Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9034AC83F0A
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Jul 2025 17:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZYaL-00023j-TZ; Wed, 09 Jul 2025 13:27:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZYZ7-00010N-Q9
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 13:26:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uZYZ3-00084W-K2
 for qemu-devel@nongnu.org; Wed, 09 Jul 2025 13:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752081995;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tinj7o2qT74O6OD7exxZnCoLbtUywkiRXt4zmRD4qLY=;
 b=dMZ4fnUB4FUcEP74igCLJ31Rtx83jDp/6/1BUtbyGZ4ZIeTExnR5wKWAYlB+dCuMftJHxi
 4VF/bktJs1KEAotslO7Mchexy5hjlrHvV+8j8h5vzJHHB1e+sgUcchYyzCgUOJ5Bu4MiWN
 Ld0oz3DMeo//H+6tmqkCRKKl9fB64EY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-umXNTVC0PZ246riEIPvgdQ-1; Wed, 09 Jul 2025 13:26:34 -0400
X-MC-Unique: umXNTVC0PZ246riEIPvgdQ-1
X-Mimecast-MFC-AGG-ID: umXNTVC0PZ246riEIPvgdQ_1752081993
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-453691d0a1dso623445e9.0
 for <qemu-devel@nongnu.org>; Wed, 09 Jul 2025 10:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752081993; x=1752686793;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tinj7o2qT74O6OD7exxZnCoLbtUywkiRXt4zmRD4qLY=;
 b=PnIoQ44kxI9nURb17fDmHRDwYx9YsBlLqYJ1FK99EolL7wWWeN3Cz1LoEBjqUT/cjq
 tc72g4uS1ue4tHE80x+KbuQwaz8Isqi7Rt3ylCM2MFV09fRKMkCBYSFRp3GH20wZFynA
 +j22bg080eAiBiioisZNE0vrKSPCbQi7Op3fWekFdP6zsxZyPnQZ10nPVs4eBk/VpPAB
 w0PXg35ESSOZ1zFTqUL6lyQwjLkh/aktYpseiiYgepafsd0h+QQa5tZ4oIQl/3RnDC4J
 1cSFh1omuNJZYoxp6leQCAHQ5DSnT4tQwwiqlk7zwZaANgSsEO7MGEbtZipD8ZYtUh7Y
 72WA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkaCPXTXncpNTxBil6DOY/QjyN76ymfbvmF4Pm6uBJPWqIvyqiJ7FMGBbYRDQkuW8fR2qT60KJh8OK@nongnu.org
X-Gm-Message-State: AOJu0YxxyMQU1AXKXNWFAeB0DHU+mwpCxDa6lz4/sSzvV8iqX2j+6ar7
 GoI5HKfNXp+LAWzC4R7rvLcmh2DPxpTHvrJ3nQiHIM3NlvEOpTAqnpuIbp0xMZ8YP5EQfhJA1NB
 nbpzIHrPxdVk8rDRCGPXQKLrmj4HlSESMco+oAmY8USyJzNGqivqEROG1
X-Gm-Gg: ASbGnctIxahvdQwDQ8kc8yr2xXqY3abXvn7ktp8SJ6nJ/D8V8Fu3kOdlLTyVkcaUA+v
 y05I4Z9Di85HXO3ufq+NnvMCV0E5pQZzSbU3CYCty/Mr3sIGjXflQLEqgo5xi+Q1+YW+0uyXrFQ
 nY+HMd/S4Sx/fzRP7mIrrJwSz3Y628r0xB5BiWmUhdCPHx7CoXULYi4tyz7TT3YyaG0Xwk7KXYU
 bzXbV7eu5K1EdpH/Xm6KLr0YNYKCFPrijP1r2G1bfRPcMtDFD3CpvlILyqnltzK2e6KI/lVwhik
 g+1Mo2fKuGqsJDO4YcDA25oz7hueGE0URDmEQFaz3LzTfHQrU8XJdDSmrOSIn+/JM2rSTg==
X-Received: by 2002:a05:600c:548d:b0:453:5c30:a1d0 with SMTP id
 5b1f17b1804b1-454d53ae0a1mr27177515e9.21.1752081993078; 
 Wed, 09 Jul 2025 10:26:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL18TWFgYbdQ4Qx6FJrY/Tha3RQLnCQZh8Plw+je9CuK8wMPlztrzFt0C8mpODqGVuEMK5cQ==
X-Received: by 2002:a05:600c:548d:b0:453:5c30:a1d0 with SMTP id
 5b1f17b1804b1-454d53ae0a1mr27177335e9.21.1752081992612; 
 Wed, 09 Jul 2025 10:26:32 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454d5070fecsm34121345e9.31.2025.07.09.10.26.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jul 2025 10:26:31 -0700 (PDT)
Message-ID: <46f3c892-45d6-4d46-96ab-06e09db986f1@redhat.com>
Date: Wed, 9 Jul 2025 19:26:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] arm/kvm: shorten one overly long line
Content-Language: en-US
To: Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Sebastian Ott <sebott@redhat.com>
References: <20250704141927.38963-1-cohuck@redhat.com>
 <20250704141927.38963-6-cohuck@redhat.com>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250704141927.38963-6-cohuck@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



On 7/4/25 4:19 PM, Cornelia Huck wrote:
> Fixes: 804cfc7eedb7 ("arm/cpu: Store aa64isar0/aa64zfr0 into the idregs arrays")
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>

Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

> ---
>  target/arm/kvm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 426f8b159e82..8ab0d692d36a 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -230,7 +230,8 @@ static uint64_t idregs_sysreg_to_kvm_reg(ARMSysRegs sysreg)
>  }
>  
>  /* read a sysreg value and store it in the idregs */
> -static int get_host_cpu_reg(int fd, ARMHostCPUFeatures *ahcf, ARMIDRegisterIdx index)
> +static int get_host_cpu_reg(int fd, ARMHostCPUFeatures *ahcf,
> +                            ARMIDRegisterIdx index)
>  {
>      uint64_t *reg;
>      int ret;


