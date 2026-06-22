Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8EC5CDB46F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2026 10:59:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbcMC-0006a2-1w; Mon, 22 Jun 2026 06:58:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wbcMA-0006Ys-NK
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 06:58:22 -0400
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1wbcM8-0001uq-VX
 for qemu-devel@nongnu.org; Mon, 22 Jun 2026 06:58:22 -0400
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-30c001b21feso3828729eec.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 03:58:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782125899; cv=none;
 d=google.com; s=arc-20240605;
 b=BMNxiCgw75PmND4BMHduj6AOIBet+AeH8EWexwJoZYxJ8+/G6BSSASCI6ay3JIwZX6
 MoxOTzZ6a8PxiFLdR3yzXmJDRnmH095rEiyxHXnpGNSgK5OPV0sxBTASgLRCv9IxhsOk
 IUbxDxmS0+crG7DK+IvxW9+KWXhyv9T0klZ3WR+d0PUtfsx7r7vck23Nmb2fdo3FBtee
 xuSjv5LEangcTm1X1TR1+c7Oc8upNWAV7OANnzUyI8sj2vuLo80nWSHbZjQ3JhOJNv6a
 c/ojgIQOjb2qeodsVPkVQhZYPi4T5IIzsiyh27EGpOksKv5o4sYdm/n7fnxGPuHaZnzn
 RsPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=0ukOZ295gE2EagRzjFi+ymatOFOzQWYPl6niSxdAdb4=;
 fh=3CALu0jP8XVfaItjbi7irWfaZhRhDQLdU2h84eV+NaM=;
 b=DONlsAQpP95LeHk+2zmctrSjf+pv7t9lmi57eYI1gj0jSBagD26EaBzz981QO8lmpI
 N9s8P4eSnaKs5MOa3h9oSOqznZ/54MCQxiAbX+NE94QB1uZJENStOPkpWDyzNtTK/c0D
 KP+O2wRp4K7ID9ddu3NZpCKypjIJrGPKQ/d7oXfadVYp1869WsCeqH9U2+k+OZf6mmAA
 QM5x/OUr7MDrRYPf8qTtJc80PtHmvtxHswklPxFbrnILyTCaK2BC2YqMcM3Ua+v0GyGm
 lmNjXfTBrr+vzcZtmTlBFk6AN68RFTnKXI58QHS6p3kaiJhTAl6kwB4avqMhloFT3S91
 cMOA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782125899; x=1782730699; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0ukOZ295gE2EagRzjFi+ymatOFOzQWYPl6niSxdAdb4=;
 b=IVn6+TkY+4Le8KhPVdj4P7a/E8e8m1Q5FjdLC0mundfx3tqZZgfN1jLCm0KNKQncSG
 cwrRoEfsy+fzykEMME1p+WSKMtR+6SCWEpc8eKZnuRtFFjJ3x1UFPltx58sEJCu9qORC
 JMMNQCaP38Zyi0CiEfdAfEzCrzwe5NuJE+RubHqbKWAfXTQav+ZJvyIckvq9oZ+oV4/A
 Vrvnp1fypczX8/yQzJOepRAavTLA4lPbhC75jRPkzIb2QporULOmKDK0mv7BQ2Ts0aFL
 yr4C/yggRg13cWlL74Wwzx8mHG+2AX9hMIOiVt946g7uULZJTkHbMeVy7rq5zAxIoHRm
 Njqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782125899; x=1782730699;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0ukOZ295gE2EagRzjFi+ymatOFOzQWYPl6niSxdAdb4=;
 b=nIJH/0+Z10fTmeorlsrsuuVrzXvHHNL+TNeXxBSjHFvXjb7dPnkYuCRSbwU+iHblnd
 5OkOC/tzHZWuB3/IvHXSmsXSuzTl8is/uHJsU3dCgM5OXSdZOnkZX1RhF+CdLLTBSyYX
 IxOn4IH6IQGWXsvThcceJROW9ADp2d8GwURKqSz2auLSSbgSaGAKuE1M74I5iifD0Wn/
 cnwk1MiJWsotExGYYml5YmQgROHvyF0ov+kHgoI0q8SKj/POouMeltsalwPpPCxs2aiH
 Q/LRGFna9cR9Z5uBb2lHFVs2cqcHWnhgdom6RfqaLoFOHdEm78rOhGPgUcwFz+j4aNuQ
 AjTQ==
X-Gm-Message-State: AOJu0YzqCLeGiX+8c17uPNQyrE2OLSU0/vPocn5sO8bJMtQaohXi1u6/
 UJdBl/r0MX0tIT2seMSbkUe32KHaGE6KKgRr3Lzv+MypDJTudJam2MPIOfY7LbjySiwilePYg3m
 IlSTS8V1Rd2VAf/pJUiKFeKjhXL+uoe8=
X-Gm-Gg: AfdE7ckUiGHR+3CuKT7GZFKvhkQH11PVAP1FH8iRBwxpBFBHf8UYIcaz8k4Qfmju0YY
 QattePFD4TJW9qfTrX4Etq/fRqLNf/aUrDRZabgPVTGxrJxJEVagtwBh5cfHnkiYxj6ELAa9TPg
 ySAXsAH58ZOy0NGgeGLY9UWaMVh5Ch84J8cbIdodbOEOibhib53WpgF00AQukP7lYdvjMv5gy7t
 srZ+n3RQbcIDtcfNhve1LLiuWmnLzUEJvl3e3xZskB02aqEDjQMCF4Ry8XeHysPyr/tuCf//Zqx
 OWgbn7IqGozR7QbvSnRxZ+s5OvQs
