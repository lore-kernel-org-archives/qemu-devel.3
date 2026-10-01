Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B13DCA5FA5
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 09:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCDVg-0002bT-Cw; Thu, 01 Oct 2026 05:55:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xCDVZ-0002VR-Fq
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 05:55:21 -0400
Received: from mail-yx2-x29.google.com ([2607:f8b0:4864:41::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xCDVX-00054P-Qg
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 05:55:21 -0400
Received: by mail-yx2-x29.google.com with SMTP id
 00721157ae682-8adb500dc50so85117b3.1
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 02:55:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790848518; cv=none;
 d=google.com; s=arc-20260327;
 b=DjIxOcrxOuRxc4yldZCo+p//ABXKdpjsL0atnDo/q7bN8RGyM0pXsea5H2XygU+y3r
 WwxtUZyNOaY/8xctaEo37tE/4nQ1SIaz5iSG5RzBjVv7qpBfp9I97LGly3sn8G0RmxFp
 ujuYVcaQj6gnLWV6CkM5fXbiJFJfHob7i8Sx62VA3dgY9VGyfE9M2Yh5aHKtg6zV7upf
 WFD4Fa/Iv4pTgUZJuUmbexuEcAyACJmPr9g7VDroGC4YRYwnIoUvpNnq0BtBpJajqA32
 RmoLcunPQqm6Lhlg5RLlFngXXAmOWcMbqRRk1TAOEMd2OsbNS5oImfHEnr+RQQTT0N6D
 qlzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oivvos2KYP62ep5QHwsceTgXDAlhyI54S3Dw3J5LmjU=;
 fh=4FtdHUzkuyC2Zq9xaVCFcthZJ7mi8fR7Tp+QzbKQ2zY=;
 b=gkI8lbQLb0qfmuyMs3z1/kXFaZ8H2VW+TxXp+muCVd35mvEHlEi91LbWIfCB4mASIk
 hTrbiEXbmBDagHBd8BQrgbaf4QZyWaD1jzyafK84eYckpjk4VHYYx6mQAl1PIFZQF1qc
 PHXWmdg5Deilj06V0lTjviiYIAXPbnkJMKyRJbb6cXNeeklD86dlQpDuY5JgOJQB1qY0
 IB4uKYyxGzsMflMYDUZOp6NO9ZVKC+kqeC2ehW4ukeRtNuknoeNsERk83Q6krzChoL/V
 jvUQStSKT9p+iGCpnEU/cIYFnm6FrkEi+1QEnFio63dTyYgFdXLYZFZtyDzAdTCdcU1F
 6wKw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790848518; x=1791453318; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oivvos2KYP62ep5QHwsceTgXDAlhyI54S3Dw3J5LmjU=;
 b=Vc79F7PzK7V81BPtaYkcRWYzWltQ1wDH1TdzbKud9f6TO9FN4Fpu1vIq7H/0ax+C8v
 rRQp9faB8PJ2adW4OUem7Vc4fDLpu7ePTwjdNdwo1pVRNRcgbe1vzRPy7VVz3mglBtcC
 iPEdA8pOEQ32rUv7hiWM84nUwb8GkOyJgeVocVKqf5bmLmpi8E1ju3t3DrRLA/cPS3Qu
 E0j9XCqLLOD9SzPqG0AQJoSEP9ryJD6eTdSvKwlVTKzi47r1nycaHB0RQE80JTqRVZqJ
 7kvQ/AVNkhyto/24HSn8bDoyiyC/jZbwt96KcWnu1sIUYCcZdK5fpnfUNVbIghswupgC
 POtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790848518; x=1791453318;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oivvos2KYP62ep5QHwsceTgXDAlhyI54S3Dw3J5LmjU=;
 b=TIOvyeQKi+22M4KhxGfDs4QgZnEA2iw7W8k14h+rc3ZE7/ACjINR7oojo0KDGzQQQZ
 r+LitVuXNSr+Vn8fw19vJa0oRwrBJ7J1xt+M3GjwfFdfDyqzbD+MU99q/rsT8Bvh/G83
 c7ksZZDqvaOiwX5XwWt3gbBkEZCxePQ8rYzSinJmD3yggT8CSUnjWqCBeSbPB51dx8ES
 6ju+z1Rl3PPWa3l+m4IRXTtE2s4SuhAn1MVfCH9b/HheRtr/6fB1Yb61Vjr9oYfxRLXq
 wtZK9sJlmm05Sy4f/rykHNZw4ybwKwdIRHtHFlstExFvXdYx0Vq9LfNKryT2b2B4/Miv
 sm8g==
X-Gm-Message-State: AFq9FYLpOzBigqgg6SgRJeA0YBkrvmrh87LAa5kHN9S77OEtY5bVAOhm
 rRVwi2F+HifEqbrAjYnwo9LnYIa8SnO/hN0+5e+q8SSgcUpi9uokhlLKZrNRrWmtf1C1BXqBu57
 7vOGw4VQOQxj3Dl0BIE7Z7jRIcANyJFrUS6HapwZQYZ/JU0LScrzTNp0=
X-Gm-Gg: AYBFou2820U6V3HfBpyhNQS8zHxXeBPW0utx30KLIenjXASQntuBxepZqzsFNOSpF4M
 DCC1H1orDmYHHOl0KbKtWNhDZN4idUepUh37iVekPXyhi16AYqWvpHk28IRUh7GA/Q6Z8a6Rqxn
 f6WrKzSc+nep7kJHa2rI24mdALfAP3ZojF2XzizDImF06WvCtNqRrcO3/vIr5/BgdeuxTdq77gn
 plN1RTq+asUCmv9w1+z6xE8NwWYy3RFiELp+danHyI7e2ycAD5kGZcjBbfnhNpsDYnOaGG+3nGD
 8A8jOJeS+TpX+9z4IE+qaFpHOUW9SS7SJNww/f+uS1z59emjxJtJgEha5uEDrJUW2Hd/pk9uDEb
 yx7HLzfEJOsNb7TXD8iAdc8Q6C17Ej0ypAEkMM5s=
X-Received: by 2002:a05:690c:dd3:b0:7db:ccda:a409 with SMTP id
 00721157ae682-8ac91ea3134mr22285337b3.9.1790848518386; Thu, 01 Oct 2026
 02:55:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260930174946.82195-1-philmd@oss.qualcomm.com>
 <619e0b71-d58b-44ac-adc9-7a5d8f62f716@oss.qualcomm.com>
In-Reply-To: <619e0b71-d58b-44ac-adc9-7a5d8f62f716@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Oct 2026 10:55:06 +0100
X-Gm-Features: AclHuK8JZxwVDE44dVlnry6zJNEAiE0OBqE1yxEK0oMPWwPr9UBEPNUF1tKURiU
Message-ID: <CAFEAcA814CERnJctiaHzwiUOUa=ubYKcmA_0_W26xrLpG0rvuA@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] accel/tcg: Make halt-to-exec transition explicit
 and remove cpu_exec_halt
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:41::29;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Thu, 1 Oct 2026 at 09:20, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 30/9/26 19:49, Philippe Mathieu-Daud=C3=83=C2=A9 wrote:
> > Missing review: 9
> >
> > Since v3:
> > - Rebased (s390x, x86 and some ARM patches merged)
> > - RISC-V posted separately as [1]
> > - Better describe ARM PSCI power-state update issue
>
>
> > [1] https://lore.kernel.org/qemu-devel/20260930174508.81497-1-philmd@os=
s.qualcomm.com/
>
> > Philippe Mathieu-Daud=C3=A9 (9):
> >    accel/tcg: Refactor poll-while-halted flow in cpu_exec()
> >    accel/tcg: Introduce poll_during_halt() and leaving_halt()
> >    target/arm: Split leaving-halt handling from arm_cpu_exec_halt()
> >    target/arm: Convert cpu_exec_halt() to leaving_halt()
> >    target/i386: Split APIC polling from x86_cpu_exec_halt()
> >    target/i386: Split leaving-halt handling from x86_cpu_exec_halt()
> >    target/i386: Use generic halt transition handlers
> >    accel/tcg: Remove the redundant cpu_exec_halt() hook
>
> Since Alistair queued the prerequisite patches [1], I'm directly
> queuing the reviewed patches 1-8 via accel-next tree.

No objections here.

> >    target/arm: Kick vCPU after updating PSCI power state
>
> I might repost this single one (arm specific) later when the
> rest landed in /master.

I reviewed this one (as "I think this isn't a correct change").

thanks
-- PMM

