Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A89D3C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 11:41:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjbVe-0004WS-L9; Tue, 14 Jul 2026 07:41:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjbVd-0004W4-Av
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 07:41:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wjbVa-0004Hm-64
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 07:41:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784029265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=EDlwee1ANFv2hdgy4LqFTTyVP6ZUwnGVBTw+WR1zH+8=;
 b=OzusK1sJroOpKz04HCaBvezD5LpzNMhNxSJKAmQt6y8OpQOLccypZDaWZYtvkEVvdLj9Ng
 vrnzPyQrQKyH1zN6j/7MgcDaEYLfkg80MzY+BkAQh8XvX0GdK/InLPikrUC8JmynpL5PTF
 RBeLQ6+I+zCl/8R7DqQimm0Pvg5B1H8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-i1zy6GYZNneNlm1A26uhGQ-1; Tue,
 14 Jul 2026 07:41:03 -0400
X-MC-Unique: i1zy6GYZNneNlm1A26uhGQ-1
X-Mimecast-MFC-AGG-ID: i1zy6GYZNneNlm1A26uhGQ_1784029262
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 44F741800595; Tue, 14 Jul 2026 11:41:02 +0000 (UTC)
Received: from berrange.com (unknown [10.44.33.163])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2BE271800348; Tue, 14 Jul 2026 11:40:59 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] tests/docker: ensure container command is probed at most once
Date: Tue, 14 Jul 2026 12:40:57 +0100
Message-ID: <20260714114057.653982-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

The '--engine' arg accepts either 'podman' or 'docker', which is
not sufficiently granular to map directly to a command. This
means that  docker.py still has to then probe the exact command
to use.

Meanwhile the 'probe' command prints out the full command to use
but this cannot be passed back to docker.py to avoid probing
again, so the caching is only useful in the few case where we
run a container directly bypassing docker.py.

Address this by replacing --engine with --command for docker.py.

This in turn requires the --container-engine configure arg to be
replaced with --container-command.

With these changes the container command is probed at most once
during configure and never again, while running in an unconfigured
tree will still probe on demand.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 configure                     | 24 ++++++-------
 tests/docker/Makefile.include | 13 ++++---
 tests/docker/docker.py        | 67 ++++++++++++-----------------------
 3 files changed, 39 insertions(+), 65 deletions(-)

diff --git a/configure b/configure
index d8bc10060e..6602fc3004 100755
--- a/configure
+++ b/configure
@@ -172,7 +172,7 @@ fi
 # some defaults, based on the host environment
 
 # default parameters
-container_engine="auto"
+container_command=""
 cpu=""
 cross_compile="no"
 cross_prefix=""
@@ -734,7 +734,7 @@ for opt do
   ;;
   --disable-containers) use_containers="no"
   ;;
-  --container-engine=*) container_engine="$optarg"
+  --container-command=*) container_command="$optarg"
   ;;
   --rust-target-triple=*) rust_target_triple="$optarg"
   ;;
@@ -869,7 +869,7 @@ Advanced options (experts only):
   --enable-debug           enable common debug build options
   --cpu=CPU                Build for host CPU [$cpu]
   --disable-containers     don't use containers for cross-building
-  --container-engine=TYPE  which container engine to use [$container_engine]
+  --container-command=CMD  which container command to use [autodetect]
   --gdb=GDB-path           gdb to use for gdbstub tests [$gdb_bin]
   --wasm64-32bit-address-limit Restrict wasm64 address space to 32-bit (default
                                is to use the whole 64-bit range).
@@ -1291,12 +1291,11 @@ fi
 ##########################################
 # functions to probe cross compilers
 
-runc="no"
-if test $use_containers = "yes" && (has "docker" || has "podman"); then
-    runc=$($python "$source_path"/tests/docker/docker.py --engine "$container_engine" probe)
-    if test "$runc" != "no"; then
-        docker_py="$python $source_path/tests/docker/docker.py --engine $container_engine"
-    fi
+if test "$container_command" = ""; then
+    container_command=$($python "$source_path"/tests/docker/docker.py probe)
+fi
+if test $use_containers = "yes" && test "$container_command" != ""; then
+    docker_py="$python $source_path/tests/docker/docker.py --command $container_command"
 fi
 
 # cross compilers defaults, can be overridden with --cross-cc-ARCH
