Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D03CFD624
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 13:03:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdTBC-00050P-MZ; Wed, 07 Jan 2026 08:02:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdTAk-0004vg-8u
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:02:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdTAi-0007Bs-LL
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 08:01:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767790915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=31aPuuD3PU7TZIw48kRji4jd9O4iQc8f9NEiWcxMzF0=;
 b=YnIGdC64BsiMIDaksxxv83yoga1+EIm3H+g9nhPooj4l2n9whKPvk2P+sEddsWL3LX6u8v
 CZkxFO7p5FpmcSATb+UYlYDvqcpovpRYLTZ3/nPXHRL1BnJmH1DSOUaAxT8hmCi/9XRJBD
 Ci5+xCK0BIX85hHb+mee3LkNuKDXQ84=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-458-gw8mIWIGPKGrwjbYXUdmAQ-1; Wed,
 07 Jan 2026 08:01:51 -0500
X-MC-Unique: gw8mIWIGPKGrwjbYXUdmAQ-1
X-Mimecast-MFC-AGG-ID: gw8mIWIGPKGrwjbYXUdmAQ_1767790910
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 64D1F19560B6; Wed,  7 Jan 2026 13:01:50 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.169])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AD80419560A2; Wed,  7 Jan 2026 13:01:48 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/4] tests/docker: improve handling of docker probes
Date: Wed,  7 Jan 2026 13:01:42 +0000
Message-ID: <20260107130145.1495219-2-berrange@redhat.com>
In-Reply-To: <20260107130145.1495219-1-berrange@redhat.com>
References: <20260107130145.1495219-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The docker.py script has logic to guess the container command and
detects one of

  * docker
  * sudo -n docker
  * podman

but the "docker.py probe" command then throws away the detected argv
and prints a slightly different argv based soley on the detected
argv[0]. The result is that 'probe' will print

  * docker
  * sudo docker
  * podman

which means that if sudo was detected & the result of 'probe' were
used direclty, it would end up prompting for password interaction
every time.

The 'configure' script, however, runs 'probe' and then throws away
the printed argv again, reporting only 'podman' or 'docker', which
is used to set the $(RUNC) variable for tests/docker/Makefile.include
which is in turn used to pass --engine to docker.py. So the docker.py
command will re-detect the need for 'sudo -n' and use it correctly

The problem with this is that some commands in Makefile.include do
not call docker.py at all, they invoke $(RUNC) directly. Since
configure threw away the 'sudo' command prefix Makefile.in won't
be adding either 'sudo' or 'sudo -n', it'll just run plani 'docker'
which is wrong.

This commit sanitizes things so that the 'docker.py probe' prints
out the exact detected ARGV, and configure fully preserves this
ARGV when setting $(RUNC). Since "$(RUNC)" is no longer just a bare
engine name, however, we must now also set the $(CONTAINER_ENGINE)
variable for Makefile.include so it can pass something sane to
the --engine arg for docker.py

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 configure                     | 19 +++++++------------
 tests/docker/Makefile.include |  5 +++--
 tests/docker/docker.py        |  7 +------
 3 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/configure b/configure
index 55e0bd3425..1adbb357df 100755
--- a/configure
+++ b/configure
@@ -1316,17 +1316,11 @@ fi
 ##########################################
 # functions to probe cross compilers
 
-container="no"
-runc=""
+runc="no"
 if test $use_containers = "yes" && (has "docker" || has "podman"); then
-    case $($python "$source_path"/tests/docker/docker.py --engine "$container_engine" probe) in
-        *docker) container=docker ;;
-        podman) container=podman ;;
-        no) container=no ;;
-    esac
-    if test "$container" != "no"; then
-        docker_py="$python $source_path/tests/docker/docker.py --engine $container"
-        runc=$container
+    runc=$($python "$source_path"/tests/docker/docker.py --engine "$container_engine" probe)
+    if test "$runc" != "no"; then
+        docker_py="$python $source_path/tests/docker/docker.py --engine $container_engine"
     fi
 fi
 
@@ -1446,7 +1440,7 @@ probe_target_compiler() {
   esac
 
   for host in $container_hosts; do
-    test "$container" != no || continue
+    test "$runc" != no || continue
     test "$host" = "$cpu" || continue
     case $target_arch in
       # debian-all-test-cross architectures
@@ -1775,8 +1769,9 @@ echo all: >> $config_host_mak
 echo "SRC_PATH=$source_path" >> $config_host_mak
 echo "TARGET_DIRS=$target_list" >> $config_host_mak
 echo "GDB=$gdb_bin" >> $config_host_mak
-if test "$container" != no; then
+if test "$runc" != no; then
     echo "RUNC=$runc" >> $config_host_mak
+    echo "CONTAINER_ENGINE=$container_engine" >> $config_host_mak
 fi
 echo "SUBDIRS=$subdirs" >> $config_host_mak
 if test "$rust" != disabled; then
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 38467cca61..7d4582b6a8 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -16,8 +16,9 @@ DOCKER_DEFAULT_REGISTRY := registry.gitlab.com/qemu-project/qemu
 endif
 DOCKER_REGISTRY := $(if $(REGISTRY),$(REGISTRY),$(DOCKER_DEFAULT_REGISTRY))
 
-RUNC ?= $(if $(shell command -v docker), docker, podman)
-DOCKER_SCRIPT=$(SRC_PATH)/tests/docker/docker.py --engine $(RUNC)
+CONTAINER_ENGINE = auto
+DOCKER_SCRIPT=$(SRC_PATH)/tests/docker/docker.py --engine $(CONTAINER_ENGINE)
+RUNC ?= $(shell $(DOCKER_SCRIPT) probe)
 
 CUR_TIME := $(shell date +%Y-%m-%d-%H.%M.%S.$$$$)
 DOCKER_SRC_COPY := $(BUILD_DIR)/docker-src.$(CUR_TIME)
diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 3b8a26704d..ff68c7bf6f 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -618,12 +618,7 @@ class ProbeCommand(SubCommand):
     def run(self, args, argv):
         try:
             docker = Docker()
-            if docker._command[0] == "docker":
-                print("docker")
-            elif docker._command[0] == "sudo":
-                print("sudo docker")
-            elif docker._command[0] == "podman":
-                print("podman")
+            print(" ".join(docker._command))
         except Exception:
             print("no")
 
-- 
2.52.0


