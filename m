Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD60CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 23:09:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGQ8u-0005Id-IZ; Tue, 04 Nov 2025 18:08:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vGQ8s-0005I7-Pr
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 18:08:46 -0500
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vGQ8r-0003TZ-2Y
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 18:08:46 -0500
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b6d3effe106so959001166b.2
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 15:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762297722; x=1762902522; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6pCLJZEgcYlWw9iD4ORoR7xWg2PSQRU6gFRhviyQ6RU=;
 b=lep7H/0rGc1bfCob26K3b4ECicvgC4qe5SlTBtrMwecrhMAITCH1bRPX9mL7pAxMhh
 EzbLv9/vW5T3uLTYnBBm1mBTEYapGYb2oUk0z7NqmBBepNA3CUfXXfDNTwXR/yOOqlp7
 c99ujjxTUURoHtPCkO8Dl0Byif7RO5GWQDdSlL8foVYCPQsHdK5LUFRzWlZ6zKbOcRnW
 Jg2oa6E+QHnLEfcGVUfpxRZFZaLAsc/UYkgdRH9ktVzn1mB+oqwRJMWD1aPbmrweO5ql
 Bg/3VPE2wYWdoNV6KQMNxe628ElcfVK9z1tGy2PeMq5Qu+YA4eulaz/QaZdDD5yGAKq1
 6TUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762297722; x=1762902522;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6pCLJZEgcYlWw9iD4ORoR7xWg2PSQRU6gFRhviyQ6RU=;
 b=qrWSnS1bXPOcV2hDglAc1u4VtuY/9lNmI7pjvVv+xfGCuAZl3QqHYtawYbT4pyp0/L
 euRT519qaPZFiKUp8AIJzlhsH+z77f0oZ4Ad53KR7gMWMZ2MHtzGk6RNbvZ8EDQoQvFN
 3sQNZ5ai9+av2BwRvjKyz734iMN2k93sQGTz3/5perpNscvG12xkGloL/Orq03Ic+3iW
 yOyjnUoS52512AzVrgPvmcIQqmFkvRhG+1ya8RdykGVLuCnS8GZNrTbgVZOt68jRWHPM
 UAbkm+MUZv1AuCw1hbvTzr0JzMmVt8Lz66OJpRzm0kO7I6FxYzlPYmQpLGIbqqyraS4i
 xCLw==
X-Gm-Message-State: AOJu0YzNDgFJE1pzvFyY4x2/suz04C4Np21zzATmlDjVOIoWfcvZwxw5
 OJD6GQaVWc+E4W/xv7p0tbM2rDms7/mizrHRkn4pdZXPqmGb4Ssz8EVZbY9nGA0FIkDmsaOVJCf
 bdVCpmqo/WDU4UlLwR244oGYaFHoo8QQ=
X-Gm-Gg: ASbGncsA8YV2Nhe361vvLTv+lnmOqakjRic2BBgAWF+Sm7Q2FO7P6HQAcI/1sRU1BaF
 LlBoXg9xwNYd+0soWjRp/cCUvbmCbY1DMnAuyUPrBjLy5JMmbRFlgJZpqCJoD/LJlsORkkHpeOU
 bEGQQSK7prDjZH3A0O0g0EGcmc3hADhe+yrmIcdph3Nykfbvq9DGxnWVKjCcMX/u/u6v9m4XsDN
 mwW+xopB4BfcQjQYwTCZ4eMSWvodFzCzL26GS4BDwKvU9hdISCTjBX5miCx301Dh6vCTH6Mi1vj
 nRzqE3J8iBbCmUo=
X-Google-Smtp-Source: AGHT+IGR9WTdxWuM0ZHHHtqhW7vy8alVg+PuQj8KrA3w3kiBWA1ehja2I1G06PIIxSqIUUl0w/qjZ64xlWsCccD5poc=
X-Received: by 2002:a17:907:6ea1:b0:b71:1420:3357 with SMTP id
 a640c23a62f3a-b726554b5eemr84819066b.45.1762297722273; Tue, 04 Nov 2025
 15:08:42 -0800 (PST)
MIME-Version: 1.0
References: <20251104150708.3345289-1-djordje.todorovic@htecgroup.com>
In-Reply-To: <20251104150708.3345289-1-djordje.todorovic@htecgroup.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 5 Nov 2025 09:08:15 +1000
X-Gm-Features: AWmQ_bk99fJnp4N2O01t1o1H511gdv8d6pNwG_BXjsLF2cYpjFKmj21VhnfAHQk
Message-ID: <CAKmqyKNV9Dc5-mszwg8aFCkqLiASLZ_u+dbLLyG_59usMAL6Mw@mail.gmail.com>
Subject: Re: [PATCH v1 0/1] riscv: Update MIPS vendor id
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, 
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "philmd@linaro.org" <philmd@linaro.org>, 
 "thuth@redhat.com" <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x636.google.com
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

On Wed, Nov 5, 2025 at 1:07=E2=80=AFAM Djordje Todorovic
<Djordje.Todorovic@htecgroup.com> wrote:
>
> We have already sent patch set for introducing MIPS's
> p8700 CPU in qemu at:
>
>   https://patchew.org/QEMU/20251018154522.745788-1-djordje.todorovic@htec=
group.com/

That series was dropped as it failed to pass the CI tests:
https://patchew.org/QEMU/20251023041435.1775208-1-alistair.francis@wdc.com/

You can just include this change in a new patchset

Alistair

>
> So, this is a bugfix that should go on top of it.
>
> Djordje Todorovic (1):
>   riscv: Update MIPS vendor id
>
>  target/riscv/cpu_vendorid.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --
> 2.34.1

