Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74324C88E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4x8x-0001y2-31; Fri, 11 Sep 2026 05:01:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x8q-0001qW-IB
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:01:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x8n-000844-Qz
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g9mLgS0ybrUUaTMFusFVuyMEvSQGJ2PNYaEiCYholds=;
 b=Tc+5QtfAP0yomD5Z9QaVRpEVwav0vAsYZiS6/THJZvoJ9KD3FWTt+Whp/3ldpzlMkyV69S
 e5CX54UGa2u421g8Y9lsamXfloY+a5lIlGPgZPESGEeqf5Fz0CRFr5XE8kUtAuQPW7RGF3
 w/T1x1TlqTSUNK03cNcr36DA73ffFPo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-397-WtygJFs4NxKXsfwEYB5jzg-1; Fri, 11 Sep 2026 05:01:48 -0400
X-MC-Unique: WtygJFs4NxKXsfwEYB5jzg-1
X-Mimecast-MFC-AGG-ID: WtygJFs4NxKXsfwEYB5jzg_1789117307
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-495689bfcc8so4972655e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117307; x=1789722107; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=g9mLgS0ybrUUaTMFusFVuyMEvSQGJ2PNYaEiCYholds=;
 b=G6HbA7y2RN3YOY0OW594VNb5jmugGu3S5CtUD6cgvWYer8qhq6AOj5LdlyMSHn8+8r
 LAL+w7EIc5qPMnsgYYsGLYfRy3JyP/zFbi4jFICcqyObU9KXNkCXKJlzKEOtdWqWmas6
 +3cLe3Q+46iNIrVIU5VUuoDbNsd/APoqjSwA4n0w8Z1VJOKSbtDjcZUGFU6fnhnjjAbi
 053+JxM0w03RaK06rNyaPgIjQ36yOvvH74pD9ibyNfgCBqUlct4KrR5xBksKJFgzQZHN
 SJG5p38zzYvTGYqhkuk4Xxzv899/g1Eos68od17Xo6spMLo+EcZqtEQd+nx9+x13fLCj
 u7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117307; x=1789722107;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=g9mLgS0ybrUUaTMFusFVuyMEvSQGJ2PNYaEiCYholds=;
 b=X8Te+i4hCP74V1Ue20/GZJaVaePmxQu3qt5yoBinkR8ajcvSGAWXwEgj8dxLTe3OiD
 FQaZlVmYUzwtzsbh4M3tgLCek1EGmqO19ZwLl9JmXNDe80xH305BgLKU99kHHrRpocbx
 s2zqJxOEfTWkYnBXRczynAwXrb5znB4Of+9JingUVDu7bluSxDS0MpfMwAV4yl/dw1ay
 6Y2ViG2mBG3Zq/JQmDiI7qvUuhCQkHDGZeD8V6/CQGIE6NVFDj2/HVc1VAwIqptJww7w
 fBvOxl2CcL68mavD06Dhq5juKvdke0HolVVToDUs5YeVT2Dnrg5KXm5PiFR71fzhUcuu
 eJPA==
X-Gm-Message-State: AFuF++n8/tMsjTO3RbWjBQ/B0988zOc5/0y1uX6R+v9+FtBboxx1IvYf
 60Nd2mn01aNA5GO/OwF7xExcHDHT96yg1io9HfHJpAD3qTagWFc07nNcXJwRaktrr6hNqvGAuTr
 05r+INW5B3C3SJhzNaTRDgESmKVGQ/EfC8Me3GDzjpZhOg3OqHgF/vGiX1TY1G5rotScQRroi8R
 Jm93Hvt09349WMdUgV8vTNq/bY/j6k+VyS9A==
X-Gm-Gg: AYBFou2Og0k8TUDm4xZru9KIZKsBcqRwEEkbve0xetibdaRVTWD2Om5q2ikZmvsGx1u
 mXnLSXLMljuwoxkg4yuwRBZDpVf8EpZ+O/c19rMyHEK3LBpleyg1+5kVrq5hrTkWo9qSANdTjBC
 BaxL0lGZkMbrIQetUViKzfCuAl36jZZ9dpmPLZ/M14NJnCSN4RcQw7QLQYWfHUjKr6SYpeAbCY3
 ptNt88dg8NNrf52Q5v6ijM0SZZADBziTh3b00c3cnBnkk7VZmn+jeTdp4nY38wk+wvEwNfkuxVI
 H7UKLLIUHfyPbVVd/OsvS2cHKfUnaANcmSZknE7JxY4+6YCauEY4TqWgCJWAHF82meCkGCFMBdM
 v7ZA4yjcbDJG3er5itGh+SXo=
