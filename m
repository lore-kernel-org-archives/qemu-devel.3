Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 204DBCAC587
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 18:08:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwliT-0003fJ-Gw; Thu, 11 Sep 2025 14:08:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwliM-0003dw-FH
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 14:08:11 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwliH-0004Ph-Nj
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 14:08:07 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-45b9814efbcso13473345e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 11:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757614083; x=1758218883; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p1zmPrH81sR7uoNtPdPVdeat1qj+DL9UyHRrfIR7R/M=;
 b=kosplScUAi8p+LzVoIOZI/LS0WcBbJIGkHC/8xX1LrP1oXny01cz8d5b/3Ah0G5NZg
 39OehNqGSG4h/AlzXkU8twnX/y/CjGJHXOQOFPT4J1qBZy/aJHlYX03MjoS2Fn0onXO3
 XQmobkr+JEGi0/Yh/9ZApLhebVEvF9VZI01lPt8GJADm/fY6ChKmBVmcO5fssTuqbm4N
 a7m5SjyVo6YwxdA8dCEasnACm4wvouFVOR4N5+lLEabwSZ+ARUYpqMRyNuZCxDcn/02g
 EGaYZc8oavyEH9mTVtXhFGFSwYEamAr+fsI0Jj2a4YFKwqum7V1AcM2YxF51eStFXjvM
 GVqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757614083; x=1758218883;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p1zmPrH81sR7uoNtPdPVdeat1qj+DL9UyHRrfIR7R/M=;
 b=C095QBCruJU+GicORPHog/T5gu71s+qnTHf/YkPM0PV3REyE4/JHUI+8zAPODTomih
 TXR9Da9OhcjeMP+O2MJQszQXC1lQruHvdgJuKqLxJzEmALzXEIvbr4ZJyr0tZyF5rKh/
 tddeAIvwGrWARAmuQ1lRoNMclNlk3EY6oaYm/QiZ75g7JpqalBGoXWWtQJcVZufLT+vu
 w3KedIvdWIs/o/IRW/zjawmztaJRGy6Z41XLEFnIQqW9KirgzHma87MG4Nif+FKqkfqP
 h0wkwcu+xwZV6iHdWY5M53JwOl/J8lSxPbn8CVjH0+IsgfobPevBaPtnGRZg2AwrgiTg
 wn9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXEfQdo6Mpe6vr5AfkCxfMHYBVfwBINEJWICkngsdvWbtDIqO5ns0KqV4SMwi1I3jSFd6HD9dYurec@nongnu.org
X-Gm-Message-State: AOJu0YzqMKvNsrSHVcrFeQoupGRNlzeEjKr2TNXM6fbFVQc5PrSvaSbc
 kn5u8aLGasFyEraGq/5l6nj8uCAXwVA1t2omxjTeTSKj09KhQCOM59z+Ujm+350a+xc=
X-Gm-Gg: ASbGncvjuh3U9SDPbIcRz34IhaESzRYaVkj4OnZpiSAxCO3dbWztwieiB017T71nevL
 H25+glgygEZqDuactx7RNYisstAZACrElpRAVI7J++TFgJxJh7XfWN76MRCU7d0WUgJK8V2MwxA
 Hn1XxD2k/ZtuYJInLxrEwQMEOhasej4oUUV2G5M9RCIw1ovIqZQQq9/bgYqGiY0NntGbCJJZojW
 3NImMKq5Hr1WwPd9LLHuda2aiYmPPalrRnTFSRK89ponjLVROkv610BGGypUqFjgpGXJzNOblHu
 0UffZ5Ie2Guk3/N3xVRePHsYQDaQ4gyhvk3covrkxcpiEzZZexD14WeTnBPyA50uYkDguWH9gVr
 fAS/FI/PiZiFl4iB595OChevKYpYa7vbBTH05i34ggOoe2E/1+OHzqtBz8JlQQwUFTv7P
X-Google-Smtp-Source: AGHT+IHKg91TUMdLAT2JDvs4ejuDz8boRG9EGXbVyt1ZktNCE5dyRibIMaFiDXt7K5HkExQ6z7K+yg==
X-Received: by 2002:a05:600c:548f:b0:45b:8ad2:76c8 with SMTP id
 5b1f17b1804b1-45f2125d5cdmr3002635e9.2.1757614083086; 
 Thu, 11 Sep 2025 11:08:03 -0700 (PDT)
Received: from [172.16.30.12] (ipnet-92-225.static.simnet.is. [157.157.92.225])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45e014ac1f5sm18070335e9.0.2025.09.11.11.07.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Sep 2025 11:08:02 -0700 (PDT)
Message-ID: <10746c43-9b63-49de-9a1e-0a428b6fdf6f@linaro.org>
Date: Thu, 11 Sep 2025 18:07:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/20] util: add support for formatting a program name
 in messages
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
References: <20250910180357.320297-1-berrange@redhat.com>
 <20250910180357.320297-19-berrange@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250910180357.320297-19-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 9/10/25 18:03, Daniel P. Berrangé wrote:
> @@ -157,10 +157,6 @@ static void print_loc(bool cur, error_print_func print_func, void *print_opaque)
>       int i;
>       const char *const *argp;
>   
> -    if (!cur && g_get_prgname()) {
> -        print_func(print_opaque, "%s:", g_get_prgname());
> -        sep = " ";
> -    }

Last use of cur in this function is removed.


r~

