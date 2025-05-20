Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFF5C3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 06:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHGIK-0008DE-8S; Tue, 20 May 2025 02:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david.abdurachmanov@gmail.com>)
 id 1uHGIF-0008CH-Q0; Tue, 20 May 2025 02:17:40 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <david.abdurachmanov@gmail.com>)
 id 1uHGIE-0003hH-64; Tue, 20 May 2025 02:17:39 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a365a68057so2477230f8f.0; 
 Mon, 19 May 2025 23:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747721855; x=1748326655; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nRWPxD+4SPAf2Cor5nVChEZBbpuCaPKh5ySEGC1yM8c=;
 b=Du4ygmnmuO88VlSuL0Ssh6Ua5VZjYcqT57Sylm1Dl94N8XltSG8q8qGYblGtqh+L5q
 r0LGY0iIjqpPHvGGDm6LRc0IfVxQyCnisyhQtXfzQ67IlLdFQCxsoITNqpcDtcNwAU+B
 U3MS/S+Uv087HixEwjmu8B1M9JFa+40Ro7HZbIfvPaTgYIOJCel3EylA+ytfCyMY5yB8
 RFRm3A3y8enUd3ko9Fy5o0j68KvYDhqvZCsfoKCQ5IAdStipU7XDbknf1iF8E7dSJ1JK
 M5vCEUpII8GQZzR4eHrv8dDbWJ+PoRvBMvFItH4CTnCTcmVZe+8AdkZZHxPIJehuwM/c
 yBjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747721855; x=1748326655;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nRWPxD+4SPAf2Cor5nVChEZBbpuCaPKh5ySEGC1yM8c=;
 b=WvB+79ls5E7ANCdcqWGK5Pr8tQfanuOBhldI6xMYGFChaDfhxJvQajJ2JsvOr3q+xp
 DbUE46s0z09vA3V5CXfIhCx0YtQx6GI+YrWyAJuR1U4M0Ty+5+Hl7SB7sTWkVppjUhWN
 DM5wYRbhAwAnU6u4mYgnAPQsk8nKZOBuqaVXXCh9HBAmlPcctJ5ll4zRtG3Ze7FPk/iD
 PeU6xMz5+rPWn4joCUFcJLmpa9BxH06OK6q5web6jbNDdLV6j7S0xn3X5MSZXTU+i/Un
 J7s52p6/IY78zWRK7OF2R9d69m68PXgmZQSecnwialHYj73uppVX+jRRJMviqoMPqQ77
 CM6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqPruQQ0yFR4afeZRwnFQzC5Mskyi7rNZa7YqKa+F13PkiTwddkirDic44aKhL1CPrmMlHSe03lObC@nongnu.org,
 AJvYcCWaQR+57QCSfO1uplnanpYmVtMeJHi82LjDTO9I33pISEop97TEEMsF06IRF46uIttIhkhb+taQu+coZA==@nongnu.org
X-Gm-Message-State: AOJu0YwYKJhCkCcHPerARegh6G+WsPorel8XyODjhY6e/f1qJC9EYOeS
 zbLtJu8LzQv+0eRwREH4ltTQ4rPnBgAXpYLv6zHMO7mU53aiacsmMLAdHQToQJLUvJtD8ihhVu2
 BO5QTdYa9t3JTABgNIw7LFtKUdgJXLv+lUo8G
X-Gm-Gg: ASbGncvINT5IEI4uXvohI2MVBtbUomRq5wUo46zOzZ+j4FiE+Cny7RVWGxNE9awBn0D
 f4JDE7ZF62fDAPPXmjqEbAlJ3aOFw67JnGr+y5DI6BLWxaBhfxXThMwWnu5HLLlVDa32u+lF62H
 WbbgwcNChdYGwEBwsXMElagM6m5HJ/+ug=
X-Google-Smtp-Source: AGHT+IEtPwCiPiy0WLzo/WALNy7srhLe5VCzcoyCBlA+S2wY/eiXPzYcKhQWbNagDBpO8NHDDLN9lwwY5lyeJPzuTpI=
X-Received: by 2002:a05:6000:1846:b0:3a3:5ae4:6e8e with SMTP id
 ffacd0b85a97d-3a35c821e70mr13340419f8f.11.1747721854754; Mon, 19 May 2025
 23:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250404152750.332791-1-dbarboza@ventanamicro.com>
 <c969d9ce-626a-4928-b050-7b7fbd8f7981@ventanamicro.com>
 <CAKmqyKPXoA3Lwq+zxP=v=YutxXXWyMz2rk6LDiW2_bMyhRmgfQ@mail.gmail.com>
In-Reply-To: <CAKmqyKPXoA3Lwq+zxP=v=YutxXXWyMz2rk6LDiW2_bMyhRmgfQ@mail.gmail.com>
From: David Abdurachmanov <david.abdurachmanov@gmail.com>
Date: Tue, 20 May 2025 09:16:58 +0300
X-Gm-Features: AX0GCFuZlGK-0eF0X1b3R1XrF8Wi4gTDcvkd1ehx6v1ScqXFfyp0Pwg-W0yW5HA
Message-ID: <CAEn-LTqAdmxdMr_AS9r09qRwBjssmDenBtw2qS4VFE021JvDgw@mail.gmail.com>
Subject: Re: [PATCH 0/2] hw/riscv/virt.c: change default CPU to 'max'
To: Alistair Francis <alistair23@gmail.com>
Cc: Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, 
 alistair.francis@wdc.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=david.abdurachmanov@gmail.com; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Mon, May 19, 2025 at 3:20=E2=80=AFAM Alistair Francis <alistair23@gmail.=
com> wrote:
>
> On Tue, May 6, 2025 at 8:47=E2=80=AFAM Daniel Henrique Barboza
> <dbarboza@ventanamicro.com> wrote:
> >
> > Hi Alistair,
> >
> >
> > I think we should push this upstream and see what happens. We'll have a
> > full release cycle to undo the change in case we find unintended side
> > effects. I'm fairly optimistic that this change will be a no-op for mos=
t
> > users and will benefit us when we'll have to deal with RVA23 specific
> > software.
>
> I worry it will cause us grief in the future. I think if we are
> changing it we should just drop any default.
>
> With profiles now becoming popular it's easy for users to just pick a
> profile CPU when starting the machine.
>

Hi Alistair,

FYI the next virt-manager release will default to maximum CPU on riscv
if the guest type is QEMU. Basically if you are using libvirt/QEMU
(non-KVM guests) and setup VMs with virt-install it will get maximum
CPU.

See PR:
https://github.com/virt-manager/virt-manager/pull/784

Our current instructions in Fedora/RISCV set cpu to max too. This is
done by passing --cpu mode=3Dmaximum to virt-install command.

david

