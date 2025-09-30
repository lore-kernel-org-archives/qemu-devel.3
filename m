Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B2B7CAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 09:21:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3WXj-0000Do-DT; Tue, 30 Sep 2025 05:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v3WXh-0000Cl-RU
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 05:21:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v3WXa-0004Xx-Bj
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 05:21:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759224055;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sJM0UBMoKkMTYqAwbs8RMvxSm86k0ejJKAxYmjzYo1w=;
 b=f3RFmA8SbT2ydytYuxGK/aZ+0qGepDv0uCt643P5ptBwvmL1lgov3dglat1hRpfni4lBpH
 fGLIuCffJNa4wxnvqBW97+EcK5EdEjMhvOseqf8nL039d4MUgInVNKfoZ0Gdp1aCwoHsBj
 Wf2uXLS284pG1RmyWOefOAu0Sk1h80U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-zGYOZ_sFMuGATenl_VokeQ-1; Tue,
 30 Sep 2025 05:20:51 -0400
X-MC-Unique: zGYOZ_sFMuGATenl_VokeQ-1
X-Mimecast-MFC-AGG-ID: zGYOZ_sFMuGATenl_VokeQ_1759224050
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 674531800451; Tue, 30 Sep 2025 09:20:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3DD71956095; Tue, 30 Sep 2025 09:20:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6A6DF21E6A27; Tue, 30 Sep 2025 11:20:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org,  mjrosato@linux.ibm.com,  thuth@redhat.com,
 alex.williamson@redhat.com
