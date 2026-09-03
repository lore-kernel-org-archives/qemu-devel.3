Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6CDBC61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24d3-00087y-9t; Thu, 03 Sep 2026 06:25:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x24d1-000877-9C
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:25:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x24cz-0002XM-8K
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:25:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788431103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vmI1QZIUKS0fL5rKs/fS2pcrfXA8lYfEhYvmmxGrtHE=;
 b=g/N3L7pQQ7HM4rYRrqEjWKMzhSOKyF41si39Of6os4xnIm+pLpKOntgjDZHj5uhRoSY7Rr
 52sAMoASjSjPzWPTsyXcb1IYZD+9V4jfhPHOX0qwWLaAC8CcoX90lms63M7h4tPXEfnxmK
 HdOaKBpiuqNJCxW6TXGOrAqsMqj+sjM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-256-ImeWsb5LMa6eqUpjun3eVg-1; Thu,
 03 Sep 2026 06:25:01 -0400
X-MC-Unique: ImeWsb5LMa6eqUpjun3eVg-1
X-Mimecast-MFC-AGG-ID: ImeWsb5LMa6eqUpjun3eVg_1788431099
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 598AF185FD8A; Thu,  3 Sep 2026 10:24:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B57C318005BB; Thu,  3 Sep 2026 10:24:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5720321E6837; Thu, 03 Sep 2026 12:24:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org,  mjrosato@linux.ibm.com,  farman@linux.ibm.com,
 cohuck@redhat.com,  alex@shazbot.org,  Shameer Kolothum
 <skolothumtho@nvidia.com>
Subject: Re: [PATCH v4 2/4] vfio/pci: Add an error handler callback
In-Reply-To: <2bd79117-a66f-49b9-a936-592ad2e00ceb@linux.ibm.com> (Farhan
 Ali's message of "Wed, 2 Sep 2026 09:23:10 -0700")
References: <20260831183151.12626-1-alifm@linux.ibm.com>
 <20260831183151.12626-3-alifm@linux.ibm.com>
 <7d930283-11c1-4b54-b8e9-1158eed5b442@redhat.com>
 <87ecfc3pj6.fsf@pond.sub.org>
 <2bd79117-a66f-49b9-a936-592ad2e00ceb@linux.ibm.com>
Date: Thu, 03 Sep 2026 12:24:56 +0200
Message-ID: <87y0diws1z.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Farhan Ali <alifm@linux.ibm.com> writes:

> On 9/2/2026 3:39 AM, Markus Armbruster wrote:
>> C=C3=A9dric Le Goater <clg@redhat.com> writes:
>>
>>> +Shameer, who is looking at forwarding AER errors to guest :
>>>
>>>     https://lore.kernel.org/qemu-devel/SJ0PR12MB8614DDFEE3A9575564EDEF9=
9ABFF2@SJ0PR12MB8614.namprd12.prod.outlook.com/
>>>
>>> On 8/31/26 20:31, Farhan Ali wrote:
>>>> Provide a vfio error handling callback, that can be used by devices to
>>>> handle PCI errors for passthrough devices.
>>>>
>>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>>>> ---
>>>>    hw/vfio/pci.c | 27 +++++++++++++++++++++------
>>>>    hw/vfio/pci.h |  1 +
>>>>    2 files changed, 22 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>>> index 428ab2f069..a2f489b34d 100644
>>>> --- a/hw/vfio/pci.c
>>>> +++ b/hw/vfio/pci.c
>>>> @@ -3244,21 +3244,36 @@ void vfio_pci_put_device(VFIOPCIDevice *vdev)
>>>>  static void vfio_err_notifier_handler(void *opaque)
>>>>  {
>>>>      VFIOPCIDevice *vdev =3D opaque;
>>>> +    Error *err =3D NULL;
>>>>
>>>>      if (!event_notifier_test_and_clear(&vdev->err_notifier)) {
>>>>          return;
>>>>      }
>>>>
>>>>      /*
>>>> -     * TBD. Retrieve the error details and decide what action
>>>> -     * needs to be taken. One of the actions could be to pass
>>>> -     * the error to the guest and have the guest driver recover
>>>> -     * from the error. This requires that PCIe capabilities be
>>>> -     * exposed to the guest. For now, we just terminate the
>>>> +     * We can retrieve the error details and decide what action
>>>> +     * needs to be taken in err_handler(). One of the actions could
>>>> +     * be to pass the error to the guest and have the guest driver
>>>> +     * recover from the error. This requires that PCIe capabilities be
>>>> +     * exposed to the guest.
>>>> +     *
>>>> +     * If err_handler() is not implemented/fails, we just terminate t=
he
>>>>       * guest to contain the error.
>>>>       */
>>>>
>>>> -    error_report("%s(%s) Unrecoverable error detected. Please collect=
 any data possible and then kill the guest", __func__, vdev->vbasedev.name);
>>>> +    if (vdev->err_handler && vdev->err_handler(vdev, &err)) {
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    if (err) {
>>>> +        error_prepend(&err, "Unrecoverable PCIe error detected for de=
vice %s",
>>>> +                      vdev->vbasedev.name);
>>
>> This requires use of ERRP_GUARD().  See "Why, when and how to use
>> ERRP_GUARD()" in qapi/error.h.
>
> okay, I can add the ERRP_GUARD(). AFAIU it will then look something like =
this?
>
> Error **errp =3D NULL;

Pretty sure you mean

  Error *errp =3D NULL;

> ERRP_GUARD();

Put ERRP_GUARD() right at the beginning of the function.

>
> if (vdev->err_handler && vdev->err_handler(vdev, errp)) {
> 	return;
> }
>
> if (*errp) {
> 	//print error with errp
> } else {
> 	//generic error
> }

I don't this "uh, have we got an error?", to be honest.  What about:

        if (!vdev->err_handler) {
            error_report([...]);
        } else if (!vdev->err_handler(vdev, &err)) {
            error_prepend(&err, [...]);
            error_report_err(err);
        } else {
            /* Error handled */
            return;
        }

        vm_stop(RUN_STATE_INTERNAL_ERROR);

This makes it quite obvious what each error report is about.  Requires
vdev->err_handler() to set an error when it fails, which it totally
should.

Matter of taste, and I'm not the maintainer here, C=C3=A9dric and Alex are.


