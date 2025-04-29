Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BCFBC3ABA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Apr 2025 17:31:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9on9-0002U2-22; Tue, 29 Apr 2025 13:30:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9omx-0002Q3-St
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:30:44 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u9omv-00042J-JX
 for qemu-devel@nongnu.org; Tue, 29 Apr 2025 13:30:35 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-22401f4d35aso77966795ad.2
 for <qemu-devel@nongnu.org>; Tue, 29 Apr 2025 10:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745947831; x=1746552631; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qRmwhXWCiQddqT83zYmB+enevSQd+xB0ZBjw+0F0qLM=;
 b=Xjiv2gH+/VukeE3nJ8cdg6Xp0mldBvqVLbYyTjdVTmBaspdLKsrFgdAadoCc8jd9dm
 iAess8BLmNqEc4tPDj4o8rvDvJle/3EIiBBa2nK4rzUpfDPHZILfTOUNWyUI++6/RwVY
 JyUo/K10Psc1v8UfhIbL7694t1wZ5TqXQQvPrrrsPEHUD8MBVtGOjxSCA7irQMgZez/a
 WVl/wOSSUhmqIpfoF830cCnjIOG99a/+x6u6ZhRPRud7VgHQ2Voe3sH8MtejWckGPZgP
 8nnoaZascRqcvjfP91pCiu/gThzd2ddkjC8e2L3e8m4Sy+DAnCryzDe2U8MXN48eCVGM
 Wvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745947831; x=1746552631;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qRmwhXWCiQddqT83zYmB+enevSQd+xB0ZBjw+0F0qLM=;
 b=OJK1MfjOU/OoDx+2FKEpfnjAJRTC8TwK+8F4qZcE0A+tIhg7gmVY4+n91TVJVkJbXm
 X9hPiSN0tJ5ihJiZ5/whIiznq3v+E8C946v/55IlN4KxFpdPg1kOlEy2QyoyoH3aq3VA
 gSDe1guVweQ3UI1VAsfbVpisj8Gf7eUxhBEqCEPrZgZV4BrRcsXZlyZAp3a6FVKq0l5S
 nTD+kLWODbAjE9mQM6cgxgQqGfAdOHpQIos+2pihycA0MSdBgTybuYoPVjzpl/ONWomK
 99oJAUlAtQ93Nuo24Kzio4YpyYfXM5+iiNFql+YWcidOzz2yac/e7zjYwF97O+w8h/Wo
 zQ9Q==
X-Gm-Message-State: AOJu0YyGbqCn2+LjkQ3f3BXEBhV8Gt+3ir93gGMMsFtM5dEXHsLZsZ/e
 sv2H193UBv561Yi4cF/zShg2MrCh47NsY5UbYBpKIkqLZiY+LrqMDM4jHF7y4dE2+D96z60rfNL
 2
X-Gm-Gg: ASbGncv0/eBTNBPcFeGGflmvhrQKDPFopwgzbWqoghsCkl2t/0A6ajB7rFiVKjr1hZc
 XFdbq/CfzXcFwrAh7+IhgnrYkl6czGUflhQo7cQAj1QhI9WUph3Y7u7CkhAiW5+B9eZbbI0Umd7
 +BZcxerBeyIS43cHZ+aY+H6FORH9o/HdLItfjx+06qyav7XOV09gpLDga7YKdvnAn7yv9xBJUjH
 VMM/Ghr+XpltaC6I1EiQ5SIAMkdD+2wnMdu+ZJsSX/5wcURkPkys5jJH6758iPaYKiqWEoxoG9s
 HgsyZioaTy7DK4somcB+YONN8zaQh785WG+IzRykzJlnkHR3JFNFe8W1AnxT+tvT4eBLcFQPHVn
 WwVA7OGM=
X-Google-Smtp-Source: AGHT+IEp46B+UVh3O8nFb3sDFTcpd10zbVkmCl3n2U4nG5Z+SazfV3Nh7oBpy6++k7e9CbjBtlvVGA==
X-Received: by 2002:a17:903:440c:b0:220:cd9f:a180 with SMTP id
 d9443c01a7336-22df35eebb2mr3123315ad.53.1745947831345; 
 Tue, 29 Apr 2025 10:30:31 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d76d34sm105772035ad.39.2025.04.29.10.30.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Apr 2025 10:30:30 -0700 (PDT)
Message-ID: <a121583f-2ec0-4f81-b5b3-1259906afb8e@linaro.org>
Date: Tue, 29 Apr 2025 10:30:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/ppc: Inline most of dcbz helper
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>
References: <20240701005939.5A0AF4E6000@zero.eik.bme.hu>
 <d3c6c417-20d9-a215-2a5c-86fa084b00fa@eik.bme.hu>
 <173c9111-e065-0dd5-c276-6bbc0351f9cc@eik.bme.hu>
 <2b969dcd-4a82-9086-803d-c52ea274fefb@eik.bme.hu>
 <e4fc537a-a15e-77dd-1167-32b12ee7a22d@eik.bme.hu>
 <87bjsf3s40.fsf@draig.linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87bjsf3s40.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 4/29/25 08:27, Alex Bennée wrote:
>>                 - 45.16% rr_cpu_thread_fn
> 
> Hmm you seem to be running in icount mode here for some reason.

For some reason ppc32 does not enable mttcg.
I'm not sure what's missing to enable it properly.


r~

