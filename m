Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4A2CAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 00:58:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v32CV-0002EI-C7; Sun, 28 Sep 2025 20:57:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v32CT-0002E9-LB
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 20:57:09 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v32CN-0005fs-Ue
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 20:57:08 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-62fb48315ddso7267608a12.2
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 17:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759107418; x=1759712218; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6oYiUxuZrY/cRMxEZa49T2EtwVNjsg6dbtSfjkUPYkQ=;
 b=aJnoejcDGlqzh2eBMdJo8K77TgkmHNl9hGdRtub1qce9NVbEoAaK8TBglA2phIujb9
 zl6PmMjI+v/KChdbTObB6e2gkw5KSe9PWwx2EcmT/Pv/fvA/ki8n5PL10pXLT1U26m8L
 LQubz126O9g18/srlDkRNHf1E4E1sNeR2mx/bMzGzuldPDIiyFX09121gIK5SeS33TMn
 62qqLErjCGe6hrLg80qdzRtRQjUTWGWghFXuRNvmshXtkC4GyLcgNlbXgmnloIpNsB6R
 fm3cu6MsRcfQPPoENyXzxbVxmjuDxEkHpIXVpYhYDyTBQ2dtPQELMjTr+jmgXRd/y9KB
 VcjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759107418; x=1759712218;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6oYiUxuZrY/cRMxEZa49T2EtwVNjsg6dbtSfjkUPYkQ=;
 b=sFdNZJVi5iCyIrIirvs/gzSDpEOii++lGxdNh1KjtrQkKgnL5xjzm/gqWdU452L1Ar
 1E9jji9ML0PlxFtBpY/jJaTjNhA9CWw9L1R28afqZOmu5qgxHVuMMJ9k3tas7kUu2qep
 9cSF2gfPGzr62AArnEfMdS5IT/VuYwGaXC5hRRjD/rb+HNcI1xS61M/mSz3oBX8gI0rA
 GxncBsarg+DzGYUehRYkc+fn9MKlJY6AJGg67aDsWEPxe2pCkwe0Hiz9coLiOGSXd+w+
 0D4soCNqDoEKnzkMUINLKKL/fovsLSahmzgUdwbLM/rc7zFibqeXjYDIofmML+f6FdxS
 wdgA==
X-Gm-Message-State: AOJu0YxIuIB3jo/rCg7+x8X+L+6MXcAZyRim3yP9GfwjwUbufbVmgUzO
 zNbDJ+j5Pg6ragijCfw11Y1Mh7pJZl3cMNeGBPE+CSdhJHBmuI28lh42XCcftwkdAoLx/M9Qv0C
 ML5lHwsT0pSVCAKlM942PAh7A2pCiwJQ=
X-Gm-Gg: ASbGncuNHKGRIGQfAmikz4qN3bXNh8S1TUGv7LC+GASz2hGUVuv1XBi6J1I+ckgDg/g
 DEBTg1jiw51XgHk38k8wMBV/Lw089IDwX2rBWSVda4imfQKaEy4V79T3XGuiYmDMbhBo9hlCVe1
 Egxqu60p8YnxjXGmYxmMH6Wt7kVMFdgP6inT6PM8riGK3/ZVhbHUmkHWNdOnpFfHNq7d0/EVsp3
 RXWKqG0jXAnZ1KJnwhOFrVe0tILUqrg4cbqIQ==
X-Google-Smtp-Source: AGHT+IG1cK/dspQm0ceqpQJck58zZYXhcEvBP85WP0OJmmMedA3UoDshMW62Z6F+aTJuff7/NVzHaBCIXn048vWnGvk=
X-Received: by 2002:a17:907:1c15:b0:b32:8943:786f with SMTP id
 a640c23a62f3a-b34bd43e835mr1620484866b.58.1759107417782; Sun, 28 Sep 2025
 17:56:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250924074818.230010-1-jim.shu@sifive.com>
In-Reply-To: <20250924074818.230010-1-jim.shu@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Sep 2025 10:56:31 +1000
X-Gm-Features: AS18NWBiy7aGFuB_irdHsOzwD4jfs6u2xCjmzTAOUGlrMuDnei41NSUIkG8ScPQ
Message-ID: <CAKmqyKN9NV8TAXzTyxqKXzX-GM3t01hnAibk=OfP3Uw1Yu380w@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Minor fixes of RISC-V CFI
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x531.google.com
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

On Wed, Sep 24, 2025 at 5:50=E2=80=AFPM Jim Shu <jim.shu@sifive.com> wrote:
>
> This patch series contains several CFI fixes:
>   (1) Fix the mepc in the exception from sspopchk instruction
>   (2) Fix the exception type from SSP CSR and ssamoswap instruction
>
> Jim Shu (3):
>   target/riscv: Fix the mepc when sspopchk triggers the exception
>   target/riscv: Fix SSP CSR error handling in VU/VS mode
>   target/riscv: Fix ssamoswap error handling

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/csr.c                            |  2 +
>  target/riscv/helper.h                         |  5 ++
>  target/riscv/insn_trans/trans_rvzicfiss.c.inc |  9 ++++
>  target/riscv/op_helper.c                      | 49 +++++++++++++++++++
>  4 files changed, 65 insertions(+)
>
> --
> 2.43.0
>
>

