Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14457CA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 15:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoOZT-0000kw-BD; Tue, 19 Aug 2025 11:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uoOZR-0000kL-Tu
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 11:48:21 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uoOZQ-0003Z5-82
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 11:48:21 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-76e434a0118so4058927b3a.0
 for <qemu-devel@nongnu.org>; Tue, 19 Aug 2025 08:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755618498; x=1756223298; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j6BZc9SKK+UiaMRIB9B2dq1pyKcokINx0nKeKUuluMg=;
 b=L6HtFln2DTHwN7GvRs5yaaoH8hk96Z2up2PbtU2rrLjr0XWyqTopNJgeOrrSUJoGa1
 9egeevewY4mmREwGiBn6Rwgf8CRWM6yduGjQ4Ms7qfYfmpkteXSYyaFF8ycwlEvgbY2v
 iMNnYiVVsdNK/PWZs5JDfxxMVj3FQmZqVaPjajXaKhOOtcsjvxInbKWHlo2nFnsF+4xH
 gMnTWgSpsIGU07lOeIDlcDS5vwJ/YC0+joq710bDeM5qbF7Mrs9XMZ8pXkr+3rNpzg4W
 AIK4uhE+GF++aAIY+r4Uyy5fl4zpQr3YWPi4s1Ds/Qnyjb5pIGHku2f3QQJ7fqJln/sI
 XdlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755618498; x=1756223298;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j6BZc9SKK+UiaMRIB9B2dq1pyKcokINx0nKeKUuluMg=;
 b=GqGVI9tMjOQX6VlNNZju+5sF8MduYKPAjNZWIlQ9j2esWRNs/o3EWJbiq7U1+VXZsx
 GUl5/rJ0dKQCQog4NHUlBQXsC7biQMfpCpSi5+eZg/Ze4fNWTli4DUXUqCo7MSEAtJJU
 9yPieLhTSrUbx+V/zh+yauTfVHIPF5JxSKChArvG3HPVAIkXGKCA1BMbE/vHzlWOrkV8
 oWKg1QtWCCza4IPQ6u3msahZIJ36d4OE8zZNhuPGILLDFSj98wNk/qO3TqYRggPDqeEy
 GvyUj9Ql/r02IUGHfi3648J561/3ffqoACqy/+ZlttHhId1e8ogbtbGV2vahe5kVjKX+
 CfBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnqqUcQcK4fOHDp93C2rOW7qvRG+CjtFumSX8V+rQijB1ZMvSAZpszbOiyJUKnfkIkSmdJNOp4HBeL@nongnu.org
X-Gm-Message-State: AOJu0Ywwv7nB1ZtAXV/PhTX7TvRtne0oUNp8LKuLVEOwcsi1IDmCkgIW
 4Fd8hzNtJCu0Ey3UcvokwtL+bnW+hceiTULU7a7ZVN8yVsjLC3EgVjXzhStXZlmZW6I=
X-Gm-Gg: ASbGnctS57pc9LpJ/Hggml2NrOUScOiZDu8MS9T061Wf0lVKQ75xIqxT/VH7m0UqcjU
 DWtdAB0nx1LKGN9ORqkYSE0y8yD9d44x1bGLrp1rAEE5fVBbE7cMImHe5cvFmV6790gXfTlM4Wh
 3dcWXn63qgmYlcJ/jhMyC//9394QSgjbWpW5r5w5likhHg/e7VSXimD1kf4L0o2ARKpW0ejDB9o
 0Ox1a9mL85q5cFCqPkYBZvr8QlTRV9V65SR1pQCfQjjUBPo+5J0visuesRYppFjQqL7/GJe1O3b
 7WEzQQjXMPolGNiFKI5IM5eZQZ/lgcYcqgtc26irxvHrcE67cRMf6/noT2wOBA5JvuiHwD10gfH
 maWdx8hcjsxuy9/W3+v+eeGvx3ZRlq3Aqgro=
