Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D8CC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 19:18:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuauj-0008MJ-0o; Thu, 13 Aug 2026 15:16:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wuauc-0008JH-HA
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 15:16:22 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1wuaua-0002v1-1R
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 15:16:22 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-47f3b39f2a1so150971f8f.2
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 12:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1786648578; x=1787253378; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mDdh2UI45By9vRJbB1S6W1i0J2Q7pQgOqZLtO2CUFA0=;
 b=tTNxWTmkineoSGyG8D54faf55s7U9P/x5Pe+h44R/RepiSWnEhKj1sY2yICfY1RT1/
 ocMy/YFMzaZtFVtcYW53cHgxt5r9+CRoFzN9WwvVav6RFPl7RWOpqSAdNd2UG8p0w0jm
 eeygQn1C29AH1FcafbkjkC6ojdRnQ00eDAHEfnQXJi1lBs0159H2/C9X/0EhKlEHSaNF
 lwhC3wFjDSuaqNN4CbaYDOcu+gw9UbwKy2FxNCjLJo7tmYXObPpMTLb7rNzBaoGj4AzK
 65gxuX/rT1mpav4SUh85poXNqGbO2FWvgaZn7G8l3CSUMlDeaS62qdESx19rUGD2KOL6
 pRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786648578; x=1787253378;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mDdh2UI45By9vRJbB1S6W1i0J2Q7pQgOqZLtO2CUFA0=;
 b=rVYSmznNK+eVj5jeHjukmdXaUNhjHAbnLptfndjpQKevwRUR7JvLeJ9S5hZfhfAWsQ
 aE/rTmwEc+b8E6QjuqoJil9j5BMIAoIhes362uQTFRE3Tz0P8p0G83VktlqtNVomFv2N
 4x7+41nDNFX7T0tLTVXOBLbE2R2XY/bFrBgo0YUBKkA/rnKzv3TyKCpABbSeGd7jXuMx
 hnh1TSpj/UAl2L14015IDkzGAktsOjAG/rQYDHpLm0t2eWIEvIu3dK6m0mirS2YbQJEJ
 rwO0JRerakM/lGGClONv4gV6ATQBYd0K5rybrgLCMmP1iaWcPoP3mRG0X/i0u6d3uK4M
 pSFA==
X-Gm-Message-State: AOJu0YxMkCpcvnfUHiUlknKttpMJ8KKMjsDZm5XP8hafoxqbmNNXGSB2
 RGxyEQZKNVm970mP7pQs6FjUa4eenG6cnuC5RUgd+/hAYffqWO/TUKcQSBWC4U5CGAigNPZ1M28
 4HM/R
X-Gm-Gg: AR+sD10LRlqOMrXuMtWg90Dilt0KHnuR2NBeybjhkYw5pQEn7bPcAXq46vm3ValIFFM
 UySjQP3Y/Fro0bHI+E1QcxAEap867A9y6yRnAYQqR09OmHPnnW3okAtTbTON/wiyVbRV7uSuGr3
 PNw7bidwUfBvLnt8bkwX8SVRp+N0TweQNJyFKYUfCLiE4gu75DsHdG71zwSYcISUpQnYH3o0uFA
 tA3sOoMdaVmYaBS6r9AgzrcosUUx4szKIY9drcma5IAMvHValK4MKIsaTScRWGAQdDdA81uiYLd
 vPG7zlSlF/r1EqKQ6KG1foweZ9TO+UKhk5V5xnzwlqepRACK45lB62u+lfUNuAXQLa7F80ItBAF
 2c1AR1M4Lwsy1Rpq2r+nAdUt2fs4mZuirQjPiBsp+iG1zUV+38QO/90f4mhEweuH3ieu5x4UmUT
 ueayZGqHdkK9GE3HYwLtQBqJy1JF6TbbfbyquYqqVlXfQNMGQsfPx+ezTU
X-Received: by 2002:a7b:c5ce:0:b0:499:726c:d658 with SMTP id
 5b1f17b1804b1-499879bb9e5mr5108275e9.19.1786648578251; 
 Thu, 13 Aug 2026 12:16:18 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:859:6d78:3324:fe2c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2b1f90sm1312493f8f.18.2026.08.13.12.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 12:16:17 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 philmd@oss.qualcomm.com, den@openvz.org
Subject: [PULL v3 2/7] tests/qtest/ide-test: add a multi-sector ATAPI DMA read
 test
Date: Thu, 13 Aug 2026 21:16:07 +0200
Message-ID: <20260813191613.2323728-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260813191613.2323728-1-den@openvz.org>
References: <20260813191613.2323728-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=den@openvz.org; helo=mail-wr1-x436.google.com
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

test_cdrom_pio_large() already exercises a multi-sector PIO read.
Add the DMA counterpart through the same cdrom_read_impl() helper so
the multi-block ATAPI DMA read path gets equivalent coverage.

Signed-off-by: Denis V. Lunev <den@openvz.org>
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


