Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF66C83F09
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Jul 2025 20:49:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZFBb-0005mC-BC; Tue, 08 Jul 2025 16:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZDhF-0007OV-DF
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:09:57 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uZDhB-0005Po-Fm
 for qemu-devel@nongnu.org; Tue, 08 Jul 2025 15:09:39 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-ae361e8ec32so946204866b.3
 for <qemu-devel@nongnu.org>; Tue, 08 Jul 2025 12:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752001776; x=1752606576; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hI8sAmJ13x4dAhHqQ5KRW0VbwKRcg/Fsqe6mUGhQqN4=;
 b=tE16JDNUTAD1IbF93TC+Q4tuYCEg+x6kzQvuzKJJ4aot1w7KBeYkyYv+QlfKoe/gRt
 kqxQ0YD7yRzW3emFFmAf0OHg4oL5BmkgpiNX5eDrIJa60vB5tkFHH5f3aeMbAZFRKfQe
 13pO6gLYsq867rV59s6ZPqM8jqDShDew7AZUywn2c1hGgJA1jG7NBAcWd0lBjY5lnDM8
 i/3FYtP4c+VBRABd9Ha9eLAggwOIj3QcpbfieozadD3EdYP69soYyMb+L8abyl2TNCIS
 EQr9mD12VEZWioh28aNF/OpV6z1VVdA6Qbp2WNRs92DwGUMF/tGjjMTomCmsOy4bWEqN
 JE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752001776; x=1752606576;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hI8sAmJ13x4dAhHqQ5KRW0VbwKRcg/Fsqe6mUGhQqN4=;
 b=u28RlemITbv1+N2zq8HFFcLvnymhHeyM/dx9fHvFpKJl4eY1jIdhe+0Vb6SGaynG+F
 AYzmXdCH+Uh14vlExYuCPnqZbWN42vQKTpFILgJkVJGwY6NinEMq7DPIs1lwJo/kFuuS
 5XUBgC2weqVitx2fLvxIscv0pBo+Hg6w8SYP076GgqNG3y6iJZp3zwkCkqEpr235k8Ga
 ZAmnjo+bmypXfgTTPfjLT3qcT7QI5okwtNbaeeBv55sVj9sVdXMShj29pk+v54sPckYU
 8wvg2R07ygLzp4BK2l8fVmK32T7A5cjQXyvNvna4eEc6QqpImpsJfbX2bpjz+ToxnkHx
 i0bQ==
X-Gm-Message-State: AOJu0YwekYWETWJSM6j8wdo0YS6//lXMEfAkMSubRMzWsU8EBcc8MyYD
 7t7hh87qKs0BWT91jpymtJtDL74YbSUO/LHVROcqTAOqTM50Y73RZFjq3A7n6LeLcWrDuPnsa48
 OfXEAtys=
X-Gm-Gg: ASbGnctpvlCQqxV7KjmAaihyt0OHgvBSs/minSLn1wGqbNDN1xBqcWYtc09wIhUSSwr
 nn2nQq5iOP9VPb8yr7VTWvd7ink/AWAy+5xL9ROzX0axXsgJqEt0HOCI+Wr8C2uKdSu0PhTQlWs
 jxxG92J8qUjx02oeSKWMuNUINhl64aVI4tZteMlo6PGaT7UGj5gLqhybMr2i48PmoEe9XW0uqO1
 SqURzVT06Ky9aeXuHeScqlC/kGtEfzPz2xOiAMp7oNcRRbEX123TZRnoX1Kv/CXvRWNOXhh4Ma4
 XX2EK5oNEGQbJNtkEogx+qDqUF2gC1i39MyEJ1Ank7tGtftRmyk5FDCkzAuFg6I2hTNqkc4IAWo
 rfo8MauaU5OGHYguDEgVb1Q4TwTIdEA==
X-Google-Smtp-Source: AGHT+IEBF8Dg32b2zfK2LEUCiBIqsCkszQ/RmitWt476HpBfkMyJozJs4eVA6oF9QsJ7q9Ox3RaC1w==
X-Received: by 2002:a05:600c:4e05:b0:43d:2313:7b49 with SMTP id
 5b1f17b1804b1-454cd4cbd79mr24423785e9.12.1751970430502; 
 Tue, 08 Jul 2025 03:27:10 -0700 (PDT)
Received: from [192.168.69.242] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454cd39d0f6sm18081605e9.16.2025.07.08.03.27.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Jul 2025 03:27:09 -0700 (PDT)
Message-ID: <21692283-9767-4109-b14b-ef0ff787d856@linaro.org>
Date: Tue, 8 Jul 2025 12:27:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH-for-10.1 v6 00/14] target-info: Add more API for
 VirtIO cleanups & introduce ARM macros
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-block@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org
References: <20250707172009.3884-1-philmd@linaro.org>
 <20250707135403-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250707135403-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

On 7/7/25 19:55, Michael S. Tsirkin wrote:
> On Mon, Jul 07, 2025 at 07:19:54PM +0200, Philippe Mathieu-Daudé wrote:
>> Rather than re-spinning the whole "single-binary: Make hw/arm/
>> common" series, restrict to the API additions, but include
>> examples of their usefulness (hundreds of virtio objects
>> removed from default Linux build).
>> Time passed since I context-switched out of this work so I'm
>> not sure the DEFINE_MACHINE_WITH_INTERFACES() implementation
>> is in the form Zoltan asked.
> 
> 
> I think I'd prefer to defer cleanups to post 10.1 - already
> too much on my plate as I was out sick. Unless there's a reason
> I'm missing to rush this in? Is there a feature we want in
> 10.1 that depends on it?

Fair enough for the virtio patch.

Hopefully the previous ones (TargetInfo related, not touching
virtio) could get in (you don't have to look a them ;P).

> 
>> Philippe Mathieu-Daudé (14):
>>    target/qmp: Use target_cpu_type()
>>    qemu/target-info: Factor target_arch() out
>>    qemu/target-info: Add %target_arch field to TargetInfo
>>    qemu/target-info: Introduce target_base_arch()
>>    qemu/target-info: Add target_endian_mode()
>>    qemu: Convert target_words_bigendian() to TargetInfo API
>>    gdbstub/helpers: Replace TARGET_BIG_ENDIAN -> target_big_endian()
>>    qemu: Declare all load/store helpert in 'qemu/bswap.h'

