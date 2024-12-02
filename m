Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 391D3E69E8C
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 19:50:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tICQj-0008NN-7H; Mon, 02 Dec 2024 14:50:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tICQd-0008Il-T7
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:49:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tICQR-00081y-9J
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 14:49:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733168980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HEoVcYVMdczLfCB29k2A4V9yDYwKiimj/pYqF1U+rwA=;
 b=ZHcbucdhzua30YawHUv+Ru609fSzGxCDH6NHogoj/IOdQ6V4U4fWF0usmdWVWynh7CJ5GO
 nf3L22IB30q+D6Pc5lQVyEtU61Qp2H0nazhg2mDzHFQW3IUSSpW3JFDNpCdGnnu5rBC4PJ
 U1alueC4HoJJnNhPhejnTveWzB7O2zU=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-_5ZkJ71WM-WyQLrXd2aaAg-1; Mon, 02 Dec 2024 14:49:37 -0500
X-MC-Unique: _5ZkJ71WM-WyQLrXd2aaAg-1
X-Mimecast-MFC-AGG-ID: _5ZkJ71WM-WyQLrXd2aaAg
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-843faa97bf9so436859939f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 11:49:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733168977; x=1733773777;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HEoVcYVMdczLfCB29k2A4V9yDYwKiimj/pYqF1U+rwA=;
 b=F1rHM6IVvz3hKgFmCP3mHoTLw8mcD8Baq7ZHfggkFJoxzRfbxOewvbaAfMr0vLIDYs
 eWN3Scp7VkWaE/CY5XxDZWaWUnlyzQkRM0bmwnAwDjF20q0Pn0xpiHm2+WrHsIV8+C46
 /G6QJCwpMwTVDocQW3OwyoLslGkAh6l0UJMB0bt7VL6e31gaCP11QNbl0whSUwiwS5hx
 lUzHYmvYgnw3/IY/GPVibH5SWBuPeBvv3ko6Iaald1w4f6MYCZZ+zlQbqrDsWDlG+AlG
 UEXkEgq2N2+NsiMTTl87KMCQFZcmvy2hZDgsaiapZOj0NhcNEmO3LmCNiQu5bfUgUG7Q
 DsIg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHGn107c3Tj+HHzicXDs5f45SL0CR+QDjpd3JN9a5VCbHZUX84S/ZeBSN/MpfMCAPRuXJCLkz2XSPi@nongnu.org
X-Gm-Message-State: AOJu0Ywsni+xUsAWoiMghW1ot+wC56lcSrl8pyX2+F4bCtyX/MU/Zlb0
 YJRHb2IoISuRQCq+XMhYbHOxu6XtTsOkkytmFRa2gwYmesRbjIvMPfyeUYBVelz4L1WZUPTonKq
 5sGEjKzdE8oJlVYbCU+DV5gve1YCfEbaisQVw4sWpkE8q9BXWDseG
X-Gm-Gg: ASbGncvH1RwVIGkFHx7mbu87cznUv91UKxZ7PvzafIHlIVPesARjGmhUK2x6Q7oxsXl
 nIrdfyHGPTesa98473PGTm8zBWyVhJT9gBnwOo3+tCWrRzHMrIOBSkh4qMm4NzBuYrqCDRpsoNb
 1XKlhhEFCBJfn5z7e+4H+whRRIisuVCin7bFN7cy5nC0i+PYGmDsqIZToGSb0RKoPFuH1KncbrU
 jTPfY/Gb8ZPvP8Z55OCvF2r8FqE+I4IrPowU9/0klZwFaM7WNmF9iinx8PV03lY6RgMHd4AC1PT
 cc38BfdVgtI=
X-Received: by 2002:a05:6e02:1a02:b0:3a7:be5e:e22d with SMTP id
 e9e14a558f8ab-3a7c55237d6mr256039025ab.2.1733168976709; 
 Mon, 02 Dec 2024 11:49:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAtEN+YBtzyAo4j1PS3IMAGbj+Dp38jOryiMoyGhl2BqJYKfSpb/F9wGp8jJKy9Lj6zFt8gw==
