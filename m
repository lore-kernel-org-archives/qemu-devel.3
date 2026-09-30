Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69DE2CA5FC1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:50:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBq0p-0000WL-Iu; Wed, 30 Sep 2026 04:50:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xBq0k-0000VW-Ud
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:49:59 -0400
Received: from mail-dy2-x0f.google.com ([2607:f8b0:4864:36::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1xBq0i-0002Pr-CR
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 04:49:58 -0400
Received: by mail-dy2-x0f.google.com with SMTP id
 5a478bee46e88-34b3e517e6dso815768eec.1
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 01:49:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790758194; cv=none;
 d=google.com; s=arc-20260327;
 b=nbbKmFmxQnqfDKS+vMzlHtkONSZKSzeavtakhych5AHkAS8zFOJV/y31mOWo+yX4Dm
 ZZdA8H1gDq8Gb6WJ9t9SBzQqwOBUeBhHOL1ocP3Ja+8XsxwqMHDoHZZrHCqdavhgsNaA
 avBru9IgHLkSPpf4r2cysu4+sXwnrxD3+daQW/gvLLtVvUB1tHqWgJXH819Bnc+HafY8
 jHYb5vGkJfLE41NTlcUhDB54fL66cg+y6F1r74ku3XNfJ9NO8TSArEUXSqNN6bOGGtVN
 2+xVcv5NdNq5h6wht/u1nRaVfSv1FTVkrB8/YqW3pRj+QLndkPuhMNZX/kndNvVpxjxM
 HNmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=crnh6RL7TdRyTJ0xbV1wIcboYFjhAL3YOuAutLU/cCM=;
 fh=W+KEQV3EiDjPniOsP5UsOkknsRwZHIOSW26dFzZTfyA=;
 b=jBS21pKGHU9om2YhOhFVAPCw742A6Ds4sjuwSghF/ebz4Mn87sb2Uy8Ugd7gYH6xBz
 hDuyDskREgqhTmKIGANyxJGjoTr+xXZ20JctYSX51keX8le+8MZ/XfYYmLV86rIJ+hKU
 euYQycUba2AlNBDq+gmTpxi4duOSaBY1yNsqGy2i1glBMIcqkK/JuEBycs4eNbn1gdsT
 KUsFIN7LwSbf1j0mb4SNB2LhJaZ/54H1Yzw0iCPccy5LGjM9CAqtM319beVN9FCHENyc
 yfjiYIYTHzzu4mPEHrHXk0z8X8jWxZVJ7CGxgb7fjnf2Ij8WAnU6cgCs0zUFsanIiMA4
 G8Vg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790758194; x=1791362994; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=crnh6RL7TdRyTJ0xbV1wIcboYFjhAL3YOuAutLU/cCM=;
 b=qiip053fdf8zdT4Utzaz59IgVIfoa8XscVZC4RvOCSMvTuMZHA6K4tshZvaQve1GLO
 2fVnMdYr+FNM8qzj/84OGohOCMrID5ar38GBZfeHc3yt+qFLKqWL57kpei2gkTxPxN0P
 qBVlLTMyvkHZlO9QWVgP9xIbBoayGdcu8Jvl58deiyHN2zSH4wv025bMy9ySw2EyyeN+
 eyQ4iA4nigj4vcfdrij02b5+iJ1kGylpK+9jgT8MrXaJ2Bh7Mr7fe9xQ0dI4P6GD6xxU
 LjOU7G4gwjo50DQE1Kh/mTTkGNWEcZfRUkMQlQKrmLY7H9413O7rtq4Iutmo2Ger0gTr
 c4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790758194; x=1791362994;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=crnh6RL7TdRyTJ0xbV1wIcboYFjhAL3YOuAutLU/cCM=;
 b=pV1Vp4XoGhyhX4kmFhyPiwzQBf39iUnTAAIZ7a4f9z/ykR46khZwDBmh/Qni3cAZ0T
 QOHCiUn9SqHDNRWDfcKoNfUOxRFyXYpGlPVP66CaEnUcTNCb1ywU5cUnIZomU1DeP17Q
 gd45edcLr2ZQ8ZDcknXyM6t94zHtCgJKVarP2jmo4IfVs1gPTw+ZlFlPnKa1TuNFZyCv
 qiwplbm7b23cmOgIV1g7KQbR8VGD90TP5LSs5mcuywx8qKwVNKRH24703oF5Fk9L/G0y
 zZvk0oTSC9iR6QwVkF6TX+R9T1LvmWpFpicZXYM3qqQAHnsLrCvcX8wSWcGH00mInAPV
 YZOw==
X-Gm-Message-State: AFq9FYL5SPYB3QElpX8JKtLYTvbDJwebdgWVWpWN/k1sYjHywQHr9BKj
 mALyGSCzCf4F+8pT7puSrDWR0oWiTjy+3O+d/T2TwvDDNe1T/U/HaVmC4uSE92bxzDtIrR6GZFA
 U7IbbDKyh5U9hmSth1/MPiDiGN/mhDSgiVe9s
X-Gm-Gg: AYBFou1ko0wkYrF6QZ6Xm44Irpuu86Rc29lT+mirdXFV1rs/wLFJ+kCXbW+PjZ+by9d
 mzAifQ0pqbh2gyL9o2SFUhPWw7wP3n6wQB50uvEw4gS78CGkwA7fJmYxwPfnb8w7i3/9qrcx7PI
 fZIGxy3sVUgm8sCHNPtSHCrrOmU7L9C3Xvn7eepajKeWZECT8f1IpAEMJcZhsfyyhZPh4WwKB0L
 nUCw5tAZhGCCYrO0Kv5fxchRsp1VAhZ5pq1ZXYGPxkns5CvDYycRxghBym3GWZuMSZo+u6qYEvb
 /qukRRR3zdq8IVGoVdBqDlP6q0/0ehUbUWS+OWDI6bCes3A32W7O6MISQrwoSEH/lJNaeZW65ul
 z5vhbsjER18g=
X-Received: by 2002:a05:7301:3a94:b0:339:79c9:a711 with SMTP id
 5a478bee46e88-34cdcfaaccbmr1032865eec.33.1790758194133; Wed, 30 Sep 2026
 01:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260911-query-reg-v1-0-0c04f0c02cf3@redhat.com>
In-Reply-To: <20260911-query-reg-v1-0-0c04f0c02cf3@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 30 Sep 2026 12:49:39 +0400
X-Gm-Features: AclHuK_Mu3G3eXqG-b1feIF6ZN0w9rURAjDZ6ecMuHJI04OyIf5XTn6JhGWe6eQ
Message-ID: <CAJ+F1CK_hgMdVduOt4NrMKyKcKJcBB6sdH9-B9Kfw__esNc7kw@mail.gmail.com>
Subject: Re: [PATCH 00/10] monitor/hmp: replace MonitorDef with GDB registers
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, 
 Glenn Miles <milesg@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu@processmission.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, 
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:36::f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy2-x0f.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi

On Fri, Sep 11, 2026 at 4:28=E2=80=AFPM Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Hi,
>
> HMP monitor supports printing $register expression. The lookup
> was done via GDB stub registers, and supplementary MonitorDef
> HMP-specific tables.
>
> Migrate HMP registers to use the GDB infrastructure and remove the
> legacy HMP MonitorDef. Use a "qemu-debug" register group, as they are
> aliases or synthetic registers, but gdb doesn't seem to care.
>
> Known behavioural changes on RISC-V: CSR lookup is now case-sensitive
> and vector registers now report "unkown register" instead of a
> target-specific message ("Unable to print the value of vector vreg 'v0'
> from this API")
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

ping? swap reviews?

> ---
> Marc-Andr=C3=A9 Lureau (10):
>       hmp: don't crash on invalid register
>       gdbstub: fix next register base after register gaps
>       gdbstub: set feature->base_reg for dynamic features
>       target/i386: expose segment limits via GDB
>       monitor/hmp: add CPUClass::get_pc fallback for HMP $pc
>       target/m68k: expose system registers via GDB
>       target/sparc64: expose system registers via GDB
>       target/riscv: bypass smstateen check in debugger mode
>       target/riscv: expose register aliases via GDB
>       monitor/hmp: remove legacy MonitorDef infrastructure
>
>  configs/targets/i386-softmmu.mak          |   2 +-
>  configs/targets/m68k-softmmu.mak          |   2 +-
>  configs/targets/riscv32-linux-user.mak    |   2 +-
>  configs/targets/riscv32-softmmu.mak       |   2 +-
>  configs/targets/riscv64-bsd-user.mak      |   2 +-
>  configs/targets/riscv64-linux-user.mak    |   2 +-
>  configs/targets/riscv64-softmmu.mak       |   2 +-
>  configs/targets/sparc64-softmmu.mak       |   2 +-
>  configs/targets/x86_64-softmmu.mak        |   2 +-
>  gdbstub/gdb-xml/i386-segments.xml         |  14 +++
>  gdbstub/gdb-xml/m68k-system.xml           |  32 +++++++
>  gdbstub/gdb-xml/riscv-32bit-alias.xml     | 105 ++++++++++++++++++++++
>  gdbstub/gdb-xml/riscv-32bit-fpu-alias.xml |  40 +++++++++
>  gdbstub/gdb-xml/riscv-64bit-alias.xml     | 105 ++++++++++++++++++++++
>  gdbstub/gdb-xml/riscv-64bit-fpu-alias.xml |  46 ++++++++++
>  gdbstub/gdb-xml/sparc64-system.xml        |  22 +++++
>  gdbstub/gdbstub.c                         |  14 +--
>  include/hw/core/cpu.h                     |   2 +-
>  include/hw/core/sysemu-cpu-ops.h          |  16 ----
>  include/monitor/hmp.h                     |   6 --
>  include/qemu/typedefs.h                   |   1 -
>  monitor/hmp.c                             |  52 ++---------
>  target/arm/gdbstub.c                      |   8 +-
>  target/arm/gdbstub64.c                    |  10 ++-
>  target/i386/cpu.c                         |  32 -------
>  target/i386/gdbstub.c                     |  24 +++++
>  target/m68k/cpu.c                         |  22 -----
>  target/m68k/helper.c                      |  47 ++++++++++
>  target/ppc/gdbstub.c                      |   2 +-
>  target/riscv/cpu.c                        |   1 -
>  target/riscv/gdbstub.c                    |  52 ++++++++++-
>  target/riscv/internals.h                  |   3 -
>  target/riscv/monitor.c                    | 140 ------------------------=
------
>  target/riscv/tcg/csr.c                    |   3 +-
>  target/sparc/cpu.c                        |  19 ----
>  target/sparc/gdbstub.c                    |  38 ++++++++
>  target/xtensa/cpu.c                       |   2 +-
>  37 files changed, 562 insertions(+), 314 deletions(-)
> ---
> base-commit: 209b2afaface001c7d4d981e38f186afe7b24a50
> change-id: 20260910-query-reg-80cd59cf4707
>
> Best regards,
> --
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
>

