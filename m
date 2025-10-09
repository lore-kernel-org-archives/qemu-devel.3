Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7593FCAC5BB
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 02:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6gWI-000349-4y; Wed, 08 Oct 2025 22:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v6gW7-0002zj-6p
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 22:36:32 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v6gW2-00081l-Ou
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 22:36:30 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-62fa062a1abso702547a12.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 19:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759977382; x=1760582182; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UETsUmCDWDud5d1hzPTaPIGH31yXBsuYA41Kk+ARFNU=;
 b=kgDJKADWRP2QxCZ/RJYUPnNDqfMn2W/6nYlpzCfxw+XItriAJO6jtrNsowwjV1Z7jg
 nzO2wVPGoQRabMVFrnaDL/xGDH5snGB24/qYIm3tdVaY8aINZofW0pgVQTKhFdtKTAQ/
 i5Jj5q0Vo8Z9kp3tJq+eS1p9RyvOwM+mFhChZNAEXMb1EdEEWXt2VP9E/FEF2WfqFiN/
 2OmM4SAmdMK5UcSJLOvwKZhwdMLto8czAYT/Qno8UMZCE/vvDu7QyTvhAAzTE3wLYs3p
 6yzNl8pMSvhRy8EvwjDuUgUhWEx1cBZSMW/uZKf8OdvX5K8YKibgfaDTzsXKk/266g3i
 NDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759977382; x=1760582182;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UETsUmCDWDud5d1hzPTaPIGH31yXBsuYA41Kk+ARFNU=;
 b=Wz6q4w2udyqjWxEjE6uzujtk5b0Wr5zYnbVpHXa7MIkB0UUsWdfpLNfCUBlsWrAFNd
 4l3wdLamY4a8sqeYCVvn8OouKAoTjdNCstUhDXJUDbToaSP2PVMYh31h7IuwdrQIXHgz
 ugUnaGB8heYxpr+GnQifUBfAlpXWasm1BhKWxHi0n9dmNiApEPSOsRsvJCmWE0dU4D6n
 7NGJ9vM0Ld4sd9NPcuQJKs02xLFpXatFgV2t9+jTg4x31avUzxH7KbmMvMz5aWAGenX7
 YZUH2aKFH0HP/C7YBrS7tir6DqOZlcswG7JMaMRU1x8noZKMp9eN/7piHu2ZotrdDeCm
 ZKww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRXxdQdlJ4w+5nroq9I2TZQSfmoE2EBb3I7je8GNCukXNRo5H1A6mO7SyBnsJLqWseAPGpyeagSNTK@nongnu.org
X-Gm-Message-State: AOJu0YxN3GAirLrwAadhfIaiN5MAa//B0oaNVuC2QVxQa04mKHZRZ2xT
 SCr1hnsSh2zMQBir4zBdZcFMVEyzLJ+Ex8etbWoU2nXh1RSIAnYJQUKfDU1zKpA9uEHFSKuYVJ2
 cfVutR1R5UPzNVGD7Jas98OodOu3aX071tA==
X-Gm-Gg: ASbGncvZGw53BrcKZozeV5At9Fq5aoOXki0pckn9/GByY9qQitm/1aqOo37bbVRPdPo
 rOuDoQFs720LD+OgTvNBj1moTNx4553kF8pTrL5vYIBfaVf8u+vycEwdrxX7L3ZHQ4M/PuGH6Y6
 mkQRh5Lj3XMQMEni7l0hk9fQMDdoL7lQ/SG/TYGIDp8GgKDKOUKWre8wIwYieEKQ9PxM7M39q4c
 pcgUIf8kSf6gzP0vy/Eidnw3a+WHX+mXKEpI/ejTcKIuyl/uz1hZEiwBBr2A0iBo49ntDRK
