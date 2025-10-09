Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97E3CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 16:48:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6to6-0001Yt-Q7; Thu, 09 Oct 2025 12:47:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6to3-0001Xv-0A
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:47:55 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6tnz-0004lz-IU
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 12:47:54 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e61ebddd6so12335075e9.0
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 09:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760028468; x=1760633268; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kkFJShCPRzclL+PLVGeCJ+9eP9tjTj4Lgzbu6jrD5Mo=;
 b=WC1DTRrWnbnRCoLW1yH2WErEC4n8I/6TfP9cZzMYT61Km2TTpQFU1vjvem2oralGQ7
 FkK2dhTO7U/OFx27wdHedDC6n38dNCrQXYL80zIoo5Wqx2MSXQyf3Ous3fwURb0NSCLm
 6Mgxu87QNLom5nazzz+HpAp6fchdIvCXuRivBlSMwW0Xcn986888NTwFcn7Hc4KDJ62x
 TDOXALn9rluJFbDaN6eBfi+jNp1qOz2h2+x5HaP+WBbGDvTJn0lSwP/tSlBGzQoPue7Y
 UoIP3kVcHVDdXeU7GlGX2q2WtiXmfPyljc0Auff7in3R0z3V45quzSI/4mkVLMkHUmdR
 rN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760028468; x=1760633268;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kkFJShCPRzclL+PLVGeCJ+9eP9tjTj4Lgzbu6jrD5Mo=;
 b=RtngoPaYGgLSJM7UiGvQaYHRnD2+rphPA5psFlYbXphi6cl53v6rdNpTwdBqKhXE+5
 qHmdNuf+qK8e9hJJ22fKvo9peMmi/ycyUyUizcvqGYFCfneNQTW0mjSalFieFLYSHe0p
 HOFHZ7ekwPvALovFGwqDzIyZGBA4TtqiRUpJ8Q72tml6KBEQgXqbU5vYr2SXCE8wgala
 Lrw1DkuAO3C+Kn2Q4HNST6QvfrA7L1b62UtMHM8B8FjT3M116aHQsVY513RNdgNAEHQ3
 aC+XhGiM7nkVj7tLcwqZFkCadG7bSF7NjwU/W2gyODOOM/3/nwCDTQuyQAI5LX9IT3H0
 4U9w==
X-Gm-Message-State: AOJu0YzthqCM1bX6gnmzYz4SDpTdl3Z+Ati5YHabj1WKk7pQLdNQzX5k
 ADwjdyRNTDNSM55zP56Pqs+kvqR+aq2Eytc4sX3bN5ptEZjGHV1W66+nREqYNHDxGPk=
X-Gm-Gg: ASbGncuGOBFroZaCDCWuD0pJ3Rv76bZaYmhvzWgnaPQSxB3WIF/L4VcEUspw2yB/j4M
 NgDCydo+ymu7PNleZVgOr8m0xNghXO9VRWv8tVUXA8I3qYzkRQMPNGcAvzSO2PdrA7KTdPqnROY
 LmGoBXb7To5FA2MgvmufktS6SInyr8HpeVrPlS6s7akcmj5Rb4tuvMrmN9c7g7Ywh/iYHu5HdSr
 FVVsAUJguBbG+440dm3Pr57mi2khxc3yNppz422bkcVlDbeeZAcAtrKuIhSkPnW/NbVvm0jFB9n
 +utbv/yguoojaugpkESxHlFw0K3p1msTDLjfCCG5rrAXs6urZfVUsUcZT6BD2nkp9/gzpMOxORD
 6y3Df7/tQQVUVz9U95dtv0V5Rg3fjOlGyBWR2u/6Sp7GXN4T31Egciubkc1iluEtz9C3/76WoaC
 CG19U9z2pp/RAbsIDVbQ==
X-Google-Smtp-Source: AGHT+IHl9zXdpbOHN61YhK9TwIZk6o+/cTSiJ3yEh4+jFsfIUBhgnZYaFPKzrpnQSJgc44jC67yM8A==
X-Received: by 2002:a05:6000:4014:b0:3fe:4fa2:8cd5 with SMTP id
 ffacd0b85a97d-42666ac4518mr4832865f8f.9.1760028467772; 
 Thu, 09 Oct 2025 09:47:47 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426cd9a025asm174957f8f.46.2025.10.09.09.47.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Oct 2025 09:47:47 -0700 (PDT)
Message-ID: <531f953f-6afe-4b61-a9ac-2e02cae2f6e4@linaro.org>
Date: Thu, 9 Oct 2025 18:47:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] docker: Remove 32-bit MIPS toolchain from
 debian-all-test image
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Aleksandar Rikalo <arikalo@gmail.com>,
 Riku Voipio <riku.voipio@iki.fi>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
References: <20250820142108.46639-1-philmd@linaro.org>
 <20250820142108.46639-2-philmd@linaro.org> <87ect3k3c4.fsf@draig.linaro.org>
 <592c3338-77f7-4393-aef3-7670e6ec90fc@linaro.org>
In-Reply-To: <592c3338-77f7-4393-aef3-7670e6ec90fc@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 22/8/25 16:49, Philippe Mathieu-Daudé wrote:
> On 22/8/25 13:23, Alex Bennée wrote:
>> Philippe Mathieu-Daudé <philmd@linaro.org> writes:
>>
>>> In commit d3322023bfe ("configure: unify again the case arms in
>>> probe_target_compiler") we lost coverage of 32-bit MIPS with the
>>> debian-all-test image. No need to keep installing the toolchain.
>>>
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   tests/docker/dockerfiles/debian-all-test-cross.docker | 4 ----
>>>   1 file changed, 4 deletions(-)
>>>
>>> diff --git a/tests/docker/dockerfiles/debian-all-test-cross.docker b/ 
>>> tests/docker/dockerfiles/debian-all-test-cross.docker
>>> index 420a4e33e60..bc74d65a634 100644
>>> --- a/tests/docker/dockerfiles/debian-all-test-cross.docker
>>> +++ b/tests/docker/dockerfiles/debian-all-test-cross.docker
>>> @@ -40,14 +40,10 @@ ENV AVAILABLE_COMPILERS gcc-aarch64-linux-gnu \
>>>           libc6-dev-arm64-cross \
>>>           gcc-arm-linux-gnueabihf \
>>>           libc6-dev-armhf-cross \
>>> -        gcc-mips-linux-gnu \
>>> -        libc6-dev-mips-cross \
>>>           gcc-mips64-linux-gnuabi64 \
>>>           libc6-dev-mips64-cross \
>>>           gcc-mips64el-linux-gnuabi64 \
>>>           libc6-dev-mips64el-cross \
>>> -        gcc-mipsel-linux-gnu \
>>> -        libc6-dev-mipsel-cross \
>>>           gcc-powerpc64le-linux-gnu \
>>>           libc6-dev-ppc64el-cross \
>>>           gcc-riscv64-linux-gnu \
>>
>> You also need to remove the references in configure:
>>

Expanding:

     case $target_arch in

>>        hppa|m68k|mips|riscv64|sparc64)
>>          container_image=debian-all-test-cross
>>          ;;
> 
> OK.

So actual patch is correct here.

> 
>>        mips64)
>>          container_image=debian-all-test-cross
>>          container_cross_prefix=mips64-linux-gnuabi64-
>>          ;;
> 
> We aren't removing mips64 yet. We will but since the reason is
> different, it will be in another series.


