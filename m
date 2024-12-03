Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 491B7E64ABA
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 14:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIUJu-0004vA-Vo; Tue, 03 Dec 2024 09:56:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1tIUJt-0004ub-6d
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 09:56:09 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1tIUJr-0002lv-KT
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 09:56:08 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-724d23df764so4914240b3a.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 06:56:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733237766; x=1733842566; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q+kc96z5ScfmNUcRJ2QkY4fyC2is1v5rmCpXPKmqZAU=;
 b=EarQsWUXXFQXORBAHCL+PwK5K90kJR+y0jEOUhN24khPXrgHNYzr+j0oLycFuCIbtU
 63Qe/AyWSAkc8XdAUGucox7gHUhhA6XYNdRAuIRPGx6yLrLJ4O3RNoyZc9qey5CnPCNa
 UDQhScy4Dp82VDl6zmpTcq8qzmsOPb7IX6klnJd+Oj470jBuCRKvN4Zqr+duD3tUSpXi
 SUl9RLfIYDaSp/YJfArcI4ClCdAaxIunwvSInWycS+E7DMSvdO7ZEbZRfjy3m85g4MT6
 IbUB5JAbhwHniHIeq+jVPIW3FH2yuBDP4V8qO945cHuwbUSi4fHtoYN8VspnJN3ytlOk
 Jeuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733237766; x=1733842566;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q+kc96z5ScfmNUcRJ2QkY4fyC2is1v5rmCpXPKmqZAU=;
 b=WFQZNsTIhn+1weUB0nlpU0jp7ibRqGu0TD9+wB8LQ4i19DWCElinD1xmFBj0I/pgSJ
 6aITEGLFtb099NxZx/bHjiIGpCl9IffOXd90a0zggdzxkGsK1eZdP2KfAUs0WJ/e/6fS
 fPsi7SHTYgg7uG9JYQi9/+GLKNg2SOyWk83+EN8HAl99IvToj6d5YgHJC3dSAkb7wFiI
 kSGxVY3r9IpAsPsIU5E3iiZRoqHIT5KFEVrvF5EzuqfkmJPLq7mlH3PhSgcROBULooyY
 ArEs19yTd0EEefEJuq4qsIw7osz2Ld6aB1VjtJrZQl7a8oAgVxkQ1UFlQ2lxI77x4OzJ
 gRdw==
X-Gm-Message-State: AOJu0Yzf19brA4kQ2oOmOy5+uAa3maWQ8yMPJY33UiVovW6Vqq0yBLoM
 qBHsna7XnrlVz6//OLFzmh/GzyAs+u4aVnp/EdVgVlsDnBLajKGASeSYkRLEL5I=
X-Gm-Gg: ASbGnct8wYmRXgT985TU/iRTJH4CylCdAq2aq/A8qT0eBSbUl10UPaX09Yd8fBVVYO9
 Q9Z39UNUGNdaGDUCbV3g4/QUvv3wkewIg5KQOyucagJKrRv9kAg0OVNx9sFRFFzzCjLLF9n41+c
 G8dvUDSIja0YVGepGA5pBnvpRR7l1XKa2BT77DLAA+ghpEbdL0FGYz/XX4UruYKcL43NiVh4Ajf
 rzniY4yvjvNr3UbriLlNBJdJWsNX3LFuWKnJijBXqMRTwS6+XgjVAG6s5PIfs4=
X-Google-Smtp-Source: AGHT+IGbeMGGFGQuKV7fKZKB/Gz+zvE+3N9o1GPUk4FHnrEyjZfW3356o9XW6Bm9pwji2oW4zgWuSw==
X-Received: by 2002:a05:6a00:3d06:b0:71e:7cb2:57e7 with SMTP id
 d2e1a72fcca58-7257fa5b914mr3061343b3a.10.1733237765705; 
 Tue, 03 Dec 2024 06:56:05 -0800 (PST)
Received: from [192.168.0.102] ([179.93.129.106])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-725418148bfsm10558936b3a.164.2024.12.03.06.56.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2024 06:56:05 -0800 (PST)
Message-ID: <f043b94a-278f-4009-87b9-9b2ba4b80c42@linaro.org>
Date: Tue, 3 Dec 2024 11:55:59 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional/aarch64: add tests for FEAT_RME
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Troy Lee <leetroy@gmail.com>, Alistair Francis <alistair@alistair23.me>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, alex.bennee@linaro.org,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, Joel Stanley <joel@jms.id.au>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20241128213729.1021961-1-pierrick.bouvier@linaro.org>
 <4b3180bd-8054-4431-a594-0445ce4837aa@linaro.org>
 <5620efa2-98c6-4613-b866-67e91ac6acf8@linaro.org>
 <21d8399a-91bf-4599-a73d-351f9f0c147c@linaro.org>
 <CAFEAcA-4_tnm9iPCf_3E4HKKXJ9h6w9oMiYaN0Y4s9wmpji3Jg@mail.gmail.com>
 <6cd6b3fd-8362-4fa8-b6e5-e0e3aded3215@linaro.org>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <6cd6b3fd-8362-4fa8-b6e5-e0e3aded3215@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x436.google.com
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

Hi Pierrick,

On 12/2/24 14:33, Pierrick Bouvier wrote:
> On 12/2/24 03:04, Peter Maydell wrote:
>> On Mon, 2 Dec 2024 at 10:58, Marcin Juszkiewicz
>> <marcin.juszkiewicz@linaro.org> wrote:
>>>
>>> W dniu 1.12.2024 o 19:09, Pierrick Bouvier pisze:
>>>> Hi Marcin,
>>>>
>>>> On 12/1/24 05:34, Marcin Juszkiewicz wrote:
>>>
>>>>> So RME tests probably need longer timeouts or would not run at all.
>>>>>
>>>>
>>>> By any chance, are you running those tests in debug mode?
>>>
>>> zOMG, thanks! Turned out that I left "--enable-debug" in my local build
>>> and forgot to remove it.
>>>
>>> 90s vs 2974s is a difference ;D
>>
>> That is a particularly awful debug-to-non-debug performance
>> difference; it might be worth looking into what exactly
>> is causing it.
>>
> 
> Indeed.
> 
> This test boots a nested VM (using kvm, not tcg), do you any idea why such use case could be so slow with QEMU?

It's not "really" using kvm acceleration right?

It's using kvm but the kvm module in the host kernel is actually running
fully emulated in QEMU system mode (-accel tcg is being passed to it).

So I understand it's "all TCG" in the end and no HW acceleration is ever used in the tests.


Cheers,
Gustavo


