Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA83A10F2862
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 18:26:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6Bsq-0001hL-Hx; Fri, 27 Mar 2026 14:26:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6BsV-0001g0-I2
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 14:25:54 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w6BsT-00068U-2Z
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 14:25:51 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2b0ba3bfe16so20919045ad.1
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 11:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774635947; x=1775240747; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ACXZcnQ52zjYTW/ftpwQA5MmC2zbnyVVr8sE0KsfMA8=;
 b=xXMw5B+XzpTz79S7BMqxHrtkNdyyLbx6Yh6bHWbMQXVvsS3+YchqlaKwCiiZJQCH5A
 bldPM5v56WDTtHDDUwOg+UiQycqKAgsII1/j21zV9qhU4OI6i8XjAbSwkMQEJv23L/7d
 Hihllrw/8dwX5via3jxbTQ0lFZl4HLZ0Q73KruyKp2XUjB3pkZf2Nt2ClEYiGwvH4imz
 ZvKdaegEtU2FYrqylkMGOehNgwFqIGLlqi+JTgEqzk1klS5hwaR9NfnJ7OMKiXNxPsja
 KHN8IR95bHztaqHI5QhA/s+IEkov6OH7zQJipQWG/X0bbyzW6AS842Z/xeLJA51LXkKu
 OMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774635947; x=1775240747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ACXZcnQ52zjYTW/ftpwQA5MmC2zbnyVVr8sE0KsfMA8=;
 b=TZoGveu1n28+QsPNnYP6Oq6HxZNpoREnSLn4gdb6kIixZJaLCBVLBw230Fo+v9dthq
 ZzGZDr5cJGkdJimhTo7iOc/UiJ3OrD5grCra32ZE7k5uo6nlz/sH0XyJhmN7NsMtpu2K
 7qMLA7KAAjFTe/HGajAbh+ONUpfjT6uhcw9LZ4GOzNNafHxXacjOhrWAKrc6jp2l5kdr
 UKMqPUW75ouUUaGTNiN1StYBXltCEKRuyi74XlirSbpa9U2EOyKzBbMn+QmyyLsGTHIi
 kY7vS05R/TshtoPExX+aYvLCyF36ekhi1AcRi1l9Gdgjl7ZPMwFvyOW0oW3PSWMyTHbu
 D2WA==
X-Gm-Message-State: AOJu0YySI37dtkV76Gh2IvpoHnOSP97Vy0SLxz3CSShptXhO3p2uDiiT
 UVNWDszmUcmucRSgeTiTIPFguDeVxu/HjSka96ZvRWKIgg8XUEPaMKxR9D79vklM/V7a7y9r6ZK
 v115gfzA=
X-Gm-Gg: ATEYQzzSRfZEyCjBB8DEiw2VeObXxcCB5mXm05Zgd85C71l7r2EsX1dy08kP3HR/nF5
 YfRhW9VE13uZYu+xZ/bBtsBRSfc+gLaEKXNnMLRQD+OwM7C7jkn45+jCUfg90R362EXp0U+k5EQ
 WsJhviTbspbJvJSC97WfGU8kmA3RKhdD/hXGIWLACdLIHBlRi1vZoZqeLjM+5P2oOVSaZRK/Azb
 HLPgWbLiScJYJkTJm5Q9p8MHsoOTLV4PLp78A0k0OGMfmqxLwl0yA7PJpV26KGv+xmHbe8am5AW
 ivyXJ906cNhLsh49kBDeVEBPZafpRJOgoG1e3i9Fk9yCKvs9/fExQY+mSTYjn4Di6RLzReJ9vmz
 sNPITFJwwsSOghUJZKjcJIGACSNGg+jd6PAFWwLH4W+FAup24+R6eZcTCBz3FXAktXhuFYMmcCW
 VDI3wbSN3tMsGTRYBEeZP4xUbG5MWsrzuB2rTpbKlHqmnX4APrJU/FBKHlR4D8otLBkE0l5Mha5
 iqZ
X-Received: by 2002:a17:902:dac7:b0:2ae:be67:722f with SMTP id
 d9443c01a7336-2b0ce5c4c51mr34470145ad.22.1774635946768; 
 Fri, 27 Mar 2026 11:25:46 -0700 (PDT)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc7a9deesm64463315ad.28.2026.03.27.11.25.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 11:25:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@linaro.org
Subject: [PULL 1/1] docs and tests: assets moved after GitHub account renaming
Date: Fri, 27 Mar 2026 11:25:41 -0700
Message-ID: <20260327182541.691078-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327182541.691078-1-pierrick.bouvier@linaro.org>
References: <20260327182541.691078-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

GitHub setup a permanent redirection for all repositories when accounts,
so the old links will keep on working also.

However, GitHub allow this username to be reused again. To ensure no one
can inject malicious content, I took ownership of the (newly free)
pbo-linaro account [1], so no one else can claim it.

