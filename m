Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77098108B91E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 01:37:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5DA8-0002zY-Pv; Tue, 24 Mar 2026 21:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5DA7-0002yx-6I
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 21:35:59 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w5DA5-0007lD-AG
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 21:35:58 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-64ad9fabd08so6371976d50.2
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 18:35:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774402555; cv=none;
 d=google.com; s=arc-20240605;
 b=jBhT7ECYAUxNfW6ZhBceR7HdRzucRUlfzR4G1mTjxJC0kHF5fDBcMcl1K9+c3OTmDM
 I1tnOTW1tf0xGeqjw8bpdS1jMgGQr/MNwFWbijcs4hDSBzudY4L/H1ABarmlZddVd2e6
 se6tUf3EnKt18Ff0u325U3D/0ebnwt9Nzrc7uJsRtCDn3Uy0ARiCrkKNo9ZpLBYqIQD3
 EHw0oFOV1zSXMSDWvsLvNOVk9K+4k2yz+f54K4ZJ8VOsht9VYFSPAY7G+8nnsxDpVBd+
 5X6m3H8Ows8Tvt6h1voiww0DwMJdmtElPQgExbigkBtsS5u6fpOaXl63AFHLsyeAKNqQ
 z0wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=hVmw7nS6Awwi0HKrdCWhAqC/gnRZR++BvA55UgAXgdc=;
 fh=7k/U97Ta3TLJTR+yXa8ZC+Gk41Mo4g4FOxMRS9u3w/k=;
 b=ZsHSoe+jXzu0/6Lxs7YIzd9G1UPjXdcdntOOY7EMTQuB8cZnz8wJBf/bBmJkufUdkG
 R9AntexOTkN+t7WLwtkRkjvXy7k922GVlO8J4TECOaNYUgahFlZelLn8JdXW7jNxBJ84
 v0ESemoD6jNkGgpjebXoDgrGkuYMY+LNmvPLEHLKJLDspge7K3BkQvcjSdfgKMi5RdXw
 I+riujyJkZZR0GroLAfXGajv4GFXWl/CddNmRCH7FiVI78oT4V/QW/3ZXe0O+ZJtcf/I
 i8ytmC8YYlmNa2kAYPxTyYNcqEFoIB0EvsFGOxse1F5xoQIc0W8ViG4McsWaqr5aMSYs
 lonw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774402555; x=1775007355; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hVmw7nS6Awwi0HKrdCWhAqC/gnRZR++BvA55UgAXgdc=;
 b=bylfikd5qCB4hOZ+x5b/965oZxJsiVqO79FXph40/xMNEl6N6sNzGREYrTkr5adLNS
 oLQxcr8XQZgCtH+uCFqYoDMZ5YYgXMap4Qrq5JiFiW53of5Bmv0t9uAVXYDjRlboeGLI
 U8gH2bwCJD42UV+DZPn9B+pKEOric24S/KfrgdMgFuCMFOdTPTDEMn5U3X9K39we4pkE
 PCJouLMPZ7eEJEM27hx5Ba5XsDXraa+GGi4mCrztsITrLzSKm7DLBQ3ehBqZBl51qhnu
 mlJaoCeCKQN3DMclrQ98EbUmnqeUwTg2e6hUCgZGB8HvttUmayqumV3jBOrFYowoHc2c
 jgaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774402555; x=1775007355;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hVmw7nS6Awwi0HKrdCWhAqC/gnRZR++BvA55UgAXgdc=;
 b=j6d359tbybcvutEOImqDIXuc9/+ZeNcwtngw3+dGGCqbuYCeNYcKTPFnuFnCbTgJVw
 iTkfmkbA2M6nXGtZInwCRqEmyzQ/JonZiolIiqY1VPtmrMuRhiG8vN3fhXMHdizWpY19
 y/JvlrWSE+FNRmsjoyl2kIWc6wwkXAKLWbO0/JQTafkfEpfNKcPA5qEG7aM3CjIuO9hz
 XpOpiDcVKoOGnvt5C4Qe4LkGsUvboMUYFPaPGr+hVnDIsBM9PnF7qEhxmPtiRjgtliba
 gFMwT01ymlSYuK3cctkMlnuw3j3Skivmkdm1N1umElz4nEAD4RjcGHZGFOzAT1s2TagJ
 MZFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUNGNMM3NE45XEsBpm0Gruh0yw/XD19UYDQhJkEJcLGVw4zRFBFc0eLRusB+BRT4nFObUCal3VIvS6f@nongnu.org
