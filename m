Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62467CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 18:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7IEb-0004bn-13; Fri, 10 Oct 2025 14:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7IEY-0004a6-Ob
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:52:55 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v7IET-0003P0-KJ
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 14:52:54 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-27d2c35c459so17302005ad.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 11:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760122367; x=1760727167; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=begoUp0oBV8mpS+yptjnrr4rI9lBPYiXV+KmzPfLRAA=;
 b=aVPo96br8E/hHbAQIkpUOPFXLM5T7cZoFlqhcTvB1/dvajWAaYodt8kMZ4VQ1+Gi/Y
 Xs4lm2P8whwiUZdQ0KGQgLv51HquvSa+R7kqnsKDjE8vaCzu0PjgPtxKVurYiEVBk7ba
 5HM8Ch/KJNuIlrwNr0t7TIfCIlE/KD9TtSo5H4dDzYZjG/ywHgRmW5b5ulK5zAs4/4XP
 xBwiMvgS4D1jfGJLJLCbjpdhMqpaSnLvZ7WSsVcEJJQM4+vlAPvCUE7cQxoj52yVGssK
 UnT3026mwEala/L7/N81SIIJHTubo0X0qpPzQHwxQJbEBIrfH4k11bsyvMBEaX6yJ6/q
 al6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760122367; x=1760727167;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=begoUp0oBV8mpS+yptjnrr4rI9lBPYiXV+KmzPfLRAA=;
 b=GJULpmImTeIjSc/kfUiBkUMEcVtIj49h2bqEOVdj1G7jEuP+axZc94f0n3hZdsWnnR
 YeyWYNksWtONHvhWOZiiEhrlDy+djXyZMFhVqUtvwy/nzJXlsSNrx/ODpwAWahN3ZOkX
 tf+oqU9wrurcNrqwU+RkSdWAVlkuSC72U/cc3FZkZUdBev1MGpFcciiTkUlXV1YFwtPj
 VvTdFNlRegOCV/PgxGwo+8InTldcv0ug17DAbajEqR+F0ITxy4tASlszHsQPAtYZX90p
 CYWZ8BDv49+nwhFeKN9HLh2x9yJMxhZYVe+Aas2YwaRLf7QQTI875YmztZtHPos+cfb2
 wZQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgzLX/ZsKYoB67BkrNXoiDeijtbPH274NP4eqm4BE6lgrJC31aIDD3dRrGHlVCzAgUvxKFkDglr3OC@nongnu.org
X-Gm-Message-State: AOJu0YzHNYRyfEMn+8PKEHp8Vcbs+Tt0d+h8ws0niCVuCw2yq9s/khB7
 H5+PE27x2aF4pB/dMF6hefNRYJKKtHVoN/rFfgpO9+9A/pEfF5YRX5+jLGoQyWLzJoI=
X-Gm-Gg: ASbGncsHYIU/S1ukPUpdRrF82D9t3RpZxv1Wid9ictMRYJbo5kDQIhk+yEmgIYY86fM
 UKOU3S9U730gksHEItYS07j12QCG97gFKD5A32wYFkM545Vg5lxPawMa6HyXI3+W/qWubm0wQaD
 LrWB1eFDzRqJHBSvzzkXtJpKR+e49PwM//koSPJRRIOk0hsLRRuOxdnRl3fphhnmPTTskaMWyXv
 H/sVu8Ddg0Yj0dYsIk0TyDXe6blUBE7n+6zT6Hgv42Q2xm7LtrI9QxHWVBnza7Rnr5BeqJBFE8k
 mb0W/0hvljywkiFQ2RCJ8COeG4+Tvyd7XMLIpz+4GWVwPdf2Yi1zAW9ANslZiGawDBcyPHSmyXe
 +MCmCEx1zE4q000DKCWZVjVOrR6gaPGfRH+/JPtUaGRMBTsGPGTMhlCE4xAQ=
X-Google-Smtp-Source: AGHT+IFfo0U7WIH0emhwkwA7of07IN4JrwB/W5cyscaQuQayoeEX/oVz/AthJgh7WHEKnKYwRZs9gQ==
X-Received: by 2002:a17:903:1aa3:b0:269:9adf:839 with SMTP id
 d9443c01a7336-290272b3357mr162622405ad.19.1760122366903; 
 Fri, 10 Oct 2025 11:52:46 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f56c04sm63704165ad.110.2025.10.10.11.52.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Oct 2025 11:52:46 -0700 (PDT)
Message-ID: <7a504cd1-4935-4801-b473-88bdf10312d6@linaro.org>
Date: Fri, 10 Oct 2025 11:52:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] target/riscv: Introduce mo_endian() helper
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
 <20251010155045.78220-13-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251010155045.78220-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
> mo_endian() returns the target endianness from DisasContext.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/riscv/translate.c                      | 18 +++++++++++++++---
>   target/riscv/insn_trans/trans_rva.c.inc       |  4 ++--
>   target/riscv/insn_trans/trans_rvd.c.inc       |  4 ++--
>   target/riscv/insn_trans/trans_rvf.c.inc       |  4 ++--
>   target/riscv/insn_trans/trans_rvi.c.inc       |  4 ++--
>   target/riscv/insn_trans/trans_rvzacas.c.inc   |  4 ++--
>   target/riscv/insn_trans/trans_rvzce.c.inc     |  4 ++--
>   target/riscv/insn_trans/trans_rvzfh.c.inc     |  4 ++--
>   target/riscv/insn_trans/trans_rvzicfiss.c.inc |  4 ++--
>   target/riscv/insn_trans/trans_xthead.c.inc    | 16 ++++++++--------
>   10 files changed, 39 insertions(+), 27 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

