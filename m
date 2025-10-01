Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E00E9CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 10:12:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3tn7-0007Tm-2R; Wed, 01 Oct 2025 06:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1v3tn1-0007SW-AW
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 06:10:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1v3tmh-0005C9-55
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 06:10:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759313395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5FXqrGTbHBFVpQTTwqdYR2ROhwQKR91PR+Kuds6n6WI=;
 b=YgJ7J5S5C85cKFiZb6H3JC5KJANmrZaYC7fShITQWlOvwQL2/y+H+0+xgr12evKBmR+cju
 t7YodIvSvMSSBvTnspOuVHFLZFvjxqjoSlX6OQxffRJQB5sDRo+fmSadhJp6Vig3B9xGRX
 BYEHf0NUtawfVBtcs8EX1tTy72/RstQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-3MIci3zVMfiAn18iN6UyYQ-1; Wed, 01 Oct 2025 06:09:54 -0400
X-MC-Unique: 3MIci3zVMfiAn18iN6UyYQ-1
X-Mimecast-MFC-AGG-ID: 3MIci3zVMfiAn18iN6UyYQ_1759313393
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e502a37cdso20897915e9.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 03:09:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759313393; x=1759918193;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5FXqrGTbHBFVpQTTwqdYR2ROhwQKR91PR+Kuds6n6WI=;
 b=biI0/2IHBj5EaXSNmtgFfJg63kxdTWxzwN+Oisg+EaC/P+C/1bkXvo5D2gPXA0IBui
 8lNlftNO00lndyYlWps0CCkLvv2cbj3hV6xs5H9jX2mbKw5cj2HVuOtEYJ8FfrXnZTes
 hJa2INktCRmNCgtsThVWleMbtPkJqwH0wnAPp2FZ4LPA0XGta7ydKqKShMN03VRiFvHJ
 p8R7sT0JIZUKtFHmH+OOrwal2RIAhitMsWddoUd3Q+oK3+m3s2c3J5wC/4pMqsd4QZDA
 FZtcngJt0XKfAYgm/kFpdk4aOY0FXLyTQjylxugafrpZs/e0WV9Hxg5xw8oVm896Mq7Z
 mCQA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJKFtnTQkPDg8hjvYiQyozQ3SArfoszlcdRuZBHQs/0ac66WbIPIOh5HEQ9aCHqik74l1CLzNBCgDi@nongnu.org
X-Gm-Message-State: AOJu0YzEk7hpU7mOoFJ4KgDus9WkMdKApv8d8o8z9oo6XIqSYlMvLMP7
 IJl3AJgBCacPtUE/k1NNk0cDVTKzahy+WjUtcv9lSYTR4vqA7ZlDoE+fuXqQd2DqJtN2J6cBQHW
 q0K9+DuRLsjOtn1dUPwmzzuUfOeYAT4yt3XO/FFZ+hGxDzW31ev1jd36t
X-Gm-Gg: ASbGncvbUl4jEoRqY8vwMj7STwiIlgo475KQf9lPP1hRGokZGQCZS9AcrctZ9ZhXSUB
 L+ZEPGL+vmaA3rCUQYCVh+rGkmeqV7BZvQ4fzjYspgEa/g5+iOmZnA8lKc3RGHYwvP4I+jBTZpi
 AWttq5k6EkWdYUugBD2ZX0CBFpIqOC7PbVHNXgKRv1D0Ghuo1AxBEbr96Xv3g4HIr0/I9lOr/h/
 It/OGnWY8HkVZmgDZfQIfgXKEpsejh4OGE2ROP0HQwIa/SYYeOCVXJ0PKwKrHqgWOIzicehnAW9
 2/O5v1WqCW30kp2EmAp4dBKCJkE7ljj4S3Y=
X-Received: by 2002:a05:600c:348f:b0:45d:f83b:96aa with SMTP id
 5b1f17b1804b1-46e6125d19dmr24277985e9.7.1759313392631; 
 Wed, 01 Oct 2025 03:09:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEjcMPJjw9ljjsIq77YF09DoG3MnHlhn5lWtjzLPFloviNdb3Hw+b6L02W6PBRMSdiWTryI3Q==
X-Received: by 2002:a05:600c:348f:b0:45d:f83b:96aa with SMTP id
 5b1f17b1804b1-46e6125d19dmr24277725e9.7.1759313392072; 
 Wed, 01 Oct 2025 03:09:52 -0700 (PDT)
