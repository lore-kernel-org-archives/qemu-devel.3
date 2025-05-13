Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C34DC3ABCC
	for <qemu-devel@archiver.kernel.org>; Tue, 13 May 2025 14:50:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEqxe-0008O0-A3; Tue, 13 May 2025 10:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uEqxX-0008Mx-Hp
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:50:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uEqxU-0001Ud-F4
 for qemu-devel@nongnu.org; Tue, 13 May 2025 10:50:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747147814;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Vh+wAuJrcvPvfiLhvY41nHVEZ4KPPjEC/9ttCXTHuk=;
 b=EjZtIIax5Ftg5uT6u+xauViwEFA0YlVGoN+OvZzdISl19iyGjwcX6jrZtyiTwAHJ/sNX2x
 YSqbirK6e6e6W+zxRfgrZqWh7wV8OE1OFmXsn+zx6yfnSmXHskYSQa4WWHds0VK2pFQppY
 u7GyCFS8SBeEjGmw3o1erLaBYX2bbgs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-465-8njVwmZmNC2fRzPT_0l7LQ-1; Tue, 13 May 2025 10:50:13 -0400
X-MC-Unique: 8njVwmZmNC2fRzPT_0l7LQ-1
X-Mimecast-MFC-AGG-ID: 8njVwmZmNC2fRzPT_0l7LQ_1747147812
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cec217977so28563615e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 May 2025 07:50:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747147812; x=1747752612;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9Vh+wAuJrcvPvfiLhvY41nHVEZ4KPPjEC/9ttCXTHuk=;
 b=UO0yHwsosRQ2IV/jLwEC/xd/oQr4VVx7FEwBDL3hH6EZEbiKKC+V829EzCCiOQjzx0
 wG+MWiBhPJWAQqKjbyys7TSsv2xVIcoExKBWjL+KLEgAntil8SAfu4XRWYTkVylYCc6K
 3zr1w9axsJXSaKrgRRFVu49cZOCSx4+zUlZZnvznX+T5TfG7gDq6RnXf4PsrPQPHn9es
 eWpF8n444EGuNy9SqM4V+yVfM+9idPagdiI6/uWl8tUP2p4NQ1aIw4K/OzLjsrgAi8Zx
 2lng+M9ZqnW+8hp9k9Un+K0A06pTbmgCuBrvZE7SC8wpuF0u/apnO2jXdBageL7Yjmdu
 gBKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNIT5HwkRIf8UOxcYumhfBRMhsnPL5c0bS9svRne3fg/GiAMgDOHXXXg9t2/8Tbe3/GqJt8LTfmFlN@nongnu.org
X-Gm-Message-State: AOJu0YyWCO29PVfHyY/FZGHfC2o00e4a8gcqBUMp4kw8KAgzGDRBHHbY
 jQnerY8sD++W0Ju6GyNdJhwZY3d6TuIljXN0/uOrIYPVkuCUQ9Y4LIuUohQw/ZgVmqIxBft0af6
 W47BEK6m+2CfvxdlmpEzLIEAGswdatvnntZ7FDOyzylWx8BdqfM+R
X-Gm-Gg: ASbGncucB2I5nPPIoXoUHHZUjgx97CB47CXAGeGCF6DrmZmzugqoIVozZTlm+1btGHY
 uoPaK7rtOt0FTInkfHm5hHLzm5R4rBPP3vzRFJDE093ZMzO9XGWLIW7yZglE1P963ZA2r61d1JM
 dwGdDbpQPYwiY1NohO1rdeO0yrFJQGDfj7ttt7AssVC0YIPNYBz4xlfFw8WAIeiDtJiGhWltmkt
 agXKY+Da9AUBDwknJStzr+FEInm865Es/CVKjd7P9aNaYbb02Gah11UnJ8bpE0K93LKg4hLGE+L
 u8lnAp3OjeesbJzZQXr/dsMHFJW3aK+aIM8OsX9SOReSpl1hlV1LI/IJjbA=
