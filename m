Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C37CD6E5D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 00:43:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUZgk-00007c-VU; Tue, 02 Jun 2026 20:42:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wUZgg-00006k-Q6
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 20:42:28 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wUZgf-0003Uo-7d
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 20:42:26 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-bebc80100efso386360266b.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 17:42:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780447344; cv=none;
 d=google.com; s=arc-20240605;
 b=UvS+OqFn1QwI+KdkorCy8bdG9+G3aXgmNw9/iGwvtAtGXJdg5dRLDXWjj/k6Uj+xBJ
 H0Q2E4bXFPUUnrgz4uqr8ZoHDbaNgmFxvccIHUT0NSHCbsS08zC9IpJtk7ZHqOUelPh6
 jOagf+KJ3T5ySwHfn3OqwfuLHDBipxZaMjHXdr66YR3/k6ptTfXKj7jVz5DvtK8sbxXx
 7j0Jp7ystDIAOXlLkMTot0670VehEfrNllMBQuT5udJmxBMjlzRsIRfIS6/lxgrsIKf0
 gMZn6Bsq5/0xitRROl6zZla0Y0WMRB+8TsUwO3RoDesiVrIEVR+Kz+k7L5MGjaBUOFGW
 h12Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dYLOQEEK9SlB+I4AbXytkiWykJ8Oikpc/Uw3zoytCc0=;
 fh=fx/r/twi0lR0VsLAVqPkirIE7VN6h63K7UWTunhhuts=;
 b=LtuPZw/2GGTppoT6JnDOOxhRuAft0hEgghWBQb3EoXEPjLEWyPRdXo5QfC7vAQ/ZbV
 6fjegHvRD9F9ZNeWJz9/Lw4Dwe/Dlmw7TIT6h3MJHejdCJIpnWvYGI/7ZGYnn6VxsGPu
 uzXP1cgKaHWBeDLzKjYVtXYv2qdebilS73R6K34o3PkvKYi0o0JVOSh4ZB8Vr6LQrrp0
 +o5X7Og6YKvMsFmsujJm2R6mGLTJr/G63+3jD3nUXKMNmuPaxNJ2esPnx742vh5gk2/E
 BOGqfSUIZUovicA3ZE8LncaWd7H0GsjhX/+6H5iR7dXg1LEy7MvitIQxpp3erkvvGXCm
 JcxQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780447344; x=1781052144; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dYLOQEEK9SlB+I4AbXytkiWykJ8Oikpc/Uw3zoytCc0=;
 b=rVhVGqkkvT2Pp5bVKoovgIvYdUVVIdLR/WuIKvPJ6zqjQum/6U8JoU7dd1S6UCrOrF
 bQT7joP2sHm4V+pn6JKD3eYezU2YGHp+zqS10i3UtyFCv+ZMrUIfh129HlaFjDwQOn7k
 N4Gq95xBYmrUJirDo5Dmnub+v2nplbp/9SV2NL8DMvXEBGEFky4N4nlS3YFOmTArmtlt
 wryKjd3r/pVXdGNNjoVh2e7AZ82xY+AWsu17AOiUgpffspgk4w9bgl4cLJBGRd1CPNxy
 GZ7XI4G0G00L7qybPfa5wLI6dAhFsBiQvaK+ZAPO17YSSH7b19R/+zh47Mioi15MrFZx
 VUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780447344; x=1781052144;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dYLOQEEK9SlB+I4AbXytkiWykJ8Oikpc/Uw3zoytCc0=;
 b=B+yshEwAPMXaNJMgCS01vo8dRUosTS6utnnBufBuKSYkvQr6dWKKuP46ZIazZmP+OZ
 u1Ji5B6ZbRwxWNaXEL0+nv0qRwx+Tp/R9eFXlLRjFuLtFzEI1KWoSvq/ga9LpfUw3wmr
 5VzTODxcGapSsOGVmD/kmoocIdqjCSGI0Dld66a06cCHQjvCS3tMOMz4RyWyptUwioLu
 rQi81X4F0wEpB63mywgjyBOzvWwni/xyGGc9CvzjH+YvX1yyB9WQ2fcqsv3Uu8TiJ8IA
 NPKjqQWe2qQSVL936WWuCQt4VxdCpvAQgVZoJdY9Ojg89p09rxIjjIwsTyeN86W+C3yY
 MWtw==
X-Gm-Message-State: AOJu0YzN/subY11qmioFI1hpNUGQvt3+sIiQJlrg0uJ/jFoOMZgnCAMk
 HPHFsqxKHdBcPpKBpRZvX2we3rcT3Z2eLayY19ZeMG8q7s8HUOq+I/JF5hDNwW7J0BxdOiBsWAq
 4sRxv+geEECg6bMKmzrqUQm7vg2zmtes=
X-Gm-Gg: Acq92OF1cImE5W42fnRlSHKdvCI+2ITlJVsuDdSbER6PAvlz84bFa5cB+9CcWxgxCTR
 cvI8a37oAyHot+Un8WJWcg2wcVAUUFckx8J0IOeZdBUuY05a//20VvzEQ+mEpb1nxNM2qe4+RUh
 LCc0CC+y73BZbnOJwyTzq/6DBiUNMSSFDEHi/mqQhQaUK/3Gk6hB649f6lx3064JB7aTjMNro3R
 b9Hv+NsuRfGQek8NsCk2sM76/p47EtoK7+IlCAnEu9/k5490oCRm8y5ihHx3FxyaosjYMc+2Hbt
 vgZMUzS9/U0DQ7fBKwQHe/6iJwyMazFK/y2yzsPaxfQo8Rym
X-Received: by 2002:a17:907:9446:b0:beb:bf23:ac78 with SMTP id
 a640c23a62f3a-bf0af9fb89cmr31746566b.44.1780447343457; Tue, 02 Jun 2026
 17:42:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260528054213.678458-1-frank.chang@sifive.com>
In-Reply-To: <20260528054213.678458-1-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jun 2026 10:41:57 +1000
X-Gm-Features: AVHnY4IKvVCf21hG50UGzHAoPKdheIhX8Zz2EDvxf6t3FZm66T_I7UOOBF9DhIM
Message-ID: <CAKmqyKPywAKDrKKnVsNKvPpzCz09+La5Ec6zFawN2qwmAf9foQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] target/riscv: Add the implied rules for G and B
 extensions
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x629.google.com
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

On Thu, May 28, 2026 at 3:43=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> Add the implied rules for G and B extensions to enable the implied
> extensions.
>
> Changelog:
>   v4: Add 'target/riscv' to cover-letter subject prefix.
>
>   v3: Keep riscv_cpu_validate_g() and riscv_cpu_validate_b() but remove
>       the auto-enables as the implied extensions can be enabled by the
>       implied rules.
>
>   v2: Remove riscv_cpu_validate_g() and riscv_cpu_validate_b() as the
>       implied extensions can be enabled by the implied rules.
>
> Frank Chang (1):
>   target/riscv: Add standard B extension implied rule
>
> Jim Shu (1):
>   target/riscv: Add the implied rule for G extension

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu.c         | 26 ++++++++++++++++++++++++-
>  target/riscv/tcg/tcg-cpu.c | 39 +++++++-------------------------------
>  2 files changed, 32 insertions(+), 33 deletions(-)
>
> --
> 2.43.0
>
>

