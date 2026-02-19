Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF389E9A048
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 14:53:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt5MN-00044H-3U; Thu, 19 Feb 2026 09:50:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt5MD-0003vO-Bi
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:50:22 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vt5M6-00087S-Uu
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 09:50:19 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-43622089851so1022898f8f.3
 for <qemu-devel@nongnu.org>; Thu, 19 Feb 2026 06:50:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771512600; x=1772117400; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FCi0alFE7PJKdffvGQNHsCppNHZRJnPMHnqdrnJ7VHo=;
 b=XEWr2Svd++iRrUytAadC9CdLc6jA1KcQuiydTqR4HAp1JNm1fO/VKHnI0jzsJJw/wB
 MvN8kwH5w0qJjZhsXyKykfjFV0DHHm1M6kcZl6gxe6anz/a5tugp1fpxgIYm2JLPkTf/
 pSBJtYI+64I/Rv+y71RzM3CT+e8LuROz4cuGf9bJ/2zOWsW/GxdmSf0LJpd9hpw6EaH9
 TN0NatK1S5OEtGHRqPlaJ9YrapLwvXGW4eTBu9xxl5ieLxcx/mUmAfo1KuWPXsxtwUre
 AuQfHayDnIMFjHh+uP01ZSSu4Kp0lS073GjK+AqCkXDoFWHdweQCYk7xho2qVfwAdgrr
 l1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771512600; x=1772117400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FCi0alFE7PJKdffvGQNHsCppNHZRJnPMHnqdrnJ7VHo=;
 b=V69oJGcGTj/Wn1qEAf/vvehmwAKUfeLmnVPB7SNaSG57C37FEnh0RPWxTZDuLhNvog
 dB7fVKVAlM4t/RKCLxT9bx3B1y0CaqR+bjI5YJdNWBICObbwVeHh4bhtAV8sK+t4xSD5
 2ZuqAlSbOZlT4ezILfVRPt++OTwo0e6aXGgLdumCOqVOw6hdU8g566WHdBLIz5NjTI2P
 gUbMY/DI5pFtBIImvBJ3akBcqHK40QH2ekaYRTC/MdpS3UeWkGriIEX96xPEj6P6PhJH
 xdxyAKAWLuw6SQAEGEWhXtzMyZ1VtnI6dQmA5FsC2qTQ407T+QraSoOS7CQWk8sk5R6p
 +0kQ==
X-Gm-Message-State: AOJu0YyIzrH+RIEgkP4+uZyAAM98svPN0Y5VoGFVRowVzzqVxRVqRzlj
 7C1+eJw/FIFexXzC4OSA40Fm3ZVqqYWpe4lV1RbzVGMjKtuxXTp3rNStfJSw3xho
X-Gm-Gg: AZuq6aISbxIhAvQvTPWwXMhLP1ttE66ae1Dtt7YGrBYiE2BZaVeDRZwEw4rSgGA4ZX1
 yEdKxf5XhHefyCJiaEViYXI1mZ+wfqKm6p5WfKCNaNieDh/Gb4kSYv6blJVbo+a0vE/oVAArk+b
 dBtHsG7KG1THjKViAIXcMUD02xXffXw7k8DFhvJnBJeqIwVF1A6+1gn0QeeBTWErtPiW1NiwvNg
 C/GbvzpRx0Eg6Ik2VinMjZEJHQgfm2by4xKivgMHH41nlS8yRSHAe6HNdrb8lg7CR7WRi8622Jd
 LmOfvKzm9wOwD5dBex5IUplj598eWdgjM6CUamjunAogAhagMk7bGgyUTL1CYVJ3Tfk9Y8OIKRG
 Cy2QfdKkworrnJnLKmQPTpbiBip2stfK5+Sh1JLYgTMnL9FE7AJKx5BYYfQ1wR9P++KlXVsu7Sw
 0JpkuYxKAFaKqWuAjj51bQoQxiwWpv10v0HrL9gGHf8SErIXXbK02eg8VfibBbOjaXTTUG
X-Received: by 2002:a05:6000:2c11:b0:435:f29d:8c41 with SMTP id
 ffacd0b85a97d-43958e58511mr10191979f8f.62.1771512599975; 
 Thu, 19 Feb 2026 06:49:59 -0800 (PST)
