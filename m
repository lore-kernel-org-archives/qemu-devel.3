Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B4AD2E02E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Dec 2025 07:54:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vRQcv-0004wM-SJ; Fri, 05 Dec 2025 02:53:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vRQcu-0004w7-MM
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 02:53:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vRQcs-0005PC-Uh
 for qemu-devel@nongnu.org; Fri, 05 Dec 2025 02:53:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764921192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UDhj9fLlcMXVabJfiiiSCqpmgLpbktGCY3wZkBb0BAs=;
 b=hmhwyqDVyNUQZCs3AwGRt3Dq5w8Y1YEdumMTE+mGzvjgEhXd59ffXnTePnxBeUMP8ZPv84
 vq0PXK8NdP8iYFs0BiVvQSixiwWmzaGrp3jfWBGo/IphuKQKgIC/Hs1wwSslXYrLm7pu/L
 ClQGnCqEZzZc8y5kbjXkUzjCUgWr6b8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-vcptP4YoMKub52E1DKojgw-1; Fri, 05 Dec 2025 02:53:10 -0500
X-MC-Unique: vcptP4YoMKub52E1DKojgw-1
X-Mimecast-MFC-AGG-ID: vcptP4YoMKub52E1DKojgw_1764921190
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477563a0c75so9613385e9.1
 for <qemu-devel@nongnu.org>; Thu, 04 Dec 2025 23:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764921189; x=1765525989; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=UDhj9fLlcMXVabJfiiiSCqpmgLpbktGCY3wZkBb0BAs=;
 b=FFMdaEIYNtaAQeJImYNWGJDFKxnGiq0u7lMe2+MqL5U96/m4Ms/N+UOXm5AxR40U7a
 8IX9Ef1QyPxgIfIJY7plo2rUtZWuvO2ksWGyx95Qbwu8yiqku0kmO2ht8JN9GmyqBqMP
 wJXs48lwG7BLR0iYp8rkughfO6+F0fuxwHJibWOgd+2xfuzWGZ0GqwPOd7zjZRMR+DjL
 VfEHQhlV7xSPtZ2blmo2/gDgl1r5B4ihu7oIcOvWD43npdgmwymPKs8FXRxjbY1e2KPI
 xoZ8mb3xu+Jt0k9ThMtdqAvtAQlEXiikBeUjNsRO926gm+DPaa3Q+h9yGT++K+Du68pv
 3pvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764921189; x=1765525989;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UDhj9fLlcMXVabJfiiiSCqpmgLpbktGCY3wZkBb0BAs=;
 b=Pj2dWEqtKh/dCVImUtLjmhIa1zip1GwWT6QupajcIdw1lB9EGDdUiGcp0GI4pFBbMT
 JW8xmwXNwqqHLzEHB8hVj9L1zLiaA2swZFf/Iv3FmvFUtNLvMDXSEkNhatiUddmsWpkV
 GCfXwkap4TBIelidWczWTm2DiySxUEfUG8kPIJUaDsj3FLR/aWBXrtoxAWljZgp4Bv9g
 SDtDG+62CbsTgBJoSxuE62GgaSUh2lsICrw17B9mEl5OS7geJfN2ltNcUdSTcJpMcl9s
 9qUgiOlYmMdHwuQNwzzrSMUj1HJTyxeIxHj043u66yZm3C4zwhCYFn4ya3vuh0kSUGBP
 x3zw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaMGOvNTK/fCtVSD2e2v8toHl01J0b7i3a3PTXYMHjrw5FjJJGMWY69ELOQGz+d8mrRO00znHve5tR@nongnu.org
X-Gm-Message-State: AOJu0Yyku5av48EtGjCVnh+C4uF+MPC6h+v+nzpPveokEy/uOeb/HmQT
 VIv1uYZ2oYWmXmoRzaT2j0b5lHecj5AJ0m4hdqKtRVk+SYNWtLl//tSSKBjrrAGAXsaTzCebDBb
 CgZgGx7jOhQOpAUAeObAljneRjvJKbDMiae6SYe4TYbiYBKCmRkL4YvsR
X-Gm-Gg: ASbGncuv9H0Aon6sX2ASO025iQG9VM4Cq57mwvinFPXAcgsM3lAYr8D+yS3Eh7AUC9h
 Cl/g4eforlk8ufz5Mhjzshs7gM5PDooXJ2zHX1hxjbAylCWRvCMShs0YeyZ4yLxVAJm0riyJN4m
 9eemLq25ogNiQdiECQmW+cnTUdjmDICtP4irQLlMvXqDtVt9wpmk75eoHotan0QjdI8XbBzC0WY
 BD7t5kTP3vxn9Zn01l/Hlr2Uj1Py9Qu5R/7ozupI5xf6oSvKINPYa1VWGD2bWWTjdKINw+h29kh
 BGebyyBhHUOEQYofEW4+qdhRijo6/j7tKfTOSinoipVVrglXBBxqYJRdSbu+JB3aqWwbW8wxBlf
 pslKlFng=
X-Received: by 2002:a05:600c:4706:b0:477:8ba7:fe17 with SMTP id
 5b1f17b1804b1-4792f244c3bmr60467395e9.7.1764921189483; 
 Thu, 04 Dec 2025 23:53:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIxiwSUwXb/HExFCL4tjU0t5MFAnLJBCj4MQIcxf1oa7VGAdSlMFOhCzcgE8sz61mpsk+E1Q==
X-Received: by 2002:a05:600c:4706:b0:477:8ba7:fe17 with SMTP id
 5b1f17b1804b1-4792f244c3bmr60467215e9.7.1764921189110; 
 Thu, 04 Dec 2025 23:53:09 -0800 (PST)
Received: from [192.168.0.5] ([47.64.112.197])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47930c7473bsm109085035e9.10.2025.12.04.23.53.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Dec 2025 23:53:08 -0800 (PST)
Message-ID: <bf2e0c4f-d75c-43a9-b4b9-ead4c65864bf@redhat.com>
Date: Fri, 5 Dec 2025 08:53:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/11] gitlab: drop --disable-pie from
 aarch64-all-linux-static build
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
References: <20251204194902.1340008-1-alex.bennee@linaro.org>
 <20251204194902.1340008-2-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251204194902.1340008-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 04/12/2025 20.48, Alex Bennée wrote:
> Since we have upgraded to 24.04 with its new libc we no longer need
> this workaround.
> 
> Link: https://bugs.launchpad.net/ubuntu/+source/glibc/+bug/1987438
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Suggested-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>   .gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
> index 98d99193457..b4c0faab15d 100644
> --- a/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
> +++ b/.gitlab-ci.d/custom-runners/ubuntu-24.04-aarch64.yml
> @@ -41,9 +41,7 @@
>   ubuntu-24.04-aarch64-all-linux-static:
>     extends: .ubuntu_aarch64_template
>     variables:
> -    # Disable -static-pie due to build error with system libc:
> -    # https://bugs.launchpad.net/ubuntu/+source/glibc/+bug/1987438
> -    CONFIGURE_ARGS: --enable-debug --static --disable-system --disable-pie
> +    CONFIGURE_ARGS: --enable-debug --static --disable-system
>       MAKE_CHECK_ARGS: check-tcg
>   
>   ubuntu-24.04-aarch64-all:

Reviewed-by: Thomas Huth <thuth@redhat.com>


