Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0135BE81A3D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 15:53:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vs0uC-000736-RL; Mon, 16 Feb 2026 10:53:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vs0uB-00072a-Ek
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 10:52:59 -0500
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vs0u9-0002YS-Ma
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 10:52:59 -0500
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-7964f1405a0so34161377b3.1
 for <qemu-devel@nongnu.org>; Mon, 16 Feb 2026 07:52:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771257175; cv=none;
 d=google.com; s=arc-20240605;
 b=YifvcBZPQEJGTIJ8/aikgxO3yHk+2HJFae4KVr5dqBmNE3FTYJaVQOC2dX4LXUWQef
 PU2O3jC3kXFmH9PZghe514KSXDFH6lKRVP9+GtU2ClI/6oFA+fwhugT2txWQ9q4u0nJG
 IceHsatuFDG5w4rI2N18G2cZX4XYfWXHmNyk4fR2/MCmGAr0DVzzpCFLov6xkimsvEB4
 PLuhJ4gZ3IQ0QZVaV17knNp4gO1G6g/akdU+VziXf6hk9eSivoUuGAq64UJDjw9rvaj+
 YRcwilMsX58bdgjsVJKMWW+eDJfXp2KFwMgxPreEVHlPM1e/ZknZnhfBhX+3fRyBRVLD
 0BoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dP7OJCe4IFWPzF0ucWa9rG4RGTcEJ98iWAzWk9PebNw=;
 fh=2WCIYsl40A352Dxo4B6IOy0bgaLCiK89nOgLYW+Qbs4=;
 b=EAbux8zwaffIOz4qoj3AmZvQ+DB0yRD86/TMan3loDhfm1xSvFwWdkLJvk1K7RmcCT
 HSsCOTu/pd+PO03wnrrCWEjX8rpQbaQoVaH3nG64GSjXunCL8ZsAm+u5ocOMUS3QsWNu
 YHgyOGigffPrbpI9dcPdUgsxG6ardyNXIe04E04yL9riMbFDSIJrT95DOupcVuz8ZfvJ
 aNxmVFrVfizOucM1Pim5Os5eurDpRJ+M4NlifA5Gvyxf6nDyjumlSymNgs/NWpD2dQDw
 rg1ryjH0cNHhVzIt3WPCjvE+NJGGPsPYmvhyy7onrXSTb/PxswIc7WucbXY88ryRwua3
 xhHw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771257175; x=1771861975; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dP7OJCe4IFWPzF0ucWa9rG4RGTcEJ98iWAzWk9PebNw=;
 b=bWLFI05SO3r4bFhIvkP8h2prIy+BCbOGf9Aq7uWqYnKR2YiSfNMHkida9w3iEMykfr
 i5/g7wkTkxmWwKOXnoBtM45xi9pvl834Sq8goCXdQRk9fa2xuyYVA7voj6Ej1dBjZpp0
 ft10i1beZM2y2GufPjy7zM3hg0OwVwVMfv6UT4PuZ/E5IaYNfDrdozSqXqNuQcUHA76e
 Ed5nbvpILi1sKGRUZhVm24+nPJBBseqNfvRUBzuY/esba4E+wgKt1L0fPXEMlyp+3JH6
 nXheY/jrt4VEmxopapfqpg9Y1eM5vkux56PnlbLH7a623cfPdP9726qYFUoOIDuWJu2U
 btOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771257175; x=1771861975;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dP7OJCe4IFWPzF0ucWa9rG4RGTcEJ98iWAzWk9PebNw=;
 b=BysxeqXbRR3JRMURiwfhOO3s3YTd4F6eDjR01RnqGfXRuSUSMH0eqXLCZtCoSW5XUw
 3hovcdv9PlvVaqfWVekAy+ATElnVaSVQ4VSqNCYlv5eyFI1DeVnElX/m49ry0QWQaSED
 GJE6rZD1i28Rm0cIAfLk0bMZUmMFQm9eNGcEryzafW47iurw6njbOCF9Knx6NfABsgKs
 Qdj3VLl2R4WDAl8XoCTkJrZHnD/rKM5pepNIKgNf1Oylu04ELA3wmCOW4ECkFPtzK4ib
 ugjsgvD9ubumPLfeQSZ7xyAx4llnAB5rZmzbQnjufwaaaxkCLo0ZayM400WOVGzRw1Td
 aCxA==
X-Gm-Message-State: AOJu0YwLbgQmaD196TKPZGKtk3ZR6Baac/y/DhvHovaPN+xauhAkiUTV
 oxY9tXpGhMr0Zl9DYtj5rX0wFjqge3xaZAHvkKNDPcPgwOVnP1rAfnCYeSGdOvERGDYeDlCDTn2
 ndQfx0U7BJ+wgYk81TEK5qWwbKxaUTut7GBhWwW0DsQ==