Received: from thinkpad-t470s.. (93-143-129-182.adsl.net.t-com.hr.
 [93.143.129.182]) by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-43796ac8d82sm50163087f8f.31.2026.02.19.06.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 06:49:59 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, peter.maydell@linaro.org,
 artem_mygaiev@epam.com, volodymyr_babchuk@epam.com,
 takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Ruslan_Ruslichenko@epam.com, balaton@eik.bme.hu
Subject: [PATCH v2 33/33] tests/functional: Add functional tests for
 arm-generic-fdt machine
Date: Thu, 19 Feb 2026 15:49:01 +0100
Message-ID: <20260219144901.3317747-15-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260219144901.3317747-1-ruslichenko.r@gmail.com>
References: <20260219143332.3316679-1-ruslichenko.r@gmail.com>
 <20260219144901.3317747-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

This patch adds functional tests for the new `arm-generic-fdt` machine type.
It introduces two new test suites:

1. test_arm_generic_fdt.py: Validates the firmware boot chain (TF-A and
   EDK2). It checks the console output for specific patterns indicating
   successful execution of BL1, BL2, BL31, and UEFI stages.

2. test_arm_generic_fdt_alpine.py: Validates a full OS boot by launching
   an Alpine Linux ISO and waiting for the welcome message.

To support these tests, two pre-compiled Device Tree Blob (DTB) files are
added to `tests/data`.

The tests reuse the existing firmware assets and Alpine ISO infrastructure
from the sbsa-ref tests.

Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 .../arm-generic-fdt/arm64-sbsa-guest.dtb      | Bin 0 -> 673 bytes
 .../aarch64/arm-generic-fdt/arm64-sbsa-hw.dtb | Bin 0 -> 5414 bytes
 tests/functional/aarch64/meson.build          |   2 +
 .../aarch64/test_arm_generic_fdt.py           | 114 ++++++++++++++++++
 .../aarch64/test_arm_generic_fdt_alpine.py    |  61 ++++++++++
 5 files changed, 177 insertions(+)
 create mode 100644 tests/data/dtb/aarch64/arm-generic-fdt/arm64-sbsa-guest.dtb
 create mode 100644 tests/data/dtb/aarch64/arm-generic-fdt/arm64-sbsa-hw.dtb
 create mode 100755 tests/functional/aarch64/test_arm_generic_fdt.py
 create mode 100755 tests/functional/aarch64/test_arm_generic_fdt_alpine.py

diff --git a/tests/data/dtb/aarch64/arm-generic-fdt/arm64-sbsa-guest.dtb b/tests/data/dtb/aarch64/arm-generic-fdt/arm64-sbsa-guest.dtb
new file mode 100644
index 0000000000000000000000000000000000000000..5f2a1e9b2826eec45ed97e6dd704649a05d0af4c
GIT binary patch
literal 673
zcmZuuJx|0i40R8LjsXD+Gtw;#SBZ~>u>%r210zx{4c9=LRB?)cf5SiGkFYT#>@=y4
za+VVN*)R69@_F#{1u**nfNSzg@@I68=^W8v>j8@IA^dX}3GI;IO)>k7PbPKlJ=>_$
zyb&K#d~3ArUzfN-QF`@A85%4bhsws7-xk^i8PPE3l;S(a)gIquNmVr;U=mj7fSh1$
zyjOg4GfyjW=Rr%HA-g`3DVKL)?Q9um?L}~%Gj9Dhl*jr#VOEm)4-;HZaGP+RU!7Be
zjNkJnQ7<RRM$W~6ryQO;axS-XxIS{OwsW{|=CR*zg>1A{<%{yDoh@5!orix}@kH4L
u>UUL2WembX)U{WL2};*?BIuP-;ME#J<CUlpq$3VU(_^6ifKEOu`m|p^QBCmx

literal 0
HcmV?d00001

