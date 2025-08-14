Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE1DBCA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 15:43:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uma6D-0003Fp-F4; Thu, 14 Aug 2025 11:42:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uma6B-0003Eo-QI
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 11:42:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1uma66-0000pb-M9
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 11:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755186150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gVMPIm+V4aZifiS8oQTruRZsyXVoMumppyxmGJDL2kA=;
 b=iomuGf34WftEIViwcoRlGi4iHTICUXbkm+VnS8oBFXzWCO8f0Sf1rTjl26tLsBB5HsqQlW
 /wpioQrRRWYbzWSXkl7P9GgdYscLwSBCDQPI+2F9zll46Ys39vZ6GETsNoC6WLW3iKc+ao
 WJvpX5AUsyhvy/WUcLKdWwp0MsO0g6c=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-kIqgWzszO4SSycWIh-nqtA-1; Thu, 14 Aug 2025 11:42:28 -0400
X-MC-Unique: kIqgWzszO4SSycWIh-nqtA-1
X-Mimecast-MFC-AGG-ID: kIqgWzszO4SSycWIh-nqtA_1755186148
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-70a88dd1408so23488636d6.0
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 08:42:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755186148; x=1755790948;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gVMPIm+V4aZifiS8oQTruRZsyXVoMumppyxmGJDL2kA=;
 b=WspRCN4wUv1L7V5HiJVmtpWdxp2DoY9zIley5Xt4U1EgrvViIEK49+tp6wXAe4jHCM
 BrWYgPWPh6D86IZ9VHOlkFe57QjpK1eN4+KXaBUkmzV8I2YMtEuaETj4GxZOj63Jlu16
 cKVBFUbl0c0d0ov+bBwi2f6p8rQlXtKCt/ql8puVVHBrlbPDsOUhjntqTs0Bb+6wJVL0
 GYbQohQ3fzO1wetMC11H6SnLzEaAt0nrgwr3pg3q0PBq1iY5ZUgB719JYHFuvsvHzxrd
 yMEBYCCcv2XKmLYBPH88TZdtiEd+d4bBfyDsAOiNiNzyVP7r0m16ucEEPKjli986LSgt
 C90Q==
X-Gm-Message-State: AOJu0YwhXT1YiaPf+1fluNmixx9EbLY3gVIguzWghcALbqV6FGgJDqGN
 Uc7shm6RQsbJGkxEwyFQ675F8U0ITQD0rPmVehztiHB/u0cjKGgSajJaopDwpJKRMximfW8iEIu
 sdszC8jxudy4jzLBbVM2t1+24sjQo99jopc2XzaQSpTPyQmcQtRnNCy/3
X-Gm-Gg: ASbGnctCY7o//yg9v5hJVOV6xk8hvss2/xziUgIpDO4L9X8rDO5TOEeLxkNmSoU9v98
 EdByEXLnwJuSOsN7WgI2DawK8QQXRowkpF+XqbX9c3V5TS17qxFfv2j4GPRW+JI89tlWWQoHXC9
 i9ETmNFV2RFSr6PLoq53lbbvtIQxhe9E5GOvScfU3vT0joMTkkw+AbUa81v1+NgXdK1L/emef9a
 VEs5He0hzfIwibIOvuHkBy6SahsYA82erCmKYzP/i5d4Xz/0vCbi3CZpDrKnZtTD+5nca+OXscw
 SD9Y1BuRqsJv1avZhtGgSv81S7om
X-Received: by 2002:a05:622a:a1b:b0:4b0:799c:14a8 with SMTP id
 d75a77b69052e-4b10ac26180mr49148981cf.48.1755186147786; 
 Thu, 14 Aug 2025 08:42:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6PSBSrYZowneqfB2Es6S+pK2i55yoRvplJVFIk+yvIpPvmOyflesmWtVQsYpRatyq3/qG2w==
X-Received: by 2002:a05:622a:a1b:b0:4b0:799c:14a8 with SMTP id
 d75a77b69052e-4b10ac26180mr49148411cf.48.1755186147223; 
 Thu, 14 Aug 2025 08:42:27 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4b09a2e6095sm117025891cf.33.2025.08.14.08.42.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 08:42:26 -0700 (PDT)
Date: Thu, 14 Aug 2025 17:42:23 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>, Jiri Denemark <jdenemar@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Weil <sw@weilnetz.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [RFC PATCH 0/4] migration: Introduce postcopy-setup capability
 and state
