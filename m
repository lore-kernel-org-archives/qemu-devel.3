Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24BC2E77160
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 00:58:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIdiP-0002sJ-EN; Tue, 03 Dec 2024 19:58:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIdiM-0002nU-Uq
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 19:58:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIdiJ-0007O3-Bx
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 19:58:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733273878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hFGoG81JmWWOQcbzt3xzzoNwpnoYmAVYp72V0w/Dskk=;
 b=NwpO4ROF5LdP4J1Km2YHp7vDvSOS7GMlHimdVuESZB+ZUNjkelSAg53rCqN7bahRs3jvNW
 fR1/HpfhZEXGVd/ha0495RBaEFbHkwbaF5Mp18XgiG552rzy+0vxZuHonkir2zRy3p1MSq
 IYG50RFirINHF8eaNWfrHD9VKP2dsCo=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-p4qgZgvmNwWgi3LeFw-g2w-1; Tue, 03 Dec 2024 19:57:54 -0500
X-MC-Unique: p4qgZgvmNwWgi3LeFw-g2w-1
X-Mimecast-MFC-AGG-ID: p4qgZgvmNwWgi3LeFw-g2w
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7b6676f4361so605484585a.3
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 16:57:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733273874; x=1733878674;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hFGoG81JmWWOQcbzt3xzzoNwpnoYmAVYp72V0w/Dskk=;
 b=Pzfoy3AamYPoQHuTZ9tuYetqymqwRDil323GHGf8Ooe0EoMJMsfqB/524emLjqUZ/M
 9b3RaS7x4XoQaqMXZDGvTRHhM4Ohk2k9iLgtXxKtTFImIgKvmMuidwRWNLGZ2NI7j8mn
 0C+FXOaqWmKlJPcwl2sJni+I9QdZBbTm48CGKvMKMaBriBMQDPKURz3lZe8V3TGsaAi2
 n1TnQicOaXEKD2PP4k4m9ixoMRQZHQbQcyVvjBC0r9/3Rb1QI/xANYxnFNwMuR7wwaqy
 XxA+jLIFwqe523ll03QfFTPFHlZWPxXOLg1vJ65cMuLwZMT0JHtG0pM2eAxxyuEId5qf
 bhQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWEZM4/9dZ1x83YU1KwTz9JSQbvyv58iOOB6Uj+uMsM7Pb+821Aw0r58GQF7BAgzHO9EqwjW6qiDUMa@nongnu.org
X-Gm-Message-State: AOJu0YwuBVGPjimAD0V0K32ecbd0KvkSKwbwA/YI8+GhSBb5+0BwAlyC
 D9brSZumKnLwodNn31ww8pKXPGrnIdP28zk9XaIx2Zqd+scuE32W/ZQOMCtdNy0Tn22+D66wY2+
 QYbWW8StpAOfZp6tacV+SBG3hV0baBi4bLi5KuKEKAboQqkH9tRDX
X-Gm-Gg: ASbGncuQ2vN1yijfSa1ykcyX1pgOD0T7ClnvTzY5OiNeuob8fg5ve4cLWgOFAlMFlOv
 LaeQAjBoeFKnOKhXisb5hbl3okVSYGh1xg4h+UxvbW13Wq29E2MjU0vpscyqICPWeGFt7rvohFu
 8sdj7ncUEiIdrK2BVPbm8b6kpLL929qmB3QdOWK81hazAqMOCNKjbuMcmoiUD3rQAYEk+4f0dRQ
 7DGnKvbbY1KcfP8I1AP/ySirR7OKGNlypqVGkapUfFXFA7AwbGPIwSnShnmet4d8HKgFcCfYJao
 K612XvVJ6KI=
X-Received: by 2002:a05:620a:31a2:b0:7b1:3b5e:4b50 with SMTP id
 af79cd13be357-7b6a5d9df8bmr617668885a.19.1733273874081; 
 Tue, 03 Dec 2024 16:57:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGmyaB5KiTaolM/iq6tYEKmRoeqlhxfv8EhvsBECmdnAbGAXJXpEEa0ZRxR94tt9tyjs8LkUQ==
X-Received: by 2002:a05:620a:31a2:b0:7b1:3b5e:4b50 with SMTP id
 af79cd13be357-7b6a5d9df8bmr617666985a.19.1733273873759; 
 Tue, 03 Dec 2024 16:57:53 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b684920835sm563712285a.11.2024.12.03.16.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Dec 2024 16:57:52 -0800 (PST)
Date: Tue, 3 Dec 2024 19:57:51 -0500
From: Peter Xu <peterx@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 den@virtuozzo.com, Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH 4/5] migration: Activate block devices if VM is paused
 when migrating
Message-ID: <Z0-pD2KgsEtklsgq@x1n>
References: <20241125144612.16194-1-farosas@suse.de>
 <20241125144612.16194-5-farosas@suse.de> <Z0Su2RINKfqRk969@x1n>
 <f6fc6ed3-d1d0-4498-9ec7-1f4e55a2abf3@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f6fc6ed3-d1d0-4498-9ec7-1f4e55a2abf3@virtuozzo.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Nov 27, 2024 at 07:40:39PM +0200, Andrey Drobyshev wrote:
