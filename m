Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA4F7CEF172
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 14:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syBJ6-0008LM-Hb; Tue, 08 Oct 2024 10:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syBJ5-0008Kv-7L
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:35:23 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1syBJ3-0002Li-LU
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 10:35:22 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c89f3e8a74so7893652a12.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 07:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728398119; x=1729002919; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ejEHR1wMlkNLtiJ1Hqtaqwe+D7rXesFiFwGrxD/Swxc=;
 b=oeC8l3VaX5McD6Umg/WwgNNFE1V7OcHqY37Q3h2vy/kD8wr78/vtGgB3k9ODiQkRdN
 zwC99BpgmqL5A+6kErebcweJaPm/XczAlMMKcPa3Jx1eYeJbIKqKVE+gPxkSFp3TYjNU
 XVBOZnNPHHUjhmmySn1mc2kEumAk2ieAfTgjpFZPCZQYhuRR+VJ9jDznO+jyNsXwGTXV
 TAIqAFsD5pEOENHZf6lJNgUXtJ4XGaMkzWl9rfGlwOpJdCLo4pxCABhGkUPIADY9p/ct
 qXeuy8TZSToa6D4njI0Y+pQpXDGWKeNq0uBUAAJmfNXZBs4i6PwmG8L8pSTjSVAUq4Oi
 JSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728398119; x=1729002919;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ejEHR1wMlkNLtiJ1Hqtaqwe+D7rXesFiFwGrxD/Swxc=;
 b=HuDlzzwj6S1w8PuK0dP833cXbPEjw8tjvoi2XSEU+NoH1YnA9oeGRj39Gd9z4Qyg+B
 0QtfVyz1SExzr8oyVExJoGLjNGLOBgc1DO2p5Phtd0xlV8o6075B2m91SQjYBQ90SpnB
 Fr7nufJfJ0mIZrfIQ5BAnpALeumJPGxiHoYfdmxIvfMi9dA+npHTq9hTA1KvCd0zEEAb
 Xdhby4d1ma84943ybRRfCXEqLNSU3ZeYTdO9vKnYBHDzdsjHJO0v4HM77rhs/zrkDLgP
 9noS4IOT8O8l4jTy00lorQtz1zCXDcA0Q06tHdWJoXY6oIZJtEDHP/A6PlvbQtvOiPCP
 3Hrw==
X-Gm-Message-State: AOJu0YxUydKR43CfvAfH5awTmNohgV7UdUL/3oIeXwhaPIgFCAfpNKD8
 51yXdP0r7tZzqT9TBvdpBKg/mUaCBDro0VWM/R27M5SPGMjDdJcoLDT+Fqr3iTbmd+9mCAr1Yb2
 503HeoM9THDaxINnRLwlnUOjSa1oKmLvAzUIpvQ==
X-Google-Smtp-Source: AGHT+IEJhPFIg7Qd18l/zzU6VuxNjyfZlpL9dJ5GySWcXx1gRxvqO8ZcTix41f8blmGjq8Y98ULXs/w/4SLM1BwGu+4=
X-Received: by 2002:a05:6402:c42:b0:5c8:ad38:165c with SMTP id
 4fb4d7f45d1cf-5c8d2ebdaf7mr14866174a12.23.1728398118716; Tue, 08 Oct 2024
 07:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <20241005200600.493604-1-richard.henderson@linaro.org>
 <20241005200600.493604-15-richard.henderson@linaro.org>
In-Reply-To: <20241005200600.493604-15-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Oct 2024 15:35:07 +0100
Message-ID: <CAFEAcA9B1OsYgChehuz7uRgP-=Mbh=4zSK+owJz+BoBvA4Cnvg@mail.gmail.com>
Subject: Re: [PATCH v2 14/21] target/arm: Pass MemOp to
 get_phys_addr_with_space_nogpc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, deller@kernel.org, alex.bennee@linaro.org, 
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, 5 Oct 2024 at 21:06, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Zero is the safe do-nothing value for callers to use.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/internals.h | 3 ++-
>  target/arm/helper.c    | 4 ++--
>  target/arm/ptw.c       | 2 +-
>  3 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 2b16579fa5..a6088d551c 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1461,6 +1461,7 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
>   * @env: CPUARMState
>   * @address: virtual address to get physical address for
>   * @access_type: 0 for read, 1 for write, 2 for execute
> + * @memop: memory operation feeding this access, or 0 for none
>   * @mmu_idx: MMU index indicating required translation regime
>   * @space: security space for the access
>   * @result: set on translation success.
> @@ -1470,7 +1471,7 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
>   * a Granule Protection Check on the resulting address.
>   */
>  bool get_phys_addr_with_space_nogpc(CPUARMState *env, vaddr address,
> -                                    MMUAccessType access_type,
> +                                    MMUAccessType access_type, MemOp memop,
>                                      ARMMMUIdx mmu_idx, ARMSecuritySpace space,
>                                      GetPhysAddrResult *result,
>                                      ARMMMUFaultInfo *fi)
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 3f77b40734..f2f329e00a 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3602,8 +3602,8 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
>       * I_MXTJT: Granule protection checks are not performed on the final address
>       * of a successful translation.
>       */
> -    ret = get_phys_addr_with_space_nogpc(env, value, access_type, mmu_idx, ss,
> -                                         &res, &fi);
> +    ret = get_phys_addr_with_space_nogpc(env, value, access_type, 0,
> +                                         mmu_idx, ss, &res, &fi);

0 is the correct thing here, because AT operations are effectively
assuming an aligned address (cf AArch64.AT() setting "aligned = true"
in the Arm ARM pseudocode).

Is there a way to write this as something other than "0" as
an indication of "we've definitely thought about this callsite
and it's not just 0 for back-compat behaviour" ? Otherwise we
could add a brief comment.

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

