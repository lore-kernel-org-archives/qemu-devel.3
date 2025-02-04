Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A3DC02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 14:48:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfKDK-0007vi-7C; Tue, 04 Feb 2025 09:47:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfKDI-0007t6-U0
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 09:47:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tfKDH-0005lk-0o
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 09:47:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738680452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ycb8MdhLNYc68pS4VNjC+5DVI72g9Ja3t1up8hvyurU=;
 b=VCTxUh4T/YQk2wYVfn9Kl8pfvI/6ms+vacA1Z2lNOZ2SPfTPxHL2vcDF63qTbe3yS5/+YN
 DHasNBrGSL8PqCazy9ooRprLDSQEZSfeAw2NObajNMk2Utbh/cEHGxly2PBSUbj7cwizvf
 r24B1s7uuQkg37AhE8utKVCEbbxC+rc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-WETwsLtbNGq_GBQk9s8J_Q-1; Tue, 04 Feb 2025 09:47:30 -0500
X-MC-Unique: WETwsLtbNGq_GBQk9s8J_Q-1
X-Mimecast-MFC-AGG-ID: WETwsLtbNGq_GBQk9s8J_Q
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7b6e6cf6742so1623411185a.3
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 06:47:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738680448; x=1739285248;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ycb8MdhLNYc68pS4VNjC+5DVI72g9Ja3t1up8hvyurU=;
 b=f3mdCxz3i3t0YvYCUTjebEZ6oikzotPSDHI3a29JVsNc2yF/95AMvUblhIQ/LHpK8m
 x4yPss9CFs1mA5m8LsoQr2kY8Ss//xagEoPCKPNgiENnCa5tGjZSORz94tvKPewxDYP/
 vy2nd1XAknnVK018iF1POA72j1CVBtMgV2j/PEjUV1jauJMROPn5Q5jHndoxR1nYxYZ6
 XHqAxGSJBgJiTRtV1h1xysGKjsTp4O4YrP6lw6Nlc8mVdJJcW+2se+R/e7oZ4AnQffKy
 NTyOUF1rW99P9x8N9omxlWRNANKTTOJJWjvmZERJB2ao5Ez+wFvMF6yhk/32kv0LbtQm
 5N3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCaGsHnId2zzOOF2a9eSiLFjTV8fEwmYN30WwntwakX85S1NawSlznQ6RX3d3LGNkUPfin/Fe0SM/9@nongnu.org
X-Gm-Message-State: AOJu0YwYsu+3rHCPLHNeKFhxMxHgt5f1dNyIEoWzuHeXjg9JG2o8zrb7
 ZG9OzDiuomd7wBkNjvwM8kqhgXrbDGUCuRTIVosTZ8j33kUrvri6Yr8XpplDHm5DfagS5iMSW28
 28LaoGLoSBY+bq5v2bcb1Nm4ShYOT3c6f8G1i8tc5a2X9Jo1B9xRb
X-Gm-Gg: ASbGncvjKBCZlfxmTbf2uv8slw1VLZiuhDYJNMZp6ZQI8DZ5sioOJl9RwG9jOZddZwC
 HirYLCltf+Ano84Uluk43yBDsC2vMpjjG1PNLddjy6I8z9/EpY4cLiYJ/Yo+dO7ItaAJXZd6Nzc
 hxW83WseoeWTBbFZx/X5h9yyT7J7jAUjLgysuM/inwSCQ5m0aKlJwUzTVuQ6cA0GY0AS2dgifDj
 pFz3tRd5D+9koVTBI9gjJPM16xah+ofbJ92lg46XMsJiisq4AB4+QgT7He7zJCkOYvx/jp6OZzn
 Knmg/zWG6rjF9xVUNbViSwx93KO1G2UKPrIywkS8Rwuvnp8d
X-Received: by 2002:a05:620a:8088:b0:7b6:d6ff:86ba with SMTP id
 af79cd13be357-7bffcd99e37mr3762005385a.52.1738680448560; 
 Tue, 04 Feb 2025 06:47:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUxti8JHHRpKYeuHGqslWSlWEh1eCWXjv4Q0SgjAL3XOWnHSa4b+64HNM3tG/r0rzRqKfWUw==
X-Received: by 2002:a05:620a:8088:b0:7b6:d6ff:86ba with SMTP id
 af79cd13be357-7bffcd99e37mr3762002785a.52.1738680448246; 
 Tue, 04 Feb 2025 06:47:28 -0800 (PST)
