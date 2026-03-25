Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2E93FEA806
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 03:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5FOr-0005YV-6s; Tue, 24 Mar 2026 23:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w5FOo-0005Xy-Mt
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 23:59:19 -0400
Received: from mail-dy1-x1343.google.com ([2607:f8b0:4864:20::1343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1w5FOm-0005bu-TP
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 23:59:18 -0400
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-2c1092cc08cso2375631eec.1
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 20:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774411155; x=1775015955; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JKZ3aR5oG3y+Q1Wf77NOEkfmQBq93FXXnxwyNr0Wy+k=;
 b=B74JsX/UR7/hYatXU/8dfDwzuoeZqVQe+svwe5jd2jcJBAsWwR68vctMLGICYKJSs4
 95WozFlvVq9L+Hj0XFQPaXvs51fAIbIEluyNEhyqj9IAs+TKLWxk/KDDzDZ1HIGH8LQ2
 nSiqLRetJGV7NCC2euZcLR5htiiCM+p7kFZQdBdwtYmUGFoI23Tp2c0mMPKCitGyf62Z
 6uKCawc4G5OAZUAzIfwAYS6J+dTJxu/ejsJI8NTgB7gTqJA1x11SFWacfzcK/dV6Ynmb
 r35swW+StH3j2WzfSyUXS3nnHC5932MUdpOexN7k4/nwcTH6K1fe+DQYIoqzdJCZ/TqV
 OPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774411155; x=1775015955;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JKZ3aR5oG3y+Q1Wf77NOEkfmQBq93FXXnxwyNr0Wy+k=;
 b=IToPW7taJWDjho5Q8e8WyR/oOhWWWZvqbwe4N20mAugKOTxukEqVGqzO93vguAob1W
 glsPSHzg7FdwCCRSawnHmQYq5ekelfvZMdwxezXFt0CxMRaIweVvkwdfBlqIEaJRipTO
 5apw60hYzyYseESJWxHOxBCcAfyTWHVMe+NlDXoLvJzMd+fYF4NwL5Ev35HzW5g7xKkX
 fKzz4tRtQjr/zS1CdXiqaNB3+v/1eyYulC6xfPsyvbGq+vbr9KKFH8K84TRdjl+43foP
 vQWveY0QjygMKzW6Y27KT5eeTnB2Lmp8Ri5Je+bDS0gjOikmaENBQ2hirUWDZgePC7Mm
 nmIw==
X-Gm-Message-State: AOJu0YwRFKC+4dqhj+cWZO77fZ4No9vtJ5H47nklwDpxWlLAD0YhgHpz
 DxKV437mr7jwJpSZhB7ZCSoDSJat14UKFBEWsgG4nwfUzsugyA/skwL7
X-Gm-Gg: ATEYQzwIdb/5CgG01Gl7P2OgRHAEHYaUoLBQjHYZTLQSESMfu4/eEOZWc7f5IX1TkjK
 N3ThP1YpqtdYwsK1OXm6X7YF852vm8n00MryvwRVlzhJNAGmtVkpVb25WtUAks7rHnneaMfZGOr
 P55HZ4ihnM8w8j/NTlWJvE1LVyrPpncOC24b33M1VNotwJXQDhmAZU3vSRUm56yKcLWHFZ8n5Ua
 Z6Cw6XhUevG7C5UciAsXhLVGNJWwMK28N1ydC5lzCtHkaixu4ShvB+sS+iCaisOmM9n7ZdOh9sk
 uUbp7uCjkrqCSzdWjROjuAOcfyqZ5XHuLMy6kuL/viybs+MK3kZz44FkppjDpjP7hFTl1yWZpSs
 jCVlT2di964pFO/cPYPfdEeMHBQQTYQQD4sWWns67iDpcmFlUgee8Qd1fCrDTuu5NZcPeyCBowY
 jwSrrb071x8c9e4Cm/bejLKQhM5+qZCuPitB55LlXdA0eTeHojAvQRNbe1JwEnHlMTddryQU1Wl
 19kLtgoyA7F/YvXhsWph78D6w+Mm9k=
X-Received: by 2002:a05:7300:148f:b0:2be:2cfe:68b7 with SMTP id
 5a478bee46e88-2c15d36146dmr911552eec.11.1774411155359; 
 Tue, 24 Mar 2026 20:59:15 -0700 (PDT)
Received: from ZEVORN-PC.localdomain ([38.95.120.198])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b17d1ddsm16775894eec.11.2026.03.24.20.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 20:59:14 -0700 (PDT)
Date: Wed, 25 Mar 2026 11:58:54 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, "cfu@mips.com" <cfu@mips.com>,
 "mst@redhat.com" <mst@redhat.com>, 
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>, 
 "philmd@linaro.org" <philmd@linaro.org>,
 "alistair23@gmail.com" <alistair23@gmail.com>, 
 "thuth@redhat.com" <thuth@redhat.com>
Subject: Re: [PATCH v5 0/7] Add RISC-V big-endian target support
Message-ID: <acNc-7Ky29tqG7-C@ZEVORN-PC.localdomain>
References: <20260324164007.549397-1-djordje.todorovic@htecgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324164007.549397-1-djordje.todorovic@htecgroup.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1343;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1343.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi Djordje,

On Tue, Mar 24, 2026 at 04:40:14PM +0000, Djordje Todorovic wrote:
> Adding functional test case for riscv big-endian.
> 
Thanks for the v5 and for adding the functional test
that Philippe requested. The runtime big-endian approach
is the right direction.

However, it looks like the series was developed on top
of Philippe's "[PATCH-for-11.1] target/riscv: Forbid to
use legacy native endianness API" prep series, which
hasn't been merged yet. This causes two build-breaking
issues and apply failures on both master and
riscv-to-apply.next.

For v6, I'd suggest either:
a) Explicitly declare "Based-on:" Philippe's prep
   series, or

b) Include the prerequisite changes (MSTATUS defines,
   op_helper.c cleanup, MO_TE->MO_LE) in this series.

Thanks,
Chao
> Djordje Todorovic (7):
>   target/riscv: Add big-endian CPU property
>   target/riscv: Set endianness MSTATUS bits at CPU reset
>   target/riscv: Implement runtime data endianness via MSTATUS bits
>   hw/riscv: Make boot code endianness-aware at runtime
>   target/riscv: Fix page table walk endianness for big-endian harts
>   target/riscv: Support runtime endianness in virtio via sysemu callback
>   target/riscv: Add test for RISC-V BE
> 
>  hw/riscv/boot.c                            | 82 ++++++++++++++++++----
>  include/hw/riscv/boot.h                    |  2 +
>  target/riscv/cpu.c                         | 22 ++++--
>  target/riscv/cpu.h                         | 28 ++++++++
>  target/riscv/cpu_cfg_fields.h.inc          |  1 +
>  target/riscv/cpu_helper.c                  | 28 ++++++--
>  target/riscv/internals.h                   |  9 +--
>  target/riscv/tcg/tcg-cpu.c                 |  9 ++-
>  target/riscv/translate.c                   | 12 ++--
>  tests/functional/riscv64/meson.build       |  1 +
>  tests/functional/riscv64/test_bigendian.py | 57 +++++++++++++++
>  11 files changed, 211 insertions(+), 40 deletions(-)
>  create mode 100644 tests/functional/riscv64/test_bigendian.py
> 
> -- 
> 2.34.1

