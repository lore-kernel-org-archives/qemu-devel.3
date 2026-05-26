Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE91CD5BD2
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsVP-0002ZR-TX; Tue, 26 May 2026 10:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wRsVO-0002ZG-On
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:11:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wRsVM-0003pb-6P
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:11:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779804694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VjZX+fvkTp1huSeLjS2B6u9Smx9ekUJsPEt5bh6hUpI=;
 b=WDlAgBYMdC0hRz5jJRJOaqUGVADwVYoXYzxKINufU4fAfDbBgqu34/SJIt5+wE989jy6qh
 JCcVxTKLwdMbB/1gmOQMkbrKT7VShP4NN6btjlMQfjiQNsvOSXvk3fkOthG4edj9t6G4g5
 kAlj7XjYBRInAWaSZouDtVZhuSQx4t4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-cW_EnbQqPFG9-5XxZLZ3cQ-1; Tue, 26 May 2026 10:11:30 -0400
X-MC-Unique: cW_EnbQqPFG9-5XxZLZ3cQ-1
X-Mimecast-MFC-AGG-ID: cW_EnbQqPFG9-5XxZLZ3cQ_1779804689
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4411a36715dso6926978f8f.2
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779804689; x=1780409489; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VjZX+fvkTp1huSeLjS2B6u9Smx9ekUJsPEt5bh6hUpI=;
 b=FuR14nm3WuNqjTD1pa5Pq7top8fRw2+lJ/04W0WNBZ4ryASiF6h74NrFVjfbrF66in
 eERoBkEDri8R/yHwBq2AoSkBX69V+b3IjFAk1Fm0c9pDCl9b0Z9UtVwjiBwHr91NkUwi
 7IgcJtZS5wTFlbCZDbUOYrQmNTGrNCW37DFbNwlB3rTZCCVJmWJfAsDhcc2y+/cL574M
 rqk6yK71SagAdmZBCBd3TX7SnJtmJFTf0Bbi/kC6d6kIPPt2MFVzSFDspeSX6TottqRA
 lgoqbUwWm9Q59XDvJl+FGfXMsP9mc6K7LLL/EFGKXOkqZKBo6YS0TdQ1GB4ZYP35Ns3P
 31tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779804689; x=1780409489;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VjZX+fvkTp1huSeLjS2B6u9Smx9ekUJsPEt5bh6hUpI=;
 b=aWG2WvaajLqH97admM34hnMWQS0/H1w4HAbDC3/UVyxeqpue63vi20uqA+mKBp1MW4
 Lg7EqTe2AquB0I2LWibDSYNd3A/dviqW53Qlns7ZedknHs1L65oiNosjddIu06lUfppn
 3y6TcBeFEIuOEPpmwBM2FfUbSzq3HK+511W7Kx0q5u2/yuGEN9ZsgshCwkTJzlHakAeU
 3fzAZk7ogyNJCilxrHTywfwHsD/Z0IDIicn2T0qRNPVtastN4vGF8LY2/aVVR+A8MOWk
 e6urJiH+QqPrjJtnHq2peBWku25xk4hnRDFoYilKv+UQUwNXuNS0Xz5z1/qvOvTlWgC7
 Y4mg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/L95uB3HwkyHahnHwoNbwkAVmWgG0DfqbGbKm9Zsc6YzP3ncua2mSWtznyadGzpr3m4ww2gL2yEBux@nongnu.org
X-Gm-Message-State: AOJu0YzbGJMdoAYgKBpkLJgrLQQ2Nj9bdRDdFNmfdQw/G+vFI5AhLULs
 TOrjuYca+5UjuC55Eh2LrM0V/JC0Ezw2UWTJT8BxCYVw42HJsZOFznSpfXFCjmzinQzifO3uY7X
 A0Labs7DZhGcYfr447zttZj8gwGhtEnagne+DOvonp+UF3rD8G0wkBrdi
