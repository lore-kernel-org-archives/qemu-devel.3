Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49C51C021A9
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 02:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkDJ5-0007qP-M5; Mon, 17 Feb 2025 21:25:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tkDJ4-0007qC-AK; Mon, 17 Feb 2025 21:25:54 -0500
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tkDJ2-0005MX-3V; Mon, 17 Feb 2025 21:25:53 -0500
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-5208736db3fso968899e0c.3; 
 Mon, 17 Feb 2025 18:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739845550; x=1740450350; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IY5kWlXvpGwPlUFdmrybvEqIBPOuaYXZZfvKf4rFUgQ=;
 b=eAMrmLM6QW51Zrq+MyTXu8fe9RXVa8kT4TIilfIY4FaPLpzDW7JHyKg1h5LZEfVl27
 JOry0u9w8+Bky+ThZxuisPGnGerNOobwBRCv5xLLIMlP+ozwbn6nuvFxfF0cK1I2lH6k
 AhkpPqAWxwKMLsfW6EArnkTBHwAGKZH9mzOBFjUoBUl/oiEIdEjXiBvAnMMDm4J+psdc
 Tbi67REyjbhg9qNnBVf0qTW+t9gpiV+1CcLyfq1FbdmXiP7HRXyU2jSASDAH8WWFFCH+
 9x/3OQYwCcDEVt4tgAVc6g9zmcn0sJzscTSWhz8TJOaEVV4waULl7bXwLVNRyE0nUUFl
 2K5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739845550; x=1740450350;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IY5kWlXvpGwPlUFdmrybvEqIBPOuaYXZZfvKf4rFUgQ=;
 b=tNF/Islax58aYcdxCex59xHiIk2/Q9Z+jtiY7bwQ8n/J94fzcJr8sSIWTAXntuCHb1
 GOjObn4WAT0g6eUQixPkQ7UXFLNxkB6X12AbG2PdGch01Wjf13d1KN/H/TnXM7S11DFk
 4W+jVFUG6+k21ALwXxnd1fOreXMIufwgyT4E1CqqI2CFlW+T9rVolXGN7U4b/nGBZH4L
 u16AeI8MIOsvEcfutA/kqJji9ta8Z/mQ/+F5jvxZoabRDFyFj+ANEHSKf2nNdEYmdjRh
 tBGOJAm9AiLViKDvndMUCAr/j9ggBF4u5M6rGC99h4/lyb+5fDhP4ZtQVaUtnEZjSekl
 wRKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZkyIo2tWJGr9MaXk29HrkoJY68dptVkk7bC79lc4YgXN8dOS4Bu/EFxQsPmCXAIs5W86+elE3geQy@nongnu.org
X-Gm-Message-State: AOJu0YyRhFI02dokkyXDIYbYGgsI6X8GUtUzYESab+CYKN7Zizd/m02M
 doC569umAniNP4PKWgPO69xfgV/I03lqCZrebGC8L5JH0AxMiahzS9W2O+YNWPLiP6noN4vSHLZ
 FgyrFRi8zhp+w/wp96iUG0qE23z4=
X-Gm-Gg: ASbGnctECuhN5HiJUAcG0s1xlAJdackyp5c4TeXi3pOrGCqM6r6wCvExi2nfgLns0jY
 c6bg23aZ+b6G3wI+UnfIFsOZZmJ1X75PBn6+sEV5TYlVd6ek3mcd7KW4TYgn5mVRPyAxWWU9TwT
 slsvrFWkB2rvpwKcIlOFU+VSeYUQ==
X-Google-Smtp-Source: AGHT+IGQY4azRoy/2Pzo2seBBIP3ND63Ib9fta5wL4dkDAxIoDVIGIPwCoLIZNeoFQydUrkjlB8fVyncrcVf9ZZEH9I=
X-Received: by 2002:a05:6122:9002:b0:520:3987:ce0b with SMTP id
 71dfb90a1353d-5209da1b40fmr6055598e0c.2.1739845549949; Mon, 17 Feb 2025
 18:25:49 -0800 (PST)
MIME-Version: 1.0
References: <20250210153713.343626-1-rbradford@rivosinc.com>
In-Reply-To: <20250210153713.343626-1-rbradford@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 18 Feb 2025 12:25:24 +1000
X-Gm-Features: AWEUYZmwnJXByFInV6j7rGRRZPKAZo9aMQS8PG_BMGswim4wITWO2C9KDpuP8cc
Message-ID: <CAKmqyKMikm_TjEL06Ys=ZUCqRX=c+b2zGaJvuXE3+p86Pjj_vQ@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Respect mseccfg.RLB bit for TOR mode PMP
 entry
To: Rob Bradford <rbradford@rivosinc.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2d.google.com
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

On Tue, Feb 11, 2025 at 1:38=E2=80=AFAM Rob Bradford <rbradford@rivosinc.co=
m> wrote:
>
> When running in TOR mode (Top of Range) the next PMP entry controls
> whether the entry is locked. However simply checking if the PMP_LOCK bit
> is set is not sufficient with the Smepmp extension which now provides a
> bit (mseccfg.RLB (Rule Lock Bypass)) to disregard the lock bits. In
> order to respect this bit use the convenience pmp_is_locked() function
> rather than directly checking PMP_LOCK since this function checks
> mseccfg.RLB.
>
> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/pmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index a185c246d6..85ab270dad 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -524,7 +524,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t a=
ddr_index,
>              uint8_t pmp_cfg =3D env->pmp_state.pmp[addr_index + 1].cfg_r=
eg;
>              is_next_cfg_tor =3D PMP_AMATCH_TOR =3D=3D pmp_get_a_field(pm=
p_cfg);
>
> -            if (pmp_cfg & PMP_LOCK && is_next_cfg_tor) {
> +            if (pmp_is_locked(env, addr_index + 1) && is_next_cfg_tor) {
>                  qemu_log_mask(LOG_GUEST_ERROR,
>                                "ignoring pmpaddr write - pmpcfg + 1 locke=
d\n");
>                  return;
> --
> 2.48.1
>
>

