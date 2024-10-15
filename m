Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A3BBD1D88B
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 16:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0kWI-0005Ma-Dt; Tue, 15 Oct 2024 12:35:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1t0kWH-0005M8-4O
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 12:35:37 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1t0kWF-0007i4-HO
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 12:35:36 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43140a2f7f7so7649575e9.1
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 09:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729010133; x=1729614933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=riqLFRDWkesQT/W0Iiem1Vzb+jwMJPKQExBYDSJSEQ4=;
 b=nWqpjkiinKr+qZL+WgyhpuvBG2sYqV14tmfitlcoT9VHOrCtgBdKqfN+S0CiFzI2ey
 2zzsoCTv0Ub1GPyVkHSSQ849loWx5AvW7mYi4f15WEA0y712OTf831j8AuUG0SIELiKt
 zn6XnsZ0SwCal0Q9J+iew8drelwIQzd7s4UUm72khff3mglTeBTJFJhYKjpOdzGNMq+J
 WNOham0wj++NBWFqez3cMNk0EerDO0rcEWa3yOrLuljfQVtgnncb9YTq9AqoFXKOxZyI
 YWfl2yyEkUxYS9GUCB4yZvm3ekX/XQT6SAbxq+VSHQxQdv0R4nmGZMsE5S0f/upjMcVR
 fFew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729010133; x=1729614933;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=riqLFRDWkesQT/W0Iiem1Vzb+jwMJPKQExBYDSJSEQ4=;
 b=KvAxG2KxwiwQhMPPW070xLamdJsBId/5TZNCygL1BMixno75n8Rurf/td1I9dDyo5y
 sM5t/Tz/fdulgJSYmZjpheX/yxumjVwcxirGPRqwfTtjR/7qYFyGM7Ek0ANQyfPDZYaV
 1G5qRXboYEAQdr88eedmJHQjF4WiOIxyel4y2kgOilxzk30DloQ0aXTwYNCqgyMnZ4T/
 3Lx3vhUjjqZ0XjdrkpuXWdw0rLmi6SNaXViZQuq1mSiCp3VdFrZU9pHCB1t4XkqVA2t2
 hErfesBaTqySESHoero0ZfjWbEPYnixO/Q19ZMh07W/fTbDenWAJPDZk3dY89EqehUUa
 bKxQ==
X-Gm-Message-State: AOJu0YwP2jXC7tEQL69dByWB7LlUO3p17y6RXUdNGkRFBPuAXAFFs+n4
 ISWyflx/Nh6skS3i90FO/UZJu2wy7nCLQVEhXrJTMDD5dovu9lguy+XJ5A==
X-Google-Smtp-Source: AGHT+IE1UYa74d4h4g79bBTJ+crFTluoOKihDnma9fGBf0oxHv/4dIFOejzk8OotTn3/j2uTQPNzOA==
X-Received: by 2002:a05:600c:6745:b0:431:40ca:ce6e with SMTP id
 5b1f17b1804b1-4314a3acc32mr10074245e9.31.1729010133230; 
 Tue, 15 Oct 2024 09:35:33 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-077-183-076-057.77.183.pool.telefonica.de.
 [77.183.76.57]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4313f56eb0bsm22371755e9.22.2024.10.15.09.35.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Oct 2024 09:35:32 -0700 (PDT)
Date: Tue, 15 Oct 2024 16:35:29 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Gustavo Romero <gustavo.romero@linaro.org>
CC: gustavo.romero@linaro.org
Subject: Re: [PATCH] hw/acpi/acpi_dev_interface: Clean up remains of madt_cpu
In-Reply-To: <20241015140957.385491-1-gustavo.romero@linaro.org>
References: <20241015140957.385491-1-gustavo.romero@linaro.org>
Message-ID: <758C079D-C43E-495C-9689-5CE874EE3241@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 15=2E Oktober 2024 14:09:57 UTC schrieb Gustavo Romero <gustavo=2Eromer=
o@linaro=2Eorg>:
>Commit c461f3e382 ("Remove now unused madt_cpu virtual method") removed
>madt_cpu virtual method but didn't remove the text about it in the
>header file=2E Thus, remove it now=2E
>
>Signed-off-by: Gustavo Romero <gustavo=2Eromero@linaro=2Eorg>
>---
> include/hw/acpi/acpi_dev_interface=2Eh | 4 ----
> 1 file changed, 4 deletions(-)
>
>diff --git a/include/hw/acpi/acpi_dev_interface=2Eh b/include/hw/acpi/acp=
i_dev_interface=2Eh
>index 68d9d15f50=2E=2E2f5ab5c1b1 100644
>--- a/include/hw/acpi/acpi_dev_interface=2Eh
>+++ b/include/hw/acpi/acpi_dev_interface=2Eh
>@@ -34,10 +34,6 @@ void acpi_send_event(DeviceState *dev, AcpiEventStatus=
Bits event);
>  * ospm_status: returns status of ACPI device objects, reported
>  *              via _OST method if device supports it=2E
>  * send_event: inject a specified event into guest
>- * madt_cpu: fills @entry with Interrupt Controller Structure
>- *           for CPU indexed by @uid in @apic_ids array,
>- *           returned structure types are:
>- *           0 - Local APIC, 9 - Local x2APIC, 0xB - GICC
>  *
>  * Interface is designed for providing unified interface
>  * to generic ACPI functionality that could be used without

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>


