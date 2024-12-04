Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04975E7716D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 19:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIvDa-0003V3-JS; Wed, 04 Dec 2024 14:39:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIvDY-0003Uq-Il
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 14:39:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIvDW-0003wk-Ns
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 14:39:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733341161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=N9p2ah+8mGCc74H8B5wJh5JeHYrYMC2xVL/enXpFQrg=;
 b=Y2kxaBvickepVDVdbXoJtUBXF3ReYCUWFeNmkVr42I+iJVhShdAQYjNV7UB1EJu4mOVTlL
 hzPj9Kj1HhbbrmtoyJwXEvGrEiTJgHPI7fZb6vF5x7CG3T08Tr4LUPxBNCYwsPex1qjUkk
 lxrIiKqwa5YB39FfTEC+ZoSYR51dZ3w=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-5-NsLlieMxCja-Gb8TLMjQ-1; Wed, 04 Dec 2024 14:39:17 -0500
X-MC-Unique: 5-NsLlieMxCja-Gb8TLMjQ-1
X-Mimecast-MFC-AGG-ID: 5-NsLlieMxCja-Gb8TLMjQ
Received: by mail-il1-f197.google.com with SMTP id
 e9e14a558f8ab-3a7807feadfso330745ab.2
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 11:39:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733341156; x=1733945956;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N9p2ah+8mGCc74H8B5wJh5JeHYrYMC2xVL/enXpFQrg=;
 b=hi5SX1CX1nyFtmKh3nhX+4C0sFAuhCmaZN5jRIZ+rWwZ2MRxyinVAUvBmuCxjoJkVS
 OgpSElnrP61ZZrieRUA5GiRx5mTTT4IwpPjbTB1oStjYebFFOkyZZNHHCRa9VElkM+Hu
 JwSJ5sru+3reV34TUq6K45tHgBZL7VVc+4Fhmp76uTKi6Ee3WHLJ8F23IWX/BCN5Yqz1
 3MAbO3HIgnUwzD3W5NNgp3p+SPwCf4L4MJGbG99DfX7EKjm2E7ifxFZnsDbaXkJhtNxo
 ezFpu/qC8X2EZV9E9glVu0hGINwX97nUFt6Cxi+Fnc8jcb6Qhxe5k2mfuHfZP3pn2fQc
 Bc+A==
X-Gm-Message-State: AOJu0YxpndxeNQR9p0dSWqYViNQssJMUJCoU7ztBA0IiOLoHNh04dcZL
 7GAsi8JxdmLwyGpo9HYWZhvvbLn4SqZCk91LJVUbo3LeAjQ3V4uPUV7ULYisHC9eW5tiqKCjjDQ
 tnz0A9EzBcESzJXBj19slBSuDwfqAvE27yopJ2GHeEq79Eo+kOYT9k5h6sDzF
X-Gm-Gg: ASbGncugi8DWcB3FzQDGYY/AwbnlfypE/a4ivTKBT2aS3c4PvL3zHyL6sChBL1Vchd3
 OdlI6Wxcw5DvrN++WAKRgUcJtAHD+eA90KTP3TEMDDykPDOIM7Ce4Gd5h0LmsXeEng6RFD4mAFC
 IsAmWVLqANAx6pdRq0epwmGMHiitQjAQRoKKUj55Up6a4q+UsDqMTITcNmd772hKoqPMRDCtHRt
 nNzlYZXosHQdGNRM2qEP4eGF8YiTAJj4ITiVIs3vWUNTYwpifrU/LEFc0hcACR06zPTIs8taog9
 gIwFwMpZuyo=
X-Received: by 2002:a05:6e02:1a03:b0:3a7:9533:c3ac with SMTP id
 e9e14a558f8ab-3a7f9a35b4amr96495165ab.4.1733341155430; 
 Wed, 04 Dec 2024 11:39:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZHQklMqR3wJA/ycl8vjucl3dspx7ZH7GSJ2AZ78lX8l/XXfLuyU4ewq1LLIXZHSW52BCUiA==