Message-ID: <xbqqss2yshtjkew5cirlp2bx3dkumxg3grwpduol5ucpx3leqq@irqeo2csi2vg>
References: <20250807114922.1013286-1-jmarcin@redhat.com>
 <aJoEJhJw-_rGVBbA@x1.local>
 <xfzgjwld4ba7mymu3xhkxdwpeie7bbjnbei2xchkqncamktk3g@rbafrorlpvcv>
 <aJzOo7P8aA64AfY_@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJzOo7P8aA64AfY_@x1.local>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Peter,

thank you very much for your answer!

On 2025-08-13 13:42, Peter Xu wrote:
> On Tue, Aug 12, 2025 at 03:34:26PM +0200, Juraj Marcin wrote:
> > Hi Peter
> > 
> > On 2025-08-11 10:54, Peter Xu wrote:
> > > [Sorry to respond late on the real meat of this series..]
> > > 
> > > On Thu, Aug 07, 2025 at 01:49:08PM +0200, Juraj Marcin wrote:
> > > > When postcopy migration starts, the source side sends all
> > > > non-postcopiable device data in one package command and immediately
> > > > transitions to a "postcopy-active" state. However, if the destination
> > > > side fails to load the device data or crashes during it, the source side
> > > > stays paused indefinitely with no way of recovery.
> > > > 
> > > > This series introduces a new "postcopy-setup" state during which the
> > > > destination side is guaranteed to not been started yet and, the source
> > > > side can recover and resume and the destination side gracefully exit.
> > > > 
> > > > Key element of this feature is isolating the postcopy-run command from
> > > > non-postcopiable data and sending it only after the destination side
> > > > acknowledges, that it has loaded all devices and is ready to be started.
> > > > This is necessary, as once the postcopy-run command is sent, the source
> > > > side cannot be sure if the destination is running or not and if it can
> > > > safely resume in case of a failure.
> > > > 
> > > > Reusing existing ping/pong messages was also considered, PING 3 is right
> > > > before the postcopy-run command, but there are two reasons why the PING
> > > > 3 message might not be delivered to the source side:
> > > > 
> > > > 1. destination machine failed, it is not running, and the source side
> > > >    can resume,
> > > > 2. there is a network failure, so PING 3 delivery fails, but until until
> > > >    TCP or other transport times out, the destination could process the
> > > >    postcopy-run command and start, in which case the source side cannot
> > > >    resume.
> > > > 
> > > > Furthermore, this series contains two more patches required for the
> > > > implementation of this feature, that make the listen thread joinable for
> > > > graceful cleanup and detach it explicitly otherwise, and one patch
> > > > fixing state transitions inside postcopy_start().
> > > > 
> > > > Such (or similar) feature could be potentially useful also for normal
> > > > (only precopy) migration with return-path, to prevent issues when
> > > > network failure happens just as the destination side shuts the
> > > > return-path. When I tested such scenario (by filtering out the SHUT
> > > > command), the destination started and reported successful migration,
> > > > while the source side reported failed migration and tried to resume, but
> > > > exited as it failed to gain disk image file lock.
> > > > 
> > > > Another suggestion from Peter, that I would like to discuss, is that
> > > > instead of introducing a new state, we could move the boundary between
> > > > "device" and "postcopy-active" states to when the postcopy-run command
> > > > is actually sent (in this series boundary of "postcopy-setup" and
> > > > "postcopy-active"), however, I am not sure if such change would not have
> > > > any unwanted implications.
> > > 
> > > Yeah, after reading patch 4, I still want to check with you on whether this
> > > is possible, on a simpler version of such soluion.
> > > 
> > > As we discussed offlist, looks like there's no perfect solution for
> > > synchronizing between src <-> dst on this matter.  No matter what is the
> > > last message to be sent, either precopy has RP_SHUT, or relying on 3rd/4th
> > > PONG, or RUN_ACK, it might get lost in a network failure.
> > > 
> > > IIUC it means we need to face the situation of split brain. The link can
> > > simply be broken at any time.  The ultimate result is still better when two
> > > VMs will be halted when split brain, but then IMHO we'll need to justify
> > > whether that complexity would be worthwhile for changing "both sides
> > > active" -> "both sides halted" when it happened.
> > 
> > Yes, a network failure can indeed happen at any time, but that's the
> > decision we need to make if we can allow the possibility of two machines
> > running at the same time. And depending on that, one solution is more
> > complex than the other.
> > 
> > Right now if the network fails during the device load and the
> > destination reaches 3rd ping and postcopy-run, the machine would start,
> > but the source wouldn't. So to me, it looks a bit like a regression, if
> > we introduce a possibility of two machines trying to start.
> 
> That's a fair point.
> 
> Said that, I think trying to start two VMs on both sides are fine when we
> have proper drive locks.  That may help us to serialize things.
> 
> So.. we're talking about an extremely rare case of last-phase split brain
> of migration, that we lost one last ACK message, no matter what is that
> message.
> 
> IMHO we have two scenarios:
> 
>   (a) VM has no shared storage, all storages need to be migrated using
>       block-mirror
> 
>   In this case, starting both VMs in such extremely rare case should, IIUC,
>   succeed on both sides, because file locks for the drives are separate,
>   hence the drive locks are separate too.
> 
>   On src, it would see migration FAILED because of the network failure on
>   last-phase ACK message.  On dest, it sees SUCCEEDED (as if it sees
>   FAILED it'll be a common "migration failure" case).
>   
>   Then, the mgmt (while seeing src migration FAILED), should IMHO fallback
>   to src.  After all, migration is almost always driven on the source.
> 
>   Even if the dest QEMU is running, src contains all guest data so IMHO
>   it's fine killing the dest QEMU, and the real ownership should have never
>   switched over due to src QEMU migration status was either ACTIVE or
>   FAILED, never COMPLETED (which should be the final mark for mgmt to
>   switchover the real ownership).
> 
>   Even though I'm not sure whether libvirt would do so already, but it
>   sounds the right thing to do.

Yeah, that sounds right. Maybe @jdenemar could enlighten us, if and how
libvirt handles such situation now, or what changes would it require.

> 
>   (b) With shared storage, either some drives or all drives are shared
> 
>   In this case, src QEMU still sees migration FAILED, rolling back and
>   trying to restart the VM.  Both sides will contend on the drive lock of
>   whatever drives are shared.  Here, whoever takes the lock will be able to
>   run the VM.  Here I assumed both QEMUs take all locks in order so no ABBA
>   deadlock might never happen.  Hence, no chance that both fails, one must
>   win on taking all the locks.
> 
>   If it's src that wins, it's perfect, because dest QEMU will fail the
>   migration_block_activate() in last BH (process_incoming_migration_bh).
>   mgmt should see dest QEMU halted, src QEMU started running with migration
>   FAILED.  Killing dest would work.
> 
>   If it's dest that wins, this can start to become more complicated..  Two
>   sub-conditions:
> 
>   (b.1) precopy: it should be ok too as long as src QEMU will notice lock
>         contention failed.  Then instead of trying to start the VM, it
>         should wait for mgmt to involve [*]. In this case, we need to
>         assume migration completed because only dest QEMU's RAM now matches
>         with the shared storages.
> 
>   (b.2) postcopy: it will similarly fail the drive activation on src.
>         Since due to the same reason above we must switch ownership to dest
>         QEMU now (dest QEMU's RAM is the solo source of truth that matches
>         with the shared storage), we may need some way to enforce setting
>         src QEMU to postcopy-active once more so src QEMU need to be able
>         to resolve page requests from dest.  It's not easy because the
>         stream is broken now, so it needs to recover the postcopy first.
> 
> [*] NOTE: I think this part is still trivially broken.. as we don't detect
> drive activation failure so far on src QEMU when migration fails..  We may
> need some patch like this to allow "trying to start two VMs on both sides"
> safe:

Maybe, in case disk activation fails on source and the postcopy was
already started, the source could fall back to postcopy-paused, so the
postcopy can be recovered, instead of going into failure. This could
solve the problem with recovering migration in case (b.2).

> 
> From 8b69239e6a7980c34c20880b55f9dd5fd96779fd Mon Sep 17 00:00:00 2001
> From: Peter Xu <peterx@redhat.com>
> Date: Wed, 13 Aug 2025 12:52:38 -0400
> Subject: [PATCH] migration: Do not try to start VM if disk activation fails
> 
> If a rare split brain happens (e.g. dest QEMU started running somehow,
> taking shared drive locks), src QEMU may not be able to activate the
> drives anymore.  In this case, src QEMU shouldn't start the VM or it might
> crash the block layer later with something like:
> 
> bdrv_co_write_req_prepare: Assertion `!(bs->open_flags & BDRV_O_INACTIVE)' failed.
> 
> Meanwhile, src QEMU cannot try to continue either even if dest QEMU can
> release the drive locks (e.g. by QMP "stop").  Because as long as dest QEMU
> started running, it means dest QEMU's RAM is the only version that is
> consistent with current status of the shared storage.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c | 29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 10c216d25d..3c01e78182 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3502,6 +3502,8 @@ static MigIterateState migration_iteration_run(MigrationState *s)
>  
>  static void migration_iteration_finish(MigrationState *s)
>  {
> +    Error *err = NULL;
> +
>      bql_lock();
>  
>      /*
> @@ -3525,11 +3527,28 @@ static void migration_iteration_finish(MigrationState *s)
>      case MIGRATION_STATUS_FAILED:
>      case MIGRATION_STATUS_CANCELLED:
>      case MIGRATION_STATUS_CANCELLING:
> -        /*
> -         * Re-activate the block drives if they're inactivated.  Note, COLO
> -         * shouldn't use block_active at all, so it should be no-op there.
> -         */
> -        migration_block_activate(NULL);
> +        if (!migration_block_activate(&err)) {
> +            /*
> +            * Re-activate the block drives if they're inactivated.
> +            *
> +            * If it fails (e.g. in case of a split brain, where dest QEMU
> +            * might have taken some of the drive locks and running!), do
> +            * not start VM, instead wait for mgmt to decide the next step.
> +            *
> +            * If dest already started, it means dest QEMU should contain
> +            * all the data it needs and it properly owns all the drive
> +            * locks.  Then even if src QEMU got a FAILED in migration, it
> +            * normally should mean we should treat the migration as
> +            * COMPLETED.
> +            *
> +            * NOTE: it's not safe anymore to start VM on src now even if
> +            * dest would release the drive locks.  It's because as long as
> +            * dest started running then only dest QEMU's RAM is consistent
> +            * with the shared storage.
> +            */
> +            error_free(err);
> +            break;
> +        }
>          if (runstate_is_live(s->vm_old_state)) {
>              if (!runstate_check(RUN_STATE_SHUTDOWN)) {
>                  vm_start();
> -- 
> 2.50.1
> 
> 
> > 
> > > 
> > > If we go back to the original request of why we decided to work on this: it
> > > was more or less a feature parity request on postcopy against precopy, so
> > > that when device states loading failed during switchover, postcopy can also
> > > properly get cancelled rather than hanging.  Precopy can do that, we wished
> > > postcopy can do at least the same.
> > > 
> > > Could we still explore the simpler idea and understand better on the gap
> > > between the two?  E.g. relying on the 3rd/4th PONG returned from the dest
> > > QEMU to be the ACK message.
> > > 
> > > Something like:
> > > 
> > >   - Start postcopy...
> > > 
> > >   - Send the postcopy wholesale package (which includes e.g. whole device
> > >     states dump, PING-3, RUN), as before.
> > > 
> > >   - Instead of going directly POSTCOPY_ACTIVE, we stay in DEVICE, but we
> > >     start to allow iterations to resolve page faults while keep moving
> > >     pages.
> > > 
> > >   - If...
> > > 
> > >     - we received the 3rd PONG, we _assume_ the device states are loaded
> > >       successfully and the RUN must be processed, src QEMU moves to
> > >       POSTCOPY_ACTIVE.
> > > 
> > >     - we noticed network failure before 3rd PONG, we _assume_ destination
> > >       failed to load or crashed, src QEMU fails the migration (DEVICE ->
> > >       FAILED) and try to restart VM on src.
> > > 
> > > This might be a much smaller change, and it might not need any change from
> > > dest qemu or stream protocol.
> > 
> > I can test this idea, but I think it should be working and there should
> > be no problems if there are no network issues. However, then there's
> > also a question if we want the destination side to exit gracefully if
> > there is some issue during device load that doesn't cause immediate
> > crash.
> 
> Maybe there's no perfect solution on cleanly shutdown the dest?
> 
> For example, even with RUN_ACK that this series provided, if RUN_ACK is
> lost, dest QEMU is also running on dest showing migration SUCCEED on dest,
> and src QEMU migration FAILED (as it didn't see the RUN_ACK).  In this case
> we'll still need mgmt involvement, right?  Logically, we'll also need
> special care to treat migration SUCCESS even if on src migration shows
> FAILED.
> 
> > IUUC it would switch to POSTCOPY_PAUSED and then the management
> > application would need to kill it and restart the migration.
> 
> Not hugely matters to our discussion here.. but just to mention, currently
> POSTCOPY_PAUSED is very special.  When in such condition, we should not
> kill either side of QEMU because it means there're unique data on both
> sides.  We should suggest mgmt not killing any qemu instance that is in
> POSTCOPY_PAUSED state.

I tested it and if some device state load function returns and error
code, the destination goes to FAILED instead. It will not pause unless
the postcopy state is POSTCOPY_INCOMING_RUNNING to which it transitions
when the destination starts.

> 
> > 
> > > 
> > > It means, if it works (even if imperfect) it'll start to work for old VMs
> > > too as long as they got migrated to the new QEMU, and we get this postcopy
> > > parity feature asap instead of requesting user to cold-restart the VM with
> > > a newer machine type.
> > 
> > But are migration capabilities limited to machine types?
> > 
> > My understanding is that once VM is migrated to the new QEMU it can
> > start using the capability even if it uses older machine type. Then we
> > would be in the same situation, that the feature is usable once we are
> > migrating from a newer QEMU instance.
> 
> You're right.
> 
> Though it also means when it's a cap, we need to have libvirt changed too
> to enable it.  It's not the best way to do for this feature.
> 
> For this one, we definitely want it to be enabled whenever it can.  Likely
> it can be a migraion parameter and setting OFF on old qemus, ON on new
> QEMUs.  Then it'll start to matter.
> 
> The best is if we can enable it silently on src QEMU by default.. if
> possible.  We can finish the discussion first on the rest.
> 
> > 
> > > 
> > > Would this be a better possible trade-off?
> > 
> > So, while yes, such solution would require fewer changes, but to me, it
> > feels like introducing a known regression if the network would fail
> > before the destination reaches 3rd ping message while processing the
> > packaged command. But in case the probability of such failure is so
> > slim, that it's not worth to have the more complex solution, I can move
> > on with the simpler one.
> 
> Right, I think that's the whole point, at least for the past years we never
> hit such problem yet so far on split brain at the last message.  I believe
> we have much more severe issues than this one..
> 
> So yes, we have two issues, one rare issue ([Issue 1]), one extremely rare
> issue ([Issue 2]):
> 
>   [Issue 1] start postcopy fails when device load fails on dest
> 
>   [Issue 2] split brain on the last ACK message, for either precopy or
>             postcopy, no matter what's the last ACK message
> 
> Let's say, possibility of Issue 1 is 1%.  NOTE: this may not be as rare as
> we thought: sometimes dest kernel can start or miss some kernel features,
> causing either KVM feature or vhost or ... feature diff, causing VM load on
> dest fail during device load.  Whatever we hit such migration failure cases
> in precopy, it could happen if we start to always enable postcopy.  It's
> just that we rarely enable postcopy at least until now in production, but I
> suspect it's not true anymore. Hence this request to fix it.
> 
> Possibility of Issue 2 is... I would say, 0.001%? Or less..
> 
> I'm not sure whether we would fix Issue 2 at all.  The fix might need to
> also involve libvirt.  But likely Issue 1 always has higher priority.

Fair point, I'll then continue with the PING/PONG solution, the first
implementation I have seems to be working to resolve Issue 1.

For rarer split brain, we'll rely on block device locks/mgmt to resolve
and change the failure handling, so it registers errors from disk
activation.

As tested, there should be no problems with the destination
transitioning to POSTCOPY_PAUSED, since the VM was not started yet.

However, to prevent the source side from transitioning to
POSTCOPY_PAUSED, I think adding a new state is still the best option.

I tried keeping the migration states as they are now and just rely on an
attribute of MigrationState if 3rd PONG was received, however, this
collides with (at least) migrate_pause tests, that are waiting for
POSTCOPY_ACTIVE, and then pause the migration triggering the source to
resume. We could maybe work around it by waiting for the 3rd pong
instead, but I am not sure if it is possible from tests, or by not
resuming if migrate_pause command is executed?

I also tried extending the span of the DEVICE state, but some functions
behave differently depending on if they are in postcopy or not, using
the migration_in_postcopy() function, but adding the DEVICE there isn't
working either. And treating the DEVICE state sometimes as postcopy and
sometimes as not seems just too messy, if it would even be possible.


Thank you!

Juraj Marcin

> 
> Thanks,
> 
> -- 
> Peter Xu
> 


