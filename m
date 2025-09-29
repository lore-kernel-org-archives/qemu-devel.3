Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54BB2CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:25:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3FkI-0001NH-Ls; Mon, 29 Sep 2025 11:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3FkH-0001N8-A3
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:24:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v3Fk3-0000Io-Q1
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759159479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WoUrJogh2BxPZTjC0zNeJpXVARM7tPg2mnMFvSaU1q4=;
 b=Jls76yQQPU741lMDcME0DsDfdV6SeT4nzgpcDMAQ0TXgBLGJAsavr9MykoOnggV2RHzp+5
 SEpLurlmik9KII1PufDqceLPyMWttWSKGzXHRiW9EO7zoVKHq9Cfd95xrNezGEA2LVnNgW
 xcRnDWfnCDnEDsGTEfYDD8L9BnNA2Ho=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-dHRKF-FQPrKA3__LP166pQ-1; Mon, 29 Sep 2025 11:24:35 -0400
X-MC-Unique: dHRKF-FQPrKA3__LP166pQ-1
X-Mimecast-MFC-AGG-ID: dHRKF-FQPrKA3__LP166pQ_1759159475
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3f6b44ab789so2438507f8f.3
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759159474; x=1759764274;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WoUrJogh2BxPZTjC0zNeJpXVARM7tPg2mnMFvSaU1q4=;
 b=OjRFIiEcUIdtCVhQfBrYjwX9j0qoWtWU+6156BBW9o2H66PfqQaD6UG3jGFTkGO+LE
 w6FUVVyOOuXsIWThkOGzkSrMr1e95cwDLDkTPba15HyJbFo+G8y3JoQFU7qt20Hy8/1a
 qwziuoGrZSdxhvtgZgWLptkJRu+msfu2rTAA2uGkI9lVvU81uIGpx4kZImuL+Clw+91p
 9zh9+f/nLCotsf6FDvOJxzy7EfFYAmXnNqyi5OV1qfsjqgeYpM1IFytJqsX/XirqXTzm
 K/8wRDbQUv80ZRzuM2kx+IRdk1sjflmLP5FOMcg3Q8rMPnc1uDmctg6tx3W01gEx1ZJV
 SVAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1qc4C3ppdRB2HwND5htsiJbJOZDA4osr8hAXJRqT+/sMjPVKRmlzimuD75wwwxLJckHPUelRp/GZv@nongnu.org
X-Gm-Message-State: AOJu0YxqV2nvK2c3nFOTrNHCQYdLIFjNFaG0pBavZ7AkYqRQSQZmfd8F
 U4TPkUSRnRYrTFvs8N4hMhzH42F3kK0t0zz2sduvCm4I291WrVjwHsMeUReaEs22ohXeQ72u+gj
 Yr4eYCsgHaApgJsb7jyTk+HkPdhEkm15Bvc1x+zR9pkVb4tUqxmPZTaLy
X-Gm-Gg: ASbGncuC2rjXmXQuT1L6Ytm5IZPU51mUTicFc8x1AbTXfB/67gJM7Ju2rxWOeW28+FD
 0kF4gUamQPN4sBH9NjXOT2xYTFWp2PNhLdblM5kTcYax4XLXSalg7JYtmkNujumZRP6vSXJK0YB
 FfpsgI5rd9PGdc/DnmBfW5WT+N7/Zqf1pgPTeAV56T6+bp/aHz0lG3TPoMPiCt2m0nm1OZTrkiG
 /9aJGzI9tWgxJaBY7xBii1lAITuw2AMgw4cOYcbz+9jX6FPweidHNdokHttxnLBgPuwypBEJntK
 k0KmnvTNWQtOfqL792W7JBSSQSe0izXqb7tB57W+1bPZXUSRYzDCGUnwq1HapNe4RpXghm4KPa0
 dgp1Ulw==
X-Received: by 2002:a05:6000:1846:b0:3ee:15b4:846c with SMTP id
 ffacd0b85a97d-40e44682b8dmr15978322f8f.28.1759159474607; 
 Mon, 29 Sep 2025 08:24:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5Yzb23l6MmH8unBZNY4/rtxGZpv4PhTZdfmBHwrOXfx8ocXYEcsbvoS1enMHLAZgWu9N2Hw==
X-Received: by 2002:a05:6000:1846:b0:3ee:15b4:846c with SMTP id
 ffacd0b85a97d-40e44682b8dmr15978282f8f.28.1759159474057; 
 Mon, 29 Sep 2025 08:24:34 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-212.pools.arcor-ip.net.
 [47.64.114.212]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc5602dfdsm18563860f8f.33.2025.09.29.08.24.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Sep 2025 08:24:33 -0700 (PDT)
