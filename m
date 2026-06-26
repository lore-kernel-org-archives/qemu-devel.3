Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE4ECDE010
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 04:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcyOr-0004Mp-Jw; Fri, 26 Jun 2026 00:42:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcyOn-0004Jj-SN
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 00:42:42 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wcyOm-0002Nj-AT
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 00:42:41 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-69531108f25so933418a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 21:42:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782448959; cv=none;
 d=google.com; s=arc-20260327;
 b=j5kD8AHybBJfIa66iBu/uglHyPQ21L9+UqsbFScmF36DaNdbJ7JtXiVW9zgmNdHOzr
 FTLVOnkCfs7kXWAkZ4LevcyDEcfxGZz3ojIWJ8WYqAtrrQ5PrXlPSaYfl6AjRSxs973H
 md9ul2kpRVm6vYekIX6jZOtNDCiEAoyh4rTQ54qL79UnSoJ+lunw3VZ5mr5erJMIkU2B
 05jE3jxdsBZAhjPB9bGMrEsjnsjhXR27HniUZ7G423Hkxp8EXOGnfJSj2Iwf/hAFCmun
 DYdvtX036EfNtja/V8Oacagk6gjeCbXnsOl6voIwbE4e4Fyn7Jx9VA/304FSOq8b4vg5
 Zhuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=YgUtXqNn5UCD0dFZ+zBsrLNWHo7j6OwA5fqXZ0ecAJU=;
 fh=2s0MttjKBC7//6BVZfOXp5B7TsNCE9/dD5tTB67EQLU=;
 b=svlIerQOV4NoK+0Fj2Bs0V8sciTHm5Hh1sPo9goculkEEmY86cPecBljBtqJ8Hig4/
 Yng6bAWTPep0RjHpNT3oOJl5qHnfG+6hfj83cbFQJSitVwjDeULhw+PF56hwwAnwDYBx
 sXrERPutjxWtft9NG/MW9g1UUEyZFjAe0j9/8FYpiWdKYbfON+pPDfkqo6T39BUl9uZW
 120RwXqDDCgxBDpGG8YXtSoizSj5Z3LPQDDzy4t8uimDHzL8h4obzBcjhLIjGLMNUN2L
 nepOFOSe79I6+0x09zPaIrXF0KuzuDu8cQZO2ZbjKmyMusXNdDz/J50mK0S3Ij5/VW39
 JbPw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782448959; x=1783053759; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YgUtXqNn5UCD0dFZ+zBsrLNWHo7j6OwA5fqXZ0ecAJU=;
 b=l/EcMb3O7FcNWADYEt0j8m+qmEYI1w0uUi1tJg0ts0fw96f6Ji03sSTfVdJ7Hnzvtq
 lCHLQvEE2Th97TXZudswgdPI5cYukeY8h3eTL+fsNWuNnOgnigA192Rw9eihI0n8KVgP
 lA7pVDQ8+XRK1l/P+8/ocVVC7OAUHDV33vHtibmdrnDVkqL7mN+joo86lE7dDAUFpvMV
 +Vs5HEkh9J5wSQIxv4p/Mw9t43in90fdHnaqhXjPUU3RMpiFgXdLfMNF3PsWr1s8htPZ
 EN7UE4hH14zZi/h+IzbYMIc8aW4v62TbaSWA/gKVxbtfAD7Rub9npGY2j+9/U/R3jYXV
 5l+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782448959; x=1783053759;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YgUtXqNn5UCD0dFZ+zBsrLNWHo7j6OwA5fqXZ0ecAJU=;
 b=MqxRr+dZaF4kQefg39x5QOgdVsah/fisgK/onSU41K2UDhMGgkrhhSrlYstisbIuHv
 q2odOyHKNZduFH9pc2nYMIoVA70eXpFi7dN5ahOJT7dVOcLef2omhd1pVUAzCjbKSsgo
 lqTAfZTNfLfMSWoVtvRFjnu/dSq7/+R4NJbkFhEsUc2r+oKhxaNJqsMC9TeLpqmeBdZN
 7gyLnoHbMPwL3aXBVq7SVXxF/IFYRD0C3uJ3C4jtixHDZLBk9FFkQGKu9OMmpi0wC9op
 RmCtxkQ30krp+knin/Y9tCS/u7yRw0E6LuAbmIhkpvj8AUHXZmhn828T2nPYHk6UYQZ6
 MbUw==
X-Gm-Message-State: AOJu0YwxYMvQCH61ysOUOngyCCI5BjxqE3zMEbm+ddLxRcZO4uUllsAA
 Mze/XPgMINuQyWqfVzHA4hTs0U2ryHiy5hCXEdEuO1yE/E9SVdrTm6joyUj00trwfT3AR0abAUj
 2PlqAXOPJ9PYw/GLFy6Ghu59Y1xkIy8Y=
X-Gm-Gg: AfdE7cmQ+mFLbmKnCnuIsK1iLBp8t1W6qaUjz5bpOPfLmTIMipYR5zC1jRJM/ocb+IP
 2W3xI80LNkWR5gHQ2XiNG/LVffDH1jP968LeYYUWx6vYi8cpB9usRWD195AFffFoKB8Rdbt1ufw
 ajFUaO/jsqNCq5Abf3Ioe5Kk/HZXDe0J30DMhuyh+YOlf25SIYBHovUpxgyk2sYejIgK5wtVR7q
 Sv9kwZIDIsJXlEdIMgUW/LcJzcmyRTXmO9tO++C55f2NttgHAgAM5ELbkeFvGJkPZFhyQag7CoC
 7DfotRjbEjX+1nygSUFa5xmCzatZ5vapMJKrDQ==
X-Received: by 2002:a05:6402:254e:b0:697:ee73:386d with SMTP id
 4fb4d7f45d1cf-69810b60d79mr1130107a12.17.1782448958508; Thu, 25 Jun 2026
 21:42:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260625210833.3294437-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260625210833.3294437-1-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 26 Jun 2026 14:42:11 +1000
X-Gm-Features: AVVi8CcTm76-40JVciQA92N6dGHHvc6Nnsl8teDObFsoLkQhja312ips0xMeMug
Message-ID: <CAKmqyKNNXAX4itYHg5fkeahHDBWJfEfJsYf8BU68x4oJ+rLm+Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] hw/riscv/riscv-iommu: gitlab3576 fix
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 andrew.jones@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52e.google.com
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

On Fri, Jun 26, 2026 at 7:09=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Hi,
>
> Here's a somewhat trivial fix for gitlab3576.  Patch 1 is something I
> decided to send because I got misled by regs_rw.
>
>
> Daniel Henrique Barboza (2):
>   hw/riscv/riscv-iommu: rename regs_rw to regs
>   hw/riscv/riscv-iommu.c: make FCTL.BE read only 0

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  hw/riscv/riscv-iommu-hpm.c |  4 ++--
>  hw/riscv/riscv-iommu.c     | 40 ++++++++++++++++++++------------------
>  hw/riscv/riscv-iommu.h     | 26 ++++++++++++++-----------
>  3 files changed, 38 insertions(+), 32 deletions(-)
>
> --
> 2.43.0
>
>

