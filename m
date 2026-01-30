Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6240E6BF20
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 16:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlrP2-0000My-73; Fri, 30 Jan 2026 11:31:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vlrP1-0000MZ-1W
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 11:31:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vlrOz-0002r3-A6
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 11:31:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769790679;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uguVw0yt3k8Yqmho+aUHZfZwdBpUHFvQMCdDRkTXfGY=;
 b=Ul5f+UM4a2DkG7v1w77HWgNgcv//0CVd9qIbqm0/mFyowFJgIbUhZdJu/bkPQLRORDEBwC
 wAyudsnPtY06dmZSvzkKGnhhpvVmFvn5SHBaq9BQ88pbrgZTgON3EJFTecC5VFR/FmnmM2
 W9ZPTYUdbHJSXlE7t3SeV2YX5Ziug4Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-6HhriAfnPcOD-C_aH9ZbiQ-1; Fri,
 30 Jan 2026 11:31:15 -0500
X-MC-Unique: 6HhriAfnPcOD-C_aH9ZbiQ-1
X-Mimecast-MFC-AGG-ID: 6HhriAfnPcOD-C_aH9ZbiQ_1769790673
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C89E71800451; Fri, 30 Jan 2026 16:31:12 +0000 (UTC)
Received: from localhost (unknown [10.67.32.74])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C336619560A2; Fri, 30 Jan 2026 16:31:09 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, sgarzare@redhat.com, raphael@enfabrica.net,
 qemu-devel@nongnu.org, yc-core@yandex-team.ru, d-tatianin@yandex-team.ru,
 Richard Henderson <richard.henderson@linaro.org>, Ilya Leoshkevich
 <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>, Thomas Huth
 <thuth@redhat.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, "open list:virtio-ccw"
 <qemu-s390x@nongnu.org>
Subject: Re: [PATCH v4 08/23] virtio: move common part of
 _set_guest_notifier to generic code
In-Reply-To: <28313ff2e6fc34f45304ba19b8b9380fc4ba167d.camel@linux.ibm.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260119185228.203296-1-vsementsov@yandex-team.ru>
 <20260119185228.203296-9-vsementsov@yandex-team.ru>
 <20260124000624.1bd7c9c1.pasic@linux.ibm.com>
 <26198787-a1da-4858-8656-f5006d153d6e@yandex-team.ru>
 <20260126230026.2664d565.pasic@linux.ibm.com>
 <28313ff2e6fc34f45304ba19b8b9380fc4ba167d.camel@linux.ibm.com>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Fri, 30 Jan 2026 17:31:04 +0100
Message-ID: <87ecn7t647.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jan 30 2026, Eric Farman <farman@linux.ibm.com> wrote:

> On Mon, 2026-01-26 at 23:00 +0100, Halil Pasic wrote:
>> On Mon, 26 Jan 2026 19:40:09 +0300
>> Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru> wrote:
>> 
>> > > > +/**
>> > > > + * virtio_queue_set_guest_notifier - set/unset queue or config guest
>> > > > + *     notifier
>> > > > + *
>> > > > + * @vdev: the VirtIO device
>> > > > + * @n: queue number, or VIRTIO_CONFIG_IRQ_IDX to set config notifer  
>> > > 
>> > > Semantically are mixing queue numbers and interrupt indexes here.  
>> > 
>> > That's preexisting logic in virtio_pci_set_guest_notifier_fd_handler().
>> > 
>> > But, you are right, that's doesn't answer the question, is it good to share
>> > the logic with mmio and ccw.
>> > 
>> > Is config notifier only pci specific, or similar feature may appear in future
>> > for mmio and/or ccw?
>> 
>> AFAIR there is no  notifier for ccw. A possible explanation for
>> that is, that AFAIK that config space notifications (device -> driver)
>> are always classic I/O interrupts while queue indicators can be so called
>> adapter I/O interrupts and irqfd is only available for adapter I/O
>> interrupts. 
>> 
>> If you like you can have a look at 
>> "4.3.2.6 Setting Up Indicators" in
>> https://docs.oasis-open.org/virtio/virtio/v1.3/csd01/virtio-v1.3-csd01.html#x1-1940003
>> 
>> I see no reason why virtio_config_guest_notifier_read() based, i.e
>> !irqfd virtio config notifier should not exist or would not work. And I
>> guess it is needed for certain vhost things. But nevertheless, I can't
>> find the place where a virtio-ccw config notifier is set up.
>> 
>> Eric, what is your opinion on this? My current thinking is that
>> virtio-ccw not having a config notifier is basically a bug.
>
> (Sorry that I missed this; thanks for the ping, Halil)
>
> Yeah, we don't have have such a config notifier and I don't recall the history behind it.

Adapter interrupts were not a thing for virtio-ccw in the beginning (we
only added the airq infrastructure later IIRC, so all interrupts were
"classic" subchannel-based interrupts.)

> But I don't know that it's a bug; spec points out config notifications for ccw come as unsolicited
> interrupts versus config notifier, so not having one is fine by me as far as this refactoring goes.
> I'll add it to a list of things to play around with, though.

I think I agree.

(Although my brain is already more than halfway into the weekend...)