@@ -1415,7 +1414,7 @@ probe_target_compiler() {
   esac
 
   for host in $container_hosts; do
-    test "$runc" != no || continue
+    test "$container_command" != "" || continue
     test "$host" = "$cpu" || continue
     case $target_arch in
       # debian-all-test-cross architectures
@@ -1736,9 +1735,8 @@ echo all: >> $config_host_mak
 echo "SRC_PATH=$source_path" >> $config_host_mak
 echo "TARGET_DIRS=$target_list" >> $config_host_mak
 echo "GDB=$gdb_bin" >> $config_host_mak
-if test "$runc" != no; then
-    echo "RUNC=$runc" >> $config_host_mak
-    echo "CONTAINER_ENGINE=$container_engine" >> $config_host_mak
+if test "$container_command" != ""; then
+    echo "CONTAINER_COMMAND=$container_command" >> $config_host_mak
 fi
 echo "SUBDIRS=$subdirs" >> $config_host_mak
 if test "$rust" != disabled; then
diff --git a/tests/docker/Makefile.include b/tests/docker/Makefile.include
index 4725c39807..0adddb6a5c 100644
--- a/tests/docker/Makefile.include
+++ b/tests/docker/Makefile.include
@@ -16,9 +16,8 @@ DOCKER_DEFAULT_REGISTRY := registry.gitlab.com/qemu-project/qemu
 endif
 DOCKER_REGISTRY := $(if $(REGISTRY),$(REGISTRY),$(DOCKER_DEFAULT_REGISTRY))
 
-CONTAINER_ENGINE = auto
-DOCKER_SCRIPT=$(SRC_PATH)/tests/docker/docker.py --engine $(CONTAINER_ENGINE)
-RUNC ?= $(shell $(DOCKER_SCRIPT) probe)
+CONTAINER_COMMAND ?= $(shell $(SRC_PATH)/tests/docker/docker.py probe)
+DOCKER_SCRIPT=$(SRC_PATH)/tests/docker/docker.py --command "$(CONTAINER_COMMAND)"
 
 CUR_TIME := $(shell date +%Y-%m-%d-%H.%M.%S.$$$$)
 DOCKER_SRC_COPY := $(BUILD_DIR)/docker-src.$(CUR_TIME)
@@ -41,7 +40,7 @@ docker-qemu-src: $(DOCKER_SRC_COPY)
 # General rule for building docker images.
 docker-image-%: $(DOCKER_FILES_DIR)/%.docker
 	  $(call quiet-command,			\
-		DOCKER_BUILDKIT=1 $(RUNC) build		\
+		DOCKER_BUILDKIT=1 $(CONTAINER_COMMAND) build \
 		$(if $(DOCKER_V),,--quiet)		\
 		$(if $(NOCACHE),--no-cache,		\
 			$(if $(DOCKER_REGISTRY),--cache-from $(DOCKER_REGISTRY)/qemu/$*)) \
@@ -152,7 +151,7 @@ $(foreach i,$(filter-out $(DOCKER_PARTIAL_IMAGES),$(DOCKER_IMAGES)), \
 )
 
 docker:
-	@echo 'Build QEMU and run tests inside $(RUNC) containers'
+	@echo 'Build QEMU and run tests inside $(CONTAINER_COMMAND) containers'
 	@echo
 	@echo 'Available targets:'
 	@echo
@@ -219,10 +218,10 @@ docker-run: docker-qemu-src
 			$(IMAGE) --executable $(EXECUTABLE),		\
 			"  COPYING $(EXECUTABLE) to $(IMAGE)"))
 	$(call quiet-command,						\
-		$(RUNC) run 						\
+		$(CONTAINER_COMMAND) run 				\
 			--rm						\
 			$(if $(NOUSER),,				\
-				$(if $(filter docker,$(RUNC)),		\
+				$(if $(filter docker,$(CONTAINER_COMMAND)), \
 					-u $(UID),			\
 					--userns keep-id		\
 				)					\
diff --git a/tests/docker/docker.py b/tests/docker/docker.py
index 9e18b984f4..d2f39b5645 100755
--- a/tests/docker/docker.py
+++ b/tests/docker/docker.py
@@ -35,27 +35,6 @@
 
 DEVNULL = open(os.devnull, 'wb')
 
-class EngineEnum(enum.IntEnum):
-    AUTO = 1
-    DOCKER = 2
-    PODMAN = 3
-
-    def __str__(self):
-        return self.name.lower()
-
-    def __repr__(self):
-        return str(self)
-
-    @staticmethod
-    def argparse(s):
-        try:
-            return EngineEnum[s.upper()]
-        except KeyError:
-            return s
-
-
-USE_ENGINE = EngineEnum.AUTO
-
 def _bytes_checksum(bytes):
     """Calculate a digest string unique to the text content"""
     return hashlib.sha1(bytes).hexdigest()
@@ -73,12 +52,11 @@ def _file_checksum(filename):
 
 def _guess_engine_command():
     """ Guess a working engine command or raise exception if not found"""
-    commands = []
-
-    if USE_ENGINE in [EngineEnum.AUTO, EngineEnum.PODMAN]:
-        commands += [["podman"], ["podman-remote"], ["podman", "--remote"]]
-    if USE_ENGINE in [EngineEnum.AUTO, EngineEnum.DOCKER]:
-        commands += [["docker"], ["sudo", "-n", "docker"]]
+    commands = [["podman"],
+                ["podman-remote"],
+                ["podman", "--remote"],
+                ["docker"],
+                ["sudo", "-n", "docker"]]
     for cmd in commands:
         try:
             # 'version' is not sufficient to prove a working binary
@@ -222,8 +200,11 @@ def _dockerfile_verify_flat(df):
 
 class Docker(object):
     """ Running Docker commands """
-    def __init__(self):
-        self._command = _guess_engine_command()
+    def __init__(self, commandstr=None):
+        if commandstr is None:
+            self._command = _guess_engine_command()
+        else:
+            self._command = commandstr.split(" ")
 
         if ("docker" in self._command and
             "TRAVIS" not in os.environ and
@@ -411,8 +392,8 @@ def args(self, parser):
                             help="Run container using the current user's uid")
 
     def run(self, args, argv):
-        return Docker().run(argv, args.keep, quiet=args.quiet,
-                            as_user=args.run_as_current_user)
+        return Docker(args.command).run(argv, args.keep, quiet=args.quiet,
+                                        as_user=args.run_as_current_user)
 
 
 class BuildCommand(SubCommand):
@@ -445,7 +426,7 @@ def run(self, args, argv):
         dockerfile = _read_dockerfile(args.dockerfile)
         tag = args.tag
 
-        dkr = Docker()
+        dkr = Docker(args.command)
         if "--no-cache" not in argv and \
            dkr.image_matches_dockerfile(tag, dockerfile):
             if not args.quiet:
@@ -512,7 +493,7 @@ def args(self, parser):
                             help="Docker registry")
 
     def run(self, args, argv):
-        dkr = Docker()
+        dkr = Docker(args.command)
         dkr.command(cmd="pull", quiet=args.quiet,
                     argv=["%s/%s" % (args.registry, args.tag)])
         dkr.command(cmd="tag", quiet=args.quiet,
@@ -590,7 +571,7 @@ def run(self, args, argv):
         tmp.seek(0)
 
         # Run the build with our tarball context
-        dkr = Docker()
+        dkr = Docker(args.command)
         dkr.update_image(args.tag, tmp, quiet=args.quiet)
 
         return 0
@@ -601,7 +582,7 @@ class CleanCommand(SubCommand):
     name = "clean"
 
     def run(self, args, argv):
-        Docker().clean()
+        Docker(args.command).clean()
         return 0
 
 
@@ -610,7 +591,7 @@ class ImagesCommand(SubCommand):
     name = "images"
 
     def run(self, args, argv):
-        return Docker().command("images", argv, args.quiet)
+        return Docker(args.command).command("images", argv, args.quiet)
 
 
 class ProbeCommand(SubCommand):
@@ -619,7 +600,7 @@ class ProbeCommand(SubCommand):
 
     def run(self, args, argv):
         try:
-            docker = Docker()
+            docker = Docker(args.command)
             print(" ".join(docker._command))
         except Exception:
             print("no")
@@ -651,18 +632,16 @@ def run(self, args, argv):
                 cmd += ["-v", "%s:%s:ro,z" % (p, p)]
         cmd += [args.image, args.cc]
         cmd += argv
-        return Docker().run(cmd, False, quiet=args.quiet,
-                            as_user=True)
+        return Docker(args.command).run(cmd, False, quiet=args.quiet,
+                                        as_user=True)
 
 
 def main():
-    global USE_ENGINE
-
     parser = argparse.ArgumentParser(description="A Docker helper",
                                      usage="%s <subcommand> ..." %
                                      os.path.basename(sys.argv[0]))
-    parser.add_argument("--engine", type=EngineEnum.argparse, choices=list(EngineEnum),
-                        help="specify which container engine to use")
+    parser.add_argument("--command",
+                        help="specify which container engine command to use")
     subparsers = parser.add_subparsers(title="subcommands", help=None)
     for cls in SubCommand.__subclasses__():
         cmd = cls()
@@ -671,8 +650,6 @@ def main():
         cmd.args(subp)
         subp.set_defaults(cmdobj=cmd)
     args, argv = parser.parse_known_args()
-    if args.engine:
-        USE_ENGINE = args.engine
     return args.cmdobj.run(args, argv)
 
 
-- 
2.55.0


