Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90373C369D5
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:35:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RLU-0001XX-SU; Fri, 25 Apr 2025 18:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8RLN-0001Ku-Sm
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:16:27 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8RLF-0003VF-4J
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:16:25 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3913d129c1aso1839226f8f.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745619373; x=1746224173; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1B5bfHQA32ByEyNRaIccvyVfRoxcXRJl6KVjp2Ex+n8=;
 b=Z9ADq7bJoPQqLSQPWp7Hrd0gczceNOFPMhbSBRyerhKvKxpuTJ2gEHTj9tMIs7Kb/b
 Sj7LmqykdpYgQitIe4eNXdXb/UKEK54Uk7fWyrn5kNXqY7yoMTpKpLAAmWeP6YTXXRYY
 N/TSY85kU3ItkmzM1sosoyUBN8wJtkspAcjoAuacIpjfDq0Q7jdqQMc6nB5UFIfbH4xV
 pOO920Kf/QAR8ryemqnO9TT3jQQLH3C4GzjuFe8wntoQVRWlOAkGZmztS7SYrythrxGE
 EFtcxoJYkSgZ2+WHa8psaYV5Bin26ankkhFE++HGoc40Tv0VNeJexyGqEC6dsMOCrbNW
 n9Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745619373; x=1746224173;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1B5bfHQA32ByEyNRaIccvyVfRoxcXRJl6KVjp2Ex+n8=;
 b=iAo4s83JeuIMzSRSoMXL3wDN4GU8VeTbAOrHLbHl6RXMvYtXY0+DW2+2kglS/gpUjf
 cn4wE85gX8g1M/k5QzPnT/9m/bYsq2uE2prsnGrIBIhIuJjS3k/Ejxvdok6gyWyn1ro3
 3ytArnn0H7uRbQqeARnFyLuhjYN4NNwji1eGFInIpkWglLNA5HIxz27+pmZ18Ojj8+i0
 ZvMu/S2XD2UnAo2hbBq57bQm6vIRT1kjXYm5YWLwyl3DnIEZ1xIoFFg4/zEYrdngBo1/
 K0NS+Bm2q6JY6XwzH4CaAfhV2a8hqwKRtpFeUvO/aA372cZgtZPiLoe+aBCcsd8mTUpl
 2Ohg==
X-Gm-Message-State: AOJu0YywmMMjkAVvjXBRkadOYjvwzE12paAh71N2pjG5gfKQUiGoxTPU
 ydieND9KHWO6czieG3Yx7grJXBXGYYyh2iDxcpyFmjTwDqPNA0WwOTHcgVE4Kw4=
X-Gm-Gg: ASbGncvQqw9bPge9Je+l7cI6725d9KMLOHk5/XxfbJJvaRytFrqvJpl2CaqDb9VTdua
 SwJ1Meoa5/TGuM/LWyhJjw3Qmuxjs2YE+IvAbctv2c4+ZqSfp69VCsQBbs2ZZ8Jng7eTUmo1k9R
 X/8dOBITXc7DJCxb6Tl8JCDeD2NfYbptQKt9eLXU5wm+p6uu9W5KwbSZP+h4pnTd/BC3Gvia+f4
 RwjHw99TAXRCdMOXROpXSgkQS848uoG1BjON8O/p23pBP8ty/M7xAPwlvL0gl/Dk0zV3AXh0uCs
 WxEl0zgdH7qbIHr57DF/dnwmf59BEimVN4osKMosAyYSnKsAbeDLDELgup1Sm4n188RZVADFdng
 RxzNj2Jhl
X-Google-Smtp-Source: AGHT+IHi3/5mhxBeC6tl6hzRxBOyOxq0pLI01JAkNMs8ucJBRsuoX0myxbTVOT3i40MYnnWmGlJS+A==
X-Received: by 2002:a05:6000:40c7:b0:39f:d13:32a with SMTP id
 ffacd0b85a97d-3a074d4f2c9mr2939428f8f.29.1745619373535; 
 Fri, 25 Apr 2025 15:16:13 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073bbeb5esm3567829f8f.0.2025.04.25.15.16.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 15:16:04 -0700 (PDT)
Message-ID: <305d68df-b690-4a93-9a08-925cddbac8e3@linaro.org>
Date: Sat, 26 Apr 2025 00:16:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] single-binary: make QAPI generated files common
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, stefanha@redhat.com, 
 Michael Roth <michael.roth@amd.com>, pbonzini@redhat.com,
 peter.maydell@linaro.org, thuth@redhat.com, jsnow@redhat.com,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250424183350.1798746-1-pierrick.bouvier@linaro.org>
 <aAs6Q2GiBUbUCc2I@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aAs6Q2GiBUbUCc2I@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 25/4/25 09:35, Daniel P. Berrangé wrote:
> On Thu, Apr 24, 2025 at 11:33:47AM -0700, Pierrick Bouvier wrote:
>> Feedback
>> ========
>>
>> The goal of this series is to be spark a conversation around following topics:
>>
>> - Would you be open to such an approach? (expose all code, and restrict commands
>>    registered at runtime only for specific targets)
> 
> QMP defines a public API between QEMU and external mgmt apps, and personally I
> like the idea that the API exposed is identical across all binaries and thus
> the API becomes independent of the impl choice of combined vs separate binaries,.

I tried to expose all structures / unions as a first step (not yet
commands) but realized even structure fields can be conditional,
see @deprecated-props:

   ##
   # @CpuModelExpansionInfo:
   #
   # The result of a cpu model expansion.
   #
   # @model: the expanded CpuModelInfo.
   #
   # @deprecated-props: a list of properties that are flagged as
   #     deprecated by the CPU vendor.  The list depends on the
   #     CpuModelExpansionType: "static" properties are a subset of the
   #     enabled-properties for the expanded model; "full" properties are
   #     a set of properties that are deprecated across all models for
   #     the architecture.  (since: 9.1).
   #
   # Since: 2.8
   ##
   { 'struct': 'CpuModelExpansionInfo',
     'data': { 'model': 'CpuModelInfo',
               'deprecated-props' : { 'type': ['str'],
                                      'if': 'TARGET_S390X' } },
     'if': { 'any': [ 'TARGET_S390X',
                      'TARGET_I386',
                      'TARGET_ARM',
                      'TARGET_LOONGARCH64',
                      'TARGET_RISCV' ] } }


