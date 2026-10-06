Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3535CCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMzf-0007hP-16; Wed, 07 Oct 2026 04:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEHmA-0006Xb-3v
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:53:09 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEHly-0004rp-VW
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:52:56 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-5bccc73eea4so1129731e87.1
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 19:50:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791341440; x=1791946240; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GLxNFWV8pCAYWPytD3wTV65ZM3p+kzSwWoszDQAFfO8=;
 b=WngT7Oo9kpQDED41dqAvJLWjZmUFbd9/omILqrdVhmW5mkROYTCO966jX2IfkR+tlJ
 wfoj4v7CtTeNb9IdGrQd25ITyduevCg09+VTFvHHA7kK1mUSDKelizAskZn8mgBT6mJm
 LhgHFW+g9CCgVDakIYBagE+nhe2lb9Rm6A7JTMU9owP58zvziLwja2itc7pm277N04cz
 Jx5qTaFZqvzTcwPcMeTknD9Ar3xSXWJSBxq/NvBc3uD+pgoAXZOCCi2SSBrYo3WmABiM
 RGeawAPJhb3qY0319bzaRyiFkC4l94X5LOETIA+ekpaMZ+h6B+FcLoaq9KZzPPwTUBlh
 qcAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791341440; x=1791946240;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GLxNFWV8pCAYWPytD3wTV65ZM3p+kzSwWoszDQAFfO8=;
 b=i/TCT1M9ASRfHvghAXRQCPIXEgLWpcxWaEctNwgYzTM+jBXilGRLxQ1yyb/C0wXOML
 jedtYhRZTd01Zbz+2LmQB99QOJaCjrPmNM6anUB7YGCAEroFGm5iRIfd8gwYgGsQsAkr
 Ba/v4X67JmwDWdcFo7NW3VqhidR2t3D2iKoDIpo3YR1/XmrtASbxzQNn4ISkC02UxloZ
 4OY07hsdTmyDe1SJPpoQgMztZaInzGI/9zz/jhCAy1mPiAJgFIh+Lwu6hzG+TH8ivEG5
 eDQD11brLTtbSmB3za0nduAmZZg4S3d6Gx4w1nSiEjIX11Wg9/q5gRQm9xUeQ8ReLSy9
 gCCw==
X-Gm-Message-State: AFq9FYJSAprSBN4xbckAk6SVpMUqfTwugAUcoBZ0T9QsJoQDzIGumJi5
 y+j6VBHreq8sUnNUkFmlBy+2s3ByoTQOqoxjojEpy8Cjh9woa01oNKprmDdZWg==
X-Gm-Gg: AYBFou0wbv7uMbaC2xQeCQbNDUwb2S+wTL1fXKCDFuSD1kuLeIEqGyOffcDsrXDvEaQ
 9kllk+tJ3YdSurV0CKML5FZIZRB+KvCQ7QzYUQnXljv/X91o7HYYi//kGua6kWf1z1FVQVQpuUR
 YEoMixVac9HSnluEDcgdLSA1FoXzCH0XEqC8ud0NDG/2xPLuw8zU3yUn36XTRL27gZUimhwXSSS
 oTkYMs1uCKMKVvoFIVv0KQQilX0mLbY4ydrQuDMaEJD7yesohui5IOV/3zQnyjlJYcVxcS0e27R
 6n+GeonKDYW0/48VLxjmKwww5BWFL7VShZABGcFFIXA3/iza5OzW/DTUn2UNTWhU5nzx4nh5JRP
 6jLu0127Bz2v1jffVgJZ4/3MbrCiCgu+1cse/d2B24aDuGX14nKK4RgWodelpqUiv7C09BMnju6
 a3jtmOlHytzTdEl0a/QrfE3yH/QeIxkxAB4UUuK3eNldFmk4qc69SCBupUi2SqIIcPzTWVFun/x
 umjHzQU0LjqVmKR2keKUNCjXWJIJxofTD9W7oGLZO0dzdLf
