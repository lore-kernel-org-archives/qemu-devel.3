Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3A7ACD4F3D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 00:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOlcN-0007wp-98; Sun, 17 May 2026 20:13:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOlcM-0007wV-02
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:13:58 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOlcK-0005Zs-2j
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:13:57 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-bd4d7f4fa02so301234366b.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 17:13:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779063234; cv=none;
 d=google.com; s=arc-20240605;
 b=M4Y/ddMRJRIfn6Sr+RyhLP7QDlOzZm8Qw3EipogQ2lHb4lJBqD5VMhD3lk01WZWGn6
 qAe20SkfYSfQLKYfqEP3bOlFYzOn64JDWz1i6qnJlgMlG0gPkuL4jZbGCraHP2BwWg/V
 9KaLKir5WXNQWtobDHyz++qdlsxEo1xbuznekzOk+SSQm5ssAgaMBjkjIYaV8TWsQcxd
 xS+U7x+ScrHigWYjyI73aj7wU2gKMK7fd2mHVTJ7ODLx+CWcwlG6N/6TZge75r4PsUYT
 2Va1in72RMQoS2jlFKc96aPZBsIjh35m0CNfEhYSPmdt7hOTEMsNr0uBCPkU1XBB0/QL
 VZdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=kwXk53vsyitp2oLPbSb3KrPsWW/x/V5JHE7bOlSz0z4=;
 fh=V35bOn+ojg9QwXXYxPTDi/M9cx9eHLMfSvGHHCHJCSg=;
 b=JeBNp5l3cmFrvVrDB5sHCn3GaESBeHdSy3z5MpQsuQhXkTpnb0wbeVIoVyMp4/uxGS
 mo/m2bS12xlztwdOyAtgvs3qYy+9jrLrzLd6Y/3y+wvpax9rvIxqmHpXOIhQTth57scD
 gM/hvR2VvrMPU2kwfwI5AoWvssT4IPgUNPDD58YaBHtewPYrysygtMWHsFEeBfjUdHBI
 13lfNhfMDWtn1TwDO+M2jWYbMH2AHc7uua0hwnhgk105FkT5af09QosGoo3u6vSG8DvM
 36R4HNy5d5//9e7IS+L36VopopVlJEZrIaP3+S7UyQI5VHdCTB/z8jLRK4D4TvIeQ+Ew
 3pQQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779063234; x=1779668034; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kwXk53vsyitp2oLPbSb3KrPsWW/x/V5JHE7bOlSz0z4=;
 b=jyddbzghSRaNTAKFsesVIyF+HjmKDZjsHpBeYwAfnP0If3Tu+BeJ4mYV3rEQXDp4g5
 J+hm/pOFqJi8Sl7+orhAl0HI3tsFey14IyaCUOjRsIsxsaBR8CA9iIzUzPGoSZua+5wq
 kkEIT6N9TG8RPmY7zOdotu4C/tXR0d+dLLrKAfh+rwi/U1SfiEQ6834hJSY900cLqfio
 +i/Y1HnkenvqIzReK6IaPSbkm4diUyZBz9V5cPRmjWd6dBcE7WDAduQnlNYN/Rmzzu8R
 rL+v1qchUqwW2KY5UIY+6n5nmsyDMwsiq/CXaC3AxXCqaJ5sdjILNNcAwwq8UMqfxoqm
 lCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779063234; x=1779668034;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kwXk53vsyitp2oLPbSb3KrPsWW/x/V5JHE7bOlSz0z4=;
 b=G86J+Rwn2OaZyafjNwUwNpk9ozB0lb5nInpLR45ywN+7f+EUPFcDmgWxZve6uCYvqf
 50lR/yp6wEO3f/sMoQ1nivJEi/o0s0b7AUn+ecE3jLOxgTRI8IpQfAZspnlxxbVhuEOl
 gyrpRPI71hPzj3wa2I6QBRX3U7/0ecij7bHJ5rXDMfI5BQIzOJjLc98mzAfAbXqSzkTG
 WZNo2Ap3fnBwkPr9wpdbzGrvwG/mI3EDaDg4GpYXutoEAcxceQ87xKPt3PZmnllDBjcm
 G4NQF69KclzYPT2PC7zMuQVt2778s9TuRIH7QHsPU7HziU/nXDFnUz0Axg94bZW3izbZ
 GRPw==
X-Gm-Message-State: AOJu0YzhiE4GiHIzFZ5Dc0gA0nWI/eCSVMJ9u8vLU67gmaINlP5jkRL3
 cnYJNTwj0/dTe/4t9p9QtyrMfHbct+CLkdia9hmbe7mMARQsOycxq6MJy22eBgoDL4tmhQoti0g
 NMa8jzEY4vnvc6Fr7t0huK+IPIuW472o=
