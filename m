Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE45CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 18:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7I9Y-0005cZ-1h; Fri, 10 Oct 2025 14:47:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7I9W-0005bg-On
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:47:42 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7I9N-00024B-O5
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:47:42 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2697899a202so24297525ad.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 11:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760122049; x=1760726849; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IQ3GA2jhg9dm+zJqrkOTRUvsuju8bnP32L13v2V/7sQ=;
 b=WT0un4Tobu/b0dQQjIUJjy4O62RrkF5bjcQbVr/ShkyrNZNDHFN0/Kyqme4PROB/Pp
 a66H7K2exHFTDQswCpeIDBFWNuFzXGm9vFh0EIXRyZlGGlkkB3CSQFycefjsx+BG5GCo
 es4r+T+z/YRacHX/icSq0nlarp4I/hc7ka14xfGRHDLoBj6ETijxGz01p48dvU3Xdhev
 W0En9qH2AwEUqNh0nVxNeZv9qXpKiY7EaHozJeeD0nEdDkM76gkuNoqgteoMfNJCTj27
 ae97rhlBmA5pipscK6SagUPSseNeSUvV2MTWwrgTVtJIKFpWhIDphrZTCWRn7bcHmYi0
 dJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760122049; x=1760726849;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IQ3GA2jhg9dm+zJqrkOTRUvsuju8bnP32L13v2V/7sQ=;
 b=gPBrk6M1i56IHJ1zqu7J8Ig4mqQUlR9KMCJi5hz3nGbVQEHkOrEM5GXIM5JgTXOKCQ
 g8xsRVXwYM9lbu0CHsTm1G08lMyzMUd9AbVrGPVnJLtn3dtO6UcrsWrC3U7KP3a7POET
 Y+GLtnreUTg8RC6ZX+Om39wQv+wjYvcXqEkdMksQqH3hX8EVZ1/EIGwUpZ6+Zh1EeAII
 skqbtOSBp08T/x/KR+WIRVmsfkUVQsk3EldDsStuYqOWOD5030ryf2aPVx17/nVrRoqO
 sGEgibOJluhS70BUJ9PZqobqf/k4l+887nIvUEaa/TDt6tSEZfyTbEwwropmVCzW7XAm
 p2Sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUCtmTvCF2owaQ7umyr1MDvWywAt8DahH46EcNPkMqCKI04qtWOsRYC6gj6w84yqcM7baw9JmAiLi/@nongnu.org
X-Gm-Message-State: AOJu0YwIzlCVAXjLngDvjEM9UNwfZA24n/ytQ+ro3cYZRwk4WTdapUne
 S7rfXCtaqkIcz0U3y3lCBm2JPCmRz5X/H+cio/O/r406Bn8xQWdIVWLu4+1zTRL38FU=
X-Gm-Gg: ASbGnctczDiXftXdROlmqINb/taW7AWGyTVcJT/R5eaw6X1muDI6TNjKnueveEXBG0a
 NO9Zu+yndAbGW7IEoDKiUtVVgwzmuOKq26eLDcE2vCD+jl16MWZwB4zL1Mat8jAutAdPSEZLw8a
 71oOvodxcaQ621zUD98Woins8Fa5VF7pAgsHRG8Imypf/0mwE56quUyzyqff2wmgaIRXTeGbhji
 6CmqJlYA5fJciNxGzLtTeaLrgclOV5ZhuOA14JBckFl3q9HFlZXsbXUhmP/vAXVMCi/5l5Wjhp/
 Bz14NM8zCV7WVdwdRP4s3knNKkA62Fsor3WoX0XK8Mqtp6Zo93NlsXLGnV4cfn6qKgNcXgpBr4q
 gP0ZK1plTYcgiNGrl8eZk4KXvXgeMUb+Mgg2L6Wh2T7vHwaZNbIvdNB9QTnA=
X-Google-Smtp-Source: AGHT+IEBu/iyNS0Xv6uIo1rNeE6+jXMoly795z8i4QZpbQJz3I8leETg3KblcjiRQ/MlMfgz64zHkA==
X-Received: by 2002:a17:903:1aef:b0:27d:6cb6:f7c2 with SMTP id
 d9443c01a7336-29027f0cec2mr160914445ad.17.1760122049558; 
 Fri, 10 Oct 2025 11:47:29 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f08ddasm63233095ad.65.2025.10.10.11.47.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 11:47:29 -0700 (PDT)
Message-ID: <71d18c36-1c2a-4dc0-b195-ee3755dee534@linaro.org>
Date: Fri, 10 Oct 2025 11:47:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] target/riscv: Conceal MO_TE within gen_inc()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Christoph Muellner <christoph.muellner@vrull.eu>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Anton Johansson <anjo@rev.ng>,
 Valentin Haudiquet <valentin.haudiquet@canonical.com>,
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
References: <20251010155045.78220-1-philmd@linaro.org>
 <20251010155045.78220-5-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010155045.78220-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 10/10/25 08:50, Philippe Mathieu-Daudé wrote:
> All callers of gen_inc() set the MO_TE flag. Set it once in
> the callee.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/riscv/insn_trans/trans_xthead.c.inc | 34 ++++++++++++----------
>   1 file changed, 18 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