Received: from x1.local (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c00a8d96ecsm642772285a.62.2025.02.04.06.47.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 06:47:27 -0800 (PST)
Date: Tue, 4 Feb 2025 09:47:26 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PATCH v4 0/4] overcommit: introduce mem-lock-onfault
Message-ID: <Z6Iofl0pp1xDENHz@x1.local>
References: <20250123131944.391886-1-d-tatianin@yandex-team.ru>
 <Z5Ju0ZnR6KEEF-Bu@x1n>
 <1abc7363-21be-4a9e-a946-c50deb266dea@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1abc7363-21be-4a9e-a946-c50deb266dea@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Feb 04, 2025 at 11:23:41AM +0300, Daniil Tatianin wrote:
> 
> On 1/23/25 7:31 PM, Peter Xu wrote:
> > On Thu, Jan 23, 2025 at 04:19:40PM +0300, Daniil Tatianin wrote:
> > > Currently, passing mem-lock=on to QEMU causes memory usage to grow by
> > > huge amounts:
> > > 
> > > no memlock:
> > >      $ ./qemu-system-x86_64 -overcommit mem-lock=off
> > >      $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
> > >      45652
> > > 
> > >      $ ./qemu-system-x86_64 -overcommit mem-lock=off -enable-kvm
> > >      $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
> > >      39756
> > > 
> > > memlock:
> > >      $ ./qemu-system-x86_64 -overcommit mem-lock=on
> > >      $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
> > >      1309876
> > > 
> > >      $ ./qemu-system-x86_64 -overcommit mem-lock=on -enable-kvm
> > >      $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
> > >      259956
> > > 
> > > This is caused by the fact that mlockall(2) automatically
> > > write-faults every existing and future anonymous mappings in the
> > > process right away.
> > > 
> > > One of the reasons to enable mem-lock is to protect a QEMU process'
> > > pages from being compacted and migrated by kcompactd (which does so
> > > by messing with a live process page tables causing thousands of TLB
> > > flush IPIs per second) basically stealing all guest time while it's
> > > active.
> > > 
> > > mem-lock=on helps against this (given compact_unevictable_allowed is 0),
> > > but the memory overhead it introduces is an undesirable side effect,
> > > which we can completely avoid by passing MCL_ONFAULT to mlockall, which
> > > is what this series allows to do with a new option for mem-lock called
> > > on-fault.
> > > 
> > > memlock-onfault:
> > >      $ ./qemu-system-x86_64 -overcommit mem-lock=on-fault
> > >      $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
> > >      54004
> > > 
> > >      $ ./qemu-system-x86_64 -overcommit mem-lock=on-fault -enable-kvm
> > >      $ ps -p $(pidof ./qemu-system-x86_64) -o rss=
> > >      47772
> > > 
> > > You may notice the memory usage is still slightly higher, in this case
> > > by a few megabytes over the mem-lock=off case. I was able to trace this
> > > down to a bug in the linux kernel with MCL_ONFAULT not being honored for
> > > the early process heap (with brk(2) etc.) so it is still write-faulted in
> > > this case, but it's still way less than it was with just the mem-lock=on.
> > > 
> > > Changes since v1:
> > >      - Don't make a separate mem-lock-onfault, add an on-fault option to mem-lock instead
> > > 
> > > Changes since v2:
> > >      - Move overcommit option parsing out of line
> > >      - Make enable_mlock an enum instead
> > > 
> > > Changes since v3:
> > >      - Rebase to latest master due to the recent sysemu -> system renames
> > > 
> > > Daniil Tatianin (4):
> > >    os: add an ability to lock memory on_fault
> > >    system/vl: extract overcommit option parsing into a helper
> > >    system: introduce a new MlockState enum
> > >    overcommit: introduce mem-lock=on-fault
> > > 
> > >   hw/virtio/virtio-mem.c    |  2 +-
> > >   include/system/os-posix.h |  2 +-
> > >   include/system/os-win32.h |  3 ++-
> > >   include/system/system.h   | 12 ++++++++-
> > >   migration/postcopy-ram.c  |  4 +--
> > >   os-posix.c                | 10 ++++++--
> > >   qemu-options.hx           | 14 +++++++----
> > >   system/globals.c          | 12 ++++++++-
> > >   system/vl.c               | 52 +++++++++++++++++++++++++++++++--------
> > >   9 files changed, 87 insertions(+), 24 deletions(-)
> > Considering it's very mem relevant change and looks pretty benign.. I can
> > pick this if nobody disagrees (or beats me to it, which I'd appreciate).
> > 
> > I'll also provide at least one week for people to stop me.
> 
> I think it's been almost two weeks, so should be good now :)

Don't worry, this is in track.  I'll send it maybe in a few days.

Thanks,

-- 
Peter Xu


