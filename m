Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE7E0CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 01:45:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v32vu-0001EO-It; Sun, 28 Sep 2025 21:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v32vq-0001E6-N4
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 21:44:03 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v32vd-0007KF-Hf
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 21:44:01 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b3b3a6f4dd4so227372566b.0
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 18:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759110225; x=1759715025; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oC2CFS1PAHIvuqzX5fQskVTJaszXMlhixWQ7HJegC2s=;
 b=HTyc3SyiFO8GIGvW+3l/9HSeuwa7Ti0XZODyz1Ke5QsQAGcKZ0kWBhgQD4+bxa5KBO
 rAc/k+OzPxTPbLNbUacqbF0hC2rrAUuAXFZhxn+81nGCkGk0SK3sTAYaogJi9myLdvz8
 33QdCeilnv1CLTQdnW5HpNlmU5DUgql00YB1eO9OZljYb5xgVnJvmd9vykawJ7KyHyav
 xlCUDOxEQDWtQ6hYBtkg0LP9P6nfysEWu8DP42XB8c3Vc9tz491EUpjkJjxJBBOPXQ8T
 BwcL6vLyT4zoVnrDq/6lMISdsxI+YRs15Vy1G8Qv40HptEulcsNet6YKi5uderBGg+aa
 3DQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759110225; x=1759715025;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oC2CFS1PAHIvuqzX5fQskVTJaszXMlhixWQ7HJegC2s=;
 b=LQKqUDBV5+qJ5DJfdGxBZjR9+kgwfkCx+7y8CADAvD56Qe1m++f5764g8k5Sy7rQuV
 j7TRQDqtoUNfGuLT9bq1RTAXS3MkZfnjAVXf1sirkb2dI9sYygdY1VXYQ1zqqW5m5pBn
 K7YqV5k0Ecp9lkdCyPgUC3KX91UI/lVgQ2MbfhP+2ED7nNAn4yt7lmjc+00GvWGI6YFR
 OXovLehLHXIotXbBOIvH/PV83MOi79BcYvH5qpOIRHOaWiEn4U+KwiDlNZEkfSFHBB/B
 SKFsSplwlg1cFQfvzzOzkKyeUc2QQNhmxIr647mlPbkhzu5TD0w8GrytQUv1R9J6n0ex
 EMdw==
X-Gm-Message-State: AOJu0YwIIuVFCK3FjNa0vTgFeK9oyoCB8KU74wnP4mS7GLqLZZnUYUIs
 /PClNk4D6hWN9n2IUwoY5DF18Yl+KK0ZQkt9IRr0h4eMPmCCCHM/f47znez29ECy75jEEdTB73P
 Jd+xGFOmcs/Y0AVKCh7+i9wN6TJinNP4=
X-Gm-Gg: ASbGncsdZiHqeHrWWN6pvvnY7ef2azLbV45eR9xudz4xbZ9fU4W5lC1JENP7T+B1XAh
 rCLNE22hv6LKBp0pXv3dLlsllOUQRsqZVKIjHY9FYGYOf+ZWRx/PyhrJIkhko8zJXBzLy6qmnBk
 J2yHqxAQWgODj8rb6tSmuquY+pzle/FlZ59azsPuC8jWdMFRRehx3YtqUIrrVtWODuCURPnwkCh
 xCKJUi4JkzUEFuskq3O9RyxU3eU8NRmmSU6joWhPWfuo1kP
X-Google-Smtp-Source: AGHT+IHD3ZoMWNv4S67RDyhhv3bKehBgEmxMmx7xh3cmCGY7KwNmsH+9khpmHvrP2dvSD6x/hOj+h9IosPsN29/qKhc=
X-Received: by 2002:a17:907:d106:b0:b04:5a74:b675 with SMTP id
 a640c23a62f3a-b34b79c7b7amr1475707066b.9.1759110224955; Sun, 28 Sep 2025
 18:43:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250915070811.3422578-1-xb@ultrarisc.com>
In-Reply-To: <20250915070811.3422578-1-xb@ultrarisc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Sep 2025 11:43:18 +1000
X-Gm-Features: AS18NWD6xed5-YEjLXuhR9X8f75I1vdI2Aut5H7EzxQmrzpRqvD9mMGJx__RUv0
Message-ID: <CAKmqyKOnJcFbZCCfssQYpBS5VwPZJ3_28TxLvkMWD8nukFD6uw@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_v9_0=2F2=5D_target=2Friscv=EF=BC=9AFix_riscv64_kvm_mi?=
 =?UTF-8?Q?gration?=
To: Xie Bo <xb@ultrarisc.com>
Cc: qemu-devel@nongnu.org, ajones@ventanamicro.com, qemu-riscv@nongnu.org, 
 pbonzini@redhat.com, anup@brainfault.org, alistair.francis@wdc.com, 
 rkrcmar@ventanamicro.com, palmer@dabbelt.com, xiamy@ultrarisc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

On Mon, Sep 15, 2025 at 5:08=E2=80=AFPM Xie Bo <xb@ultrarisc.com> wrote:
>
> This is v9 of the series. Compared to v8, the patches are now based on
> the 'riscv-to-apply.next' branch from Alistair's repository:
>
> https://github.com/alistair23/qemu/tree/riscv-to-apply.next
>
> Changes since v8:
> - Rebased the series onto [alistair/riscv-to-apply.next]
> - Removed the previous 'Reviewed-by' tags due to the rebase
>   * The changes are purely mechanical; no code logic was altered *
> - Added 'Cc: qemu-stable@nongnu.org'
>
> Xie Bo (2):
>   Set KVM initial privilege mode and mp_state
>   Fix VM resume after QEMU+KVM migration

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu.c           | 17 +++++++++-
>  target/riscv/cpu.h           |  2 ++
>  target/riscv/kvm/kvm-cpu.c   | 60 ++++++++++++++++++++++++++++--------
>  target/riscv/kvm/kvm_riscv.h |  3 +-
>  target/riscv/machine.c       |  5 +--
>  5 files changed, 70 insertions(+), 17 deletions(-)
>
> --
> 2.43.0
>