X-Google-Smtp-Source: AGHT+IFKNpfeQwiA34dne45x9N494UKYJX/v5QJlmIbEWfU83OtP5xPqV5OMysBad41vNI9HMpPYhF63fU+WSQknjSM=
X-Received: by 2002:a05:6402:35ce:b0:634:c377:e188 with SMTP id
 4fb4d7f45d1cf-639d5b57b06mr5528563a12.6.1759977381489; Wed, 08 Oct 2025
 19:36:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250911-timers-v3-0-60508f640050@linux.alibaba.com>
 <8b282db4-b49b-4199-94e9-35d7cc296b8b@tls.msk.ru>
In-Reply-To: <8b282db4-b49b-4199-94e9-35d7cc296b8b@tls.msk.ru>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 9 Oct 2025 12:35:55 +1000
X-Gm-Features: AS18NWDB6WnlsCYd_SqqwzB7sCGutQeAHdfo1eS10rP8wa3KJfXaPqwVHrJoqYE
Message-ID: <CAKmqyKMz+b+MUxRLSuDRM=cDH9XMiJs1+PF5WxTnXNQgS3nnAw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Fix RISC-V timer migration issues
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: TANG Tiancheng <lyndra@linux.alibaba.com>, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 qemu-stable <qemu-stable@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x533.google.com
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

On Sat, Oct 4, 2025 at 5:19=E2=80=AFPM Michael Tokarev <mjt@tls.msk.ru> wro=
te:
>
> On 9/11/25 12:56, TANG Tiancheng wrote:
> > This patch set fixes several timer-related migration issues in QEMU's
> > RISC-V implementation that cause timer events to be lost or behave
> > incorrectly after snapshot save/restore or live migration.
> >
> > The problems addressed are:
> >
> > 1. ACLINT mtimer time_delta not migrated: The time_delta field in
> >     RISCVAclintMTimerState was missing from vmstate, causing incorrect
> >     mtime values after snapshot restore. This resulted in guest time
> >     appearing "frozen" until enough virtual time elapsed to compensate
> >     for the offset error.
> >
> > 2. ACLINT mtimer timers array not migrated: Active timer events
> >     scheduled via riscv_aclint_mtimer_write_timecmp() were not being
> >     migrated, causing pending timer interrupts to be lost after restore=
.
> >
> > 3. CPU stimer/vstimer not migrated: The S-mode and VS-mode timer
> >     pointers in CPURISCVState were missing from vmstate_riscv_cpu,
> >     causing supervisor-level timer events to be lost.
> >
> > The patch set introduces a new VMSTATE_TIMER_PTR_VARRAY macro to handle
> > migration of variable-length timer pointer arrays, and adds the missing
> > timer fields to the appropriate vmstate structures.
> >
> > Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> > ---
> > Changes in v3:
> > - Remove 'include/' of the subject at patch v2 2/4.
> > - Added Reviewed-by from Peter Xu.
> > - Link to v2: https://lore.kernel.org/qemu-devel/20250910-timers-v2-0-3=
1359f1f6ee8@linux.alibaba.com
> >
> > Changes in v2:
> > - Split VMSTATE_VARRAY_OF_POINTER_UINT32() into a separate patch,
> >    and define VMSTATE_TIMER_PTR_VARRAY() in riscv_aclint.h.
> > - Added Reviewed-by from Daniel Henrique Barboza.
> > - Link to v1: https://lore.kernel.org/qemu-devel/20250909-timers-v1-0-7=
ee18a9d8f4b@linux.alibaba.com
> >
> > ---
> > TANG Tiancheng (4):
> >        hw/intc: Save time_delta in RISC-V mtimer VMState
> >        migration: Add support for a variable-length array of UINT32 poi=
nters
> >        hw/intc: Save timers array in RISC-V mtimer VMState
> >        target/riscv: Save stimer and vstimer in CPU vmstate
>
> Am I right this stuff is not back-portable to previous qemu
> stable releases, as it introduces new fields into the migration
> stream which, which can't be picked up by these releases?

Yes, I don't think this should be backported as it'stargetting migration.

Alistair

>
>  From the description it seems like all this stuff should be fixed
> in previous stable qemu releases too.
>
> Thanks,
>
> /mjt
>