X-Received: by 2002:a5d:5f88:0:b0:48c:4a62:9b31 with SMTP id
 ffacd0b85a97d-48c6d164fa6mr2204289f8f.5.1791279905135; 
 Tue, 06 Oct 2026 02:45:05 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6faa93fbsm433426f8f.16.2026.10.06.02.45.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 02:45:04 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Christian Speich <c.speich@avm.de>, Bin Meng <bmeng.cn@gmail.com>,
 qemu-block@nongnu.org, Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH v5 1/8] hw/sd/sd: Transfer up to one block in case of
 multi-block commands
Date: Tue,  6 Oct 2026 11:44:40 +0200
Message-ID: <20261006094447.43491-2-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006094447.43491-1-shentey@gmail.com>
References: <20261006094447.43491-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=shentey@gmail.com; helo=mail-lf1-x136.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Commit eff58d3d9681 ("hw/sd/sd: Allow multi-byte read/write for generic
paths") allowed for transferring multiple bytes at once at the choice of
the SD host implementation. Take advantage of that in the multi-block
commands CMD18 and CMD25 by transferring up to one block rather than one
byte at a time.

Note that the drive limits and write-protect groups were already checked
at the block boundary only. In between, bytes were accumulated up to one
block and the block was trustfully transferred once full. This patch
optimizes the accumulation process to fill a whole block at once if
possible, so no further checks are required.

This patch is based on https://lore.kernel.org/qemu-devel/20260417-sdcard-performance-b4-v4-3-119e66be10c2@avm.de/

Signed-off-by: Christian Speich <c.speich@avm.de>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/sd/sd.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b1b3b1226a..759db66e3d 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2663,7 +2663,6 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
 {
     unsigned int partition_access;
     int i;
-    const uint8_t *value = buf;
 
     if (!sd->blk || !blk_is_inserted(sd->blk)) {
         return length;
@@ -2695,12 +2694,6 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
         break;
 
     case 25:  /* CMD25:  WRITE_MULTIPLE_BLOCK */
-        /*
-         * Only read one byte at a time. We will be called again with the
-         * remaining.
-         */
-        length = 1;
-
         if (sd->data_offset == 0) {
             /* Start of the block - let's check the address is valid */
             if (!address_in_range(sd, "WRITE_MULTIPLE_BLOCK",
@@ -2714,7 +2707,11 @@ static size_t sd_write_data(SDState *sd, const void *buf, size_t length)
                 }
             }
         }
-        sd->data[sd->data_offset++] = value[0];
+
+        length = MIN(sd->blk_len - sd->data_offset, length);
+        memcpy(sd->data + sd->data_offset, buf, length);
+        sd->data_offset += length;
+
         if (sd->data_offset >= sd->blk_len) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
@@ -2811,7 +2808,6 @@ static size_t sd_read_data(SDState *sd, void *buf, size_t length)
     const uint8_t dummy_byte = 0x00;
     unsigned int partition_access;
     uint32_t io_len;
-    uint8_t *value = buf;
 
     if (!sd->blk || !blk_is_inserted(sd->blk)) {
         memset(buf, dummy_byte, length);
@@ -2851,16 +2847,10 @@ static size_t sd_read_data(SDState *sd, void *buf, size_t length)
         break;
 
     case 18:  /* CMD18:  READ_MULTIPLE_BLOCK */
-        /*
-         * We will only read one byte at a time. We will be called again with
-         * the remaining buffer.
-         */
-        length = 1;
-
         if (sd->data_offset == 0) {
             if (!address_in_range(sd, "READ_MULTIPLE_BLOCK",
                                   sd->data_start, io_len)) {
-                *value = dummy_byte;
+                memset(buf, dummy_byte, length);
                 return length;
             }
             partition_access = sd->ext_csd[EXT_CSD_PART_CONFIG]
@@ -2871,7 +2861,10 @@ static size_t sd_read_data(SDState *sd, void *buf, size_t length)
                 sd_blk_read(sd, sd->data_start, io_len);
             }
         }
-        *value = sd->data[sd->data_offset++];
+
+        length = MIN(io_len - sd->data_offset, length);
+        memcpy(buf, sd->data + sd->data_offset, length);
+        sd->data_offset += length;
 
         if (sd->data_offset >= io_len) {
             sd->data_start += io_len;
-- 
2.56.0


