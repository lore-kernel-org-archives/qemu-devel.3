Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7C36C27C4F
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 08:10:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKZJN-0001GA-Cx; Fri, 21 Jun 2024 04:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZJL-00016W-46
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:07:55 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKZJJ-00007p-BS
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 04:07:54 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-421cd1e5f93so12981345e9.0
 for <qemu-devel@nongnu.org>; Fri, 21 Jun 2024 01:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718957271; x=1719562071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kNBeXm9P/Ml80/yN91/eWbfFz/hJLMpAuct+ZmQTshg=;
 b=OrBh0QKF5202eZgpnj4VVSsUmsZ3Ac0YN/BkJjSwIJYWzJgUIOpL5B4JP7rvigrgw9
 xubpYvPoJlCtDl2+D9qzhjSXRHvbteKr1sPYhNi70sFfVUsatTKtoO5ou5QoUSExy1E8
 k803Zj8As0Q4yqwjomyBpRCGuHzxK9FYEanff+eXxjSqqFM0hPAH3UoAuZ9VcvfE+fzc
 Iy668CH6aFKPFvsWU/Zj2DWCABqwwY/yCCFpmTv0XTGYwJ1haYQ+WGQZZJZzrxPxuTip
 Y+BQ3LdBtx6knaWDdmVk9g1BAguYu63RvvH0BDRSZIW7kgIotiMnfAeG0ZaYQxCWjMyT
 CnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718957271; x=1719562071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kNBeXm9P/Ml80/yN91/eWbfFz/hJLMpAuct+ZmQTshg=;
 b=a2VFm6O1lP7AQvoRFlmBvgNJxp+5rBNOddrBDXwSgumvOAG1LaNumiFhM8NWFJuTe1
 Amg7bZ7x92Mk638RwxfWnIvx/uvwOtXIp4CEH4o7bnSvTzD4IUQvSj74vgjXEp5Yr2mR
 vQk/AOg1wFGOKZyGTVaw3oxH005wFKxPitpctOrVVJEoBeVufoEuv6SmlC5lB3HegC8q
 peW7wju0PmxPmzsgbzo0g5UeSe96tvjEnBFVS47KUuLrjujJMSsuW8mUjhnrnpbiBoNB
 dNy8HZeEqYyZK0y/yR4TES7umDY+BwPZsBXx4/qzxaXioXU7I/84evvowzWgUVeEay0k
 fnFg==
X-Gm-Message-State: AOJu0YxYiQ8FZj63rpxTWakNzI1QDgnyK+cTJHMWnuEiMpdbVtbDcgpI
 b0v4z93r6Wx2bbC3PkkkHv4AkqyHYfJ6aWk+Obl3HiVpxmRX7rfk8o5QZ0blMmUbMKWWRdeZ8T2
 5
X-Google-Smtp-Source: AGHT+IEqdyrdTUH8xzFAJeTGgMv41+cTdI7kRLqldWZsa0rWZmaGFn7XEb+ExxJeN1QhIbDeIIQiuw==
X-Received: by 2002:a05:600c:2d93:b0:421:182d:9232 with SMTP id
 5b1f17b1804b1-42475185a23mr56228875e9.18.1718957271702; 
 Fri, 21 Jun 2024 01:07:51 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.128.209])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4248191c65asm16698085e9.40.2024.06.21.01.07.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Jun 2024 01:07:51 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Bin Meng <bmeng.cn@gmail.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>, qemu-block@nongnu.org
Subject: [PATCH 19/23] hw/sd/sdcard: Inline BLK_READ_BLOCK / BLK_WRITE_BLOCK
 macros
Date: Fri, 21 Jun 2024 10:05:50 +0200
Message-ID: <20240621080554.18986-20-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240621080554.18986-1-philmd@linaro.org>
References: <20240621080554.18986-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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

These macros only save 3 chars and make the code harder
to maintain, simply remove them.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/sd/sd.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 8d63a39a54..ca2c903c5b 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -816,8 +816,6 @@ static void sd_blk_write(SDState *sd, uint64_t addr, uint32_t len)
     }
 }
 
-#define BLK_READ_BLOCK(a, len)  sd_blk_read(sd, a, len)
-#define BLK_WRITE_BLOCK(a, len) sd_blk_write(sd, a, len)
 #define APP_READ_BLOCK(a, len)  memset(sd->data, 0xec, len)
 #define APP_WRITE_BLOCK(a, len)
 
@@ -869,7 +867,7 @@ static void sd_erase(SDState *sd)
                 continue;
             }
         }
-        BLK_WRITE_BLOCK(erase_addr, erase_len);
+        sd_blk_write(sd, erase_addr, erase_len);
     }
 }
 
@@ -1901,7 +1899,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
         if (sd->data_offset >= sd->blk_len) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
-            BLK_WRITE_BLOCK(sd->data_start, sd->data_offset);
+            sd_blk_write(sd, sd->data_start, sd->data_offset);
             sd->blk_written ++;
             sd->csd[14] |= 0x40;
             /* Bzzzzzzztt .... Operation complete.  */
@@ -1927,7 +1925,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
         if (sd->data_offset >= sd->blk_len) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
-            BLK_WRITE_BLOCK(sd->data_start, sd->data_offset);
+            sd_blk_read(sd, sd->data_start, sd->data_offset);
             sd->blk_written++;
             sd->data_start += sd->blk_len;
             sd->data_offset = 0;
@@ -2075,8 +2073,9 @@ uint8_t sd_read_byte(SDState *sd)
         break;
 
     case 17:  /* CMD17:  READ_SINGLE_BLOCK */
-        if (sd->data_offset == 0)
-            BLK_READ_BLOCK(sd->data_start, io_len);
+        if (sd->data_offset == 0) {
+            sd_blk_read(sd, sd->data_start, io_len);
+        }
         ret = sd->data[sd->data_offset ++];
 
         if (sd->data_offset >= io_len)
@@ -2089,7 +2088,7 @@ uint8_t sd_read_byte(SDState *sd)
                                   sd->data_start, io_len)) {
                 return 0x00;
             }
-            BLK_READ_BLOCK(sd->data_start, io_len);
+            sd_blk_read(sd, sd->data_start, io_len);
         }
         ret = sd->data[sd->data_offset ++];
 
-- 
2.41.0


