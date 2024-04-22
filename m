Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD1F1C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 10:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryrBo-0007sE-LF; Mon, 22 Apr 2024 06:46:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ryrBm-0007qL-VU
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 06:46:23 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ryrBk-0007y8-UM
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 06:46:22 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-571e3f40e31so1642300a12.2
 for <qemu-devel@nongnu.org>; Mon, 22 Apr 2024 03:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713782779; x=1714387579; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aGCfaOEUfbf7RSRB7kCEk2foOuGP6WwLRpCDdNjgc4A=;
 b=JBnX340UPjFLnXjOht8DkOKXtEx2x4XZj1eT36kdG8wV8eGeQHLhyadpJYTgAVlCfn
 32InxZ1T81TesXDeOchdaSYgltO0U7nh3lz9jjsz+2j5Dz5mZGhOn+4vtikyCAg+sWNO
 JM+Gf/FAaYx8fUhiOCGhm2Q1qy4c7MVHWuzhDMBcA0Xdi0YvqG7GD/G+yarDuFsIYhXO
 iZ+iwLkLJgZkrZ2DPoj21ujqcElDGN8RjIVNf5M25uk5jwKSES9qyyyUXz7/AftxpWVk
 SZhJ6PTHfTOIWJwWWKwkiaTNiQHNaObsg+KAjhAfUmGmm3GkqD6L865g/SYMeFMSws8l
 zbWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713782779; x=1714387579;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aGCfaOEUfbf7RSRB7kCEk2foOuGP6WwLRpCDdNjgc4A=;
 b=s/oECqlrJlt0cmFywF0J9fmnNwCmeyxkCRVKmO0WPcPi0MJpnHWWvajUKYqaRu7Otm
 8jl5ewDEsx3qOU9+muL9j3wj3Fwc5YKBtFc2+Np8y1veWFVkH0nb+NJ2M2RPZcTYxMOo
 pGtW4OgMjL1Mz4NkwoFSjvLl8OcDz9k2GUoqolj4ccNAx/I9bIDKjr9kqB6FMStClUvx
 RC5Z+1RMdbBjnNRWdU2Z8p6eXGXFDkyxRmyY9MvU1vwdwRGUrW8ymZ3fgXtjguQm+d5K
 qS3RSIIXBV9hOPk7V01x/TGKxvbUXpqPYaQydMJUOO3BiQ/EjKjkfvtHCt0AKhdrsrX6
 +8QA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVFqWfBWhesxVvcMOuN8sk1mr3sGS+tSg1bptFcsDnSrCq0/UIMy161vqzttovGSY5eyxwzZNEPz6we1i0tevvm4aw3Xc=
X-Gm-Message-State: AOJu0Yyirk0lhRiFuliK0N4VOUSjPxE+bjNssI0xHic3hOuHtBgyfzOU
 bzDoI3gYRnRiNJp4YCd6Is/Q+eZRfw18mwvDwU6bLU3XVp4jqYeYB/OutiOhNlp26pcwlulbVjI
 G/u1apg4ef8oXDA+dChzPQjxl2tk1ICVvN3uuZQ==
X-Google-Smtp-Source: AGHT+IFfRJgRUDeINJWgcZk7jSUPQv8ZUHszGL3y92Xd6aHy/514UlDWKq+yNOpY/bgFU3yCuGReTugLD2xFfsBPf00=
X-Received: by 2002:a50:cd9d:0:b0:56e:7a8:5db8 with SMTP id
 p29-20020a50cd9d000000b0056e07a85db8mr7200949edi.35.1713782778860; Mon, 22
 Apr 2024 03:46:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240419183135.12276-1-dorjoychy111@gmail.com>
 <f397f267-06d9-46c1-8acc-1c9ebf9c3773@linaro.org>
In-Reply-To: <f397f267-06d9-46c1-8acc-1c9ebf9c3773@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 22 Apr 2024 11:46:07 +0100
Message-ID: <CAFEAcA8i_wU+RSRk+D1L8YKy72zHz4YFV20r2Z7m+3ARfzb51w@mail.gmail.com>
Subject: Re: [PATCH] target/arm: fix MPIDR value for ARM CPUs with SMT
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Sun, 21 Apr 2024 at 06:40, Richard Henderson
<richard.henderson@linaro.org> wrote:
> > --- a/target/arm/cpu.c
> > +++ b/target/arm/cpu.c
> > @@ -1314,8 +1314,18 @@ static void arm_cpu_dump_state(CPUState *cs, FILE *f, int flags)
> >       }
> >   }
> >
> > -uint64_t arm_build_mp_affinity(int idx, uint8_t clustersz)
> > +uint64_t arm_build_mp_affinity(ARMCPU *cpu, int idx, uint8_t clustersz)
> >   {
> > +    if (cpu->has_smt) {
> > +        /*
> > +         * Right now, the ARM CPUs with SMT supported by QEMU only have
> > +         * one thread per core. So Aff0 is always 0.
> > +         */
>
> Well, this isn't true.
>
>      -smp [[cpus=]n][,maxcpus=maxcpus][,drawers=drawers][,books=books][,sockets=sockets]
>                     [,dies=dies][,clusters=clusters][,cores=cores][,threads=threads]
>
> I would expect all of Aff[0-3] to be settable with the proper topology parameters.

As I understand it the MPIDR value is more or less independent
of the topology information as presented to the guest OS.
The options to the -smp command set the firmware topology
information, which doesn't/shouldn't affect the reported
MPIDR values, and in particular shouldn't change whether
the CPU selected has the MT bit set or not.

For Arm's CPUs they fall into two categories:
 * older ones don't set MT in their MPIDR, and the Aff0
   field is effectively the CPU number
 * newer ones do set MT in their MPIDR, but don't have
   SMT, so their Aff0 is always 0 and their Aff1
   is the CPU number

Of all the CPUs we model, none of them are the
architecturally-permitted "MT is set, CPU implements
actual SMT, Aff0 indicates the thread in the CPU" type.

For TCG all the topology info is pretty irrelevant anyway:
if the user wants to tell the guest OS that it should
do NUMA partitioning (assuming threads or otherwise),
that's up to them.

thanks
-- PMM

