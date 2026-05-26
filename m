Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C880CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsuy-00032G-FU; Tue, 26 May 2026 10:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wRsup-00031M-Ia
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:37:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eauger@redhat.com>) id 1wRsun-0005zp-2i
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:37:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779806271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RgCfk9VGyvOdsQ/VBQnBbMM85hx/l+tI/fX8KGz1+7U=;
 b=EiqlmHWRK61+Mp55lObM+JFlm6qkH7dUx8PTyJ5fM4d5ZpIzAcNlYBVZcKkw0Xw7F6tiM2
 vL+XxNbCr+u9CIbJelSuQL0Pi9T2cf2UykmVm5L/SLkvPdqg3KLnFFGylFfDxlPgOcdOhT
 ykW8PV9mv5p89DGa8lybVwC7QUYyleM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-uZy_KG8TORmaZveO1nxaPQ-1; Tue, 26 May 2026 10:37:49 -0400
X-MC-Unique: uZy_KG8TORmaZveO1nxaPQ-1
X-Mimecast-MFC-AGG-ID: uZy_KG8TORmaZveO1nxaPQ_1779806268
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4905428aad6so28693435e9.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779806268; x=1780411068; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RgCfk9VGyvOdsQ/VBQnBbMM85hx/l+tI/fX8KGz1+7U=;
 b=lT6SBxWNnUMlqVV2tsER9vwtqrPfEo7JRahvsTT5eZfb3CjeEUD2yZD8P3oOON2Rpb
 Q+H24OuWnePQYFTqcmumRloi/dqsy7toR3eE/0RNuZTCQmLWBhjZXtulnFtj3ef2d50z
 Fu99hjH0pW/nTFYRKvHUMDRG7uYLo6aBsOUv/gno/YIAVQ2tIgrFPdpegUypL5Oacgsh
 RjeTaeS0UrzN7Tw9JcUpoCIXRZDBmILmWGlN19RJdUuEtCLjwAOsQuRhWdzi18kRRSYu
 S+gjxyE8Egz831pUnVwYJw4e20ReLkTo7V0nVpuPEqDK2f+Z2Ls91ciZMLMJdHzSD/Fr
 1z2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779806268; x=1780411068;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RgCfk9VGyvOdsQ/VBQnBbMM85hx/l+tI/fX8KGz1+7U=;
 b=hjI8RpuwFURda+Pxa4S6sqtUs71Ib48OZhoujJ/XX2XdE3E0OR65WYQhD1Br7yv6bH
 7lXppuDtn6i3ikeEdK6xfvsyaT9luTe9df0eylrr39QU0jQDCQfZYk1OpWYgGj6Ysnis
 bTSSWgzkoBGA/nJw5RcP/CZa3sSSLzZM+tb3hWSDy22O4j52CQ34ajW7UyYtbwRcrQ0s
 uj6rMCst6nI/419JSR9khn89tyJ32DOJGjpPv83NvYPy2zaz9E5Cca/ZVrUqcVQOJ8V0
 +pZiE5UfLgJSGSJRFWNySi1LmmjKThAcWUPw5HP9XwIbCYT3EjpZmOIKuvewZvZU9Pl/
 TqGw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/jhbCW1CK1ujm58PcS8BykVbSBs6KggOrUR9R9/CdQBlW7dSZREOBavBf9rfgRUzYPPKxbwTKEfmf2@nongnu.org
X-Gm-Message-State: AOJu0Yyrp6UZGCnxwpPSHrWMfIvKdVqaWpQ4PsqVD7LOYyUTqKRBRbHP
 K5vA036eDo4tVzgkVkZWXYeZ9D//RBBoXX4Hl7BmqMUqgFtiWAOqQMvxw4e7m/leJ9SOF610YwQ
 yog6uk0xfTX6c5YzeAZ8ZJ7KQH/KqjWWYrm+K8sEKMkKSUEPnPVfmtRSQTqYmCnpf
