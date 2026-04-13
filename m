Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB99F531CE
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 21:08:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCOVA-000799-F9; Mon, 13 Apr 2026 17:07:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wCOV8-00078w-GS
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 17:07:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wCOV5-0004lR-1W
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 17:07:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776114433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gLq7tCdIacV7oeZTw5EJ1EHeovNJtG86UXIqZx4QqUo=;
 b=UqpVLSX0F4iWWAo5fBQvmVR6bNu8j4yajRU1sUrZird2FOpD22495E2Hx3abbuVpQNpxcL
 IEQ5+G8sdLDxrDCRkc5Hwk15u9TRyhLdH7ivTIoOIJZAtQWbAkXDmwtDsne3BiEjtLfJ3s
 NIVDc+TqOXP88a1BRUszrGrnE8jQtxw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-rU4dqTreNvKeJ_AU1sIiMQ-1; Mon, 13 Apr 2026 17:07:09 -0400
X-MC-Unique: rU4dqTreNvKeJ_AU1sIiMQ-1
X-Mimecast-MFC-AGG-ID: rU4dqTreNvKeJ_AU1sIiMQ_1776114429
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50d890580e1so90771331cf.3
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 14:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776114429; x=1776719229; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gLq7tCdIacV7oeZTw5EJ1EHeovNJtG86UXIqZx4QqUo=;
 b=bbExn3uNGodnTFwHoKloupvXjlxMPzwcWlfTRnXxlkEhckX/CWAO1VSUrjedIxMUh4
 F03rTcF3TfPx0ffovWX0fZld4lEFZWjYxdjCGazKODSJkLna+U0DBbV+8eZ2HM3SHCbG
 800h3tD/btGpQO6tcYf8P/9uogffWf8Gltj4X962xX3Q6n/MuRXO1y0VB0cjShC7z6yZ
 RgwHVo9WEAqwp2LCA0mJJY34av+QPTQ+Aa3DNseY6p410kK5gRPaptIwNgC3aPrw+O5L
 UY9HsE1K9mEv5t/oV1k+FZlXA8euKi5nNIPrrlekTCBucODMn3wkCroqBWQ+KiZ0A6bQ
 +qHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776114429; x=1776719229;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gLq7tCdIacV7oeZTw5EJ1EHeovNJtG86UXIqZx4QqUo=;
 b=S812gGryB+ZDAb12qskstBee3W0GKPHzjXbE5gRlmuY5RoWBvYTPNqe1EaqMCl7DpB
 I0qq97DjL0ltDEeRGGaS5rebonA8t493kQ9zoinmA54gRbWrOfjE+2x0oOVhn2uxSXxL
 mNfzbvXwm2vWCpn77tGLmvMb5LNhEx0zLDif/PRiYJ4Aq09ZcH/8V85YzVhIhyvLgw5J
 ZlarHElCm9ms81fpWgu57a9NvnfS6DETCbon7R/csuDDLgrCQBJMiEJS4PEkWM4ZpEFx
 4b0aADDXAeSm8KhBeQKxv1dSolN29uMHWr0vQOj3EChANsrv3ogYrOM5aq2RbbZcmLNA
 kVKg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+USnm1DgA6mZigPawsBhFsk7ErQ7wBUI8ZaKSqArX6I91x2V3djzj2loiO/QnH7G6F5k04rQjL5wK3@nongnu.org
X-Gm-Message-State: AOJu0Yz7vAIqNba87BFUxd0HDUcOqcLBOQTLyqLONAGN77aZvPtTamIF
 12uBB3A0wXsBvmK+VxG/3i2iiVHtv8chD/PmPeGNd0Enods94J8gadnCk6E4idp4xc1dnSshsUL
 H0dnVs6pWDe14c+u7MHUGJmdvxYnyGMgjAx9HUg2Lat2W6KtmCteq1eCk