X-Received: by 2002:a05:6e02:1a02:b0:3a7:be5e:e22d with SMTP id
 e9e14a558f8ab-3a7c55237d6mr256038815ab.2.1733168976357; 
 Mon, 02 Dec 2024 11:49:36 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e230dc9d20sm2217975173.45.2024.12.02.11.49.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Dec 2024 11:49:35 -0800 (PST)
Date: Mon, 2 Dec 2024 14:49:33 -0500
From: Peter Xu <peterx@redhat.com>
To: Yong Huang <yong.huang@smartx.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH v3 0/5] Guestperf: miscellaneous refinement and enrichment
Message-ID: <Z04PTe4kCVWEQbPL@x1n>
References: <cover.1729562974.git.yong.huang@smartx.com>
 <87sesmdfl4.fsf@suse.de>
 <CAK9dgmZvj4W2EBxp1_TcdYs3q2aqaRZGZCAk=FRJk-PaB9y_fw@mail.gmail.com>
 <87v7w6jkc9.fsf@suse.de> <87plmejgtb.fsf@suse.de>
 <CAK9dgmbHL+O34+E3ykDdAunap+Ruubm7ysisrMags6TN25BiNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK9dgmbHL+O34+E3ykDdAunap+Ruubm7ysisrMags6TN25BiNQ@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Sat, Nov 30, 2024 at 10:01:43PM +0800, Yong Huang wrote:
