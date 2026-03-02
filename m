Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF7F1E9B371
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 12:34:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx2U3-0004wa-T3; Mon, 02 Mar 2026 07:34:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vx2U1-0004uI-JI
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 07:34:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vx2Tz-00060d-JJ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 07:34:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772454882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SyI9+dmSLQJvPQgBg5tFSyHQYFn9ACNBvoOjgvPrBB4=;
 b=B24dhSswXIJ0egt3qme+as3VX9pwZvGJunWeiXxwSpNWrXvPiZYcHXRo4mGENBNHVHa6tr
 3wqoL+P86fNOIOimI/iWdpfzA2nBIsjSup29Uw0lqumr1xk9XxZIQxXjmvowOxQoPHYhPF
 9rO9EI17tYyUO045wqb6tZzUk8GzOUo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-540-M28btc-6PWuwrbet3mwl5w-1; Mon,
 02 Mar 2026 07:34:39 -0500
X-MC-Unique: M28btc-6PWuwrbet3mwl5w-1
X-Mimecast-MFC-AGG-ID: M28btc-6PWuwrbet3mwl5w_1772454878
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 81BDA1956094; Mon,  2 Mar 2026 12:34:38 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.162])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AA2BF1956053; Mon,  2 Mar 2026 12:34:36 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 07/10] tests/docker: improve handling of docker probes
Date: Mon,  2 Mar 2026 13:34:10 +0100
Message-ID: <20260302123413.274700-8-thuth@redhat.com>
In-Reply-To: <20260302123413.274700-1-thuth@redhat.com>
References: <20260302123413.274700-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.968,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.495, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Daniel P. Berrangé <berrange@redhat.com>

The docker.py script has logic to guess the container command and
detects one of

  * docker
  * sudo -n docker
  * podman

but the "docker.py probe" command then throws away the detected argv
and prints a slightly different argv based solely on the detected
argv[0]. The result is that 'probe' will print

  * docker
  * sudo docker
  * podman

which means that if sudo was detected & the result of 'probe' were
used directly, it would end up prompting for password interaction
every time.

The 'configure' script, however, runs 'probe' and then throws away
the printed argv again, reporting only 'podman' or 'docker', which
is used to set the $(RUNC) variable for tests/docker/Makefile.include
which is in turn used to pass --engine to docker.py. So the docker.py
command will re-detect the need for 'sudo -n' and use it correctly

The problem with this is that some commands in Makefile.include do
not call docker.py at all, they invoke $(RUNC) directly. Since
configure threw away the 'sudo' command prefix Makefile.in won't
be adding either 'sudo' or 'sudo -n', it'll just run plain 'docker'
which is wrong.

This commit sanitizes things so that the 'docker.py probe' prints
out the exact detected ARGV, and configure fully preserves this
ARGV when setting $(RUNC). Since "$(RUNC)" is no longer just a bare
engine name, however, we must now also set the $(CONTAINER_ENGINE)
variable for Makefile.include so it can pass something sane to
the --engine arg for docker.py

Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260210163556.713841-2-berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure                     | 19 +++++++------------
 tests/docker/Makefile.include |  5 +++--
 tests/docker/docker.py        |  7 +------
 3 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/configure b/configure
index 5e114acea28..b99ba65d718 100755
--- a/configure
+++ b/configure
@@ -1319,17 +1319,11 @@ fi
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
 
@@ -1449,7 +1443,7 @@ probe_target_compiler() {
   esac
 
   for host in $container_hosts; do
-    test "$container" != no || continue
+    test "$runc" != no || continue
     test "$host" = "$cpu" || continue
     case $target_arch in
       # debian-all-test-cross architectures
@@ -1771,8 +1765,9 @@ echo all: >> $config_host_mak
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
index 38467cca610..7d4582b6a8d 100644
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
index 3b8a26704df..ff68c7bf6f2 100755
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
2.53.0


