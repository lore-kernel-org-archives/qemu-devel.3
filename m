Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA61F433D6
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 02:36:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDCan-0004vw-42; Wed, 15 Apr 2026 22:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDCai-0004vO-GN
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 22:36:29 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDCag-0001WD-Up
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 22:36:28 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-b980785a0bfso997464266b.3
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 19:36:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776306985; cv=none;
 d=google.com; s=arc-20240605;
 b=dhUeg2SLWAvTET2O9MkhtTZ1SAnLHA3/ZEzSnDD41sRw9WSMjp8O4X9iWZwJgYOIYP
 NbZ1WgP8m1EqwN8HyaDRzYcXStTcsnYqN+t1ZD7D2/Wv+JUEDrKXp8f8jo/DckUdgeRz
 00mhSRPZQycdsaDdOldMYnByMWBY95v2nEJaITukdZcat6/sZN/KCl/cRQSetpH2xCZG
 vlNdXJ3u2GwE/KzeHUVvGvMuf6AfaPe6qkyeOOi7CcgXVUhD0m31ABVLjakmH++KcW13
 TGNUYOne6TRmzoLGkgI4wNZC17EoYPW0q4qCU3kSib17ad+OSMfMd6AkKiAtikTAn4cy
 zTsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=fSeyPzgZLJzu7J7MSxzWDtUOk4T2bmV2CC+Y96QE7pQ=;
 fh=GCRks4vpyHw7hr9QjWzE3NT3L/qVPRN3EycfGThFU4Y=;
 b=kXPQEhcOiZqwmTUTNgaYVL7ZyP43QWA5ehNxkwsZigrUNzQVFd14BQw+TFI7u5u0he
 kXFUqCycp1tSg7uVjeF0o1+OrS4GX9Ys2UVD6LFwiVTQEcQ+S0nRb64df0bP94sXbO6X
 xaMlvDvyVmXYzrwrZCtAMEK7Iz6j2FldImMLJV5LUakJ9K9B18FPL2uaz0AYgqA6Dz7G
 zQufiMwztWq3SS9tsgkSRzbirKjoD+XCVzJSCzYYf43B0auLcGkeRR2gozh4Jnz1QPJd
 cRdemnN5dksI3U/zv4lT+7f5DH8ipNid8S1tmrP97vPFw2oEiBANsikZXPYnhfPEMxXl
 wckA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776306985; x=1776911785; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fSeyPzgZLJzu7J7MSxzWDtUOk4T2bmV2CC+Y96QE7pQ=;
 b=eAXCx+lsitvsION9I3yaS7Bs20LvlAX5s8wydqNL16M5dsywaQxKVh0yx5N8REQ8yq
 QMtgE9B9CwJGIhftjp3TiHSahQrWCahpFwhPVDYAXGOxf/E+yQoKibrfo2KaLEhZvK07
 N11CzXOwqi1n3uslM/IZ+dm96nExDVh+pdpgqQ6J5Ddyxi/lSAyq1bmGItisa7qOmMXk
 Qn8wb+l4ugbhyAkb9LAxX9eTgP5+buw4Sz/iqD7XjWnPOEiBVw9ONgFpAMGaZ8JnSX/K
 MJmT0YvmfNxq0GZfO1PNdsu+cRhlFphQPbCH7CdXC9dK1oaySA6QxtT0sSFQYD6T5ZmN
 Yk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776306985; x=1776911785;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fSeyPzgZLJzu7J7MSxzWDtUOk4T2bmV2CC+Y96QE7pQ=;
 b=FEJzc3oF8Cv+FkSgxpfl5AAkRwhyB/30DlSgpVCi17ql1Y8e7sGQdaWzvL8NKEFs1y
 iPRwgg2VVmZoaX0H41zivHg9dW5MGren9pfFI2kKFooRfXyyhPYQbfFXyxjfXHmU7JLK
 h6Z9Nd5zmCGjBlpbV01AFrDcq1ZXOGgVlqyxkAjqsJOoaDK3yixcslOYDVHnY2ME3zv5
 48BAG5m4ry/XjZioRs3cNBDHfzeWPY0D4CeLz49G6qqab1KZsCsTrxvY65icOQ617jE8
 dqzScyGbn9paEJGKHouR1ebUI80uaI5Uq5lxHOTd2TOKctoZ4nNgyBHGpAp8c482gYdM
 b5BQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/W8z2yRa+gA/miCPGfbE6naTuX+F2sQgPbFfuSuPTLx7fIYxyu8ln6nOPCIHaHLPuebNfdY+toCCRp@nongnu.org
