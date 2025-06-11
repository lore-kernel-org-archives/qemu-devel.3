Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FF49C61CE7
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Jun 2025 04:32:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uPD7j-00036X-Ha; Wed, 11 Jun 2025 00:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uPD7g-00035x-IF; Wed, 11 Jun 2025 00:31:36 -0400
Received: from mail-vs1-xe32.google.com ([2607:f8b0:4864:20::e32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uPD7d-0001aF-4i; Wed, 11 Jun 2025 00:31:35 -0400
Received: by mail-vs1-xe32.google.com with SMTP id
 ada2fe7eead31-4e7b3363c5aso330600137.1; 
 Tue, 10 Jun 2025 21:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749616291; x=1750221091; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4GFacjXElYcpgysBTYJrwW7iEZGXZBIzzC0oGvp6J2A=;
 b=Rs/RtbCAql3FIDX/jiHXsnrJorrJVRXQ4T3C+wT3wWf8uTkVdnBFJ3n55BmtvneR0b
 8cubJXoReYAsc/PhQW2t+HUUokbN4RTjkI2YKBES4Kqt9X2PxS3qlHPnKbbL8MDA5ACM
 ogkbsOyR3tTMQ5kqEXIvxF9fgvfB4kafbD1z4/rviWTpVBFl7OA9SRCWwqu8D8WYRvhC
 0vonyBRvt06o5NgxqlqfV8IKP/OkkfDjIFuRO770DlxpQiWSltuY914LzCAKtcd64ure
 iHXnpMB/AR8tTturlqPWQSOjeKEe1Azo6wDQit+j/ag58upl/vjMC8ZdSBoawu94Z34Y
 hK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749616291; x=1750221091;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4GFacjXElYcpgysBTYJrwW7iEZGXZBIzzC0oGvp6J2A=;
 b=CEyEfc9i3/jzi5nTCnAncQVdAYZ7N1CMGcVixEvdzm5jqA8kT0Cbg/RPoVRP8SO3eu
 Ypjgr+Q+EcCiGWrraEjGCVMnD+A3eArUQGQxmyMm+RDlzV+MDvpBAUgtOiru0Y5XJa/K
 u5qzyh+7BTAYpzd4wmxC56KVNJjEb6B1rE5lmuw36d7ewawf7nrnR6olaiPofOkajZY4
 EtbsPUt4jIIm38JOivKdWByyqgl8WFoCQWUaxLyHtCiQ8rbUplaNkAgQ2W/bZu1iNIBW
 befqDgt9L8m2ug8DuZUUtgHnRipZwl6kHE+Y1+OOSmSJzi9EIc7ECFjW2hVz6arMb1jr
 AB5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNzUfaF4LBLr0nvelg2rM4f3kh4mypWHszg++p62xp8ywWN4dLcwtDiKqakqfqb6QrrjVw18g7KELm@nongnu.org
X-Gm-Message-State: AOJu0YzM684JA6HMKCvF2lOpMDfM6O3RO4nkNYOdKYa462NJUBw1uSAY
 mD8LinFlyydNeqW6uUhwpdwdskpY/R6yzUCpOsj5Ieic3gMLYGts8kDv5CFpF4G+hvA+SOSGFYR
 Eq2MV5sbuUzqFeSfnyy0Qvfig8D1W7Uk=
X-Gm-Gg: ASbGncuOpDg7P4EoXZoRjga+/gZw5F/lzyM2yy9DrSD3NzVIuCN7v4ixHaMhjlMjB+y
 72C1I+b6IZlv4P6HjbxpqRDJQ5BvWGR27RW6ZcmH9jKfcUAD+OeibNMsrAxpR29OMF/IoaDKQZE
 B0rEhziAnfV+crtq8T+5gt6Vv3PaEkh6GqMyoeTkkNs5d30M5y75QeWfAwbhDAY+f9/4VgNbSTz
 ZgvNlHmWrZy
X-Google-Smtp-Source: AGHT+IFdK0oj7akwuvbuaaqOeO6aKZSmPihiNV4uTTzNtZrdDhkkHhMiyqcjvGWE9kj7jFvBZn29TBSL3KEzlFBYez8=
X-Received: by 2002:a05:6102:396e:b0:4e5:911b:60e1 with SMTP id
 ada2fe7eead31-4e7ba571be5mr1600596137.1.1749616290847; Tue, 10 Jun 2025
 21:31:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250610083309.992724-1-roan.richmond@codethink.co.uk>
In-Reply-To: <20250610083309.992724-1-roan.richmond@codethink.co.uk>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 11 Jun 2025 14:31:04 +1000
X-Gm-Features: AX0GCFtK1_X-CEEUQIaM7MARps1xdWJohEVKcMuP_s09fUNlXKmaIZT49iN4vv4
Message-ID: <CAKmqyKPQ=TjrgdvHBRoe1CYLR4eoMsd+Hs+2LNVzUOEMApDeow@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] Add RISCV ZALASR Extension
To: Roan Richmond <roan.richmond@codethink.co.uk>
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e32;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe32.google.com
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

On Tue, Jun 10, 2025 at 6:33=E2=80=AFPM Roan Richmond
<roan.richmond@codethink.co.uk> wrote:
>
> Ping, resending as no responses in over week.
>
> V2:
>   - rebased patch onto master branch
>   - added check for RV64() for Load Double, as pointed out by Alistair Pa=
lmer.
>
> In response to Alistair Palmer (https://lists.gnu.org/archive/html/qemu-r=
iscv/2025-06/msg00010.html):
> "Aren't you missing a check to ensure RL is set?"
>   - There is no need to check if RL is set, as this is required by Spec f=
or all Store Release instructions.

I don't follow this justification.

What would happen on real hardware if an invalid instruction is run?
It should cause an exception, which is what we should be doing as well.

Alistair

>
> Roan Richmond (1):
>   Add RISCV ZALASR extension
>
>  target/riscv/cpu.c                           |   1 +
>  target/riscv/insn32.decode                   |  10 ++
>  target/riscv/insn_trans/trans_rvzalasr.c.inc | 110 +++++++++++++++++++
>  target/riscv/translate.c                     |   1 +
>  4 files changed, 122 insertions(+)
>  create mode 100644 target/riscv/insn_trans/trans_rvzalasr.c.inc
>
> --
> 2.43.0
>