X-Received: by 2002:a05:600c:628c:b0:43c:f689:dd with SMTP id
 5b1f17b1804b1-442d6d71df0mr161957555e9.19.1747147812370; 
 Tue, 13 May 2025 07:50:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyvLSUMf/JT5Dprw5YizmztUBTO6fhnpQzAJ1M70b1svTPVFXSqm65oRVzoYHvjCmHJ3fcgQ==
X-Received: by 2002:a05:600c:628c:b0:43c:f689:dd with SMTP id
 5b1f17b1804b1-442d6d71df0mr161957185e9.19.1747147811919; 
 Tue, 13 May 2025 07:50:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd34bd84sm212123835e9.22.2025.05.13.07.50.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 May 2025 07:50:11 -0700 (PDT)
Message-ID: <5d2f9062-8bc8-40b8-9a0b-d04f232756bb@redhat.com>
Date: Tue, 13 May 2025 16:50:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 09/10] arm-qmp-cmds: introspection for ID register props
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvmarm@lists.linux.dev,
 peter.maydell@linaro.org, richard.henderson@linaro.org,
 alex.bennee@linaro.org, maz@kernel.org, oliver.upton@linux.dev,
 sebott@redhat.com, shameerali.kolothum.thodi@huawei.com, armbru@redhat.com,
 berrange@redhat.com, abologna@redhat.com, jdenemar@redhat.com
Cc: agraf@csgraf.de, shahuang@redhat.com, mark.rutland@arm.com,
 philmd@linaro.org, pbonzini@redhat.com
References: <20250414163849.321857-1-cohuck@redhat.com>
 <20250414163849.321857-10-cohuck@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250414163849.321857-10-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.549,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 4/14/25 6:38 PM, Cornelia Huck wrote:
> Implement the capability to query available ID register values by
> adding SYSREG_* options and values to the cpu model expansion for the
> host model, if available.
>
> Excerpt:
> (QEMU) query-cpu-model-expansion type=full model={"name":"host"}
> {"return": {"model": {"name": "host", "props":
> {"SYSREG_ID_AA64PFR0_EL1_EL3": 1224979098931106066,
> "SYSREG_ID_AA64ISAR2_EL1_CLRBHB": 0,
> ../..
>
> So this allows the upper stack to detect available writable ID
> regs and the "host passthrough model" values.
>
> [CH: moved SYSREG_* values to host model]
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
>
> ---
>
> TODO: Add the moment there is no way to test changing a given
> ID reg field value. ie:
>
> (QEMU) query-cpu-model-expansion type=full model={"name":"host", "prop":{"SYSREG_ID_AA64ISAR0_EL1_DP":0x13}}
Isn't it a mandated feature for layered products to be able to try a
given combination. Do you think this would be achievable?

Eric
> ---
>  target/arm/arm-qmp-cmds.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>
> diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
> index 883c0a0e8cce..5f48c7d835e1 100644
> --- a/target/arm/arm-qmp-cmds.c
> +++ b/target/arm/arm-qmp-cmds.c
> @@ -21,6 +21,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "hw/boards.h"
>  #include "kvm_arm.h"
>  #include "qapi/error.h"
> @@ -209,6 +210,24 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>          }
>      }
>  
> +    /* If writable ID regs are supported, add them as well */
> +    if (ARM_CPU(obj)->writable_id_regs == WRITABLE_ID_REGS_AVAIL) {
> +        ObjectProperty *prop;
> +        ObjectPropertyIterator iter;
> +
> +        object_property_iter_init(&iter, obj);
> +
> +        while ((prop = object_property_iter_next(&iter))) {
> +            QObject *value;
> +
> +            if (!g_str_has_prefix(prop->name, "SYSREG_")) {
> +                continue;
> +            }
> +            value = object_property_get_qobject(obj, prop->name, &error_abort);
> +            qdict_put_obj(qdict_out, prop->name, value);
> +        }
> +    }
> +
>      if (!qdict_size(qdict_out)) {
>          qobject_unref(qdict_out);
>      } else {


