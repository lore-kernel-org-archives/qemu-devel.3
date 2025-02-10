Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E0D7C02198
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 19:54:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thZqa-0007WK-2A; Mon, 10 Feb 2025 14:53:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thZqW-0007Vq-JS
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 14:53:33 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1thZqU-0002vF-VG
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 14:53:32 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21f49bd087cso62588675ad.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 11:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739217209; x=1739822009; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bsPsV9nRHz/oa5fQ7yMqXwBqAyJRf7cuT01dKnpp6Do=;
 b=oznicWyRHxTG/lhkuIzGL96mlnJyZGKaFFQhG7tTtIER5jo7gutrPzySNu2A3Eoiu+
 KOt30gqyuk5+UV5OCda/gqd7T9kus6kz9XdPlkjrdNFXITMoO2cDhcA0j0IJHYJJGvgG
 b0iEKCspoHl+JeFwsRxi6BMmW268Z5Afx5vad6Ln9dT11jd0xXplnaViD0khWczEJ3tV
 OS2/+Hp4hQ2skGAdglqrOJlATiehpqiypkrkQq8DznQvidl2KHk8Zm6oVz7glaKe10rB
 zwvY6D9EVg0g8VXkbQdrhbB55YGETk1HZnNPQw9shO6gJjyWSLONCiyLqpA8Q6YaKBdV
 qpOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739217209; x=1739822009;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bsPsV9nRHz/oa5fQ7yMqXwBqAyJRf7cuT01dKnpp6Do=;
 b=rylL1XvyAL2SPXtwyRjfij+VsZeB1yn4clkniY1iiPHGkxSKg4JQLNATxjrGrKLqQm
 PoG9yINLSUXx888vI8Up9KpEUKXNZ8Jvy+GgklDQvE6a2tdgrH6uAvSTJzqW7GNmjXWV
 cmgeRd25ee3fFPG3YQXirnM6n39C5yBEjiiUO1lz+qrg2UCXzrCi6/0l1EBldxZm2W5F
 0B8symAgOryMY+dOUPI0c0uccN+8Pgm1t9eNT86Aq+YZaNb93LitvkBqUq8BE3BCHfv2
 wX72KVoAW6MYtvNlP3+wLgE2TiycjIR+t/kDnTL7kINEzVXEQiChRNGiIy2OZbFI/2jg
 a9fQ==
X-Gm-Message-State: AOJu0YwoWYx+25/jmF9mhyKug2n5DGtxCXBl6qs2i2rminfk3S+rJR3M
 xVEjjsO9kPC3D9K6K2MIg3XI2kitZADxPblhZ1poS3Qp019e8xumrxHhZlw5Y8fp0mtORuWDBCp
 o
X-Gm-Gg: ASbGnctho0/R8pGazka9kjtAYV5kGiXJITJ1OveM9I55O8Y+wCYgeD7g1u2BFA0t/rx
 aD7KT9NgTsp+aepqOqkxIQTZXefjRyLK3ORvwBfVvTAXeMVZcylPZ10uiEx8aI66CYZFkn93TD4
 ZdR0vEHOsVWdQLvUo4x1n5jBKkcJohCrg2sbmWJCFb3q8b+gZ2N6r3ORjot0I+l7jFvj9cApBkG
 tC4XalIuIDz2UY4bKz4QAZZ87W9/JKtnDXCBHo3ZLJv4ALAM3aqlfQ1frRewjFMbrfzNiis0yJp
 SCjT8FM3PiW/kyxA+f+mV6H/2hk9vUI2NhX3ZJ8yP4d9cg7zgaKn5Qc=
X-Google-Smtp-Source: AGHT+IG/Sdi6HG+ANrBLP22GRuk6+EVMNvaI89uh+9Ohru4kfrwl2gd2ay15uJYzJbuD0BXz2XZ7mA==
X-Received: by 2002:a05:6a20:438c:b0:1dc:7907:6d67 with SMTP id
 adf61e73a8af0-1ee03b66183mr28991971637.40.1739217209196; 
 Mon, 10 Feb 2025 11:53:29 -0800 (PST)
Received: from [192.168.0.4] (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-ad51af6a8a4sm8271259a12.51.2025.02.10.11.53.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Feb 2025 11:53:28 -0800 (PST)
Message-ID: <d60610f1-dba6-43f5-a643-58bb2b60c814@linaro.org>
Date: Mon, 10 Feb 2025 11:53:27 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/14] target/arm: Correct errors in WFI/WFE trapping
To: qemu-devel@nongnu.org
References: <20250130182309.717346-1-peter.maydell@linaro.org>
 <20250130182309.717346-15-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250130182309.717346-15-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 1/30/25 10:23, Peter Maydell wrote:
> The code for WFI/WFE trapping has several errors:
>   * it wasn't using arm_sctlr(), so it would look at SCTLR_EL1
>     even if the CPU was in the EL2&0 translation regime
>   * it was raising UNDEF, not Monitor Trap, for traps to
>     AArch32 EL3 because of SCR.{TWE,TWI}
>   * it was not honouring SCR.{TWE,TWI} when running in
>     AArch32 at EL3 not in Monitor mode
>   * it checked SCR.{TWE,TWI} even on v7 CPUs which don't have
>     those bits
> 
> Fix these bugs.
> 
> Cc:qemu-stable@nongnu.org
> Fixes: b1eced713d99 ("target-arm: Add WFx instruction trap support")
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/arm/tcg/op_helper.c | 37 ++++++++++++++++++-------------------
>   1 file changed, 18 insertions(+), 19 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