X-Gm-Gg: Acq92OEZoaFGm0AnTDw3TvziZ2yNUo9t/QdJDNXVhN/zUDa1AY1oDF5qeCcKetOTn2a
 h+wwawn6HEwOY9q5+/I+sQ3bOdW/75wTARNqa+9tjMzWD7tJzHOuSpsfe4HBlqzsLTmRv2caf7T
 BBjY16NztSHTladEIBSIK+pLyyTdC6aNRNptAl6WfZnka++O+WSl5tmPpF25DKCDNrKk2Hm6e1N
 /GFcgyR7ntlWiFloNF/aoJV26sibBIWGP4ejeU8eRlIiT5+4KWolNMjq2NAy5u6Z0SGkP4Gyk03
 PKl+qoPIWd8iKyQDnB5PzQRS7sADpMV6k415PY+d19Es0qc6svZTiUnWYmzMQU5lZs4C5j3wJ1y
 iySOiObpUaKFBkWrGzeMLlNoeYRaCWKZj9c9/smxHXGCIStHMU/VC0LqpFT73TtvI
X-Received: by 2002:a05:600c:35c8:b0:490:44eb:c1e7 with SMTP id
 5b1f17b1804b1-49044ebc2d5mr345205735e9.30.1779806267922; 
 Tue, 26 May 2026 07:37:47 -0700 (PDT)
X-Received: by 2002:a05:600c:35c8:b0:490:44eb:c1e7 with SMTP id
 5b1f17b1804b1-49044ebc2d5mr345205245e9.30.1779806267562; 
 Tue, 26 May 2026 07:37:47 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454a0b82sm348259265e9.9.2026.05.26.07.37.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2026 07:37:47 -0700 (PDT)
Message-ID: <98236231-c7d5-4866-8cdd-9d318f4d0634@redhat.com>
Date: Tue, 26 May 2026 16:37:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 18/21] sbsa_gwdt: reduce code ident
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, anisinha@redhat.com, pbonzini@redhat.com,
 peter.maydell@linaro.org, shannon.zhaosl@gmail.com, philmd@linaro.org,
 zhao1.liu@intel.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
References: <20260303092532.2410177-1-imammedo@redhat.com>
 <20260303092532.2410177-19-imammedo@redhat.com>
From: Eric Auger <eauger@redhat.com>
In-Reply-To: <20260303092532.2410177-19-imammedo@redhat.com>
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
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  hw/watchdog/sbsa_gwdt.c | 38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
> index 40d80f7f2b..91f9a4202c 100644
> --- a/hw/watchdog/sbsa_gwdt.c
> +++ b/hw/watchdog/sbsa_gwdt.c
> @@ -105,25 +105,27 @@ static void sbsa_gwdt_update_timer(SBSA_GWDTState *s, WdtRefreshType rtype)
>  
>      timer_del(s->timer);
>  
> -    if (s->wcs & SBSA_GWDT_WCS_EN) {
> -        /*
> -         * Extract the upper 16 bits from woru & 32 bits from worl
> -         * registers to construct the 48 bit offset value
> -         */
> -        timeout = s->woru;
> -        timeout <<= 32;
> -        timeout |= s->worl;
> -        timeout = muldiv64(timeout, NANOSECONDS_PER_SECOND, s->freq);
> -        timeout += qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> -
> -        if ((rtype == EXPLICIT_REFRESH) || ((rtype == TIMEOUT_REFRESH) &&
> -                (!(s->wcs & SBSA_GWDT_WCS_WS0)))) {
> -            /* store the current timeout value into compare registers */
> -            s->wcvu = timeout >> 32;
> -            s->wcvl = timeout;
> -        }
> -        timer_mod(s->timer, timeout);
> +    if (!(s->wcs & SBSA_GWDT_WCS_EN)) {
> +        return;
> +    }
> +
> +    /*
> +     * Extract the upper 16 bits from woru & 32 bits from worl
> +     * registers to construct the 48 bit offset value
> +     */
> +    timeout = s->woru;
> +    timeout <<= 32;
> +    timeout |= s->worl;
> +    timeout = muldiv64(timeout, NANOSECONDS_PER_SECOND, s->freq);
> +    timeout += qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +
> +    if ((rtype == EXPLICIT_REFRESH) || ((rtype == TIMEOUT_REFRESH) &&
> +            (!(s->wcs & SBSA_GWDT_WCS_WS0)))) {
> +        /* store the current timeout value into compare registers */
> +        s->wcvu = timeout >> 32;
> +        s->wcvl = timeout;
>      }
> +    timer_mod(s->timer, timeout);
>  }
>  
>  static void sbsa_gwdt_rwrite(void *opaque, hwaddr offset, uint64_t data,


