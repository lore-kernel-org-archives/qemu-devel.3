Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06212C3ABB6
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 00:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC5uR-0004cV-LA; Mon, 05 May 2025 20:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uC5uP-0004bl-0J
 for qemu-devel@nongnu.org; Mon, 05 May 2025 20:11:41 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1uC5uN-00009Y-Ez
 for qemu-devel@nongnu.org; Mon, 05 May 2025 20:11:40 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso4020870b3a.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 17:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746490298; x=1747095098; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pPYohP+2+Ojai2hA+Ri6L4jLq96SA19k0mKSSyeJVtU=;
 b=xvYSN+y4DXwtGrPQg9Y7/p9y4LzSR4XV3DFL3EX3VBFdwaHWupxkpc6cYpaLAtyuz4
 iEzA7NrjX728PpVudcmwsaf8y0DjsBoPWyfqQUoO58ZgdwiTY9c+B7RiiosOzLScckjW
 TyUTEbZV+73erzAvSbeNb1VKcMF7S3uFJXMkxW0liLCgowPOGzKHLZ66ckm5kdV29Spu
 wiwj4CuShYWctA/4uGZtx5lsUgGIzmfpodPLk7ai9dX23e2CS5E57Qit8HyFhrekCoC/
 yq4IovgvZI8ZJOTnqiB4remXT2cX1uWSh6X3JNHhwWZmrMoaHZqvt10rDJdn7H8r2IsS
 zUZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746490298; x=1747095098;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pPYohP+2+Ojai2hA+Ri6L4jLq96SA19k0mKSSyeJVtU=;
 b=n3yzyWI0sfx8qG6kz1h16UIJ7ySire+brErlnChECTxYk9sPi5YcDQBOp0XOaLwn9q
 /T00vb0PfZvEQrEw/ab76L38uzm1jIBC+7HSFz1vHXOEpEMVIwRFYcJgieTvinTM3O1d
 /a5CkzMNEbTYQL19dG9QwNcld09xuqkwaPT0T0V75dKK5nrtdswF/Zpp0znNAD1E5kNM
 bsmVYwfXNkrCT5U1f0C//SVH/JDSLlf7pPU2CCT1io+T7UQcIYMqovUKhm9sTagpo2y3
 eYXlENbWozzOMAGEmeQNEAkYKRRZE+dg2RqlDufRByeMP2BI1oc6YewAKRgEyMOIY6wq
 nDLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkVcGBnOG66okqdRWf9n6iLwp0b+8XEP06Ws8EKajXW0giK3GiiFPWZuKloQOtRnaXv5WuHIEcQNSA@nongnu.org
X-Gm-Message-State: AOJu0Yxp+9c8BugxOuUdw0JYUreEToMiH+zhNEgAtU8UKHKjtJVm5HJm
 DxLw0/uwC6EDyl85zV/J7meTmPgtu4NSemMJj3avsfIGv5PqNJDa+k1nPuAdXQs=
X-Gm-Gg: ASbGncuZzyIzqFUkMegf77qbu14OTDUrn44+YHLoHlp0UkUyPH++ortO3VHZP9/WLsM
 +FslEDTctfMDPKnSBOqoabiRiDg4070Gq7yvD8WdK1l0GiIb5l/DURxepH2bTNTQQoC9mYurm9b
 5qIPNqAOm7+TIB+4QLPJZeqJGuDKGxD6ZM5U4YkhJ9V/Zfq2XfbA7Rg9PRICZ3W0LLYZHHi8LR6
 a6eAvFv2XAsUoDdni7DySdcNcbR42e4OGUMMQWLPr5Z/1VZf+fshZCcPrjQvHKOw0/wgZ3v5ujB
 +Swe4QGhAC71jmtwAsf0vIe2oAbxTCoPV2Pl/tIJ6e7EUM6NMSjBFCw9eTZg6Al8w/9EBT0rq2m
 a20ocJz2UhsNpwPR5KVM=
X-Google-Smtp-Source: AGHT+IEaVH9noYL2lcBnUzcbKEK0RkPGqhUvyYMytUWWn3ezwEn9AUocBldMEvP1V6ekz6DuNjqO4Q==
X-Received: by 2002:a05:6a00:8216:b0:736:4c3d:2cba with SMTP id
 d2e1a72fcca58-74090f17b97mr1417717b3a.9.1746490297959; 
 Mon, 05 May 2025 17:11:37 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b400:8604:71fc:f75a:e2f5:e7b5?
 ([2804:7f0:b400:8604:71fc:f75a:e2f5:e7b5])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7405909c491sm7518535b3a.159.2025.05.05.17.11.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 17:11:37 -0700 (PDT)
Message-ID: <d5451229-4369-4c85-a499-b9a03db772c2@linaro.org>
Date: Mon, 5 May 2025 21:11:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Gustavo Romero <gustavo.romero@linaro.org>
Subject: Re: [RFC 03/24] hw/i386/acpi-build: Fix
 build_append_notfication_callback typo
To: Eric Auger <eric.auger@redhat.com>, eric.auger.pro@gmail.com,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, peter.maydell@linaro.org,
 imammedo@redhat.com, anisinha@redhat.com, mst@redhat.com,
 shannon.zhaosl@gmail.com
Cc: pbonzini@redhat.com, Jonathan.Cameron@huawei.com
References: <20250428102628.378046-1-eric.auger@redhat.com>
 <20250428102628.378046-4-eric.auger@redhat.com>
Content-Language: en-US
In-Reply-To: <20250428102628.378046-4-eric.auger@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x42d.google.com
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

Hi Eric,

On 4/28/25 07:25, Eric Auger wrote:
> Rename build_append_notfication_callback into
> build_append_notification_callback
> 
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
> ---
>   hw/i386/acpi-build.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 3fffa4a332..85c8a8566b 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -589,8 +589,8 @@ void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus)
>       }
>   }
>   
> -static bool build_append_notfication_callback(Aml *parent_scope,
> -                                              const PCIBus *bus)
> +static bool build_append_notification_callback(Aml *parent_scope,
> +                                               const PCIBus *bus)
>   {
>       Aml *method;
>       PCIBus *sec;
> @@ -604,7 +604,7 @@ static bool build_append_notfication_callback(Aml *parent_scope,
>               continue;
>           }
>           nr_notifiers = nr_notifiers +
> -                       build_append_notfication_callback(br_scope, sec);
> +                       build_append_notification_callback(br_scope, sec);
>           /*
>            * add new child scope to parent
>            * and keep track of bus that have PCNT,
> @@ -1773,7 +1773,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>           PCIBus *b = PCI_HOST_BRIDGE(pci_host)->bus;
>   
>           scope = aml_scope("\\_SB.PCI0");
> -        has_pcnt = build_append_notfication_callback(scope, b);
> +        has_pcnt = build_append_notification_callback(scope, b);
>           if (has_pcnt) {
>               aml_append(dsdt, scope);
>           }

Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>


Cheers,
Gustavo

