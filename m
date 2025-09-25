Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7059CCAC5B9
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 18:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1qc2-00040G-QJ; Thu, 25 Sep 2025 14:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v1qbz-0003xJ-3w
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 14:22:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v1qbq-00058h-Hs
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 14:22:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758824534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Q3Hl9rhig5CitoEb3Mt+8lv/Kt9Fhlny3WSQIw6C4M=;
 b=OE3cg8aFur9eNqEYx8M2jxOAMT8A+i/CRQVgqC8rULHRLHlN6l+v57Xr03mDWzwUlWRrw/
 mv+I3UlJcNCuUXILgmlJ/7ywARfVlsAvCE3pojKhmfq6glOY/A23KuMhisypmQHxepfuQr
 p1R888lGpc9CmdrtDT30aDImm9Xtd48=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-KYvlIWnMPyKQJpT18b9neg-1; Thu, 25 Sep 2025 14:22:10 -0400
X-MC-Unique: KYvlIWnMPyKQJpT18b9neg-1
X-Mimecast-MFC-AGG-ID: KYvlIWnMPyKQJpT18b9neg_1758824529
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-4d9ec6e592bso26142831cf.2
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 11:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758824529; x=1759429329;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3Q3Hl9rhig5CitoEb3Mt+8lv/Kt9Fhlny3WSQIw6C4M=;
 b=j1Mex57XtgIBmI/r7tQPbHPitg+3fiCeOHQ0bLpMJCDxOXCuCAkr4RAWlMqRZ+EsaY
 blHes/tQkkxKyLvs3kYwLYIwbZual/S1Mb421y0yvZcnYkyzoj37lJ2NDUP5fPGhhHtg
 3iveY3Toan5ZfFWcrs8l4k4hM5P77DKoeuaqzeZPZu4N4NCVWxUWsYUfbZR19OU44hBz
 T2Mj2XOkblnDDk8S9n2mT6qgvrudeyp95UJSf55c7jmIedxtDzOuUS3atizr+6uankOx
 7aAsTbQBipeP8TmHg0ocpBoezr+AuyohrUpVHg7xco4CIkNTnNoVCfWeUFDnHWgOcW/M
 Bo1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjV8kkieh8Gc4iPASvCHUAG/NCbEtKaYPzITQ5SWrgmZXCApt1g67iu85yb44I8g6ZY4GtMUav3csp@nongnu.org
X-Gm-Message-State: AOJu0Ywy5LZ1+h9ujiorbbmdv8xBthawoLdPogFuEIiOInEia18A1O+Y
 faHsFBi0t+e6EsorB0Ny9Ep4/1UzVBPhCgw84s14Kfm+xupwdckdHOMUAUYhaHE8hQbEORHcUCB
 O38SyobLqAiaiWpUFCvMLvbpsTctgz3ZG00/VoCQADyIRXrexbUH0wyT7
X-Gm-Gg: ASbGncsT+n7HE0aiWyVQ++9DdSBpqtxDS0CbF4Z9x+h1nbDzU25eDVXIJF+7jgKeWWz
 HoKbL5ykVcFHVkwV8EL/68Bqlm//v48JANaLmKfOeddXwWRXl5n3aIbgjWjoseBTev3JCYFxvNM
 /B9j5KUr7cGZqxhaO3KWfVA7tNQYupvn+lKYMXXCJtZrMEZlo72EOOM+wyb4qoOsV5lb6NUZA0g
 LrInFrhkJlSoaECfCSfJcYKYQl2rEKIQq0AacPvzuPuHj6OOF4wPBkllo25IofBLlbokmGL64O5
 HnvfvPTpfvgqT7Tu2WLbDnIQFJvG85q6
X-Received: by 2002:a05:622a:5508:b0:4d2:d413:1f3a with SMTP id
 d75a77b69052e-4da4c9651aemr57426601cf.64.1758824529224; 
 Thu, 25 Sep 2025 11:22:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkQzbL3u1zL9zks+sLFPr/tYyOBKi9Ak9ZRV8q6LhQdQ+IPOVHRBU+drU0cRrZcbZA1m7Vkw==
X-Received: by 2002:a05:622a:5508:b0:4d2:d413:1f3a with SMTP id
 d75a77b69052e-4da4c9651aemr57426131cf.64.1758824528596; 
 Thu, 25 Sep 2025 11:22:08 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4db10874bb9sm14256271cf.24.2025.09.25.11.22.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 11:22:07 -0700 (PDT)
