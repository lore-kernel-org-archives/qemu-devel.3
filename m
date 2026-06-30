Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A7BC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 11:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weWYJ-0003P9-Gr; Tue, 30 Jun 2026 07:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1weWYG-0003Os-Un
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 07:22:53 -0400
Received: from mail-dy1-x132f.google.com ([2607:f8b0:4864:20::132f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1weWYF-0005TM-5G
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 07:22:52 -0400
Received: by mail-dy1-x132f.google.com with SMTP id
 5a478bee46e88-30bc871ecdfso5837043eec.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 04:22:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782818569; cv=none;
 d=google.com; s=arc-20260327;
 b=jkETImRkFHKREuzh6CqGSNTk8+ZXtRpFWlSU9TjiHxStCOpuZpmqlhcElyXJh5m+Xp
 OfQ+7DbsxVjJnKDhpMuEePOOhkVkJ6h3/rPzkWieeIYvtds8jTlviKHA73il30ytS28u
 wnCL837hEx5LLLsgKvdxvBFWc4Sh+U+VYpUBMG6IcR5rPR38rJnG4E10HBWx4PaDRxt8
 KHAQ4tGQUIRPdjW9+AykVcoaLxZZEE3vaoZKKvWE/zZk4HA2fe2MzRYG/4DZe/Gcgj77
 oyL3546mofFK1ElRs2hAeLZnCzErelHB5VzF7mRiP7AYr4nYM7GLsuoXCbMPLurhYR2O
 PCfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=7sXmEGHGpLey7+onlSpijll094OWNX58UK/ut0j0Rbc=;
 fh=iajTSHmt/wIYi3CFWQCzliPQTMZQKiSTc02uxYOTQwQ=;
 b=c8ftQ4MFGAzZqfoDRfWhCixce9L9a3KxOA2Ji+V02Q5NQNh1yy0FpkQwAE/qdUnKy4
 Dk01pmct9hbPRxtcjczkC2fsOT7JhaCqhX/WD+0gI9kH4UMKlYdQ0Ft399fVY7TjosW6
 wDAgmEkh8dLw5OzHEm8wYy3Fzb1RxSS4FY0vT39O0diuMvsKahtMACoGEOJFTWNfdm1m
 PfYAUic6pbKM5C25pMXzut4LGKVfgZRI/SQjxn33dRczbEFRreFGCGPfrU6LFZjJG86s
 AyukrALV208WVxKABC/fPr4zzuiBo9ymiWJChWh5mso/wBC1R6ZH+b9BI5i7uYxhUbLB
 OxFQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782818569; x=1783423369; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7sXmEGHGpLey7+onlSpijll094OWNX58UK/ut0j0Rbc=;
 b=Htku05/zkzqfvyUbZoMj4AKA69mu3oC+5doE1NBUA+CdArFsj3j2X3HMY0QtzpGbxE
 OaMJ4dhuc9OqSLcvpjutu0EjbbJnX1alZGo/ZSsV7RWkr4dq2RwPXg4yAVqNVRuqni4V
 UNntWgCsDzmXT6ZuuAHVMIejSaySQ0OOX6IMezW0UiXUQTQFNe63EddHR3cTBGpldSBD
 hGvIyOzumZQota+YtICsL5BeUVPhKUeVbvrpqWFPjI8rVQnYNq4r+AGIX8L28oZH97iD
 DBvOG3DvL4R+r+wbehMwux1odLT1OYAcNgMG+4oAGPW5IVElBfKTkrlMYEbRMTrhWEmD
 TEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782818569; x=1783423369;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7sXmEGHGpLey7+onlSpijll094OWNX58UK/ut0j0Rbc=;
 b=WlQFDs+9ySGm3DobMlm80tqctlhh15bEUwYEJrsbTTjA5AtATCa6N60p7UQr9uVJ6l
 FK9y9AvnopgEp6LtNN3Z7pjjFoT86yhERqruZE+mJxyzbQ+UjBaolQvG/zGgaGAfwPVD
 C9TdE0w8+7lK8vnr0i8ArksFaueEzHA8iEUkKRWNWMFn5WiiupUjWULnGJSQuo03IyUu
 7AsrVwGMO1U87XfJunnT/EyJ5yFPoQCBe51eUiRPEQmoYGVsTXMfj6D0bKi7bajdSreo
 2oIrEBgMZKkOba54ZnjICHUJDLb5cYnTCy8pfCO2OZ4RFSiI/2XG8RjFwmiYnj6on5sB
 Gq4Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro/wZdnKHOPb62VCwW8GyUBwWDnlYbHpauMH1+l4KagVwK0+WrMhlqtw311sGHQgFw2GG9+6vl0Dx9k@nongnu.org
X-Gm-Message-State: AOJu0Yx6sLsrsgXJ0PKYbbAOC8rZgvUSta09/JV/6E72moRDkoZei0GY
 C1NlADrMqsoEN6gss1zWP5c4Qc3u2gTM59jomyxcMp4gMysVISVA6ftDX8T8Llv826RIGJzAWSe
 ebumyGJ3TD6lsrxrNqCANtdQPw0fkdAc=
X-Gm-Gg: AfdE7ckRGEihRRKtpQgHyoGGK1ATOWLlHEFiZ95yyZ2KGb/ddw9f+uBgDWVW9aFLYdm
 K6oSYVwG/Lu8S0QZWaQv4xagUu+uCJV3Wq7ylldLexMuDsM7Vfzsoi8M+Vk3GSoe2Sao9UO5ZY3
 g4OXMjPEiFc0wedpxcsJpQqpjClH8DkgP6egOta4QjoVLkCLuri3DetgCZoFjatUk7BKFTWkWU2
 qE/d4wBDLFofu7LUNXFjfb00gbPOyQ7j9XkXKyt38MJX68s1RWOZCxxNJLsdLah05Fsxbikc5+u
 tcgxoTF80W0BnAFkTq/+n4BTLojoTqcLv5OOu3I=
X-Received: by 2002:a05:693c:2d98:b0:30c:55f2:1e32 with SMTP id
 5a478bee46e88-30ee12f0fa8mr2195713eec.6.1782818569069; Tue, 30 Jun 2026
 04:22:49 -0700 (PDT)
MIME-Version: 1.0
References: <20260619101834.228432-1-den@openvz.org>
 <9aeb2a71-49ef-477e-a67b-1c509bbf99eb@virtuozzo.com>
In-Reply-To: <9aeb2a71-49ef-477e-a67b-1c509bbf99eb@virtuozzo.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 30 Jun 2026 15:22:37 +0400
X-Gm-Features: AVVi8CfSV4deNskSA9Ig3xiyWdD5-I9cVI3W7hH0zeki7-aUOjg5OkJUoeYhZew
Message-ID: <CAJ+F1CK_EBDfHhJdydEgFAe4qAz5MycduC7n_AMauqd-uJJgZg@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] dump: report win-dmp via vmcoreinfo, guard
 guest-RAM reads during migration
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org,
 anisinha@redhat.com, 
 berrange@redhat.com, peterx@redhat.com, farosas@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::132f;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-dy1-x132f.google.com
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

On Tue, Jun 30, 2026 at 3:04=E2=80=AFPM Denis V. Lunev <den@virtuozzo.com> =
wrote:
>
> On 6/19/26 12:18, Denis V. Lunev wrote:
> > This series fixes Windows-dump (win-dmp) availability reporting and clo=
ses
> > a related hole found while doing so: several commands read guest RAM an=
d
> > must not run while a migration destination is still receiving it.
> >
> > dump-guest-memory, memsave and pmemsave all read guest RAM on the main
> > thread with the BQL held. On a migration destination that RAM is either
> > still being loaded (precopy) or pulled from the source on demand
> > (postcopy, where the guest already runs). During precopy the read retur=
ns
> > incomplete data; during postcopy it deadlocks, as the read faults on a
> > not-yet-received page while the postcopy incoming path needs the BQL th=
e
> > reader holds to install it. dump-guest-memory only guarded the precopy
> > phase and memsave/pmemsave had no guard at all, so a new
> > migration_guest_ram_loading() predicate captures both phases and all
> > three commands now use it.
> >
> > query-dump-guest-memory-capability also advertised win-dmp for every x8=
6
> > VM, and dump-guest-memory accepted it unconditionally; win-dmp only wor=
ks
> > when the guest has published a Windows dump header through vmcoreinfo.
> > win_dump_available() now reads that note back from the vmcoreinfo devic=
e
> > and validates it, keeping its original signature, so the dump.c call si=
tes
> > are unchanged.
> >
> > The series also adds the first qtest coverage for dump-guest-memory:
> > capability list, ELF and kdump output, protocol errors, and win-dmp
> > reporting in both directions (the positive case forges a vmcoreinfo not=
e,
> > so no Windows guest is needed).
> >
> > Tested:
> >  - Linux guest: win-dmp not advertised; an explicit win-dmp request is
> >    rejected without stopping the guest; elf/kdump dumps work.
> >  - Windows Server 2022 guest: win-dmp advertised once vmcoreinfo is
> >    populated; dump-guest-memory format=3Dwin-dmp produces a valid (PAGE=
DU64)
> >    crashdump.
> >  - Live postcopy migration: on the destination, dump-guest-memory, mems=
ave
> >    and pmemsave are all refused immediately, without faulting a page.
> >
> > This supersedes the earlier "dump: enhance win_dump_available to report
> > properly" series, which obtained the note by reusing the dump setup pat=
h
> > (splitting dump_init() and stopping the vCPUs). Reading vmcoreinfo
> > directly is much smaller.
> >
> > Changes since v4:
> >  - Refuse guest-RAM reads (dump-guest-memory, memsave, pmemsave) while =
a
> >    migration destination is still receiving RAM, via a shared
> >    migration_guest_ram_loading() helper.
> >  - Decide win-dmp availability by reading vmcoreinfo directly instead o=
f
> >    splitting dump_init()/dump_preinit() and stopping the vCPUs.
> >  - Add dump-guest-memory qtests.
> >
> > Denis V. Lunev (7):
> >   migration: add migration_guest_ram_loading() helper
> >   dump: refuse dump-guest-memory while guest RAM is being migrated
> >   system/cpus: refuse memsave/pmemsave while guest RAM is being migrate=
d
> >   dump: make win_dump_available() check vmcoreinfo for a Windows dump
> >     header
> >   tests/qtest: add dump-guest-memory test
> >   tests/qtest/dump: reject win-dmp without vmcoreinfo
> >   tests/qtest/dump: cover win-dmp availability via vmcoreinfo
> >
> >  MAINTAINERS              |   1 +
> >  dump/dump.c              |   5 +-
> >  dump/win_dump-x86.c      |  42 +++++
> >  include/migration/misc.h |   3 +
> >  migration/migration.c    |   6 +
> >  system/cpus.c            |  11 ++
> >  tests/qtest/dump-test.c  | 331 +++++++++++++++++++++++++++++++++++++++
> >  tests/qtest/meson.build  |   1 +
> >  8 files changed, 398 insertions(+), 2 deletions(-)
> >  create mode 100644 tests/qtest/dump-test.c
> >
> >
> > base-commit: c7cf7c810153d6f5f31aa2d5c0dee9087f6b4dff
> Hello, Marc-Andre!
>
> Should I do something with this series or it is good to
> go in. Its final destiny is unclear for me at the
> moment.
>
> Can you shed some light with it?

I'll prepare a PR. thanks

