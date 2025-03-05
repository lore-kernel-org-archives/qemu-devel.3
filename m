Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F0FC282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdWm-00065R-2T; Tue, 04 Mar 2025 20:26:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdVe-0004Tq-4Y
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:25:21 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdVa-0007XW-Ho
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:25:16 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3910e101d0fso1839227f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:25:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137913; x=1741742713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zNYmKdmAkSe74tv/hM9qGRHhB0/eo8ytTK5WDBjYNps=;
 b=vQQfY9jgOF3N27M2LmAJimAt22HJRbBmZkLexoiPUTTC96GoFEx5aZgDT5et57GrEG
 txGeceelQVXCLhDyaIRUFcuFW8Ke6D91f3iM91CACgxh9GeGp2HhzHeYGot5PsQvqyst
 IyyZFMCQ036U371z+nu/yssKk1p3UEAMoBOBYtFABHxGpWYKFHBpG9gS3f+lV7KECtu/
 aeZMqX+Vv5+ybnKiIYkDof1sGlZPQPCZbKTtJJ8n8dZ8Q8XcoUQCpWGa1SfHi3nnUcXg
 Ua2EtFRTEv/+8IxCVodK3hAbrM7F+ryVu1OrA9muicFd67dgqcBCfTM4AKG3tdwJ4CuX
 1X8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137913; x=1741742713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zNYmKdmAkSe74tv/hM9qGRHhB0/eo8ytTK5WDBjYNps=;
 b=Trol7ZGIDUPzI5Wjok+f5hkHo1/xFDbhVLkrNwC2+TLRM5pZdkBn67/vKwJFsDLQEZ
 u/jPQ4wSFxALSuWRUdXxhd2dS1m2ubqFxuZsaL1rPsCERy4UWoxRNdpFzMhY1sp2iwsg
 yoHH7SqX2qsz38V2YLoihCfO6+ncjgJ222Y7EGA3lpta2CaOwqEPLxJNmOtWHSxT4oMP
 egX7WE6LwO4kXKDVwFmsmObUruRFUQCnPJjZDAmwXXxi/SOYoHqxSzhy/y8wUQbDU4nY
 ZFLax3Efsvh0YWQvbEaCDoltjvUmUObxqrcTEL0vatUywqdUgI3qMsqYW64HT9P9GRbv
 4QBw==
X-Gm-Message-State: AOJu0YwwKtQXRmAWWOVidcOLPSP+pYE2qfbnb5qRMcH4e0BzLmt56UWC
 TUVvBKkP/+OQITSTs1xrl2YWVxpBzIlH9M0jzar91zgoZ64vJKzxe8Qq6UfmKFeKDPvgh8gkmCm
 8UJ8=
X-Gm-Gg: ASbGncs5I/3eOVvS4mX1kyoeQieXQkJy5OPOrsCx/9Qhp7CIZf6dMK8eWoEE751nr64
 h7fM4I7V/n62xcAtLg1REi+qsew0Izcb5IkiQpZmlKFSB14kRiK5Pp0LsEfID+vpZWd4LjIhthQ
 be/Z3tIV+7wiOueMUok2D7gkGbItwWKBcWCxKmYd/xGzQ5ywFWsqXr7w/omce1huPx2cBcBAfZw
 d6aIJLYzfZ5ISL6gV9lTugMUn8RguhGj9cHYLit8JwXY4o7rYETrn9g+pube2wegKP336DIG9iv
 muKb5+0LqsA0OPLtGlBdTe4wMXQxYt/kJLmMVEkbjaz9K6BewbDmaQeu53lxcCT2RZwIkCqrH/e
 xBZFtAoUcXZaUEsKyvZc=
X-Google-Smtp-Source: AGHT+IF/Aq1E6HYWY3+62q3IhdcMlhTsymuc5Adu1vrnYudPtzpupQTtly/2q4Cr8h8MIyFdiiwrjg==
X-Received: by 2002:a5d:59ad:0:b0:391:8a3:d943 with SMTP id
 ffacd0b85a97d-3911f73f9f3mr787266f8f.13.1741137912683; 
 Tue, 04 Mar 2025 17:25:12 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e485e03asm19626906f8f.95.2025.03.04.17.25.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:25:12 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 40/41] hw/nvram/eeprom_at24c: Remove memset after g_malloc0
Date: Wed,  5 Mar 2025 02:21:55 +0100
Message-ID: <20250305012157.96463-41-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Calling memset to zero memory is not needed after g_malloc0 which
already clears memory. These used to be in separate functions but
after some patches the memset ended up after g_malloc0 and thus can be
dropped.

Fixes: 4f2c6448c3 (hw/nvram/eeprom_at24c: Make reset behavior more like hardware)
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <ff281851e6d824ecd01b8b5cd955328dae1515a0.1740839457.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/nvram/eeprom_at24c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index 9f606842eb6..78c81bea77f 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -190,7 +190,6 @@ static void at24c_eeprom_realize(DeviceState *dev, Error **errp)
     }
 
     ee->mem = g_malloc0(ee->rsize);
-    memset(ee->mem, 0, ee->rsize);
 
     if (ee->init_rom) {
         memcpy(ee->mem, ee->init_rom, MIN(ee->init_rom_size, ee->rsize));
-- 
2.47.1


