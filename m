Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 840F6CAC587
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Sep 2025 18:08:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwlit-0003we-5n; Thu, 11 Sep 2025 14:08:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwlin-0003mZ-6N
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 14:08:37 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uwlil-0004Qt-KY
 for qemu-devel@nongnu.org; Thu, 11 Sep 2025 14:08:36 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-45dde353b47so6751915e9.3
 for <qemu-devel@nongnu.org>; Thu, 11 Sep 2025 11:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757614114; x=1758218914; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yRq+qfcJI4eKuPU82aCqlnRDDqaFDfvfNkEiQUM3H78=;
 b=PRE70tjo141+LzyEdsUoPUYzNLRy3rO6M1jgcgsNV5LKBCRVKrtZtP0nmu9V2MMAeC
 79kZLW9Deeuu6Ys+JK2DOSnSSELAYqJQZaNcyyUCTveuiNUI7w8z2SiGL5/jnayd4uYL
 epkaV5nvaHzBMD1uA7HDY4PrMEITl8aA8iRoXyBE29GYWq6d6uYbCOK/KqWWGJYzHiXH
 //D8B0FKDbxNymkInHEGxn8JrVLG8/M63r2j02LplSwH3fQnOcIk5BcCXAwpSZRVOmLH
 K7M/5i7LAE2HovZDpBqyv7W1M1pvlRTGd5DVCRIy2VpwBU1igWvoLKsP81J4ABD3st1G
 +NCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757614114; x=1758218914;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yRq+qfcJI4eKuPU82aCqlnRDDqaFDfvfNkEiQUM3H78=;
 b=mhmbIkNHHE3ACw0a8/kmWCJX7qd0ffK7QuIaEFJDyEdqNi/kSW7JXOs6KF5RuBtaqW
 UtCKd0cTfJFMCsDztlk5B09xsKkB6PUFwD3dgHR0mmUvQmxCHbc+dqZnX0yqi6agxwr6
 vFBKAltvCgS52oEU7fyRlW5T4Ak/la9GDZFq7yIhVONjEBY3ywAf5HvkV+09X0aeWrTn
 istaa5iX9MomZkn8U3Bmp6p9GSJs1ty+VRTnRi6ImnLhZxkBNX6zNpAPvroOG6+ULxHZ
 A+3gmkkypHnGZs85DHN0JD48KAiRi9akZk7xOTTntw/GfZK1wuw1sLBp/Fu6+xrcSTpm
 +/1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgdCN+E92as2WnEK6OFZV4GwqjpqLtVWycEymVSCXB2fvTfR0vavBw3RQbaNyCOrcMbuN6TtrzmyWY@nongnu.org
X-Gm-Message-State: AOJu0YwJe4VO8Zxp9fCGpINM5wNBAjipsMeJIMDYleoHjm2vZOpDr9HE
 NKFbaAWLsK5RnyTUtXauysOxTFwQraOdbwkuL29TusltqjX6khipQxNby894wkeyCvM=
X-Gm-Gg: ASbGnctYUbZ6mvPmor4KDoySIGdlb/95fUczi1wPxWzWBPVPfg2zETNKFsX/6gV3dim
 vdxn/wT43oiM66xJJl15UkJL6UK9BLCyGf1QJdKWuq5iUBbBkQzLObW6I04QHbN1SlANWYa1Dri
 tvE34jfNsEtMf5V+xlppZ5JZGuRvoVbSeo0+8EEk4oVuZVfMhXqACNO2aZWmAvFL7gOc6vjiSB3
 taQGzXwP9lem7mK+2RPVqznrXNJzAED2HSlIuj4RzcSQdokT2oMy2M+R/TjqIVTBDGTNpIqgRuJ
 yKvvbtDRFXvu5r2AABV6a9DXl4QKecvdxMdBKuoVHRvwMchYoufnc1rooV/Nj++s/UnaMUZ0GD6
 gbrmqKQ25/csTdiDrIyQdz4t/aOAM+a+GHGYAbMzt2SThIAT8MNCBWHL5eROpfyC+eh4Q
X-Google-Smtp-Source: AGHT+IEoSKb7tyioMuD8S0l3UMpYKADoxnTnfh06cu3EuER6RYbYmqdAo1G/NBKaoWFHrZ+5ezzM2w==
X-Received: by 2002:a7b:cb87:0:b0:45b:9a3b:34aa with SMTP id
 5b1f17b1804b1-45f211d5828mr4342235e9.16.1757614114113; 
 Thu, 11 Sep 2025 11:08:34 -0700 (PDT)
Received: from [172.16.30.12] (ipnet-92-225.static.simnet.is. [157.157.92.225])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760777851sm3362996f8f.4.2025.09.11.11.08.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Sep 2025 11:08:33 -0700 (PDT)
Message-ID: <ef0c2811-d6a6-46c9-b0c7-fb0457901a2e@linaro.org>
Date: Thu, 11 Sep 2025 18:08:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/20] util: add support for formatting a program name
 in messages
From: Richard Henderson <richard.henderson@linaro.org>
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
 <10746c43-9b63-49de-9a1e-0a428b6fdf6f@linaro.org>
Content-Language: en-US
In-Reply-To: <10746c43-9b63-49de-9a1e-0a428b6fdf6f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x330.google.com
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

On 9/11/25 18:07, Richard Henderson wrote:
> On 9/10/25 18:03, Daniel P. Berrangé wrote:
>> @@ -157,10 +157,6 @@ static void print_loc(bool cur, error_print_func print_func, void 
>> *print_opaque)
>>       int i;
>>       const char *const *argp;
>> -    if (!cur && g_get_prgname()) {
>> -        print_func(print_opaque, "%s:", g_get_prgname());
>> -        sep = " ";
>> -    }
> 
> Last use of cur in this function is removed.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

