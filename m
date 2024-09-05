Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69F08CD5BB8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 19:59:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smIcM-0006fY-7O; Thu, 05 Sep 2024 15:58:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smIcE-0006DV-Ad
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:58:02 -0400
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smIcB-0005QO-Nr
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 15:58:02 -0400
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5c255e3c327so1379270a12.1
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 12:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725566278; x=1726171078; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lYfrfHS9RtigmYutpmVoHsixfgUjRDK8Puz2pHNo5FI=;
 b=U/cIgRw97COS8oUEocIosulUhB7bBK4XfKY1JCE2Gz8anqqgkcxCyvLSBFlryXtjYf
 n5gRk/Sw3fOae+JrMS545Epd7BFGHrMC/dXLCY7OLaiY5gBtySW4+dvee3NXww+dQReT
 xTbKI6JfcOA7tFm3U4vrGA5eSpHlWPuce2U+9+4nJ2wmCpAxnAVlUcV2VfgRgm+Y01xz
 tFCO4qZ3vasaOB79FYgKeYTpsc+tS/QDXPnPUiP/xNG//TZC71GQsFqUy9ophLYI78Zv
 DsL5oJiiHiBN4OdbxM7wsGQFiMMeCHLVmR6Ud4mzL6F6XQEiBER63rbiL6klJj7DZcDl
 L7pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725566278; x=1726171078;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lYfrfHS9RtigmYutpmVoHsixfgUjRDK8Puz2pHNo5FI=;
 b=FM4VLPPykjPtPrLT+ngBxNucODEG1kv0nEtT2jQjTeVExbXGQ4wDGuSF1GaJRvmEnJ
 kFoN4pS2E/fODihNpbRhrC/Mx+ycD+R7WLJNUU2nRzef7QTtQIj251wWQYnNXeY90D1Q
 9uBfiFsMmh9o+/COYwQfwgna0pMJdhxKvZs6D423K6xWVfcBQbp/2jBhY8zhGrlnMGda
 8FlOvuIUwaFTmFnoOvwGLOb3v3nnfgq+dNMz9/mXctXM+jBrHLmmfohqiTFUqqHJif6q
 +N+0XQbiBBkJSJO4Z8leGr3NxU1XOXDgI8jfndzTDdHDYp1yqY+6W1rG1Hk4RuYpjDak
 r1Ow==
X-Forwarded-Encrypted: i=1;
 AJvYcCUe5lqGF5mtLMtpCyA86AMGMMN+XPimMROZgJD375PYIRbM7GqmLti5lgOiePV5f/E5crxwZ2ac9Yyd@nongnu.org
X-Gm-Message-State: AOJu0Yxm9PfD0SDH/NB8Mmk8HSXrk8qHDO5MGzmcTY8xOORMAZCYZdrI
 AzLJjJf1kHQ8bjYA9AoIkneEd7kQsuVWtwS45O9t67Xkyd51oT5Ji9qWfCCYCtl1NibGveH2Wfz
 jptRkUvcsgKiOTX0vg/YOsit1i/XYODh8tv+r9g==
X-Google-Smtp-Source: AGHT+IGrWR5JOyJ/Raoykx96VXJhDX1H4HFUlBfuZtF+caWfKSra0Y9jp6VN4gIjU0mGmwtLozHOYgt4uw6kZMLAwzQ=
X-Received: by 2002:a05:6402:50c6:b0:5c2:1043:b3e1 with SMTP id
 4fb4d7f45d1cf-5c3dc7993e8mr70420a12.18.1725566277937; Thu, 05 Sep 2024
 12:57:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240905150702.2484-1-mps@arvanta.net>
 <aca89438-a7c0-4cd9-9668-2917a04ec779@linaro.org>
In-Reply-To: <aca89438-a7c0-4cd9-9668-2917a04ec779@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Sep 2024 20:57:46 +0100
Message-ID: <CAFEAcA8yaVZHToNyU3D7nPX37RAqLWW9zxPD6TuSHk5PVaCM3g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] util/util/cpuinfo-riscv.c: fix riscv64 build on
 musl libc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: =?UTF-8?Q?Milan_P=2E_Stani=C4=87?= <mps@arvanta.net>, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, 5 Sept 2024 at 20:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 9/5/24 08:06, Milan P. Stani=C4=87 wrote:
> > build fails on musl libc (alpine linux) with this error:
> >
> > ../util/cpuinfo-riscv.c: In function 'cpuinfo_init':
> > ../util/cpuinfo-riscv.c:63:21: error: '__NR_riscv_hwprobe' undeclared (=
first use in this function); did you mean 'riscv_hwprobe'?
> >     63 |         if (syscall(__NR_riscv_hwprobe, &pair, 1, 0, NULL, 0) =
=3D=3D 0
> >        |                     ^~~~~~~~~~~~~~~~~~
> >        |                     riscv_hwprobe
> > ../util/cpuinfo-riscv.c:63:21: note: each undeclared identifier is repo=
rted only once for each function it appears in
> > ninja: subcommand failed
> >
> > add '#include "asm/unistd.h"' to util/cpuinfo-riscv.c fixes build
> >
> > Signed-off-by: Milan P. Stani=C4=87 <mps@arvanta.net>
> > ---
> >   util/cpuinfo-riscv.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/util/cpuinfo-riscv.c b/util/cpuinfo-riscv.c
> > index 497ce12680..8cacc67645 100644
> > --- a/util/cpuinfo-riscv.c
> > +++ b/util/cpuinfo-riscv.c
> > @@ -9,6 +9,7 @@
> >   #ifdef CONFIG_ASM_HWPROBE_H
> >   #include <asm/hwprobe.h>
> >   #include <sys/syscall.h>
> > +#include <asm/unistd.h>
>
> I suppose this is ok, but...
>
> For some reason musl processes asm/unistd.h at build-time to produce <bit=
s/syscall.h>,
> which is included by <sys/syscall.h>.  This will be "fixed" the next time=
 musl is rebuilt
> against current kernel headers.

It matches how we include asm/unistd.h in memfd.c so
we can get __NR_memfd_create, so it seems OK to me.
We ought to be able to build against older musl too, not
just those which are up-to-date with their kernel headers.

-- PMM