Received: from fedora ([85.93.96.130]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5b577c87sm34304605e9.0.2025.10.01.03.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 03:09:51 -0700 (PDT)
Date: Wed, 1 Oct 2025 12:09:49 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: =?utf-8?B?SmnFmcOt?= Denemark <jdenemar@redhat.com>, 
 qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 4/4] migration: Introduce POSTCOPY_DEVICE state
Message-ID: <off3t2ozhefn4gw6eqasxkippkxmtbizm2uem4rn2xxdnsnypt@roazvkgchhz4>
References: <20250915115918.3520735-1-jmarcin@redhat.com>
 <20250915115918.3520735-5-jmarcin@redhat.com>
 <aNUtgHsiQwR12jPs@orkuz.int.mamuti.net> <aNWITu36f_DlhZo1@x1.local>
 <aNuMe0GD0mzFbD-K@orkuz.int.mamuti.net> <aNw35iWaNDnYXOz7@x1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNw35iWaNDnYXOz7@x1.local>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 2025-09-30 16:04, Peter Xu wrote:
> On Tue, Sep 30, 2025 at 09:53:31AM +0200, Jiří Denemark wrote:
> > On Thu, Sep 25, 2025 at 14:22:06 -0400, Peter Xu wrote:
> > > On Thu, Sep 25, 2025 at 01:54:40PM +0200, Jiří Denemark wrote:
> > > > On Mon, Sep 15, 2025 at 13:59:15 +0200, Juraj Marcin wrote:
> > > > > From: Juraj Marcin <jmarcin@redhat.com>
> > > > > 
> > > > > Currently, when postcopy starts, the source VM starts switchover and
> > > > > sends a package containing the state of all non-postcopiable devices.
> > > > > When the destination loads this package, the switchover is complete and
> > > > > the destination VM starts. However, if the device state load fails or
> > > > > the destination side crashes, the source side is already in
> > > > > POSTCOPY_ACTIVE state and cannot be recovered, even when it has the most
> > > > > up-to-date machine state as the destination has not yet started.
> > > > > 
> > > > > This patch introduces a new POSTCOPY_DEVICE state which is active
> > > > > while the destination machine is loading the device state, is not yet
> > > > > running, and the source side can be resumed in case of a migration
> > > > > failure.
> > > > > 
> > > > > To transition from POSTCOPY_DEVICE to POSTCOPY_ACTIVE, the source
> > > > > side uses a PONG message that is a response to a PING message processed
> > > > > just before the POSTCOPY_RUN command that starts the destination VM.
> > > > > Thus, this change does not require any changes on the destination side
> > > > > and is effective even with older destination versions.
> > > > 
> > > > Thanks, this will help libvirt as we think that the migration can be
> > > > safely aborted unless we successfully called "cont" and thus we just
> > > > kill QEMU on the destination. But since QEMU on the source already
> > > > entered postcopy-active, we can't cancel the migration and the result is
> > > > a paused VM with no way of recovering it.
> > > > 
> > > > This series will make the situation better as the source will stay in
> > > > postcopy-device until the destination successfully loads device data.
> > > > There's still room for some enhancement though. Depending on how fast
> > > > this loading is libvirt may issue cont before device data is loaded (the
> > > > destination is already in postcopy-active at this point), which always
> > > > succeeds as it only marks the domain to be autostarted, but the actual
> > > > start may fail later. When discussing this with Juraj we agreed on
> > > > introducing the new postcopy-device state on the destination as well to
> > > 
> > > I used to think and define postcopy-active be the state we should never be
> > > able to cancel it anymore, implying that the real postcopy process is in
> > > progress, and also implying the state where we need to start assume the
> > > latest VM pages are spread on both sides, not one anymore.  Cancellation or
> > > killing either side means crashing VM then.
> > 
> > Right, although it's unfortunately not the case now as the source is in
> > postcopy-active even though the complete state is still on the source.
> > 
> > > It could be a good thing indeed to have postcopy-device on dest too from
> > > that regard, because having postcopy-device on dest can mark out the small
> > > initial window when dest qemu hasn't yet start to generate new data but
> > > only applying old data (device data, which src also owns a copy).  From
> > > that POV, that indeed does not belong to the point if we define
> > > postcopy-active as above.
> > > 
> > > IOW, also with such definition, setting postcopy-active on dest QEMU right
> > > at the entry of ram load thread (what we do right now..) is too early.
> > > 
> > > > make sure libvirt will only call cont once device data was successfully
> > > > loaded so that we always get a proper result when running cont. But it
> > > 
> > > Do we know an estimate of how much extra downtime this would introduce?
> > > 
> > > We should have discussed this in a previous thread, the issue is if we cont
> > > only after device loaded, then dest QEMU may need to wait a while until it
> > > receives the cont from libvirt, that will contribute to the downtime.  It
> > > would best be avoided, or if it's negligible then it's fine too but I'm not
> > > sure whether it's guaranteed to be negligible..
> > 
> > We start QEMU with -S so it always needs to wait for cont from libvirt.
> > We wait for postcopy-active on the destination before sending cont. So
> > currently it can arrive while QEMU is still loading device state or when
> > this is already done. I was just suggesting to always wait for the
> > device state to be loaded before sending cont. So in some cases it would
> > arrive a bit later while in other cases nothing would change. It's just
> > a matter of waking up a thread waiting for postcopy-active and sending
> > the command back to QEMU. There's no communication with the other host
> > at this point so I'd expect the difference to be negligible. And as I
> > said depending on how fast device state loading vs transferring
> > migration control from libvirt on the source to the destination we may
> > already be sending cont when QEMU is done.
> 
> Ah OK, I think this is not a major concern, until it is justified to.
> 
> > 
> > But anyway, this would only be helpful if there's a way to actually
> > cancel migration on the source when cont fails.
> > 
> > > If the goal is to make sure libvirt knows what is happening, can it still
> > > relies on the event emitted, in this case, RESUME?  We can also reorg how
> > > postcopy-device and postcopy-active states will be reported on dest, then
> > > they'll help if RESUME is too coarse grained.
> > 
> > The main goal is to make sure we don't end up with vCPUs paused on both
> > sides during a postcopy migration that can't be recovered nor canceled
> > thus effectively crashing the VM.
> 
> Right, I assume that's what Juraj's series is trying to fix.  After this
> series lands, I don't see why it would happen.  But indeed I'm still
> expecting the block drive (including their locks) to behave all fine.

