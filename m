Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45478C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 08:13:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1we76w-0001uX-Dg; Mon, 29 Jun 2026 04:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1we76u-0001u0-TJ
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 04:12:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1we76t-0004fM-HR
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 04:12:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782720773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oKIK0SUno5CX+2oH+AKwpBCMF/JJ5BRSDyNKjfU3BYk=;
 b=cHitoopiNXSbgg/krmXcwZUnicK6d5o7AAS1i+jNtv3NJbJsUipwJCMaYe05z6LQjovKJE
 VKYLYrRyNF5JuCviKxNNmd8weruAO0b0zqa/UCDS9uKvtol2tb03C9xzSZZMvis5I5Prih
 vRqN+0Ty9EoOrkrNDe6pTuOe9L+Z1Sc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-ooDRrMJGM-CoUIiIu0eRvQ-1; Mon, 29 Jun 2026 04:12:52 -0400
X-MC-Unique: ooDRrMJGM-CoUIiIu0eRvQ-1
X-Mimecast-MFC-AGG-ID: ooDRrMJGM-CoUIiIu0eRvQ_1782720771
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47416fc1674so306161f8f.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 01:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782720771; x=1783325571; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oKIK0SUno5CX+2oH+AKwpBCMF/JJ5BRSDyNKjfU3BYk=;
 b=fNSTbcB0t5YL3tXXc4eLDTrMwYDT3H+81hLZ+AMt+i7Na0aQKQn9Gb09OERTDl3k/i
 1IdkM0BT3RTRwHRXppuA3lhh76M3FOcMZRGeWcId4QoJO/Z+TxWAoStlZwmb2n/XwL8S
 LK2wxtZvdfGc/PpGfScs72oh4Rn7IazlNM3rBUR8SRNVEA9IYJ9NTpFCOmPr/u2ZrYZm
 ORvAoJKf3ERVbQKCSIs63ic6e6JszPrtFJmiBWqYR0wm4DVeVtuRANAOxk4xg8E4+bKB
 PHXQX5CiPsG/IXl742WRWyk2qT2xtS3tKq1IWmHkdA4rnSu03RScdLbHJO+6ZNtxFN8C
 JLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782720771; x=1783325571;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oKIK0SUno5CX+2oH+AKwpBCMF/JJ5BRSDyNKjfU3BYk=;
 b=CJTEpPJRD3KLjCOI1ekB6bn2AwvyMBb7M2KujafZkTrajGHR3Ilj8PTSYu63ObOtPI
 iN/DjPpcJv7DzTBCT8wtyU6JZ8EoGF+J/UVxr0zpDlvGTnna9iYd7UzZpC1eUuCFAKSV
 0VhPffHimdpib6/dlTGlCYb4Rzlz54vXZKHAtuQe0o8hOvHBi0iJsrloWnac+uERPpJU
 txWraCmVtEE3LLkTocUf+BO4/IiNjTK+ieljKR7lKi8da1G5KHqWvQL/JkkGvOEWbwsg
 oczHY7Mk+efCFVJu22WBAzsiUPIjP9HkD6bqji0NY4eAyHNNyPME59MPjzkkF0Dlvgla
 Ocig==
X-Forwarded-Encrypted: i=1;
 AHgh+RqSmlk0grKhD1Bz+1CJG/G7gsaCdkBHezipfKuNqOrHwwOnPs/gGK7NbYdep2Zj3sF6xu3s280vEdws@nongnu.org
X-Gm-Message-State: AOJu0YzMZT5DoaRAHD3bgVhTa2uF6NSEFidsuUMNrHBtBdIh+MB8+v7H
 IPTyIssnR9BTQ5Hcg65v4bOSrrx9U/aG4tkXx8FmyRZil2Q98Lelr5527jBM24ELsODZTndZ5S/
 sVOqZU7/355c2KNJxSZ785wMjaTjuvhcLtkGpyu7jadvOa92vOap1vIhF
X-Gm-Gg: AfdE7ckhaf2KhhTsA1a9a5OuYUhvW+BuzoDUYahBMh2HcfqiiQ5a05ExIyW9tiYFi5A
 gvVpBEB4tGsrpALaqlfpIjQjcHWuWD0xO0+T+3W6gwKEFQOywzj+IWdheNS+EOFjWVN8ioSjOXw
 fKiFhD0LHcpKHLpLSDS0BbJei1gwrMIO/rpviTskbe7YmoJtzwlCVyQnnZzGJ7191Hemlz7lGIv
 vNjP9h+3Fl3a4a92vmB4umakre8zBNDeusd8A8zdj8Br7D3JRoDrlf2Kmg9ynM4RQbZBaD80WgI
 Pm+XcKu67KWxI/EaEJkMKEo20GLrk1HDVlry+giYSzFZCP2REnw2s7QYud7/GbxgOwXI8LtBG/R
 aG6c5VjM4BtM55BkJM4ugq3+Qcf/HqL65sA1l5HqoRPwDaBDfc2sRIA==
X-Received: by 2002:a05:6000:2f87:b0:46e:1658:7c62 with SMTP id
 ffacd0b85a97d-46e16587d84mr24643966f8f.16.1782720770995; 
 Mon, 29 Jun 2026 01:12:50 -0700 (PDT)
X-Received: by 2002:a05:6000:2f87:b0:46e:1658:7c62 with SMTP id
 ffacd0b85a97d-46e16587d84mr24643935f8f.16.1782720770546; 
 Mon, 29 Jun 2026 01:12:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4728072188fsm14230044f8f.29.2026.06.29.01.12.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jun 2026 01:12:49 -0700 (PDT)
Message-ID: <6b64061f-06d4-4e92-8f06-43332c10fd3b@redhat.com>
Date: Mon, 29 Jun 2026 10:12:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/17] arm: sbsa_gwdt: rename device type to sbsa-gwdt
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 rad@semihalf.com, leif.lindholm@oss.qualcomm.com, qemu-arm@nongnu.org
References: <20260624102830.1355552-1-imammedo@redhat.com>
 <20260624102830.1355552-4-imammedo@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20260624102830.1355552-4-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 6/24/26 12:28 PM, Igor Mammedov wrote:
> Use hyphenated name to follow QEMU device naming convention.
> Migration compatibility is preserved since the vmstate name
> is already "sbsa-gwdt".
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

> ---
>  include/hw/watchdog/sbsa_gwdt.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/watchdog/sbsa_gwdt.h b/include/hw/watchdog/sbsa_gwdt.h
> index 307a4f291a..8941dcff9e 100644
> --- a/include/hw/watchdog/sbsa_gwdt.h
> +++ b/include/hw/watchdog/sbsa_gwdt.h
> @@ -16,7 +16,7 @@
>  #include "hw/core/sysbus.h"
>  #include "hw/core/irq.h"
>  
> -#define TYPE_WDT_SBSA "sbsa_gwdt"
> +#define TYPE_WDT_SBSA "sbsa-gwdt"
>  #define SBSA_GWDT(obj) \
>      OBJECT_CHECK(SBSA_GWDTState, (obj), TYPE_WDT_SBSA)
>  #define SBSA_GWDT_CLASS(klass) \


