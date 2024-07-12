Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1839C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 09:08:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSCGW-0003vz-K3; Fri, 12 Jul 2024 05:08:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sSCGO-0003O5-Fz
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:08:24 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jim.shu@sifive.com>)
 id 1sSCGK-0000Q2-2X
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 05:08:22 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-52ea79e689eso2427708e87.1
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 02:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1720775298; x=1721380098; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hoi5Ljthle/R6Uu59pU98XoPZerV++ElxTvv045jQFg=;
 b=l4KzkVneOPC05GQVDXtHDW5J19EG3DKkBBLV3bAL1icqbX2MNtKxXhpKErdCeHMMr5
 jWzZyJwATHo/6JTemV5AI93mudeV++7H+v3CLzeXI4Cqlrl6CxdqBGUlbTRZ4ggQMUZW
 xHCrC+iO4S3JHHxgzNr47fiD5f7JYlfHOTH/J9y3/efJEnEr/EVAaBiogLBOT6aQhRKJ
 6vBbKmHVVwO0dGBAQVco+FmyyBdIiWk5X9njTMRm5guxFNimOO5ZdJcrvwYlVx6kEWWg
 LtwvQt9fxwLCuWIXIPuJWHNR3Frclkho9rMdk6l6rK1Vi/vnL7hjYH+h3yyPZKenMDKh
 QtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720775298; x=1721380098;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hoi5Ljthle/R6Uu59pU98XoPZerV++ElxTvv045jQFg=;
 b=FwD5pwpr2FiNEaC+Bfda+9Lo7ue8LzwqtWfQDcYYcedr1HMXky9iLpR2Gn2zfdHLP8
 Mhl2ORM2HMRn3YXn1KkYZscEjmvM96Asasbczu4uLE737x8gi6QzTYUSchUtR+Scz0zt
 bP2NCElgh9nzbLOFdHc0MPuqbpzyc42Z/iJOlIzdV4rcpJ2JEjS29QbWvFKAsUd7KGoG
 y+PmSqPjE+r4/on/DMRMTOrRKTPPdy3BranHqok1nk39YZMa1anLXn3Ur/6lT3WPKXKC
 HyabIMQiw7iwyq3EyviE/CKRChJMhILGwyfsLPONz+6gi6ofPtov8rg3AY5Eh9b5/JTT
 lDLg==
X-Gm-Message-State: AOJu0Yw8UQL0wLLqXjsktZL4nLY2o2GNOSFUftGRNyCBroWQjQLw6IL4
 dvk1O0cfS6wWmd8W5tfixdGXYF7LbYTzc+8tEEawBz7HR+GYXrGPmLUUOp7B+Mh9cqj2sMVWvfM
 1KZ0OgKEID8VTE8d+I+5A9aka3cQrh1r64NsbAA==
X-Google-Smtp-Source: AGHT+IF7TyTyCwMn1NkhNPH3Vt2X0Q24QuSmo8xQWWRDMmztVcxxI6vVqKVEiW5xcK7RhPDaZqfwpKC/K1OjxvVfeYI=
X-Received: by 2002:a05:6512:39cc:b0:52e:96d7:2f38 with SMTP id
 2adb3069b0e04-52eb99d6840mr10486832e87.62.1720775297954; Fri, 12 Jul 2024
 02:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240709113652.1239-1-zhiwei_liu@linux.alibaba.com>
 <20240709113652.1239-5-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240709113652.1239-5-zhiwei_liu@linux.alibaba.com>
From: Jim Shu <jim.shu@sifive.com>
Date: Fri, 12 Jul 2024 17:08:06 +0800
Message-ID: <CALw707qPBsfAAo52q4o9nDYgaZf-M=JbKC+x0Njx9XnQrmGJdQ@mail.gmail.com>
Subject: Re: [PATCH v4 04/11] disas/riscv: Support zcmop disassemble
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 bmeng.cn@gmail.com, Deepak Gupta <debug@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=jim.shu@sifive.com; helo=mail-lf1-x131.google.com
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

On Tue, Jul 9, 2024 at 7:41=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibaba=
.com> wrote:
>
> Although in QEMU disassemble, we usually lift compressed instruction
> to an normal format when display the instruction name. For C.MOP.n,
> it is more reasonable to directly display its compressed name, because
> its behavior can be redefined by later extension.
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Acked-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  disas/riscv.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)

Reviewed-by: Jim Shu <jim.shu@sifive.com>

