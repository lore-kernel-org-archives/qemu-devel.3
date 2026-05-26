Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BA1CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsiZ-0006fz-Dk; Tue, 26 May 2026 10:25:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wRsiX-0006fV-1e
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:25:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wRsiS-0008ON-V0
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779805506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dw8FtCfBiYjKI5wPCVclBnscGdVHt9nmpQs+GCnhfV8=;
 b=dFCAQKu9tpuTQ1CnbM98o+cB3qr2gDuW2IzKCsZUo7vFtFmC25Znk3U7fP3n4fsx7LLf6f
 JFXoWZW1ue3mYd3fyw5KAcRwUHwirWLq6Ktxew5B6r1BDs0WED5CmjX2YuanF1mn2ZXUME
 z2qF48KgF3sV8IJm15P1SqRRMqQzpJM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-pyGf9H78PkOAosLTJ68uKw-1; Tue, 26 May 2026 10:25:03 -0400
X-MC-Unique: pyGf9H78PkOAosLTJ68uKw-1
X-Mimecast-MFC-AGG-ID: pyGf9H78PkOAosLTJ68uKw_1779805502
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48e79219704so73970695e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779805502; x=1780410302; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dw8FtCfBiYjKI5wPCVclBnscGdVHt9nmpQs+GCnhfV8=;
 b=pGw6IXflKIuUqJuVug8vC4oQawY8xgUNLr8rv6QzhM3+47Hxt00HDIeqILHPatfFfc
 ej+K3IX/tJ60/NmpQxecuIWF0KTCg0AslozfBT4F/CnyzUPY+uMnbSFx82RXD5MwaHZ3
 AQFIOqyH1sOEKHF/+ZEKogNvi69cKbtae+KUTk6Nn+9src2TPDDeQYaHLN61h1E6hMD6
 NEcOZYJax3e6dO95AiMmz/vhGsBtFrQwfZ0Qb9TJ9SAqch1f7/R/FebI2Jk5qY04pemX
 +QQW1Z2LtMLRoiFyb1/v8pJ0CODDBI+T/vDV3bJNm5eVhX+vg9lZO12o1epUVTCqM75+
 iTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805502; x=1780410302;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Dw8FtCfBiYjKI5wPCVclBnscGdVHt9nmpQs+GCnhfV8=;
 b=Q8buO724Z09gEZXNTeXuzDDgbPV/sijN9NejYTIEW2H5I9e5cdHPbzpd0W2fLVNbL1
 MG80CDc5mAy2zTx/OahELADNBshId7VM42ed0PoD0E27W5EIgD5T2/mzcCxZ+2YDzslK
 if7YqwYRh88g1E37tWlTlAgbt0UI0FtaUmRRrVu38aWcApNkqOlJaQbK3wNtHtm8BIiD
 c5HvGSzFSRklsinHiVayZ/mQCyAH3uxnniLu8RQPBpJeBeYZJlVqcj308MrJGT503BwI
 58JRZu+0POnfOdg/1VB/9lRS5qZLbi1mnw8MeYQ9RBNnK+pfzmXyHDt08Jvvf0Xvllrm
 z7DA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/FTW8hc2+ukMsqk5Bg8ZuyURd4Dy8x9xlFYTl8ibrJGoAa6C6Dtp0gCnkGEuRYmIyrmoSyNvqaouNB@nongnu.org
X-Gm-Message-State: AOJu0YxSiMWFShDPptp27mDz9Rm8/JFtWG47bJ3HcgSnsHP8DjxYuuie
 qMmT8WbRBKM7LPIGs4d983WuNNtRzJEQz7FmTiCJHVDu2SfA54wLmXBH8NmntrpIVWq9q0XB7O4
 i4XADK+zsbCip6eXVuvSsPvMkpzh8rkCxQWg1wfMQCdDRjVGLnR/sXVgS
