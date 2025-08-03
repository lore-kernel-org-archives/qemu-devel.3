Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0A0C87FCB
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Aug 2025 20:30:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uifKa-0003Nf-OZ; Sun, 03 Aug 2025 16:29:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uifK6-0003BV-3x
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 16:28:55 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uifK4-00005R-JF
 for qemu-devel@nongnu.org; Sun, 03 Aug 2025 16:28:49 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-76bd7676e60so1775687b3a.0
 for <qemu-devel@nongnu.org>; Sun, 03 Aug 2025 13:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754252927; x=1754857727; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FUCui5stuYhzGDKnvafV04f2kDXoqo1oZdCyKJNvZOU=;
 b=FJFv0o07YTiQuIvArHM8odAmE4bSe8r+3Jx9NvluNedfByamHg5j6tWNhNiIIB/Iij
 0L9q/WIcW10TvLvTCZBtGcqYjRiFb5YrRax7FISU4JUMHgWCRnydU9dzpLVzYNOHD/Cd
 i3rYK9cTvj9RRCxFeFwfH8fXn7YZ3Vy7add4erS/yzpL0DH5tur/JFkDNFpMo1Lepop5
 BtWjJw5XCp/ddvCl94atDKO9AVhX/s2+ZQaP8nBBKuJCLNovINWZguFIYR7Cd99pfPjr
 qZbsCFrYMsI2ddFxQ1ulVE7dkYUsU2h/GVEQel+t1VVZjNJ/bneoekbvMjOoXZyBvEeh
 6QCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754252927; x=1754857727;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FUCui5stuYhzGDKnvafV04f2kDXoqo1oZdCyKJNvZOU=;
 b=FuhhSdnAYtqwl6WQyGEeU0UKrGEis3NTabkC4XRl9NQuozJRfXHlZZ+gFD/ecprt28
 BJSN1Gv0CMeG35cHVyvNROH1TLxTOFo169kwbm9eA0RJkWvdsLeudFbVzXJphHKuUBgi
 hRfvITYRYlKY3Te2aSM8I2xTCvpGj15oKbPgwgKSyEMePJLUXsi6HesiFYblvsNtwUV2
 vOjPGBmpm9kMjQF6HWJuN0u7WRBH9wxs4RdryFL1J4jslMbtqlV5Lv0Pq8skcUWbbtld
 mi+xNC1N9bOu8tbnWXGkLPV2o5LBh03B80VC+vMK/qLBVaqxCZZY14PN3wjCknu6CB3H
 MDWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVVjJ42tyXFtnJJTlqC/Qj1tB5k0qyflls+0L/0R3Q9/1TZT25PEhZDmv09yVdi96OYK1G+GTBmB9l@nongnu.org
X-Gm-Message-State: AOJu0YzlrvgmjDMz5G+oDUcva833t/qTdI+XPozbYmCJadvMcInfwh5/
 AURPNWekNbHpBy+w2cgo/adfg8nOZCc+VxBWQBURZA/+IH0ewI2NhnReetdE24HazL4=
X-Gm-Gg: ASbGncsiKOYaawBFMwHqy2/VM+aJ9iz+GV70QVqbL4SutJIkmWa83bPNGZKAFlK/bmI
 yUD9PCNrtWbUtDzUX5uB+FjjfHKeVnbNsbZoip8xGZYq7rzl106argjkt1lFaVs5yusUoIEb+3U
 cCsLrzQF+7mLk8l/pbxTlMfDozrdsGsjrf/elupPeusEUwUD6nUPxOXjtTTUYlSPJwa+u1SPWMi
 CNqcQ8woUPUT6GVC9ZeD/Y4gCLNH0Szm1GDVxPnZ8+UzvVSfcRajA2VjvqQvnmhc+HdTQgnDOJV
 akL9K/YFUA3np/wFZrrQrrHZ6Luy3P6Fs4wOA23DKb1FZ8OapEnIV11QC438AcQ+Ub0hyMWigKI
 /SWfRvGW+u0OQyvptlfXgm49SDs/JosiLGgbq+UbIDvLymfg1nDA=
X-Google-Smtp-Source: AGHT+IG7rTMq8lUncssGn/rlsAtbF2eEeDcdxlEVQZtIC/aUq0cJ5MNNq5gFI00QaegRw52ALFL0UA==
X-Received: by 2002:a05:6a20:7d86:b0:233:c703:d4bf with SMTP id
 adf61e73a8af0-23df8fd290cmr9535122637.19.1754252926709; 
 Sun, 03 Aug 2025 13:28:46 -0700 (PDT)
Received: from [192.168.4.112] ([180.233.125.160])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b422b77f33asm7585125a12.5.2025.08.03.13.28.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Aug 2025 13:28:46 -0700 (PDT)
Message-ID: <2a2e6a67-07d5-4bf5-87c6-282867076201@linaro.org>
Date: Mon, 4 Aug 2025 06:28:41 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/11] target/arm: Implement CB, CBB, CBH
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250803014019.416797-1-richard.henderson@linaro.org>
 <20250803014019.416797-9-richard.henderson@linaro.org>
 <c101dbc2-9431-4633-8a91-d5d85ce02082@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <c101dbc2-9431-4633-8a91-d5d85ce02082@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 8/3/25 22:31, Paolo Bonzini wrote:
> On 8/3/25 03:40, Richard Henderson wrote:
>> +static bool do_cb_cond(DisasContext *s, int cc, int imm,
>> +                       int rt, int rm, MemOp mop)
> 
> This is a memop...
> 
>> +static bool trans_CB_cond(DisasContext *s, arg_CB_cond *a)
>> +{
>> +    return do_cb_cond(s, a->cc, a->imm, a->rt, a->rm, a->sf ? 64 : 32);
>> +}
>> +
>> +static bool trans_CBB_cond(DisasContext *s, arg_CBB_cond *a)
>> +{
>> +    return do_cb_cond(s, a->cc, a->imm, a->rt, a->rm, 8);
>> +}
> 
> ... but these use bits
> 
>> +static bool trans_CBH_cond(DisasContext *s, arg_CBH_cond *a)
>> +{
>> +    return do_cb_cond(s, a->cc, a->imm, 16, a->rt, a->rm);
>> +}
>> +
> 
> ... and this one also has arguments in the wrong order.

Gah.  Thanks.  I've reorganized the code to avoid this entirely.

Now to fix a gcc crash when emitting code for cmpbr...  :-)


r~

