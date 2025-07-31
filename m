Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 814ECC87FCA
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 04:38:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhL2Z-0004l3-W0; Thu, 31 Jul 2025 00:37:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uhL2X-0004ha-5Q
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 00:37:13 -0400
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uhL2V-0002Wt-Cc
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 00:37:12 -0400
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-531b4407cfbso190559e0c.1
 for <qemu-devel@nongnu.org>; Wed, 30 Jul 2025 21:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753936630; x=1754541430; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z69gNnA6zZAM3vx/VPpSPaZAUF0qCKK4Z6h469vVM/U=;
 b=hC556qZNzkojM3i/1wkuclXZetDpi/WJnfUnPl+MXIUfnHg0FjLSsbHoBpFK6q/v7p
 NKB9mIHHrsTvDEZSS6YPssu0jqA2T+E/f2HfFf+yVusv9VLmThA2Scz6QbKVHuh8t5uh
 VnCDQLqCf3Y7ZlJAnWwt4ZV/IKLRoj11QB+NQGS0TlmwyrvqhKYWaedUiDt+AWBy0R0G
 tZ+5hAa/AZxq923tP0Z6FMCVS7JCi0sdEZ6a3UtmDLGwYdIntB51X3TVb3lAGYn/zO8R
 s5IMKS7CZMMIpilIIhH+GoqRUnHZBiwP4mDuW7vKILKDV1nle7eZxjkkyicQxq0SrMF5
 +O3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753936630; x=1754541430;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z69gNnA6zZAM3vx/VPpSPaZAUF0qCKK4Z6h469vVM/U=;
 b=uGMrT34p4DQjMjb4L+k6jCNB/BIVywrNaT8Lr9lhCRpQwvQWtJi8rwO28kA/F4Ao1X
 z5VkWtKuMyOROSTzBmLh6L4VANfESWzuxrOjynMtuzOGqi2tw2pGjqnt1TEHSyr/z+Pl
 SgpJm8ZWovZzYoLgB3Wx3NMj6Oibcj4SxXg0vmX9iQTN1TnnxuMiXu51a4K4q0ufmDOK
 mr8s8J648h9Or8y2UlsCqS6Zf3rW2e52kSi+DTIusO61pKNnCemvAGsSx03eC7tAZ8t1
 CQNm0Cf84hj6CISU9eN1kNYPzTKpC5K89J6uKaPavJF7Tls8L42d4m6q/jjfuXuSy1We
 wVFA==
X-Gm-Message-State: AOJu0Ywaqp3yHpx8HqvFjdLr9/gXJ5NPrJD02Wo+xZD485HdFxDzPuJH
 glROWhlsdI9T0GlZciaWjGv9ViaAownW5yOvA17TNen4izqxzazHS+A6Oh/59fi8PLkdCGVfpYJ
 MQz2dH8X0kbaEthoNfdeyfFWvQRgR9n2Zfsmd
X-Gm-Gg: ASbGncub/Tgtb0u5hHoaDLgE/yPmrw2jsyFJSMcEW65/3IQvqMWQbvsnVNDxpG62Y4q
 IXFQnJyxWvUnRqbnHvAh/35f1zCvtgiwEKGFQk8wf8zEcg4UGqWhCk1Yvm3OKjhzJmihpIYh5N9
 NGdEFPWUQnDrS/enNz+qNwq38kcviVTx/KgMGOtJGehqtjQGMhy1FIe9WmCcd0VbEMBsUgxiP6I
 uo9kpe15oFqPutQUFPp0HTzOAu2bdXItNNOUA==
X-Google-Smtp-Source: AGHT+IErFGjAUo+ARavlw1Qc7TpHf9RTkACP0PAIbNVk/1nNPXFQ5fL0iqGd9mj8GQAeTc7c+l1/coxpoRO1h1NnQQ0=
X-Received: by 2002:a05:6102:570a:b0:4e7:3d55:5212 with SMTP id
 ada2fe7eead31-4fbe7f6d47dmr3584987137.11.1753936629544; Wed, 30 Jul 2025
 21:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250730010122.4193496-1-alistair.francis@wdc.com>
 <e4578b16-a23e-4e56-ac72-3e65b8fbae53@tls.msk.ru>
