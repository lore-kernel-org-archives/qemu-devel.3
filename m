Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 155B3CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 04:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPCHn-0004xU-JC; Tue, 19 May 2026 00:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPCHk-0004wp-9i
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:42:28 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPCHi-0004hV-Pb
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:42:28 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-bd21ffaca79so627966866b.0
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 21:42:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779165745; cv=none;
 d=google.com; s=arc-20240605;
 b=QHvWTAZeUTKFkQAb1956QKC/fsPNmBtc4MjuqRfPzwBhoHF/bIV8fhAkuDAc/ifgB1
 MUfvScKd1VsGMwemw/wDTyYsHPxDFd2GQZZI4AmMtIMG4HaNaIQoF06L6CFo7CQW4icA
 br1l7WT7iW6w9MFvlDQvEeaH7Zj40/WMDqjk7sOV0mOriihwup6EF7oBkIBDPhyPGirn
 +nvUFRXfAMwapW6g0HW8qTYUn58wzBqZIm89IVpPpRqLfUsfrky2Z3QKBswzPi/xUsTg
 yYBV7muBK9EzsUWP2g+RyKiNb/EhL8mL6cDmT4+957jbGMTh3HT2wo9naA25lsdqLndx
 9PQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=y/Xm8uZPu/o/iClEawzGN+hY7qYMF79Y0M0iVf6VRcM=;
 fh=rfkyepp3rkVCuP1zq2/fANJ/AIlST33BvR3R0V4OhSA=;
 b=C4gqyEV3HzZ1H0/58wLas3gHFxebmIsvHx/BeKOjgCrDAkeXHF7UnuN+6i39sr0KBE
 +zyKUgpuMIMPw6kgk3ZXHf439l7ocdFjQfnWyCryx6r32jaoh7q4OnLLncWGlVDYhVqi
 8nV/C4C9Vvmp6br9GU+BDzEAjtPPrmlRzMJ5TNJkkEHE//x+75lF9RRXDW07bcFZFCDU
 q2DMXiV2jlMpo4b4mPbwCrhXabC7lvXVcbBvbAVpEgcmFHZkHwcd0/du9SEjVpITACLF
 y5jbCW4az3FmK39MXFB95V7gUjEfigZkZuJBigeUgA1NjlmnzZdbbNzs2l5GKFbOO7Eo
 pqBQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779165745; x=1779770545; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y/Xm8uZPu/o/iClEawzGN+hY7qYMF79Y0M0iVf6VRcM=;
 b=a76/kBnWxW68agQNrfikYkd9DQDaS3uZ4uFU2oK0BJPwc/3CrazNZOuVNX/3V4orgz
 9vfh6BfUszl6JghhNG70Ae4ikX4Nz/SSk8ydDf2dNj2Yz40ZamTL3bU/cFe+QnYz2po6
 MIpUSeMfrkxMMsfok4ONXWMVAkeVR+BC1HTOLvTQwfk/2NnaYIiGR8tUmAPP3nFf2wJV
 HjRNpgJiXtGojJs4YORScEAhMOXxYxuwY4Kz1JlqJ8iebh6dM+hlRI9AG9OBNSJMHAUI
 kSvNsQMl0vChYJSs7WspqqZxB4P4U5DsrnYUnFfduobYsFr6V13i/3ucS4t2yPs06nRi
 M8QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779165745; x=1779770545;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=y/Xm8uZPu/o/iClEawzGN+hY7qYMF79Y0M0iVf6VRcM=;
 b=B1h1MN6sJElArDoe0QGs+Rh684ilrPZZAz77MC7icB6HKXvSPLj1VVUoVS8q2cU/kQ
 xlJhQkZHkf8dWj7agys8HVl0Ia5/MuvIB0WloEMqU5cA4S8A+flcm1bvh7FjtYcLmMtZ
 tZxUAv3D90JLtrwUPkun7rcS7v6qcOEfyV0OnBHoHI+ybAzrEXlLyjH3lR8EL8Bn8EOs
 CE1anBa2K/A7Po/9MFnS7zP0jtdPATSKr8an7PcKwhT58XlOSNuQU/8w72y6M/5m6ucb
 2RV79hYfC7y0nKwrJvV4+i2+/SR4D6VSpoRQLsJlYhkGEravOYXEisloAALxmNl6QtEV
 vJIw==