> On 11/25/24 7:07 PM, Peter Xu wrote:
> > On Mon, Nov 25, 2024 at 11:46:11AM -0300, Fabiano Rosas wrote:
> >> Currently a VM that has been target of a migration using
> >> late-block-activate will crash at the end of a new migration (with it
> >> as source) when releasing ownership of the disks due to the VM having
> >> never taken ownership of the disks in the first place.
> >>
> >> The issue is that late-block-activate expects a qmp_continue command
> >> to be issued at some point on the destination VM after the migration
> >> finishes. If the user decides to never continue the VM, but instead
> >> issue a new migration, then bdrv_activate_all() will never be called
> >> and the assert will be reached:
> >>
> >> bdrv_inactivate_recurse: Assertion `!(bs->open_flags &
> >> BDRV_O_INACTIVE)' failed.
> >>
> >> Fix the issue by checking at the start of migration if the VM is
> >> paused and call bdrv_activate_all() before migrating. Even if the
> >> late-block-activate capability is not in play or if the VM has been
> >> paused manually, there is no harm calling that function again.
> >>
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >>  migration/migration.c | 19 +++++++++++++++++++
> >>  1 file changed, 19 insertions(+)
> >>
> >> diff --git a/migration/migration.c b/migration/migration.c
> >> index aedf7f0751..26af30137b 100644
> >> --- a/migration/migration.c
> >> +++ b/migration/migration.c
> >> @@ -2029,6 +2029,25 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
> >>          return false;
> >>      }
> >>  
> >> +    /*
> >> +     * The VM might have been target of a previous migration. If it
> >> +     * was in the paused state then nothing will have required the
> >> +     * block layer to be activated. Do it now to ensure this QEMU
> >> +     * instance owns the disk locks.
> >> +     */
> >> +    if (!resume && runstate_check(RUN_STATE_PAUSED)) {
> > 
> > I hope this will cover all the cases that QEMU could overlook.. or I'm not
> > sure whether we could invoke bdrv_activate_all() unconditionally, as it
> > looks like safe to be used if all disks are active already.
> > 
> > I wished we don't need to bother with disk activation status at all,
> > because IIUC migration could work all fine even if all disks are inactivate
> > when preparing migration.. hence such change always looks like a workaround
> > of a separate issue.
> > 
> >> +        Error *local_err = NULL;
> >> +
> >> +        g_assert(bql_locked());
> >> +
> >> +        bdrv_activate_all(&local_err);
> >> +        if (local_err) {
> >> +            error_propagate(errp, local_err);
> >> +            return false;
> >> +        }
> >> +        s->block_inactive = false;
> > 
> > This var so far was only used within one migration iteration, and the var
> > was only set in migration_completion_precopy() so far.  Now we're resetting
> > it upfront of a migration.  I'm not 100% sure if it's needed, or should be
> > put somewhere else.
> > 
> 
> This variable is unconditionally set in migration_completion_precopy()
> and used as a flag for whether or not we should be deactivating disks in
> qemu_savevm_state_complete_precopy():
> 
> >     /*                                                                              
> >      * Inactivate disks except in COLO, and track that we have done so in order 
> >      * to remember to reactivate them if migration fails or is cancelled.           
> >      */                                                                             
> >     s->block_inactive = !migrate_colo();                                            
> >     migration_rate_set(RATE_LIMIT_DISABLED);                                                                                                                   
> >     ret = qemu_savevm_state_complete_precopy(s->to_dst_file, false,             
> >                                              s->block_inactive);
> 
> Ideally we'd like to take our paused state into account right here and
> skip inactivation.  However at this point during the 2nd migration (in
> paused state) our current_run_state == RUN_STATE_FINISH_MIGRATE.  So if
> we truly wanted to skip unnecessary bdrv_activate_all(), we'd have to
> remember our paused state somewhere earlier on the call stack and pass
> an additional flag for that. Personally I don't think this is any
> cleaner than just blatantly calling bdrv_activate_all().

I did something like that.

Would you please have a look at the other series I posted?  Sorry it's
slightly longer than this patch, but it does cover more than this bug
alone (and it should also fix this bug):

https://lore.kernel.org/r/20241204005138.702289-1-peterx@redhat.com

> 
> > In general, I saw the mention of other places that may also try to
> > invalidate disks that used to be invalidated.  If that's the case, I wish
> > we don't need to touch migration code at all, but instead if block layer
> > can cope with "invalidate on top of invalidated disks" it'll be perfect.
> > 
> 
> This sounds similar to my initial very naive fix, which we decided not
> to take:
> https://lists.nongnu.org/archive/html/qemu-devel/2024-09/msg04254.html

I still wish this can work, either the original patch, or anything that can
make bdrv_inactivate_all() work on inactive-state disks, then it'll be an
easier to use block API.

I don't know block layer well, but I more or less know migration.  I hope
we can still resolve that with some other way at least in migration so that
we don't start to request disk being active for migration, because it
really shouldn't need to.

Thanks,

-- 
Peter Xu


