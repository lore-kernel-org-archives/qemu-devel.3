Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511F4C3DA59
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2024 14:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVBJi-0003xj-TT; Sat, 20 Jul 2024 10:44:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVBJd-0003p2-Qt
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 10:44:05 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sVBJc-0008CQ-93
 for qemu-devel@nongnu.org; Sat, 20 Jul 2024 10:44:05 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5a1c49632deso1987803a12.2
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2024 07:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721486642; x=1722091442; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CMcbGilH8Rh50JE8ohtT5nPQ0eOe5/ZtzOcMO5NB0fk=;
 b=urqPm+M0FsWDcLh+DU8ULQb+ldXmY953DXkR8KpPS+TgaubFlrxNgoEInzc2+ucNID
 kj5nIb4gcSuUgyMcEyMUI6WarKvtZSWfOvGp6HQX4tM/jvZ3/1evfIf+Evdicl8BqpGh
 cs39PO00uq/BfaQH4iN03ypzkH10c9fulKm+ccKT/vwR0r3V43oRnK45NP5SBu3ESv9X
 F0I0Wtajg0AddCGd5TsQoVkRUWs/E0rdwJrsIaGSMWb05mhhrxuQ233azfpflF1T/gvV
 1DvYAqgASyRKVxpq4r3isweKr4S0YeWTPq7HiGrcHgxCNbAW+voywOlrt4VWqsK6q3no
 4csw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721486642; x=1722091442;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CMcbGilH8Rh50JE8ohtT5nPQ0eOe5/ZtzOcMO5NB0fk=;
 b=AgxLpUv2AWucr18LX7xZ5pOwPY/kJB7dp3jQzzVGFD9HotDSlc7bfwyXeD+f+zLfi6
 5pfsE0aIFfjWTn1m0/9BsId1JfL7NIJTPXdWo/f1/Wt9cojJ8wJqYZMtyhG478WTAWTv
 bDhWBfNiwCztwonLmvSlgQfvi1Zt6ku0LJWEQcJtx91wgNHpjJi+xps6On7eDPFJX2Q1
 bLLEj7KoyiMjD+GvIYqWzASeshIWmn9zWUCRk17/LivmZj/JXnKkY2qqrjpRaCmDNbwE
 Kuu13t0gGMGft+yldsR4NXF4G+f/Tqq+lBqES2GhECMbgztxPN0twWR85kybdTDRymf3
 Wm4g==
X-Gm-Message-State: AOJu0Yx1QVbaDqZyCqvo/YbmGTDMZZHuiaC9lMWrhGvB1d7TnE0vrTw6
 P/mftgxL7ufq8ntmEejiOX46TcmhXx8o6RgdnW/OFYij12+p709IxaT5zfJvbr70GCD0GcBeTLM
 r3gCkvmA9FiRUaOIZZjMtq8qU3M+Zf2hHo/hhuA==
X-Google-Smtp-Source: AGHT+IHwbFhv/Xewmx4Bzbn7FfwLoAYLP42+2vJL9qLkmIHCsh6UhWLSQ6wKiKiyhjnEExeEcT+RvLeJem/pT1H1mrA=
X-Received: by 2002:a05:6402:528c:b0:5a2:2101:a714 with SMTP id
 4fb4d7f45d1cf-5a479677407mr1246247a12.25.1721486642063; Sat, 20 Jul 2024
 07:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
 <20240718021012.2057986-22-alistair.francis@wdc.com>
In-Reply-To: <20240718021012.2057986-22-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 20 Jul 2024 15:43:50 +0100
Message-ID: <CAFEAcA9dToUo9LwxQwCLSL=gVTXWs9M23BpLhm+eD1rZShnehQ@mail.gmail.com>
Subject: Re: [PULL 21/30] target/riscv: Implement privilege mode filtering for
 cycle/instret
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-devel@nongnu.org, Atish Patra <atishp@rivosinc.com>, 
 Rajnesh Kanwal <rkanwal@rivosinc.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Thu, 18 Jul 2024 at 03:12, Alistair Francis <alistair23@gmail.com> wrote:
>
> From: Atish Patra <atishp@rivosinc.com>
>
> Privilege mode filtering can also be emulated for cycle/instret by
> tracking host_ticks/icount during each privilege mode switch. This
> patch implements that for both cycle/instret and mhpmcounters. The
> first one requires Smcntrpmf while the other one requires Sscofpmf
> to be enabled.
>
> The cycle/instret are still computed using host ticks when icount
> is not enabled. Otherwise, they are computed using raw icount which
> is more accurate in icount mode.

Hi; Coverity points out some possible issues with this patch
(CID 1558459, 1558462):


> +typedef struct PMUFixedCtrState {
> +        /* Track cycle and icount for each privilege mode */
> +        uint64_t counter[4];
> +        uint64_t counter_prev[4];
> +        /* Track cycle and icount for each privilege mode when V = 1*/
> +        uint64_t counter_virt[2];
> +        uint64_t counter_virt_prev[2];

These two arrays are defined with size 2...


> +static void riscv_pmu_icount_update_priv(CPURISCVState *env,
> +                                         target_ulong newpriv, bool new_virt)
> +{
> +    uint64_t *snapshot_prev, *snapshot_new;
> +    uint64_t current_icount;
> +    uint64_t *counter_arr;
> +    uint64_t delta;
> +
> +    if (icount_enabled()) {
> +        current_icount = icount_get_raw();
> +    } else {
> +        current_icount = cpu_get_host_ticks();
> +    }
> +
> +    if (env->virt_enabled) {
> +        counter_arr = env->pmu_fixed_ctrs[1].counter_virt;
> +        snapshot_prev = env->pmu_fixed_ctrs[1].counter_virt_prev;
> +    } else {
> +        counter_arr = env->pmu_fixed_ctrs[1].counter;
> +        snapshot_prev = env->pmu_fixed_ctrs[1].counter_prev;
> +    }
> +
> +    if (new_virt) {
> +        snapshot_new = env->pmu_fixed_ctrs[1].counter_virt_prev;
> +    } else {
> +        snapshot_new = env->pmu_fixed_ctrs[1].counter_prev;
> +    }
> +
> +     /*
> +      * new_priv can be same as env->priv. So we need to calculate
> +      * delta first before updating snapshot_new[new_priv].
> +      */
> +    delta = current_icount - snapshot_prev[env->priv];
> +    snapshot_new[newpriv] = current_icount;
> +
> +    counter_arr[env->priv] += delta;

...and in this function we may use those counter_virt and
counter_virt_prev arrays with newpriv and env->priv as indexes,
but in the callsites like riscv_cpu_set_mode() the assertions on
newpriv etc are things like
  g_assert(newpriv <= PRV_M && newpriv != PRV_RESERVED);

so Coverity thinks newpriv might be PRV_M (because that's the only
explicit range guard it's seen) and we will overrun the array.

If this is a "can't happen" case I think we should have asserts in the
functions like riscv_pmu_icount_update_priv() and riscv_pmu_cycle_update_priv()
that might index into these arrays that the indexes can't be out of bounds
for these smaller arrays.

thanks
-- PMM

