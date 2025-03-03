Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D15C282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 05:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1toyFe-0003i6-Co; Mon, 03 Mar 2025 00:22:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1toyFY-0003hS-Dq; Mon, 03 Mar 2025 00:21:57 -0500
Received: from mail-ua1-x935.google.com ([2607:f8b0:4864:20::935])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1toyFW-0004yg-Re; Mon, 03 Mar 2025 00:21:56 -0500
Received: by mail-ua1-x935.google.com with SMTP id
 a1e0cc1a2514c-86b3bd4d0faso1408579241.3; 
 Sun, 02 Mar 2025 21:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740979313; x=1741584113; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OgpiujYnj9Kxi0GIjb5Vxf0uSrOTMAMZGpoKopQYj8c=;
 b=Ks7K8vwv9Q7h+Id6GAxsAKCvNhXzXuTLaWZMgsDGbiJJPD3Hc6eRWfxqDGmd7vNj/C
 3OALykbAp67izopzNIp8eflaWuYwhln4JlOxAdSgNCffDmx3Wp8GlwHu1kf6N7oFhioG
 iEikZIzCI7UPYFqH9QXsrzVWt9vN6ywFSS8mCfylKvSay3AytPj6HNdBv/mxR4dqi/Ti
 5EruQW8NAoVWQome0G9eEiF4kfoLEmq0PmaoeUpDl5ApEyb+f1y2hpuUfvxcLPnB4kSt
 JYP7XHehjePn4vAl/mcbt++UIi9bXarBY5PzaEyV5F/lM3LwZnpprBYohZEw7x5HHc1j
 V/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740979313; x=1741584113;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OgpiujYnj9Kxi0GIjb5Vxf0uSrOTMAMZGpoKopQYj8c=;
 b=NQ0sFNfy5fGJjDGzQRuYlH/NeAuFLaVhPk9SPmhAdjjYUdycVWNjNu2NuDcKLkyYhd
 EviMqvLIfNS2AkMoc7PBiKZueNhseeMTEQru3c8XjGv3neqdfB0SawZ4KK3YResXOfLV
 Il+CEZg2SWXog+D3AUNoeLkDugKQtd2WPkNKgwNw/+5AEbTZdENlFLJEC1GrClZ4FAiI
 PLl0g1KopJB7FbAPRZYSmp5PI0mnzx4NxV7Af15h7PSRwjEdMTzUdGF/1bP1L8w1/gL+
 yE+v0bUXWA0W21DMhFJDKV/1YMPkJPhGp9I3/gihK0NMpHnnM1AEP+PGS4lSYziXzDuP
 UOVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4fu9cNJYOM7EPOOqFU3zWkNryH7wm3yhbC0gzNZT00/iApR1lTiUlHQCDKmoB2Y21NEQeTOXjjzqI@nongnu.org
X-Gm-Message-State: AOJu0Yy7ditxi1lFEOidIlHOckW0swBbPXXycnuAiFl69JviZlNRGG3N
 uZ3DqardtBmladybxq/qliCWjENP3txaPqDeucVutGph8eegNDsD16Zax7dBpv1+GSHmCW/5ns/
 6rSJJoTXxWv2jlcA+4JoWFtZA0ZU=
X-Gm-Gg: ASbGncskKjoVJJrdIzr/98JI7yIHqDXyYmRRWg3HubSHOuEVj2Rvi+HOwBZ4vuv8tLX
 IAx3KrsbUGM77zqP8SgXZJPKO0TMSBxKtR1SU8pnxPijDOjuxcfr4LC1/UpBiq421HVitOIXSc+
 dAai/8iCUICYj3W6Yw8KjsJLK+3fT28tbtNthis48lF9WOetE6mh5QMECy
X-Google-Smtp-Source: AGHT+IGL2vw9FzVv5erbVv79qj0eo7a7cV2Zhu1mCXf7hYR/ZV577h8GnJsFXbW8/cUs/NLHfDcb9ZvmcvhGQW+/npc=
X-Received: by 2002:a05:6102:14a3:b0:4bb:d062:438 with SMTP id
 ada2fe7eead31-4c044858c74mr7404050137.1.1740979313127; Sun, 02 Mar 2025
 21:21:53 -0800 (PST)
MIME-Version: 1.0
References: <20250224123120.1644186-1-dbarboza@ventanamicro.com>
In-Reply-To: <20250224123120.1644186-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 3 Mar 2025 15:21:26 +1000
X-Gm-Features: AQ5f1Jpl5yVIfPIdpmvvd6cCtVO_jLs0YxkFrsjdvyQGwAP5zwzCV7MeIYw6Hw8
Message-ID: <CAKmqyKPiC2T8ajWXMX_OJJrMmQsmN9MJ_Xv+XMfb4YpdNTCQcA@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] target/riscv/kvm: reset time changes
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::935;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x935.google.com
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

On Mon, Feb 24, 2025 at 10:32=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> In this version I rolled back on the riscv_cpu_reset_hold() changes made
> in patch 1. Peter made an argument about keeping the design the same
> across architectures and I agreed. Patches 2 and 3 are already taking
> care of everything that KVM needs during reset, thus this doesn't incur
> in any functional changes.
>
> Drew said it was ok to keep his ack on patch 1 so his ack is kept.
>
> Patches based on alistair/riscv-to-apply.next. All patches acked.
>
> Changes from v2:
> - patch 1:
>   - do not do an early exit in riscv_cpu_reset_hold() if kvm_enabled()
> - v2 link: https://lore.kernel.org/qemu-riscv/20250221122623.495188-1-dba=
rboza@ventanamicro.com/
>
>
> Daniel Henrique Barboza (3):
>   target/riscv/cpu: remove unneeded !kvm_enabled() check
>   target/riscv/kvm: add kvm_riscv_reset_regs_csr()
>   target/riscv/kvm: add missing KVM CSRs

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/kvm/kvm-cpu.c | 32 +++++++++++++++++++++-----------
>  1 file changed, 21 insertions(+), 11 deletions(-)
>
> --
> 2.48.1
>
>

