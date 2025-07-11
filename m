Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219FEC83F1B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 20:14:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uaK6j-00036w-C9; Fri, 11 Jul 2025 16:12:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaJsy-0004d1-Mi
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 15:58:21 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uaJsx-0000ej-5Q
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 15:58:20 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-2ef8dfb3742so561325fac.3
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 12:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752263897; x=1752868697; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4CsWiatzJck1QaJtSAHOx+wzX/98K3pxwA4Bg4uXD9o=;
 b=kjQCnsGJBodnhSxIq0vnZFAteR7IDVfYUm1WhcsF26C72Oed071NGvOJ2CyD+lUTPe
 B6ZObY4PQCrA0A7LXYhB6F5VFkZiGZ5PUR1ggv9g10j9j//Fd2QmGOZqYuQsv9hHtw7a
 Et/zy09xzvhxTDDAO6P4kh69ZgXbISpYEYyR/ntxyw/qB3ZnKTc/6HC2wNwG21kn1eje
 xYe0HOlp7btgfWzO24OHJhKvXw+MX0yjIYkmDtCQa3/3gpHVMrGlt2c2AIHvjqOHsfAx
 834p6LyAsF29CLdM5CufW3+Joz3Z21EzguWf/merk9t5wLEJ9OZxePL5fpnvQu3Qg5C1
 Xi7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752263897; x=1752868697;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4CsWiatzJck1QaJtSAHOx+wzX/98K3pxwA4Bg4uXD9o=;
 b=fyw6lfs53pfjsXgUvvODiG/i6iLFYmoePG3Bvo33YRE14Hc4xvmPzGQr/1U8JYIgHF
 prPCop7qCzjQQSDfLFNcveyb8x4wOLcEwl5OQcfmlyOI1HlciAsoVP1C+CzLj0xCFu8M
 vkfqxQegBGUYhDEwq1Wr5JiXP2vKrvzER/peXLMwRl39jKywGkxQxiEW08mdmoZzFmVJ
 JPpcHg+OA9TPzmDHEqoiLPvimOTZOBJBiKFxQoScMF7Qqzh1d2hLvGKpkczNsuScgkV0
 +4UpA5NCxZxkXM2oQiTaen7nDs2RE/8ptaU3erDxiu9lt0fIk4fjaZOvvkSmy9crw2yD
 emkw==
X-Gm-Message-State: AOJu0YxRiYFPdGZbc4QkzoWVISzgArBqZL+ABLHG4CKrEbOXi+fi2srY
 iVXC+K3/niCqxOqvJTjaqDacjWF40yRUVJz8twLsp5il+IueKku6Uo9Rcs6BPX4ytxFNyXS1aB2
 AABuEtzo=
X-Gm-Gg: ASbGnctHtdsNjkqwv44fCTRBsKyqNYZNWTep46fcm565A+v+R/PflcqFByn3APaCHSf
 kmVBmtqwSt48oIiZLXLtpIzYqR8Rbreaou72gDj2omGYvm4rid/33IRxLOTKk/HvGFzn9qnZLJ6
 qvfAL4lXIFAsH6xPz8menzC0IFeVYWUu5pj4aVX6xJsZ+qyKRMrlq+cbr9QQBO3tGQXvJvJDG0l
 9VpR1hsEQV8McDOHNntQwwzz9vmpRklCB3T0Qcx7EySFeUI1hLQi5fFqIfkppI1xskpEfplyjuy
 WK2EDoi4NJqlz1UOzdyT0G9THcV+OnYtCSWzz87NkAZYovk8EFj/8K3djDvsa+vkW276U6x+xIS
 XBuFm4rDtdMfzg9djPmgIWG6w3OSAZTN94faqpbA9Hz3Wel2diej8cYfsmlTlpbAoy+3g2K4pIa
 zT
X-Google-Smtp-Source: AGHT+IGSg/QVIWwXqxczev7ybP+4fBNYbegZjhgs8twE1ZxxNVyi2y0BqS42LP6uiPAE2UQg+1Ai/A==
X-Received: by 2002:a05:6871:c708:b0:2ea:fdd4:ab97 with SMTP id
 586e51a60fabf-2ff26748604mr3486860fac.2.1752263897215; 
 Fri, 11 Jul 2025 12:58:17 -0700 (PDT)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-613d9f00d46sm545690eaf.22.2025.07.11.12.58.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jul 2025 12:58:16 -0700 (PDT)
Message-ID: <c777c6f2-1b61-40ab-b191-a92b58d7b7c0@linaro.org>
Date: Fri, 11 Jul 2025 13:58:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/arm: Added support for SME register exposure to GDB
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
References: <20250708221438.347643-1-vacha.bhavsar@oss.qualcomm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250708221438.347643-1-vacha.bhavsar@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2e.google.com
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

On 7/8/25 16:14, Vacha Bhavsar wrote:
> +            if (isar_feature_aa64_sme(&cpu->isar)) {

Preferred usage is cpu_isar_feature(aa64_sme, cpu)

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

PS: I tried this myself a few weeks ago and got an error from gdb.  I had assumed that gdb 
simply wasn't prepared for the vector-of-vectors type.  I guess I should have investigated 
further -- it may have just been an xml typo.


r~

