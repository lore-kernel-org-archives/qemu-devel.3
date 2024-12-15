Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68B11E77186
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:09:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtwO-0001HT-Ij; Sun, 15 Dec 2024 14:06:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwF-0001GY-FJ
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:02 -0500
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwD-00011W-JV
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:05:58 -0500
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5f32de85789so1034447eaf.0
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289556; x=1734894356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LkTIOJvxAZpwekaMnF4W9WKYdFapWxP/f2wAmpMVyBY=;
 b=PseLGHiWshvw8/qw0OC5u2R9P3MXXMNvzPRoqllMe44DGX8re6x6worPDJ6TKCa6pU
 kNZT+il9Y//tyPFILontTfltkblbF9WaUqIoi0qoAk9in+ZOQf7B/T+OGFFPeTseirgW
 1CQ7pEMAzjEDr+kMFZ0SIjJFfU9uLpwSe79jACS8ZXyhFVYkSJuhGN0XVybcI+mLVnUt
 uPpYRdTWdLcOPjC9r73/Sj88ndKmzYBkxX9OHC+JALqnqJ5ER9dE7gVmhajxD7Q82wU9
 eiNc64alMPw9NGfrsxGTFKkU4YnXECKjbSLjVcuP/sYIZy94DW1ZfSjjZoMOuZBJn7kZ
 Fiow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289556; x=1734894356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LkTIOJvxAZpwekaMnF4W9WKYdFapWxP/f2wAmpMVyBY=;
 b=RXpb28Mv/F4+Zq/E8ZbHW5DerjngpI9dL3ehA1W4zS//1cYMdkGxhND9x08sk3Lhow
 ZOUmufVPqQQGNmJoO8JAbOm2BwC2JkbizkvfqNAxzGLJDzPSg/Nj3bxf0+6rIUneRkqM
 ZLZDlxlA8jSEXr5SOHNczw4TA29saXUulNNZqzKLzAyNAJKugPfgCgWc6/RVlT0NYMUE
 WuJa8DrYg11FkkA8p+DVR5JdoSSVIBoieEENZJbx0ZpGrV7IikuaoCuiCtmQHa1wuXQ9
 3dqWyZi6Vo53d4+jjaskdz8R0g0e1KtabPaL+Eg9RVAG+MUK9pIsvLo1VLyDPi6l4ex/
 ewrw==
X-Gm-Message-State: AOJu0Yxe02NzTBPVwVB5+UVYArgtdipr/32MhsIHeomO076FAK1nUdyf
 zFl6pMFeokjtnJvgm3GBRJTopIgsu8VKKowZo92ki0UUS8rTj7lM1Yjv2k3hkd9zASho9SEPXR6
 IAzeGqUoM
X-Gm-Gg: ASbGncumCUoTgHRONalENsFFqK1q1VX8g1qK0aKUr3wMEL3LZ5VPpqZWAJVIeEZKL6z
 0DZ3yqJQl2oOiTsUak2Fms7HrCgCERa+DT032sxmZK6CQ7cd8N/wQECm9hVh6hkMfHo9D1mAYLY
 MCzG9FSq1Irngmyi/DFjGnXyWZIGEkDFlS8aXdrIR31h/CQHr9BkN66k+O3DBt33HSfa9ZimFss
 u0ACBpsTxYVmMGmUt+BScTTgbutbvmH1DawuTW69YfsOPiA+uDtkEjtm13TgGDHNGu5eQXva+ZX
 ow4ndNvL8BB6bXg4OwcOjpcDmekWu1AkTBCnn54um6s=
X-Google-Smtp-Source: AGHT+IG+M/6zhR5loTcSQyWHKz/7wp55zlbqX0+AJWOLJMWgv8xroVuI7zcQvV8TRc4azMLn6CqcBg==
X-Received: by 2002:a05:6870:d114:b0:29e:7629:1466 with SMTP id
 586e51a60fabf-2a385335461mr7476534fac.7.1734289556543; 
 Sun, 15 Dec 2024 11:05:56 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:05:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/67] hw/acpi: Constify all Property
Date: Sun, 15 Dec 2024 13:04:38 -0600
Message-ID: <20241215190533.3222854-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc31.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/acpi/erst.c                 | 2 +-
 hw/acpi/generic_event_device.c | 2 +-
 hw/acpi/piix4.c                | 2 +-
 hw/acpi/vmgenid.c              | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/acpi/erst.c b/hw/acpi/erst.c
index a108cfe49b..5ef5ddccb6 100644
--- a/hw/acpi/erst.c
+++ b/hw/acpi/erst.c
@@ -1011,7 +1011,7 @@ static void erst_reset(DeviceState *dev)
     trace_acpi_erst_reset_out(le32_to_cpu(s->header->record_count));
 }
 
-static Property erst_properties[] = {
+static const Property erst_properties[] = {
     DEFINE_PROP_LINK(ACPI_ERST_MEMDEV_PROP, ERSTDeviceState, hostmem,
                      TYPE_MEMORY_BACKEND, HostMemoryBackend *),
     DEFINE_PROP_UINT32(ACPI_ERST_RECORD_SIZE_PROP, ERSTDeviceState,
diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
index 663d9cb093..8c4706f8cf 100644
--- a/hw/acpi/generic_event_device.c
+++ b/hw/acpi/generic_event_device.c
@@ -316,7 +316,7 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
     qemu_irq_pulse(s->irq);
 }
 
-static Property acpi_ged_properties[] = {
+static const Property acpi_ged_properties[] = {
     DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 1de3fe3261..2bfaf5a38d 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -602,7 +602,7 @@ static void piix4_send_gpe(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
     acpi_send_gpe_event(&s->ar, s->irq, ev);
 }
 
-static Property piix4_pm_properties[] = {
+static const Property piix4_pm_properties[] = {
     DEFINE_PROP_UINT32("smb_io_base", PIIX4PMState, smb_io_base, 0),
     DEFINE_PROP_UINT8(ACPI_PM_PROP_S3_DISABLED, PIIX4PMState, disable_s3, 0),
     DEFINE_PROP_UINT8(ACPI_PM_PROP_S4_DISABLED, PIIX4PMState, disable_s4, 0),
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index e63c8af4c3..9c2ca85cc7 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -214,7 +214,7 @@ static void vmgenid_realize(DeviceState *dev, Error **errp)
     vmgenid_update_guest(vms);
 }
 
-static Property vmgenid_device_properties[] = {
+static const Property vmgenid_device_properties[] = {
     DEFINE_PROP_UUID(VMGENID_GUID, VmGenIdState, guid),
     DEFINE_PROP_END_OF_LIST(),
 };
-- 
2.43.0


