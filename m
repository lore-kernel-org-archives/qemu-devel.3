Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C691C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 06:57:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCvCV-0008Os-MN; Thu, 08 May 2025 02:57:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCvCT-0008K5-D2
 for qemu-devel@nongnu.org; Thu, 08 May 2025 02:57:45 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCvCR-0004zq-S7
 for qemu-devel@nongnu.org; Thu, 08 May 2025 02:57:45 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-736b98acaadso704977b3a.1
 for <qemu-devel@nongnu.org>; Wed, 07 May 2025 23:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746687462; x=1747292262; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YZgzbnh2jhCx8JjKZt6EzyKU7MxHEvSMZT+8BE7IBOg=;
 b=kazDnDNN8fvOcgvOWeQ27tjrdsNEYGY6pi8HYq0IT21WFtkQPK+KCOZ3o721KGdikg
 EoapVMULNic6X2iLcUzGoIrWQHTcmup+0eO0s64k6lIs95rGV83jvIlmjBAqVWYt8kg9
 n7Vjp6dIZieEBi9QROKdT2qmsjk+OVWMglN1/+DVS3wTfBtvTJ1RhbDuT+V+SPEKBaxa
 6LHINLJwaMwghcBpXpxlCpnRKMQPbI2afnDGe2zGY9GjmbUBTzwQKOZfYpIAheU0j1fj
 5EGdjDJL+qfDt7XU5PSpWTVQck711HRAYzmxrz1II7w0597KFweHnu0EuipOMtzcHzRq
 DOpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746687462; x=1747292262;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YZgzbnh2jhCx8JjKZt6EzyKU7MxHEvSMZT+8BE7IBOg=;
 b=oS+mchtABxvfVUYe9yRlKjXo5iZ2yfhdTCjU3U9cAvIKAA69QhPTtYE9TihMw+3MMX
 cDbG8sjnqAYQKJb4rbvNTRA6NQPJWE0BhyLTxM2mZphYyRUXMy1fYS3uQBBRC9gb74Wf
 xkdOvgNSfivZ5wYc2meR3PfaXWxx4TEBHHUjayg1i6taVSEyAVjFUBdUMiPScFu6CD2Q
 U28ovJnvmeTaqB/VlnfBAQwKoIPJBABYxSukniJCQbC38uimVhvMmwkMswMdW99Ltld+
 2KSsRSla992g7HmvZTcHCwkcVTyDCI2j02Jw2ODlbqghBnYnELVAsXT0ZG6nFEEIYx1O
 fuEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5pqP5rpMY0TyAQwwi1rchEZCyHjUIJBH6lX3ljqkiELB12SP/7RSlUAWR6zT/RKaF6TlLeUqZEFaC@nongnu.org
X-Gm-Message-State: AOJu0YymoyPNAEdHL7Lugi17tCW3y7pJuGGFziccmxwJy5DRnhVQh/sQ
 oiHmhOALJYXO2V9uMFMn9qNh6gRwYWndSeikgI0u79uCDA3omoZ8DOXi+ApOYgg=
X-Gm-Gg: ASbGncsCcmGpsS78OiIfnyKsYKUrdXOAh0F1Ovl3wNbjWB9D1+p6sjaQkQMeLeklcWj
 iczqr3Iku0Zx72k5qPn8Myvcc8RXn6Teuaqvhi1/lQG6Ul8LV1QY0nsB5qehVlTa6s8kA3CU9IM
 ebGpTLDITXQ3V5vfMqVYqBAnG/BhmH9kYEdryVOmO3bXGvq7id8fGyzi6mq40/wE/8EflP0qQd7
 HiuOFW/dF/oGulsqLElNCSyckTejrhCsng8KjEr3Xa318xtdl2Hv10CFN2ez3YVT3pddUnR1lUq
 /v1Ez/BGLiU5AzBL4Lf2gZONsDJjDIwz7UneMYSoS+/W2F+tYBUcIDaI08KbuG4tvyp41Cg0AeK
 ixh4FdBdp
X-Google-Smtp-Source: AGHT+IEaBVvo/d9dNga+umgUXKoZQOev9kzZW6mgjt8A4t3+HwT0XUK9aRr9xH/07J6ty3z1OyGqLQ==
X-Received: by 2002:a05:6a00:4093:b0:73e:2d7a:8fc0 with SMTP id
 d2e1a72fcca58-7409ced952cmr7873084b3a.1.1746687462321; 
 Wed, 07 May 2025 23:57:42 -0700 (PDT)
Received: from [192.168.69.243] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058dc45basm12931851b3a.69.2025.05.07.23.57.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 May 2025 23:57:41 -0700 (PDT)
Message-ID: <cda1388f-283d-43ee-87db-add09ffefc49@linaro.org>
Date: Thu, 8 May 2025 08:57:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] qapi: make all generated files common
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, stefanha@redhat.com, peter.maydell@linaro.org,
 Markus Armbruster <armbru@redhat.com>, richard.henderson@linaro.org,
 pbonzini@redhat.com, jsnow@redhat.com, berrange@redhat.com,
 thuth@redhat.com, Michael Roth <michael.roth@amd.com>
References: <20250507231442.879619-1-pierrick.bouvier@linaro.org>
 <20250507231442.879619-12-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250507231442.879619-12-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42d.google.com
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

On 8/5/25 01:14, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   qapi/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