[1] https://github.com/pbo-linaro

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260326214436.256215-1-pierrick.bouvier@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/about/emulation.rst                      | 28 +++++++++----------
 .../aarch64/test_device_passthrough.py        |  4 +--
 tests/functional/aarch64/test_rme_sbsaref.py  |  4 +--
 tests/functional/aarch64/test_rme_virt.py     |  4 +--
 4 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/docs/about/emulation.rst b/docs/about/emulation.rst
index 469f31bab6a..3b4c365933d 100644
--- a/docs/about/emulation.rst
+++ b/docs/about/emulation.rst
@@ -898,24 +898,24 @@ As an example, we can trace qemu itself running git::
     $ uftrace dump --chrome | gzip > ~/qemu_aarch64_git_help.json.gz
 
 For convenience, you can download this trace `qemu_aarch64_git_help.json.gz
-<https://github.com/pbo-linaro/qemu-assets/raw/refs/heads/master/qemu-uftrace/qemu_aarch64_git_help.json.gz>`_.
+<https://github.com/p-b-o/qemu-assets/raw/refs/heads/master/qemu-uftrace/qemu_aarch64_git_help.json.gz>`_.
 Download it and open this trace on https://ui.perfetto.dev/. You can zoom in/out
 using :kbd:`W`, :kbd:`A`, :kbd:`S`, :kbd:`D` keys.
 Some sequences taken from this trace:
 
 - Loading program and its interpreter
 
-.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/loader_exec.png?raw=true
+.. image:: https://github.com/p-b-o/qemu-assets/blob/master/qemu-uftrace/loader_exec.png?raw=true
    :height: 200px
 
 - open syscall
 
-.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/open_syscall.png?raw=true
+.. image:: https://github.com/p-b-o/qemu-assets/blob/master/qemu-uftrace/open_syscall.png?raw=true
    :height: 200px
 
 - TB creation
 
-.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/tb_translation.png?raw=true
+.. image:: https://github.com/p-b-o/qemu-assets/blob/master/qemu-uftrace/tb_translation.png?raw=true
    :height: 200px
 
 It's usually better to use ``uftrace record`` directly. However, tracing
@@ -928,7 +928,7 @@ Example system trace
 
 A full trace example (chrome trace, from instructions below) generated from a
 system boot can be found `here
-<https://github.com/pbo-linaro/qemu-assets/raw/refs/heads/master/qemu-uftrace/aarch64_boot.json.gz>`_.
+<https://github.com/p-b-o/qemu-assets/raw/refs/heads/master/qemu-uftrace/aarch64_boot.json.gz>`_.
 Download it and open this trace on https://ui.perfetto.dev/. You can see code
 executed for all privilege levels, and zoom in/out using
 :kbd:`W`, :kbd:`A`, :kbd:`S`, :kbd:`D` keys. You can find below some sequences
@@ -936,27 +936,27 @@ taken from this trace:
 
 - Two first stages of boot sequence in Arm Trusted Firmware (EL3 and S-EL1)
 
