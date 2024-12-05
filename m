Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68C7DE7716D
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 15:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJDOk-0003nB-8C; Thu, 05 Dec 2024 10:04:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJDOj-0003mx-82
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 10:04:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tJDOg-00020e-G2
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 10:04:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733411044;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/51kSQMFJN6AM51LfaECtvm8nEIuJkRR4GASGP3EdN0=;
 b=VUkCVXHreIBe5LQXr8WkhFd/vSvx8EdKaKcw/JpojAeWVmhbomVVKgr3LvnF+89oehhr7v
 VaZVIxrNDh5JHkalI8gXwiVBD+yO5JoGXvIMI78L9nzRooq5+9i1JjIHlpbD5TJZiu75O8
 q1GBjEgaY7xh0J8uMOTnwYW34y+hn1U=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-dVI_Rs2WMyuQebtj3-OvpQ-1; Thu, 05 Dec 2024 10:04:03 -0500
X-MC-Unique: dVI_Rs2WMyuQebtj3-OvpQ-1
X-Mimecast-MFC-AGG-ID: dVI_Rs2WMyuQebtj3-OvpQ
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-466bc740022so32282121cf.0
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 07:04:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733411042; x=1734015842;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/51kSQMFJN6AM51LfaECtvm8nEIuJkRR4GASGP3EdN0=;
 b=PEngtzfZtbr7zBx7SB99zhKMu9lje/2h0G0y+x6DBColPcRmcWe9gju48xI2vvWmZo
 hUDNJbGIxCAlWm5DByIojA13DtSGTA0EwBYVzlUnqmKBHPDG5rWcJJtOEVaG0sn+ukMi
 AszNJjHocLz2PTR2ZEChuWcV0Er2eHaGbdJuifzXT7oUbMZrYPmu5j/R2h7z4xY+nsXe
 HbxOPGcrN+1BOpPauS2IQ0YndDpLQrI9HHlkpI/0aSBuASktLuTGh2zogNdqt1CwACma
 ntT7KWvDpPTHPpCVJXzWsZW8oZhP2Q8nr/UpkGT3liOgfaBuO/1+Pga51j6RKqtK7js8
 NrBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS5PcIeqyohXkM4PgV5pBOcuyguDkyOWI6hPXS5l1N3bw0KcOMZSE6M0rn8D145/pHXPqBcwNFBKMv@nongnu.org
X-Gm-Message-State: AOJu0Yx7VsuHpPeDPx+mFUzj5OqRIpY8LPEnXHVl0sHRn/hSgDHeYwzq
 RysVoGfwwn9k5MeThLPm+2BFMTQNRU6JTej4u1kBUEE4gFLr/eGYR2LUX2wwP2r3r/8aZ3PiFTm
 qPcwwommlJWyrPUT0hOmkNuSD5u6fGQTzRYP2Duk2V+8FQqZXNnbb
X-Gm-Gg: ASbGncsP48jS/596MOuHxh+uWt5C1/jhq6raxdKUC7jhIW6k5Vs36vO1eUrABh17IWd
 oZhFvzrJ3ddXdK3x9eKxGw/8NP9nxkYsTmK31USuTDkS43urSintlTMqeaLNOHjtECx1yqO97n4
 25WwAYv4oZcMUG49xULHN3HrzLkjQWFF8RHtE/sCjWG9P85JzunuBnviowSA0njLKkcW34KntW1
 VD17hFOlxvWbdE9JYdTgH+5bzULHRyd2MzzwDBJq/JlwOgrF7ZT+5VR1u/DMqsHF62IfFElNOKU
 aB9gbsEN0Z8=
X-Received: by 2002:ac8:7d86:0:b0:466:9631:4a40 with SMTP id
 d75a77b69052e-4670c13d7fbmr169552091cf.17.1733411042494; 
 Thu, 05 Dec 2024 07:04:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIA7caYAWfPaoNVaf/LwBDW5wEji7JsybaLaw5Py8sdO3GwQXx3qqK1tlWUfgqjabKcMHXiQ==
X-Received: by 2002:ac8:7d86:0:b0:466:9631:4a40 with SMTP id
 d75a77b69052e-4670c13d7fbmr169551681cf.17.1733411042123; 
 Thu, 05 Dec 2024 07:04:02 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46729791f3csm8609991cf.65.2024.12.05.07.04.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Dec 2024 07:04:01 -0800 (PST)
Date: Thu, 5 Dec 2024 10:03:58 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 2/6] migration: Kick postcopy threads on cancel
Message-ID: <Z1HA3hk8XSnOFv6s@x1n>
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
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

And if that is a real difference, I'd think whether we should simply make
migrate_cancel be oob-capable too.. IOW, I still think it'll be good to
stick with always one API to cancel a migration, no matter which it is.  If
we want to move over to yank then I think we should move all migrate_cancel
operations into yank and deprecate "migrate_cancel', but that sounds
overkill.

There's only one thing that might not be oob-compatible there so far, which
is bdrv_activate_all().  But I plan to remove it very soon (so that disks
will be activated in the migration thread instead, just like failure cases).

> 
> On that note, how is yank supposed to be accessed? I don't see support
> in libvirt. Is there a way to hook into QMP after the fact somehow?
> 

-- 
Peter Xu