X-Gm-Gg: Acq92OFAy+6rKIaGHAMRxE0KswzkXgwpclWUZKodZJKHAQeOiOXBLfGSIckhrs5cbOh
 RTKLiirHkkec9RKNUPrO3JDKSnfgFgfVqf9bwdPjpuvhPW9MzlIcxDMtpdNBzwcl8WXvqqQUIoJ
 AQ/E6puEE91RLo1zLOk2QHkpzqECD9ChfQsOPNiOR6FJlsR5z5K1ZHjQ/njTjege28S8dI/aTKx
 F1O34j0qnBDFcCft4CSDKGdAHTQmRhfJpprfdS4qWTSYdWgOxwsS5cRAmR5v+Q+lVt3iOYpr3rR
 DCtPWJd+h8pBGyIKWjLF9CwvHdNUmeUlZeg8lN8WxDWk53xPPI4NMEAvtXbE5hXpX5mwYmQQr1x
 c+vmbhSyOmdlBAOBaSpO4E1Z6H48sabl3XULc6amo+iC1ZsFtGREGCLlYSjI9Q8/X
X-Received: by 2002:a05:6000:1acb:b0:45d:b14b:2409 with SMTP id
 ffacd0b85a97d-45eb38a798dmr35514311f8f.2.1779804688720; 
 Tue, 26 May 2026 07:11:28 -0700 (PDT)
X-Received: by 2002:a05:6000:1acb:b0:45d:b14b:2409 with SMTP id
 ffacd0b85a97d-45eb38a798dmr35514194f8f.2.1779804688015; 
 Tue, 26 May 2026 07:11:28 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d5c32esm34704737f8f.26.2026.05.26.07.11.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 07:11:27 -0700 (PDT)
Message-ID: <24184b07-2ba4-4bc4-a73f-084f0e4719ab@redhat.com>
Date: Tue, 26 May 2026 16:11:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/21] acpi: add API to build WDAT instructions
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
References: <20260303092532.2410177-1-imammedo@redhat.com>
 <20260303092532.2410177-2-imammedo@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20260303092532.2410177-2-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 3/3/26 10:25 AM, Igor Mammedov wrote:
