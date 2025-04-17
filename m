Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DFBBC369C9
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 17:31:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5T4a-0001RL-Ft; Thu, 17 Apr 2025 13:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u5T4Y-0001Ng-1V
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:30:46 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1u5T4V-00019F-Pe
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 13:30:45 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-736b0c68092so979290b3a.0
 for <qemu-devel@nongnu.org>; Thu, 17 Apr 2025 10:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744911042; x=1745515842; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WihMJUisad0mVnN74dFCh+QMMw3Gxt1gDJkJzWOpzOs=;
 b=XCUFk7ATTMraCIT7bcH3sjZwaU1YHbjTsz/ef8D6/hC++5cOryYqzAtZCfaUfnwj23
 q7b0NcpjMNCRAMNVUQ0EQwmdbyxGJJavOamCBsAEzpLNFHr97PjyyZcyTxKa/p3Wkeho
 91/BK6Dplb19XFswuUFSWVmpiv06N1GMjW9XZXdItZJ65u6I/xbgST2ePynGV8NBvYTM
 AF/BEwOMHRj4YZFylfyjuzyrnot+LpBK1qjle1Twj4FS+nRJd/A8GaZLEEbpbgnxNuCR
 vXuQWeTq1UOaSbcluMTe+bluKqUZB24pORVgxDlSPlsk4zDwGUHgDscTmqo3w67kMGls
 fDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744911042; x=1745515842;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WihMJUisad0mVnN74dFCh+QMMw3Gxt1gDJkJzWOpzOs=;
 b=wV7vvpaAjY3kuU3HfZWjcnNMXEtRqEai3lT1kfpxAMaPpa/I6X1c0ECITmodehAZ2O
 zwLs6nViSaN4WuswBV/igAlJxXDSxOmTUpX8lyQ9NH2k/vmot4BrMbnAQZ+dCzsAjJT5
 F+nMDGvRplg6/tY/++0dIumJXxcHMzbWIdGJqqMX7ZBINiUOtLHi6qaqA4EOn6jRtiTe
 ywVObuxAEOdf/eoNI2j74uEFjPb8uW++lVaESL0bSVv6YV9WTX9R41vqEufllWWKY+6b
 gQCkxVDqmBbd2xjO4loSLMa5EBA7gD2drL+S6uM0tFrjtbUhBvV66hpEk1E7kxFKAxYa
 Vmjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmH5vFx/VhlodHrTf6ytn9CITtpxFCqMohDe6ouMvdNlR3lPzWmkNJJXeGa1KqqbJafAVuR1zoxPC7@nongnu.org
X-Gm-Message-State: AOJu0YziHwJ23dtOJSQT8sbb2LMvgCVFcxQCUiWxom7dMmfe2BNGKjbr
 zJH5Th4KiVy3z3kc1czNq5UOAaFnZFT02qKG58oJSA137oik7GvNdZ6CGbvWtpONSFsnT7gDj+b
 p
X-Gm-Gg: ASbGncv4/JW16UV5Y1ktP/RMMuHokErNuK8ldaPaA5+hvvy0RCMfrhudKj0cEG7bzxa
 /xlv9/rvfj34PHBUk2eoj3T73qm6cST5FiXSWaMI7j03TNsEUF4egMDrizPbahN2Gzd/5mCfzJT
 1AT8FHpb7mypuvVyUwiTeuMcc5CobqoPpnfHlc/mFDnd1eJKAPLJhbl5f8MvvImkdSC++vzKnzv
 MEpx+bcnJ+e7hoWpSY/0cMzF0EGUerFZITa7QKRNSvFIIREIvD6a/HilcuGHndE09qk03rND5ph
 TUVkzBVPv02r/Ht07fOmtL8fsiYATaQtYExINqcyX4LswPQ0eL/N
X-Google-Smtp-Source: AGHT+IGRVXpbXoG1IhlMmWNDXs3XUwWSOepyhIFcJCfZ26FnZPK3Lo3crOA6ZdilYAxf4/2J7lmWwA==
X-Received: by 2002:a05:6a00:328f:b0:736:a6e0:e66d with SMTP id
 d2e1a72fcca58-73dbfabcfc3mr361945b3a.6.1744911042043; 
 Thu, 17 Apr 2025 10:30:42 -0700 (PDT)
