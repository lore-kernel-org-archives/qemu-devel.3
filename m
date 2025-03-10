Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D1E3C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 22:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trlzr-0006Fh-K7; Mon, 10 Mar 2025 18:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1trlzo-0006FB-CW; Mon, 10 Mar 2025 18:53:16 -0400
Received: from mail-ua1-x933.google.com ([2607:f8b0:4864:20::933])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1trlzm-0003yW-3X; Mon, 10 Mar 2025 18:53:15 -0400
Received: by mail-ua1-x933.google.com with SMTP id
 a1e0cc1a2514c-868da0af0fcso2087664241.2; 
 Mon, 10 Mar 2025 15:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741647192; x=1742251992; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ig7G6llHHqx30UhKA8gmhky22+sViIctHpc/Hwgbt9A=;
 b=YMEAbNz8p3jlK2K8ehg11qKBqi5Nz0LHrWPpEHIIcSMJy2bJFPeoBDRzSX/1lf0Nl1
 HAp39dTIq9chf03AQfcsePcQlj4kEWacIDSQvMnFEtZ/KHIEkljq0R9KqWwyFU45rzYr
 Q8L5aYM8P48RxvHsK9YzsZL83tnu5wxJW+3pzyrSlq/lk+DJunaobz8ruvJkuB35aP51
 BvEspgfdY4SuzsMSfeDOe7yrdGXO1BbguJCMpHbpMBYGg68sRXAg9QEgBUZrK3OvbPYq
 VMbpflwB/CmRozNJk/mLTa41C2KXJho8hUge5NVCC13o93c+935333lrkZSg2dR5A5pN
 dg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741647192; x=1742251992;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ig7G6llHHqx30UhKA8gmhky22+sViIctHpc/Hwgbt9A=;
 b=Z3WW4hoXTc7OhhFoUt7DklbUbeksy506tPwMIrNIMVeC9M4pTFENCqk+je6/v7TAj4
 T+I3hdqEUqLya+thAWMH75wQVimbu/r/xf/nsOXLP2Ti8lW04b8pe2BHUe/9zj4OmWkv
 /dnEatLNnRJa/z45SaJmoZH2HPrGK2xd3GGogHjyjaFag3aqzLpQoXPZsTgnr+v4v0T/
 Zu28p2KPYsekJIRl7tIQ8XNrMrtOF7OKYRhxCBSBC10Uwkbf44lVKiHDylARWO/phEFO
 JsNQBO5X3FeOHJFlm+q2uMJhIT2TFlXrYYoZxuXXly7Cd8ZGNDF3khBR1eJHhRZfBTiZ
 QDuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZ4JUAetZpCMHexZuz6VbCMaP3A5/J0W7WMTqMgL73l06t7eq5Otu2AHrZ2U2bJeNLfJ92u6CLIHGY@nongnu.org,
 AJvYcCXK2k4ZcuNaXpg5DxS+YWPmJNY7uKHy4LMSRYZDBf3Cu0X/W/wKgBx7lTl4/Hpp+BvFm3FmNFiBJhfshg==@nongnu.org
X-Gm-Message-State: AOJu0YxWImvXd9ivG7NtuP7CDLn4qY1ujMY7rJ1ohH2QvFn4ysVooYKl
 ivVNo+NyZDX7/M+jBT+fX5t5JSgovzS6MJUY3QVri5i0c2QT5D3fAyt3oicRoxaPIw1DKBfQ0Lw
 IVhPJXF02/PkGpaYcJdb0G0tlEPs=
X-Gm-Gg: ASbGncvsrr3JCFTzc3cMzVN6CR0Rp8vDtqAvWiDX0yyCYx51PNsqFq4ojKlYkFThizc
 mZFJGtF+WfLnZ5spxn+UagPdroIRVwk2EV2dwqrDMJXCUJoc/8rPMv2zRAJ+jnwgqxpmUZrNqzd
 KBxqKYrLpdgyKCXT9Es6dNyujgRPXYpJiGMDFOPv4EeoiERqhWv1/Ugod3
X-Google-Smtp-Source: AGHT+IFiJdheOdDM4Y3rcnssRvxcVYtxRL5LCQU4O+t6bTzique5VnlZvUou8bKRKZsqX7q3r9Y/TQI1mOotq202qkw=
X-Received: by 2002:a05:6102:578f:b0:4c1:8928:cefb with SMTP id
 ada2fe7eead31-4c30a5e6c20mr10774790137.12.1741647191828; Mon, 10 Mar 2025
 15:53:11 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1741573286.git.lc00631@tecorigin.com>
In-Reply-To: <cover.1741573286.git.lc00631@tecorigin.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 11 Mar 2025 08:52:45 +1000
X-Gm-Features: AQ5f1JoOkHszo03f1h4r0glQzyyiRMHgegc3WH6ycVj6y47Z9a65Nt_2pflv8xQ
Message-ID: <CAKmqyKMpSxYquX+_x-S-FU8-kpdB93Xv7BYk5H=_9neEMpg_hA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Enhanced VSTART and VL checks for vector
 instructions
To: Chao Liu <lc00631@tecorigin.com>
Cc: alistair.francis@wdc.com, bmeng.cn@gmail.com, dbarboza@ventanamicro.com, 
 liwei1518@gmail.com, palmer@dabbelt.com, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org, zhiwei_liu@linux.alibaba.com, zqz00548@tecorigin.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::933;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x933.google.com
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

On Mon, Mar 10, 2025 at 12:37=E2=80=AFPM Chao Liu <lc00631@tecorigin.com> w=
rote:
>
> Hi, Alistair:
>
> I rebase both patches based on the riscv-to-apply.next branch and tested =
them.
> https://github.com/alistair23/qemu/tree/riscv-to-apply.next
>
> Only the first patch had two conflicts, which were resolved nicely,
> and the second patch rebased fine, so you can review it again if necessar=
y,
> thanks!
>
> PATCH v3 review:
> https://lore.kernel.org/qemu-riscv/71f15782-ec28-4763-8197-c10ec12811ec@v=
entanamicro.com/
>
> PATCH v2 review:
> https://lore.kernel.org/qemu-devel/61e8f7d8-607a-4d63-b9dd-cfbfc840716e@v=
entanamicro.com/
>
> PATCH v1 review:
> https://lore.kernel.org/qemu-devel/CAKmqyKPFYxhK8PANOVzV3FMWxd79wZSJYLWkK=
OAgEMt_b2KvZA@mail.gmail.com/
>
> --
> Regards,
> Chao
>
> Chao Liu (2):
>   target/riscv: refactor VSTART_CHECK_EARLY_EXIT() to  accept vl as a
>     parameter
>   target/riscv: fix handling of nop for vstart >=3D vl in some vector
>     instruction

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/vcrypto_helper.c   | 32 ++++++-------
>  target/riscv/vector_helper.c    | 83 ++++++++++++++++++---------------
>  target/riscv/vector_internals.c |  4 +-
>  target/riscv/vector_internals.h | 12 ++---
>  4 files changed, 69 insertions(+), 62 deletions(-)
>
> --
> 2.48.1
>