X-Gm-Message-State: AOJu0YyJX4se1+asYGu4GcQCvF3+iWjxV8bGJAMrIA2toxFRtPADHAtQ
 0Ljmpa5zCA6rGrVmFcLVOezXAtb4RW+oAx07VnQTV7yKxfgRB+AJtO02QBcqhQ5dxBtxGXF/QbK
 yWbGgKK8XgDCvAIzup3Lu5FLPEMqrfEs=
X-Gm-Gg: Acq92OEOuKaEXc8UsyujUSjhRk2UCZD+l/FDxglGyU2HQz6lqHz7uu+iLzDL38+jVCQ
 Jl4IwS/Dn4yOMngVixvyVWC5B/f7ZZp/IR7h2naXspXgH2HENIq4+YhcpoCisyAaV082zAdbAgu
 7k/FQiUBxSptmk0QTYqu2Uwylqaxn5aYSLmrnuAJDlinBfPdvNsP3b6qYYs+1OgbyzIBDXFrIi1
 D+Zer4nVbDilvejQt/6o45bSfX8TMN6fOKf6I0EToDBx1OSTvft3t+ygoxLM5Nvt1jwFBbnhQgB
 vaLQsGI4knU7NTMhHtHq2wwwFQI/FXY2hHqL7ZGI4FdtpLZS
X-Received: by 2002:a17:907:d0b:b0:bd1:77c4:acc0 with SMTP id
 a640c23a62f3a-bd51550075amr906071866b.19.1779165744948; Mon, 18 May 2026
 21:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260519043352.3685866-1-stephensportia@gmail.com>
In-Reply-To: <20260519043352.3685866-1-stephensportia@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 May 2026 14:41:58 +1000
X-Gm-Features: AVHnY4IJLyucY2aXTCbTNGgV6Qrye16iEFIOc5Jdzb-aMyh8oX7eOYcaeVimcUQ
Message-ID: <CAKmqyKOnqq31u8tSt5FN1Y+2_szNvCeMC=kUWuVi1pDzOooKuw@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv: Make hpmcounterh return the upper 32-bits
To: stephensportia@gmail.com
Cc: qemu-devel@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com, 
 liwei1518@gmail.com, chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-stable@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62f.google.com
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

On Tue, May 19, 2026 at 2:35=E2=80=AFPM <stephensportia@gmail.com> wrote:
>
> From: Portia Stephens <portias@oss.tenstorrent.com>
>
> The counter value was not being bitshifted for a hpmcounterh read
> resulting in hpmcounterh returning the bottom 32-bits.
>
> Fixes:  cfc96df65e01 ("target/riscv: Remove upper_half from riscv_pmu_ctr=
_get_fixed_counters_val")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3498
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Portia Stephens <portias@oss.tenstorrent.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/csr.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index cfd076b368..c522533807 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1389,8 +1389,9 @@ RISCVException riscv_pmu_read_ctr(CPURISCVState *en=
v, target_ulong *val,
>       */
>      if (riscv_pmu_ctr_monitor_cycles(env, ctr_idx) ||
>          riscv_pmu_ctr_monitor_instructions(env, ctr_idx)) {
> -        *val =3D riscv_pmu_ctr_get_fixed_counters_val(env, ctr_idx) -
> -                                                    ctr_prev + ctr_val;
> +        uint64_t cntr =3D riscv_pmu_ctr_get_fixed_counters_val(env, ctr_=
idx) -
> +                                                             ctr_prev + =
ctr_val;
> +        *val =3D extract64(cntr, start, length);
>      } else {
>          *val =3D ctr_val;
>      }
> --
> 2.43.0
>
>