Subject: Re: [PATCH v3 2/5] vfio/pci: Add an error handler callback
In-Reply-To: <0c221734-5faf-4829-bc17-21ec96a91fa5@linux.ibm.com> (Farhan
 Ali's message of "Mon, 29 Sep 2025 10:20:38 -0700")
References: <20250925174852.1302-1-alifm@linux.ibm.com>
 <20250925174852.1302-3-alifm@linux.ibm.com>
 <87qzvtstd7.fsf@pond.sub.org>
 <90de0c70-9309-4fd0-a5d7-3bd9e7088a0e@linux.ibm.com>
 <87ms6gmo4j.fsf@pond.sub.org>
 <4207529b-a0a5-4360-8449-f4c20661e9e8@redhat.com>
 <0c221734-5faf-4829-bc17-21ec96a91fa5@linux.ibm.com>
Date: Tue, 30 Sep 2025 11:20:47 +0200
Message-ID: <87qzvo9tzk.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Farhan Ali <alifm@linux.ibm.com> writes:

> On 9/27/2025 12:05 AM, C=C3=A9dric Le Goater wrote:
>> On 9/27/25 07:59, Markus Armbruster wrote:
>>> Farhan Ali <alifm@linux.ibm.com> writes:
>>>
>>>> On 9/25/2025 9:57 PM, Markus Armbruster wrote:
>>>>> Farhan Ali <alifm@linux.ibm.com> writes:
>>>>>
>>>>>> Provide a vfio error handling callback, that can be used by devices =
to
>>>>>> handle PCI errors for passthrough devices.
>>>>>>
>>>>>> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
>>>>>> ---
>>>>>> =C2=A0=C2=A0 hw/vfio/pci.c | 8 ++++++++
>>>>>> =C2=A0=C2=A0 hw/vfio/pci.h | 1 +
>>>>>> =C2=A0=C2=A0 2 files changed, 9 insertions(+)
>>>>>>
>>>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>>>>> index bc0b4c4d56..b02a974954 100644
>>>>>> --- a/hw/vfio/pci.c
>>>>>> +++ b/hw/vfio/pci.c
>>>>>> @@ -3063,11 +3063,19 @@ void vfio_pci_put_device(VFIOPCIDevice *vdev)
>>>>>> =C2=A0 static void vfio_err_notifier_handler(void *opaque)
>>>>>> =C2=A0 {
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VFIOPCIDevice *vdev =3D opaque;
>>>>>> +=C2=A0=C2=A0=C2=A0 Error *err =3D NULL;
>>>>>>
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!event_notifier_test_and_clear(&v=
dev->err_notifier)) {
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>>
>>>>>> +=C2=A0=C2=A0=C2=A0 if (vdev->err_handler) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (vdev->err_handler(vd=
ev, &err)) {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
return;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report_err(err);
>>>>>> +=C2=A0=C2=A0=C2=A0 }
>>>>>
>>>>> This is unusual.
>>>>>
>>>>> Functions taking an Error ** argument usually do so to report errors.
>>>>> The rules spelled out in qapi/error.h apply.=C2=A0 In particular:
>>>>>
>>>>> =C2=A0=C2=A0 * - On success, the function should not touch *errp.=C2=
=A0 On failure, it
>>>>> =C2=A0=C2=A0 *=C2=A0=C2=A0 should set a new error, e.g. with error_se=
tg(errp, ...), or
>>>>> =C2=A0=C2=A0 *=C2=A0=C2=A0 propagate an existing one, e.g. with error=
_propagate(errp, ...).
>>>>> =C2=A0=C2=A0 *
>>>>> =C2=A0=C2=A0 * - Whenever practical, also return a value that indicat=
es success /
>>>>> =C2=A0=C2=A0 *=C2=A0=C2=A0 failure.=C2=A0 This can make the error che=
cking more concise, and can
>>>>> =C2=A0=C2=A0 *=C2=A0=C2=A0 avoid useless error object creation and de=
struction. Note that
>>>>> =C2=A0=C2=A0 *=C2=A0=C2=A0 we still have many functions returning voi=
d.=C2=A0 We recommend
>>>>> =C2=A0=C2=A0 *=C2=A0=C2=A0 =E2=80=A2 bool-valued functions return tru=
e on success / false on failure,
>>>>>
>>>>> If ->err_handler() behaved that way, it @err would be null after it
>>>>> returns false.=C2=A0 We'd call error_report_err(NULL), and crash.
>>>>>
>>>>> Functions with unusual behavior need a contract: a comment spelling o=
ut
>>>>> their behavior.
>>>>>
>>>>> What is the intended behavior of the err_handler() callback?
>>>>
>>>> Hi Markus,
>>>>
>>>> Thanks for reviewing! The intended behavior for err_handler() is to se=
t errp and report the error on false/failure. With the above code, I also i=
ntended fall through to vm_stop() when err_handler() fails.
>>>>
>>>> I think I misunderstood the errp error handling, it seems like the cor=
rect way to do what I intended would be
>>>>
>>>> diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
>>>> index b02a974954..630de46c90 100644
>>>> --- a/hw/vfio/pci.c
>>>> +++ b/hw/vfio/pci.c
>>>> @@ -3070,10 +3070,11 @@ static void vfio_err_notifier_handler(void *op=
aque)
>>>> =C2=A0=C2=A0 =C2=A0 =C2=A0}
>>>>
>>>> =C2=A0=C2=A0 =C2=A0 =C2=A0if (vdev->err_handler) {
>>>> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (vdev->err_handler(vdev, &err)) {
>>>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!vdev->err_handler(vdev, &err)) {
>>>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(err);
>>>> +=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {
>>>> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;
>>>> =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>>>> -=C2=A0 =C2=A0 =C2=A0 =C2=A0 error_report_err(err);
>>>> =C2=A0=C2=A0 =C2=A0 =C2=A0}
>>>>
>>>> Please correct me if I missed anything.
>>>
>>> Resulting function:
>>>
>>> =C2=A0=C2=A0=C2=A0 static void vfio_err_notifier_handler(void *opaque)
>>> =C2=A0=C2=A0=C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VFIOPCIDevice *vdev =3D opaq=
ue;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *err =3D NULL;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!event_notifier_test_and=
_clear(&vdev->err_notifier)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (vdev->err_handler) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
!vdev->err_handler(vdev, &err)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 error_report_err(err);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } el=
se {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * TBD. Retrieve the er=
ror details and decide what action
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * needs to be taken. O=
ne of the actions could be to pass
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the error to the gue=
st and have the guest driver recover
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * from the error. This=
 requires that PCIe capabilities be
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * exposed to the guest=
. For now, we just terminate the
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * guest to contain the=
 error.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("%s(%s) Unrecov=
erable error detected. Please collect any data possible and then kill the g=
uest", __func__, vdev->vbasedev.name);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vm_stop(RUN_STATE_INTERNAL_E=
RROR);
>>> =C2=A0=C2=A0=C2=A0 }
>>>
>>> Slighly rearranged for clearer control flow:
>>>
>>> =C2=A0=C2=A0=C2=A0 static void vfio_err_notifier_handler(void *opaque)
>>> =C2=A0=C2=A0=C2=A0 {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 VFIOPCIDevice *vdev =3D opaq=
ue;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error *err =3D NULL;
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!event_notifier_test_and=
_clear(&vdev->err_notifier)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (vdev->err_handler) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (=
vdev->err_handler(vdev, &err)) {
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 /* Error successfully handled */
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return;
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 erro=
r_report_err(err);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>
> Yes, this is what i intended to do with my patch and provide a clearer fl=
ow. Though the compiler error reported by Cedric, is a little confusing, ne=
ed to understand why that happens.
>
>
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * TBD. Retrieve the er=
ror details and decide what action
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * needs to be taken. O=
ne of the actions could be to pass
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the error to the gue=
st and have the guest driver recover
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * from the error. This=
 requires that PCIe capabilities be
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * exposed to the guest=
. For now, we just terminate the
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * guest to contain the=
 error.
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("%s(%s) Unrecov=
erable error detected. Please collect any data possible and then kill the g=
uest", __func__, vdev->vbasedev.name);
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vm_stop(RUN_STATE_INTERNAL_E=
RROR);
>>> =C2=A0=C2=A0=C2=A0 }
>>>
>>> Questions / issues:
>>>
>>> * Is the comment still accurate?
>
> This comment would still apply for vfio-pci devices on other architecture=
s except for s390x. We are trying to change this behavior for s390x.

The comment is about things that should be done to handle the error.
Would these things be done here, or in a suitable ->err_handler()?

>>>
>>> * When ->err_handler() fails, we report the error twice. Would it make
>>> =C2=A0=C2=A0 sense to combine the two error reports into one?
>>
>> Yes. It was my request too.
>>
>> Thanks,
>>
>> C.
>
> I was a little hesitant about changing the existing error message as its =
been there for almost 12 years (since commit 7b4b0e9eda ("vfio: QEMU-AER: Q=
emu changes to support AER for VFIO-PCI devices")). Nothing should ever dep=
endent on specific error messages, but still.. .If the preference is to com=
bine/change the message I can do that.

Don't hesitate to improve error messages.

>>> * Preexisting: the second error message is ugly.
>>>
>>> =C2=A0=C2=A0 Error messages should be short and to the point: single ph=
rase, with
>>> =C2=A0=C2=A0 no newline or trailing punctuation.=C2=A0 The "please coll=
ect ..." part
>>> =C2=A0=C2=A0 does not belong to the error message proper, it's advice o=
n what to
>>> =C2=A0=C2=A0 do.=C2=A0 Better: report the error, then print advice:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("%s(%s) Unrecov=
erable error detected",
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __func__, vdev->vbasede=
v.name);
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_printf("Please collect=
 any data possible and then kill the guest.");
>>>
>>> =C2=A0=C2=A0 Including __func__ in an error message is an anti-pattern.=
 Look at
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 vfio_err_notifier_handler(fred) Unrecoverable =
error detected
>>>
>>> =C2=A0=C2=A0 with a user's eyes: "vfio_err_notifier_handler" is program=
mer
>>> =C2=A0=C2=A0 gobbledygook, the device name "fred" is useful once you re=
alize what
>>> =C2=A0=C2=A0 it is, "Unrecoverable error detected" lacks detail.
>>>
>>> [...]
>>>
>>
> How about "(device) Unrecoverable PCIe error detected for device"

Suggest "for device %s", where %s identifies the device to the user.


