Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01A5BC3064D
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:26:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZjh-0008WJ-R9; Tue, 02 Jul 2024 05:23:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZjg-0008VC-9j
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:23:40 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZjc-0007V9-Jh
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:23:39 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a72459d8d6aso399480966b.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912213; x=1720517013; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4VJOT5ZcN/EvCEADOgKfKYKQ9sQEErpJJZeG9rUrgf8=;
 b=pwCusik83OhK9oMd7E4pjMCRa79euDk5DZdx+8c89McIRwj0xXRZzJT226EFDoDL8r
 AFVAPiGdaicHliDvjIzeYZxqbNQNuXQjyE97omUthIu24zUHMoiiaZH85hhp4XWnEv3S
 3tBLyYrakefdoN9b2gGcXrVCtxIFoIF5f5HmhPfqQASIUxnNaDKFfmCr4VTJQZvrntok
 OdNxyLraoWYMwU7Z9mJoaBeykd0NLELho8wxK+I1BYy27X8iC/Eg8McAcLrR2KvHaC5y
 nM2OYb6y5uox4Qg3nFpSzhYmYdF6DKIitiOSZVA8aEEswGoEdq3lnuVNkGDWy7ja2aQG
 fgDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912213; x=1720517013;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4VJOT5ZcN/EvCEADOgKfKYKQ9sQEErpJJZeG9rUrgf8=;
 b=IbNepXbiWoVpoSUVc5BCp/I+bkPPAx+co8FZoBLFPiDfNxc7sW/2GfOeNYYuKZQU1c
 YyiXa54o+G45hYnw0RurLZKtJLvep0udwmHvjOne4PNejQrDFwyJadReTMsqUo6XdzlM
 XOvlsJZdBaW1aV3uMrItdKYex/0ZdzJpRQugs5b818Zm2OszI/0NNIUPl9oU+hjw8GNU
 Lh1DrHCjvDoW+Weaoign1PiWqeH3MSA/3OQPkm9bHF2dISjFPjXaX6DAK2XEJnTQ73aT
 S7bQHgnUffWOHiVotsI1xcVa73PEz53X83MJWY0mjpnae6/iJc56hv5no4wgQE8yuK1C
 ZEYw==
X-Gm-Message-State: AOJu0YwWZ1E0mTtdY7g/D/CbAz5TYkvtzqB1J/lXbIetpa9Lgk0/eaVb
 TTlBXvDQ0no+zz2P6C+rF5o64Qamb3ON8Fr5YOISnba/Y3JZ9OJkQqScwvT7rXB9E1BksEIy3hs
 z
X-Google-Smtp-Source: AGHT+IF1qeQAMwghrfWZ1Jwegrru0Z+Ct+8pKzBl7BJ+48Fd8XV3oLJ0jNxWtQrFzI2k6TESv8JBeA==
X-Received: by 2002:a17:906:db0b:b0:a6f:e819:da9c with SMTP id
 a640c23a62f3a-a751444dab8mr691427266b.43.1719912212642; 
 Tue, 02 Jul 2024 02:23:32 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0fb9absm12668064f8f.80.2024.07.02.02.23.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:23:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 27/67] hw/sd/sdcard: Convert PROGRAM_CID to generic_write_byte
 (CMD26)
Date: Tue,  2 Jul 2024 11:20:10 +0200
Message-ID: <20240702092051.45754-28-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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
Message-Id: <20240628070216.92609-33-philmd@linaro.org>
---
 hw/sd/sd.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 349549f801..0aead3c866 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -1507,17 +1507,7 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
         break;
 
     case 26:  /* CMD26:  PROGRAM_CID */
-        switch (sd->state) {
-        case sd_transfer_state:
-            sd->state = sd_receivingdata_state;
-            sd->data_start = 0;
-            sd->data_offset = 0;
-            return sd_r1;
-
-        default:
-            break;
-        }
-        break;
+        return sd_cmd_to_receivingdata(sd, req, 0, sizeof(sd->cid));
 
     case 27:  /* CMD27:  PROGRAM_CSD */
         switch (sd->state) {
@@ -2078,8 +2068,7 @@ void sd_write_byte(SDState *sd, uint8_t value)
         break;
 
     case 26:  /* CMD26:  PROGRAM_CID */
-        sd->data[sd->data_offset ++] = value;
-        if (sd->data_offset >= sizeof(sd->cid)) {
+        if (sd_generic_write_byte(sd, value)) {
             /* TODO: Check CRC before committing */
             sd->state = sd_programming_state;
             for (i = 0; i < sizeof(sd->cid); i ++)
-- 
2.41.0


