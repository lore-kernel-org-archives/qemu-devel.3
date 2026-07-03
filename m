Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5917C43458
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2026 10:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfbRr-0008T9-HH; Fri, 03 Jul 2026 06:48:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfbRn-0008RO-Ag
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 06:48:40 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wfbRl-0007wy-Q7
 for qemu-devel@nongnu.org; Fri, 03 Jul 2026 06:48:39 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-66628618509so581344d50.2
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2026 03:48:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783075716; cv=none;
 d=google.com; s=arc-20260327;
 b=gm1Bem36ToPKbZGUdddXVN5QKe2ic4jAqNXKOANMfu3VCv6QQ7yW3bRrFqBxNS/vTC
 fzAczk43qnnHjkieAGkHO39bUnEitY8lV/IKum2RS/nm4p2jZfu4i3tK+p7fi9lU+Sbg
 2hrVs4Ki+WO7D9HPFcpHCdrHBH/txANIo3QS64ZdGzXJsGhB4oGBlqSNyf6jXoA7bgSn
 XIjp1/EEXO9/7FP1nGfDHcMumMUFTpA9P/gMYnJxQO3gSeR4dKAmNR0wT7t4fdMzWQ7i
 QnL679272sc2MHe7IhTnKqh8Tksz0e8zhqghqvEIpG1b15Y1SkldnhPwxJFUconed3nX
 U9vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=MMS1CLVN9/uJZ+7HZ4p4rGchY5uieE3LZId1saVr7Yo=;
 fh=aqCwq12y8nVWQmqz9Odk+to9HU73TrWpjU8wHvZfe/g=;
 b=CoW96997TicFDrkRV9embYB9FUY/WLbGXPQQPd3Ca5lnlC65afNIdKVTicBXU3RsPw
 rNo1qBWQE3tUYueGfMkLu+NpP9RQaTZiVjtHEgVlPyKxjboSN2iTXWQXaEOKk45BX4Nv
 Su7kk/4FF2OXSgsL0O87B7LkkcEK/WQgUULiKKnzwQRMv/DoCmGJDDJQVZyCppEQgqxA
 vGFoT4CUP8WiSdhNrxvmmmx2GS3o6zvi7JjyBKC3bX3at/NyqJkjynaDFZ6zA/wFBx49
 AwnG4bE2jZdWslo2UPRauszpNv5WfNPjXisDCK4SdwzDNpV8epIUGebext0+7IMyoXTt
 nkZw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783075716; x=1783680516; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MMS1CLVN9/uJZ+7HZ4p4rGchY5uieE3LZId1saVr7Yo=;
 b=faAwzbfwiF3fMpbHNQB7d/nxnI45NYeB9a6GjrqxdRurU3FS64TxhV//RKKUC1CRkW
 qpQs16tj+hF6EohzWogVFG4636Zuo4pKii86ikVZ+nTUkaU6rHXhIVmSPqBy/zjLS3KR
 nz5EowMDXfwBUA5TmvOrpoU6aDhEdbRnMG//Ngb3auq3YkayLbEGqu6uAst5xE8FWcCN
 Jq4MwGvldKcwVc5eFTqDQ8KHL5Kv2qaTUzhRrsna8S+gKxzx45/5ZU+EyoiY2+1kCPZ2
 AViKGS8/EFwgpG0Nf655MbS11J2xsK/b0j5OhMEgV2KjdHEkM/skMH1AaRHGzxCGEL1o
 u8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783075716; x=1783680516;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MMS1CLVN9/uJZ+7HZ4p4rGchY5uieE3LZId1saVr7Yo=;
 b=sHP3gEEWLzwt/U9FgyZ0pEDHZl/IBgso+LAsh028ua2JS13a3N6czkGLKzT1/1afnv
 NJFWT2hF28nSGKOyU0tdWrvFXQAMA6L3VT5aq1UXj3Bnk98kIjINO+oaRWC58OUc+Ybc
 jJtm4MS4PmJvUNp9lCCBvcwOn/0hb6EVanZEXRswtD+5TLgp8tipRAC9uJKks2Hp9E29
 pAxKWbY68rufeqDleKjs5sjv1xgVMt27C2zk2w4TEBxfIUcmqFtrH5c8TpBmY+6pe6Tq
 NUedfI9RQVoAuApaxy21mxaRArAGOz/jxSbn6TVciD8ZrvRmnKoSIz/L/ZCNEvRS6FtJ
 tnyA==
