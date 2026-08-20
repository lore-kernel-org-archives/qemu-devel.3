Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BFF7C5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:45:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx3zW-0000fJ-Qg; Thu, 20 Aug 2026 10:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wx3zN-0000bi-Ck
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:43:29 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wx3zK-0005CG-5e
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 10:43:29 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-495437bb891so8373205e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 07:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1787237005; x=1787841805; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TJBKDx/NPPo3M962XW23quyF1pb9lG1A3xeKFPd765A=;
 b=LWR3vaJHqSTxMiVpucbUMNLqTugemSyDHaMcNxBhV1sEPSAbXopE56L92oeN50QDOQ
 yYM5ehLvrPCyxCRj+JIsKfvjXvaWF0ah0xkqEkhPM8qTvCWs6bp1aYnDolY/Mi744pwF
 1+mhAVpbvXC66Pr0WfrZTcgPeRVVfxN1ggxqQUaCAyUc5Qac0UtLL/eGAYgwX/4Xg3rS
 jgy9dDfmgocElWhzatKRp8iKYHAT9zuMguOGrmOcKgmZvZivCKQriaihkZ2RcC7L8mIz
 TY4J3ELV8TlUe4qCYEKW7ZfEz1gowK3sqDQy0xDB3HevTGmCkPhxS9HlE7C43QIiT18i
 GC+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787237005; x=1787841805;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TJBKDx/NPPo3M962XW23quyF1pb9lG1A3xeKFPd765A=;
 b=P/CI+WAbjeAzjfCuM6G5jWwpkqXKDNPOoko43Z6Td3vqaUHnkyvztMaMrGbNKOtlfF
 9+S3Y/1c42JB77jMixqtouDbxDU0zO9rJrR5cLdt9ybe32HyJ83KzlGNett1n7fPDV0l
 NziRSkr12bhApQcjLSt2awdvvrGb4apgF72ToKTB0OoFs+AIsFoz/qHsPoM8lgd9shyM
 v7Ujre7rdSUdHqRb96Mp8ErMCvisESbgnufy50YrIgJ29xrUnmBKPNpA5yd+vCGqn+/+
 G7uZ6t0HOJrsyD0OzI5ID2zLJJQ2TqY+u0/2YIEfVveDSqeYhQvsbpt8ouG7OsRQctn8
 oCGw==
X-Gm-Message-State: AOJu0YwlxK4DJ7vQmyI//tAq4xt1Tg9iTBnMNZGxT7i+ThYbDVM3P4sD
 inAevpgfIcVwKQGUVHgt4XiCvop61Y0idyhJIe41j6rZOWDBmTRauazEnHd/VDa8vIIV4IG5lPC
 FrI2N
X-Gm-Gg: AR+sD10n2W9k3Dw5c4Y8lqxsJTL9wdX2fkApWOUzP0xbCE6iQswV/7ANiBytLk5yv2S
 pOkWJkkRp8PsaZuuLaddxiK62MiXuSZoZz4oBSxMXXHwSZ75F/wueyw3u6MTbIPm5pJ6wbsYIPp
 ihOVbVypqo8i2zQJL+aYMLL74FgQHhIWMRLygH9IGH56+zwxnB8ToLDWR9r/y2lhLynIZYYuBGT
 D+a3ZS7p4P7r/Xq+C5/+mYDzK3wRXQTeCU7f5C4xuga68tggx/ukfveiH9K+JexhMY0R96Qmn5e
 FkDfbWU7TtQQ4XUag6Xs+9a45OuJyg/q3eZuFb1dhca+tVPxrSJpG5uL0VXvlRRErnYoarYTLxc
 ZGznkYdObdh/BT4zBBRCDNyLbGybgX6tPbtpxG74LAdIkk8/HilGskRxpAN+8fhTQQpLAK8gvOp
 8IhsqeC0nmd6s2a+TOeKQvbBZT8Tn8evuy5+vlHjzX8Jn4+xs+DY9o9nGXsTZ8rLv/trLv
X-Received: by 2002:a05:600c:674a:b0:499:5f80:83ac with SMTP id
 5b1f17b1804b1-499b06cbaf2mr111842375e9.7.1787237004806; 
 Thu, 20 Aug 2026 07:43:24 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a123:7b43:afd8:8b47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0dd620sm136791565e9.13.2026.08.20.07.43.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 07:43:24 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH 10/11] hw/ide: report ATAPI UDMA5 with a matching standard and
 cable
Date: Thu, 20 Aug 2026 16:43:08 +0200
Message-ID: <20260820144309.835173-11-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260820144309.835173-1-den@openvz.org>
References: <20260820144309.835173-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=den@openvz.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Denis V. Lunev <den@openvz.org>

IDENTIFY PACKET DEVICE claims UDMA mode 5 in word 88 while word 80
reports support only up to ATA/ATAPI-4. UDMA5 first appears in
ATA/ATAPI-6; ATA/ATAPI-5 stops at mode 4. Bits 3:1 of word 80 are
obsolete in IDENTIFY PACKET DEVICE data as well, so the old 001eh
claimed three standards that mean nothing for a packet device. Report
0070h, ATA/ATAPI-4 through ATA/ATAPI-6.

Word 93 was left unset, so nothing reported the 80-conductor cable that
UDMA5 needs. Fill it in, but only for a parallel attachment: ACS-3
7.13.6.41 gives word 93 of IDENTIFY PACKET DEVICE data the meaning of
word 93 of IDENTIFY DEVICE data, where "For SATA devices, word 93 shall
be set to the value 0000h". A cleared ncq_queues is how both identify
paths already tell a parallel attachment from an AHCI one.

The device 0 reset result is 0fh rather than the 01h ide_identify()
reports: bit 3 says diagnostics passed, which they did, and bits 2:1
say the device number came from some other method, the only one of the
four encodings that is not a jumper, CSEL or reserved.

Raising word 80 has a second effect. Linux decides a device is SATA in
ata_id_is_sata(), which wants word 93 clear and word 80 at ATA/ATAPI-5
or later. An AHCI CD-ROM satisfied neither condition before and was
taken for a parallel device; now it satisfies both.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/4038
Cc: John Snow <jsnow@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 hw/ide/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/ide/core.c b/hw/ide/core.c
index 06c18dbf09..ef573798d9 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -292,7 +292,7 @@ static void ide_atapi_identify(IDEState *s)
         put_le16(p + 76, (1 << 8));
     }
 
-    put_le16(p + 80, 0x1e); /* support up to ATA/ATAPI-4 */
+    put_le16(p + 80, 0x70); /* support up to ATA/ATAPI-6 */
     if (s->wwn) {
         put_le16(p + 84, (1 << 8)); /* supports WWN for words 108-111 */
         put_le16(p + 87, (1 << 8)); /* WWN enabled */
@@ -300,6 +300,10 @@ static void ide_atapi_identify(IDEState *s)
 
 #ifdef USE_DMA_CDROM
     put_le16(p + 88, 0x3f | (1 << 13)); /* udma5 set and supported */
+    if (!s->ncq_queues) {
+        /* word 93 is parallel ATA only, a SATA device reports zero */
+        put_le16(p + 93, 0x600f);
+    }
 #endif
 
     if (s->wwn) {
-- 
2.53.0