X-Gm-Gg: AZuq6aJ/djYD7LmxnJAsAmEhYwkPWeRCG3zhDZjndYxMcTDUExUZxfHC2xtdLdLW2RD
 nDDpgRAYobjuKfXNDh/tjFxJHpEhMvcrR35ps5ducpf5d/sRUk/wtapUASbCKQP3UTCSf0vRU3V
 o6CVreCHZBeZKxTqDB3+8hmqhT131uaTZczBwCd9paVAFfFqT6U51L+6+ib4ExG3ET12sw0c6AJ
 Uo6It/j8EcmPHPxL0rSOBlXHs11s98d8oCt+0n9HADcahOxC6QN97GGo9BMYP/D/ONhv/vN+Zqr
 fHk4kq73NqGUxn4vX8E3vnKSxJixecvLQ6EBt5zOYZvPYpc/NMroOtzt7BPCM/ehTXx1z28v+ha
 aOA==
X-Received: by 2002:a05:690e:13c4:b0:64a:ee12:e7c3 with SMTP id
 956f58d0204a3-64c21b27b78mr6172226d50.49.1771257175307; Mon, 16 Feb 2026
 07:52:55 -0800 (PST)
MIME-Version: 1.0
References: <20260210201540.1405424-1-pierrick.bouvier@linaro.org>
 <93f8f250-7899-4528-b277-1ddd469c192c@linaro.org>
 <CAFEAcA9YUOxko51ziY3yAOaDfTCEAwqmXnifF=q_mkyotFHTcg@mail.gmail.com>
In-Reply-To: <CAFEAcA9YUOxko51ziY3yAOaDfTCEAwqmXnifF=q_mkyotFHTcg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Feb 2026 15:52:44 +0000
X-Gm-Features: AZwV_Qhn_PA25doQjTID65lEcz5xT-1XaHevKcqNoTL7fZxazaWzkWciCHn6keY
Message-ID: <CAFEAcA8XCSjjb2opkf2A5WZwCa5THNswOOUO=fpj7kUJEc79qQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] target/arm: single-binary
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, anjo@rev.ng, 
 Jim MacArthur <jim.macarthur@linaro.org>, kvm@vger.kernel.org, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-arm@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 12 Feb 2026 at 10:59, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 10 Feb 2026 at 20:19, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
> >
> > On 2/10/26 12:15 PM, Pierrick Bouvier wrote:
> > > This series continues cleaning target/arm, especially tcg folder.
> > >
> > > For now, it contains some cleanups in headers, and it splits helpers per
> > > category, thus removing several usage of TARGET_AARCH64.
> > > First version was simply splitting 32 vs 64-bit helpers, and Richard asked
> > > to split per sub category.
> > >
> > > v3
> > > --
> > >
> > > - translate.h: missing vaddr replacement
> > > - move tcg_use_softmmu to tcg/tcg-internal.h to avoid duplicating compilation
> > >    units between system and user builds.
> > > - eradicate TARGET_INSN_START_EXTRA_WORDS by calling tcg_gen_insn_start with
> > >    additional 0 parameters if needed.
> > >
> > > v2
> > > --
> > >
> > > - add missing kvm_enabled() in arm-qmp-cmds.c
> > > - didn't extract arm_wfi for tcg/psci.c. If that's a hard requirement, I can do
> > >    it in next version.
> > > - restricted scope of series to helper headers, so we can validate things one
> > >    step at a time. Series will keep on growing once all patches are reviewed.
> > > - translate.h: use vaddr where appropriate, as asked by Richard.
>
> > Patches 1-11 are reviewed and ready to be pulled.
>
> Looks like patch 12 has also now been reviewed, so I've applied
> the whole series to target-arm.next.

I meant to send this to the list, but accidentally sent it to
Pierrick only:

I just ran this (plus some other patches) through gitlab CI, and
it fails to build on the kvm-only and xen-only jobs:

https://gitlab.com/pm215/qemu/-/jobs/13131658696

In file included from /builds/pm215/qemu/include/exec/helper-gen.h.inc:9,
                 from /builds/pm215/qemu/include/exec/helper-gen-common.h:11,
                 from ../target/arm/helper.h:7,
                 from ../target/arm/helper.c:13:
/builds/pm215/qemu/include/tcg/tcg.h:35:10: fatal error: tcg-target.h:
No such file or directory
   35 | #include "tcg-target.h"
      |          ^~~~~~~~~~~~~~


https://gitlab.com/pm215/qemu/-/jobs/13131658593

In file included from /builds/pm215/qemu/include/exec/helper-gen.h.inc:9,
                 from /builds/pm215/qemu/include/exec/helper-gen-common.h:11,
                 from ../target/arm/helper.h:7,
                 from ../target/arm/debug_helper.c:11:
/builds/pm215/qemu/include/tcg/tcg.h:35:10: fatal error: tcg-target.h:
No such file or directory
    35 | #include "tcg-target.h"
       | ^~~~~~~~~~~~~~

I think the problem looks like it's in "move exec/helper-* plumbery to
helper.h", which has put the "emit the TCG gen_helper_foo inline
functions" into target/arm/helper.h, when they were previously
handled by target/arm/tcg/translate.h and so only in source files
that are part of the TCG translate-time code. helper.h only needs the
prototypes of the helper functions themselves.

Some of the other new helper-foo.h files look like they would
also have this problem, except they happen to only be included
from tcg files. For instance target/arm/helper-mve.h is only
included from files in target/arm/tcg (so it maybe could be
in target/arm/tcg itself).

I couldn't see an obvious easy fixup for this, so I'm afraid
I've removed the series from target-arm.next.

thanks
-- PMM

