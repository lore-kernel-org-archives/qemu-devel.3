Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D289CDD1AE
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2024 13:25:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1suAxQ-0006LE-DC; Fri, 27 Sep 2024 09:24:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1suAxN-0006Kj-QC
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 09:24:27 -0400
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>) id 1suAxK-000674-Tv
 for qemu-devel@nongnu.org; Fri, 27 Sep 2024 09:24:24 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 614805C4894
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 13:24:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AAAC4CEC6
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 13:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1727443455;
 bh=D6h5Ad/jLpq/BSwpX8jI47VFwcP+TTSWXyqSH4+ni68=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=rQN0mZhaH8FYOjxO0as8tGqBlgUJWUnvAcEqo2Mgxcqz2lPkpYU/Psm6I/m8BoziU
 vEBo1dCFtC1dRGHEzx2SSzHCEvA7aLwDphP6m8bE7JD6RFOzht2JroGDB1o3mrs446
 MFL5xPnl4SSQK1fF2uS48jpIKPm4at0m+kG5i4xuhlpnwICODCgzMFdWinBBF8pfhn
 OcPur3C2KCX39WY7iq5L2GJDgcilHyeImnAs1bSksUtdQG0opRre8HD5gH9FBsDz1G
 q+SYNYJi755uSJDbLLbcd97aJ12dUwbiadqjPWd6OhM3H0LC/f8nFTIUug8q7QpoHQ
 vRjhDpIFv7BsA==
Received: by mail-lj1-f171.google.com with SMTP id
 38308e7fff4ca-2f74e468baeso25552041fa.2
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2024 06:24:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXAbQAq7NBDyh/JnuiYeBgm6YhqwN8tJycyr0QqFTk1ksDt2NgRYSb5n5Equa4YkaUpaSgcqrFahIOy@nongnu.org
X-Gm-Message-State: AOJu0Yxzefw0hS+Kkn46GyfBISBZiZFBUyKPBzg4mLlbGzSN+ttpIFKC
 orvtDtLgU2HHIFU0xA9lEdMmmfkwlY2+CYOBvmP7bTgGpT4kp87O8JEppKuz3XCak9bggAiiuzy
 FcBvhcONpYs5ZgJc/CWXtjOSJX6c=
X-Google-Smtp-Source: AGHT+IGqg1oTJ3PasIWkCxjavxhbqY3RAJDQJs+9LE+bYUcHGdqC/UbAISxsKY6BnLOJSvtBz1ekemD5+42hyIAHCP8=
X-Received: by 2002:a2e:be27:0:b0:2f6:5df8:bfcb with SMTP id
 38308e7fff4ca-2f9d4199141mr20131481fa.38.1727443453381; Fri, 27 Sep 2024
 06:24:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240927071950.1458596-1-ardb+git@google.com>
 <4bd26d6c-1f68-43e9-ac99-b542f24676ef@redhat.com>
In-Reply-To: <4bd26d6c-1f68-43e9-ac99-b542f24676ef@redhat.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Fri, 27 Sep 2024 15:24:01 +0200
X-Gmail-Original-Message-ID: <CAMj1kXF4C5ybD=GdwgN6BMb2u0N44e0ccupvPoAtmHi432zh+w@mail.gmail.com>
Message-ID: <CAMj1kXF4C5ybD=GdwgN6BMb2u0N44e0ccupvPoAtmHi432zh+w@mail.gmail.com>
Subject: Re: [PATCH] hw/x86: Always treat the PVH entrypoint as a 32-bit field
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=ardb@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.15,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 27 Sept 2024 at 14:05, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 9/27/24 09:19, Ard Biesheuvel wrote:
> > -
> > -        pvh_start_addr = *(uint32_t *)elf_note_data_addr;
> >       }
> >
> > +    pvh_start_addr = *(uint32_t *)elf_note_data_addr;
>
> I think we even want ldl_le_p(elf_note_data_addr) here?  It makes no
> sense to read big-endian data.
>

Yeah good point.