X-Gm-Gg: Acq92OFXru/N0M5CpI82g28+tonvm/fsrcLmyzDR1zT+vfOs7CE3ulfz5jherwANTXG
 qV3uISI3RlyHeLnk3gjXQ+EXwLQzPP/fvmpi4TalUKo0ZnYY6lSFZa5MQoSeEFwaegeupOB6XRu
 6MFFIT3JwEExdvP6vb6ocZQmPSH9rdUdipJwSFqml0LDfRlWZr0+KUIXbOeQByx7vwJJQK8SEFN
 8NNZN4DbQDAxb05hVSvluzAdlguQbP8wIoOH+oLWEnkD3r9ErQSLij2HU0MdtCjasZ+BG4JOnR0
 lcCk4Oakt68YobJN+FhIg/JFoyEo9/9eUmuRXEByQ0Fzkugf
X-Received: by 2002:a17:906:eec4:b0:bd5:17f9:e987 with SMTP id
 a640c23a62f3a-bd517f9eb24mr518177066b.46.1779063234101; Sun, 17 May 2026
 17:13:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260427051507.727280-1-314abh@gmail.com>
 <20260427051507.727280-2-314abh@gmail.com>
In-Reply-To: <20260427051507.727280-2-314abh@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2026 10:13:27 +1000
X-Gm-Features: AVHnY4KgWu96upN869UPVEWPJ8NGIHLHkFsNcIa7IRfwGndml71YggsiHK_H6aQ
Message-ID: <CAKmqyKPhQPHYHkHP0F3UBp9-yFiP9qRmD8=bbW6Z9585B-+C_A@mail.gmail.com>
Subject: Re: [PATCH 1/1] target/riscv: Fix medeleg[11] read-only zero bit for
 M-mode ECALL
To: Abhigyan Kumar <314abh@gmail.com>
Cc: qemu-devel@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com, 
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com, 
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, Apr 27, 2026 at 10:50=E2=80=AFPM Abhigyan Kumar <314abh@gmail.com> =
wrote:
>
> RISC-V Privileged Specification 3.1.8 (Machine Trap Delegation Registers
> (medeleg and mideleg)) mentions:
>
> "For exceptions that cannot occur in less privileged modes, the
> corresponding medeleg bits should be read-only zero. In particular,
> medeleg[11] is read-only zero."
>
> QEMU incorrectly included RISCV_EXCP_M_ECALL in DELEGABLE_EXCPS. It
> allowed the 11th bit to be written and read as set. Fixed by removing it
> from the DELEGABLE_EXCPS mask, adhering to the specification.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3438
> Signed-off-by: Abhigyan Kumar <314abh@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index a75281539..c9bf73dd7 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1775,6 +1775,10 @@ static const uint64_t vs_delegable_ints =3D
>      (VS_MODE_INTERRUPTS | LOCAL_INTERRUPTS) & ~MIP_LCOFIP;
>  static const uint64_t all_ints =3D M_MODE_INTERRUPTS | S_MODE_INTERRUPTS=
 |
>                                       HS_MODE_INTERRUPTS | LOCAL_INTERRUP=
TS;
> +/*
> + * As per RSIC-V Privileged Spec Section 3.1.8, M-mode ecall should be a
> + * read-only zero. Therefore, medeleg[11] is set to zero below.
> + */
>  #define DELEGABLE_EXCPS ((1ULL << (RISCV_EXCP_INST_ADDR_MIS)) | \
>                           (1ULL << (RISCV_EXCP_INST_ACCESS_FAULT)) | \
>                           (1ULL << (RISCV_EXCP_ILLEGAL_INST)) | \
> @@ -1786,7 +1790,6 @@ static const uint64_t all_ints =3D M_MODE_INTERRUPT=
S | S_MODE_INTERRUPTS |
>                           (1ULL << (RISCV_EXCP_U_ECALL)) | \
>                           (1ULL << (RISCV_EXCP_S_ECALL)) | \
>                           (1ULL << (RISCV_EXCP_VS_ECALL)) | \
> -                         (1ULL << (RISCV_EXCP_M_ECALL)) | \
>                           (1ULL << (RISCV_EXCP_INST_PAGE_FAULT)) | \
>                           (1ULL << (RISCV_EXCP_LOAD_PAGE_FAULT)) | \
>                           (1ULL << (RISCV_EXCP_STORE_PAGE_FAULT)) | \
> --
> 2.54.0
>
>

