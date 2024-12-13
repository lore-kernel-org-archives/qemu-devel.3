Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D14EE77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:14:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB2K-0003JR-4N; Fri, 13 Dec 2024 14:09:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB1x-0002WZ-1M
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:08:58 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB1u-0006a7-8N
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:08:52 -0500
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-71e3cbd0583so199163a34.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734116928; x=1734721728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CZ5o+wK3lUFPQSBeOoH6IwFw54AejBcTfhRb5vaU2tQ=;
 b=AreI7Tk7bteZVfF/PRMFP3SBQqw8UQDACiChUJNVR6gtASVMIpmjKKR2vwKo8buQkP
 7LynT9Ene+GbMe4fwIcUjbfSfL0ZEjbQnpYwlOcEv4tlkaufXoyAJh5NkK7XEy3bYtmy
 FFDfOM9PpgbnYXDwhtAaMaPduRGyta14zFqvgrafy0vHyosprfaGHvks6b/Z3N9GCKst
 ZLeRVc043ZzxE24hhkrRBiWpNaNng5yMOP5bJ8IeE5n9lVvzUlnYmlv1F8+XLgvRLfFZ
 H6FYTqAuXx0LO3eLyxKO+0o4822tDgJX0cOfgOF35mChQlZOW61MEcPR7gNT19wIJheb
 wR8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734116928; x=1734721728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CZ5o+wK3lUFPQSBeOoH6IwFw54AejBcTfhRb5vaU2tQ=;
 b=M7YeSP3bxG+sb6tuKEuTkZ5aRHrs9olWvx7g68nAqoQiwiFlV9gij4ROzNMWr9i35S
 I4Xc7qY4jw7djbKqtGWuHsVq8J1jQFzDNVGI736anylfNTxPAUjI9rLyfAhXHybJeE/G
 8wRzKYFv50EWJmizoxLPrkmSxJuzPAsf96jMCaQjaV7v43Ea/ZeBYfyMka8CimA8DK22
 ZQCsngjAfscSJeuf7JXDUNDrwClkIjuw5wEtewhsgZ9aBpzWVTUFOrE2oSieJkG6Ylxi
 YYDfeYTroABH5G/75JojXllu6ojIxaOfVrz1Ia+Mk8DJfllveJbzqDhevBPeyH2Lez6y
 47ew==
X-Gm-Message-State: AOJu0YwnVn+Rm3LtB4f0BU+6n5/DPIt3SwfbqSK5VfTBIAZq9YEgIuS6
 vOgW5w9Nj749Qi1TE7aMFApkx/LpsggSPVfzHrcLCG7DSk9SnxFVSXmsVxhD74KOk/13p99VKPx
 cRgRsgeh3
X-Gm-Gg: ASbGncs2D4OwyXzEdKF0eEyutNC9yU7VYpjCGnubl+CVZYS0pXlak0RuaUORH/HBkUq
 zocJSA2OPxn0etxsuhaGVKz/NEVkUtLqNIlTzFfoTE4fqWP5R1JDSyrGcxJFyfD+DwSndcAbeNv
 3B8mehTfDREfvSc7xpoIa4J7iCmP18K6T+q/pUmAnP1TPCioqqrNd9carWZ8RrsVS9TMFKeFI5g
 wk8wGXuJAlN9yHcaWqibXwKLY70nMwWjPyfZpvcxkzsOUnoftcklQ2UHQYWS34k
X-Google-Smtp-Source: AGHT+IHOJPtgViTttcUfFvw76b0ckdZVIlX7g224egEIPf3HEZnH2BdQAgE5qOd2b9N2tJT77qrnzg==
X-Received: by 2002:a05:6830:917:b0:718:1163:ef8f with SMTP id
 46e09a7af769-71e3b812c59mr2293190a34.2.1734116928405; 
 Fri, 13 Dec 2024 11:08:48 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.08.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:08:48 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH 13/71] hw/acpi: Constify all Property
Date: Fri, 13 Dec 2024 13:06:47 -0600
Message-ID: <20241213190750.2513964-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32d.google.com
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