Message-ID: <ea0f5995-920f-4bda-8e03-e840f139bf4a@redhat.com>
Date: Mon, 29 Sep 2025 17:24:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 24/28] pc-bios/s390-ccw: Handle true secure IPL mode
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20250917232131.495848-1-zycai@linux.ibm.com>
 <20250917232131.495848-25-zycai@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250917232131.495848-25-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 18/09/2025 01.21, Zhuoying Cai wrote:
> When secure boot is enabled (-secure-boot on) and certificate(s) are
> provided, the boot operates in True Secure IPL mode.
> 
> Any verification error during True Secure IPL mode will cause the
> entire boot process to terminate.
> 
> Secure IPL in audit mode requires at least one certificate provided in
> the key store along with necessary facilities. If secure boot is enabled
> but no certificate is provided, the boot process will also terminate, as
> this is not a valid secure boot configuration.
> 
> Note: True Secure IPL mode is implemented for the SCSI scheme of
> virtio-blk/virtio-scsi devices.
> 
> Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
> ---
>   docs/system/s390x/secure-ipl.rst | 16 ++++++++++++++++
>   pc-bios/s390-ccw/bootmap.c       | 19 ++++++++++++++++---
>   pc-bios/s390-ccw/main.c          |  7 ++++++-
>   pc-bios/s390-ccw/s390-ccw.h      |  2 ++
>   pc-bios/s390-ccw/secure-ipl.c    |  4 ++++
>   pc-bios/s390-ccw/secure-ipl.h    |  3 +++
>   6 files changed, 47 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
> index 205de8bc02..579b7b4993 100644
> --- a/docs/system/s390x/secure-ipl.rst
> +++ b/docs/system/s390x/secure-ipl.rst
> @@ -67,3 +67,19 @@ Configuration:
>       qemu-system-s390x -machine s390-ccw-virtio, \
>                                  boot-certs.0.path=/.../qemu/certs, \
>                                  boot-certs.1.path=/another/path/cert.pem ...
> +
> +Secure Mode
> +-----------
> +
> +With *both* the presence of certificates in the store and the ``secure-boot=on``
> +option, it is understood that secure boot should be performed with errors

"it is understood" sounds weird to me here ... maybe rather:

If both, certificates are provided and the ``secure-boot=on`` option has 
been set, a secure boot is performed with error reporting enabled, and the 
boot process will abort on any error.

?

> +reported and boot will abort.
> +
> +Configuration:
> +
> +.. code-block:: shell
> +
> +    qemu-system-s390x -machine s390-ccw-virtio, \
> +                               secure-boot=on, \
> +                               boot-certs.0.path=/.../qemu/certs, \
> +                               boot-certs.1.path=/another/path/cert.pem ...
...
> diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
> index cd798c1198..92e3e1e021 100644
> --- a/pc-bios/s390-ccw/secure-ipl.c
> +++ b/pc-bios/s390-ccw/secure-ipl.c
> @@ -287,6 +287,10 @@ static bool check_sclab_presence(uint8_t *sclab_magic,
>           comps->device_entries[comp_index].cei |= S390_IPL_COMPONENT_CEI_INVALID_SCLAB;
>   
>           /* a missing SCLAB will not be reported in audit mode */
> +        if (boot_mode == ZIPL_BOOT_MODE_SECURE) {
> +            zipl_secure_handle("Magic is not matched. SCLAB does not exist");

I'm not a native speaker, but maybe rather "Magic does not match" ?

> +         }

Indentation of the } is off by 1 here.

>           return false;
>       }
>   
> diff --git a/pc-bios/s390-ccw/secure-ipl.h b/pc-bios/s390-ccw/secure-ipl.h
> index 87aa6e1465..d7786158c4 100644
> --- a/pc-bios/s390-ccw/secure-ipl.h
> +++ b/pc-bios/s390-ccw/secure-ipl.h
> @@ -58,6 +58,9 @@ static inline void zipl_secure_handle(const char *message)
>       case ZIPL_BOOT_MODE_SECURE_AUDIT:
>           IPL_check(false, message);
>           break;
> +    case ZIPL_BOOT_MODE_SECURE:
> +        IPL_assert(false, message);

Using IPL_assert() with false looks weird. Why not simply panic(message) 
instead?

> +        break;
>       default:
>           break;
>       }

  Thomas


