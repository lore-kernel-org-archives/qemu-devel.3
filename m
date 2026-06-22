Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE334CD98E4
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 03:11:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbV4C-0007sA-5E; Sun, 21 Jun 2026 23:11:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbV44-0007r5-7K
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 23:11:13 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbV42-0000RR-2Y
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 23:11:11 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-696bf0e7c9cso5985638a12.1
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2026 20:11:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782097868; cv=none;
 d=google.com; s=arc-20240605;
 b=aWqAuEfqIzYkkNHIQUt++h6MJJvtiOQuAdR6IF7Vx7zofFl1HH3oPM+O/cuOeVLIss
 zgFtn1nckSP/j0XNB+UKGLlD2JOLKCpagMrQ8STF4PUB3tPcaA8RxxRyMJC73LKIwKBg
 Fe3aUZefdwBez2q+iGa7pLlVjGmizTMGT5QcsRiawnCn93i+hJtnaUNKqn6WaCboYZoS
 R924prCC00YE0Wu6xXRhoWHi+OIsevUt+8PRXKva5/kepvR06fBW7ZDKZ3gIad3qiota
 OLpVkVfQiLEnzRSN+92jqKDqtIzDh89moQWJywJ0cm1m/WaZ0l0wZd6hQmUmAOhFcu8p
 5YdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5251lJHZna8xSeEEf+SDbVoy83ed2bMtD6Z/OC+BWA4=;
 fh=SglfmchVYcdfczLSoCSBefjtWZMKziUtZF1Tfwx67Pw=;
 b=C8drNxIerrG1bfAyVk772P9kO4t2+VLQJY1nh7N/iNuzLAUg/71Y9TSvk+2qldds2A
 ew5tKTrgwMcJsG63gym8tzHnKPSewtPzwOlBJwmkfwlj8FLyRRNrrTyeM1eO2s1PjDjE
 JD5SuL33O1V0F0jK7xxBR5R0TwKQfriYEvTYmNQqo7UosgoBaFS7zzvZ+jpx3VlztvrR
 1sd8LvsmC9p1tuKJY3a36YGcmQdVKRLggX3MkPIAxmBiw7mN3eb92165H9JDAwjHPpzB
 YJFwKXd0yqA6tJJ5Jb1Qu+dzv63K+6ssEzdqQNfuT3zTbuMOlzLx07gIYYRFtjAmU5dy
 38TQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782097868; x=1782702668; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5251lJHZna8xSeEEf+SDbVoy83ed2bMtD6Z/OC+BWA4=;
 b=R9Wx0Qs4yYQ3om/bjHfjGWDONfC6TWFhaMw/DU+IeTIgJgVco4wQ/vYlXhIDKR71e2
 kgbxMalBY0DsLsnIkMxG1qoE3XnGzUs9pdkcWfPhCjmq+BHjLSEUvo2vhl7giwoRxDgg
 vMj7tHsv/PFmMCgLuJbMZ/fSmGiZ6CWTy/GLVZcEveZdNvAfZJRcX4+u+EHcL0PVzHw3
 EXCdpiyNXlObdY4dDQPoxyUtvrPs+bx9NlpYpV+Z8wLISBDVNK3KdyUv9KUbVQs/kg9g
 ezEZ8RmM/QRpLuvD0nW3FzDx+m7S4CWRLYaMxyKeqj/gjGiLaQ9ucE0FWmDj+6VdYl+b
 j94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782097868; x=1782702668;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5251lJHZna8xSeEEf+SDbVoy83ed2bMtD6Z/OC+BWA4=;
 b=UlICaKVFrCyuwf2QTKnqfvhV0oZOk2yofLn8zVEMKd4BXjr0gTrpse7b8HixM1Pn0E
 8t2HzVPo2WGs5H+/0uC5LfLN1dedTrQnBlIFhorQyiravmNQdV42H7X+XnD+q8N8wW1I
 dqYIVlaJCjc8xXZVUwjr957C8oU6ihkgPg6ivb64DsNpeNwxwCGOw8ZoJ4wzo/6NWxVU
 0gSJ+ADsNoY9aO28TUGSiWE4K8vZTAfClj+NeHUd3x7U3VikRj+JJEBn9pVoLC6IJSZr
 w5MdbASBRTFWiWgQRRY1NLDxQTUGLyouPSotsjzrqHMeE7vdWma3uqgGVlEN+PMuXpfG
 J3ug==
