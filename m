Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A55B2C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 13:19:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubJ4n-0000VH-9B; Mon, 14 Jul 2025 09:18:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubI0l-0005Dn-9I
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 08:10:30 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubI0i-00053M-Od
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 08:10:22 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3a4fd1ba177so2757762f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 05:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752495018; x=1753099818; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oE2uMXUiiFM8FhKSo+jh6RjiKCSwwiGNwTTlcD7T1I0=;
 b=DucnWweWIqfGvHOlub7fHivITgeHxTIL+sm16OAtV2epb8m2IBfcgWLXy8zfYAwP8U
 hFzxbrfX9BRAxpKnHz8uxtZqNRbLbsXdV8+IzlDySaq7lwI+z1pqLcClxPb2w+P6m3gy
 4roYUH56A3b86obRqQ+wVTdNmspaNPoiuW/PhSAoobuse7q2OCn1W1g4lg1XNYCFi+fh
 57esyGCCNw7bQqWAZlozhYGJsRU0h1J/7+LMo0hQaOvY5xm//W5YAhRNjmNb+zdL/kM2
 NrjcKjfSwkqXhxRUtn8rgm3dGo7bxNiBAvMeVL/skgGSDal34IMTBvXf3G8SeizUeyvh
 aTGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752495018; x=1753099818;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oE2uMXUiiFM8FhKSo+jh6RjiKCSwwiGNwTTlcD7T1I0=;
 b=OmTY8nWni24wZAnDCz+/Vq6KKykn3/n0R9ndtD1Bqvg0AHz5SHyFPeWQe37tXkY5XL
 Suafe9Xf6hQCOoFf1wmMEO52hXJLMcvS0YfLPaOZfA3yXfZHM8gfjKLfekjdsKhwm7KG
 Mx+/rh7t1oAfkJ95PLVJ8e2VDDKt8ywag8/77HtRNkEbITQDoCeO3aS1njpwLF3iVfvx
 9MPqatoIXFw6teE8Pgto8OHCo/jITx6FjmV7Z5Bd+EoDk59pI2t/opd/UzhTSQWNXDK1
 H72vlyGiQ9/Gpze+VjmCwdLti0B7lzJdVPsZ6Q5kFd4g2SQN6OsMMGcDZQUaF0UCvixa
 qEJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmbN0ZYZpfDbVD+mESiQV60bt3NZNclZDRC7eyTpDz0lNTI4/o7xVl1bLnCvnEDj0gL49PBeNPMn/t@nongnu.org
X-Gm-Message-State: AOJu0Yyt6MIE/Md5OudE/aoy7pbLsZf7N5iPuuqLQ+0Ww5LLZCVhp5Vz
 EjcvEL4VTBPQWyRAfWanosHX4zBPgY8ik6FiaCTL3Q3fXLT5WV6T4Nc194KweKTI6y4=
X-Gm-Gg: ASbGncvx1pos5fg+sihviDj3DxyCDtoswPd38OAK0rZl46LbW4CWXpZikfIxkDMH/cp
 l0TOXw2yeNRwoZNPlrFblGRNm+ac+ecJfeCV+YeHqTKBNvVjBi85MhA9th5kM2OAkaNQXQP7+TT
 jILCblR2K0epcq+qTteQmr49BxuLeWJ1TbAoNzgeDiqGelGgUaThz8jSIgtQzoooOD3ZxB3OOpA
 JA7urfaj4fD0Swa1/a5aZWZaTVRidyzPTKunDFVZCStK61yzSdyzAQOgwkXsYMmkcld696IxpD5
 tQY6JlGm2ovu/6zkHL+ypwoIl7o1JxIHRy4skzUn87Dq9ZmlnesgjYRG7R62lwCRgOlLz0ZD1Db
 5Dj8ZaL9+OPBkIPDchY0Et8NhRcGSJGF5/65flodj3jOFqXAiAahyw2eF0Q0yuN4H0JMemmAQth
 AGfjAawg==
X-Google-Smtp-Source: AGHT+IFIYsP07DdzOj7Ie3YTuqvV07XMsAxlqbss5qIjLr1jveCIYmIGNTtPfYQPATfF0/zV9QtjsA==
X-Received: by 2002:a5d:6f1d:0:b0:3a3:64b9:773 with SMTP id
 ffacd0b85a97d-3b5f1c726admr10208205f8f.10.1752495017940; 
 Mon, 14 Jul 2025 05:10:17 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc91d8sm12047584f8f.42.2025.07.14.05.10.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 05:10:17 -0700 (PDT)
Message-ID: <d338428e-ae84-47f4-8f60-b72b3cbe8dcd@linaro.org>
Date: Mon, 14 Jul 2025 14:10:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hvf: arm: Remove $pc from trace_hvf_data_abort()
To: Zenghui Yu <zenghui.yu@linux.dev>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: agraf@csgraf.de, mads@ynddal.dk, peter.maydell@linaro.org
References: <20250713154719.4248-1-zenghui.yu@linux.dev>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250713154719.4248-1-zenghui.yu@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 13/7/25 17:47, Zenghui Yu wrote:
> We don't synchronize vcpu registers from the hardware accelerator (e.g., by
> cpu_synchronize_state()) in the Dabort handler, so env->pc points to the
> instruction which has nothing to do with the Dabort at all.
> 
> And it doesn't seem to make much sense to log PC in every Dabort handler,
> let's just remove it from this trace event.
> 
> Signed-off-by: Zenghui Yu <zenghui.yu@linux.dev>
> ---
>   target/arm/hvf/hvf.c        | 2 +-
>   target/arm/hvf/trace-events | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