In-Reply-To: <e4578b16-a23e-4e56-ac72-3e65b8fbae53@tls.msk.ru>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 31 Jul 2025 14:36:43 +1000
X-Gm-Features: Ac12FXwlmJhFkYCYUbKiswsoM6mxS70S3XagKYH4e03beRx_LG5WTqeu1dWvp0A
Message-ID: <CAKmqyKN9mnd16FCJhEUoVAbHz1++-C2MmFG_ocT+aidj=9SuiQ@mail.gmail.com>
Subject: Re: [PULL 00/11] riscv-to-apply queue
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
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

On Thu, Jul 31, 2025 at 4:20=E2=80=AFAM Michael Tokarev <mjt@tls.msk.ru> wr=
ote:
>
> On 30.07.2025 04:01, alistair23@gmail.com wrote:
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > The following changes since commit 9b80226ece693197af8a981b424391b68b5b=
c38e:
> >
> >    Update version for the v10.1.0-rc1 release (2025-07-29 13:00:41 -040=
0)
> >
> > are available in the Git repository at:
> >
> >    https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-2025=
0730-2
> >
> > for you to fetch changes up to 86bc3a0abf10072081cddd8dff25aa72c60e67b8=
:
> >
> >    target/riscv: Restrict midelegh access to S-mode harts (2025-07-30 1=
0:59:26 +1000)
> >
> > ----------------------------------------------------------------
> > Third RISC-V PR for 10.1
> >
> > * Fix pmp range wraparound on zero
> > * Update FADT and MADT versions in ACPI tables
> > * Fix target register read when source is inactive
> > * Add riscv_hwprobe entry to linux-user strace list
> > * Do not call GETPC() in check_ret_from_m_mode()
> > * Revert "Generate strided vector loads/stores with tcg nodes."
> > * Fix exception type when VU accesses supervisor CSRs
> > * Restrict mideleg/medeleg/medelegh access to S-mode harts
> > * Restrict midelegh access to S-mode harts
> >
> > ----------------------------------------------------------------
> > Daniel Henrique Barboza (3):
> >        linux-user/strace.list: add riscv_hwprobe entry
> >        target/riscv: do not call GETPC() in check_ret_from_m_mode()
> >        riscv: Revert "Generate strided vector loads/stores with tcg nod=
es."
> >
> > Jay Chang (2):
> >        target/riscv: Restrict mideleg/medeleg/medelegh access to S-mode=
 harts
> >        target/riscv: Restrict midelegh access to S-mode harts
> >
> > Sunil V L (3):
> >        bios-tables-test-allowed-diff.h: Allow RISC-V FADT and MADT chan=
ges
> >        hw/riscv/virt-acpi-build.c: Update FADT and MADT versions
> >        tests/data/acpi/riscv64: Update expected FADT and MADT
> >
> > Vac Chen (1):
> >        target/riscv: Fix pmp range wraparound on zero
> >
> > Xu Lu (1):
> >        target/riscv: Fix exception type when VU accesses supervisor CSR=
s
> >
> > Yang Jialong (1):
> >        intc/riscv_aplic: Fix target register read when source is inacti=
ve
>
> Is there anything there for qemu-stable?

Urgh, sorry I forgot to CC qemu-stable.

>
> It looks like "Fix exception type when VU accesses supervisor CSRs" is a
> good candidate, maybe "Fix pmp range wraparound on zero" too.  Something
> else? "Fix target register read when source is inactive"?  The "S-mode
> harts" ones?
>
> I already picked up "do not call GETPC()" as it's been Cc'd qemu-stable
> before, and I'm picking up riscv_hwprobe too, as it's trivial and fixes
> a trivial omission which might be useful.  Should I pick up others I
> mentioned?

Thanks for getting those two

77707bfdf8 target/riscv: Fix pmp range wraparound on zero
b6f1244678 intc/riscv_aplic: Fix target register read when source is inacti=
ve
30ef718423 target/riscv: Fix exception type when VU accesses supervisor CSR=
s
e443ba0336 target/riscv: Restrict mideleg/medeleg/medelegh access to
S-mode harts
86bc3a0abf target/riscv: Restrict midelegh access to S-mode harts

Are all good candidates for back porting as well

Alistair

>
> Thanks,
>
> /mjt

