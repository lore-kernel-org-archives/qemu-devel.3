Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC89DC54E41
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 16:20:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfj8J-0001Kv-ON; Thu, 29 Feb 2024 11:19:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anup@brainfault.org>)
 id 1rfj8E-00015a-Qt
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 11:19:40 -0500
Received: from mail-il1-x12c.google.com ([2607:f8b0:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anup@brainfault.org>)
 id 1rfj89-0004RT-AI
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 11:19:38 -0500
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-364f791a428so5480655ab.3
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 08:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1709223570; x=1709828370;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qhMwoDYvCne6enjotZwzjXE3hZDJxEtDrlqLaJ31C2c=;
 b=Cxcmsy0t8gOE6CL1cdk38JW9e9SfU57FCXIv8lWPg/SA/MOYZqcXdLYkwUxEAC/PT6
 O0iAHcW4BTaKDJBNwMLe1aEEbTadr3bouVazcVZXQtiuBI5qU1qNJSYZjxZ3XSlsVvz0
 lPYM+EAd9HnlZ5of19oSjLC63svW1VQmqMDV6kV/XXPifRPDWsiqagbVHK3eLrZiWZia
 iHZaT1f/R01DZ8RCxwxfcdz6y1LMYj7G9qOpZg97o7TsDFCLE1xIkfh3+6ocREZf8KMn
 eeHTHekDsltKzcfMNDv+QO/3b3I6/w9Dclz4q7alVIyzoHnZUpiDbXQY59x/j5ih+Kg9
 WwSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709223570; x=1709828370;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qhMwoDYvCne6enjotZwzjXE3hZDJxEtDrlqLaJ31C2c=;
 b=TTwEZ1fuELZAu0KA8QeBMoSxagUEnAFzPbs++fVFaYWa6d0Q6qSRvUbLsFnTiCiFRT
 HwG5ktIKH2dQBky8x623DCOw+8bZ4ZWyc8M9qMEGvMtQovybohmTUQo8bO7tF7cOaX5h
 Ll05SPqSOs2gFFJTga7hgY9dKbpZjlIrphSyK0OJSvQnsxFdE8HGRWVl8kc/1hSLCj9M
 Y7KMbclJ9ieoAQkm7Xw214Ug1/VSGTIFsp7lktbgJGh4GOVt3qcczT3lZTJ/fXeqh0QF
 qpx1eizbJqRywytB0ys7b+W1TwOLJqMhAMWfvO3ElrV7BKUFyLwSlF6+Unpjlh+WkuMe
 quFA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNmFcrkDQlXdJI/OJ3K/33kHSkNIsa1LUagjpaLcDLrHfZsZojsDWdVtcytl+xf/xOg7ZpaUEptun6CvMQFAv0wiZ51uQ=
X-Gm-Message-State: AOJu0Yw6h93VYm2mkwPqpFWteaGZHHWqMU+B7lbv8gNy8/kYGuiM+qxl
 OjAj4RU0kXBTf/bP3FHIa8ajD4QwKrYvj6uRDGrcJ0SrEbO+gYwhszWW5/fuVncJfPFu/N/W8rM
 MG9SwSuHXxCfrYtXpikqQRojMGYU2Z3CGRmd+lg==
X-Google-Smtp-Source: AGHT+IEzgbAYTi+ym8//C44o6UNWMShD6UHO4ifqlAFXUhPGoZB95btd4sFaoTq+70InQjlaYOFJeATjxV6cit1Aw0k=
X-Received: by 2002:a92:d0c4:0:b0:365:2732:8bbc with SMTP id
 y4-20020a92d0c4000000b0036527328bbcmr2695219ila.29.1709223570257; Thu, 29 Feb
 2024 08:19:30 -0800 (PST)
MIME-Version: 1.0
References: <20240229133745.771154-1-hchauhan@ventanamicro.com>
 <20240229-92706c0ccb3d6a6e8b725815@orel>
In-Reply-To: <20240229-92706c0ccb3d6a6e8b725815@orel>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 29 Feb 2024 21:49:19 +0530
Message-ID: <CAAhSdy1SrsU4x1V5OPRzBKmfC02qHrC09QM66WK4nUqDpONGgw@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] Export debug triggers as an extension
To: Andrew Jones <ajones@ventanamicro.com>
Cc: Himanshu Chauhan <hchauhan@ventanamicro.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=2607:f8b0:4864:20::12c;
 envelope-from=anup@brainfault.org; helo=mail-il1-x12c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, Feb 29, 2024 at 8:42=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> On Thu, Feb 29, 2024 at 07:07:43PM +0530, Himanshu Chauhan wrote:
> > All the CPUs may or may not implement the debug triggers (sdtrig)
> > extension. The presence of it should be dynamically detectable.
> > This patch exports the debug triggers as an extension which
> > can be turned on or off by sdtrig=3D<true/false> option. It is
> > turned on by default.
> >
> > "sdtrig" is concatenated to ISA string when it is enabled.
> > Like so:
> >     rv64imafdch_zicbom_*_sdtrig_*_sstc_svadu
> >
> > Changes from v1:
> >    - Replaced the debug property with ext_sdtrig
> >    - Marked it experimenatal by naming it x-sdtrig
> >    - x-sdtrig is added to ISA string
> >    - Reversed the patch order
> >
> > Changes from v2:
> >    - Mark debug property as deprecated and replace internally with sdtr=
ig extension
>
> I'm getting lost in our discussions, but I thought we needed both in case
> a machine only implements debug 0.13, since sdtrig is at least 'more than=
'
> debug, even if backwards compatible (which I also wasn't sure was the
> case). If, OTOH, QEMU's debug implementation exactly implements sdtrig's
> specification, then I'm in favor of deprecating the 'debug' extension.

The QEMU's debug implementation aligns more with Sdtrig v1.0 specification
because we have mcontrol6 which was not present in debug 0.13

IMO, we should definitely depricate debug 0.13

Regards,
Anup

>
> Thanks,
> drew
>
>
> >    - setting/unsetting debug property shows warning and sets/unsets ext=
_sdtrig
> >    - sdtrig is added to ISA string as RISC-V debug specification is fro=
zen
> >
> > Himanshu Chauhan (2):
> >   target/riscv: Mark debug property as deprecated
> >   target/riscv: Export sdtrig in ISA string
> >
> >  target/riscv/cpu.c        | 38 +++++++++++++++++++++++++++++++++++---
> >  target/riscv/cpu_cfg.h    |  2 +-
> >  target/riscv/cpu_helper.c |  2 +-
> >  target/riscv/csr.c        |  2 +-
> >  target/riscv/machine.c    |  2 +-
> >  5 files changed, 39 insertions(+), 7 deletions(-)
> >
> > --
> > 2.34.1
> >
> >
>

