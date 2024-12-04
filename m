Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CECE7716F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 20:52:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIwLT-00071B-Mt; Wed, 04 Dec 2024 15:51:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIwLR-0006xt-6k
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:51:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIwLP-0005Pw-7G
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:51:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733345492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GHvpwfL9BHGvxoxjKSN21MJeDLPnVDmkXArNxjWR4wc=;
 b=KFg1MzoiMyZbaRj3hmid1/1XbJvVFcCyPCsDw9VaJPb1xmWqMuCL94OK/0S5fMZzkX59ta
 ykoX81nkNUdNf2Gr6L6bfudySSMZWAbDpzrvINfiU1ZRtMJAg4+xGYp7oIGiZMxYa5Kdvd
 /s8R87Q+HN8LIpPkE7/rsnVVXzOtCsU=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-bZ0haWMyOh2WkqZw-vMV1Q-1; Wed, 04 Dec 2024 15:51:31 -0500
X-MC-Unique: bZ0haWMyOh2WkqZw-vMV1Q-1
X-Mimecast-MFC-AGG-ID: bZ0haWMyOh2WkqZw-vMV1Q
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-8419946e077so22864939f.2
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 12:51:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733345491; x=1733950291;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GHvpwfL9BHGvxoxjKSN21MJeDLPnVDmkXArNxjWR4wc=;
 b=nqqPNFPDmgfoTyiUDmnIGaIBReLxWq4QFaCn6bIWcde+qttD5+Z8B34S740cgM8XRN
 Hzkm2uUKTGrdhHKVD0hxQQy4uYsbuJQfoybVzyUgM2UdByFaN13b43ZUTQw/M6GfW8z6
 5onP2H3EvyrUdG9qEVHA4YMcAhbU27rD3Zis9CHfWuWq8PvpHUP6XcFqbSQMNcNi35Ry
 oT8UL3nulLTKskaMWvK1S7hIWbg0wZ/ll2Tei5vv2fi0GIKE9Mb72JaJ8J6k6t22WQ8i
 BgUo1dJxtcbdJiYEIMSzVHSOyFegITxF22wLTY73e1yIf/a/qTmARle0RlxQ6VWtuRp2
 e18A==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/J43ilq5rTK1sQBXzs+71jky7x19pOZrnfw2z5+xTQe/F73rAEb+0CT8klgTsOEg2KJEZPZ2K5Okq@nongnu.org
X-Gm-Message-State: AOJu0Yxz7Gt23VR0tsOVJRA925yKLcnLUKDF8JacUERdgcsik7OJOtVT
 hrJBiWbNKpVQibHgUlzPh4LcbdKVLZrGsVJrpemxz86tI5de6YBeB6stWYgUSWcVn+6OkvTl5Mh
 lfZomUR/aFchqt91MKVbIDt//U4dHhuYfzzDngYkV/UOxxfmz1xi4
X-Gm-Gg: ASbGnct2yB9/NS8l4y/WmS1AZuevPGkb6/C9JXpjnqDkBTkmZg20ml3Tuej3Wk4NxiG
 24WgBciB+AmlcQ8NO21rOXo7RMm3wYcZNTRXrOmQFwN6yudmEiDA2ia49S1NZLx/Eyu92gHjbPO
 5JeuGD9dOMIkZsxiXsspkHqSuY9IIEiFlsFpztqGcjM+t86KNhlY6a8QXHLWcEMjOXfqHBil4mt
 6S2mQ0u8b6iGNaAKm11iYGO9mGjSGR4vAibXOOfMm24nnwoEzh/3Oa9hA+jBij7GGA0NUiapIfK
 8GkmE8V5guU=
X-Received: by 2002:a05:6602:341b:b0:841:81ef:70b9 with SMTP id
 ca18e2360f4ac-8445b575c28mr822832439f.9.1733345490868; 
 Wed, 04 Dec 2024 12:51:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH4qxRFCqi+Axj8XvwZgeJsMnrzy6/Xcunf7zV2AsAIU9t9k9SwiY8u5ApgkjyyROtuSK78mg==
X-Received: by 2002:a05:6602:341b:b0:841:81ef:70b9 with SMTP id
 ca18e2360f4ac-8445b575c28mr822830539f.9.1733345490474; 
 Wed, 04 Dec 2024 12:51:30 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-84405f97005sm328878639f.39.2024.12.04.12.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 12:51:29 -0800 (PST)
Date: Wed, 4 Dec 2024 15:51:27 -0500
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Subject: Re: [PATCH 2/6] migration: Kick postcopy threads on cancel
Message-ID: <Z1DAzzB1SfY_bL17@x1n>
References: <20241202220137.32584-1-farosas@suse.de>
 <20241202220137.32584-3-farosas@suse.de> <Z1Ch8HpiKMoqILDM@x1n>
 <87r06ni84z.fsf@suse.de> <Z1Cv4JM8IbYeiDpR@x1n>
 <Z1C1V25wydbBlsMb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z1C1V25wydbBlsMb@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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