-.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/bl3_to_bl1.png?raw=true
+.. image:: https://github.com/p-b-o/qemu-assets/blob/master/qemu-uftrace/bl3_to_bl1.png?raw=true
    :height: 200px
 
 - U-boot initialization (until code relocation, after which we can't track it)
 
-.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/uboot.png?raw=true
+.. image:: https://github.com/p-b-o/qemu-assets/blob/master/qemu-uftrace/uboot.png?raw=true
    :height: 200px
 
 - Stat and open syscalls in kernel
 
-.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/stat.png?raw=true
+.. image:: https://github.com/p-b-o/qemu-assets/blob/master/qemu-uftrace/stat.png?raw=true
    :height: 200px
 
 - Timer interrupt
 
-.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/timer_interrupt.png?raw=true
+.. image:: https://github.com/p-b-o/qemu-assets/blob/master/qemu-uftrace/timer_interrupt.png?raw=true
    :height: 200px
 
 - Poweroff sequence (from kernel back to firmware, NS-EL2 to EL3)
 
-.. image:: https://github.com/pbo-linaro/qemu-assets/blob/master/qemu-uftrace/poweroff.png?raw=true
+.. image:: https://github.com/p-b-o/qemu-assets/blob/master/qemu-uftrace/poweroff.png?raw=true
    :height: 200px
 
 Build and run system example
@@ -966,7 +966,7 @@ Build and run system example
 
 Building a full system image with frame pointers is not trivial.
 
-We provide a `simple way <https://github.com/pbo-linaro/qemu-linux-stack>`_ to
+We provide a `simple way <https://github.com/p-b-o/qemu-linux-stack>`_ to
 build an aarch64 system, combining Arm Trusted firmware, U-boot, Linux kernel
 and debian userland. It's based on containers (``podman`` only) and
 ``qemu-user-static (binfmt)`` to make sure it's easily reproducible and does not depend
@@ -974,18 +974,18 @@ on machine where you build it.
 
 You can follow the exact same instructions for a x64 system, combining edk2,
 Linux, and Ubuntu, simply by switching to
-`x86_64 <https://github.com/pbo-linaro/qemu-linux-stack/tree/x86_64>`_ branch.
+`x86_64 <https://github.com/p-b-o/qemu-linux-stack/tree/x86_64>`_ branch.
 
 You can follow the exact same instructions for a riscv64 system, combining
 opensbi, Linux, and Ubuntu, simply by switching to
-`riscv64 <https://github.com/pbo-linaro/qemu-linux-stack/tree/riscv64>`_ branch.
+`riscv64 <https://github.com/p-b-o/qemu-linux-stack/tree/riscv64>`_ branch.
 
 To build and run the system::
 
     # Install dependencies
     $ sudo apt install -y podman qemu-user-static
 
-    $ git clone https://github.com/pbo-linaro/qemu-linux-stack
+    $ git clone https://github.com/p-b-o/qemu-linux-stack
     $ cd qemu-linux-stack
     $ ./build.sh
 
diff --git a/tests/functional/aarch64/test_device_passthrough.py b/tests/functional/aarch64/test_device_passthrough.py
index 10c73728f36..3ef4e7ddc1d 100755
--- a/tests/functional/aarch64/test_device_passthrough.py
+++ b/tests/functional/aarch64/test_device_passthrough.py
@@ -78,14 +78,14 @@
 
 class Aarch64DevicePassthrough(QemuSystemTest):
 
-    # https://github.com/pbo-linaro/qemu-linux-stack/tree/device_passthrough
+    # https://github.com/p-b-o/qemu-linux-stack/tree/device_passthrough
     # $ ./build.sh && ./archive_artifacts.sh out.tar.xz
     #
     # Linux kernel is compiled with defconfig +
     # IOMMUFD + VFIO_DEVICE_CDEV + ARM_SMMU_V3_IOMMUFD
     # https://docs.kernel.org/driver-api/vfio.html#vfio-device-cde
     ASSET_DEVICE_PASSTHROUGH_STACK = Asset(
-        ('https://github.com/pbo-linaro/qemu-linux-stack/'
+        ('https://github.com/p-b-o/qemu-linux-stack/'
          'releases/download/build/device_passthrough-a9612a2.tar.xz'),
         'f7d2f70912e7231986e6e293e1a2c4786dd02bec113a7acb6bfc619e96155455')
 
diff --git a/tests/functional/aarch64/test_rme_sbsaref.py b/tests/functional/aarch64/test_rme_sbsaref.py
index 4845c824960..efea80c5782 100755
--- a/tests/functional/aarch64/test_rme_sbsaref.py
+++ b/tests/functional/aarch64/test_rme_sbsaref.py
@@ -20,10 +20,10 @@ class Aarch64RMESbsaRefMachine(QemuSystemTest):
 
     # Stack is inspired from:
     # https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/
-    # https://github.com/pbo-linaro/qemu-linux-stack/tree/rme_sbsa_release
+    # https://github.com/p-b-o/qemu-linux-stack/tree/rme_sbsa_release
     # ./build.sh && ./archive_artifacts.sh out.tar.xz
     ASSET_RME_STACK_SBSA = Asset(
-        ('https://github.com/pbo-linaro/qemu-linux-stack/'
+        ('https://github.com/p-b-o/qemu-linux-stack/'
          'releases/download/build/rme_sbsa_release-6a2dfc5.tar.xz'),
          '5adba482aa069912292a8da746c6b21268224d9d81c97fe7c0bed690579ebdcb')
 
diff --git a/tests/functional/aarch64/test_rme_virt.py b/tests/functional/aarch64/test_rme_virt.py
index 5e23773f93d..dcb18678bfd 100755
--- a/tests/functional/aarch64/test_rme_virt.py
+++ b/tests/functional/aarch64/test_rme_virt.py
@@ -19,10 +19,10 @@ class Aarch64RMEVirtMachine(QemuSystemTest):
 
     # Stack is inspired from:
     # https://linaro.atlassian.net/wiki/spaces/QEMU/pages/29051027459/
-    # https://github.com/pbo-linaro/qemu-linux-stack/tree/rme_release
+    # https://github.com/p-b-o/qemu-linux-stack/tree/rme_release
     # ./build.sh && ./archive_artifacts.sh out.tar.xz
     ASSET_RME_STACK_VIRT = Asset(
-        ('https://github.com/pbo-linaro/qemu-linux-stack/'
+        ('https://github.com/p-b-o/qemu-linux-stack/'
          'releases/download/build/rme_release-56bc99e.tar.xz'),
          '0e3dc6b8a4b828dbae09c951a40dcb710eded084b32432b50c69cf4173ffa4be')
 
-- 
2.47.3


