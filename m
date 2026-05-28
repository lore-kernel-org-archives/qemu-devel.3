Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5925CD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 15:11:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wScOD-0000RM-12; Thu, 28 May 2026 11:11:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wScO9-0000Q9-GX
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:11:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1wScO2-0004rr-3N
 for qemu-devel@nongnu.org; Thu, 28 May 2026 11:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779981064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nPDbztg8jcXDhNp+Yg4MMTER/9txcWX/5Dh8mLtVsb0=;
 b=bE7n1rKZA5Rq0SR6oSMqp90DGZt2Ved+4mP2T9TN6UpcGdt/jfN4INDatNxxuq6hUL2fF/
 oP6a3/1qTpXIX6ez7n6LGguV7FEivR1BYxbQBuScQ9olsAyO55zXQYtP2ip8E1f5XymLBM
 bfumYNrZLnW9JDDS8RtazrNWulYw/lQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542--NHTBqVdMe6KQwrFPJPpeg-1; Thu,
 28 May 2026 11:11:00 -0400
X-MC-Unique: -NHTBqVdMe6KQwrFPJPpeg-1
X-Mimecast-MFC-AGG-ID: -NHTBqVdMe6KQwrFPJPpeg_1779981059
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BF9971956088; Thu, 28 May 2026 15:10:58 +0000 (UTC)
Received: from localhost (unknown [10.44.49.185])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 654211686; Thu, 28 May 2026 15:10:56 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, zhaoguohan@kylinos.cn,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Alex Williamson <alex@shazbot.org>, Eric Farman
 <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, Tony
 Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Jason
 Herne <jjherne@linux.ibm.com>
Subject: Re: [PATCH v2 0/2] vfio: propagate IRQ notifier registration failure
In-Reply-To: <db82450e-a3fd-41ba-963b-4e0730ea34cb@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260510084353.58263-1-zhaoguohan@kylinos.cn>
 <87o6hzmvm2.fsf@redhat.com>
 <db82450e-a3fd-41ba-963b-4e0730ea34cb@redhat.com>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Thu, 28 May 2026 17:10:54 +0200
Message-ID: <87ldd3muwx.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Thu, May 28 2026, C=C3=A9dric Le Goater <clg@redhat.com> wrote:

> On 5/28/26 16:55, Cornelia Huck wrote:
>> On Sun, May 10 2026, zhaoguohan@kylinos.cn wrote:
>>=20
>>> From: GuoHan Zhao <zhaoguohan@kylinos.cn>
>>>
>>> vfio_ap_register_irq_notifier() and vfio_ccw_register_irq_notifier() cl=
ean
>>> up the fd handler and EventNotifier when vfio_device_irq_set_signaling()
>>> fails, but still return true to their callers.
>>>
>>> Return false after cleanup so callers can handle the failed registration
>>> path instead of treating it as a successful notifier setup.
>>>
>>> Please ignore the previous version.
>>>
>>> GuoHan Zhao (2):
>>>    vfio/ap: Return false when IRQ notifier setup fails
>>>    vfio/ccw: Return false when IRQ notifier setup fails
>>>
>>>   hw/vfio/ap.c  | 1 +
>>>   hw/vfio/ccw.c | 1 +
>>>   2 files changed, 2 insertions(+)
>>>
>>=20
>> ...I guess this should go through the s390 tree (and not the vfio tree?)
>> If yes, I'll pick it up.
>>=20
>
> I included these patches in my VFIO PR  last week. They are merged.
>
>    https://lore.kernel.org/qemu-devel/20260520162115.1613601-1-clg@redhat=
.com/
>
> Hope that's fine ? Sorry if not :/

Completely fine, thx, I just overlooked it :)