My POSTCOPY_DEVICE series resolves failures during the device state
load, that is up to MIG_CMD_PING that is just before the
MIG_CMD_POSTCOPY_RUN command. However, if the destination fails during
resume (POSTCOPY_RUN), the source machine cannot be recovered even with
this series, it has already received PONG and switched to
postcopy-active.

It is also not possible to move the PING after POSTCOPY_RUN without
changing how the destination interprets the migration stream and the
source would also need to know if destination supports the feature.

> 
> > 
> > > So far, dest QEMU will try to resume the VM after getting RUN command, that
> > > is what loadvm_postcopy_handle_run_bh() does, and it will (when autostart=1
> > > set): (1) firstly try to activate all block devices, iff it succeeded, (2)
> > > do vm_start(), at the end of which RESUME event will be generated.  So
> > > RESUME currently implies both disk activation success, and vm start worked.
> > > 
> > > > may still fail when locking disks fails (not sure if this is the only
> > > > way cont may fail). In this case we cannot cancel the migration on the
> > > 
> > > Is there any known issue with locking disks that dest would fail?  This
> > > really sound like we should have the admin taking a look.
> > 
> > Oh definitely, it would be some kind of an storage access issue on the
> > destination. But we'd like to give the admin an option to actually do
> > anything else than just killing the VM :-) Either by automatically
> > canceling the migration or allowing recovery once storage issues are
> > solved.
> 
> The problem is, if the storage locking stopped working properly, then how
> to guarantee the shared storage itself is working properly?
> 
> When I was replying previously, I was expecting the admin taking a look to
> fix the storage, I didn't expect the VM can still be recovered anymore if
> there's no confidence that the block devices will work all fine.  The
> locking errors to me may imply a block corruption already, or should I not
> see it like that?
> 
> Fundamentally, "crashing the VM" doesn't lose anything from the block POV
> because it's always persistent when synced.  It's almost only about RAM
> that is getting lost, alongside it's about task status, service
> availability, and the part of storage that was not flushed to backends.
> 
> Do we really want to add anything more complex when shared storage has
> locking issues?  Maybe there's known issues on locking that we're 100% sure
> the storage is fine, but only the locking went wrong?
> 
> IIUC, the hope is after this series lands we should close the gap for
> almost all the rest paths that may cause both sides to HALT for a postcopy,
> except for a storage issue with lockings.  But I'm not sure if I missed
> something.
> 
> Thanks,
> 
> -- 
> Peter Xu
> 