X-Gm-Message-State: AOJu0YxBb9x6G2RrwpqX5j4DGRy5AkSQH/Ij1+DkB1AEXwWDqWKy57gD
 Mfk+S1r2Ic4XXaDnXNNqqgFdnSvLosnTVOrQBHF1mOy6QL6/FAEDqIaKgXFmGXi/PWYhg9dn/Lb
 Mq/iZz0/BDUQg0U5AOWM7mIq7nex1Bdo=
X-Gm-Gg: ATEYQzyhLo4u3mFrmO0d8SYWayx+OoBDo6irDh0ZehWqVlwWJSmiBkBv/hLAW6ssQNh
 iKrMlVjCaJBi3nu2qz5QDA0nVy5WuTY+6dq1236xTKtsM9oFdxEmuwON5q2lKk+SRWXpV1A07GZ
 r2hH+sxYtU3EoaKMhsE4WzcpHcO0entNnykqGAv2HkqwroPFIQ7R0Mw202sW5cKWIXbxKoqFnf7
 Wh9b0XSZOlYxr5pKDcJRcEOo6QeHUDB2Ry9/1mL2hM+vWzBYYg2qbICExycE+32FFjMGiUrcigh
 A0HXNkErThUhubkLGSFIIqlc2U3QRIv8iTwRJw==
X-Received: by 2002:a05:690e:b83:b0:63f:b444:da92 with SMTP id
 956f58d0204a3-64ee60acee2mr1582948d50.31.1774402555032; Tue, 24 Mar 2026
 18:35:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260321144554.606417-1-npiggin@gmail.com>
 <20260321144554.606417-2-npiggin@gmail.com>
In-Reply-To: <20260321144554.606417-2-npiggin@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 25 Mar 2026 11:35:27 +1000
X-Gm-Features: AaiRm51VUnGiafeER45DKPozTjuJ70UgEDedOjsaatBgPHHWvmrlvfbhJSz13Vo
Message-ID: <CAKmqyKNbjvZBB0AL_7cLcfE87fX=xK5LmhgqvpNi43SsGr2bmg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] target/riscv: Fix IALIGN check in misa write
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-riscv@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org, 
 Joel Stanley <joel@jms.id.au>, Nicholas Joaquin <njoaquin@tenstorrent.com>, 
 Ganesh Valliappan <gvalliappan@tenstorrent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=alistair23@gmail.com; helo=mail-yx1-xb135.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Sun, Mar 22, 2026 at 12:47=E2=80=AFAM Nicholas Piggin <npiggin@gmail.com=