X-Gm-Gg: Acq92OFemF2RFM1h7LfVqBVqIzTFzhxX7wb95aNCzSuyDFEdGmZHIP7hIzuF2RCvKWO
 BzrD0lIEn6EtLsQDcYrcc07v5Y81m7c84CPkIeU3vmRK91c/s6axU1RSJAPiR6ZmxWy6qrYpIkR
 U2fXcWVCQdzCUXuveknENrlBT5LpdIeGlsKMcB9sV8I7JG9Y+Gv3sxv9TzG4dtniM+6lTQbQm2+
 Qg21mgBVhSMydqhpV/12ZYrYFFJIXVZiPNSTlrnPJuokXtF6byzItROjlOa73nNWEoyGQW11bB6
 1Sh/uYfpYA91RV5biCEvnkXzhnnHdmpJAYCXXSukxvEcPEOLftlqlwuaUmpAdwnKnhn+0x5gJ/l
 +LW7vJ3135tJDw+fWZm//y1GCy5SvlI4ejrTDUY/tc322nGRlwcLMX1VKKFy/S3Ur
X-Received: by 2002:a05:600c:4589:b0:490:548e:b854 with SMTP id
 5b1f17b1804b1-490548eb9d5mr201093485e9.26.1779805502056; 
 Tue, 26 May 2026 07:25:02 -0700 (PDT)
X-Received: by 2002:a05:600c:4589:b0:490:548e:b854 with SMTP id
 5b1f17b1804b1-490548eb9d5mr201092765e9.26.1779805501572; 
 Tue, 26 May 2026 07:25:01 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6c9f598sm36659674f8f.6.2026.05.26.07.25.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 07:25:01 -0700 (PDT)
Message-ID: <e443a026-3511-46f5-809a-7555789d330c@redhat.com>
Date: Tue, 26 May 2026 16:24:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/21] arm: sbsa_gwdt: add 'wdat' option
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
References: <20260303092532.2410177-1-imammedo@redhat.com>
 <20260303092532.2410177-11-imammedo@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20260303092532.2410177-11-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eauger@redhat.com;
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



On 3/3/26 10:25 AM, Igor Mammedov wrote:
> it will be used by arm/virt board, to pick WDAT compatible watchdog impl.
> and act as switch over to WDAT ACPI table vesus default GTDT ACPI table.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  include/hw/watchdog/sbsa_gwdt.h | 1 +
>  hw/watchdog/sbsa_gwdt.c         | 8 ++++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/include/hw/watchdog/sbsa_gwdt.h b/include/hw/watchdog/sbsa_gwdt.h
> index 307a4f291a..dc77e6be60 100644
> --- a/include/hw/watchdog/sbsa_gwdt.h
> +++ b/include/hw/watchdog/sbsa_gwdt.h
> @@ -73,6 +73,7 @@ typedef struct SBSA_GWDTState {
>      uint32_t woru;
>      uint32_t wcvl;
>      uint32_t wcvu;
> +    bool wdat;
>  } SBSA_GWDTState;
>  
>  #endif /* WDT_SBSA_GWDT_H */
> diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
> index c4dd8005b7..40d80f7f2b 100644
> --- a/hw/watchdog/sbsa_gwdt.c
> +++ b/hw/watchdog/sbsa_gwdt.c
> @@ -265,6 +265,13 @@ static void wdt_sbsa_gwdt_realize(DeviceState *dev, Error **errp)
>  
>      sysbus_init_irq(sbd, &s->irq);
>  
> +    /*
> +     * WDAT supports only upto 1KHz resolution,
> +     */
> +    if (s->wdat) {
> +        s->freq = 1000;
where is it specified in the spec?

Thanks

Eric

> +    }
> +
>      s->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, sbsa_gwdt_timer_sysinterrupt,
>                  dev);
>  }
> @@ -276,6 +283,7 @@ static const Property wdt_sbsa_gwdt_props[] = {
>       */
>      DEFINE_PROP_UINT64("clock-frequency", struct SBSA_GWDTState, freq,
>                         1000000000),
> +    DEFINE_PROP_BOOL("wdat", struct SBSA_GWDTState, wdat, false),
>  };
>  
>  static void wdt_sbsa_gwdt_class_init(ObjectClass *klass, const void *data)