X-Gm-Message-State: AOJu0YxfAM6eCxjl61+qP47yicZvt4m+u1zxFQ8fhL2O2TB7kra+lJq3
 /pgX1RcLxHzd7gHV4A+1JOxY0I+kl/J0dfgNAkWy9v5y+EWIOEO3iqJ/inKSGbA2DhZcwvK0Y1x
 vXVq5XB78/42i2AkJtWbUiv26QnfEG+c=
X-Gm-Gg: AeBDieu9YWyPDweB08iUhenTejKnyEw+VyS/T/Z4+FfH8YgDcpS9eL9Nw1lHbQSDLZm
 M4QvWJWggu6W5gLWzGZycHoxwotN4UczNXkyFEytlEIb6Y7ZXSZL/BYnJJOCwvn9vtl0+wSadD0
 n13ZG+HDLsmqQMvnVsqQ4P2B61Oz1obfnvytY+f4KrMUrUDDiPCt6Ii1Zj3uPaqrA/4aq5iXDyg
 OprPRrUdMJNp6ZYn+n4739u8G1iskmopPYDFfGlZuF2bVTYWlN7diJtTpCWGneEqoGL1CkPhusN
 cFBvOf38Zlw1PmPzZUhB/gJf7JcH2UFD8VVRZw==
X-Received: by 2002:a17:907:9608:b0:b9c:b88c:6364 with SMTP id
 a640c23a62f3a-b9d7249921cmr1282588866b.22.1776306985360; Wed, 15 Apr 2026
 19:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20260412012501.1808602-1-chao.liu.zevorn@gmail.com>
In-Reply-To: <20260412012501.1808602-1-chao.liu.zevorn@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 Apr 2026 12:35:59 +1000
X-Gm-Features: AQROBzDJkl-tL-ot41uPUIdUjnVQ2_7AR50MfQfB-oRBBGujnFAH2Glpjdjabj0
Message-ID: <CAKmqyKP9k5ku8hfNbq=4XxPrukAn0Php_QyZuero=MEHVtd0BA@mail.gmail.com>
Subject: Re: [PATCH v1] tests/data/acpi: Update SPCR golden-ref for RISC-V virt
To: Chao Liu <chao.liu.zevorn@gmail.com>, 
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-devel@nongnu.org, qemu-riscv@nongnu.org, tangtao1634@phytium.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62e.google.com
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

On Sun, Apr 12, 2026 at 11:25=E2=80=AFAM Chao Liu <chao.liu.zevorn@gmail.co=
m> wrote:
>
> Update the expected SPCR binary to match the corrected field
> sequence after the Terminal Type and Language fields were swapped
> back to their proper order.
>
> This fixes the qtest-riscv64/bios-tables-test CI failure:
>   https://gitlab.com/TaoTang/qemu/-/jobs/13879552268
>
> Fixes: 977c6fefcd04 ("hw/acpi: correct field sequence in SPCR table")
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Tested-by: Tao Tang <tangtao1634@phytium.com.cn>

Thanks for the fix!

Do you guys (Heinrich and Chao) mind if I squash this with "hw/acpi:
correct field sequence in SPCR table"? They are both in my tree and if
I can squash them then it keeps the tree bisectable

Alistair

> ---
>  tests/data/acpi/riscv64/virt/SPCR | Bin 90 -> 90 bytes
>  1 file changed, 0 insertions(+), 0 deletions(-)
>
> diff --git a/tests/data/acpi/riscv64/virt/SPCR b/tests/data/acpi/riscv64/=
virt/SPCR
> index 09617f8793a6f7b1f08172f735b58aa748671540..59d2c8f7f215a604612cbd029=
4c18bc6301e208a 100644
> GIT binary patch
> delta 10
> Rcma!wnqbGo%rMbG3IGpM0&@TW
>
> delta 10
> Rcma!wnqbGoz&z1G3IGpJ0&@TW
>
> --
> 2.53.0
>
>

