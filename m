Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9ABCC3065C
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:24:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZja-0007kz-O6; Tue, 02 Jul 2024 05:23:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZjX-0007Ci-Ki
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:23:32 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZjV-0007Kn-PO
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:23:31 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52cdf4bc083so5980015e87.2
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912207; x=1720517007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fsQ5dZXMOKylcaTkeNe5NCCv+ATRu3UFQ5w5tnxMhiA=;
 b=pMiPF/ahxDbSmw+Z3jn67XJyeK7Fb606Ql5Z5heggJSXaSgbSQ2CRpb7tVC6PTJK0L
 GHMTyqEy8nsSGHqbVSiEJsqXIn5U7JuY0WPeB47pFxBh6AgK96S+qhq1tdBwGeSnmkxV
 t895XzR5d3Q5db3tbXIeYydUTnMnkuTT8/zk8J4ISmcx86nVhmvmdhasubifzDIcCIzE
 +vF/rACjZ/8MYw6fD5IPQKRlHKx+shoH35/ZhlYxY9L2UBAw4SWoEbJsgiudv4M3cdDX
 60LS8rH3jywCcp18PEdEr8nl9lOVjA0ip7/zp5XD507mEaTuEjAtFaf02so/5jphLxrg
 vuew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912207; x=1720517007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fsQ5dZXMOKylcaTkeNe5NCCv+ATRu3UFQ5w5tnxMhiA=;
 b=K8bUvyXqV9olXZFMNF/BA9F9WTp3hKOD2JEan1YgShENtYxugR/PCgDcJAEM/6AjbB
 /U+WBHCsuxsrGdLWmQZEatUNp2Y91wqM55fVPdVaPnh61v+32vvMq6yuaJwcqnATTDvm
 KGzS5Vb9vtGigC4I8e70+T2FzPw2sZDPm91f4JkFR4iPuJKmiFInc4t6Siz9gAf8/9qp
 E+XFbI9TphGgpXvbwt87EPsqbcxywTF6lG/Mfo2zYaWYCM0UcdKF+1FF/G6Utlth6XQG
 qF/ekLopdZKBVWrmTVQwf0rfLfQxoeirJT7o4NOZbfagzYJ32v5fSrqOSJPfdvB3VZ79
 Uaqg==
X-Gm-Message-State: AOJu0Yxd13qEKDj6ROAGd7w70TJ1WwtlZUcYZYbFp2uND5BEbUOja5lr
 p2U/dFrUMS2VOLFe5Q+TBaTPtGGU3gNQaUE1Th1DW3hfxKay0YhP+VnKDRtMq2nEcergBb9ws+v
 W
X-Google-Smtp-Source: AGHT+IHSYdj0In9GrZnIfuyCsFynXZMlz2mFb4Zudd6ADx8FOupFAMFMxmcrSVf+HAVPBG25PuaJag==
X-Received: by 2002:a05:6512:39cc:b0:52c:c8bc:74d4 with SMTP id
 2adb3069b0e04-52e826f1554mr6105380e87.48.1719912206735; 
 Tue, 02 Jul 2024 02:23:26 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0cd6d9sm12585862f8f.12.2024.07.02.02.23.25
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:23:26 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 26/67] hw/sd/sdcard: Convert WRITE_SINGLE_BLOCK to
 generic_write_byte (CMD24)
Date: Tue,  2 Jul 2024 11:20:09 +0200
Message-ID: <20240702092051.45754-27-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12c.google.com
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

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-32-philmd@linaro.org>
---
 hw/sd/sd.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index b1acddca45..349549f801 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1096,7 +1096,6 @@ static sd_rsp_type_t sd_cmd_unimplemented(SDState *sd, SDRequest req)
 }
 
 /* Configure fields for following sd_generic_write_byte() calls */
-__attribute__((unused))
 static sd_rsp_type_t sd_cmd_to_receivingdata(SDState *sd, SDRequest req,
                                              uint64_t start, size_t size)
 {
@@ -1462,10 +1461,6 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
                 return sd_r1;
             }
 
-            sd->state = sd_receivingdata_state;
-            sd->data_start = addr;
-            sd->data_offset = 0;
-
             if (sd->size <= SDSC_MAX_CAPACITY) {
                 if (sd_wp_addr(sd, sd->data_start)) {
                     sd->card_status |= WP_VIOLATION;
@@ -1475,7 +1470,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
                 sd->card_status |= WP_VIOLATION;
             }
             sd->blk_written = 0;
-            return sd_r1;
+            return sd_cmd_to_receivingdata(sd, req, addr, sd->blk_len);
 
         default:
             break;
@@ -1989,7 +1984,6 @@ send_response:
 }
 
 /* Return true if buffer is consumed. Configured by sd_cmd_to_receivingdata() */
-__attribute__((unused))
 static bool sd_generic_write_byte(SDState *sd, uint8_t value)
 {
     sd->data[sd->data_offset] = value;
@@ -2035,8 +2029,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
                             sd->current_cmd, sd->data_offset, value);
     switch (sd->current_cmd) {
     case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
-        sd->data[sd->data_offset ++] = value;
-        if (sd->data_offset >= sd->blk_len) {
+        if (sd_generic_write_byte(sd, value)) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             sd_blk_write(sd, sd->data_start, sd->data_offset);
-- 
2.41.0


