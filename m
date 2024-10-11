Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0076CD0EE38
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 21:08:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szMrb-00082p-Hi; Fri, 11 Oct 2024 17:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1szMrX-00082T-V1
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 17:07:52 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atishp@rivosinc.com>)
 id 1szMrV-0004xw-Ig
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 17:07:51 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-71e4e481692so13710b3a.1
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 14:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1728680867; x=1729285667;
 darn=nongnu.org; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IcaPMSEikXRLKNfvJPIZ/QakjhFegjjA1ZgrzfrkIMQ=;
 b=rkNzSPY3yG0LixZN9m1ASjzQC+esD9NBLeWmewrQ/Gwij+uP+6Zj/6nME0DZQqcQpP
 zB1zJAcspTzHoaxEFJdx7Ec/OsoGvoDkCoJBBjNeCMA5hTOgiXoOB5H2ldPDrSOT6OD0
 7ruS122AEhMkCEOXOcblvBpN4Slysnpgpy9swo5kJUX9PzkNeUCBWhRBRjYthrhI2DJ+
 s6a7q3nwDqYRV7C/11DsARmowNGoxqnVgcXW9ING1anmxhZVHBpZI/ENzhLXRAuPSUkk
 eX9LD7dbd7sX1oUFoR5rjhrDo5Euq7PwdTJrqy3VawzV2zi99D3LBa1KB0WHZi7oVAM+
 ysvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728680867; x=1729285667;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IcaPMSEikXRLKNfvJPIZ/QakjhFegjjA1ZgrzfrkIMQ=;
 b=Zmw7bQRS2/4Q2uRtTzBqUnE0RZEYyuow34og5mZkQwor3Rh/4CKDPRY6N4Z5wasM3R
 Dp4p6h6QknetwQbR/xredeoLVoPM5Apxj+pPpmdbTKbMGxhYO/hDthUbsg5v81hRWe0q
 TIzg2iOvkFnULlQuBCnfthmuR0KSJzFvTy7tTcxl0eYtxjFuhq7uk3fWPchyYt0JUXiP
 ot6pnqpFHQ6IHLZ31gJOordHctAG2rANju4uRgiEdlpniTlCWBrcHGEwKx4jdQ73x+f4
 K6B1kklm5AkOlKKWCOlJOQLxXTDf7ExEfnUk0RQ6j0LrN7mu3T/3QoyilfkMEP+OtLag
 tbZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVusrxQKnRyah6PdpbHHB4eVFEof2WGcrM4ZYx0gYzMBn9TbfrlSr5psGIwIvvYlPPWxYzxhLZB8LtV@nongnu.org
X-Gm-Message-State: AOJu0YxRY5NXyEiDO1DvnhYvjy/9YKWrg3cHeLNfffephf4j3L6Di/0f
 48ovfB86/M++nSgaEVfzprKbmSY7ucBf5O8o2I+JgTUEsz/dYqi00/aJ7nOgzKAT4CctkcUMTOn
 WUjAhEuG3cHPcKRYExOMMqmin7Jc6rnylaZIQUQ==
X-Google-Smtp-Source: AGHT+IHYzLKacqiJnI47D6YzxoDIErbvG0tTLbpBoCoxYzt3LaaO3raukXOSh+6jko1o2Lx73mchUJT5InuproLZjA4=
X-Received: by 2002:a05:6a00:189a:b0:71e:4655:59ce with SMTP id
 d2e1a72fcca58-71e4c03044cmr1630827b3a.0.1728680867214; Fri, 11 Oct 2024
 14:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20241009-pmu_event_machine-v1-0-dcbd7a60e3ba@rivosinc.com>
 <43613048-ba0b-4fc0-9ee2-b987a6dc86e4@yadro.com>
