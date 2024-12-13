Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5E9E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:14:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB4K-0007DZ-8l; Fri, 13 Dec 2024 14:11:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB3m-00065T-LA
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:10:47 -0500
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB3f-00075C-GX
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:10:46 -0500
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-29e70c9dc72so1004749fac.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117038; x=1734721838; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Z1t6swvy8upy2Om0CJmkfNPeZpdljfu+4C2dIJjYZg=;
 b=SVvyCLQzy8LfC2/DSkjt92EKLvHQu5cSpIcsulwgGj367bUsm029tJi0ub3P5wpNiZ
 Tji35/1NSwY4cX7d9l/5PQeE5Dnd75wE4kHdluNVDpGOnjcbXxRz4erreFlmucndRx4L
 jb+dxOj6FibBWsDCX2bHgwgHF94VOJGIt6GJtsRbCtXYBEzd4MYBRAS0kovRD6HONjUa
 vSlNslhGiW8tdRFbOFbS0xX9+5KLdf6B+PTWdMGPX2/Kz64iqqwvW63cK2jOk6L3hlPp
 +SXXg7VmE3jFe8zR59EXXvWrZA4nIPcfmscVIEy6AOWtwBvBYEGcoqFjfTTRQObOEMV2
 FBYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117038; x=1734721838;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Z1t6swvy8upy2Om0CJmkfNPeZpdljfu+4C2dIJjYZg=;
 b=pHpDYHa831hbCNf/jOZ9l0svYLWItnogMbeYs/s4+D0CxbwgjXtx8voSQc+9cKWy9+
 ZIz1H0jhk2MKdDlWIvu4XKqPSuC8JbM3Jc2n4fTo5MMEk4f9o0K7n6G+tjMFpgurMA+6
 omDGfVMF4K2YqQ9zjuHrzjUDtnL6xOX+aRlURTspK7UAVLHuc5EOS/6iPtXZ/PZUOjym
 nxyuLD0intUmR9m/06Afyy6Itn/AB6hbYSf0r5ks5kf6kecLGtD2hs1TLEsBDEixYY6L
 7pmGPVCETPn6nH+0xksTw8sirtYKZEQarofpZZO4XrNBCz/jf4ZQqev7ylrXTFZEMlYt
 i5nA==
X-Gm-Message-State: AOJu0Yw4jxUS6FypZ4nEU6exTyWJ9E91JUK7RZc/b6HneSPBh+5ghciX
 rzLIU1ZFmw3YKsj+ZOvku0hYCBOFV4Dw/bp5SAKiHZgQj4GOQiIK1f0+YcwX/wd0mLd6fZtrmaF
 M9l/WIzUh
X-Gm-Gg: ASbGnctZaWNwXh2sP3UoZ+nSk+HR0t6RQrfKgvwsM3jDfaUNIjgdX6VolebU42+RDXo
 SRuupw/Kuvi93G7FAy0eiXtqQHURYfK1Xp/MXLdBm0AUY+A33OqStefkVAZz7BZrqfhx88vMXED
 SCISd6ak7SgSmcl1whXs/ubmGKVPZUzaC1nA2OQ6RkSCGvAwFXWqW8J5p7gXBy5Z5m1Hqh2vZ0D
 4ennwabhM0Q9OOfANfws63qQ/xrSBYBxZL6bDkBoeFJvlS7ZYcibZuFXCyy30qZ
X-Google-Smtp-Source: AGHT+IErEgP61IwTRTJFasMINfOwcin5JaD/wnc6zj1SxLqPM3lk1vUEGmZAClPD5bTMVFMju9FdEQ==
X-Received: by 2002:a05:6808:189e:b0:3eb:5d3a:5b20 with SMTP id
 5614622812f47-3eba67f5459mr2225644b6e.4.1734117038116; 
 Fri, 13 Dec 2024 11:10:38 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:10:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>, qemu-ppc@nongnu.org (open list:PReP)
Subject: [PATCH 35/71] hw/isa: Constify all Property
Date: Fri, 13 Dec 2024 13:07:09 -0600
Message-ID: <20241213190750.2513964-40-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/isa/lpc_ich9.c | 2 +-
 hw/isa/pc87312.c  | 2 +-
 hw/isa/piix.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index dabd1217dd..378244aa8f 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -826,7 +826,7 @@ static const VMStateDescription vmstate_ich9_lpc = {
     }
 };
 
-static Property ich9_lpc_properties[] = {
+static const Property ich9_lpc_properties[] = {
     DEFINE_PROP_BOOL("noreboot", ICH9LPCState, pin_strap.spkr_hi, false),
     DEFINE_PROP_BOOL("smm-compat", ICH9LPCState, pm.smm_compat, false),
     DEFINE_PROP_BOOL("smm-enabled", ICH9LPCState, pm.smm_enabled, false),
diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
index f67155498d..7bb2af817d 100644
--- a/hw/isa/pc87312.c
+++ b/hw/isa/pc87312.c
@@ -327,7 +327,7 @@ static const VMStateDescription vmstate_pc87312 = {
     }
 };
 
-static Property pc87312_properties[] = {
+static const Property pc87312_properties[] = {
     DEFINE_PROP_UINT16("iobase", PC87312State, iobase, 0x398),
     DEFINE_PROP_UINT8("config", PC87312State, config, 1),
     DEFINE_PROP_END_OF_LIST()
diff --git a/hw/isa/piix.c b/hw/isa/piix.c
index b4a402f61b..8ec9c63b8a 100644
--- a/hw/isa/piix.c
+++ b/hw/isa/piix.c
@@ -408,7 +408,7 @@ static void pci_piix_init(Object *obj)
     object_initialize_child(obj, "rtc", &d->rtc, TYPE_MC146818_RTC);
 }
 
-static Property pci_piix_props[] = {
+static const Property pci_piix_props[] = {
     DEFINE_PROP_UINT32("smb_io_base", PIIXState, smb_io_base, 0),
     DEFINE_PROP_BOOL("has-acpi", PIIXState, has_acpi, true),
     DEFINE_PROP_BOOL("has-pic", PIIXState, has_pic, true),
-- 
2.43.0


