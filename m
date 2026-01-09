Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75940D232E8
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve6zR-0003QZ-El; Fri, 09 Jan 2026 02:32:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ve6yy-0002pw-Fj
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:32:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ve6yw-0008KH-8Y
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:32:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767943944;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BzNRLjZb/4BMcgrorG+H/Rl00kDuvECnjZs2X7I1svk=;
 b=CCdkQDgjT+aUHbFaaGdU00/btkRT0XrxFzdfcDHLp1omTK6k7fJipiuCV644PNEvswaC/L
 racq/RkGHWqGqdTG8nV1hSOHY1vMRhk56heyaTLLiKk6HNtqi0ZjSOelfb2vwmcMesW5v1
 14q0WvTPigPEpmhk9w/1tgmxlivEybo=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-3iucan_QM22s8FaAHO2tsQ-1; Fri, 09 Jan 2026 02:32:22 -0500
X-MC-Unique: 3iucan_QM22s8FaAHO2tsQ-1
X-Mimecast-MFC-AGG-ID: 3iucan_QM22s8FaAHO2tsQ_1767943941
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-b8395caeab6so676239666b.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 23:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767943941; x=1768548741; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=BzNRLjZb/4BMcgrorG+H/Rl00kDuvECnjZs2X7I1svk=;
 b=MV7C69RElfQ81FYxvicIkHO7L6UAoAuuKWnEGaWLag4c7m1WqdJcVHz+AueCZv6pcP
 gMHK1jPn5rk/MtMq7nb/IXOMs/RLZ/cmYiYtHttr3FcpYoepiSPenZayjQ6GjWhi388E
 dC8EUcTGuo6zmGzmhAK0/bOM42y0gEp7rFP59H/BccH8d6U2sd/DcnroK7dJqz4j85Qr
 Xe/hYSsc5Qi2f2QjwIl4lQuuOMa5j99/9e9TZaG+K4oNFx1OS9cT41JGCGGwkkqPCqdy
 4JLJi63l8UYxbfBu0aUHAnzYy9KREo1DdeT7pyF4TXRDQaJJ9Ijs8FeA+R+P9S2ht6v2
 foCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767943941; x=1768548741;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BzNRLjZb/4BMcgrorG+H/Rl00kDuvECnjZs2X7I1svk=;
 b=Sd5opmshMF9Jn1sTNKE6uZWx9p3r3gzyqrPnDN/zal1dvOiWv9nh4+1KJ+wH4y8ISM
 Ev9yvimcto3rODQwtgj6AvOC1zfClQE5s15mLe2Bh7F5PQq47dkY87GcFqK6ZXrwkR7i
 lG8Hugoo068xYjzsmI1juo1Z9nkAdcIqFKqpgUsQ4xDJsa+f1/KXVxyiy8X6hfvx5s5l
 JNEMTeNUikGEIAttZIKaKtxNVbjPOCigzGZLGYlquMQtv5IrZMe/k+E5AoShuiFXx2H0
 Z0y/XX2oVm2BNYZidGybENGqS1ApgYY0WRp2fq6csaqjR+rfyQNauvsE57Am1MqncqLQ
 FhYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUMZ2Dd7+WPklSUIUgWT4brbt+f0eFcz+PwsNSX8C+Q1Avo74iuceWtcAIwOSfDa97+rrjlHIVt1YXd@nongnu.org
X-Gm-Message-State: AOJu0YyYryPMrx+wGnlH51PNJsigSq5V+aglfwp5cUaW5hrgTxe5nXYq
 rHONVoY+jCvuDKuUTmO+z/aGq/rJkAF/xoph2KP3krBTHZ596yyPyfgxJMXTDcw14czak7AIbu3
 e3uYHPEQ2w9wAfr1mohrlR40Y4QOzZLoYw6Cnsnc9+sO1Q6GhAnWurFhF
X-Gm-Gg: AY/fxX4lATRsokwjVL9kQDwsOf1QEudyUunzLKPS3sP1YlMfK7MvUJZ/zsncpPg/1R+
 EivfRYLZLxz9INAi287R1q9Td5alKbI+LA7g7gaFutaQ6YuoURUpUhZkexEapZABKwwbHPi3L3M
 JJzgUtRTXJL8ArMGh3pjY9lUjuE3vX7Naog7wLFLLrze9zUikYS/4skDGXpHkNq47Y6tnaugR1f
 CBl55CKTDe6OEp9HK27+9QMXQvbZHdwr0OqFJIApoOC5J24LvcLSjHTImImesaDKKtVlko6zBhG
 xPOuhni6do7eH+W9DjZuOVphUzuUvVU0qtty5f+RPDLqf/oR4bVVBhamvv5MGSNbWYkOwXmXeBG
 Q8pG8oqQ=
