Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A9BD4A5FD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 04:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgbkx-0002dV-PB; Thu, 15 Jan 2026 23:48:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vgbkv-0002d4-0Q
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 23:48:17 -0500
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vgbkr-000763-Vj
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 23:48:16 -0500
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b87693c981fso298928566b.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 20:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768538892; x=1769143692; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iA8XesB8YSvIpr81x5F94ifNOJkg0jSAiavKc62P2N8=;
 b=D9lVxKJxPRh5bCE2XA7vaXxO6gkmWCRcBkd9lCoc/iHs9kNj9ZpU4QQJJ1SqVkPPV7
 3mI2OAcD+5Y3gCScTAi0EcbgbCLZPjOzuAa/uxpzQYu3ZtCm/Q0F3uFAIH4hniAMESCC
 bgkxKppBNkNaVB7rMbzBWJiMs87hmPr6js82sKEKbD/Um1a6z/mfVQDcwn0fIqyvcRkr
 sh00U67Upl/QMqQmqifrPcQ8bE/rm7Sy75JBa8WfYP/ndj2fWbt10XI2vE9qOKf3/Xvb
 6gX8ufDO/VWhSkqiSRbtBY7P+8eVVWnb6FRqHQvjwrWe62z3vp47QgXXjXCrEz+AdxQ1
 WsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768538892; x=1769143692;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iA8XesB8YSvIpr81x5F94ifNOJkg0jSAiavKc62P2N8=;
 b=uofJJid/47tqRrXjK9ewC1BfwJPd2Afrj9CIP+ENgxba2sJXma/s68ONBmZFjb37yO
 XVtANU28HJR0ZoGxtA3zue4Eks4XNcx/sJ9NVh5jrkWia5JmkTL/bCCW+vLPgs5BZp5E
 w4GDNN0eHv7oi7wPh/9RSojdJOs4MEGBiuQy0P3jhDoX80xaMSKoKZdusrXW0RwKnVKk
 ArsetfolrJ0EOhRrIAKOfp4AOxpLEpP4UYOMEdsWLhU+twHEh8crn0PNHUc3G4wVIoSy
 P3zjNUqTX8sW2BI201a4luGDBwwlE9kqIA9Dlr7Ca3IYr1RhDv/lVIu0w7RYbZmCOAQs
 nAcQ==
X-Gm-Message-State: AOJu0YyZ1VftM8UNQTWeRA1WvUgteXmViK9zOk8t4Jz0tihqUXuDjAXY
 2MuxtKJDvkVFLS2211qe4xfKFqgNmf6LyoYQAWllKp/Jnq8Rg2H4eRkU3YH40ccGteu5BTDwAT1
 efp7wE6ZdzkdtWyFhlk6xzaXOJUluJ+Y=
X-Gm-Gg: AY/fxX5OaO1SK0CLGpn6G1foxZFWAfOpw38B4tF9+gfu0H4r4vaVZDL+eP64Tbozs/b
 zzbioS9mEunBlst+WWx2N5etpgVYkAQEowGPy4HwSYKLVuwY8QnKKIkSZyOZjWpGUtrG3rla0ah
 lGgwcZt+6XhcTI7R1+68aniUwXz8IYRyxq3bynzQ+oc5HwCs6cSwF/n3C7Scz7nVHKQ7d9HzDMU
 jRXCC2bVdowX5cPBAf7d1Ufe69tPS1BOfziktk/EFOHHOi60zWLwLnQxGBy7BOrZXFVLnCO8g8L
 HnafeQCRvMpVBFmlqxdVYmvnXA==
X-Received: by 2002:a17:907:868d:b0:b86:fa17:4cf5 with SMTP id
 a640c23a62f3a-b8792d274c0mr171902166b.13.1768538892102; Thu, 15 Jan 2026
 20:48:12 -0800 (PST)
MIME-Version: 1.0
References: <20260115130110.2825796-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260115130110.2825796-1-djordje.todorovic@htecgroup.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 16 Jan 2026 14:47:45 +1000
X-Gm-Features: AZwV_QjWLUrDHE5CjIinnkOPArog13U_MvYeZ04uhONbkYfJj77eaiRpjSPjcWk
Message-ID: <CAKmqyKOdVuCnkRi-buADd=n+qvAu++hztk_DiiQD=_uBJsxyvA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] [riscv] Fix issues found by Coverity
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>, "philmd@linaro.org" <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jan 15, 2026 at 11:01=E2=80=AFPM Djordje Todorovic
<Djordje.Todorovic@htecgroup.com> wrote:
>
> Address one comment in the first patch.
>
> Djordje Todorovic (2):
>   hw/riscv: Fix integer overflow in cm_base calculation
>   target/riscv: Fix null pointer dereference in cpu_set_exception_base

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  include/hw/riscv/cps.h | 2 +-
>  target/riscv/cpu.c     | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
>
> --
> 2.34.1

