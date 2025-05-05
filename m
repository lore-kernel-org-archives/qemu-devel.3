Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44608C3ABB9
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 19:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC1d7-0006gT-RX; Mon, 05 May 2025 15:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC1d4-0006aI-N2
 for qemu-devel@nongnu.org; Mon, 05 May 2025 15:37:30 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uC1d2-0003a3-Vb
 for qemu-devel@nongnu.org; Mon, 05 May 2025 15:37:30 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2264aefc45dso76672165ad.0
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 12:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746473847; x=1747078647; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sUKHExp9NbjWGb75YRQTnjHWCM1CTVch8pViq7ExJHs=;
 b=mhdiqTMA+Hgnscr/WA8IiSL7lNB68pdEygO/cN/ShJIeCMXJotJdfY3K4QwFbTlQ3d
 5j26pYn+4Ce3YsJEInvx9hTLFaxzIYh9a56UzFk3JE7PdRGoHuH5jK5qkT6fa0kGUJq9
 4iS6NPBunK0I+FS+Sy0CnAL75pAUiPTsKw6WuJ2vy/5fIOBJUe6YlXSh1aQwvYivmjMl
 kz7qF5+L2mmdadsAo8PzGMfnfcAExEF2xc16T8uVE/Amj6At2SEzYXAxe/Vc5Wey+ljS
 zv1bEfyq5qnfGGSLSdPkTEy9h8+g2i8nt7OLx6PupG639zbardrt4pkQmVmmbdgLkVg4
 IfpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746473847; x=1747078647;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sUKHExp9NbjWGb75YRQTnjHWCM1CTVch8pViq7ExJHs=;
 b=W+TlUS1N+sT+kX29Goyaz9HfC7l2C6kR+svnymS4bAEGrdw5GP+wPEtNXdkpUxD4Xj
 glamAuOLzGlD40XwOwFVWfvJkpOWZrdZUw7WZ1A8tzig1PrYJmFeUS/zvqnUa7uEUdzO
 TroHIFrT0Ii2ZlbYNlccUjbrTqF/p93/hCWAviQpM/jX6hI9btAA+FScoDvAc1pLmpsE
 0XyU2SFxaBSw8EcFn73Jlu/eDQepQTXwWakFdjpAT3MWG2Y2o0WxWYycqjkLsWf/UIsd
 dc6pqwIn5nEu7kDsSf7b/PKtzsf29itdyJeNJAZ6XMt8i9CmhhU8WWgWxTnqsz1RACRw
 5scA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKEZPsvMxHf4RQ78ce/cyH8iMNlX6LJFmzDYxGllK7HHRKCBYN2zUwN2GGgfxEMRWUJpwqsQC5clmB@nongnu.org
X-Gm-Message-State: AOJu0Yxv+bRiQ+qsIoZN8GqA2FL55RvIFztkqpj1wCjWUAXLGKmuIT0J
 hW7FQWovB3xHHlyvrNXHgjfUbjlk+CzfYOyxdr8Amfk7G1y7BY66cVSPLgmv+aU=
X-Gm-Gg: ASbGncsPmh3ZjK+hh0wExzhu5g1lF9/1rC7+roffSqR/aqIJAeOzA/+DxkXVbxIIIdX
 ahLlI9ErZsYV1T/Gcqi2G4a13iCVw2S7OWQdNGMs6lXNXSdcvisW1xJpMLsnAnAI0DvJFSedXMA
 SB1a1DRc661P6yHgZPJmz6X0P0b5fT9ACW8X1keevc7t0ejJ1HiOiArw29IUqt0GiGCp5CiFpgW
 /7aLDqlUM6q9rZg3xWPwOCl+BcGgzM1wRU3dewh2/js7WlRR+XT7afzeHZwXiGM7lpwdrKFG46Z
 5xXxCd2VHn1O+Y35Vh3EU5U5V+C0i7RBSjNu64+4ivjojg6KWShhjCP9G5DjlPhQJ9ZcKa9aGse
 TaGYILi7RlHQ6r+Ie0w==
X-Google-Smtp-Source: AGHT+IFHLGCTkJAIaTz0cBKQi5KISLaAoM4Rjvto0c/ddqPAd97jaswHhD+/NkXo6Xt1EUBJR2FFEA==
X-Received: by 2002:a17:903:41c4:b0:223:52fc:a15a with SMTP id
 d9443c01a7336-22e1eaab925mr125088655ad.33.1746473847458; 
 Mon, 05 May 2025 12:37:27 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-740590a136esm7258019b3a.167.2025.05.05.12.37.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 May 2025 12:37:26 -0700 (PDT)
Message-ID: <bd48b05e-34cf-442b-a645-e955d82e6732@linaro.org>
Date: Mon, 5 May 2025 12:37:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 47/48] target/arm/tcg/arith_helper: compile file twice
 (system, user)
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
 <20250505015223.3895275-48-pierrick.bouvier@linaro.org>
 <e8eee40f-3785-4816-b96a-af022b3031b1@linaro.org>
 <85513f8e-232c-4d66-ad03-15c4f697dbae@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <85513f8e-232c-4d66-ad03-15c4f697dbae@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 5/5/25 12:33, Pierrick Bouvier wrote:
> On 5/5/25 11:54 AM, Richard Henderson wrote:
>> On 5/4/25 18:52, Pierrick Bouvier wrote:
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>> ---
>>>    target/arm/tcg/arith_helper.c | 4 +++-
>>>    target/arm/tcg/meson.build    | 3 ++-
>>>    2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> This one doesn't use CPUARMState, so we can probably drop the cpu.h include, and thus
>> always build once.
>>
> 
> Done.

Thanks.  Preemptive

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