In-Reply-To: <43613048-ba0b-4fc0-9ee2-b987a6dc86e4@yadro.com>
From: Atish Kumar Patra <atishp@rivosinc.com>
Date: Fri, 11 Oct 2024 14:07:36 -0700
Message-ID: <CAHBxVyG7mNWU+r0dd-R2oL4SftOhWsTpLzcmDMAOKALvjh8qHg@mail.gmail.com>
Subject: Re: [PATCH RFC 00/10] Allow platform specific PMU event encoding
To: Alexei Filippov <alexei.filippov@yadro.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 alexei.filippov@syntacore.com, palmer@dabbelt.com, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=atishp@rivosinc.com; helo=mail-pf1-x432.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Oct 10, 2024 at 5:51=E2=80=AFAM Alexei Filippov
<alexei.filippov@yadro.com> wrote:
>
>
>
> On 10.10.2024 02:08, Atish Patra wrote:
> > Currently, the pmu implementation is virt machine specific that
> > implements the SBI PMU encodings. In the future, individual machines
> > would want to implement their own custom event encodings as there
> > is no standard event encoding defined by the ISA. There is a performanc=
e
> > events TG which is working on defining standard set of events but not
> > encodings. That allows flexibility for platforms to choose whatever
> > encoding scheme they want. However, that means the generic pmu code
> > should be flexible enough to allow that in Qemu as well.
> >
> > This series aims to solve that problem by first disassociating the
> > common pmu implementation and event encoding. The event encoding is
> > specific to a platform and should be defined in the platform specific
> > machine or cpu implementation. The newly defined callbacks can be invok=
ed
> > from machine specific cpu implementation or machine code itself dependi=
ng
> > on the requirement.
> >
> > The first 5 patches in the series are generic improvements and cleanups
> > where as the last 5 actually implements the disassociation for the virt
> > machine. The current series can also be found at[2].
> >
> > I recently found that Alexei has done a similar effort for SiFive FU740=
[1]
> > but the implementation differs from this one based on how the cpu callb=
acks
> > are invoked. For example, Alexei's series implements a single callback =
for
> > all the events and has defined machine specific counter read/write call=
backs.
> > However, it just defaults to get_ticks() for every event. IMO, that is
> > confusing to the users unless we can actually emulate more generic even=
ts or
> > machine specific events.
> >
> > I have separate callbacks for each type of events that we currently sup=
port
> > in Qemu (cycle, instruction, TLB events). Separate callbacks seems a be=
tter
> > approach to avoid ambiguity as we have very limited event capability in=
 qemu.
> > I am open to converging them to one callback as well if we think we wil=
l
> > be extending set of events in the future.
> >
> > Once we converge on the approaches, we can consolidate the patches
> > so that both SiFive FU740 and virt machine can use the same abstraction=
.
> >
> > Cc: alexei.filippov@syntacore.com
> >
> Thanks for CCing me and your patch. Your done a great work, but still I
> do not think this approach with per event callback are scalable enough.
> I'll suggest to collaborate to work your and mine solution to unite them
> to one patch set. Let me know what do you think.

Yes. We should definitely collaborate and send a single series to support b=
oth
virt and sifive machines. You had a question about widening the
hpmevent in your series.

(Answering here to keep the discussion in 1 place)

As per the section 18.1. Count Overflow Control, only top 8 bits are reserv=
ed.
Thus, a platform can implement their event encoding to upto 56 bit wide.

> > [1] https://lore.kernel.org/all/20240910174747.148141-1-alexei.filippov=
@syntacore.com/T/
> > [2] https://github.com/atishp04/qemu/tree/b4/pmu_event_machine
> >
> > Signed-off-by: Atish Patra <atishp@rivosinc.com>
> > ---
> > Atish Patra (10):
> >        target/riscv: Fix the hpmevent mask
> >        target/riscv: Introduce helper functions for pmu hashtable looku=
p
> >        target/riscv: Protect the hashtable modifications with a lock
> >        target/riscv: Use uint64 instead of uint as key
> >        target/riscv: Rename the PMU events
> >        target/riscv: Define PMU event related structures
> >        hw/riscv/virt.c : Disassociate virt PMU events
> >        target/riscv: Update event mapping hashtable for invalid events
> >        target/riscv : Use the new tlb fill event functions
> >        hw/riscv/virt.c: Generate the PMU node from the machine
> >
> >   hw/riscv/virt.c           | 102 +++++++++++++++++++++++-
> >   target/riscv/cpu.h        |  52 ++++++++++--
> >   target/riscv/cpu_bits.h   |   4 +-
> >   target/riscv/cpu_helper.c |  21 ++---
> >   target/riscv/pmu.c        | 198 +++++++++++++++++++++----------------=
---------
> >   target/riscv/pmu.h        |   3 +-
> >   6 files changed, 246 insertions(+), 134 deletions(-)
> > ---
> > base-commit: 19a9809808a51291008f72d051d0f9b3499fc223
> > change-id: 20241008-pmu_event_machine-b87c58104e61
> > --
> > Regards,
> > Atish patra
> >

