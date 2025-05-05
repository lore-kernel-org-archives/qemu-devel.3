Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BD1C3ABAA
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 18:52:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC0vT-0003vc-HI; Mon, 05 May 2025 14:52:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC0vK-0003iJ-4A
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:52:19 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC0vI-0007P5-3S
 for qemu-devel@nongnu.org; Mon, 05 May 2025 14:52:17 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-3014678689aso3746577a91.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 11:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746471134; x=1747075934; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=00bWzvaWCIBwpMCAX5b1llfSuwpHrhqcBu5fE9MIR+c=;
 b=EyIqmhV/cnewn/C64FbmNNpaTzXS2Q1dSmg4FzUCUZ+8A9i1QoWQjuydxD2jhwi3rp
 e81bbrtA9Due4z8JuSn4TVe/6Dm/iPonmh9UgtELdhrn7XchE5MxX20VTUII6NYswrJl
 PUyhd0zQMuPE04s3w32CG1m97QygQfBMUuEX7tz3ki1MKCRlQ7NtKbbZX7laX1KqXuXS
 paAP78+bdVaoTcyo6XSTjWSJQYHN3nvCdOU5Q0kTxjB2+R8xu4CRUdoRKRoaV8ZjRkDJ
 9pddMsSlv67+kCnXHGOfNn/Uev5pHf3T0VONtHrIixgMaeyQVwN1TMLx3tZDc+rp/v23
 XXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746471134; x=1747075934;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=00bWzvaWCIBwpMCAX5b1llfSuwpHrhqcBu5fE9MIR+c=;
 b=KnQIbxj5ZgGi0HRgxgNDXMBVa1psJm2zQfgSM3F7OjyOkTXw9ah+4Zwhujo+v7ydNn
 L66osoh5c+n8IFhaPk8cVrCF6hB3IB7V4Iu1Vu5EENXZttqyEjQnbyooKeQxWV/VLEcs
 9EMxDPq7g4dO40eOP3fdaVgeCQOwdhTcXH2556x36XjVosNPoe3QvB289c9Gg8Jg5S5a
 ukJtqQmh6HRF+coq76xL9rsUOfvV4345jfbeM/3XGyCBG1eyEk76KYlsYMgLWEcMH7i0
 IOHZpaL83lVWXh5XGNugK5119eNoCd/VgITKqVrSHxJJYQbLIClZ/LTYd0+Q6owaoHUm
 50gQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuQ3+5K5KrQKDjP1jjRAVegZ9juU0ufNanaKxWguswLrEBgIDw/t8HO5PoWdZNOjtGyfzaaiuoiJWG@nongnu.org
X-Gm-Message-State: AOJu0YxHJubcy1Kj1rkcEUtMRqpMfFDKGXIgWzZAEFpLgxflERA1BiId
 vTa43oHqXlYh1XWvlaMY02aV9FRUD0uvrXGn7Ov/kZcDoH2eo6wQDa7B2VlI/zw=
X-Gm-Gg: ASbGncuLgNugdfC6PcdNExVrU+Xj8+GnuMQw8X4I1UuC6ty7weYPOGlt3wBstJiU3lc
 ZYZRHwQAUUUhnCmEb85tRJ0Ebr28ODc8yU5hj06sefhFicvpy7vrFneCWm8Ch/9HuTfrANTOVzv
 mHZ+bkI82d3ZTY3kUcPF5vyQtSDju0DWXcGjLHg+jn7ICDqine45YVHYse2OQL3ex4w08LQdYqt
 jlQxO5LgDiibtlOSaQZbHssROUJRQn/eQHsC2Viz8ffXDyvEWap8xaE8Flh1WpIBLONETrDrbcR
 tEa9gRlOu3gU6d3bCrcQAHIOoxJwTeCKTd72qnn77pl35NqTklmVZc7a7EGY9U1y8+p2RPGegnw
 /fxZVDvI=
X-Google-Smtp-Source: AGHT+IEizPqXMalLaQpsANWhLbP5yYDSnFHw4NZQia9c2v8i7CH2qpEo3yLuK2W8tSkgyFV55N+vNA==
X-Received: by 2002:a17:90b:5486:b0:2ee:af31:a7bd with SMTP id
 98e67ed59e1d1-30a7bf6ccdamr673874a91.5.1746471134659; 
 Mon, 05 May 2025 11:52:14 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e151eb166sm58715695ad.96.2025.05.05.11.52.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 11:52:14 -0700 (PDT)
Message-ID: <ee6fc6e0-2c94-4108-a138-920ec3fbf15e@linaro.org>
Date: Mon, 5 May 2025 11:52:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 44/48] target/arm/tcg/neon_helper: compile file twice
 (system, user)
From: Richard Henderson <richard.henderson@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
 <20250505015223.3895275-45-pierrick.bouvier@linaro.org>
 <7ff2dff3-20dd-4144-8905-149f30f665b1@linaro.org>
Content-Language: en-US
In-Reply-To: <7ff2dff3-20dd-4144-8905-149f30f665b1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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

On 5/5/25 11:44, Richard Henderson wrote:
> On 5/4/25 18:52, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   target/arm/tcg/neon_helper.c | 4 +++-
>>   target/arm/tcg/meson.build   | 3 ++-
>>   2 files changed, 5 insertions(+), 2 deletions(-)
> 
> Likewise, I think this could be built once.

Likewise re crypto,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