X-Gm-Message-State: AOJu0Yy3V3Db29mmvBxe0Exp2taBIOP5dBUm0FGQ7mlX/lbXy4biI9Qi
 L7paxXkCSkusXP7eZvUMYjWW3kfr0/Qb4FsBUW+DWZUCMtB+XXTEog3GpEhrCVcfkbAIcDEmLrY
 tI1hq2603dIO4skO3dOix52KLDKqbFh4=
X-Gm-Gg: AfdE7cnVNhd9zSeVVA23ar61KsiEU9EP53E0z6qcXNO9HQOubTLmHQXfuMAE7aQmLIG
 xkTTMwb9rwYF92/R9Q2lBvo2or78CoYsZpqJrY49XjMO7hQZTvAgk2SatSp5vSj7paEqh8vQ2WZ
 GB9MPSC9jIHLo8Wcw12/s4R56Cs+8nYHuBbGJj8Hoe7T+kSrreM4xRT7S/iaF5e8FyFDsRrGxML
 ZZDUvptaEhifsbJYMnlEQTPoJPTTEpxQTGEEVUY4Kb5GBd0RrXt1aIoD1nkM6rmEitXUkTDSQ6x
 5bCwqMvgbPzfNDESq+/ZbVqfZvuZsJ7aLLHzSg==
X-Received: by 2002:aa7:c74a:0:b0:697:645b:90e5 with SMTP id
 4fb4d7f45d1cf-697645b9235mr3088617a12.4.1782097868438; Sun, 21 Jun 2026
 20:11:08 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_FB929239B227F05F30D62745E38BA01D4307@qq.com>
In-Reply-To: <tencent_FB929239B227F05F30D62745E38BA01D4307@qq.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 Jun 2026 13:10:42 +1000
X-Gm-Features: AVVi8CenqP06vFcsdLeDhxSThVRD5GK6GLikm8IbaMn4jsT07kp4jCe_daBurzM
Message-ID: <CAKmqyKMDznn=Dg3dgkTw-9K-N=8fDetGzwR4s6fybasHbf7GSA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: avoid abort when reading vtype before
 env->xl is set
To: ZhengXiang Qin <qinzhengxiang@foxmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu.zevorn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x531.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Jun 16, 2026 at 1:11=E2=80=AFAM ZhengXiang Qin
<qinzhengxiang@foxmail.com> wrote:
>
> TCG plugins may read registers from the vcpu_init_cb() callback.  For
> vtype, this reaches read_vtype() before env->xl has been initialized.
>
> In that case read_vtype() currently hits g_assert_not_reached() because
> env->xl is zero.  Fall back to the CPU's maximum XLEN only for this
> early-init case.
>
> Fixes: 638181a180bd ("core/cpu-common: initialise plugin state before thr=
ead creation")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3545
> Signed-off-by: ZhengXiang Qin <qinzhengxiang@foxmail.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/csr.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 5514e0f455..6ade7ccb0b 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -936,7 +936,16 @@ static RISCVException read_vtype(CPURISCVState *env,=
 int csrno,
>                                   target_ulong *val)
>  {
>      uint64_t vill;
> -    switch (env->xl) {
> +    int xl =3D env->xl;
> +    /*
> +     * TCG plugins can read registers before env->xl is initialized.
> +     * Fall back to the CPU's maximum XLEN in that early-init case.
> +     */
> +    if (xl =3D=3D 0) {
> +        xl =3D riscv_cpu_mxl(env);
> +    }
> +
> +    switch (xl) {
>      case MXL_RV32:
>          vill =3D (uint32_t)env->vill << 31;
>          break;
> --
> 2.43.0
>
>

