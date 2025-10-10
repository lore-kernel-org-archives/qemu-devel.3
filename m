Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 532BCCCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 18:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7I8s-00059b-1d; Fri, 10 Oct 2025 14:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7I8m-00058O-9K
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:46:57 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7I8j-0001wp-Rf
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:46:55 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-330469eb750so3038862a91.2
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 11:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760122009; x=1760726809; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BaAMVG8x7rCFG+HJXQodnPqJ9NCcsOADiDQibn4Sv20=;
 b=O8qwKSnSSSS8qkzPA5r/WF22aRFISNYv3M4Xl0sK+nj2yMtZrHg4JuOpQ943G/6m5o
 AegwpaNzrPhZDG9rApYULOG66kzifknIgAl/cu63A9YM798zWVHG5scusLay9YMovVAT
 W0E4ZyAsqv051/N+v8bixxnVq/0Yg8nfla90RzmC/gYrTj4krPjElBWK8xA5qpM2E/kq
 j/yXFUEjwoa6KBKlhsiEjOFMErGUT5A/XPRLqeW/E5Yt/sAMEI3Uamym2fUr/VfiGN2a
 Zkdij3UffuWmEV0WIZII03MNQfAHCqOmczbDdNoVVlWdXuRe4YOkfZKLZFmNHq7kdDUI
 mx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760122009; x=1760726809;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BaAMVG8x7rCFG+HJXQodnPqJ9NCcsOADiDQibn4Sv20=;
 b=fKLnVCGumfiuguaZPVdpD9YOt6CjOPK1WGa9HRgZgKTdZOb5NCSxs3KKHaEowKqY2X
 T2ST5sgPac4HUtbSN5r554VJmAB6xKWEjeN5RM/ItcAcJ3HQBUHN3YL+hd50OJkhFF8A
 YK5w7ktXY189XJR85Cd5YdMkPgbOxSXKi2CIRJ4YTfsTyxwVFOxgahb3E76DMZkdpA6x
 4p3zi/EZ5IegL4yse1+NraGhQeyNLcqSCS2M5j5erMu8Y1fg9mAfCIIY01gzsFXpRR8m
 7LAxxr0w4xcXkLHVR2M8Jd10tAmesGMAi2n6mCrvaVUT4sE+YZLnIVPodzxfnVGas4Lj
 +dfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXetrMpk/dxwq/XYm+77h99CrMUu25B5xBQs2DWXXYJJU8zOPNOLfKcc0HoKSglwvLHdQhc5HtscKnj@nongnu.org
X-Gm-Message-State: AOJu0YxHMgKdHV1QPRb12LM421QnBIkisBc3YwcShY5OcKLQGLp9Znz9
 delT/bB3LDI3/17edzNapXlBVTeShNmUjE/XSYEabV16dEFgNnW0EJWm5r7k/cbA1qI=
X-Gm-Gg: ASbGncujf9W+Jt5DsBZueoHSrhK/96wXMR/vjLzwImZYlfAGXpb5FmwhJzbRH9cUY69
 dglqU71mSYOUm4ONeERFybtv+7Zd7ZX2eNGt3rDJP0ZDy25iNlfI1NOiYZz6fsyr3K8QEPTIJiy
 4ha99yWrxG7RMu8dhayh7yFjD0Go/SkCP0Ab2vW85KE/yUlrgPvInIzHrjA5SpJjRTJUX8R3BYC
 Z1RThvjckvzlAc+MAC4hdfhKQ2UnoQCOJ6yBDZcwdDkvsdVcsaA5nd128q/3JfoFgztQ2yeZVh3
 iqKs54z8BzhOBxMuyjUJeFXTe0GWDSq8gSGfZ4WGZnEhEq91kj8FWmyIvcdUQk5hkRvU4/QI6FW
 jAUzMA57GZpjxqg6DAxkgUIaByAqy6gxAUDuhi0s+6wlcyP/uiw1Zf5fBJjs=
X-Google-Smtp-Source: AGHT+IFg63zRCk5UcLVDH6NW58GUWqrAVOfa8jMHsdk1A9c5u6PCOpF2ekIy0yzbSreg2ehltj+tCg==
X-Received: by 2002:a17:90b:4b45:b0:32b:65e6:ec48 with SMTP id
 98e67ed59e1d1-33b51106a08mr16902675a91.8.1760122009406; 
 Fri, 10 Oct 2025 11:46:49 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33b61b11ca9sm3991107a91.24.2025.10.10.11.46.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 11:46:49 -0700 (PDT)
Message-ID: <c79b9dd9-02f9-44ab-a806-5f81e8bac310@linaro.org>
Date: Fri, 10 Oct 2025 11:46:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/13] target/riscv: Conceal MO_TE within gen_amo()
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
 <20251010155045.78220-4-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010155045.78220-4-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

On 10/10/25 08:50, Philippe Mathieu-Daudé wrote:
> All callers of gen_amo() set the MO_TE flag. Set it once in
> the callee.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/riscv/translate.c                    |  1 +
>   target/riscv/insn_trans/trans_rva.c.inc     | 36 ++++++++++-----------
>   target/riscv/insn_trans/trans_rvzabha.c.inc | 18 +++++------
>   3 files changed, 28 insertions(+), 27 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