diff --git a/tests/data/dtb/aarch64/arm-generic-fdt/arm64-sbsa-hw.dtb b/tests/data/dtb/aarch64/arm-generic-fdt/arm64-sbsa-hw.dtb
new file mode 100644
index 0000000000000000000000000000000000000000..0f12655f9c4b4f12556dd0c55c3bc552ff3f8a5e
GIT binary patch
literal 5414
zcmd5=JC7Vi5bil%Heif-h=&MPtiXUg*4~|M46M)^84+1BSU|X*o9*2lyz{u3+4CJj
z!U3|xFR+A&9FmhD0s==!NJx&zh!6>g2oWIQ`)ayoXYS7CupLlR?{sxl*H=|t)7`V*
zANcDRV;+Cr7<1B?NB+R`1++tG52JyWj$-^9>9&77$KHkK-LB6u@-Lwsdi%{Y?{*HK
zd*j@x&O3H&bDM<raOc!JXFBgic{vYeoijl=jS^c;Ry$9CT|!g7>v%7iMM2TlU2!t%
zdto+r;(9J^k(##XBXtKo5!EupFGStP(E5o@H*8*5KUwjEJoYh%3To@EZTvY3K`I{(
zgsu4xUi<9ZrhMJ$s{ST;=27{}=+jq?ZLkamq;mSJ`Mwo@xBEx`)gJx0ZGX8qpr*gN
zu6N2`wRcDSUES#~eP_E<{;Iv(^;c@5jAEO&eI}=C$nw78_yfiqBqn7KHTn-U`uDp&
zedN2}N6jBW+c@dhNP=6~aGqN~wsD$oK@p^L^c^yPJ94r|@$9eLc<yHTxt&C5!l`wA
zTt%Ng3I=tD#a023rp|8fb5s5W7>%E{PSOoL>0j-`tFT+zxETQD)c?vom8VbaH{u@V
zK|EOLRRmEx_6|ot9r>+ey9QSMs{Oc0F4Paftr9(0c9?jGar(t|Le6QrqCxdg|8E7i
zjyDS<JB;ISJQ;>*QU=(mUAeVmcF=lYaQ<FmWNz<4lNbfdhCw{6cX^HBJEuq9#cRxO
zU`QMQ?G=-GrLJI3GP{ZRqO=`e3x~#Uv6k;u9G6Gn>>3;Oh{^i9ehELImJgR?$e65p
zQnr`;wqjlQFpVbDg(I+~*nGE`7v;O#c&>x`x)1&9Xj*ujqidsMeD6q<{bzrRG#pm@
zOl<>umFX8zoXxDi=1%%1t|)F>tKHt|8^!5mv)=OZ;6$&t$~UdXeGt7X!WqN3X|siU
zo}7?WBRT5)h^Fs6^VS#p=zyx4SG;34#M=+uop>A(+JUF*w=13v2giv7;_OxoXDfsF
zt!*;aez8^rz6~iApU1PHn9B6_d@7J+_M(P<u0}<dUjHi5EaZPy;i=ra4>}qzo*vGv
zW=(oex9xe)f&UcE<=lG_{U;l|k3LD|?g}M5u)O2j;z7Q>*VkrgcwuBWs;Q!jTzIFm
zg);5Yw|+Q|j=FKR%{)o2P{TCguua#EE8ncc+o^5Z^P;4*c|OldpIddF&So|rpsrBO
zu9U?Oobht5`;#c#SOo*({0^F&-2+w*$-Tt`RsqPBob%m#-wi2$0X+N4m)qnY!C(ht
zD*pt1eK)wypM!s@A^+0#RsZX@zPa3xQ*_Pobn_|)&}0oH&S6v*gJZ{fCwYWIQu%><
zP$L&UbVMXRvWz7kr}w#vrnQCtKcHV@)cXc=y|CZhH>gYB7*B2cJeZ0E!^JB528YRS
ze~(p%G14Q65%{aJZ^;b-qt)CdKJ|9u(<`AGU-4F5F^m0+qmmoP!un48G@$l7=u7U-
zw(Xm<p5Q=S<6(~XQ{%fx>XUoUZ~|0lg2abO7Nvt%Zt6pG?;wEqaGtY;YD|ssL^H-<
z8b(f$Id0~TK51+VyJ8NKDn_?1-tQQpeYMfYRTF2GujVC|O<>`eS#Bg$_4S<Ley|hs
z5JpKYObKv+QMI9%grT;}pWPh1JRXnh5*2-7be#_8lW*=zJ@D$2$}uE*)Ftr_r+voG
zK6U$mCQo@yE^Qna+IC)>kM-7Y;}~ILiT4ThhxRq+vM2Li=i|aNO$%2-#^e3xD5F`-
zyNW(*hWU{k6>&V@Smgykj!6s)Ml%Pj3yqan+CR8UpZ+o2stz>^M5^opd+C|P;!|W)
zkHOy3v*75L#<%YJ%5Q=vE_pdO_}@h3J4ReAa#U3X-tvPEk=#>l{y)#<h5vgvmqnTJ
z{M)(A71+NxFS7uDOqC{1M|NhqMf9QdLpz%lrW=e#xh)FE&V#({8GN^zFpaaIjMiq>
z;Fb`Dc35s@*2I|~jK@(Dm0M6NERN!}AU9!Bj`MZnzLwkH&fSF@6=uyBCYuJy2oT*Y
zkJ21Qoga%&F@7T-!Pls%J}czcPsd|Gn{XQByu!#`#sIZUbAM)&NjWviJoaV0Fc+f{
z2C69hidl;$zD-6^keF!HLt92$L0dJr>>Npg7-8qphOKO4uAd-xz6f$Vii*;G-Qy}U
zM`m;6sNlywarvJapAk|r4GLfK!Qkv>X%ngyCdQX0m;iql`gKD5Xk^^~0h~9>BD0V!
z?mVViPItcvd6V<Uxm};*&&Mr6&e9wweKAY%i`A@vM|cM(MMSqCD}#wONP8UQTk@&#
E4{LL%!~g&Q

literal 0
HcmV?d00001

diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
index 49eca12058..3ec20f5bb2 100644
--- a/tests/functional/aarch64/meson.build
+++ b/tests/functional/aarch64/meson.build
@@ -41,6 +41,8 @@ tests_aarch64_system_thorough = [
   'sbsaref',
   'sbsaref_alpine',
   'sbsaref_freebsd',
+  'arm_generic_fdt',
+  'arm_generic_fdt_alpine',
   'smmu',
   'tcg_plugins',
   'tuxrun',
diff --git a/tests/functional/aarch64/test_arm_generic_fdt.py b/tests/functional/aarch64/test_arm_generic_fdt.py
new file mode 100755
index 0000000000..7b0d81196e
--- /dev/null
+++ b/tests/functional/aarch64/test_arm_generic_fdt.py
@@ -0,0 +1,114 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a kernel and checks the console
+#
+# Based on test_arm_generic_fdt.py
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import QemuSystemTest, Asset
+from qemu_test import wait_for_console_pattern
+from qemu_test import interrupt_interactive_console_until_pattern
+
+from pathlib import Path
+
+def fetch_firmware(test):
+    """
+    Flash volumes generated using:
+
+    Toolchain from Debian:
+    aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0
+
+    Used components:
+
+    - Trusted Firmware         v2.12.0
+    - Tianocore EDK2           edk2-stable202411
+    - Tianocore EDK2-platforms 4b3530d
+
+    """
+
+    # Secure BootRom (TF-A code)
+    fs0_path = test.uncompress(Aarch64ArmGenericFdtMachine.ASSET_FLASH0,
+                                format="xz")
+
+    # Non-secure rom (UEFI and EFI variables)
+    fs1_path = test.uncompress(Aarch64ArmGenericFdtMachine.ASSET_FLASH1,
+                                format="xz")
+
+    for path in [fs0_path, fs1_path]:
+        with open(path, "ab+") as fd:
+            fd.truncate(256 << 20)  # Expand volumes to 256MiB
+
+    test.vm.add_args(
+        "-blockdev", f"driver=file,filename={fs0_path},node-name=pflash0",
+        "-blockdev", f"driver=file,filename={fs1_path},node-name=pflash1",
+    )
+
+
+class Aarch64ArmGenericFdtMachine(QemuSystemTest):
+    """
+    As firmware runs at a higher privilege level than the hypervisor we
+    can only run these tests under TCG emulation.
+    """
+
+    timeout = 180
+
+    # SBSA_FLASH0.fd.xz
+    ASSET_FLASH0 = Asset(
+            'https://share.linaro.org/downloadFile?id=kyoMLGC9zXa4oA7',
+            '76eb89d42eebe324e4395329f47447cda9ac920aabcf99aca85424609c3384a5')
+
+    # SBSA_FLASH1.fd.xz
+    ASSET_FLASH1 = Asset(
+        'https://share.linaro.org/downloadFile?id=Dj1HRXnDnKtU6Nj',
+        'f850f243bd8dbd49c51e061e0f79f1697546938f454aeb59ab7d93e5f0d412fc')
+
+    current_dir = Path(__file__).resolve().parent
+
+    hw_dtb_path = current_dir.parent.parent/ "data" / "dtb" / "aarch64" / \
+                    "arm-generic-fdt" / "arm64-sbsa-hw.dtb"
+
+    dtb_path = current_dir.parent.parent/ "data" / "dtb" / "aarch64" / \
+                    "arm-generic-fdt" / "arm64-sbsa-guest.dtb"
+
+    def test_edk2_firmware(self):
+
+        self.set_machine('arm-generic-fdt')
+
+        fetch_firmware(self)
+
+        self.vm.add_args('-hw-dtb', str(self.hw_dtb_path))
+        self.vm.add_args('-dtb', str(self.dtb_path))
+
+        self.vm.add_args('-device', "bochs-display")
+        self.vm.add_args('-device', "bochs-display")
+
+        self.vm.add_args('-d', 'guest_errors,unimp')
+        self.vm.set_console()
+        self.vm.launch()
+
+        # TF-A boot sequence:
+        #
+        # https://github.com/ARM-software/arm-trusted-firmware/blob/v2.8.0/\
+        #     docs/design/trusted-board-boot.rst#trusted-board-boot-sequence
+        # https://trustedfirmware-a.readthedocs.io/en/v2.8/\
+        #     design/firmware-design.html#cold-boot
+
+        # AP Trusted ROM
+        wait_for_console_pattern(self, "Booting Trusted Firmware")
+        wait_for_console_pattern(self, "BL1: v2.12.0(release):")
+        wait_for_console_pattern(self, "BL1: Booting BL2")
+
+        # Trusted Boot Firmware
+        wait_for_console_pattern(self, "BL2: v2.12.0(release)")
+        wait_for_console_pattern(self, "Booting BL31")
+
+        # EL3 Runtime Software
+        wait_for_console_pattern(self, "BL31: v2.12.0(release)")
+
+        # Non-trusted Firmware
+        wait_for_console_pattern(self, "UEFI firmware (version 1.0")
+        interrupt_interactive_console_until_pattern(self, "QEMU SBSA-REF Machine")
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
diff --git a/tests/functional/aarch64/test_arm_generic_fdt_alpine.py b/tests/functional/aarch64/test_arm_generic_fdt_alpine.py
new file mode 100755
index 0000000000..10429d21a3
--- /dev/null
+++ b/tests/functional/aarch64/test_arm_generic_fdt_alpine.py
@@ -0,0 +1,61 @@
+#!/usr/bin/env python3
+#
+# Functional test that boots a kernel and checks the console
+#
+# Based on test_arm_generic_fdt_alpine.py
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+from qemu_test import QemuSystemTest, Asset, skipSlowTest
+from qemu_test import wait_for_console_pattern
+from test_arm_generic_fdt import fetch_firmware
+
+from pathlib import Path
+
+class Aarch64ArmGenericFdtAlpine(QemuSystemTest):
+
+    ASSET_ALPINE_ISO = Asset(
+        ('https://dl-cdn.alpinelinux.org/'
+         'alpine/v3.17/releases/aarch64/alpine-standard-3.17.2-aarch64.iso'),
+        '5a36304ecf039292082d92b48152a9ec21009d3a62f459de623e19c4bd9dc027')
+
+    current_dir = Path(__file__).resolve().parent
+
+    hw_dtb_path = current_dir.parent.parent/ "data" / "dtb" / "aarch64" / \
+        "arm-generic-fdt" / "arm64-sbsa-hw.dtb"
+
+    dtb_path = current_dir.parent.parent/ "data" / "dtb" / "aarch64" / \
+        "arm-generic-fdt" / "arm64-sbsa-guest.dtb"
+
+
+    # This tests the whole boot chain from EFI to Userspace
+    # We only boot a whole OS for the current top level CPU and GIC
+    # Other test profiles should use more minimal boots
+    def boot_alpine_linux(self):
+        self.set_machine('arm-generic-fdt')
+
+        fetch_firmware(self)
+        iso_path = self.ASSET_ALPINE_ISO.fetch()
+
+        self.vm.set_console()
+        self.vm.add_args('-hw-dtb', str(self.hw_dtb_path))
+        self.vm.add_args('-dtb', str(self.dtb_path))
+        self.vm.add_args(
+            "-device", f"ide-cd,bus=ahci.0,unit=0,drive=cdrom0",
+        )
+        self.vm.add_args(
+            "-drive", f"file={iso_path},if=none,id=cdrom0",
+        )
+        self.vm.add_args('-device', "bochs-display")
+        self.vm.add_args('-netdev', "user,id=net0")
+        self.vm.add_args('-device', "e1000e,netdev=net0")
+
+        self.vm.launch()
+        wait_for_console_pattern(self, "Welcome to Alpine Linux 3.17")
+
+    def test_alpine_linux(self):
+        self.boot_alpine_linux()
+
+
+if __name__ == '__main__':
+    QemuSystemTest.main()
-- 
2.43.0