Received: from [192.168.0.102] ([186.215.52.65])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73dbf8beaf2sm118447b3a.5.2025.04.17.10.30.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Apr 2025 10:30:41 -0700 (PDT)
Message-ID: <326d52e6-c0ce-4f22-ade0-6f0bbbe3717b@linaro.org>
Date: Thu, 17 Apr 2025 14:30:37 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 PATCH 03/13] acpi: Support Control Method sleep button
 for x86
To: annie.li@oracle.com, qemu-devel@nongnu.org
Cc: mst@redhat.com, imammedo@redhat.com, philmd@linaro.org,
 zhao1.liu@intel.com, Jonathan.Cameron@huawei.com
References: <20250411201912.2872-1-annie.li@oracle.com>
 <20250411203406.2930-1-annie.li@oracle.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <20250411203406.2930-1-annie.li@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42f.google.com
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

Hi Annie,

On 4/11/25 17:34, Annie Li wrote:
> Add Control Method Sleep button and its GPE event handler for
> x86 platform. The GPE event handler notifies OSPM when the
> Sleep button event is triggered.
> 
> Signed-off-by: Annie Li <annie.li@oracle.com>
> ---
>   hw/i386/acpi-build.c | 22 +++++++++++++++++++++-
>   1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 3fffa4a332..4be3595e5a 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -40,6 +40,7 @@
>   #include "hw/acpi/acpi_aml_interface.h"
>   #include "hw/input/i8042.h"
>   #include "hw/acpi/memory_hotplug.h"
> +#include "hw/acpi/control_method_device.h"
>   #include "system/tpm.h"
>   #include "hw/acpi/tpm.h"
>   #include "hw/acpi/vmgenid.h"
> @@ -1359,7 +1360,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>                                                        NULL);
>       Object *q35 = object_resolve_type_unambiguous(TYPE_Q35_HOST_DEVICE, NULL);
>       CrsRangeEntry *entry;
> -    Aml *dsdt, *sb_scope, *scope, *dev, *method, *field, *pkg, *crs;
> +    Aml *dsdt, *sb_scope, *scope, *dev, *method, *field, *pkg, *crs, *condition;
>       CrsRangeSet crs_range_set;
>       PCMachineState *pcms = PC_MACHINE(machine);
>       PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(machine);
> @@ -1465,6 +1466,25 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>       }
>       aml_append(dsdt, scope);
>   
> +    sb_scope = aml_scope("_SB");
> +    acpi_dsdt_add_sleep_button(sb_scope);
> +    aml_append(dsdt, sb_scope);
> +
> +    /*
> +     * The event handler for the control method sleep button is generated
> +     * for notifying OSPM[ACPI v6.5 Section 4.8.2.2.2.].

Typo: Section 4.8.2.2.2.2

Please use the form "... OSPM (ACPI v6.5, Section 4.8.2.2.2.2)" for citations.


> +     */
> +    scope =  aml_scope("\\_GPE");
> +    method = aml_method("_L07", 0, AML_NOTSERIALIZED);
> +    condition = aml_if(aml_name("\\_SB.SLPB.SBP"));
> +    aml_append(condition, aml_store(aml_int(1), aml_name("\\_SB.SLPB.SBP")));

Why not concatenate with ACPI_SLEEP_BUTTON_DEVICE here and in the conditional
above it as it's done below for the Notify()?


Cheers,
Gustavo

> +    aml_append(condition,
> +               aml_notify(aml_name("\\_SB."ACPI_SLEEP_BUTTON_DEVICE),
> +                                    aml_int(0x80)));
> +    aml_append(method, condition);
> +    aml_append(scope, method);
> +    aml_append(dsdt, scope);
> +
>       if (pcmc->legacy_cpu_hotplug) {
>           build_legacy_cpu_hotplug_aml(dsdt, machine, pm->cpu_hp_io_base);
>       } else {