X-Gm-Gg: AeBDievm9AfZPBnMqpW8JVkyr7XHAhGPKrtXQ9f+0dJrm9G/eq0eAyZT2qjgmvcruTK
 hUwqhyU2aaddK85Qfq3YbwY3umtQNdTWdX6DnhgwLjlOxLERiZJuZs1nY6haHE9Vdctg9jZeq+G
 epvgb9hlVICpiDtAeqH7cX++N4Fp0L5vUVpSwvETyM3p/oMLUwyMe8E57cpnoPtbbGwWhP+VvDr
 Spbpli1zSXnbc3agZOx3JQM+/YwZKvh/lNfkAGFIZI+26uGcBzrR8Li/B/D+hkFCx0TZjZxDh1A
 0mivcAnh0y/AhAgphtWkxolITxeg644jctBHgce7CKNsSfguQHrxh+99AAawGS/VL7NKsqikg0H
 n1iI8VH8i6xskUIsglo9IZPgEtYlBo8fOUF/B6s4bRYn+suo=
X-Received: by 2002:ac8:5a84:0:b0:50b:4a84:aa94 with SMTP id
 d75a77b69052e-50dd5a91fa2mr226132741cf.7.1776114428935; 
 Mon, 13 Apr 2026 14:07:08 -0700 (PDT)
X-Received: by 2002:ac8:5a84:0:b0:50b:4a84:aa94 with SMTP id
 d75a77b69052e-50dd5a91fa2mr226132251cf.7.1776114428334; 
 Mon, 13 Apr 2026 14:07:08 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50dd54ff026sm94107971cf.22.2026.04.13.14.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 14:07:07 -0700 (PDT)
Date: Mon, 13 Apr 2026 17:07:00 -0400
From: Peter Xu <peterx@redhat.com>
To: Claudio Fontana <cfontana@suse.de>
Cc: Fabiano Rosas <farosas@suse.de>, Trieu Huynh <vikingtc4@gmail.com>,
 qemu-devel@nongnu.org, Jim Fehlig <jfehlig@suse.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH 0/2] migration: include timing and RAM stats on
 destination when query-migrate
Message-ID: <ad1a9GaGQFHS4UHx@x1.local>
References: <20260405152612.93027-1-viking4@gmail.com> <878qb05gq7.fsf@suse.de>
 <ada038hgmY9hNqPK@x1.local>
 <5f29c2dd-95eb-44c6-b22e-1909f7453cdf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5f29c2dd-95eb-44c6-b22e-1909f7453cdf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Apr 09, 2026 at 12:08:34PM +0200, Claudio Fontana wrote:
