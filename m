Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4732CD4F5E
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 06:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPaUA-0005TN-0Q; Wed, 20 May 2026 02:32:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wPaU8-0005T5-7P
 for qemu-devel@nongnu.org; Wed, 20 May 2026 02:32:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wPaU5-00053K-Ld
 for qemu-devel@nongnu.org; Wed, 20 May 2026 02:32:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779258767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=T4DOqcybdlND3lT/F7o8QlHfNT3S31zOmp/BLqQ4rSc=;
 b=gKbUp3uF4GJ7Xzysk+VOCMWJ4t9jL3FmViHww1tGrbpm9oiAWYtB4pX89rk/q0OHsNPdGF
 oTOZUN12OUNrbrYxuFEqtyNGBYFKPOYLIq6L6mgWxV0pwsK7Gk/a3VFS7uab1dzmu/nNVp
 8sJugK6/1JKl9O5LgbH/KQtHzgwZ/Fo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-ygzX_e6aPIeLAMnYI6tFaQ-1; Wed, 20 May 2026 02:32:46 -0400
X-MC-Unique: ygzX_e6aPIeLAMnYI6tFaQ-1
X-Mimecast-MFC-AGG-ID: ygzX_e6aPIeLAMnYI6tFaQ_1779258765
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48e79219704so31463185e9.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 23:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779258765; x=1779863565; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=T4DOqcybdlND3lT/F7o8QlHfNT3S31zOmp/BLqQ4rSc=;
 b=SGO7TUlOxYcGiixfwrHvH4JDL836sj+CUbI5I5dOZxqGK969PxHNuIEaCRZeg4GLNo
 oVpn301eDsReXtuv31x3yLm+TrescF4Vd7212umMfG250hj77GZ3Pypsx3XfV1cvBnGN
 zq+nBPAz6OGVT5mwMXmjSvGUx9aj2+TV7BaeA3jT/OlqOjo3LL/mKEgV3K+Leyr3puIb
 rmPLdHmzI/oXb+ahifZQAone+dBQh7ph3+hf/TS2jQaFJl+469eiFwOQl2kStmu7G5z2
 aObMX1Bou8LlIRM9lIdE7aztxKKLf2q/87SRICYoVWyujtruFpZF6jQf0gpmkdytglLG
 s/UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779258765; x=1779863565;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T4DOqcybdlND3lT/F7o8QlHfNT3S31zOmp/BLqQ4rSc=;
 b=ZG/09UAhTEp+p5KnLXvVyfr/jRsPNGsHds2ZMf1xSTZWBZrChfjoSDr3aHkKLQkC2l
 bGzs44eanm9u+i+8ZhrXcAUwlk3io20MbkHo3SbpUmta96OoyF39BJocfX150dUlvJPi
 1+lyy1Net1WNYerO2FADIndXFJYi9m1N9RW0aHQfeBa0C+Swcxd79kiW7pdDXwBccGtl
 WbSVqORplJmWkgLRDzOx3rXpKEJ30rakhWKcM8Kh/qz0Mw1JWQSDTI5EywiT0yBE7vrB
 85J1LfuBScL94jXKLB4PbL6s8IaxC8yy7y5C/akvJpPzx4u/bKl00wAXH136Do7Aw4Jd
 8LWQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/eqm+LtSTJQV4rCSKOjjZ+J3Iwm019K8mNwoGUGMAbWhNZSp4kJdLh0ABopNkYH4WJ5rVjTvQYucSw@nongnu.org
X-Gm-Message-State: AOJu0YyRNlmRLSZW4JDCveirzfNR+af6ZRnKUMumlQPTDGcxW+oa/kNn
 FJdII5FtogHwMStnKApStDtHKpEeN/i/R6HgXAqm6jUXOgTksADfJpVdG75CES3+OBGj79Iju5b
 EKQrXsIWtBsjQUWk/GYYMwjMq/RqU+riYQyZGQa9wqT4aUHJTLVar0wUY
X-Gm-Gg: Acq92OHBoXSBfRdhnsTWoKow/H3zcxUZq6MMZIgJVGU4ia0ewXBQ4ZKOI4tHYsdpZRz
 lTBpxJWpCqXxqEUPNYE+SnkqXURXyC6zz3eoRjcVvdmBSL3bF+T4HVVsafWyPTmWpqkQmvk5oxh
 52aSMUu7XbbV1h8SQaVFu5teFDMWTpPWnPl7PM3oZcE6F338Jb5gJtYljvV38ubJVRW/5M7mb89
 /QcfN5yiwSNVn4dJY7GVT429aiKnCTEx+SlwveVT8IFzb7FlFcLxL78N/06GjeKDWeRYhNzAXyM
 wwq9RTy6nxyG8Ydepo4j/MAP7yYcgPiczjnEtxdhLjPSBMxm09ZuoZJLgS5NTIJ4DjSevp5mDu8
 bPPkuOxLKOVJTSQLv/Fk=
X-Received: by 2002:a05:600c:4f13:b0:485:30d4:6b9e with SMTP id
 5b1f17b1804b1-48fe6328bb7mr383688515e9.21.1779258764700; 
 Tue, 19 May 2026 23:32:44 -0700 (PDT)
X-Received: by 2002:a05:600c:4f13:b0:485:30d4:6b9e with SMTP id
 5b1f17b1804b1-48fe6328bb7mr383687955e9.21.1779258764304; 
 Tue, 19 May 2026 23:32:44 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.232])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9ed2f738sm50083718f8f.16.2026.05.19.23.32.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 23:32:43 -0700 (PDT)
Message-ID: <abfb69ae-6501-4f50-9c5c-c0f9a938fb4c@redhat.com>
Date: Wed, 20 May 2026 08:32:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] MAINTAINERS: Fix s390x storage key/attribute
 device paths
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org
References: <20260519171240.97420-1-philmd@linaro.org>
 <20260519171240.97420-2-philmd@linaro.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260519171240.97420-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
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

On 19/05/2026 19.12, Philippe Mathieu-Daudé wrote:
> Fixes: 56e34834029 ("MAINTAINERS: split out s390x sections")
> Reported-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   MAINTAINERS | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index eda1e84268a..7749fe7f9bc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2975,7 +2975,7 @@ M: Halil Pasic <pasic@linux.ibm.com>
>   M: Christian Borntraeger <borntraeger@linux.ibm.com>
>   R: Jason Herne <jjherne@linux.ibm.com>
>   S: Supported
> -F: hw/s390x/storage-keys.h
> +F: include/hw/s390x/storage-keys.h
>   F: hw/s390x/s390-skeys*.c
>   L: qemu-s390x@nongnu.org
>   
> @@ -2984,7 +2984,7 @@ M: Halil Pasic <pasic@linux.ibm.com>
>   M: Christian Borntraeger <borntraeger@linux.ibm.com>
>   R: Jason Herne <jjherne@linux.ibm.com>
>   S: Supported
> -F: hw/s390x/storage-attributes.h
> +F: include/hw/s390x/storage-attributes.h
>   F: hw/s390x/s390-stattrib*.c
>   L: qemu-s390x@nongnu.org

Reviewed-by: Thomas Huth <thuth@redhat.com>


