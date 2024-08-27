Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B793C5321D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 00:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sikAG-0005Y2-5M; Mon, 26 Aug 2024 20:34:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sikAE-0005Pe-Ao
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 20:34:26 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sikAC-0000YN-Mh
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 20:34:26 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-202146e9538so43659255ad.3
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 17:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724718863; x=1725323663; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LR0lqSrn+8500V4qpIUGLmFwvuRWU/HPctPyN5MQjPg=;
 b=B2C8nRB0AeF8v2GZ39mq8Js4IHyeYBDsXo9v7SYU6giLoFlNtukN4uZfsTskTEVR/p
 BJjMM0ALaqRJkukIbI9JFlR0Fwr671Ycacof9cbHwYtVdM+mSV88404Xn8Bn1cacOrNd
 1rSXlcM5Hyt77GicoV6W9m21iq1kuokwCXb5eaMrhvv8JaSMCoGFrYy28lx6XgA5j6qt
 /jFq8TZ11RASZ6MnsSLHxGmr684GlWQQHQCQDl2ruciiFMbwZRULEsw1BsbVq/0IxqPu
 BfY9ZLqK9sFd6kDAsfA6rIXU6jUKjcmheDMqKijeJ1mXyrv9RxYgzbB7r0zX026Che9k
 p0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724718863; x=1725323663;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LR0lqSrn+8500V4qpIUGLmFwvuRWU/HPctPyN5MQjPg=;
 b=OgXovQPA/fSAMTBJSoA7oGJM8N2HVC53CvkXU6/0iNaJeRT7KQbthoJUqjXOfOXkZU
 99foy84l1gGZqr4F14LnJ7294ZjNAmVvlna8Bia0LbQEvdlMCKaeWA/K5yEl7DwmZTkl
 DDqzxe04dHBrsydDM4zsvPNIsTKWKTIgiFe9OLapoxojXUEzJAodZHxEKROkt+e16Ag1
 8FPBN9tqmkcmRheAPAkL8XH4lXG4wJ8IiI/T1rulHV33XOGWdFAhrXIRniBnmJVeGGXG
 wyiE1Meio2PWnAhN8m5FiUQrP7IqFGn+eRTYMkNWcJND2BDXjN9I3ilXT/k6IZbWzOId
 g3lA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCIfRhPirrapBfY8xmHH4aaoIW6PiCdYqm6r2xpGjUkXuyKbgfv4BBJq33OVPDTUESF2uzADKcLKPr@nongnu.org
X-Gm-Message-State: AOJu0Yy45pqz6y7ZYnaS4IT58HjftY53qbEXg4+A25/GF3Vys8xyOmUa
 RLkHyRubyXtBSL4M0FToaFYfWl9ZlVpf/5WGgyCMVqJ6gZSVJIQPo3aYR3qJuTM=
X-Google-Smtp-Source: AGHT+IELSnHB7RTCzE9cmf3hMEo+PQNYkwe2nGi++zMUSKYnVXax8+9eAGlP0E2i38aR4jb/Q5srmQ==
X-Received: by 2002:a17:902:e544:b0:202:4800:9ce3 with SMTP id
 d9443c01a7336-2039e4fbad7mr124454795ad.56.1724718862997; 
 Mon, 26 Aug 2024 17:34:22 -0700 (PDT)
Received: from ?IPV6:2001:8004:5110:2082:f68a:6871:1edc:69fe?
 ([2001:8004:5110:2082:f68a:6871:1edc:69fe])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20385bdc8cbsm72237195ad.270.2024.08.26.17.34.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 17:34:22 -0700 (PDT)
Message-ID: <c1b6edbc-3776-4ddd-b096-36abfae9610a@linaro.org>
Date: Tue, 27 Aug 2024 10:34:14 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 12/17] target/riscv: AMO operations always raise
 store/AMO fault
To: Deepak Gupta <debug@rivosinc.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: palmer@dabbelt.com, Alistair.Francis@wdc.com, bmeng.cn@gmail.com,
 liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, jim.shu@sifive.com, andy.chiu@sifive.com,
 kito.cheng@sifive.com
References: <20240826152949.294506-1-debug@rivosinc.com>
 <20240826152949.294506-13-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240826152949.294506-13-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 8/27/24 01:29, Deepak Gupta wrote:
> This patch adds one more word for tcg compile which can be obtained during
> unwind time to determine fault type for original operation (example AMO).
> Depending on that, fault can be promoted to store/AMO fault.
> 
> Signed-off-by: Deepak Gupta<debug@rivosinc.com>
> Suggested-by: Richard Henderson<richard.henderson@linaro.org>
> ---
>   target/riscv/cpu.h         |  9 ++++++++-
>   target/riscv/cpu_helper.c  | 20 ++++++++++++++++++++
>   target/riscv/tcg/tcg-cpu.c |  1 +
>   target/riscv/translate.c   |  2 +-
>   4 files changed, 30 insertions(+), 2 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

