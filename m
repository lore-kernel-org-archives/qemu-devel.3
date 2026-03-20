Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCFD1098782
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 13:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3aLT-0005x9-Ou; Fri, 20 Mar 2026 09:56:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3aLS-0005wg-FV
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:56:58 -0400
Received: from mail-yx1-xb12f.google.com ([2607:f8b0:4864:20::b12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w3aLQ-0002Yt-UF
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 09:56:58 -0400
Received: by mail-yx1-xb12f.google.com with SMTP id
 956f58d0204a3-64ae2ce2fe1so2276773d50.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 06:56:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774015015; cv=none;
 d=google.com; s=arc-20240605;
 b=J1DSmLy1fusD/x+D3L+ohXrHjfAL6aRqmrbypIEzzm9x+yMtM4dcYOcObWjL509dAj
 reFg6KtdJtv0Iyfo/Xw75u1ZU5C1PCVTxOgU9tZyE64GwAnUY3q9C8ULglQaPLj0i7tk
 RMVPzrozmSUxkx1OLJQR70ox/wsaFkxRY895KErafBtBG1fgq7PiyJGFF9QehDZUE8Tt
 EgDjMsSXC31scv3qfndr3dD4BSMzO53/pq1xO/6d9xxEVHtpjm0W9y5SC9gJYIwlZ37E
 lTlj9RwlTAYRpFLmlmo1RK2s7SSmesVs502q7N8ZSwCEYVNZ/ZNkWLFKKHp08EzzJePb
 Jo9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=S1EwBLWU7G5uEdYNNHWnvG8cPp9NmINv8yJDNa5zqB0=;
 fh=ihissIBvzhTfs3cepXrTWVpDra6uY51OVmA9LkehGhs=;
 b=lCTh8CxOeK6NUNt9A9IzTDuDrYslDZU62dtdz5x87eUEeDVVpPhzqbPuiuvosb8GU0
 ieENcIVCHHcVg1q002KCR0MosBBiTXM2UOAox1EIZl0MFaeVYgLh0eJHY1Wh3sD7JGme
 /09mJClr2U6a1xk6xDgq65qJUdMFRQTZae0UAPNlWq+WOjnXTEXhnPV+IXe2tNWMQ6aR
 144Ich+WB7a+D4t082ZqzpH26Jem2QyEc/vu26yMixIMkfdqEqTbFuqSI0rYDiYnnihs
 VTWnB+BrUX3fX8VN4kMZMSPh6iONJE58FGLRArDm8eg6/2FgLOrz/D7RJbU5q3+YZwHY
 NWeg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774015015; x=1774619815; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S1EwBLWU7G5uEdYNNHWnvG8cPp9NmINv8yJDNa5zqB0=;
 b=N2oWNjcf8POnurLGLAlyUq6Z+LLXEPCLvcBUYd6dr+Tmmz/plROWEvMHvhdB6Y4VLf
 Dc/luUK9vtnXp6RzIPe0IRDKr2o4xjLcLDr2QhvII9gcQGQm7y40kGoEtnspVKTeN4GV
 DuChpWPhHGtRUpQX4UuDD84Ok72cUySv0fCnQ8w9eEPVNpmeknFMM/x6VJ/U+3DD9aww
 WvX1sTXVv3ak8exPtk0UUc4M+p7c9ff+5aek1cbOM2gocPUyL+vYakywrz+YSP4E6tJe
 PnV+CSMK7SAUOdYNxQQqIQFlpvpAaKivMUJ5hNR4PGu2lnwWEfxzTkMA/xg6mFTJE9Ws
 e6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774015015; x=1774619815;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S1EwBLWU7G5uEdYNNHWnvG8cPp9NmINv8yJDNa5zqB0=;
 b=RtBqDpJTymRpKtSaVtoO4P8Tf7nOG5qe/0zJGl31cvDGFrgF54hTuV7kZdNP87E4eQ
 k9UEAqzf1duQUeH+fvI8JIiUKcUhYj+rtsxDvnCipFW0GaqojyYXGPTpiguMVOHr26XA
 LrGJRgGwCz4iE689wCmjn+DsgdStRThAOyM2Z7zCUSllsTYdyHvWa5WHrkLUSYal91QX
 yFMcKVC27+sg9/TFu2+ENdkd+Oi5rCLL3V6EEa5+aRY/mp8OtCgsH3wx+cX7aZ9RGLsA
 QgeeEyuo7wPfiwTJZcSowI7PqgvFgxaa48Z7Eup+4iPPNnOEhaWfcKTqxGP82RlYlKwE
 pyzw==
X-Gm-Message-State: AOJu0YwMpEG1tHk8zDvhaUBOChVpko5aulc8vj8W/20qZHGk8r0K5zc3
 6KM7saQvSUqfyFlHKiq6j6rF3kv7uDlyC0w8nsGiDX7/Vi322N0NNosLECa4fiwaIoKT1HOTxqk
 N77MRBFajyPFFTFfhBQCOgX7BFAG1KuPLqZcN6jdWsA==
X-Gm-Gg: ATEYQzxAhhrueCE6bIXqol+bwuZWg5vUIUWlggTrm5+P7mwtkEiP3XVz3r1rFJVTpy4
 jd48ifgLl79fnXBsdNnhFOiDL1knaexRNz5IKIFd6UD8FiQ6KY7DlxJMhmAdeTxfRe2eWlFzvMT
 ua/sKQMIgJoqlNTzP7X+KQU9G+NIcfsHL1rMaab/FMLSh5uulExy1FjRxOig/ntD1ZkQhFo44ML
 0B46xypkD+xg3Q8b1L7L3okCxQoPGgk6h2EeZafnA5rhybvlVTnbzxeDTAVIJo3z8g0e632yXKX
 qBrPf0deMPZD6o2yLnEqrJSmqliQTNeYzCRUlbVIRrt9IhpQuAGBXOBed0+/0nK9frQ=
X-Received: by 2002:a05:690e:144d:b0:64a:dcac:afec with SMTP id
 956f58d0204a3-64eaa69805bmr3087889d50.4.1774015015417; Fri, 20 Mar 2026
 06:56:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260320135039.26546-1-philmd@linaro.org>
In-Reply-To: <20260320135039.26546-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Mar 2026 13:56:44 +0000
X-Gm-Features: AaiRm531T5XhZGN2FtB7LqjnzlilirBDK-tUa-tpxjm8aIrrUegGKXiCwBC919Q
Message-ID: <CAFEAcA-M=jNzRcPbVyb3YBFSzdnd1frwnR+1Rmcxha2niwEyvA@mail.gmail.com>
Subject: Re: [PATCH-for-11.1] target/xtensa: Have 'info tlb' dump MMU
 information on monitor
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Max Filippov <jcmvbkbc@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Anton Johansson <anjo@rev.ng>, 
 "Dr . David Alan Gilbert" <dave@treblig.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12f.google.com
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

On Fri, 20 Mar 2026 at 13:51, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Currently 'info tlb' dumps the MMU information on stdout.
> Propagate the @Monitor argument and replace qemu_printf()
> by monitor_printf() to dump information over the monitor
> (which is not always stdout).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/xtensa/cpu.h        |  2 +-
>  target/xtensa/mmu_helper.c | 44 ++++++++++++++++++--------------------
>  target/xtensa/monitor.c    |  2 +-
>  3 files changed, 23 insertions(+), 25 deletions(-)
>
> diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
> index 22192924841..2e56e337022 100644
> --- a/target/xtensa/cpu.h
> +++ b/target/xtensa/cpu.h
> @@ -694,7 +694,7 @@ int xtensa_get_physical_addr(CPUXtensaState *env, boo=
l update_tlb,
>          uint32_t vaddr, int is_write, int mmu_idx,
>          uint32_t *paddr, uint32_t *page_size, unsigned *access);
>  void reset_mmu(CPUXtensaState *env);
> -void dump_mmu(CPUXtensaState *env);
> +void xtensa_monitor_dump_mmu(Monitor *mon, CPUXtensaState *env);
>
>  static inline MemoryRegion *xtensa_get_er_region(CPUXtensaState *env)
>  {
> diff --git a/target/xtensa/mmu_helper.c b/target/xtensa/mmu_helper.c
> index 71330fc84b9..766fe60e2eb 100644
> --- a/target/xtensa/mmu_helper.c
> +++ b/target/xtensa/mmu_helper.c
> @@ -27,7 +27,6 @@
>
>  #include "qemu/osdep.h"
>  #include "qemu/log.h"
> -#include "qemu/qemu-print.h"
>  #include "qemu/units.h"
>  #include "cpu.h"
>  #include "exec/helper-proto.h"
> @@ -38,6 +37,7 @@
>  #include "exec/page-protection.h"
>  #include "exec/target_page.h"
>  #include "system/memory.h"
> +#include "monitor/monitor.h"
>
>  #define XTENSA_MPU_SEGMENT_MASK 0x0000001f
>  #define XTENSA_MPU_ACC_RIGHTS_MASK 0x00000f00
> @@ -1082,7 +1082,7 @@ int xtensa_get_physical_addr(CPUXtensaState *env, b=
ool update_tlb,
>      }
>  }
>
> -static void dump_tlb(CPUXtensaState *env, bool dtlb)
> +static void dump_tlb(Monitor *mon, CPUXtensaState *env, bool dtlb)
>  {
>      unsigned wi, ei;
>      const xtensa_tlb *conf =3D
> @@ -1091,6 +1091,7 @@ static void dump_tlb(CPUXtensaState *env, bool dtlb=
)
>          xtensa_option_enabled(env->config, XTENSA_OPTION_MMU) ?
>          mmu_attr_to_access : region_attr_to_access;
>
> +    monitor_printf(mon, "\n%cTLB:\n", dtlb ? 'D' : 'I');

Shouldn't the change to this function be purely
 s/qemu_printf/monitor_printf(mon, / ?

>      for (wi =3D 0; wi < conf->nways; ++wi) {
>          uint32_t sz =3D ~xtensa_tlb_get_addr_mask(env, dtlb, wi) + 1;
>          const char *sz_text;

thanks
-- PMM

