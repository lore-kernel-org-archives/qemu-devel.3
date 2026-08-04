Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFB25C5518F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 17:02:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrIVH-0008VW-FH; Tue, 04 Aug 2026 13:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wrIV7-0008Tv-VR
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 13:00:26 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wrIV6-0000gy-BC
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 13:00:25 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-47fecbbafdaso4380f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2026 10:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1785862822; x=1786467622; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=cF/zvKp9V5nTLdLrbCLO9LIP5tYkEtz26Z+Uxc6lVP8=;
 b=P0Av0vUmAsTmLJpMdcZd3xEhwxxcF+5yPE2VjdiLTKs6Zjxt2nDQohxU8CkfdjPJEF
 bfTbJCMcDg01nqNiyOdzTxWK1gPQIcv0ud6mssBYpL6UMCub7vldlNagzUGQiJa73Vd7
 LMHprgRb6IsFpuXaL9r6+doeM/5E3gSgYyeaXo7Q4XCP3F4Vatdmz3p6GIsT5PHRqMD5
 EJKMxyS4CyyMJQqK5fRIRIclzmZAgXSItdlyL5J02rQoiLZZtXAwBVNBfMGSrVhEnHXT
 ZW5ntEE37Fc4+vL1EhdBEJXDx1Re9K6Nzyk8498Z6jDKRI+rQWR9Gj4N0mJtdK1Og3xD
 YarA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785862822; x=1786467622;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cF/zvKp9V5nTLdLrbCLO9LIP5tYkEtz26Z+Uxc6lVP8=;
 b=YSOQQB0zIHLsAZnK9oAgnAzx56Jjcp1ArmuqDwUk3q40JpMAcx5fB+VEDzWJHu+6Tp
 9WE9F6QqR/ZIHxIwarCb1ujAYjjO0+weLuDETLI09CmW0aagm1Nw2N8h2A+BIPq9tCRj
 HjnkuOFLnPqGR2G09qd2KhrWYQtWZZjqqr2QJYt4n82zw+AVBwVCkrqBND0jNIzY2ykU
 okjBttUdKKjw68A1Vyi5h3he4ltjJSIxN5Ek2KiOQr3PYxWdLZ8cF8w+IPN8RC9aiOD7
 0lq2mOR6Ru2hCXxJHFjpBvhKR7uxbSYVhzoKdJgnab54/LYCsWQpIoM3nljxZzo4zP3Y
 k1UQ==
X-Gm-Message-State: AOJu0YwlWL6pDtynu1H8n2b1tuOV1oPNyvkfgYO13qxjtvPvqxCRRcyQ
 1tXRcxtBCE5nvWiFGdJjHAY2DGFhyt/Hlz1Jk89XbCDtLXTT71xinG6Zv1EtKH5ikHIVbo1jOI3
 Gvcxe
X-Gm-Gg: AR+sD13E74UPuAO9bIOMLnYzixtF0Vi6bADy3NHahx/qdFsuvphO/6mmNtRmcDDrHp8
 BEhgoMyeOs0+cLXWQldKjWe8vsrVp/v2CaM0eSkRYjdMxxnXrV7sgX+TekNz8t2TKk+95SB84pS
 umdNsR/fR3auj/xzvMnuKHoJjz78JnEKLhmvkoKvrQFzStHg9pqK3XOXnW0+eYEGPXp2KHaCN6r
 7Vx6gHUKFcUbfJwb1y7f542kcFFFCtaaZqou0yLwRsketwjvyKox4qJOfzj0jJ0Mzy7aJ76i9If
 4Ep1bm8JAXvYPL82rOERZiSgjIPjFBZIJ6d3lZYNB2utUOs4HbMd/g/4Esz+931dURGrA+g6UBg
 jBAiJvyXWYLBxqV+Ms8pccOIZKBWUoVCeViJWw1nduKW31iVRjt7vVtRmOGY3ieFjIiHtQ8ADBZ
 dUcPxYSY7OyVOkQbxK+CCWC0X/M3OrnfoVanxRZYMz1itvLQ==
X-Received: by 2002:a05:6000:2913:b0:47f:973b:71c8 with SMTP id
 ffacd0b85a97d-47fec62e4eamr909420f8f.21.1785862821108; 
 Tue, 04 Aug 2026 10:00:21 -0700 (PDT)
Received: from athena ([213.133.28.44]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fec23ec3asm1234116f8f.31.2026.08.04.10.00.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 10:00:20 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 "Denis V. Lunev" <den@openvz.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PULL v2 2/7] tests/qtest/ide-test: add a multi-sector ATAPI DMA read
 test
Date: Tue,  4 Aug 2026 19:00:09 +0200
Message-ID: <20260804170015.3128363-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260804170015.3128363-1-den@openvz.org>
References: <20260804170015.3128363-1-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=den@openvz.org; helo=mail-wr1-x42a.google.com
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

test_cdrom_pio_large() already exercises a multi-sector PIO read.
Add the DMA counterpart through the same cdrom_read_impl() helper so
the multi-block ATAPI DMA read path gets equivalent coverage.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Stefan Hajnoczi <stefanha@redhat.com>
CC: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
---
 tests/qtest/ide-test.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/qtest/ide-test.c b/tests/qtest/ide-test.c
index c97bc17b67..6e59197566 100644
--- a/tests/qtest/ide-test.c
+++ b/tests/qtest/ide-test.c
@@ -1158,6 +1158,11 @@ static void test_cdrom_dma(void)
     cdrom_read_impl(1, CDROM_DMA);
 }
 
+static void test_cdrom_dma_large(void)
+{
+    cdrom_read_impl(BYTE_COUNT_LIMIT * 4 / ATAPI_BLOCK_SIZE, CDROM_DMA);
+}
+
 int main(int argc, char **argv)
 {
     const char *base;
@@ -1217,6 +1222,7 @@ int main(int argc, char **argv)
     qtest_add_func("/ide/cdrom/pio", test_cdrom_pio);
     qtest_add_func("/ide/cdrom/pio_large", test_cdrom_pio_large);
     qtest_add_func("/ide/cdrom/dma", test_cdrom_dma);
+    qtest_add_func("/ide/cdrom/dma_large", test_cdrom_dma_large);
 
     ret = g_test_run();
 
-- 
2.53.0