X-Received: by 2002:a05:600c:6289:b0:49c:de80:b833 with SMTP id
 5b1f17b1804b1-49e61983067mr32623865e9.2.1789117306262; 
 Fri, 11 Sep 2026 02:01:46 -0700 (PDT)
X-Received: by 2002:a05:600c:6289:b0:49c:de80:b833 with SMTP id
 5b1f17b1804b1-49e61983067mr32623015e9.2.1789117305570; 
 Fri, 11 Sep 2026 02:01:45 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e61a32803sm43926005e9.0.2026.09.11.02.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:01:45 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:01:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Ben Chaney <bchaney@akamai.com>, Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Sergio Lopez <slp@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, Conor Dooley <conor@kernel.org>,
 Sebastian Huber <sebastian.huber@embedded-brains.de>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Jason Wang <jasowangio@gmail.com>, Eric Blake <eblake@redhat.com>,
 devel@lists.libvirt.org, xen-devel@lists.xenproject.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org
Subject: [PULL v2 11/75] net/tap: deprecate "no" as special value for
 script/downscript
Message-ID: <3e4c54739a7e3409a477197fa300104202eb3570.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

The interface is ambiguous, as "no" is valid file name. So,
using "no" as a special value to disable script is deprecated.
Use an empty string ("script=" / "downscript=") instead.

In a future version, "no" will be treated as a plain file name, just
like any other non-empty value.

