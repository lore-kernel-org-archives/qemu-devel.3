Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6444FCD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:20:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsdJ-0004w4-Do; Tue, 26 May 2026 10:19:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wRsdH-0004vh-Ro
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:19:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wRsdF-0006FF-A6
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779805184;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VyRxyxI+z4/HONnlsJTMkCC5rG1G0mOJ4/NX0O6JM4k=;
 b=QjOsPS6UyV4wERyXcGVYXhHvcifFTldfglGSEeI2mNixY7N7+RngT0ltonDuFBwN9F0AtB
 5IrjFKjTHoNAl0dvMOKhrnMRolXRdGFagAynGKtOHT7istrjK0npzHVACDfEICm1ZN/WTh
 IhCaszX3qswd1uqcaxUEawfsIlmh9sU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-TNd6tFbNPHmPfqU5zg4JQg-1; Tue, 26 May 2026 10:19:42 -0400
X-MC-Unique: TNd6tFbNPHmPfqU5zg4JQg-1
X-Mimecast-MFC-AGG-ID: TNd6tFbNPHmPfqU5zg4JQg_1779805181
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48fde68e420so83978215e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779805181; x=1780409981; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VyRxyxI+z4/HONnlsJTMkCC5rG1G0mOJ4/NX0O6JM4k=;
 b=rZeFIWnNephq8S8gmYlg9JlbTN8RNsZG1Q1yLTMS31WzaHzWLGFqGwPT/lfigr79G4
 Yo1QFp9S8bruMvkpaomWrY+Y+3tMeSfZxud5jhFgPNqZ9NEizIH3nHeAS7TSxlNJkOYn
 5buywiMbS02Huu6ai7pvdca60RE0JhJyky8wltDH6moRJie3x4rsUVZaY+3SEd91vJ0X
 XzxKSCHb48jS6v7XCPoLc6e3CJe3+vxhzPImgnJEmf5LRVm1UD651L6LlWVCHuX91fR8
 IAJh7WjGlHZyvnbyjJIb3KJJZWAv5BziFZzo9WUT0JORhZY4rb3qmUY94pCgykafy60x
 XFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805181; x=1780409981;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VyRxyxI+z4/HONnlsJTMkCC5rG1G0mOJ4/NX0O6JM4k=;
 b=oY0BO/d3wBZkTRzdeRCcNo0f6zuLlobmiEMo6BBhL0IKFD+l7GEKFa+8WP7UZyD+eG
 4s97fTC/0ZSL0eoOSLdKzxE/bhjuodKGTSaT+TA32AZVFJScAQUY2ssaadWt7RUZaWKt
 ly5EdgTbYhv0uC77MLg56Nb07qXN+gPRNF82C5PISNpXYvr441YdfJRHJHzd4Colpvf4
 v2HMiZR7HV11kyT/oCNSrzlDp14vVV7/5il+7bGN2TzvaJOa2xSDshOH9tIkXiLr69VW
 g/nVfpCmIxHxpILyWCHAQYeClTgy9mEQy67k6NxU6AqK9spYG1xiif+6I7XYsgoGNmlZ
 Ra7w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8LHNKNrx2PDzDP9hTnzX+ohYz2DKA4ncRoTK0Z8zkOxeoo5F/JbxLr9ENEIA3P6p6NqeegeviHGTLH@nongnu.org
X-Gm-Message-State: AOJu0YzOV/KQk6z0YYFvVoD9HxJtwXzxdmRwOvAqwq2aTIwtcbNSxiD9
 /cz4zxGsb+NY6tFSZxN4aW6fVIqEpNWMZbhcIsepGB/bJ3nWZX3HSVVb047tVKKh1hDjtwMZHgl
 6zgzJ7XoCI7tX6V6uiDNW6oMYL9RkE+RMq5syWX+qu78IWJBhUbPD9Lad
X-Gm-Gg: Acq92OEfzJ/JmjsrntBkIh6gMrJJQ/T63fb4ayUtmkIJM1BlroRokMTp3x2tgHKVNIV
 oo4hyLqA+/y0Dsibe/cPNrXbF9KFw1m39iK8vesA7gCK3O4g+x2d6RqB/NVDONy2+HNJNsplMVH
 dMVEP2WRFvGr3mD1fbXL/GHXdpYoVkZzS3ePFaziYT6lHxSvujtUHaBgVN2L1e7l3KGy4D/tnbQ
 bwXJoFkOm0IBCIWWIOa6pwP570Q/VSCcPYy7oYF2ho3cpk814okYmA0hYZ3S1jBzTXL/Vxe8FcM
 1zToYfcYPTygTmyKAWZKREv7Aj3X+xTbpLmxvFpyMqtVf2SjTOummTsuD5abUzkRHRk5KIyYGuG
 EgIDmzDxzWrq+bWWjn+IYQmOwf6Vw/Ly6sGUKHa+5dBBVugBMc2sbw7ORPkmnt6hR
X-Received: by 2002:a05:600c:1d25:b0:490:58e0:f466 with SMTP id
 5b1f17b1804b1-49058e0f614mr218945885e9.33.1779805181001; 
 Tue, 26 May 2026 07:19:41 -0700 (PDT)
X-Received: by 2002:a05:600c:1d25:b0:490:58e0:f466 with SMTP id
 5b1f17b1804b1-49058e0f614mr218945265e9.33.1779805180507; 
 Tue, 26 May 2026 07:19:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904526c926sm584181715e9.1.2026.05.26.07.19.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 07:19:40 -0700 (PDT)
Message-ID: <ecc7cb66-791e-4d8b-9c3d-f172bfaf83d3@redhat.com>
Date: Tue, 26 May 2026 16:19:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/21] arm: sbsa_gwdt: fixup default "clock-frequency"
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
References: <20260303092532.2410177-1-imammedo@redhat.com>
 <20260303092532.2410177-8-imammedo@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20260303092532.2410177-8-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eauger@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
> Comment about keeping legacy freq, is wrong to begin with
> (should be 62.5MHz), but that value also doesn't make
> sense anymore as the watchdog is used only by un-versioned
> SBSA board and the later has hard-coded it to 1GHz.
> 
> Other potential user (arm/virt) also has system clock at 1GHz.
> 
> Drop misleading comment about legacy and set default to 1GHz
> to match both boards.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/watchdog/sbsa_gwdt.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
> index 7ade5c6f18..b739a3ce3c 100644
> --- a/hw/watchdog/sbsa_gwdt.c
> +++ b/hw/watchdog/sbsa_gwdt.c
> @@ -264,11 +264,10 @@ static void wdt_sbsa_gwdt_realize(DeviceState *dev, Error **errp)
>  static const Property wdt_sbsa_gwdt_props[] = {
>      /*
>       * Timer frequency in Hz. This must match the frequency used by
> -     * the CPU's generic timer. Default 62.5Hz matches QEMU's legacy
> -     * CPU timer frequency default.
> +     * the CPU's generic timer.
>       */
>      DEFINE_PROP_UINT64("clock-frequency", struct SBSA_GWDTState, freq,
> -                       62500000),
> +                       1000000000),
>  };
>  
>  static void wdt_sbsa_gwdt_class_init(ObjectClass *klass, const void *data)


