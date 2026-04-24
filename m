Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 925EBFED3E4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 15:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGIFz-0004I6-9w; Fri, 24 Apr 2026 11:15:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wGIFp-0004Fh-Td
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 11:15:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wGIFh-0006vY-Ct
 for qemu-devel@nongnu.org; Fri, 24 Apr 2026 11:15:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777043725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Xk050h+C6Ui8v/CgnCqcFsZ/JeOhaDOsp8ICXsF+n6Y=;
 b=NTBbt3gyL+cdqknT/Y+eUYOqL30QfbwUJb0l5CL15xFqMgETgy2r+9P7Hj00oolsZMsO4l
 PZwStAP+xYO7QHSQf3LMBzXONaVlDS4soqCT/OO47KNAL4rJ3RCKqWoGyq6cSGBkOe4nVB
 vNXnj5i+xAgSsGK/+65HqaTcGleRfWI=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-4cp3cRFVOeS7lWuQZRPl7w-1; Fri, 24 Apr 2026 11:15:24 -0400
X-MC-Unique: 4cp3cRFVOeS7lWuQZRPl7w-1
X-Mimecast-MFC-AGG-ID: 4cp3cRFVOeS7lWuQZRPl7w_1777043723
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50faf575af4so125153331cf.0
 for <qemu-devel@nongnu.org>; Fri, 24 Apr 2026 08:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777043723; x=1777648523; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Xk050h+C6Ui8v/CgnCqcFsZ/JeOhaDOsp8ICXsF+n6Y=;
 b=VgtsUOAiTH5IDvymQ5h810P38Z2xevJWulhsziFkXB9f7evAHf6bbkYVil8CdBVqmP
 QHLkOldxnnaMoltYeGK5XvAeufRtWzCecucTnpHnfnCBQVHzJbNopavI5CLYjz2+j4Hk
 fe09CJPeEHSs+OoEb109bsf9GaPFt4kEN+a+sSJ014dgnSNkq5/gU9wOlGOsVz8JdcMJ
 bKhtGdIc3czUKeZdvFFiwf8wEWZc22p8UXYGOjkcIhbHCzlIVdwmkpAmZQNonGV8z2Gc
 EDEmbqtVIrR+rANHNuQxusnQaEfHw32293VSaA6yHqSPperpk8iv7+gF/zVkzj98Oc7w
 ATgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777043723; x=1777648523;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xk050h+C6Ui8v/CgnCqcFsZ/JeOhaDOsp8ICXsF+n6Y=;
 b=bbmTt5gq8PloZsa6QBQnqWXA1RZCl5RUJPQtWiMbFa+rd1ZsEDvjB65pCNNZkHdfcT
 xiFm4Sstq4/a1FNFEViB2u8xsUZa6VatOQ5yJcy3KYf1nNcxPFD8DLmjNLAN2vfOWosK
 SgfvICSAAzwhPn1gyT1WJyNhWcjkFsTD0qkZdfLVhoHRKjKO/BsaJvLw7RSBMcYW6e2/
 L95eR28a1KkMMDsZZabxBXuILNoRVxcpXAj26YGWXvPLeDy9i/E3u9lLAjPlp8gj5xWs
 YAnVE4AZAhBRYy/p+xz6382wSqcrlCP6KfpdRUr29IedMTBTLZ2qupB3+LAZsd9+uWTV
 Oy8g==
X-Gm-Message-State: AOJu0Yzdrmvhc8VAGZnrpSPR70zWyh005VggNz79LBpFO4btiZdsH/6K
 kHPQ4hkQ4QGFU9MlkKB2hsep8RvAHqPPq0KB1bbZB0wNIcdQ0wuWf9AUnUNRWPPqpKQTBjGLZEm
 H05S+GSCDezSu969QPJiJ/55Mc/z7eoHUOAiBdVGde59HMI/uJt1uX5gx
