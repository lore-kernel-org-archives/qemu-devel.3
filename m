Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BCFECED635
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 12:16:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLKcS-0002SU-LY; Tue, 18 Nov 2025 07:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vLKcR-0002SE-B7
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 07:15:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vLKcP-0004Gr-Lo
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 07:15:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763468132;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=umY0RpuOIoORgXi79/PaaEg7Udocrl0Xq4FTKwgGtQE=;
 b=O0KDEjtsnO1hAZ3GIgTCeML9olVDHXHcR6E5yCtML48rJTOhva/aHvyixw0SbIxokBZT7j
 XxQpAorO6X1Fh22RXxF6K44rU9weYwiVHtoSXwncgKSO0aRERd+b3p5i3TA1dKLepr0C9t
 thlBigr1fAwBL89vomtExN9h3JYvVMw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-ZlCm3YzgPh6-w3pRdx72yA-1; Tue,
 18 Nov 2025 07:15:26 -0500
X-MC-Unique: ZlCm3YzgPh6-w3pRdx72yA-1
X-Mimecast-MFC-AGG-ID: ZlCm3YzgPh6-w3pRdx72yA_1763468125
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6772818AB406; Tue, 18 Nov 2025 12:15:25 +0000 (UTC)
Received: from localhost (dhcp-192-224.str.redhat.com [10.33.192.224])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 46933195608E; Tue, 18 Nov 2025 12:15:24 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Matthew Rosato
 <mjrosato@linux.ibm.com>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2] hw/s390x: Fix a possible crash with passed-through
 virtio devices
In-Reply-To: <a2c82393-ccc1-4dfc-92b1-69e10dd6adcc@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20251118093945.35062-1-thuth@redhat.com>
 <87ms4jr20v.fsf@redhat.com>
 <a2c82393-ccc1-4dfc-92b1-69e10dd6adcc@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Tue, 18 Nov 2025 13:15:21 +0100
Message-ID: <87jyznr0yu.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
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

> On 18/11/2025 12.52, Cornelia Huck wrote:
>> On Tue, Nov 18 2025, Thomas Huth <thuth@redhat.com> wrote:
>> 
>>> From: Thomas Huth <thuth@redhat.com>
>>>
>>> Consider the following nested setup: An L1 host uses some virtio device
>>> (e.g. virtio-keyboard) for the L2 guest, and this L2 guest passes this
>>> device through to the L3 guest. Since the L3 guest sees a virtio device,
>>> it might send virtio notifications to the QEMU in L2 for that device.
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
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   v2: Now with the required #include statement
>>>
>>>   hw/s390x/s390-hypercall.c | 13 +++++++++++++
>>>   1 file changed, 13 insertions(+)
>>>
>>> diff --git a/hw/s390x/s390-hypercall.c b/hw/s390x/s390-hypercall.c
>>> index ac1b08b2cd5..38f1c6132e0 100644
>>> --- a/hw/s390x/s390-hypercall.c
>>> +++ b/hw/s390x/s390-hypercall.c
>>> @@ -10,6 +10,7 @@
>>>    */
>>>   
>>>   #include "qemu/osdep.h"
>>> +#include "qemu/error-report.h"
>>>   #include "cpu.h"
>>>   #include "hw/s390x/s390-virtio-ccw.h"
>>>   #include "hw/s390x/s390-hypercall.h"
>>> @@ -42,6 +43,18 @@ static int handle_virtio_ccw_notify(uint64_t subch_id, uint64_t data)
>>>       if (!sch || !css_subch_visible(sch)) {
>>>           return -EINVAL;
>>>       }
>>> +    if (sch->id.cu_type != VIRTIO_CCW_CU_TYPE) {
>>> +        /*
>>> +         * This might happen in nested setups: If the L1 host defined the
>>> +         * L2 guest with a virtio device (e.g. virtio-keyboard), and the
>>> +         * L2 guest passes this device through to the L3 guest, the L3 guest
>>> +         * might send virtio notifications to the QEMU in L2 for that device.
>>> +         * But since the QEMU in L2 defined this device as vfio-ccw, it's not
>>> +         * a VirtIODevice that we can handle here!
>>> +         */
>>> +        warn_report_once("Got virtio notification for unsupported device!");
>> 
>> Maybe also print which device ended up here?
>
> You mean the values for cssid, ssid and schid ? Or which information did you 
> have in mind?

Yes, so that you can correlate this message to the configuration.


