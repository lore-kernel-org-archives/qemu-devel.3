Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65574CD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 03:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZKbO-0006x8-5h; Mon, 15 Jun 2026 23:36:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZKbG-0006wg-B4
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 23:36:30 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZKbE-0007JK-Ge
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 23:36:30 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-68852b58d87so7125694a12.3
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 20:36:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781580987; cv=none;
 d=google.com; s=arc-20240605;
 b=eOr14xT/qD28f+o3AgiRkWDe7+Us/KXhXBqiqS5gYPZczs2uxgesFWeUU3QTjXz04o
 kRgslbJGcKibWba1AoMlbcewHjlG29ifZvi548SPox6/5AfonmltYNf3WbXoKLq3D+0r
 HFdyVroNLgKiAhYFNU4d/Hpry8/f3W1qGFIAIp7tK4L8c6sP/s9a6KUqjVJ0tjAAsDaB
 0sLnZ2KvYQfbv1+yIwngPx88CqCIQSnOi+JJIy5uSgaUdJcXz9xhuG1K6FM7fwpIq0u9
 c50RTiOafBHHIWZevPQDcGnRJNQzz3P5De+aSHrrgaTEDFNWlHLBn2IzWUHrnPGBoxqn
 oEZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=PYdHyauYmderA8Rp9+txY9RPFdvtmdE57KgE5PnKn0g=;
 fh=5zjSrN0211VqBNyWQW+pqpsjKZ6jf0TG1tkKVAMci9Q=;
 b=GR+3WAFHZuxY8AKrSLhpmiKfjnMvHk/9dSDXtKayGHBWHPhVPw9TDtQ2yzGugm8/sF
 tL8JfElB7nJyG0Aj/vJlkR5aMou1wSXNXo82pYXfCVs6pE7NXMhGHuOb0BdldIZ1BLw4
 1XwrCW+YGw1d4ttlbRW/ItJnw6OW2pXJ0L1mTdhvO8gPDHgW/SYuSZYRm5iy4HeC3ZR/
 Wd6Jte35IjN0FIR+zG21gUc6m+ItogUlaYZWc7cJ++LzR8XxY02criDTJMQA13bEiHEo
 s8wZ63KQcxNNDk4cwLoSWxCRzt+cjmRYAdaaw1Q6oQVNBIvsjPc+UX9JrqfZQXYoFbBR
 yZEQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781580987; x=1782185787; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PYdHyauYmderA8Rp9+txY9RPFdvtmdE57KgE5PnKn0g=;
 b=lrLhVvSGvvASdCV6R8O5sgiNhd4fpR2UTP4U2eJLjody4//6bTY1SCatyPSDreqDEi
 IGe+u+fqxK+06meep68q1M60m55ekuLfx5XXEysEueqPnyB4CO8ADyY6Ys23DC+H1VWN
 7VvAY2+5v/XPK7M5/GKoA+8RwoY3bk95BvdWRT9jB8WCDJ2t1EGaejOht/WHihC7TyCG
 TXBxuEE8XjB8z8ThMvtvHPRmXV63YN0DPepTJg1pcHWHon4Ya6EnTs/vCE4jBHoQp440
 mixceh/izeFzy/K5oTSgaQDvWR82SEs57cb9w4RouvAcknWIIEtVTL2JYJHmrBQgK3qP
 fi/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781580987; x=1782185787;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PYdHyauYmderA8Rp9+txY9RPFdvtmdE57KgE5PnKn0g=;
 b=NAvnMt5mgtRZ0Jiui0x+Nymut7hpg0py9B5QQ2g3ZftYuEz0vpau1PmtGOnbYMsK1R
 08PdrsUczgr40Y1nPioTSgIkKbSCy5qUOu2miJm9j1QfRbi6SXERyjkwyfH3PUrMs2xI
 xlY1XqJ3ekJVA/2Ax90mGekZ/bK/yuY5FdaBcApuOjMVS7nTnm4JcppKfdBdKnYldaGu
 7qo2w93czGJLjyOdAzQsqeYdMPqEVhHc1gv5gwjaa9sJ1tmUGfkyPdMOsLwlP9cLBWd1
 IAxGDP5DSvfaRKStA+uFYQA9M5hyaJYDfnSICrmSTJOnGWLJCtTiOMOUZ49+KF81TrYO
 qQlQ==
X-Gm-Message-State: AOJu0YyX9icLToiglkBPVuzXHIyY8VUUBxT/NAPVQ7PNYi8oV27Rb15A
 AVQAM5gzmax48z1jUjMRXtQaGZOSBYWHWj/4HmAhbNREyhsTT1KNovahvVknseHkwshYQg6zsHf
 57ZNVEObNxXnUsG4ApxStlaNbKSHEK1A=