X-Received: by 2002:a05:7300:8bab:b0:30b:dd58:e155 with SMTP id
 5a478bee46e88-30c07156edamr10716301eec.20.1782125899021; Mon, 22 Jun 2026
 03:58:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260619101834.228432-1-den@openvz.org>
In-Reply-To: <20260619101834.228432-1-den@openvz.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 22 Jun 2026 14:58:07 +0400
X-Gm-Features: AVVi8Cc6MoZGJ1WOvDAvtSi5e7qJIvaAqv1A4GMZnoE1pkFqJfui6w6Woo3vcuU
Message-ID: <CAJ+F1CKa5zmjo-5GCJW3BohCSBknjWsZmKRV1Oupa20A742w7w@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] dump: report win-dmp via vmcoreinfo, guard
 guest-RAM reads during migration
To: "Denis V. Lunev" <den@openvz.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, anisinha@redhat.com, berrange@redhat.com, 
 peterx@redhat.com, farosas@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::1336;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x1336.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Fri, Jun 19, 2026 at 2:19=E2=80=AFPM Denis V. Lunev via qemu development
<qemu-devel@nongnu.org> wrote:
>
> This series fixes Windows-dump (win-dmp) availability reporting and close=
s
> a related hole found while doing so: several commands read guest RAM and
> must not run while a migration destination is still receiving it.
>
> dump-guest-memory, memsave and pmemsave all read guest RAM on the main
> thread with the BQL held. On a migration destination that RAM is either
> still being loaded (precopy) or pulled from the source on demand
> (postcopy, where the guest already runs). During precopy the read returns
> incomplete data; during postcopy it deadlocks, as the read faults on a
> not-yet-received page while the postcopy incoming path needs the BQL the
> reader holds to install it. dump-guest-memory only guarded the precopy
> phase and memsave/pmemsave had no guard at all, so a new
> migration_guest_ram_loading() predicate captures both phases and all
> three commands now use it.
>
> query-dump-guest-memory-capability also advertised win-dmp for every x86
> VM, and dump-guest-memory accepted it unconditionally; win-dmp only works
> when the guest has published a Windows dump header through vmcoreinfo.
> win_dump_available() now reads that note back from the vmcoreinfo device
> and validates it, keeping its original signature, so the dump.c call site=
s
> are unchanged.
>
> The series also adds the first qtest coverage for dump-guest-memory:
> capability list, ELF and kdump output, protocol errors, and win-dmp
> reporting in both directions (the positive case forges a vmcoreinfo note,
> so no Windows guest is needed).
>
> Tested:
>  - Linux guest: win-dmp not advertised; an explicit win-dmp request is
>    rejected without stopping the guest; elf/kdump dumps work.
>  - Windows Server 2022 guest: win-dmp advertised once vmcoreinfo is
>    populated; dump-guest-memory format=3Dwin-dmp produces a valid (PAGEDU=
64)
>    crashdump.
>  - Live postcopy migration: on the destination, dump-guest-memory, memsav=
e
>    and pmemsave are all refused immediately, without faulting a page.
>
> This supersedes the earlier "dump: enhance win_dump_available to report
> properly" series, which obtained the note by reusing the dump setup path
> (splitting dump_init() and stopping the vCPUs). Reading vmcoreinfo
> directly is much smaller.
>
> Changes since v4:
>  - Refuse guest-RAM reads (dump-guest-memory, memsave, pmemsave) while a
>    migration destination is still receiving RAM, via a shared
>    migration_guest_ram_loading() helper.
>  - Decide win-dmp availability by reading vmcoreinfo directly instead of
>    splitting dump_init()/dump_preinit() and stopping the vCPUs.
>  - Add dump-guest-memory qtests.
>
> Denis V. Lunev (7):
>   migration: add migration_guest_ram_loading() helper
>   dump: refuse dump-guest-memory while guest RAM is being migrated
>   system/cpus: refuse memsave/pmemsave while guest RAM is being migrated
>   dump: make win_dump_available() check vmcoreinfo for a Windows dump
>     header

Looks all good to me, except it needs
s/cpu_physical_memory_read/physical_memory_read now. I can do that on
MR

Philippe, do you know why physical_memory_read/write() do not return
MemTxResult?

>   tests/qtest: add dump-guest-memory test
>   tests/qtest/dump: reject win-dmp without vmcoreinfo
>   tests/qtest/dump: cover win-dmp availability via vmcoreinfo
>
>  MAINTAINERS              |   1 +
>  dump/dump.c              |   5 +-
>  dump/win_dump-x86.c      |  42 +++++
>  include/migration/misc.h |   3 +
>  migration/migration.c    |   6 +
>  system/cpus.c            |  11 ++
>  tests/qtest/dump-test.c  | 331 +++++++++++++++++++++++++++++++++++++++
>  tests/qtest/meson.build  |   1 +
>  8 files changed, 398 insertions(+), 2 deletions(-)
>  create mode 100644 tests/qtest/dump-test.c
>
>
> base-commit: c7cf7c810153d6f5f31aa2d5c0dee9087f6b4dff
> --
> 2.53.0
>
>