> On 4/8/26 22:04, Peter Xu wrote:
> > On Mon, Apr 06, 2026 at 11:02:56AM -0300, Fabiano Rosas wrote:
> >> Trieu Huynh <vikingtc4@gmail.com> writes:
> >>
> >>> From: Trieu Huynh <vikingtc4@gmail.com>
> >>>
> >>> When query-migrate is called on the *destination* QEMU after a precopy
> >>> migration completes it returns only {"status": "completed"} — no timing,
> >>> no RAM statistics.  The source correctly returns total-time, downtime,
> >>> setup-time, and full ram stats.
> >>>
> >>> This series fixes the gap in two commits:
> >>>
> >>> * commit 1: Track start/end timestamps and per-page-type counters in
> >>>   MigrationIncomingState, recorded in the receive path.
> >>>
> >>> * commit 2: Make source-only MigrationStats fields optional in the QAPI
> >>>   schema so the destination can populate info->ram with only the fields
> >>>   that are meaningful on the receive side.  Fields computed from tracked
> >>>   counters (transferred, normal, duplicate, mbps, pages-per-second) are
> >>>   shown; source-only fields (dirty-sync-count, precopy-bytes, etc.) are
> >>>   absent.
> >>>
> >>> The QAPI change (commit 2) is ABI-compatible: optional fields that are
> >>> not set are simply absent from the output.  Source-side callers are
> >>> unaffected because populate_ram_info() sets all optional fields via
> >>> has_* setters, so the source output is identical to before.
> >>>
> >>> On dst, {"execute":"query-migrate"}
> >>> * As-is:
> >>> {
> >>>     "return": {
> >>>         "status": "completed"
> >>> }
> >>> * To-be:
> >>> {
> >>>     "return": {
> >>>         "status": "completed",
> >>>         "total-time": 94,
> >>>         "ram": {
> >>>             "total": 554508288,
> >>>             "pages-per-second": 1440234,
> >>>             "page-size": 4096,
> >>>             "remaining": 0,
> >>>             "mbps": 97.955404255319152,
> >>>             "transferred": 1150976,
> >>>             "duplicate": 135101,
> >>>             "normal-bytes": 1150976,
> >>>             "normal": 281
> >>>         }
> >>>     }
> >>> }
> >>>
> >>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3151
> >>>
> >>> Trieu Huynh (2):
> >>>   migration: track timing and received pages in MigrationIncomingState
> >>>   migration: expose RAM stats and timing on destination via
> >>>     query-migrate
> >>>
> >>>  migration/migration.c | 37 +++++++++++++++++++++++++++++++++++++
> >>>  migration/migration.h | 17 +++++++++++++++++
> >>>  migration/ram.c       |  3 +++
> >>>  qapi/migration.json   | 14 +++++++-------
> >>>  4 files changed, 64 insertions(+), 7 deletions(-)
> >>
> >> Hi, remember to copy the interested people in your series. Using
> >> get_maintainers is correct, but when there's already a discussion about
> >> the topic it's good to add some CCs manually.
> >>
> >> +CC Daniel and Claudio
> > 
> > The request is a valid one.  Said that, redo accounting on both sides seem
> > to be a duplicated work and overkill to me, if src has everything.
> > 
> > Is there a way we can make Libvirt always query the results before src dies
> > and report it somewhere?  I recall these info were captured somewhere, do
> > we at least dump them into logs?
> > 
> > Thanks,
> > 
> 
> I am interested in the outcome, but I think the approach shown here is fine, the amount of duplication seems minimal to me.
> 
> That said if we _have_ to keep libvirt in the picture, I think I see a possible alternative, but then the feature is not available to anyone that does not use libvirt. At the same time, if libvirt is not used, one is free to keep source QEMU alive and query the stats, like I think Proxmox does.

The problem is here from QEMU's perspective we have all the information,
and "not quit" is the default behavior for src QEMU.  It means by default
all info is available.. this is true for no matter what upper mgmt is in
use.

> 
> So with libvirt, I think we need a way to tell libvirt to keep the source QEMU alive before the actual switchover and the source QEMU is destroyed,
> so that we can do everything that needs to be done from the platform layer before the source QEMU is lost.
> It might go beyond querying for stats using QEMU and libvirt.
> 
> Something similar to (and potentially combined with) virDomainMigrateFlags VIR_MIGRATE_PAUSE, for example:
> 
> VIR_MIGRATE_NO_SOURCE_SHUTOFF
> 
> So one might say:
> 
> flags = VIR_MIGRATE_LIVE | VIR_MIGRATE_PERSIST_DEST | VIR_MIGRATE_UNDEFINE_SOURCE | VIR_MIGRATE_PAUSE | VIR_MIGRATE_NO_SOURCE_SHUTOFF
> new_domain = virDomainMigrate3(old_domain, conn, params, nparams, flags)
> 
> and then we could do everything that needs to be done from the platform layer,
> then issue a virDomainResume to start the domain on destination,
> and maybe a virDomainDestroyFlags on the original domain to terminate it on the source.
> 
> But I would still favor the simplicity and the overall applicability of this series from Trieu Huynh.

I still think it'll be great we only do accounting once, and above sounds
like a libvirt question that I don't know the answer. Adding Jiri and
libvirt list in case we can collect some inputs.

If you're looking for this feature, IMHO it'll be great if you can have a
look at least from libvirt side to see if there's any blocker for
collecting this info from src, then we can evaluate the rest. E.g. there's
at least another option to forward statistic data from src to dest.  Then
we don't worry on mismatched accounting, or when fixing / add new
accounting we don't need to do it both sides, which will be awkward.

Thanks,

> 
> Thanks,
> 
> Claudio
> 

-- 
Peter Xu