> On Fri, Nov 29, 2024 at 9:44 PM Fabiano Rosas <farosas@suse.de> wrote:
> 
> > Fabiano Rosas <farosas@suse.de> writes:
> >
> > > Yong Huang <yong.huang@smartx.com> writes:
> > >
> > >> On Wed, Oct 23, 2024 at 11:06 PM Fabiano Rosas <farosas@suse.de> wrote:
> > >>
> > >>> yong.huang@smartx.com writes:
> > >>>
> > >>> > From: Hyman Huang <yong.huang@smartx.com>
> > >>> >
> > >>> > v3:
> > >>> > 1. Remove the two redundant assignments in [PATCH v2 2/5] suggested
> > by
> > >>> Daniel
> > >>> >
> > >>> > Please review, thanks
> > >>> > Yong
> > >>> >
> > >>> > v2:
> > >>> > 1. Update the MAINTAINERS section suggested by Fabiano Rosas
> > >>> > 2. Ensure the dependencies when build the initrd-stress.img
> > suggested by
> > >>> Daniel
> > >>> > 3. Fix some bugs
> > >>> >
> > >>> > v1:
> > >>> > The previous patchset:
> > >>> >
> > >>>
> > https://lore.kernel.org/qemu-devel/cover.1722957352.git.yong.huang@smartx.com/
> > >>> > does not made the necessary changes and tests for the upstream
> > version.
> > >>> >
> > >>> > This patchset works for that:
> > >>> > 1. Move the guestperf to scripts directory suggested by Fabiano Rosas
> > >>> > 2. Make initrd-stress.img built by default suggested by Fabiano Rosas
> > >>> > 3. Make the necessary changes to adapt the latest multifd behavior
> > >>> > 4. A nitpick for multifd migration
> > >>> > 5. Support multifd compression option
> > >>> >
> > >>> > Hyman Huang (5):
> > >>> >   tests/migration: Move the guestperf tool to scripts directory
> > >>> >   tests/migration: Make initrd-stress.img built by default
> > >>> >   guestperf: Support deferred migration for multifd
> > >>> >   guestperf: Nitpick the inconsistent parameters
> > >>> >   guestperf: Introduce multifd compression option
> > >>> >
> > >>> >  MAINTAINERS                                   |  5 +++
> > >>> >  .../migration/guestperf-batch.py              |  0
> > >>> >  .../migration/guestperf-plot.py               |  0
> > >>> >  {tests => scripts}/migration/guestperf.py     |  0
> > >>> >  .../migration/guestperf/__init__.py           |  0
> > >>> >  .../migration/guestperf/comparison.py         | 15 ++++++++-
> > >>> >  .../migration/guestperf/engine.py             | 33
> > ++++++++++++++++---
> > >>> >  .../migration/guestperf/hardware.py           |  0
> > >>> >  .../migration/guestperf/plot.py               |  0
> > >>> >  .../migration/guestperf/progress.py           |  0
> > >>> >  .../migration/guestperf/report.py             |  0
> > >>> >  .../migration/guestperf/scenario.py           |  7 ++--
> > >>> >  .../migration/guestperf/shell.py              |  3 ++
> > >>> >  .../migration/guestperf/timings.py            |  0
> > >>> >  tests/migration/meson.build                   | 30 +++++++++--------
> > >>> >  15 files changed, 73 insertions(+), 20 deletions(-)
> > >>> >  rename {tests => scripts}/migration/guestperf-batch.py (100%)
> > >>> >  rename {tests => scripts}/migration/guestperf-plot.py (100%)
> > >>> >  rename {tests => scripts}/migration/guestperf.py (100%)
> > >>> >  rename {tests => scripts}/migration/guestperf/__init__.py (100%)
> > >>> >  rename {tests => scripts}/migration/guestperf/comparison.py (89%)
> > >>> >  rename {tests => scripts}/migration/guestperf/engine.py (93%)
> > >>> >  rename {tests => scripts}/migration/guestperf/hardware.py (100%)
> > >>> >  rename {tests => scripts}/migration/guestperf/plot.py (100%)
> > >>> >  rename {tests => scripts}/migration/guestperf/progress.py (100%)
> > >>> >  rename {tests => scripts}/migration/guestperf/report.py (100%)
> > >>> >  rename {tests => scripts}/migration/guestperf/scenario.py (93%)
> > >>> >  rename {tests => scripts}/migration/guestperf/shell.py (98%)
> > >>> >  rename {tests => scripts}/migration/guestperf/timings.py (100%)
> > >>>
> > >>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > >>>
> > >>>
> > >>> Thinking out loud a little bit, it's still somewhat obscure from which
> > >>> directory this script should be called. None of these invocations work:
> > >>>
> > >>> $ ./scripts/migration/guestperf.py
> > >>>
> > >>> $ ./build/scripts/migration/guestperf.py
> > >>>
> > >>> $ cd scripts/migration
> > >>> $ ./guestperf.py
> > >>>
> > >>> $ cd build/scripts/migration
> > >>> $ ./guestperf.py
> > >>>
> > >>> Failed to open file “tests/migration/initrd-stress.img”: open() failed:
> > >>> No such file or directory
> > >>>
> > >>> This is the only one that works:
> > >>> $ cd build
> > >>> $ ./scripts/migration/guestperf.py
> > >>>
> > >>> Maybe we could improve that somehow in the future.
> > >>>
> > >>>
> > >> This patchset could be queued now,
> > >> Or after refining the documents mentioned above later?
> > >
> > > I think it's ok. Let me just rebase this on top of the other series that
> > > touches the tests/migration/ directory. I'll repost soon.
> >
> > Well, not so fast, the CI doesn't like the addition of stress.c:
> >
> > https://gitlab.com/farosas/qemu/-/jobs/8504697373
> > clang: error: argument unused during compilation: '-pie'
> 
> 
> > https://gitlab.com/farosas/qemu/-/jobs/8504697378
> > undefined reference to `_DYNAMIC'
> >
> 
> OK, I'll fix that once I have time.

Yong,

Note that the conflict is against this patch (now in migration-next, so
will be in 10.0's pull):

https://lore.kernel.org/r/20241127182901.529-4-farosas@suse.de

When you rebase, feel free to do that on top of migration-next if it didn't
yet land master branch, could be easier for all of us:

https://gitlab.com/peterx/qemu/-/tree/migration-next

For the stress.c warnings/error, I saw another one warning with gcc when
built it locally, then I found Fabiano's CI run also has it:

https://gitlab.com/farosas/qemu/-/jobs/8504697347

Which has:

[3381/3611] Linking target tests/migration/stress
/usr/bin/ld: /usr/lib64/libglib-2.0.a(gutils.c.o): in function `g_get_user_database_entry':
(.text+0xeb): warning: Using 'getpwnam_r' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
/usr/bin/ld: (.text+0x2be): warning: Using 'getpwuid' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking
/usr/bin/ld: (.text+0x134): warning: Using 'getpwuid_r' in statically linked applications requires at runtime the shared libraries from the glibc version used for linking

Feel free to look at it too if you like. Nothing should be relevant to your
changes, so I think it could be there for a while when compilers upgrade.

Thanks,

-- 
Peter Xu