X-Gm-Gg: AeBDievBvNfDKbPMF8v8U+QtQim53MwyqiXwEaM/xLFyBpd6N+u1MjldXlLBL1pxW46
 hXhHb1bhfeIbkZDDREhRmve5RkP0w4QQhxey8/6ckHrHrexLq7dryKW6L5uWrq2ym27WZ60iv9W
 RJNipID37EPQVQ7AbeJ4uj+5hGjLsephl8255UoITQOIn4cT1GyBWHjHA0qiOYumTel0YPmbhQ0
 KQJGFiKUYI4Og5d2hnNKINnesTLq3tbQLNmJN+johWCqCXZTWmdx9EN7jwbjjZOr4JTTKA5DwTv
 9hYzjIKoXuOMQ+1Bmeb9dCtiqKo0dyl+UHK4fXJi6cu0v3ub9+kwvcARFahxJ5Ym0rKPyVGX0mp
 ID9Ki3wr+hEtdC+tGojHiPWHWBJKUE9ZGDKE+QUaDM0RsESjM6NDsOVoyfg==
X-Received: by 2002:a05:622a:4d98:b0:50e:614e:4428 with SMTP id
 d75a77b69052e-50e614e4711mr314323811cf.37.1777043723196; 
 Fri, 24 Apr 2026 08:15:23 -0700 (PDT)
X-Received: by 2002:a05:622a:4d98:b0:50e:614e:4428 with SMTP id
 d75a77b69052e-50e614e4711mr314322531cf.37.1777043722492; 
 Fri, 24 Apr 2026 08:15:22 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50fb92db861sm94054631cf.5.2026.04.24.08.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 08:15:21 -0700 (PDT)
Date: Fri, 24 Apr 2026 11:15:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Joao Martins <joao.m.martins@oracle.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Prasad Pandit <ppandit@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 Kirti Wankhede <kwankhede@nvidia.com>, Zhiyi Guo <zhguo@redhat.com>,
 "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Juraj Marcin <jmarcin@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v2 14/16] migration/qapi: Introduce system-wise
 "remaining" reports
Message-ID: <aeuJCI0OCW-ohJih@x1.local>
References: <20260421202110.306051-1-peterx@redhat.com>
 <20260421202110.306051-15-peterx@redhat.com>
 <87cxzovncu.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87cxzovncu.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Apr 24, 2026 at 09:17:21AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > Currently, mgmt can only query for remaining RAM,
> 
> Remind me: how?

It is the same command, as mentioned in [1] below.  I'll enrich the commit
message here to explain.

> 
> >                                                   not system-wise remaining
> > data.  It was not a problem before, because for a very long time RAM was
> > the only part that matters.
> >
> > After VFIO migrations landed upstream, it may not be true anymore
> > especially considering that there can be GPU devices that contain GBs of
> > device states.
> >
> > Add a new "remaining" field in query-migrate results, reflecting
> > system-wise remaining data, which will include everything (e.g. VFIO).
> 
> "system-wise"?  Do you mean "system-wide"?  Maybe "total"?

Since "total" has been used elsewhere, I'll use "system-wide", hoping
that's easier to digest.

> >
> > This information will be useful for mgmt to implement generic way of stall
> > detection that covers all system resources.  Say, when system remaining
> > data does not decrease anymore for a relatively long period of time, then
> > it may mean that there is a challenge of converging, so mgmt can act based
> > on how this value changes over time (especially if sampled after each
> > migration iteration).
> >
> > Before this patch, "expected_downtime" almost played this role. For
> > example, by monitoring "expected_downtime" at the beginning of each
> > iteration can in most cases also reflect the progress of migration
> > system-wise.  Said that, "expected_downtime" was always calculated based on
> > a bandwidth value that can fluctuate a lot if avail-switchover-bandwidth is
> > not used. This new "remaining" field will remove that part of uncertainty
> > for mgmt.
> >
> > With the new field, HMP "info migrate" now reports this:
> >
> > (qemu) info migrate
> > Status:                 active
> > Time (ms):              total=12080, setup=14, exp_down=300
> > Remaining:              1.36 GiB        <------------------- newline
> 
> "Newline" is ASCI character '\n'.  I guess you mean "this is the new
> line".