X-Received: by 2002:a05:6e02:1a03:b0:3a7:9533:c3ac with SMTP id
 e9e14a558f8ab-3a7f9a35b4amr96494935ab.4.1733341155094; 
 Wed, 04 Dec 2024 11:39:15 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e230dca8f5sm3208476173.46.2024.12.04.11.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 11:39:14 -0800 (PST)
Date: Wed, 4 Dec 2024 14:39:12 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [PATCH 2/6] migration: Kick postcopy threads on cancel
Message-ID: <Z1Cv4JM8IbYeiDpR@x1n>
References: <20241202220137.32584-1-farosas@suse.de>
 <20241202220137.32584-3-farosas@suse.de> <Z1Ch8HpiKMoqILDM@x1n>
 <87r06ni84z.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r06ni84z.fsf@suse.de>
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

On Wed, Dec 04, 2024 at 04:02:36PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Dec 02, 2024 at 07:01:33PM -0300, Fabiano Rosas wrote:
> >> Make sure postcopy threads are released when migrate_cancel is
> >> issued. Kick the postcopy_pause semaphore and have the fault thread
> >> read 'fault_thread_quit' when joining.
> >> 
> >> While here fix the comment mentioning userfault_event_fd.
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >
> > I remember when working on postcopy, I thought about failing migrate-cancel
> > for postcopy in general, rejecting such request.  And when working on the
> > recover feature, there's no concern on having it being cancelled, because
> > the user really shouldn't do that..
> >
> > The problem is migrate-cancel means crashing the VM on both sides when QEMU
> > already goes into postcopy stage.
> 
> Well, that's the sillyness of having a cancel command, you can never
> know what "cancel" means. The "documentation" says: "Cancel the current
> executing migration process", it doesn't mention anything about the
> consequences of such action.

We definitely need cancel.  It was always used in precopy, and people use
it a lot!

> 
> >
> > If the user wants to crash the VM anyway, an easier way to do is killing on
> > both sides.
> 
> I don't think this is fair. We expose a "cancel" command, we better do
> some cancelling or instead reject the command appropriately, not expect
> the user to "know better".

That's exactly why we should fail it with a proper error message, IMHO.
Because the user may not really understand the impact of postcopy.

I remember I also tried to reuse migrate-cancel to work as what
migrate-pause does currently (so as to not introduce yet another new QMP
command).  I don't remember why we came up with the new cmd, but with
migrate-pause being there, I think the only sane way to respond to cancel
request during postcopy is to fail it properly..

> 
> >
> > If the user wished to cancel, we should tell them "postcopy cannot be
> > cancelled, until complete".  That's probably the major reason why people
> > think postcopy is dangerous to use..
> 
> We could certainly add that restriction, I don't see a problem with
> it. That said, what is the actual use case for migrate_cancel? And how
> does that compare with yank? I feel like we've been kind of relying on
> nobody using those commands really.

We had "cancel" first, then "yank".  I didn't remember who merged yank,
especially for migration, and why it was ever needed.

What I still remember is yank crash qemu migration quite frequently, though
I can't blame it as it does help us to find quite a few mismatch on
iochannel setup/cleanup or stuff like that.  So it's sometimes "helpful" as
kind of a program checker..

Migration users should have stick with "cancel" rather than "yank" - qmp
"yank" would "FAIL" the migration instead of showing CANCELLED, definitely
should avoid.  I am not aware of anybody that uses "yank" for migration at
all.

So yeah, both commands are slightly duplicated, and if we want to throw
one, it needs to be yank, not cancel.  I'm fine keeping both..

> 
> One truth that we have (because it's tested) is that the multifd
> migration allows migrate_cancel on the source and another migration to
> start from it.
> 
> (btw, that reminds me that multifd+postcopy will probably break that
> test).

When postcopy==true (even if multifd==true as well!  Or not, it doesn't
matter), we should reject the cancel request, IMHO.

-- 
Peter Xu