X-Gm-Gg: Acq92OFZolw6Gjk4gBM2HE5fVk4sZrDoU2pswVNqpyW4L14HG5WkyJ/w+9w2nrKmJXS
 ags7OSTjUlIWSdXCxWESpYUdGj0rwUgqEl5FLeUDhWMqQOxAbkFgJs2elThWJF/J1tGCS9ZEL4Y
 GySAueJ3hm+WUm9+N40HfSp6PaHud+BuVUyCskDKOo4M7xbseINP8kfIDPMWM983uuQ4o1j8aNt
 2qQLejdrYOj1e8J6pJ1JA4V7krfmezNUFEL+qpZSFcv4W6f6U6P3Q4yDUl4ttuETpyAVCX9V8rL
 xK//VRoISzsSBYIUzTf4lt4FxrbMDPtociV0Hv3tvlyCmC6G
X-Received: by 2002:a05:6402:a50a:10b0:694:faab:5454 with SMTP id
 4fb4d7f45d1cf-694faab549emr964287a12.19.1781580986624; Mon, 15 Jun 2026
 20:36:26 -0700 (PDT)
MIME-Version: 1.0
References: <20260615203734.954428-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260615203734.954428-1-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 16 Jun 2026 13:36:00 +1000
X-Gm-Features: AVVi8Ccpl3BIHKowEduWCyOi17Wd-mhaPsvn-pNMM6VA6hUJAe7I034cYy6FvnI
Message-ID: <CAKmqyKOD4G5u==kr7ueyHAk-RpoqPPrefMou8_OxUbZ_go5b0A@mail.gmail.com>
Subject: Re: [PATCH 00/13] hw/riscv: FDT creation helpers
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Joel Stanley <joel@jms.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Portia Stephens <portias@oss.tenstorrent.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x530.google.com
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

On Tue, Jun 16, 2026 at 6:43=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> Salutations,
>
>
> We have a good amount of code repetition between boards, mostly because
> we copied/pasted components from one to the other across the years.  But
> now we want to upstream the RISC-V Server Platform, currently at v8 [1],
> and this topic came in the review.  This is a work I've been ducking for
> 2 years now but seems like it's time we do something about it.
>
> The patches are mostly code moving work with some design decisions
> here and there in the new helper file.  When needed I changed board code
> first to be compatible with what would be the helper (usually the code
> from 'virt', which is more modern) and then I moved stuff to a helper.
>
> The result of this series in the FDTs:
>
> - for 'virt': no changes;
> - for 'spike': the /htif node changed places with /soc;
> - for 'sifive_u': phandles values for cpu-intc changed because now we're
>   generating them (see patch 1).  Aside from that the board now has a
>   'cpu-map' subnode with cluster and core IDs;
>
>
> This is not everything -  I have a shorter follow up FDT  series ready
> to go as soon as we get this accepted.  Figured that 13 patches is
> enough for one go.
>
>
> Patches based on alistair/riscv-to-apply.next.
>
>
> [1] https://lore.kernel.org/qemu-devel/20260610214133.1882563-1-daniel.ba=
rboza@oss.qualcomm.com/
>
> Daniel Henrique Barboza (13):
>   hw/riscv/sifive_u.c: add a FDT phandle to cpu-intc
>   hw/riscv: add fdt-common helper
>   hw/riscv/numa: make numa_enabled() public
>   hw/riscv: add create_fdt_socket_memory() helper
>   hw/riscv/sifive_u.c: add intc_phandles array
>   hw/riscv/spike.c: add intc_phandles array
>   hw/riscv: add create_fdt_clint() helper
>   hw/riscv/sifive_u.c: add cpu-map, cluster and core DTs
>   hw/riscv: add fdt_create_cpu_socket_subnode() helper
>   hw/riscv: add create_fdt_socket_cpus()
>   hw/riscv/spike.c: use create_fdt_socket_cpus()
>   hw/riscv/fdt_common.c: create create_fdt_socket_cpu_internal()
>   hw/riscv: add create_fdt_socket_cpu_sifive()

Thanks!

Applied to riscv-to-apply.next

@Joel Stanley , @Nicholas Piggin , @Portia Stephens FYI

Alistair

>
>  hw/riscv/fdt-common.c         | 202 ++++++++++++++++++++++++++++++++++
>  hw/riscv/meson.build          |   1 +
>  hw/riscv/numa.c               |  20 ++--
>  hw/riscv/sifive_u.c           |  88 ++++-----------
>  hw/riscv/spike.c              | 123 ++++-----------------
>  hw/riscv/virt.c               | 182 +++++-------------------------
>  include/hw/riscv/fdt-common.h |  33 ++++++
>  include/hw/riscv/numa.h       |   8 ++
>  8 files changed, 322 insertions(+), 335 deletions(-)
>  create mode 100644 hw/riscv/fdt-common.c
>  create mode 100644 include/hw/riscv/fdt-common.h
>
> --
> 2.43.0
>
>

