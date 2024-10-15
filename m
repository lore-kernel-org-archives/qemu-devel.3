Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D9AD1D87B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 15:50:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0jlO-00040e-0V; Tue, 15 Oct 2024 11:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jky-00023Q-9n
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:46:52 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t0jkw-0000sy-1K
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 11:46:43 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20cd76c513cso22067705ad.3
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 08:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729007200; x=1729612000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O3CwF/pvrtCvTLmBwFN1fDWOJO8U19FSddrcPe726vo=;
 b=SYOxRiWCU3NIq6MAmQMIyIleLr8lYENJ7BVX9E1ijHPbVJim4Ekq3TBUJnMvrAPpyu
 XOFN9AN0DaI6wu04n8mEHr3u+QV6xfc54fPn+byLKRON8jd7mpZX7Xw6wi1sifgmAIHG
 EGZnpK0bjbVbPK/bMemCTvBLKUMZWL12xsjXcBZR619VIcSeeyj+XDkZWOTZ+ZqVOiVS
 JNyxU9SmBG9rwd0BlmFYTuYv0ESq7zCDBot1lU1hgXaEfkmTrzC2FbulpcrwLyAtjchg
 YvL8K/Gj0g7vPfvS9C/U2Hc+b5kF4Ax6sdHLseC1kVCyWBETXwKzDSbUPdtAmomrq7CZ
 2emQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729007200; x=1729612000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O3CwF/pvrtCvTLmBwFN1fDWOJO8U19FSddrcPe726vo=;
 b=HzklblwHmuKc0QbL0hmZxE2LOi/PAr1bhHi3zMTzKHAySfaKdafmM5EsAqHyhbal8X
 Mj+MHHlSEKDIW84/GsHBSrbbrBG982YdO313xX/FmRrI2Ltt+QXa+v8UuqT0Q5Y/3sHr
 IWPj5+MO6Kd1DIi+p8saLDsT3tAwQOdVKoHjv9akVZM/4iP3hVQL4Z/aHIIU8AYNbY9Q
 zwFkjSZcovEZUbT77DPwy9lIY3vJIHIa6WMvmnHBtX0NZ+B5MAQWEqL7DuY+zjNB049S
 zDMahGXDX2PLMdpQ0AziVo+BRNTcBpFjpyPNyOp0bkZR4ZLDzFYD8g5/p2nj8bxOgZcR
 irBg==
X-Gm-Message-State: AOJu0YxSyCC+h6BnhClsVLfCU8LRmAzSyEcvB+XDruNINeer5lOI7V5j
 Ua1pmDOSzLQ9ttnHtL18uHb6SQrC1hbHTsfxQaISmFHWgU+0LCeRfzFcuORuwuumy2+lEk8xt/S
 w
X-Google-Smtp-Source: AGHT+IE3mxs8F8RQfXvk/UzQ7THNli/ACGhumpWbPhRQVmaCgaZImax8PDXgVtm4G7yy5ifxjtbU6g==
X-Received: by 2002:a17:902:db12:b0:20b:c1e4:2d70 with SMTP id
 d9443c01a7336-20ca147e89bmr214989295ad.23.1729007198962; 
 Tue, 15 Oct 2024 08:46:38 -0700 (PDT)
Received: from localhost.localdomain ([45.176.88.167])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d18036593sm13536675ad.164.2024.10.15.08.46.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 15 Oct 2024 08:46:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 16/33] hw/xtensa/xtfpga: Remove TARGET_BIG_ENDIAN #ifdef'ry
Date: Tue, 15 Oct 2024 12:44:25 -0300
Message-ID: <20241015154443.71763-17-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241015154443.71763-1-philmd@linaro.org>
References: <20241015154443.71763-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Move code evaluation from preprocessor to compiler so
both if() ladders are processed. Mostly style change.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240930073450.33195-8-philmd@linaro.org>
---
 hw/xtensa/xtfpga.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index 45b29d3b4e8..398e6256e1d 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -415,8 +415,7 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
             }
         }
         if (entry_point != env->pc) {
-            uint8_t boot[] = {
-#if TARGET_BIG_ENDIAN
+            uint8_t boot_be[] = {
                 0x60, 0x00, 0x08,       /* j    1f */
                 0x00,                   /* .literal_position */
                 0x00, 0x00, 0x00, 0x00, /* .literal entry_pc */
@@ -425,7 +424,8 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
                 0x10, 0xff, 0xfe,       /* l32r a0, entry_pc */
                 0x12, 0xff, 0xfe,       /* l32r a2, entry_a2 */
                 0x0a, 0x00, 0x00,       /* jx   a0 */
-#else
+            };
+            uint8_t boot_le[] = {
                 0x06, 0x02, 0x00,       /* j    1f */
                 0x00,                   /* .literal_position */
                 0x00, 0x00, 0x00, 0x00, /* .literal entry_pc */
@@ -434,14 +434,16 @@ static void xtfpga_init(const XtfpgaBoardDesc *board, MachineState *machine)
                 0x01, 0xfe, 0xff,       /* l32r a0, entry_pc */
                 0x21, 0xfe, 0xff,       /* l32r a2, entry_a2 */
                 0xa0, 0x00, 0x00,       /* jx   a0 */
-#endif
             };
+            const size_t boot_sz = TARGET_BIG_ENDIAN ? sizeof(boot_be)
+                                                     : sizeof(boot_le);
+            uint8_t *boot = TARGET_BIG_ENDIAN ? boot_be : boot_le;
             uint32_t entry_pc = tswap32(entry_point);
             uint32_t entry_a2 = tswap32(tagptr);
 
             memcpy(boot + 4, &entry_pc, sizeof(entry_pc));
             memcpy(boot + 8, &entry_a2, sizeof(entry_a2));
-            cpu_physical_memory_write(env->pc, boot, sizeof(boot));
+            cpu_physical_memory_write(env->pc, boot, boot_sz);
         }
     } else {
         if (flash) {
-- 
2.45.2


