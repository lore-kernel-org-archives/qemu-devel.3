Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18134C77B7C
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 15:35:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTjCE-0005uH-Ll; Mon, 23 Jun 2025 11:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTjC9-0005t4-E2
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 11:34:55 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uTjC7-0004gn-OM
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 11:34:53 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-b2c4331c50eso3645240a12.3
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 08:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750692889; x=1751297689; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vZ1kpYyXoU/JAqYFLoKpckxcSVZCbriso4O/bA5mZ4c=;
 b=AktGnGmaleI97HPDPPdHcVnMXXL/L/kJTV+A4pILAZKB2zu8HI0bFkKoJy9DjTHYOL
 qFDMD1Lniy5Ddn3a/ZDS/L2KTbjCCZUZLES/NISsZi2JzKrYylyq+qiUCatIEil91oqc
 pF/FPCuyYetrUvvFpQYkA9WhNCebne5d1SW1UBd97ca460YXwikeundiIJECJrxydEG6
 88wncCerGhF+Q1AcA74LfRTaQuAblKPFLjLqLcWO5vWFQvz+lQGtAbHvqJG+m/Et0FeI
 uZo3TYHIl1OoXGg28pJDrrUoHgTTrS7n/LXwVkXwS7SeUSWG7ukgE+JWZwAGipeVTpC8
 vuZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750692889; x=1751297689;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vZ1kpYyXoU/JAqYFLoKpckxcSVZCbriso4O/bA5mZ4c=;
 b=MW/WLB+mkueBAzrfrxP2GxvfdpFb0dzouBOjwcWjR9L8TlZDxnqM4mryd/4rI/SE22
 ZOS7mqrxCnrEui7hg39emGY4UsFH2jYuSKzCdB5XiPPfaZ3/RHOS/BTbvqv+stfzEEB6
 OawVxfGMU3NS1Y0YzJBgsqSd69fhKvMxqZd6nDz2y1g0Y5T+Y1t4AWpdGkD4D58jtjD9
 LFDr4rCeQRXAJ4ufFEYdkvwBGmNtE8IM1t9iDYKYC6+wW3QydI7rjhRSGhNXs0tF43p9
 MLyoCs7w6JchJSIxFbEW9oGTmApGJoits37dZQtK1fo918J1E68EVKLakm5p+hFjF7SR
 8jhg==
X-Gm-Message-State: AOJu0YzcF3B1aiyNmV37G4248uAZLMJgjH2Vc0PUJ36LUD8kSMTA/XBI
 8+M9iaQuv+gJXyKvXkmCk4WgxCCy9kOEtlOfmDYGDY91vtSqzKxhlctRgpISshJ6wO7e3IBmsUl
 4qFV7xXg=
X-Gm-Gg: ASbGncsIpDw5YLJS0oKSnzCWYsZEjhZeOxnSMbW31qbbD8VfH4B/3CX/UoIT4l5PV24
 m//ElxWQH2DnfbYI7wkaKMHnOaWQhEVsfv9P3KwwownmcIKLqBr1MHl0de/F3ntVQGWYUlTHDNo
 /QjRIzsYeZbVU62B54G7nlo/9tyXcOveBimui9ZCG7lpwxZwVT0iPxLFEAhkq4pCAthqVHPZD9q
 RllYcVqiXtOgk7GcvOyEQ7inLyvSc0/WylXqy5dHRsk81SnxY9IgT7Dfvh4Cnlt8iu4kof0mWFn
 Nt+wmxQSj0B0mdI1bZvKP599Ncfc+vM6hZ1Qx/ySuq3prdryavBK3DxOJqwD7lW5fJO6dXQRjBv
 zWt7clspb09Z6YOJdPkAe46kHW33/
X-Google-Smtp-Source: AGHT+IFJthgT26hqdbHxJPPFYihdYcMjw2MGd//vgCbb/kiSgRpI70t1f+8igqU5lrzxX6YIkHqN5A==
X-Received: by 2002:a17:90b:5685:b0:311:ad7f:3299 with SMTP id
 98e67ed59e1d1-3159d8d9af1mr18688686a91.25.1750692888749; 
 Mon, 23 Jun 2025 08:34:48 -0700 (PDT)
Received: from [192.168.0.4] (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3159e06a888sm8574009a91.35.2025.06.23.08.34.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 08:34:48 -0700 (PDT)
Message-ID: <97a30a04-2a64-4044-9db3-56d9454f0bc5@linaro.org>
Date: Mon, 23 Jun 2025 08:34:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 019/101] target/arm: Implement SME2 LDR/STR ZT0
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
References: <20250621235037.74091-1-richard.henderson@linaro.org>
 <20250621235037.74091-20-richard.henderson@linaro.org>
 <CAFEAcA98aZhdE6=564tB0bn8DvStzHrM6ihn=duvdTJhoodwOA@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAFEAcA98aZhdE6=564tB0bn8DvStzHrM6ihn=duvdTJhoodwOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

On 6/23/25 05:21, Peter Maydell wrote:
>> +TRANS_FEAT(LDR_zt0, aa64_sme2, do_ldst_zt0, a, gen_sve_ldr)
>> +TRANS_FEAT(STR_zt0, aa64_sme2, do_ldst_zt0, a, gen_sve_str)
> 
> The alignment check the pseudocode requires happens inside
> gen_sve_ldr/str, right? I don't entirely understand why, though,
> because those functions don't seem to use MO_ALIGN.

Hmm, I don't recall having seen an alignment requirement for these insns before.
I went back and checked H.a and it's there...
Will fix.


r~