> Add definitions for WDAT[1] actions/instructions
> and build_append_wdat_ins() API to build table entries.
> 
> 1)
> "Hardware Watchdog Timers Design Specification"
>   https://uefi.org/acpi 'Watchdog Action Table (WDAT)'
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Ani Sinha <anisinha@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  include/hw/acpi/wdat.h | 118 +++++++++++++++++++++++++++++++++++++++++
>  hw/acpi/aml-build.c    |  14 +++++
>  2 files changed, 132 insertions(+)
>  create mode 100644 include/hw/acpi/wdat.h
> 
> diff --git a/include/hw/acpi/wdat.h b/include/hw/acpi/wdat.h
> new file mode 100644
> index 0000000000..89803eef4b
> --- /dev/null
> +++ b/include/hw/acpi/wdat.h
> @@ -0,0 +1,118 @@
> +/*
> + * Watchdog Action Table (WDAT) definitions
> + *
> + * Copyright Red Hat, Inc. 2026
> + * Author(s): Igor Mammedov <imammedo@redhat.com>
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +#ifndef QEMU_HW_ACPI_WDAT_H
> +#define QEMU_HW_ACPI_WDAT_H
> +
> +#include "hw/acpi/acpi-defs.h"
> +
> +/*
> + * Watchdog actions as described in
> + *  "Hardware Watchdog Timers Design Specification"
> + * for link to spec see https://uefi.org/acpi
> + *     'Watchdog Action Table (WDAT)'
> + */
> +typedef enum {
> +    /*
> +     * Restarts the watchdog timer's countdown. This action is
> +     * required.
> +     */
> +    WDAT_ACTION_RESET = 0x1,
> +    /*
> +     * Returns the current countdown value of the watchdog hardware
> +     * (in count intervals).
> +     */
> +    WDAT_ACTION_QUERY_CURRENT_COUNTDOWN_PERIOD = 0x4,
> +    /*
> +     * Returns the countdown value the watchdog hardware is
> +     * configured to use when reset (in count intervals).
> +     */
> +    WDAT_ACTION_QUERY_COUNTDOWN_PERIOD = 0x5,
> +    /*
> +     * Sets the countdown value (in count intervals) to be used when
> +     * the watchdog timer is reset. This action is required if
> +     * WDAT_ACTION_RESET does not explicitly write a new
> +     * countdown value to a register during a reset. Otherwise, this
> +     * action is optional.
> +     */
> +    WDAT_ACTION_SET_COUNTDOWN_PERIOD = 0x6,
> +    /*
> +     * Determines if the watchdog hardware is currently in enabled/
> +     * running state. The same result must occur when performed from
> +     * both from enabled/stopped state and enabled/running state. If
> +     * the watchdog hardware is disabled, results are indeterminate.
> +     * This action is required.
> +     */
> +    WDAT_ACTION_QUERY_RUNNING_STATE = 0x8,
> +    /*
> +     * Starts the watchdog, if not already in running state. If the
> +     * watchdog hardware is disabled, results are indeterminate.
> +     * This action is required.
> +     */
> +    WDAT_ACTION_SET_RUNNING_STATE = 0x9,
> +    /*
> +     * Determines if the watchdog hardware is currently in enabled/
> +     * stopped state. The same result must occur when performed from
> +     * both the enabled/stopped state and enabled/running state. If
> +     * the watchdog hardware is disabled, results are indeterminate.
> +     * This action is required.
> +     */
> +    WDAT_ACTION_QUERY_STOPPED_STATE = 0xA,
> +    /*
> +     * Stops the watchdog, if not already in stopped state. If the
> +     * watchdog hardware is disabled, results are indeterminate.
> +     * This action is required.
> +     */
> +    WDAT_ACTION_SET_STOPPED_STATE = 0xB,
> +    /*
> +     * Determines if the watchdog hardware is configured to perform a
> +     * reboot when the watchdog is fired.
> +     */
> +    WDAT_ACTION_QUERY_REBOOT = 0x10,
> +    /*
> +     * Configures the watchdog hardware to perform a reboot when it
> +     * is fired.
> +     */
> +    WDAT_ACTION_SET_REBOOT = 0x11,
> +    /*
> +     * Determines if the watchdog hardware is configured to perform a
> +     * system shutdown when fired.
> +     */
> +    WDAT_ACTION_QUERY_SHUTDOWN = 0x12,
> +    /*
> +     * Configures the watchdog hardware to perform a system shutdown
> +     * when fired.
> +     */
> +    WDAT_ACTION_SET_SHUTDOWN = 0x13,
> +    /*
> +     * Determines if the current boot was caused by the watchdog
> +     * firing. The boot status is required to be set if the watchdog
> +     * fired and caused a reboot. It is recommended that the
> +     * Watchdog Status be set if the watchdog fired and caused a
> +     * shutdown. This action is required.
> +     */
> +    WDAT_ACTION_QUERY_WATCHDOG_STATUS = 0x20,
> +    /*
> +     * Sets the watchdog's boot status to the default value. This
> +     * action is required.
> +     */
> +    WDAT_ACTION_SET_WATCHDOG_STATUS = 0x21,
> +} WDATAction;
> +
> +#define WDAT_INS_READ_VALUE 0x0
> +#define WDAT_INS_READ_COUNTDOWN 0x1
> +#define WDAT_INS_WRITE_VALUE 0x2
> +#define WDAT_INS_WRITE_COUNTDOWN 0x3
> +#define WDAT_INS_PRESERVE_REGISTER 0x80
> +
> +void build_append_wdat_ins(GArray *table_data,
> +                           WDATAction action, uint8_t flags,
> +                           struct AcpiGenericAddress as,
> +                           uint32_t val, uint32_t mask);
> +
> +#endif /* QEMU_HW_ACPI_WDAT_H */
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index ea1c415b21..9f9ce28dcc 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -32,6 +32,7 @@
>  #include "hw/pci/pci_bus.h"
>  #include "hw/pci/pci_bridge.h"
>  #include "qemu/cutils.h"
> +#include "hw/acpi/wdat.h"
>  
>  static GArray *build_alloc_array(void)
>  {
> @@ -2647,3 +2648,16 @@ Aml *aml_error_device(void)
>  
>      return dev;
>  }
> +
> +void build_append_wdat_ins(GArray *table_data,
> +                           WDATAction action, uint8_t flags,
> +                           struct AcpiGenericAddress as,
> +                           uint32_t val, uint32_t mask)
> +{
> +    build_append_int_noprefix(table_data, action, 1);    /* Watchdog Action */
> +    build_append_int_noprefix(table_data, flags, 1);     /* Instruction Flags */
> +    build_append_int_noprefix(table_data, 0, 2);         /* Reserved */
> +    build_append_gas_from_struct(table_data, &as);       /* Register Region */
> +    build_append_int_noprefix(table_data, val, 4);       /* Value */
> +    build_append_int_noprefix(table_data, mask, 4);      /* Mask */
> +}


