Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B35BE66886
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Dec 2025 14:45:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vXKgi-0008Sm-9A; Sun, 21 Dec 2025 09:45:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@ziyao.cc>) id 1vXISV-0005l5-Uf
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 07:22:48 -0500
Received: from mail5.out.flockmail.com ([54.161.96.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <me@ziyao.cc>) id 1vXISU-000246-Ed
 for qemu-devel@nongnu.org; Sun, 21 Dec 2025 07:22:47 -0500
Received: from localhost (localhost [127.0.0.1])
 by smtp-out.flockmail.com (Postfix) with ESMTP id 4dZ0ld2R1Yz9rvw;
 Sun, 21 Dec 2025 12:22:37 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; bh=CeXYzpoV/HzQju2FXCn/V36fb1ZHeTurbLcdmmx23+I=; 
 c=relaxed/relaxed; d=ziyao.cc;
 h=subject:date:message-id:mime-version:cc:from:to:from:to:cc:subject:date:message-id:in-reply-to:reply-to:references;
 q=dns/txt; s=titan1; t=1766319757; v=1;
 b=DDFN0AqjO+Q95cAN2Cj5XlNsM3nkW7gmM8vOpwk49PODy2Tsaez4T0drinhst8nGUiQC9Wxn
 T+hB5fqr7P4UiHyi2M5AjDQAdQl/T54MNQUQRVd1dOqBxwEJBXxB3B4RIEHf1dk2Tz/t1/Pekf2
 3Pny5tablCmuDAcQdRywQ7b8=
Received: from ketchup (unknown [117.171.66.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by smtp-out.flockmail.com (Postfix) with ESMTPSA id 4dZ0lZ5N1gz9rvR;
 Sun, 21 Dec 2025 12:22:34 +0000 (UTC)
Feedback-ID: :me@ziyao.cc:ziyao.cc:flockmailId
From: Yao Zi <me@ziyao.cc>
To: Song Gao <gaosong@loongson.cn>, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: qemu-devel@nongnu.org,
	Yao Zi <me@ziyao.cc>
Subject: [PATCH] hw/loongarch/virt: Permit bytes/half access to IOCSR
Date: Sun, 21 Dec 2025 12:22:06 +0000
Message-ID: <20251221122205.56463-2-me@ziyao.cc>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-F-Verdict: SPFVALID
X-Titan-Src-Out: 1766319757193826375.21635.9107412786983697637@prod-use1-smtp-out1003.
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.4 cv=a8/K9VSF c=1 sm=1 tr=0 ts=6947e68d
 a=rBp+3XZz9uO5KTvnfbZ58A==:117 a=rBp+3XZz9uO5KTvnfbZ58A==:17
 a=MKtGQD3n3ToA:10 a=1oJP67jkp3AA:10 a=CEWIc4RMnpUA:10
 a=aVE23oPOqu3myQbryVkA:9 a=3z85VNIBY5UIEeAh_hcH:22
 a=NWVoK91CQySWRX1oVYDe:22
Received-SPF: pass client-ip=54.161.96.10; envelope-from=me@ziyao.cc;
 helo=mail5.out.flockmail.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 21 Dec 2025 09:45:02 -0500
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

IOCSRs could be accessed in any sizes from 1 to 8 bytes as long as the
address is aligned, regardless whether through MMIO or iocsr{rd,wr}
instructions. Lower min_access_size to 1 byte for IOCSR memory region to
match real-hardware behavior.

Fixes: f84a2aacf5d1 ("target/loongarch: Add LoongArch IOCSR instruction")
Signed-off-by: Yao Zi <me@ziyao.cc>
---
 hw/loongarch/virt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index 49434ad1828b..5cc57e9b5aa7 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -692,7 +692,7 @@ static const MemoryRegionOps virt_iocsr_misc_ops = {
     .write_with_attrs = virt_iocsr_misc_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid = {
-        .min_access_size = 4,
+        .min_access_size = 1,
         .max_access_size = 8,
     },
     .impl = {
-- 
2.51.2