Date: Thu, 25 Sep 2025 14:22:06 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?B?SmnFmcOt?= Denemark <jdenemar@redhat.com>
Cc: Juraj Marcin <jmarcin@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 4/4] migration: Introduce POSTCOPY_DEVICE state
Message-ID: <aNWITu36f_DlhZo1@x1.local>
References: <20250915115918.3520735-1-jmarcin@redhat.com>
 <20250915115918.3520735-5-jmarcin@redhat.com>
 <aNUtgHsiQwR12jPs@orkuz.int.mamuti.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aNUtgHsiQwR12jPs@orkuz.int.mamuti.net>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Sep 25, 2025 at 01:54:40PM +0200, Jiří Denemark wrote:
> On Mon, Sep 15, 2025 at 13:59:15 +0200, Juraj Marcin wrote:
> > From: Juraj Marcin <jmarcin@redhat.com>
> > 
> > Currently, when postcopy starts, the source VM starts switchover and
> > sends a package containing the state of all non-postcopiable devices.
> > When the destination loads this package, the switchover is complete and
> > the destination VM starts. However, if the device state load fails or
> > the destination side crashes, the source side is already in
> > POSTCOPY_ACTIVE state and cannot be recovered, even when it has the most
> > up-to-date machine state as the destination has not yet started.
> > 
> > This patch introduces a new POSTCOPY_DEVICE state which is active
> > while the destination machine is loading the device state, is not yet
> > running, and the source side can be resumed in case of a migration
> > failure.
> > 
> > To transition from POSTCOPY_DEVICE to POSTCOPY_ACTIVE, the source
> > side uses a PONG message that is a response to a PING message processed
> > just before the POSTCOPY_RUN command that starts the destination VM.
> > Thus, this change does not require any changes on the destination side
> > and is effective even with older destination versions.
> 
> Thanks, this will help libvirt as we think that the migration can be
> safely aborted unless we successfully called "cont" and thus we just
> kill QEMU on the destination. But since QEMU on the source already
> entered postcopy-active, we can't cancel the migration and the result is
> a paused VM with no way of recovering it.
> 
> This series will make the situation better as the source will stay in
> postcopy-device until the destination successfully loads device data.
> There's still room for some enhancement though. Depending on how fast
> this loading is libvirt may issue cont before device data is loaded (the
> destination is already in postcopy-active at this point), which always
> succeeds as it only marks the domain to be autostarted, but the actual
> start may fail later. When discussing this with Juraj we agreed on
> introducing the new postcopy-device state on the destination as well to

I used to think and define postcopy-active be the state we should never be
able to cancel it anymore, implying that the real postcopy process is in
progress, and also implying the state where we need to start assume the
latest VM pages are spread on both sides, not one anymore.  Cancellation or
killing either side means crashing VM then.

It could be a good thing indeed to have postcopy-device on dest too from
that regard, because having postcopy-device on dest can mark out the small
initial window when dest qemu hasn't yet start to generate new data but
only applying old data (device data, which src also owns a copy).  From
that POV, that indeed does not belong to the point if we define
postcopy-active as above.

IOW, also with such definition, setting postcopy-active on dest QEMU right
at the entry of ram load thread (what we do right now..) is too early.

> make sure libvirt will only call cont once device data was successfully
> loaded so that we always get a proper result when running cont. But it

Do we know an estimate of how much extra downtime this would introduce?

We should have discussed this in a previous thread, the issue is if we cont
only after device loaded, then dest QEMU may need to wait a while until it
receives the cont from libvirt, that will contribute to the downtime.  It
would best be avoided, or if it's negligible then it's fine too but I'm not
sure whether it's guaranteed to be negligible..

If the goal is to make sure libvirt knows what is happening, can it still
relies on the event emitted, in this case, RESUME?  We can also reorg how
postcopy-device and postcopy-active states will be reported on dest, then
they'll help if RESUME is too coarse grained.

So far, dest QEMU will try to resume the VM after getting RUN command, that
is what loadvm_postcopy_handle_run_bh() does, and it will (when autostart=1
set): (1) firstly try to activate all block devices, iff it succeeded, (2)
do vm_start(), at the end of which RESUME event will be generated.  So
RESUME currently implies both disk activation success, and vm start worked.

> may still fail when locking disks fails (not sure if this is the only
> way cont may fail). In this case we cannot cancel the migration on the

Is there any known issue with locking disks that dest would fail?  This
really sound like we should have the admin taking a look.

I recall Juraj mentioned off list that drive lock sometimes will stop
working.  Is that relevant here?

> source as it is already in postcopy-active and we can't recover
> migration either as the CPUs are not running on the destination. Ideally
> we'd have a way of canceling the migration in postocpy-active if we are
> sure CPUs were not started yet. Alternatively a possibility to recover
> migration would work as well.

Thanks,

-- 
Peter Xu