> wrote:
>
> The instruction alignment check for the C extension was inverted.
> The new value should be checked for C bit clear (thus increasing
> IALIGN). If IALIGN is incompatible, then the write to misa should
> be suppressed, not just ignoring the update to the C bit.
>
> From the ISA:
>
>   Writing misa may increase IALIGN, e.g., by disabling the "C"
>   extension. If an instruction that would write misa increases IALIGN,
>   and the subsequent instruction=E2=80=99s address is not IALIGN-bit alig=
ned,
>   the write to misa is suppressed, leaving misa unchanged.
>
> This was found with a verification test generator based on RiESCUE.
>
> Reported-by: Nicholas Joaquin <njoaquin@tenstorrent.com>
> Reported-by: Ganesh Valliappan <gvalliappan@tenstorrent.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c                        | 16 ++++-
>  tests/tcg/riscv64/Makefile.softmmu-target |  5 ++
>  tests/tcg/riscv64/misa-ialign.S           | 88 +++++++++++++++++++++++
>  3 files changed, 106 insertions(+), 3 deletions(-)
>  create mode 100644 tests/tcg/riscv64/misa-ialign.S
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 5064483917..91421a2dd8 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2129,9 +2129,19 @@ static RISCVException write_misa(CPURISCVState *en=
v, int csrno,
>      /* Mask extensions that are not supported by this hart */
>      val &=3D env->misa_ext_mask;
>
> -    /* Suppress 'C' if next instruction is not aligned. */
> -    if ((val & RVC) && (get_next_pc(env, ra) & 3) !=3D 0) {
> -        val &=3D ~RVC;
> +    /*
> +     * misa writes that increase IALIGN beyond alignment of the next
> +     * instruction cause the write to misa to be suppressed. Clearing
> +     * "C" extension increases IALIGN.
> +     */
> +    if (!(val & RVC) && (get_next_pc(env, ra) & 3) !=3D 0) {
> +        /*
> +         * If the next instruction is unaligned mod 4 then "C" must be
> +         * set or this instruction could not be executing, so we know
> +         * this is is clearing "C" (and not just keeping it clear).
> +         */
> +        g_assert(env->misa_ext & RVC);
> +        return RISCV_EXCP_NONE;
>      }
>
>      /* Disable RVG if any of its dependencies are disabled */
> diff --git a/tests/tcg/riscv64/Makefile.softmmu-target b/tests/tcg/riscv6=
4/Makefile.softmmu-target
> index eb1ce6504a..f176f87ed0 100644
> --- a/tests/tcg/riscv64/Makefile.softmmu-target
> +++ b/tests/tcg/riscv64/Makefile.softmmu-target
> @@ -36,5 +36,10 @@ run-plugin-interruptedmemory: interruptedmemory
>           $(QEMU) -plugin ../plugins/libdiscons.so -d plugin -D $<.pout \
>           $(QEMU_OPTS)$<)
>
> +EXTRA_RUNS +=3D run-misa-ialign
> +run-misa-ialign: QEMU_OPTS :=3D -cpu rv64,c=3Dtrue,v=3Dtrue,x-misa-w=3Do=
n $(QEMU_OPTS)
> +run-misa-ialign: misa-ialign
> +       $(call run-test, $<, $(QEMU) $(QEMU_OPTS)$<)
> +
>  # We don't currently support the multiarch system tests
>  undefine MULTIARCH_TESTS
> diff --git a/tests/tcg/riscv64/misa-ialign.S b/tests/tcg/riscv64/misa-ial=
ign.S
> new file mode 100644
> index 0000000000..7f1eb30023
> --- /dev/null
> +++ b/tests/tcg/riscv64/misa-ialign.S
> @@ -0,0 +1,88 @@
> +/*
> + * Test for MISA changing C and related IALIGN alignment cases
> + *
> + * This test verifies that the "C" extension can be cleared and set in M=
ISA,
> + * that a branch to 2-byte aligned instructions can be executed when "C"=
 is
> + * enabled, and that a write to MISA which would increase IALIGN and cau=
se
> + * the next instruction to be unaligned is ignored.
> + *
> + * SPDX-License-Identifier: GPL-2.0-or-later
> + */
> +
> +#define RVC (1 << ('C'-'A'))
> +#define RVV (1 << ('V'-'A'))
> +
> +.option norvc
> +       .text
> +       .global _start
> +_start:
> +       lla     t0, trap
> +       csrw    mtvec, t0
> +
> +       csrr    t0, misa
> +       li      t1, RVC
> +       not     t1, t1
> +       and     t0, t0, t1
> +       csrw    misa, t0
> +       csrr    t1, misa
> +       li      a0, 2 # fail code
> +       bne     t0, t1, _exit # Could not clear RVC in MISA
> +
> +       li      t1, RVC
> +       or      t0, t0, t1
> +       csrw    misa, t0
> +       csrr    t1, misa
> +       li      a0, 3 # fail code
> +       bne     t0, t1, _exit # Could not set RVC in MISA
> +
> +       j       unalign
> +. =3D . + 2
> +unalign:
> +
> +       li      t1, RVC
> +       not     t1, t1
> +       and     t0, t0, t1
> +       csrw    misa, t0
> +       csrr    t1, misa
> +       li      a0, 4 # fail code
> +       beq     t0, t1, _exit # Was able to clear RVC in MISA
> +
> +       li      t0, (RVC|RVV)
> +       not     t0, t0
> +       and     t0, t0, t1
> +       csrw    misa, t0
> +       csrr    t0, misa
> +       li      a0, 5 # fail code
> +       bne     t0, t1, _exit # MISA write was not ignored (RVV was clear=
ed)
> +
> +       j       realign
> +. =3D . + 2
> +realign:
> +
> +       # Success!
> +       li      a0, 0
> +       j       _exit
> +
> +trap:
> +       # Any trap is a fail code 1
> +       li      a0, 1
> +
> +# Exit code in a0
> +_exit:
> +       lla     a1, semiargs
> +       li      t0, 0x20026     # ADP_Stopped_ApplicationExit
> +       sd      t0, 0(a1)
> +       sd      a0, 8(a1)
> +       li      a0, 0x20        # TARGET_SYS_EXIT_EXTENDED
> +
> +       # Semihosting call sequence
> +       .balign 16
> +       slli    zero, zero, 0x1f
> +       ebreak
> +       srai    zero, zero, 0x7
> +       j       .
> +
> +       .data
> +       .balign 16
> +semiargs:
> +       .space  16
> --
> 2.51.0
>
>