X-Received: by 2002:a17:907:9716:b0:b80:411f:aa50 with SMTP id
 a640c23a62f3a-b844538b340mr974153866b.48.1767943941472; 
 Thu, 08 Jan 2026 23:32:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvZixlSYYVL1lD9iGLVXwaDXn+nfRwEZfm4/Yo8Tae+w6pSGblE86ggKN0sBuQQh3hzsfIDQ==
X-Received: by 2002:a17:907:9716:b0:b80:411f:aa50 with SMTP id
 a640c23a62f3a-b844538b340mr974151666b.48.1767943941052; 
 Thu, 08 Jan 2026 23:32:21 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a27c0bfsm1059827966b.22.2026.01.08.23.32.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 23:32:20 -0800 (PST)
Message-ID: <8c10c955-685d-444b-bb76-cbd1d2ceb395@redhat.com>
Date: Fri, 9 Jan 2026 08:32:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 24/29] pc-bios/s390-ccw: Handle true secure IPL mode
To: Zhuoying Cai <zycai@linux.ibm.com>, berrange@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, jrossi@linux.ibm.com,
 qemu-s390x@nongnu.org, qemu-devel@nongnu.org, brueckner@linux.ibm.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, pasic@linux.ibm.com,
 borntraeger@linux.ibm.com, farman@linux.ibm.com, mjrosato@linux.ibm.com,
 iii@linux.ibm.com, eblake@redhat.com, armbru@redhat.com, alifm@linux.ibm.com
References: <20251208213247.702569-1-zycai@linux.ibm.com>
 <20251208213247.702569-25-zycai@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251208213247.702569-25-zycai@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 08/12/2025 22.32, Zhuoying Cai wrote:
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
>   docs/system/s390x/secure-ipl.rst | 13 +++++++++++++
>   pc-bios/s390-ccw/bootmap.c       | 19 ++++++++++++++++---
>   pc-bios/s390-ccw/main.c          |  7 ++++++-
>   pc-bios/s390-ccw/s390-ccw.h      |  2 ++
>   pc-bios/s390-ccw/secure-ipl.c    |  4 ++++
>   pc-bios/s390-ccw/secure-ipl.h    |  3 +++
>   6 files changed, 44 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/system/s390x/secure-ipl.rst b/docs/system/s390x/secure-ipl.rst
> index 675724d324..a03e59ae14 100644
> --- a/docs/system/s390x/secure-ipl.rst
> +++ b/docs/system/s390x/secure-ipl.rst
> @@ -64,3 +64,16 @@ Configuration:
>   .. code-block:: shell
>   
>       qemu-system-s390x -machine s390-ccw-virtio,boot-certs.0.path=/.../qemu/certs,boot-certs.1.path=/another/path/cert.pem ...
> +
> +Secure Mode
> +-----------
> +
> +When both certificates are provided and ``secure-boot=on`` option is set,

When I started reading this sentence "When both certificates are provided" I 
wondered why two certificates are involved here ... so this sentence is 
somewhat hard to digest. Could you please rephrase it?

> +a secure boot is performed with error reporting enabled. The boot process aborts
> +if any error occurs.
> +
> +Configuration:
> +
> +.. code-block:: shell
> +
> +    qemu-system-s390x -machine s390-ccw-virtio,secure-boot=on,boot-certs.0.path=/.../qemu/certs,boot-certs.1.path=/another/path/cert.pem ...
...
> diff --git a/pc-bios/s390-ccw/secure-ipl.c b/pc-bios/s390-ccw/secure-ipl.c
> index 8733254cfb..bfe021fffe 100644
> --- a/pc-bios/s390-ccw/secure-ipl.c
> +++ b/pc-bios/s390-ccw/secure-ipl.c
> @@ -296,6 +296,10 @@ static bool check_sclab_presence(uint8_t *sclab_magic,
>           comps->device_entries[comp_index].cei |= S390_IPL_COMPONENT_CEI_INVALID_SCLAB;
>   
>           /* a missing SCLAB will not be reported in audit mode */
> +        if (boot_mode == ZIPL_BOOT_MODE_SECURE) {
> +            zipl_secure_handle("Magic does not matched. SCLAB does not exist");

s/matched/match/

> +        }
> +
>           return false;
>       }

  Thomas