X-Gm-Message-State: AOJu0YwIj/sT69O1wVWOKxiNU3mOXmEZCjCPB4f8VpyuFYcoT1u44VJb
 tUCR/5+RHKos2yd/9YaWuT/6iusyBtoLrMs/maemhNaCg8/DUHPz8IMUi/5ldaoDJHXCSfZE5+e
 8u/z9N4uI1RxSowM94nnkK91cQEotA5jXxzk8KCn9fA==
X-Gm-Gg: AfdE7cnkTVZLolry1AZS1HfMWBB2Vh0/Ug+gIQShbKTAtgaHSizGKk2Q4clkQ8zuJO8
 drIoLwdfyyYM/WplUOf7q96DJqTaOU04yxwfdE3Pa0BRdqWgYrzZvYfm7CqWGN9TBHVVJQLTj1m
 qjv0DNxpwphZGHb7CE/VoqnAxDC6VpglAjoajEPfCILbNeeHecToWh4U+VIh2n1PFW2axcEA41k
 7gXUJl1HEgR2nAWz9TBOf9iIqcR7CUUJpK5vN7rxGDJxvU2gqJoL1pTvlEi5+qaF4yPy/GuwRZs
 7fpohA2hBXc4wXjfjrfRV/T4GyjVmJ8ijgt7dgY2Qz+sDTPLpZw0BPRB
X-Received: by 2002:a05:690e:488c:20b0:664:c9d5:f8a8 with SMTP id
 956f58d0204a3-66521bcccdfmr6595961d50.70.1783075716337; Fri, 03 Jul 2026
 03:48:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260629131232.2487780-1-brian.cain@oss.qualcomm.com>
 <20260629131232.2487780-65-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260629131232.2487780-65-brian.cain@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 Jul 2026 11:48:23 +0100
X-Gm-Features: AVVi8CeBlgutzVcKs5tNPABfrAiKskIszwR6531uOkmwAeRjBq7-S6PLKDPVl50
Message-ID: <CAFEAcA-4mo6MCm6o+U1fH_HnqSxTob9eWwNKhJL9s0zk+HEoNA@mail.gmail.com>
Subject: Re: [PULL v5 64/77] target/hexagon: Add k0 {un,}lock
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com, Brian Cain <bcain@quicinc.com>,
 Taylor Simpson <ltaylorsimpson@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 29 Jun 2026 at 14:44, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> From: Brian Cain <bcain@quicinc.com>
>
> Reviewed-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/sys_macros.h |   3 +
>  target/hexagon/hex_mmu.c    |   4 +-
>  target/hexagon/op_helper.c  | 119 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 124 insertions(+), 2 deletions(-)


> +static void hex_k0_unlock(CPUHexagonState *env)
> +{
> +    HexagonCPU *cpu = env_archcpu(env);
> +    unsigned int this_threadId = env->threadId;
> +    CPUHexagonState *unlock_thread = NULL;
> +    CPUState *cs;
> +    target_ulong syscfg;
> +
> +    BQL_LOCK_GUARD();
> +    g_assert((env->k0_lock_count == 0) || (env->k0_lock_count == 1));
> +
> +    /* Nothing to do if the k0 isn't locked by this thread */
> +    syscfg = cpu->globalregs ?
> +        hexagon_globalreg_read(cpu->globalregs, HEX_SREG_SYSCFG,
> +                               env->threadId) : 0;
> +    if ((GET_SYSCFG_FIELD(SYSCFG_K0LOCK, syscfg) == 0) ||
> +        (env->k0_lock_state != HEX_LOCK_OWNER)) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "thread %" PRIu32 " attempted to unlock k0 without"
> +                      " having the lock, k0_lock state = %u,"
> +                      " syscfg:k0 = %" PRIu32 "\n",
> +                      env->threadId, (unsigned)env->k0_lock_state,
> +                      (uint32_t)GET_SYSCFG_FIELD(SYSCFG_K0LOCK, syscfg));
> +        g_assert(env->k0_lock_state != HEX_LOCK_WAITING);
> +        return;
> +    }
> +
> +    env->k0_lock_count--;

This causes Coverity similar problems to the TLB lock (CID1660927):
we assert that k0_lock_count is either 0 or 1, but we haven't
obviously done anything to assure that it's not 0 here, which
would be an underflow.

thanks
-- PMM