Document the deprecation in docs/about/deprecated.rst, qapi/net.json,
and qemu-options.hx. Update other docs to use empty string instead of
"no". Add a warning.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Ben Chaney <bchaney@akamai.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260819180201.1970193-4-vsementsov@yandex-team.ru>
---
 docs/about/deprecated.rst                  | 18 ++++++++++++++++++
 docs/system/i386/microvm.rst               |  4 ++--
 docs/system/i386/xenpvh.rst                |  2 +-
 docs/system/ppc/ppce500.rst                |  4 ++--
 docs/system/riscv/microchip-icicle-kit.rst |  2 +-
 docs/system/riscv/sifive_u.rst             |  2 +-
 qapi/net.json                              | 14 ++++++++++----
 net/tap.c                                  | 17 +++++++++++------
 qemu-options.hx                            |  8 ++++++--
 9 files changed, 52 insertions(+), 19 deletions(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 98c32991c9..61e775373d 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -71,6 +71,15 @@ flexible enough. The monitor objects have been converted to QOM, so
 ``-mon mode=control`` is replaced by ``-object monitor-qmp``. The
 short convenience options are not deprecated, only ``-mon``.
 
+``script=no`` and ``downscript=no`` for ``-netdev tap`` (since 11.2)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The special value ``"no"`` for the ``script`` and ``downscript``
+parameters of ``-netdev tap`` disables script execution.  This special
+treatment of ``"no"`` is deprecated.  Use an empty string (``script=``
+or ``downscript=``) to disable script execution instead.  In a future
+version, ``"no"`` will be treated as a plain file name.
+
 QEMU Machine Protocol (QMP) commands
 ------------------------------------
 
@@ -164,6 +173,15 @@ Use ``job-finalize`` instead.
 
 Use ``query-accelerators`` instead.
 
+``"no"`` as value of ``script``/``downscript`` for tap in ``netdev_add`` (since 11.2)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+The special value ``"no"`` for the ``script`` and ``downscript``
+parameters of ``netdev_add`` with ``type=tap`` disables script
+execution.  This special treatment of ``"no"`` is deprecated.  Use an
+empty string instead.  In a future version, ``"no"`` will be treated as
+a plain file name.
+
 Human Machine Protocol (HMP) commands
 -------------------------------------
 
diff --git a/docs/system/i386/microvm.rst b/docs/system/i386/microvm.rst
index 1675e37d3e..077ea15751 100644
--- a/docs/system/i386/microvm.rst
+++ b/docs/system/i386/microvm.rst
@@ -79,7 +79,7 @@ legacy ``ISA serial`` device as console::
      -serial stdio \
      -drive id=test,file=test.img,format=raw,if=none \
      -device virtio-blk-device,drive=test \
-     -netdev tap,id=tap0,script=no,downscript=no \
+     -netdev tap,id=tap0,script=,downscript= \
      -device virtio-net-device,netdev=tap0
 
 While the example above works, you might be interested in reducing the
@@ -103,7 +103,7 @@ disabled::
      -device virtconsole,chardev=virtiocon0 \
      -drive id=test,file=test.img,format=raw,if=none \
      -device virtio-blk-device,drive=test \
-     -netdev tap,id=tap0,script=no,downscript=no \
+     -netdev tap,id=tap0,script=,downscript= \
      -device virtio-net-device,netdev=tap0
 
 
diff --git a/docs/system/i386/xenpvh.rst b/docs/system/i386/xenpvh.rst
index 904778e3f5..862f38830b 100644
--- a/docs/system/i386/xenpvh.rst
+++ b/docs/system/i386/xenpvh.rst
@@ -42,7 +42,7 @@ case you need to construct one manually:
       -vnc none                                       \
       -display none                                   \
       -device virtio-net-pci,id=nic0,netdev=net0,mac=00:16:3e:5c:81:78 \
-      -netdev type=tap,id=net0,ifname=vif3.0-emu,br=xenbr0,script=no,downscript=no \
+      -netdev type=tap,id=net0,ifname=vif3.0-emu,br=xenbr0,script=,downscript= \
       -smp 4,maxcpus=4                                \
       -nographic                                      \
       -machine xenpvh,ram-low-base=0,ram-low-size=2147483648,ram-high-base=4294967296,ram-high-size=2147483648,pci-ecam-base=824633720832,pci-ecam-size=268435456,pci-mmio-base=4026531840,pci-mmio-size=33554432,pci-mmio-high-base=824902156288,pci-mmio-high-size=68719476736 \
diff --git a/docs/system/ppc/ppce500.rst b/docs/system/ppc/ppce500.rst
index c9fe0915dc..ec5aaf14fd 100644
--- a/docs/system/ppc/ppce500.rst
+++ b/docs/system/ppc/ppce500.rst
@@ -158,14 +158,14 @@ interface at PCI address 0.1.0, but we can switch that to an e1000 NIC by:
   $ qemu-system-ppc64 -M ppce500 -smp 4 -m 2G \
                       -display none -serial stdio \
                       -bios u-boot \
-                      -nic tap,ifname=tap0,script=no,downscript=no,model=e1000
+                      -nic tap,ifname=tap0,script=,downscript=,model=e1000
 
 The QEMU ``ppce500`` machine can also dynamically instantiate an eTSEC device
 if “-device eTSEC” is given to QEMU:
 
 .. code-block:: bash
 
-  -netdev tap,ifname=tap0,script=no,downscript=no,id=net0 -device eTSEC,netdev=net0
+  -netdev tap,ifname=tap0,script=,downscript=,id=net0 -device eTSEC,netdev=net0
 
 Root file system on flash drive
 -------------------------------
diff --git a/docs/system/riscv/microchip-icicle-kit.rst b/docs/system/riscv/microchip-icicle-kit.rst
index 9809e94b84..7fdb96601a 100644
--- a/docs/system/riscv/microchip-icicle-kit.rst
+++ b/docs/system/riscv/microchip-icicle-kit.rst
@@ -84,7 +84,7 @@ Then we can boot the machine by:
   $ qemu-system-riscv64 -M microchip-icicle-kit -smp 5 -m 2G \
       -sd path/to/sdcard.img \
       -nic user,model=cadence_gem \
-      -nic tap,ifname=tap,model=cadence_gem,script=no \
+      -nic tap,ifname=tap,model=cadence_gem,script= \
       -display none -serial stdio \
       -kernel path/to/u-boot/build/dir/u-boot.bin \
       -dtb path/to/u-boot/build/dir/u-boot.dtb
diff --git a/docs/system/riscv/sifive_u.rst b/docs/system/riscv/sifive_u.rst
index 8f55ae8e31..0e4dcf3e70 100644
--- a/docs/system/riscv/sifive_u.rst
+++ b/docs/system/riscv/sifive_u.rst
@@ -199,7 +199,7 @@ To boot the VxWorks kernel in QEMU with the ``sifive_u`` machine, use:
 
   $ qemu-system-riscv64 -M sifive_u -smp 5 -m 2G \
       -display none -serial stdio \
-      -nic tap,ifname=tap0,script=no,downscript=no \
+      -nic tap,ifname=tap0,script=,downscript= \
       -kernel /path/to/vxWorks \
       -append "gem(0,0)host:vxWorks h=192.168.200.1 e=192.168.200.2:ffffff00 u=target pw=vxTarget f=0x01"
 
diff --git a/qapi/net.json b/qapi/net.json
index ab8ed9c086..dccf95bbbc 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -399,15 +399,21 @@
 # @fds: multiple file descriptors of already opened multiqueue capable
 #     tap
 #
-# @script: script to initialize the interface.  An empty string or
-#     "no" disables script execution.  Defaults to
+# @script: script to initialize the interface.  An empty string
+#     disables script execution.  Defaults to
 #     ``<sysconfdir>/qemu-ifup``, where ``<sysconfdir>`` is the
 #     system configuration directory at build time (typically /etc).
+#     Using "no" to disable script execution is deprecated (since
+#     11.2); use an empty string instead.  In a future version, "no"
+#     will be treated as a plain file name.
 #
-# @downscript: script to shut down the interface.  An empty string or
-#     "no" disables script execution.  Defaults to
+# @downscript: script to shut down the interface.  An empty string
+#     disables script execution.  Defaults to
 #     ``<sysconfdir>/qemu-ifdown``, where ``<sysconfdir>`` is the
 #     system configuration directory at build time (typically /etc).
+#     Using "no" to disable script execution is deprecated (since
+#     11.2); use an empty string instead.  In a future version, "no"
+#     will be treated as a plain file name.
 #
 # @br: bridge name (since 2.8)
 #
diff --git a/net/tap.c b/net/tap.c
index 2076f5b780..f4051e8d4b 100644
--- a/net/tap.c
+++ b/net/tap.c
@@ -92,7 +92,8 @@ static void launch_script(const char *setup_script, const char *ifname,
 static void tap_send(void *opaque);
 static void tap_writable(void *opaque);
 
-static bool tap_is_explicit_no_script(const char *script_arg_value)
+static bool tap_is_explicit_no_script(const char *script_arg_name,
+                                      const char *script_arg_value)
 {
     if (!script_arg_value) {
         return false;
@@ -103,16 +104,19 @@ static bool tap_is_explicit_no_script(const char *script_arg_value)
     }
 
     if (strcmp(script_arg_value, "no") == 0) {
+        warn_report("'%s=no' is deprecated; use '%s=' instead",
+                    script_arg_name, script_arg_name);
         return true;
     }
 
     return false;
 }
 
-static char *tap_parse_script(const char *script_arg_value,
+static char *tap_parse_script(const char *script_arg_name,
+                              const char *script_arg_value,
                               const char *default_path)
 {
-    if (tap_is_explicit_no_script(script_arg_value)) {
+    if (tap_is_explicit_no_script(script_arg_name, script_arg_value)) {
         return NULL;
     }
 
@@ -741,7 +745,7 @@ static bool net_init_tap_one(const NetdevTapOptions *tap, NetClientState *peer,
         qemu_set_info_str(&s->nc, "helper=%s", tap->helper);
     } else {
         qemu_set_info_str(&s->nc, "ifname=%s,script=%s,downscript=%s", ifname,
-                          script ?: "no", downscript ?: "no");
+                          script ?: "", downscript ?: "");
 
         if (downscript) {
             snprintf(s->down_script, sizeof(s->down_script), "%s", downscript);
@@ -947,9 +951,10 @@ int net_init_tap(const Netdev *netdev, const char *name,
         }
     } else {
         g_autofree char *script =
-            tap_parse_script(tap->script, DEFAULT_NETWORK_SCRIPT);
+            tap_parse_script("script", tap->script, DEFAULT_NETWORK_SCRIPT);
         g_autofree char *downscript =
-            tap_parse_script(tap->downscript, DEFAULT_NETWORK_DOWN_SCRIPT);
+            tap_parse_script("downscript", tap->downscript,
+                             DEFAULT_NETWORK_DOWN_SCRIPT);
 
         if (tap->ifname) {
             pstrcpy(ifname, sizeof ifname, tap->ifname);
diff --git a/qemu-options.hx b/qemu-options.hx
index 16ef7d5455..2f6863180b 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3022,7 +3022,8 @@ DEF("netdev", HAS_ARG, QEMU_OPTION_netdev,
     "                use network scripts 'file' (default=" DEFAULT_NETWORK_SCRIPT ")\n"
     "                to configure it and 'dfile' (default=" DEFAULT_NETWORK_DOWN_SCRIPT ")\n"
     "                to deconfigure it\n"
-    "                use '[down]script=no' or '[down]script=' to disable script execution\n"
+    "                use '[down]script=' to disable script execution\n"
+    "                ('[down]script=no' is deprecated and will be treated as a file name in future)\n"
     "                use network helper 'helper' (default=" DEFAULT_BRIDGE_HELPER ") to\n"
     "                configure it\n"
     "                use 'fd=h' to connect to an already opened TAP interface\n"
@@ -3561,7 +3562,10 @@ SRST
     ``<sysconfdir>/qemu-ifup`` and the default network deconfigure script is
     ``<sysconfdir>/qemu-ifdown``, where ``<sysconfdir>`` is the system
     configuration directory at build time (typically ``/etc``).
-    Use ``[down]script=no`` or ``[down]script=`` to disable script execution.
+    Use ``[down]script=`` to disable script execution.
+    Using ``[down]script=no`` is deprecated; it disables script
+    execution now, but in a future version it will be treated as a
+    plain file name.
 
     If running QEMU as an unprivileged user, use the network helper
     to configure the TAP interface and attach it to the bridge.
-- 
MST


