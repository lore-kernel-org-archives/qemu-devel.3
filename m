Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB6EEE7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 15:41:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJDyS-0001Zx-2N; Thu, 05 Dec 2024 10:41:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tJDyQ-0001ZR-0s
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 10:41:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tJDyM-0007jS-R8
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 10:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733413257;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RlHVopj+6C7Ukf7azLzcpIVy+CQ1pHF0HNfvZzmV78o=;
 b=Vk+DawSY/fnXtSP5AzBX0YnovyTrQmveXuIlBfz7qVit6olwtkobwkHyW0s4tk5AZopnYu
 UM8wmFxPmVB3+U0t+w9IlQM1FL8lM1UrxNDLFW1ly07D6FOsB4qakNTlphb+LBPw1ytPGf
 ReULBxVdHAyKTPIv/xQlAuWyHWVqF8g=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-mGuddDbgP1isyahZ9jiSiA-1; Thu,
 05 Dec 2024 10:40:54 -0500
X-MC-Unique: mGuddDbgP1isyahZ9jiSiA-1
X-Mimecast-MFC-AGG-ID: mGuddDbgP1isyahZ9jiSiA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C85C1955F2F; Thu,  5 Dec 2024 15:40:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.137])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 90E3330001A1; Thu,  5 Dec 2024 15:40:51 +0000 (UTC)
Date: Thu, 5 Dec 2024 15:40:47 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/6] migration: Kick postcopy threads on cancel
Message-ID: <Z1HJf0iiIECxW49m@redhat.com>
References: <20241202220137.32584-1-farosas@suse.de>
 <20241202220137.32584-3-farosas@suse.de> <Z1Ch8HpiKMoqILDM@x1n>
 <87r06ni84z.fsf@suse.de> <Z1Cv4JM8IbYeiDpR@x1n>
 <Z1C1V25wydbBlsMb@redhat.com> <Z1DAzzB1SfY_bL17@x1n>
 <Z1GF7KheH_z5E1lc@redhat.com> <87bjxqi7ya.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bjxqi7ya.fsf@suse.de>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Dec 05, 2024 at 10:18:53AM -0300, Fabiano Rosas wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Wed, Dec 04, 2024 at 03:51:27PM -0500, Peter Xu wrote:
> >> On Wed, Dec 04, 2024 at 08:02:31PM +0000, Daniel P. Berrangé wrote:
> >> > I would say the difference is like a graceful shutdown vs pulling the
> >> > power plug in a bare metal machine
> >> > 
> >> > 'cancel' is intended to be graceful. It should leave you with a functional
> >> > QEMU (or refuse to run if unsafe).
> >> > 
> >> > 'yank' is intended to be forceful, letting you get out of bad situations
> >> > that would otherwise require you to kill the entire QEMU process, but
> >> > still with possible associated risk data loss to the QEMU backends.
> >> > 
> >> > They have overlap, but are none the less different.
> >> 
> >> The question is more about whether yank should be used at all for
> >> migration only, not about the rest instances.
> >> 
> >> My answer is yank should never be used for migration, because
> >> "migrate_cancel" also unplugs the power plug.. It's not anything more
> >> enforced.  It's only doing less always.
> >> 
> >> E.g. migration_yank_iochannel() is exactly what we do with
> >> qmp_migrate_cancel() in the first place, only that migrate_cancel only does
> >> it on the main channel (on both qemufiles even if ioc is one), however it
> >> should be suffice, and behave the same way, as strong as "yank".
> >
> > I recall at the time the yank stuff was introduced, one of the scenarios
> > they were concerned about was related to locks held by QEMU code. eg that
> > there are scenarios where migrate_cancel may not be processed promptly
> > enough due to being stalled on mutexes held by other concurrently running
> > threads. Now I would expect any such long duration stalls on migration
> > mutexes to be bugs, but the intent of yank is to give a recovery mechanism
> > that can workaround such bugs.  The yank QMP command only interacts with
> > its own local mutexes.
> 
> Ok, so that could only mean a thread stuck in recv() while holding the
> BQL. I don't think we have any other locks which would stop
> migrate_cancel from making progress or other stall situations that could
> be helped by a shutdown(). Note that most of locks around qemu_file were
> a late addition. I don't think that scenario is possible today. I'll
> have to do some tests.

Yes, in general there should never be a for "yank", *if* QMEU is implemented
correctly. yank is there in case something unexpected happens.

IOW, even if we think migration is perfect today, yank is still worth
having there as a safety net.

> On that note, how is yank supposed to be accessed? I don't see support
> in libvirt. Is there a way to hook into QMP after the fact somehow?

We've not wired up any API for this libvirt. I can be issued via libvirt's
QMP passthrough API if desired though.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


