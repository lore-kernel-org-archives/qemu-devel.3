Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8EBCED63B
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 14:25:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLMdy-0005WS-1J; Tue, 18 Nov 2025 09:25:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vLMdu-0005VB-Dh
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 09:25:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vLMds-00071H-Le
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 09:25:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763475911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cdBqXFnL/T6LgDFGbWUz9B584w70+yEj1PXtSccK3D4=;
 b=ETY362YCp9991Jh2VAgSRTrussYezJXSUlkcupXIGtCxGpVukZW2hDW4UmvMXuoshG7kb3
 xDKPYTXypCSUK9xGzbtNzvouWV50tVPXePyGQtV0j8e1Lik52InZYuJOPaOHoOq/408wpu
 LtUxxhcSXyxT5qGe9qlWfeY1j/sK2/A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-550-guinaFF6NdOwapytHckDAA-1; Tue,
 18 Nov 2025 09:25:06 -0500
X-MC-Unique: guinaFF6NdOwapytHckDAA-1
X-Mimecast-MFC-AGG-ID: guinaFF6NdOwapytHckDAA_1763475905
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ECB3E180122B; Tue, 18 Nov 2025 14:25:04 +0000 (UTC)
Received: from localhost (dhcp-192-224.str.redhat.com [10.33.192.224])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0BAA7180047F; Tue, 18 Nov 2025 14:25:03 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: qemu-s390x@nongnu.org, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Matthew
 Rosato <mjrosato@linux.ibm.com>, qemu-devel@nongnu.org, David Hildenbrand
 <david@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2] hw/s390x: Fix a possible crash with passed-through
 virtio devices
In-Reply-To: <50f79156-dd93-40c4-831e-66e558531be8@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20251118093945.35062-1-thuth@redhat.com>
 <20251118130218.30d3da33.pasic@linux.ibm.com>
 <50f79156-dd93-40c4-831e-66e558531be8@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Tue, 18 Nov 2025 15:25:01 +0100
Message-ID: <87h5urquyq.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Nov 18 2025, Thomas Huth <thuth@redhat.com> wrote:

> On 18/11/2025 13.02, Halil Pasic wrote:
>> On Tue, 18 Nov 2025 10:39:45 +0100
>> Thomas Huth <thuth@redhat.com> wrote:
>> 
>>> Consider the following nested setup: An L1 host uses some virtio device
>>> (e.g. virtio-keyboard) for the L2 guest, and this L2 guest passes this
>>> device through to the L3 guest. Since the L3 guest sees a virtio device,
>>> it might send virtio notifications to the QEMU in L2 for that device.
>> 
>> Hm, but conceptually the notification is sent to the virtio device,
>> regardless of hypervisors, right? But because for virtio-ccw the
>> notification is an DIAG 500, we have the usual cascade of intercept
>> handling. And because we have never considered this scenario up till now
>> the intercept handler in L2 QEMU gets called, because it is usually the
>> responsibility of L2 QEMU to emulate instructions for an L3 guest.
>
> Right.
>
>> I think vfio-ccw pass through was supposed to be only about DASD.
>
> Yes. And we only noticed this bug by accident - while trying to pass through 
> a DASD device, the wrong device was used for VFIO and suddenly QEMU crashed.

That boils down to the fact that we don't know (at the kernel level) if
we're dealing with a dasd or something else, as we're operating on the
subchannel level. We certainly don't want to deal with devices whose
(Linux) drivers do funky things with ccws, or devices where we need to
support side-channel notifications, like virtio-ccw.

>
>>> But since the QEMU in L2 defined this device as vfio-ccw, the function
>>> handle_virtio_ccw_notify() cannot handle this and crashes: It calls
>>> virtio_ccw_get_vdev() that casts sch->driver_data into a VirtioCcwDevice,
>>> but since "sch" belongs to a vfio-ccw device, that driver_data rather
>>> points to a CcwDevice instead. So as soon as QEMU tries to use some
>>> VirtioCcwDevice specific data from that device, we've lost.
>>>
>>> We must not take virtio notifications for such devices. Thus fix the
>>> issue by adding a check to the handle_virtio_ccw_notify() handler to
>>> refuse all devices that are not our own virtio devices.
>> 
>> I'm on board with this patch! Virtio notifications are only supported
>> for virtio devices and if a guest for what ever reason attempts
>> to do a virtio notification on a non-virtio device, that should be
>> handled accordingly. Which would be some sort of a program exception
>> I guess. Maybe you could add what kind of exception do we end up
>> with to the commit message. I would guess specification exception.
>> 
>> But I would argue that the L3 guest didn't do anything wrong.
>
> That's the point - the L3 guest just sees a virtio device, so we should not 
> punish it with program exceptions just because it tried to send a 
> notification for the device.
>
>> Pass-through of virtio-ccw devices is simply not implemented yet
>> properly. And even  if we were to swallow that notification silently,
>> it would be effectively loss of initiative I guess.
>
> I think the current patch does the right thing: It returns an error value to 
> the guest (just like we're doing it in other spots in this function 
> already), so the guest sees that error value and then can finally give up on 
> using the device.
>
>> So I think it would really make sense to prevent passing through
>> virtio-ccw devices with vfio-ccw.
>
> That could be a nice addition on top (in another patch), but we have to fix 
> handle_virtio_ccw_notify() anyway to avoid that the L3 guest can crash QEMU, 
> so it's certainly not a replacement for this patch, I think.

"Prevent crashing" is certainly the correct first step :)

I'm not sure where we would want prevent assignment of non-dasd
devices. The kernel can't (because we're dealing with a subchannel
driver.) I think maybe management software on top of QEMU?

The other direction would be supporting things like diag500, so we could
pass through virtio-ccw devices as well. But I'm not really seeing a
use case for it, or is there one?


