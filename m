Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69744C624D0
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 10:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1iO3-0001GV-Tl; Wed, 02 Sep 2026 06:40:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x1iO2-0001Fq-O7
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 06:40:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x1iO0-000549-V7
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 06:40:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788345606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cjzOQpLff3xZzZoFZdm11n8/lOW/Ioct3v9swDcavug=;
 b=fCK5h3QIzzZkjPaQvM5p+ECtIWwLRrebK3xckWLxhfRuANASsG8Ej7LSX+i6GZDUTtiA5L
 +Emd89aXu6TKNaf75cdUo0DD4/gmN6dZsXCLgq+DjjDBN3+t5DFUIAFFSZGrSQ3c7RLoPt
 qVmgqxsynnJ5rwRlB7LjCOuS/SJoGms=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-340-uheE_GFoOfmcZIFBYzSkwA-1; Wed,
 02 Sept 2026 06:40:03 -0400
X-MC-Unique: uheE_GFoOfmcZIFBYzSkwA-1
X-Mimecast-MFC-AGG-ID: uheE_GFoOfmcZIFBYzSkwA_1788345602
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 689A4195605E; Wed,  2 Sep 2026 10:40:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 611B418005BB; Wed,  2 Sep 2026 10:40:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0241421E682B; Wed, 02 Sep 2026 12:39:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>
Cc: Farhan Ali <alifm@linux.ibm.com>,  qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org,  mjrosato@linux.ibm.com,  farman@linux.ibm.com,
 cohuck@redhat.com,  alex@shazbot.org,  Shameer Kolothum
 <skolothumtho@nvidia.com>
Subject: Re: [PATCH v4 2/4] vfio/pci: Add an error handler callback
In-Reply-To: <7d930283-11c1-4b54-b8e9-1158eed5b442@redhat.com>
 (=?utf-8?Q?=22C=C3=A9dric?= Le
 Goater"'s message of "Wed, 2 Sep 2026 10:07:55 +0200")
References: <20260831183151.12626-1-alifm@linux.ibm.com>
 <20260831183151.12626-3-alifm@linux.ibm.com>
 <7d930283-11c1-4b54-b8e9-1158eed5b442@redhat.com>
Date: Wed, 02 Sep 2026 12:39:57 +0200
Message-ID: <87ecfc3pj6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

C=C3=A9dric Le Goater <clg@redhat.com> writes:

> +Shameer, who is looking at forwarding AER errors to guest :
>
>    https://lore.kernel.org/qemu-devel/SJ0PR12MB8614DDFEE3A9575564EDEF99AB=
FF2@SJ0PR12MB8614.namprd12.prod.outlook.com/
>
> On 8/31/26 20:31, Farhan Ali wrote:
>> Provide a vfio error handling callback, that can be used by devices to
>> handle PCI errors for passthrough devices.
>>=20
>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>> ---
>>   hw/vfio/pci.c | 27 +++++++++++++++++++++------
>>   hw/vfio/pci.h |  1 +
>>   2 files changed, 22 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>> index 428ab2f069..a2f489b34d 100644
>> --- a/hw/vfio/pci.c
>> +++ b/hw/vfio/pci.c
>> @@ -3244,21 +3244,36 @@ void vfio_pci_put_device(VFIOPCIDevice *vdev)
>>   static void vfio_err_notifier_handler(void *opaque)
>>   {
>>       VFIOPCIDevice *vdev =3D opaque;
>> +    Error *err =3D NULL;
>>=20=20=20
>>       if (!event_notifier_test_and_clear(&vdev->err_notifier)) {
>>           return;
>>       }
>>=20=20=20
>>       /*
>> -     * TBD. Retrieve the error details and decide what action
>> -     * needs to be taken. One of the actions could be to pass
>> -     * the error to the guest and have the guest driver recover
>> -     * from the error. This requires that PCIe capabilities be
>> -     * exposed to the guest. For now, we just terminate the
>> +     * We can retrieve the error details and decide what action
>> +     * needs to be taken in err_handler(). One of the actions could
>> +     * be to pass the error to the guest and have the guest driver
>> +     * recover from the error. This requires that PCIe capabilities be
>> +     * exposed to the guest.
>> +     *
>> +     * If err_handler() is not implemented/fails, we just terminate the
>>        * guest to contain the error.
>>        */
>>=20=20=20
>> -    error_report("%s(%s) Unrecoverable error detected. Please collect a=
ny data possible and then kill the guest", __func__, vdev->vbasedev.name);
>> +    if (vdev->err_handler && vdev->err_handler(vdev, &err)) {
>> +        return;
>> +    }
>> +
>> +    if (err) {
>> +        error_prepend(&err, "Unrecoverable PCIe error detected for devi=
ce %s",
>> +                      vdev->vbasedev.name);

This requires use of ERRP_GUARD().  See "Why, when and how to use
ERRP_GUARD()" in qapi/error.h.

>> +        error_report_err(err);
>> +    } else {
>> +        error_printf("Unrecoverable PCIe error detected for device %s",
>> +                     vdev->vbasedev.name);
>> +    }
>> +    error_printf("Please collect any data possible and then kill the gu=
est");
>
> how about that instead :
>
>    if (err) {
>        error_report("Unrecoverable PCIe error detected for device %s: %s",
>                     vdev->vbasedev.name, error_get_pretty(err));
>        error_free(err);
>    } else {
>        error_report("Unrecoverable PCIe error detected for device %s",
>                     vdev->vbasedev.name);
>    }
>    error_printf("Please collect any data possible and then kill the guest=
\n");

I prefer use of error_report_err(), because it displays hints added with
error_append_hint(), if any.

>>=20=20=20
>>       vm_stop(RUN_STATE_INTERNAL_ERROR);
>>   }

[...]