Yes.  I'll remove this "<----..." if it causes any confusion.

> 
> > RAM info:
> >   Throughput (Mbps):    840.50
> >   Sizes:                pagesize=4 KiB, total=4.02 GiB
> >   Transfers:            transferred=1.18 GiB, remain=1.36 GiB
> >     Channels:           precopy=1.18 GiB, multifd=0 B, postcopy=0 B
> >     Page Types:         normal=307923, zero=388148
> >   Page Rates (pps):     transfer=25660
> >   Others:               dirty_syncs=1
> >
> > It should be the same value as RAM's remaining report when VFIO is not
> > involved, and it should report more than that when VFIO is involved.
> 
> "RAM's remaining report" is the "remain=1.36 GiB" part, isn't it?

[1]

Correct.

> 
> > Cc: Markus Armbruster <armbru@redhat.com>
> > Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
> > Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  qapi/migration.json            | 4 ++++
> >  migration/migration-hmp-cmds.c | 5 +++++
> >  migration/migration.c          | 7 +++++++
> >  3 files changed, 16 insertions(+)
> >
> > diff --git a/qapi/migration.json b/qapi/migration.json
> > index e3ad3f0604..a6e24b5685 100644
> > --- a/qapi/migration.json
> > +++ b/qapi/migration.json
> > @@ -300,6 +300,9 @@
> >  #     average memory load of the virtual CPU indirectly.  Note that
> >  #     zero means guest doesn't dirty memory.  (Since 8.1)
> >  #
> > +# @remaining: amount of bytes remaining to be migrated system-wise,
> > +#     includes both RAM and all devices (like VFIO).  (Since 11.1)
> > +#
> >  # Features:
> >  #
> >  # @unstable: Members @postcopy-latency, @postcopy-vcpu-latency,
> > @@ -310,6 +313,7 @@
> >  ##
> >  { 'struct': 'MigrationInfo',
> >    'data': {'*status': 'MigrationStatus', '*ram': 'MigrationRAMStats',
> > +           '*remaining': 'uint64',
> 
> It's a byte count, so let's make it 'size'.

Will do.

Since this will be the last functional change so far on the whole series,
and the update seems to be pretty under control (say, qapi schema.py
generates same c code for both "size" and "uint64"), could I request an ACK
on this one with a short diff below, instead of reposting the whole series?

The diff attached here (I'll also fix the commit messages on
e.g. system-wide wordings if I'll not repost):

diff --git a/qapi/migration.json b/qapi/migration.json
index b7518b29c6..c701ef1cf5 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -300,7 +300,7 @@
 #     average memory load of the virtual CPU indirectly.  Note that
 #     zero means guest doesn't dirty memory.  (Since 8.1)
 #
-# @remaining: amount of bytes remaining to be migrated system-wise,
+# @remaining: amount of bytes remaining to be migrated system-wide,
 #     includes both RAM and all devices (like VFIO).  (Since 11.1)
 #
 # Features:
@@ -313,7 +313,7 @@
 ##
 { 'struct': 'MigrationInfo',
   'data': {'*status': 'MigrationStatus', '*ram': 'MigrationRAMStats',
-           '*remaining': 'uint64',
+           '*remaining': 'size',
            '*vfio': 'VfioStats',
            '*xbzrle-cache': 'XBZRLECacheStats',
            '*total-time': 'int',

===8<====

The complete new version of patch is here (I updated quite a few places on
the commit message):

https://gitlab.com/peterx/qemu/-/commit/86d973360890cecc564a4a5bcf9a01b9efde368a

Thanks,

-- 
Peter Xu


