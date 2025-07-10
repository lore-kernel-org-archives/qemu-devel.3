Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BDEC83F17
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 12:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZqdL-0006Bp-Jq; Thu, 10 Jul 2025 08:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uZqdI-0006BO-RL
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:44:12 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1uZqd7-0003s0-P1
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 08:44:12 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-60c4521ae2cso1677644a12.0
 for <qemu-devel@nongnu.org>; Thu, 10 Jul 2025 05:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752151438; x=1752756238; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m5AdhoPt+Z+scusECX+q6g4pSfzf7nFvMyBtqItkHF8=;
 b=A57Xy2bTAHKRsjNpdm9XkYidMOKGdXgtERFY+T+OdZD5WnNkhnkKYOn9mxAg/cdB2n
 eqRCv6CKXaUNCy10ly26sWpU01SBGoivIm08BgN3QN6pH8/Tjqt1iGd2GluJfC4OEvGq
 Zid4S4x1F+7qtY/A6MGY2PGP8E9qSBVq5f2U2HhVK5TvDpb+nnvmE9xzV89j1XleBKti
 lTLYvUVxh0RVJfeCzOME7GTx+nFZfsnQ0rxJg4rkFJD1jB7fKh50oaTCBEcC/tEfellj
 aHX6TTTSFeOE5h4HSsDZkP7NzKl9OZnj1LaTLr9AtNgbpByGI2W4rJ6sJaM/2g3hVK7M
 jX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752151438; x=1752756238;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m5AdhoPt+Z+scusECX+q6g4pSfzf7nFvMyBtqItkHF8=;
 b=QQ868tGv436y+xezAgV+51DOAsKaBD8nEQaxi6zHoGa1F1BEpLbJxXvzqm48SLsX2B
 VCIyfMP8pFn2bht5y0Os3NqX2lj2PBVWs1CodmedrDiO7sdPGTmVkxVpzxmFAWRvjpBg
 Wb5SH1dnrq1ojCDwF4LB6haGvsrCnc7WsIhZHOFTzPvm/Yc8oEUz5ON+0w0XNWrdEZ5m
 qMLPd5WT2RrP2Y4JVQucwXEnzZushrbD214RF8zwDoCurkJjT0AZXvsHT90Y7OF1lP2X
 e8mguNHPnn3zJ2cF3//SUMC5pqnBS4gxheE56OouMZ8wNB8g8BFiPkmIwJPY91OG6xvl
 S++Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvqNfXUyQZZLs40k2ke8huGcMnRBm87z+1Cf+zw7b9nA/qv3PdIQQG5EEMQlTPrFoDdhPUtaajY/tv@nongnu.org
X-Gm-Message-State: AOJu0YyxraulSv6y5MwmCvbApwZyYiv4nf+1zMu3Z7rltLL6gcyU+ULS
 MixHgOthyJCAAqytVr4t0Dyhm2w8LtG6U1L6Kj1P9PYgy8291BzYWaEJ+ZCmohth+yYnj4gIMYZ
 RAZuFWyhM5DtlzC1NWjILOQ/4U2wDhKc7e6ie7w4=
X-Gm-Gg: ASbGnctMyx+b4tCL9xYt+gy44Mi87ymaGeAyg0/20m30qCbzFVnDjDjDmmKPYyrCaQe
 M9FEtsjGvGzWxZt/ismMUhMxd6q8XHsec3HDmSQufNTgrWCdnI2GfPLeIh5khVD5WWQqAQwNYNY
 QBjiMa2eQoWMlPVsIRP7gs3GxpJBXW3nQ6pnCF7Kmxz9kQag==
X-Google-Smtp-Source: AGHT+IHaxopvZqBbOyPswd0NtSp+6OJ73JFGZ6gRbaZlhpmhU3vXk6aZvZUnkSjgzn5rEziu+Cj+14vVJq+0rq78j4Y=
X-Received: by 2002:a05:6402:35d3:b0:607:ea0c:65b2 with SMTP id
 4fb4d7f45d1cf-611c16ad81amr3039506a12.31.1752151437777; Thu, 10 Jul 2025
 05:43:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250710093238.453962-1-maobibo@loongson.cn>
In-Reply-To: <20250710093238.453962-1-maobibo@loongson.cn>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 10 Jul 2025 08:43:45 -0400
X-Gm-Features: Ac12FXxBpi1YLtKK5lmyms-831pIvvFb4yjFGLEyM_DdciO75_VHop-MgGauLbM
Message-ID: <CAJSP0QXq=d5UC8vp01OB0guvaH+V5SX8PtZ5b1NT78CmGeo6UQ@mail.gmail.com>
Subject: Re: [PULL 0/4] loongarch-to-apply queue
To: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Jul 10, 2025 at 5:34=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> The following changes since commit df6fe2abf2e990f767ce755d426bc439c7bba3=
36:
>
>   Merge tag 'pull-target-arm-20250704' of https://gitlab.com/pm215/qemu i=
nto staging (2025-07-07 09:22:41 -0400)
>
> are available in the Git repository at:
>
>   https://github.com/bibo-mao/qemu.git tags/pull-loongarch-20250710
>
> for you to fetch changes up to 8ad757642e3a8a283edc29efec73b9bd57fdb365:
>
>   target/loongarch: Remove unnecessary page size validity checking (2025-=
07-10 16:30:25 +0800)
>
> ----------------------------------------------------------------
> pull-loongarch-20250710 queue
>
> ----------------------------------------------------------------
> Bibo Mao (4):
>       hw/intc/loongarch_extioi: Move unrealize function to common code
>       target/loongarch: Correct spelling in helper_csrwr_pwcl()
>       target/loongarch: Fix CSR STLBPS register write emulation
>       target/loongarch: Remove unnecessary page size validity checking

Please take a look at the following aarch64 macOS CI failure and
resend your pull request when it has been fixed:

../target/loongarch/tcg/tlb_helper.c:643:75: error: format specifies
type 'long' but the argument has type 'target_ulong' (aka 'unsigned
long long') [-Werror,-Wformat]
643 | qemu_log_mask(LOG_GUEST_ERROR, "Illegal huge pagesize %ld\n", ps);
| ~~~ ^~
| %llu
/private/var/folders/7m/kxwv39y54d9g6lmkzwbqwk8r0000gn/T/cirrus-ci-build/in=
clude/qemu/log.h:57:30:
note: expanded from macro 'qemu_log_mask'
57 | qemu_log(FMT, ## __VA_ARGS__); \
| ~~~ ^~~~~~~~~~~

https://gitlab.com/qemu-project/qemu/-/jobs/10637285043

Thanks,
Stefan

>
>  hw/intc/loongarch_extioi.c                |  9 ---------
>  hw/intc/loongarch_extioi_common.c         |  9 +++++++++
>  include/hw/intc/loongarch_extioi.h        |  1 -
>  include/hw/intc/loongarch_extioi_common.h |  1 +
>  target/loongarch/tcg/csr_helper.c         |  8 ++++++--
>  target/loongarch/tcg/tlb_helper.c         | 24 ++++++++----------------
>  6 files changed, 24 insertions(+), 28 deletions(-)
>
>

