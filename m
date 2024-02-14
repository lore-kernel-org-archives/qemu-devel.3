Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4EEC48BC4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Feb 2024 08:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raB3n-0007cc-UL; Wed, 14 Feb 2024 03:56:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1raB3l-0007bg-MS; Wed, 14 Feb 2024 03:56:05 -0500
Received: from sin.source.kernel.org ([145.40.73.55])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1raB3g-0007ut-VL; Wed, 14 Feb 2024 03:56:05 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 3F737CE1C6E;
 Wed, 14 Feb 2024 08:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80C7BC433C7;
 Wed, 14 Feb 2024 08:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1707900948;
 bh=dIEMdbt4uVH+SLcKL2HAfT6xds6Yg5ZGi16KuJ+Ap8c=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Ix48GOZnRUmmE4lVcPA3k4gNd4WJlJEhRt+G0TYvbqkmKZfINf138KKyTzSyQ5G9O
 qaIB9G2dzT9FylNpw+ab+WO4VQjWWMBEAzi2tXeje1sQ4eme3C6ebzKSSiyGhgrAZy
 8iP49dTxgQ1LhxSUhDib7wBhQ390NnelfxzVCB5wd8JhIVY5W1Y+qZAKLI5m/S2up/
 0xTDP5dqUiIJiKee6UiejWp+VeJJd3YRpS4yirFCUA52/d3O4Z2pNZTMNXbEMDPlXk
 zc41O9H6wsvXAsksRjBqfZL8MYRzw4WvF2bHgR9eXr0ednGYAHxK0CP/wt6gLzbSvc
 C+JU5QKN+ZhJA==
Received: by mail-lf1-f43.google.com with SMTP id
 2adb3069b0e04-51182f8590bso4485560e87.0; 
 Wed, 14 Feb 2024 00:55:48 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWPWt/+13Wj9jFFPuiPtFHEFaziyUkoOZLCaeD+7l8wpEZmgKEFayFldtClpSNdGRN9u6lEx1s5H9W1s2FnxXz5DdDUvng=
X-Gm-Message-State: AOJu0YzCgDB/0nRVGe51GDPXTvtAyAFsbDuc316fCaCvC201Vvb0PYeH
 XZxMFR7xNwzxcqWBG3WWLSZ+I0RJWUm+c4hYz7tAM5vejONQwZGFYPqAObSOQke1k5e7UM7s4fz
 vSCjeW2z5OqxUKTWEkHd+SUkxLNk=
X-Google-Smtp-Source: AGHT+IHvEDDI5F+hLi/GOEGRDBmmGVzlgg4rga3Z58kXUGgAT/3RBmuHN/kuso36uweCwtp4grVIFjgm49jzPiIs8NM=
X-Received: by 2002:a05:6512:1590:b0:511:a206:8fee with SMTP id
 bp16-20020a056512159000b00511a2068feemr1676763lfb.64.1707900946712; Wed, 14
 Feb 2024 00:55:46 -0800 (PST)
MIME-Version: 1.0
References: <20240122143537.233498-1-peter.maydell@linaro.org>
In-Reply-To: <20240122143537.233498-1-peter.maydell@linaro.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 14 Feb 2024 09:55:35 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHTcYB0K7f7S6F3SqSye3XAJemTt6qAb8cgmcThYshrWA@mail.gmail.com>
Message-ID: <CAMj1kXHTcYB0K7f7S6F3SqSye3XAJemTt6qAb8cgmcThYshrWA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] virt: wire up NS EL2 virtual timer IRQ
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, 
 Leif Lindholm <quic_llindhol@quicinc.com>, 
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=145.40.73.55; envelope-from=ardb@kernel.org;
 helo=sin.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, 22 Jan 2024 at 15:35, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchset wires up the NS EL2 virtual timer IRQ on the virt
> board, similarly to what commit 058262e0a8b2 did for the sbsa-ref board.
>
> Version 1 was an RFC patchset, originally sent back in autumn:
> https://patchew.org/QEMU/20230919101240.2569334-1-peter.maydell@linaro.org/
> The main reason for it being an RFC is that the change, while correct,
> triggers a bug in EDK2 guest firmware that makes EDK2 assert on bootup.
> Since the RFC, we've upgraded our in-tree version of the EDK2 binaries
> to a version that has the fix for that bug, so I think the QEMU side of
> these patches is ready to go in now.
>
> To accommodate users who might still be using older EDK2 binaries,
> we only expose the IRQ in the DTB and ACPI tables for virt-9.0 and
> later machine types.
>
> If you see in the guest:
>      ASSERT [ArmTimerDxe] /home/kraxel/projects/qemu/roms/edk2/ArmVirtPkg/Library/ArmVirtTimerFdtClientLib/ArmVirtTimerFdtClientLib.c(72): PropSize == 36 || PropSize == 48
>
> then your options are:
>  * update your EDK2 binaries to edk2-stable202311 or newer
>  * use the 'virt-8.2' versioned machine type
>  * not use 'virtualization=on'
>
> I'll put something about this into the release notes when this
> goes into git. (There are other reasons why you probably want a
> newer EDK2 for AArch64 guests, so this is worth flagging up to our
> downstream distros who don't take our pre-built firmware binaries.)
>
> changes v1->v2:
>  * the change in DTB and ACPI tables is now tied to the machine version
>  * handle change of the ARCH_TIMER_*_IRQ values from PPI numbers to INTIDs
>  * bump the FADT header to indicate ACPI v6.3, since we might be using
>    a 6.3 feature in the GTDT
>  * the avocado tests now all pass, because we have updated our copy
>    of EDK2 in pc-bios/ to a version which has the fix for the bug
>    which would otherwise cause it to assert on bootup
>  * patch 2 commit message improved to give details of the EDK2 assert and
>    state the options for dealing with it (this will also go into the
>    QEMU release notes)
>
> thanks
> -- PMM
>
> Peter Maydell (3):
>   tests/qtest/bios-tables-test: Allow changes to virt GTDT
>   hw/arm/virt: Wire up non-secure EL2 virtual timer IRQ
>   tests/qtest/bios-tables-tests: Update virt golden reference
>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

