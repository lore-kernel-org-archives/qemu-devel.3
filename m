Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8FA606A31B
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 09:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cdac.in header.i=@cdac.in header.a=rsa-sha256 header.s=default header.b=IgV3sCly
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKBZm-00069R-41; Fri, 23 Oct 2026 05:28:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karthika.b@cdac.in>)
 id 1xKBZg-00067i-4K; Fri, 23 Oct 2026 05:28:32 -0400
Received: from mailsender.cdac.in ([196.1.113.117]
 helo=mailsender-core1.pune.cdac.in)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <karthika.b@cdac.in>)
 id 1xKBZc-0007AV-F9; Fri, 23 Oct 2026 05:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=cdac.in; s=default;
 t=1792747678; bh=stH8KsnIGvSsUHrHLDpgrYZSxeFdSS9Q4eGbKj4uE5U=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IgV3sClyB7vQQPVzgQGDZ7qaAeCiZMd17xR2iaJwpIVtXqXnObPZ8ze35glIpV/6E
 9xVJ3SRH/HeWh2heAu5GX41D7K5J5JMk4nuqp/aRd3MiZ0EhLBN7fVgszYzvrFAjOi
 XO+fSXjHSpGTgELvuJWqCH8v1FCtwAU5CaNtKRz4=
Received: from mscr-int2.pune.cdac.in (mscr-int2.pune.cdac.in [10.208.193.12])
 by mailsender.cdac.in (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 69N9RvHg1831913; Fri, 23 Oct 2026 14:57:57 +0530
Received: from mailgw-cip.pune.cdac.in (mscr-haproxy.pune.cdac.in
 [10.208.193.46])
 by mscr-int2.pune.cdac.in (Postfix) with ESMTP id ED155100074B2;
 Fri, 23 Oct 2026 14:57:47 +0530 (IST)
X-Auth: karthika.b@cdac.in
Received: from hdg164.tvm.cdac.in (hd_hdg164.tvm.cdac.in [10.176.18.107])
 (Authenticated sender: karthika.b@cdac.in)
 by mailgw-cip.pune.cdac.in (Postfix) with ESMTPSA id 76EF714E2709;
 Fri, 23 Oct 2026 14:57:47 +0530 (IST)
From: Karthika B <karthika.b@cdac.in>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair@alistair23.me, sreenadh@cdac.in,
 raokk@cdac.in, Karthika B <karthika.b@cdac.in>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>
Subject: [PATCH 2/3] tests/functional: Add VEGA OpenSBI boot test
Date: Fri, 23 Oct 2026 14:57:26 +0530
Message-ID: <20261023092727.41197-2-karthika.b@cdac.in>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023092727.41197-1-karthika.b@cdac.in>
References: <2071795723.301996.1792747114406@webmail2.cdac.in>
 <20261023092727.41197-1-karthika.b@cdac.in>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CDAC-PUNE-MailScanner-Information: Please contact the ISP for more
 information
X-CDAC-PUNE-MailScanner-ID: ED155100074B2.A0794
X-CDAC-PUNE-MailScanner: Found to be clean
X-CDAC-PUNE-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
 score=-0.999, required 6, ALL_TRUSTED -1.00, URIBL_BLOCKED 0.00)
X-CDAC-PUNE-MailScanner-From: karthika.b@cdac.in
Received-SPF: pass client-ip=196.1.113.117; envelope-from=karthika.b@cdac.in;
 helo=mailsender-core1.pune.cdac.in
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Karthika B <karthika.b@cdac.in>
---
 tests/functional/riscv64/test_vega.py | 50 +++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tests/functional/riscv64/test_vega.py b/tests/functional/riscv64/test_vega.py
index b71daa7bbb..5f1003b788 100644
--- a/tests/functional/riscv64/test_vega.py
+++ b/tests/functional/riscv64/test_vega.py
@@ -53,6 +53,56 @@ def test_riscv64_vega_linux(self):
                          '-kernel', bbl_path,
                          '-dtb', dtb_path,
                          '-initrd', rootfs_path,
+                         '-cpu', 'vega64,f=true,d=true,c=true',
+                         '-no-reboot')
+
+        self.vm.launch()
+        self.wait_for_console_pattern('cdac login:')
+
+
+class VegaOpenSBI(LinuxKernelTest):
+
+    ASSET_FW_PAYLOAD = Asset(
+        'https://gitlab.com/riscv-vega/vega_qemu_test_images/-/raw/v1.1/opensbi/fw_payload.elf',
+        '8ad86d0e83670a6ded668b33e63001939dfc1bde71d8ca01afc2f05dccf24f2f')
+    ASSET_IMAGE = Asset(
+        'https://gitlab.com/riscv-vega/vega_qemu_test_images/-/raw/v1.1/opensbi/Image',
+        '9feeca99c8116e3b6eeaa50029467c884b4677c885df2a61e660fb6b03616621')
+    ASSET_ROOTFS = Asset(
+        'https://gitlab.com/riscv-vega/vega_qemu_test_images/-/raw/v1.1/opensbi/rootfs.cpio',
+        '574bf2f64ad84323ecb6de8bc41a14c621165bc6eefe4f61a0759689c03a44a9')
+    ASSET_DTB = Asset(
+        'https://gitlab.com/riscv-vega/vega_qemu_test_images/-/raw/v1.1/opensbi/riscv_uboot.dtb',
+        '3f9e00b3474d460a311fe99c44681ca43da8443a6522247d7c7ce1784157e36b')
+
+    def test_riscv64_vega_opensbi(self):
+        self.set_machine('vega')
+        fw_payload_path = self.ASSET_FW_PAYLOAD.fetch()
+        image_path = self.ASSET_IMAGE.fetch()
+        rootfs_path = self.ASSET_ROOTFS.fetch()
+        dtb_path = self.ASSET_DTB.fetch()
+
+        self.vm.set_console()
+        self.vm.add_args('-M', 'vega,dram-base=0x80000000',
+                         '-m', '512M',
+                         '-kernel', fw_payload_path,
+                         '-bios', 'none',
+                         '-dtb', dtb_path,
+                         '-netdev', 'user,id=net0',
+                         '-device', 'virtio-net-device,netdev=net0',
+                         '-object',
+                         'rng-random,filename=/dev/urandom,id=rng0',
+                         '-device', 'virtio-rng-device,rng=rng0',
+                         '-device',
+                         f'loader,file={image_path},addr=0x84000000,'
+                         'force-raw=on',
+                         '-device',
+                         f'loader,file={rootfs_path},addr=0x88000000,'
+                         'force-raw=on',
+                         '-device',
+                         f'loader,file={dtb_path},addr=0x00020000,'
+                         'force-raw=on',
+                         '-cpu', 'vega64,f=true,d=true,c=true',
                          '-no-reboot')
 
         self.vm.launch()
-- 
2.43.0


------------------------------------------------------------------------------------------------------------
[ C-DAC is on Social-Media too. Kindly follow us at:
Facebook: https://www.facebook.com/CDACINDIA & Twitter: @cdacindia ]

This e-mail is for the sole use of the intended recipient(s) and may
contain confidential and privileged information. If you are not the
intended recipient, please contact the sender by reply e-mail and destroy
all copies and the original message. Any unauthorized review, use,
disclosure, dissemination, forwarding, printing or copying of this email
is strictly prohibited and appropriate legal action will be taken.
------------------------------------------------------------------------------------------------------------