X-Google-Smtp-Source: AGHT+IHzKdPGnuh5ePrXs3AayZneWjnAdZJOW/mYIOlKo26QEYHuf3tmWHItehL2YcRiWcVOicl7yg==
X-Received: by 2002:a05:6a00:929c:b0:749:bb6:3a8e with SMTP id
 d2e1a72fcca58-76e80eb487cmr3738344b3a.1.1755618498163; 
 Tue, 19 Aug 2025 08:48:18 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76e7d5242dasm2881479b3a.77.2025.08.19.08.48.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Aug 2025 08:48:17 -0700 (PDT)
Message-ID: <1396c8cf-fb2c-4b39-811a-7152bdbe976f@linaro.org>
Date: Tue, 19 Aug 2025 08:48:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/18] whpx: arm64: implement -cpu host
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Ani Sinha <anisinha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Mads Ynddal <mads@ynddal.dk>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Zhao Liu <zhao1.liu@intel.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Eduardo Habkost <eduardo@habkost.net>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, qemu-arm@nongnu.org,
 Yanan Wang <wangyanan55@huawei.com>
References: <20250808065419.47415-1-mohamed@unpredictable.fr>
 <20250808065419.47415-16-mohamed@unpredictable.fr>
 <CAFEAcA9iQnrKWXPXw2wG3c6gmevOMFQtt48HsJdx8GZz2sd+4Q@mail.gmail.com>
 <8e64fd77-9969-42b3-bbcd-1ed8de910ff9@linaro.org>
 <CAFEAcA9OXu3=HuA9n+Oo0C5K5hTG+kLr9xsM=geBJ_UtCi4_-w@mail.gmail.com>
 <aKSUS2-JrMBX7JXo@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <aKSUS2-JrMBX7JXo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x433.google.com
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

On 8/19/25 8:12 AM, Daniel P. Berrangé wrote:
> On Tue, Aug 19, 2025 at 04:06:45PM +0100, Peter Maydell wrote:
>> On Tue, 19 Aug 2025 at 16:04, Pierrick Bouvier
>> <pierrick.bouvier@linaro.org> wrote:
>>>
>>> On 8/19/25 6:24 AM, Peter Maydell wrote:
>>>> On Fri, 8 Aug 2025 at 07:55, Mohamed Mediouni <mohamed@unpredictable.fr> wrote:
>>>> Can you follow the QEMU coding style, please (here and elsewhere)?
>>>> Variables and function names should be all lower case,
>>>> and variable declarations go at the start of a C code
>>>> block, not in the middle of one.
>>>>
>>>
>>> In some cases, including in this function, I feel that the rule to
>>> declare variables at the start of a block is not really helpful, and is
>>> more related to legacy C than a real point nowadays.
>>> As well, it sometimes forces to reuse some variables between various sub
>>> blocks, which definitely can create bugs.
>>>
>>> Anyway, I'm not discussing the existing QEMU coding style, but just
>>> asking if for the current context, is it really a problem to declare
>>> variable here?
>>
>> The point of a coding style is to aim for consistency. QEMU
>> is pretty terrible at being consistent, but we should try.
>> The rule about variables at start of block is not because
>> some compilers fail to compile it, but because we think
>> it's overall more readable that way.
> 
> There are also potential[1] functional problems with not declaring
> at the start of block, because if you have a "goto cleanup" which
> jumps over the line of the declaration, the variable will have
> undefined state when the 'cleanup:' block is running. This is
> something which is very subtle and easily missed when reading the
> code flow.
>

This has nothing to do with where variables are declared, but where they 
are assigned. The same issue can happen whether or not it's declared at 
the start of a block.

I suspect we use -ftrivial-auto-var-init precisely because we force 
variables to be declared at start of the scope, i.e. where they don't 
have any value yet. So, instead of forcing an explicit initialization or 
rely on compiler warnings for uninitialized values, it was decided to 
initialize them to 0 by default.

If we declared them at the point where they have a defined semantic 
value, this problem would not exist anyway, out of the goto_cleanup 
situation, which has the same fundamental issue in both cases.

> With regards,
> Daniel
> 
> [1] I say "potential" because we unconditionally build with
>      -ftrivial-auto-var-init=zero to mitigate this danger
>      in practice.


