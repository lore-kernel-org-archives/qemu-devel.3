Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 325E3C30658
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2024 09:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOZhv-00018E-Ck; Tue, 02 Jul 2024 05:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZhq-00017Z-VL
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:21:48 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOZhm-0006RG-Oz
 for qemu-devel@nongnu.org; Tue, 02 Jul 2024 05:21:45 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2ebeefb9a7fso44908401fa.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jul 2024 02:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719912101; x=1720516901; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YMu0JsqJ0+r4fsG0B6FCI0Tvxg5Vyf5673gOlduh3A4=;
 b=jQYZFj+uVo+5j4n/xXlgwk41bH0Yj23Og0CzQMTuLa9jqGSwWlhrfkoATlGfkms/jf
 r4xx3XGGz4imNC04eUni6RytnCyL/RGxvJgVShygZNw0pIsk+lAgn4LTSFvgVNV3I08u
 ImAulvZWhNoDFlRXk96qMd/DimPrHZazPu/jnJjhccBi8jUfcN8jlRkBot4JWdqa7509
 /BK1342PINeN9xA0utQio1kxct2A/ubOxamf5+oVPq9ZKdKXCt2UDOOF8I/EMeZw8ZiU
 B0o2dCisBnn4k+vOGjUvn0tb7CEFMyahNkDATWTJRwITSt3l54zCMapcD18K2jmnnLcA
 TEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719912101; x=1720516901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YMu0JsqJ0+r4fsG0B6FCI0Tvxg5Vyf5673gOlduh3A4=;
 b=gC8pk/ewTYHH2b01ATZ3BoCN++R2BtfpsL7D1tpVWiLbIRfBEcB08pVpP+NrLW0A1U
 jLpXOE1bgCaUMkgE0uM1IUjj9iwt0faocRLS5CbUKk5v016aUZCb3S4Z1nBtHqgQ3urR
 z8BpRC3fk3loaiJjIPqlZBP0ZJic62/8PgscPjFmtbjtgR4jN4xSH12t7qKgSJL60eiZ
 LZxix16HNx8+7VoajyAq7xMMCpIYf5HTX6b+hrzwwLfvDF5TaL0qDIlrjyRI4qvnNjZA
 2Ed2FkIIy6gyQcSCp37njwFphzA0FrmWjGcoTQJpcJopZ4boK21WDR2dfaM2S2K3bXHW
 wXhQ==
X-Gm-Message-State: AOJu0YxmJZc9UVLZ3be8PiN6JWGu0xBtwzlXjF9UX0AI3GrV1EKx7b0z
 fJjVIOaqgxgNOzO5MdiOlDm1IgyHYK1JbHX/koYJD/ATNADQSNvTRDwaW1/cAVrD/Tg1IzHs/hl
 Z
X-Google-Smtp-Source: AGHT+IGTFyBDZeJPw+gvfFHQBWO49c5VRJeaK2/vCzHi8dXwV7K2qqIFzsbKrFaSgYtqTDn5VYU+lw==
X-Received: by 2002:a2e:9dd4:0:b0:2ec:4e59:a3de with SMTP id
 38308e7fff4ca-2ee5e3811eemr50130121fa.10.1719912100813; 
 Tue, 02 Jul 2024 02:21:40 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.209.58])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257c4e10d6sm117669665e9.30.2024.07.02.02.21.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Jul 2024 02:21:40 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 08/67] hw/sd/sdcard: Use READY_FOR_DATA definition instead of
 magic value
Date: Tue,  2 Jul 2024 11:19:51 +0200
Message-ID: <20240702092051.45754-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240702092051.45754-1-philmd@linaro.org>
References: <20240702092051.45754-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22f.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Message-Id: <20240628070216.92609-10-philmd@linaro.org>
---
 hw/sd/sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 54bb0ff1c9..04ca895645 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -559,7 +559,7 @@ FIELD(CSR, OUT_OF_RANGE,               31,  1)
 
 static void sd_set_cardstatus(SDState *sd)
 {
-    sd->card_status = 0x00000100;
+    sd->card_status = READY_FOR_DATA;
 }
 
 static void sd_set_sdstatus(SDState *sd)
-- 
2.41.0


