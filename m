Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FDA7C369B2
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Apr 2025 09:42:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5LkP-0006eI-PX; Thu, 17 Apr 2025 05:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u5LkJ-0006bV-Hv
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 05:41:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1u5LkF-0007oz-AH
 for qemu-devel@nongnu.org; Thu, 17 Apr 2025 05:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744882877;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NFvO6IoBTjWYPf3Ebu5SIXQTPn3yrfwiURlOzjpikzQ=;
 b=jWbos/bicyn6xbBb7HWBO9DahV8GAgecaOO8X3ytfbGTIIcAU7gKtRWzIVDarkS2pRDzDo
 KtdCteTMGHwV0qRhSF53k/8X4owX/bxnwE5aTJmoKoXUN6uUbYJggbKKpXYIEJJ9NdTrCE
 0OE7RqjEyf3TWytOnF+rHHIyuOWcqcg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-Fz5ei7yjNjqCKdwe3dDzBA-1; Thu,
 17 Apr 2025 05:41:15 -0400
X-MC-Unique: Fz5ei7yjNjqCKdwe3dDzBA-1
X-Mimecast-MFC-AGG-ID: Fz5ei7yjNjqCKdwe3dDzBA_1744882874
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 768351956087; Thu, 17 Apr 2025 09:41:14 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.151])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 37C5A1954B00; Thu, 17 Apr 2025 09:41:12 +0000 (UTC)
Date: Thu, 17 Apr 2025 10:41:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Yuri Nesterov <yuri.nesterov@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] usb-host: enable autoscan for bus+addr to survive host
 suspend/resume
Message-ID: <aADMttudIP3zC85W@redhat.com>
References: <20250416161929.2846102-1-yuri.nesterov@gmail.com>
 <Z__jtQe0nYsaGnoH@redhat.com>
 <CAB_o470VGNmj_4LKvo3-Y6O7LiKiJ4QXczt6ZqRua_mpM1LN2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB_o470VGNmj_4LKvo3-Y6O7LiKiJ4QXczt6ZqRua_mpM1LN2A@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Apr 16, 2025 at 10:27:54PM +0300, Yuri Nesterov wrote:
> On Wed, Apr 16, 2025 at 8:07 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Wed, Apr 16, 2025 at 07:19:29PM +0300, Yuri Nesterov wrote:
> > > Currently, there is a special case for usb-host devices added using the
> > > hostbus= and hostaddr= properties to avoid adding them to the hotplug
> > > watchlist, since the address changes every time the device is plugged
> > > in. However, on Linux, when the host system goes into suspend and then
> > > resumes, those devices stop working in both the guest and the host.
> > >
> > > Enabling autoscan and adding those devices to the watchlist allows them
> > > to keep working in the guest after host suspend/resume.
> >
> > So IIUC what you're saying is that on suspend the host device
> > is removed by the kernel, and on resume, the USB device is
> > recreated. So QEMU's open file handle for the USB device is
> > invalid after resume.
> >
> > If the /dev/bus/usb/NNN/NNN file goes away and then gets
> > re-created by the kernel though, we can't assume QEMU is
> > going to be able to re-open the new /dev/bus/usb device
> > file though.
> 
> I'm not sure if the file actually goes away. It looks like the internal
> state of the device changes and QEMU receives a "no device"
> response in usb_host_req_complete_data. However, the file
> remains in place. At least I don't see any changes in udevadm
> monitor or inotifywait aside from attribute modifications.
> 
> After resuming from suspend, the device doesn't work on either
> host or guest. Probably the device stays with a detached kernel
> driver since QEMU can't reattach it after receiving the "no device"
> error. Adding such devices to the hotplug watchlist causes QEMU
> to reopen them the same way it does for devices specified by
> vendorid and productid or hostport.

This is a bit odd, as AFAICT from reading the code, the
usb_host_auto_check wll only trigger close + re-open of
the device, if there is a period of time in which the
/dev/bus/usb device node does not exist, but you're
saying it remains existing across suspend/resume.

> 
> The reason bus+addr devices aren't currently added to that list is well
> explained in commit e058fa2dd599ccc780d334558be9c1d155222b80.
> A special case was made because the device address changes every
> time it's replugged. However, it turns out that it doesn't change after
> a suspend/resume cycle so adding them to the list allows them to
> keep working after resume.
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


