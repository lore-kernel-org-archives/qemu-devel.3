Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D98BC282D0
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 01:36:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpdWu-0006q4-CW; Tue, 04 Mar 2025 20:26:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdVe-0004Tl-4Y
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:25:21 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tpdVR-0007L4-PK
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 20:25:07 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-43bc63876f1so21515215e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 17:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741137904; x=1741742704; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fBKaSdciz4vWObThuGuztLYugPKsPiaANZDROnbbSag=;
 b=f7vv46wcHJziPk1i4fP4WQSugpG4FTyl9MJLFjIT6RldKP+9D+hR4iNDQiChuhYU5b
 HmeBgZJGfr5yVtB7tp5HRSPF6E6pbG9Wk4dAqm1EPa0p/xq9hx1pbSKAkY4YXTSe5bEQ
 9oLzdpYsX7J3f5U4XUD/z5XLWgicfiy1SnmfJIlNLFjQdu/FSrT9sdtnaD30RzvuTtun
 6IZpQ4TXIKTUg6mWPJZtw7ca3xrlr/f2eS/44iz6caiL8g1rMPMiww0E4dvs4UcX5cHE
 uZQ1LJyfGesYg5rG7IHXT2S0gVOk1gJ4zgeDN2v1P/z3lZPJOiK0D+kRLLJ6o+pbWpun
 h83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741137904; x=1741742704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fBKaSdciz4vWObThuGuztLYugPKsPiaANZDROnbbSag=;
 b=iwJKyfHpIyHLGqbAPljtcoD54adWUuxbMALsZXOHdu9asITN+Q1KXDcLG50wIwbiOQ
 YaSW9Ir1Ar+mzN5FJzSVXSMeOZ4DU+4FVi8Lvadzqm5QsRy+E5kH8dfFUJo7BkO7LHeW
 BBZFUR9Ij5y84UP86hRfld6T0QrQdFSZq1nvpsvX2PraJpo81ghL6io6X4WEG8Erqr6S
 uFH6g9i71JWgJOFvm/aYS8TQJeDXCZ2n+XkSX5MimiMStFMHH1SL/fcp7x9ZoyHiD6tX
 ktSTTjMTsb+3/YIChEbqihuCWIdTryoQRj9MF1gmwX9KWqXNBamgt7UWtTOr4WzThFb6
 x56w==
X-Gm-Message-State: AOJu0YzjUANriqBBOxxp/yLB314jlIcOAypx98xFASU3nru5bmzn6QF5
 eyu7fRP9qG00UQ7ZPcoAGyMm3YT6b/yQ4uXwtK0jsrqzsQu9NtTkNmhR6bGi9dutUQ2p4wTrN56
 GU48=
X-Gm-Gg: ASbGnctRwGtVAtgiTl+/2w+sIweKKqxVLpMBXepVCwU/98S9uDjNeelBSTxaQf6eT1V
 6kImeaFzBnGy1iBANJgXaYU2bumjrLAs4IuZscZv119vX9dNHKfGA9xOT1y8+9UYnjcH5cMq6Zf
 1zo74UbEhLt8KzMi2Rd92Pn+geIaFVbWid7rnvepshmeW2IiKAs8bSRJeCwDPRvcByv+WCsO7g8
 zo9z4frXHwcd0ETfAie/gkaE+Izyyn8oYchYlycTUwf4FEBCR0Ohk7IWpyUebyLc+FjlfW7fmlS
 oESVaeiKwbumUIuV3Y3WCmumPJCeN1m7VriDk9a/Kzg5v3KSkRL1DZlcyUsDeC7P4ocqkQTIL6I
 DfE5nPVkdfMpV8OJ/mOQ=
X-Google-Smtp-Source: AGHT+IGQlstr4QKzVtgWdZq8j7qDheTdAWqwVZT6dBgKI8NoqRkvrhgRtkXpntsEVCd8+Y0mzmW8gA==
X-Received: by 2002:a5d:64a6:0:b0:390:eb32:3fd2 with SMTP id
 ffacd0b85a97d-3911f57cc31mr912485f8f.0.1741137903706; 
 Tue, 04 Mar 2025 17:25:03 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390e4795983sm19153614f8f.6.2025.03.04.17.25.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Mar 2025 17:25:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 38/41] hw/nvram/eeprom_at24c: Use OBJECT_DECLARE_SIMPLE_TYPE
Date: Wed,  5 Mar 2025 02:21:53 +0100
Message-ID: <20250305012157.96463-39-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250305012157.96463-1-philmd@linaro.org>
References: <20250305012157.96463-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

No need to open code it so use the simple object type declaration.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <08d9900af04789ede485942c8072eaa58bf52f80.1740839457.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/nvram/eeprom_at24c.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/nvram/eeprom_at24c.c b/hw/nvram/eeprom_at24c.c
index a40cc5dd15a..2ae03935d47 100644
--- a/hw/nvram/eeprom_at24c.c
+++ b/hw/nvram/eeprom_at24c.c
@@ -30,9 +30,7 @@
                             ## __VA_ARGS__)
 
 #define TYPE_AT24C_EE "at24c-eeprom"
-typedef struct EEPROMState EEPROMState;
-DECLARE_INSTANCE_CHECKER(EEPROMState, AT24C_EE,
-                         TYPE_AT24C_EE)
+OBJECT_DECLARE_SIMPLE_TYPE(EEPROMState, AT24C_EE)
 
 struct EEPROMState {
     I2CSlave parent_obj;
-- 
2.47.1


