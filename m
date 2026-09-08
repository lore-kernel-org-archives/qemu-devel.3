Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68AE3C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 16:26:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3ydU-0002DB-U2; Tue, 08 Sep 2026 12:25:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3ydT-0002Bp-1t
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 12:25:27 -0400
Received: from mail-yx2-x10.google.com ([2607:f8b0:4864:41::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3ydR-0005b9-Es
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 12:25:26 -0400
Received: by mail-yx2-x10.google.com with SMTP id
 00721157ae682-85d46e4cdcbso1227747b3.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 09:25:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788884724; cv=none;
 d=google.com; s=arc-20260327;
 b=PBrdiDUtlbuFTdLPpzeg6R8Jm2/m//X5NNE3kwV1JYiN2SHJbO9NhL2A99UuBGmQOY
 Cp7dXokwLBC1oqhn3q4epVDAqCL5keWOtVP9GLk7UPg8U2N2T8gx+Ra8d+rRoPDgwvHJ
 B+hgAZpHOzy03l+6iIKd/65D+9revIgwrGhCYbRr7aESEJ++SfFdII5huccJPWhCP+0w
 NqEzln/VthqRFB+QQOVJ7t8BCOSToy14/1hSaj8kz8XkM/woHJnqtlncqexvqumCWJ6d
 XvTVSITpsVBkc+/WtELeH9Sm2Z/JL/O21YeHGLbwI1LXBR/MyRXPilS2fn9rY55Rq2ql
 VpTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=my+ZFhuaujN6LDeHb7IAmbevvxBSmQi3eP+e5gOqJh4=;
 fh=CKGv7PpI7GuseLo3IyfferWYLuL7PC/ovF0PN+PD6ds=;
 b=Eh7JIp7ITk+o0myIpmkGJavNPBsHvCIAS2w/MfTC5gBqQIK+JqrLAXUq5aHnUZCH3V
 xufzQdcCvUBAz6ZrBb3W6pCVXfPS/LDmNEt+RBY1S52qGquydn4gNx6HfDbU+EZ6yZA6
 2as/zxCggsYD9eRIrLzXQixbYZmrHVNo2qMaB+0aI7FVxL1pgRiQsQhfnnY5kLV6K94I
 XTCM3MqAVQirx1hkfX2t0dVM07Rwb3bnzlDhh1BiOugRwMOWALvUq+dQOTdV7rO/0zzq
 HXxkv0tGPrW36ySXLHFxrDdYQduzggFI9JeNZgYy/qi/m/+6hSffQ4HsGA+/Ji5ksvWS
 3CeQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788884724; x=1789489524; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=my+ZFhuaujN6LDeHb7IAmbevvxBSmQi3eP+e5gOqJh4=;
 b=qIdXS8LXE1biTSknkLgLe3NKGlOVD6buW4lAn5DcMDZLDQMo9EvIHP5tn30JKqp/kS
 m/V+p8xufIxdbJVnHskLnRRE8OAlHhIFdUxRej8NJbtlBn+JE2T7pIPyURgzZGsrf+eO
 CFzvEAw+yr+beUIhfoC3djlQW5GxgZxoL4Nl3wrzVMpJbLheZ2eBqExp1hSWtS2sprq3
 fQLS+RjTx4nZW6HEwN6UuhjgvFJm/vFIvW4lMq8BAejjtXSQdtcCrQB/Gjkh79joWeI0
 8a5h4WKDrz2j+vUWhPRB7g/dAvaodkb+xlIkkw2B3ShLx90edwLiQ/8PmA3Hf0+xuYSm
 EpLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788884724; x=1789489524;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=my+ZFhuaujN6LDeHb7IAmbevvxBSmQi3eP+e5gOqJh4=;
 b=p67VwKWgRSowThHwCt282bIud9DWgALJpNLc5s55AG5FSUr/eDkksQ0N/PgGHz6V0t
 Bw+d9Twu8rIwQAnXIpsmkGEhwQCE5b/cBSOdLneDwGvtAkL176r/621TtJRrPoSvwfOC
 9sn2zIokcutsB1/z0oUHFvpOXtVvkvJSeReolqEWl/CNrvMyvRqKuTIop2UOzsaYlNau
 41eySDBjicqHaWeuwXgxfovdHIXifeYvcxMJjhXlE96v6cvfW27067ZmCNELKcg3ueQ6
 NyVd7djSI7Njz9bqpdMpf0dJgSk6NWUFGz0atCkOPEp6YCo8OjOOBHpQkw5fKo6s8CL4
 KOVw==
X-Gm-Message-State: AFuF++nj68zohu1HTCldxB2CIs6wtlhFFngIJ7r4BRyUfvUHcG0cqe1u
 g6DyxDhopXDjZ/cseoJMDSCP6M4fpwAoSqJYroRPXd0MjDC4NgA/GTT+n59t8cswOIch7UaTggA
 nus2er6DLmqiZCDu4AGxgoeQ/QiEE0v1ec7SC6WSzHQ==
X-Gm-Gg: AYBFou08VJ7NGgAQZEvLZzOP5PNA+G6ft0aR2C1E9rm1M3b4ABOLAf9K6tah1Wp0BBw
 vJt8MsPYbfYGCcusqaa4w6ja+JRASs6bHnhbh6vqvcJf+X/i+ol2fKRd7jqOkOm7M2lMyglb9hp
 yWoEgIB5Zu5qgzCz1PZSPvz/dxQoHoHVNzg7e2EGyDDq0WYwJcOfatu7wKllNtURozrVOLlLJCR
 WfV59q7aTbsRgNUwG7Dh3RoaHdfU4XXoIzh0xADAStTiEz0r3Vntkfw8oktcPUMUq1ADGW6nMqb
 3vkgrjJIHw9Pu8RyHaMB7qM9Nkz8dVa1H8L0bJ0VRWFUGJkV2Trza3I1l6s687pOPWP4e31pdaW
 wKI9iMa4NbLBY9zP6RoUBuBx4VDND
X-Received: by 2002:a05:690c:e152:10b0:7ff:1a93:be35 with SMTP id
 00721157ae682-87f27057c86mr3434427b3.16.1788884723700; Tue, 08 Sep 2026
 09:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260902152044.31291-1-philmd@oss.qualcomm.com>
 <20260902152044.31291-5-philmd@oss.qualcomm.com>
In-Reply-To: <20260902152044.31291-5-philmd@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2026 17:25:12 +0100
X-Gm-Features: AcwNN1V4XIKVs54SK6sImGEmX9ljAGTNQW2lfGrMMj2QVZXtln3ANID7z7SOkSk
Message-ID: <CAFEAcA-9R6ov530pA5FV6=ECr9qj5HP7yz=O4YtyCDJDP3qc6Q@mail.gmail.com>
Subject: Re: [PATCH v3 04/11] accel/tcg: Document cpu_exec_interrupt()
 callback contract
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-riscv@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::10;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x10.google.com
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

On Wed, 2 Sept 2026 at 16:21, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> Expand docstring to clarify that @interrupt_request is a bitmask,
> the handler is called with BQL held, and document the return value
> semantics. Fix typo in arm_cpu_exec_interrupt() documentation
> (s/inrerrupt/interrupt).
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> ---
>  include/accel/tcg/cpu-ops.h | 15 ++++++++++++++-
>  target/arm/internals.h      |  2 +-
>  2 files changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
> index ded7cc700df..87850402203 100644
> --- a/include/accel/tcg/cpu-ops.h
> +++ b/include/accel/tcg/cpu-ops.h
> @@ -171,8 +171,21 @@ struct TCGCPUOps {
>  #else
>      /** @do_interrupt: Callback for interrupt handling.  */
>      void (*do_interrupt)(CPUState *cpu);
> -    /** @cpu_exec_interrupt: Callback for processing interrupts in cpu_e=
xec */
> +
> +    /**
> +     * @cpu_exec_interrupt: Callback for processing target-specific inte=
rrupts
> +     * @cpu: cpu context
> +     * @interrupt_request: Bitmask of pending interrupts
> +     *
> +     * Called from cpu_handle_interrupt() with the BQL held. Process the
> +     * pending interrupt according to the target specific @interrupt_req=
uest
> +     * masking rules.

I think we could clarify this a little to explain what to do with
multiple pending interrupts. How about:

Identify which, if any, of the possibly multiple pending interrupts
specified by @interrupt_request should be taken, using the target
architecture's rules for interrupt prioritization and masking.
If an interrupt can validly be taken, take it (by updating the
emulated CPU state for an interrupt entry).

?

(I'm trying to get across that the function sets things up
for execution of the interrupt handler as the next thing, it
doesn't cause the whole interrupt handler to run. But maybe
that's obvious enough we don't need to say so.)

> +     *
> +     * Returns: %true if an interrupt was processed and the next TB shou=
ld
> +     * be restarted, %false to continue normal execution.
> +     */
>      bool (*cpu_exec_interrupt)(CPUState *cpu, int interrupt_request);
> +
>      /** @cpu_exec_reset: Callback for reset in cpu_exec.  */
>      void (*cpu_exec_reset)(CPUState *cpu);
>      /**
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index 1775835ad50..551a6b4a872 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -1248,7 +1248,7 @@ static inline const char *aarch32_mode_name(uint32_=
t psr)
>  }
>
>  /**
> - * arm_cpu_exec_interrupt(): Implementation of the cpu_exec_inrerrupt ho=
ok.
> + * arm_cpu_exec_interrupt(): Implementation of the cpu_exec_interrupt ho=
ok.
>   */
>  bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request);
>

-- PMM