On Wed, Dec 04, 2024 at 08:02:31PM +0000, Daniel P. Berrangé wrote:
> On Wed, Dec 04, 2024 at 02:39:12PM -0500, Peter Xu wrote:
> > On Wed, Dec 04, 2024 at 04:02:36PM -0300, Fabiano Rosas wrote:
> > > Peter Xu <peterx@redhat.com> writes:
> > > 
> > > > On Mon, Dec 02, 2024 at 07:01:33PM -0300, Fabiano Rosas wrote:
> > > >> Make sure postcopy threads are released when migrate_cancel is
> > > >> issued. Kick the postcopy_pause semaphore and have the fault thread
> > > >> read 'fault_thread_quit' when joining.
> > > >> 
> > > >> While here fix the comment mentioning userfault_event_fd.
> > > >> 
> > > >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > > >
> > > > I remember when working on postcopy, I thought about failing migrate-cancel
> > > > for postcopy in general, rejecting such request.  And when working on the
> > > > recover feature, there's no concern on having it being cancelled, because
> > > > the user really shouldn't do that..
> > > >
> > > > The problem is migrate-cancel means crashing the VM on both sides when QEMU
> > > > already goes into postcopy stage.
> > > 
> > > Well, that's the sillyness of having a cancel command, you can never
> > > know what "cancel" means. The "documentation" says: "Cancel the current
> > > executing migration process", it doesn't mention anything about the
> > > consequences of such action.
> > 
> > We definitely need cancel.  It was always used in precopy, and people use
> > it a lot!
> 
> Not a fair benchmark though.
> 
> People use cancel alot because 'precopy' cannot complete in a
> predictable amount of time, any time guesstime can suddenly
> get much worse if the guest dirties memory differently. So
> people give up and cancel it after waiting ridiculously long
> and never being sure if it is nearing the finish.
> 
> Once a migrate has been switched to 'postcopy' phase, however,
> we have what should be a highly predictable completion time,
> directly related to the amount of untransferred pages. That
> time should not get worse. The amount of time spent in the
> 'postcopy' phase will depend on how long you let the migrate
> run in 'precopy' before flipping to 'postcopy'

Right.  And if to be precise - the time doesn't matter, but "how many dirty
page left".  For extremely busy guests, longer precopy doesn't help, for
example.. so time isn't very relevant, IMHO.  It's just that postcopy
always have an upper time limit, which is guest mem size / bw.

> 
> IOW, I think there's a reasonable case to be made that NOT
> having the ability to cancel while in 'postcopy' phase would
> be mostly acceptable. You give up the ability to cancel for
> a while, in exchange for a clearly determined completion
> time. 
> 
> > > > If the user wants to crash the VM anyway, an easier way to do is killing on
> > > > both sides.
> > > 
> > > I don't think this is fair. We expose a "cancel" command, we better do
> > > some cancelling or instead reject the command appropriately, not expect
> > > the user to "know better".
> > 
> > That's exactly why we should fail it with a proper error message, IMHO.
> > Because the user may not really understand the impact of postcopy.
> 
> Yep, I think users/apps expect "cancel" to be safe. So if it can't be
> safe at certain times, we should reject it in those time windows.
> 
> > > > If the user wished to cancel, we should tell them "postcopy cannot be
> > > > cancelled, until complete".  That's probably the major reason why people
> > > > think postcopy is dangerous to use..
> > > 
> > > We could certainly add that restriction, I don't see a problem with
> > > it. That said, what is the actual use case for migrate_cancel? And how
> > > does that compare with yank? I feel like we've been kind of relying on
> > > nobody using those commands really.
> > 
> > We had "cancel" first, then "yank".  I didn't remember who merged yank,
> > especially for migration, and why it was ever needed.
> 
> yank is for the case where the network connections are completely stuck,
> causing QEMU to potentially get stalled in I/O operations until a TCP
> timeout is reached. yank force unwedges any stuck I/O by aggresively
> closing the connections. It is most useful in the non-migration use
> cases though.
> 
> > Migration users should have stick with "cancel" rather than "yank" - qmp
> > "yank" would "FAIL" the migration instead of showing CANCELLED, definitely
> > should avoid.  I am not aware of anybody that uses "yank" for migration at
> > all.
> > 
> > So yeah, both commands are slightly duplicated, and if we want to throw
> > one, it needs to be yank, not cancel.  I'm fine keeping both..
> 
> I would say the difference is like a graceful shutdown vs pulling the
> power plug in a bare metal machine
> 
> 'cancel' is intended to be graceful. It should leave you with a functional
> QEMU (or refuse to run if unsafe).
> 
> 'yank' is intended to be forceful, letting you get out of bad situations
> that would otherwise require you to kill the entire QEMU process, but
> still with possible associated risk data loss to the QEMU backends.
> 
> They have overlap, but are none the less different.

The question is more about whether yank should be used at all for
migration only, not about the rest instances.

My answer is yank should never be used for migration, because
"migrate_cancel" also unplugs the power plug.. It's not anything more
enforced.  It's only doing less always.

E.g. migration_yank_iochannel() is exactly what we do with
qmp_migrate_cancel() in the first place, only that migrate_cancel only does
it on the main channel (on both qemufiles even if ioc is one), however it
should be suffice, and behave the same way, as strong as "yank".

Meanwhile, "yank" definitely lacks the graceful side of thing, not only on
"cancelled", but also anything extra in migration_cancel() that wasn't
about shutdown().  Examples, qmp_migrate_cancel has special care on:

  - migrate_dirty_limit(), where it'll shutdown the limit threads too
    alongside if migration cancels,

  - process the possible hang case with PRE_SWITCHOVER.

  - if the cancel happened right during switchover, and if at that time the
    disks are inactivated, it'll re-activate the disks

In general, there's no reason to use yank on migration, IMHO, because it's
not stronger either on shutting the NIC.

Considering it's confusing to mostly everyone, and tons of people asked me
about this.. maybe I should send a patch to remove yank from migration?

Thanks,

-- 
Peter Xu


