Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90964C5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylQ7-00025p-4w; Tue, 25 Aug 2026 03:18:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wylQ4-00025G-Vf
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 03:18:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wylQ3-00083E-74
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 03:18:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787642282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PkUdYyOB8020hD5U1TwC8Bf6/S0GyfbUoMEED7znhh4=;
 b=P4Kb95c3JJU7BnMjaL/ad7qWaMvzaL8hI5DMwmKhl5E6WollmayJu5dlQ8NlotEGm3H0Gn
 TbeIkHM3h2Z/RRG8E3ErV0jq72YzC2BS1rNONJ8jxCITkRIiw8brGrYDUr8OtNNIppAdqc
 d8PSBxuMOipEm5d8NmdGAci7wKOta4o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-IhpCW-H7NjSjTppOnituKQ-1; Tue,
 25 Aug 2026 03:17:58 -0400
X-MC-Unique: IhpCW-H7NjSjTppOnituKQ-1
X-Mimecast-MFC-AGG-ID: IhpCW-H7NjSjTppOnituKQ_1787642276
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BCE41933B44; Tue, 25 Aug 2026 07:17:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.12])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 05D1E195604A; Tue, 25 Aug 2026 07:17:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 725DB21E6920; Tue, 25 Aug 2026 09:17:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>, mst@redhat.com,
 imammedo@redhat.com,  anisinha@redhat.com,  philmd@mailo.com,
 aurelien@aurel32.net,  peter.maydell@linaro.org,
 richard.henderson@linaro.org,  marcandre.lureau@redhat.com,
 qemu-devel@nongnu.org,  qemu-arm@nongnu.org
Subject: Re: [PATCH v4 14/16] hw/acpi/pcihp.c: convert ACPI_PCIHP_PROP_BSEL
 from object prop to class prop
In-Reply-To: <1fd9946e-1d2a-462a-93e3-238f2c67a1b6@nutanix.com> (Mark
 Cave-Ayland's message of "Mon, 24 Aug 2026 14:47:13 +0100")
References: <20260821111550.276011-1-mark.caveayland@nutanix.com>
 <20260821111550.276011-15-mark.caveayland@nutanix.com>
 <aoxBd0tGArc8rwdf@redhat.com>
 <1fd9946e-1d2a-462a-93e3-238f2c67a1b6@nutanix.com>
Date: Tue, 25 Aug 2026 09:17:52 +0200
Message-ID: <87fr02pt27.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Mark Cave-Ayland <mark.caveayland@nutanix.com> writes:

> On 24/08/2026 14:04, Daniel P. Berrang=C3=A9 wrote:
>
>> On Fri, Aug 21, 2026 at 12:14:26PM +0100, Mark Cave-Ayland wrote:
>>> Move the ACPI_PCIHP_PROP_BSEL property to the PCIBus object and update =
all
>>> callers accordingly.
>>>
>>> Since the existing logic checks for the existence of the ACPI_PCIHP_PRO=
P_BSEL
>>> property to enable the relevant ACPI changes, set the type of the under=
lying
>>> variable to uint32_t with a default value of UINT32_MAX indicating that=
 the
>>> property has not been set.
>>>
>>> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
>>> Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>>> ---
>>>   include/hw/pci/pci_bus.h |  2 ++
>>>   hw/acpi/pci-bridge.c     |  9 ++++++++-
>>>   hw/acpi/pcihp.c          | 30 ++++++++++++++----------------
>>>   hw/arm/virt-acpi-build.c |  7 ++++++-
>>>   hw/i386/acpi-build.c     |  7 ++++++-
>>>   hw/pci/pci.c             |  7 +++++++
>>>   6 files changed, 43 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
>>> index c738446788..7ecb23d13c 100644
>>> --- a/include/hw/pci/pci_bus.h
>>> +++ b/include/hw/pci/pci_bus.h
>>> @@ -56,6 +56,8 @@ struct PCIBus {
>>>       int *irq_count;
>>>         Notifier machine_done;
>>> +
>>> +    uint32_t acpi_pcihp_bsel_val;
>>>   };
>>>     static inline bool pci_bus_is_cxl(PCIBus *bus)
>>> diff --git a/hw/acpi/pci-bridge.c b/hw/acpi/pci-bridge.c
>>> index 394a919479..1bfc5431f2 100644
>>> --- a/hw/acpi/pci-bridge.c
>>> +++ b/hw/acpi/pci-bridge.c
>>> @@ -23,6 +23,8 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *sc=
ope)
>>> @@ -23,6 +23,8 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *sc=
ope)
>>>=20=20
>>>      if (!DEVICE(br)->hotplugged) {
>>>          PCIBus *sec_bus =3D pci_bridge_get_sec_bus(br);
>>> +        Error *local_err =3D NULL;
>>> +        uint32_t bsel;
>>>=20=20
>>>          build_append_pci_bus_devices(scope, sec_bus);
>>>=20=20
>>> @@ -30,9 +32,14 @@ void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *s=
cope)
>>>           * generate hotplug slots descriptors if
>>>           * bridge has ACPI PCI hotplug attached,
>>>           */
>>> -        if (object_property_find(OBJECT(sec_bus), ACPI_PCIHP_PROP_BSEL=
)) {
>>> +        bsel =3D object_property_get_uint(OBJECT(sec_bus), ACPI_PCIHP_=
PROP_BSEL,
>>> +                                        &local_err);
>>> +
>>> +        if (local_err =3D=3D NULL && bsel !=3D UINT32_MAX) {
>>>              build_append_pcihp_slots(scope, sec_bus);
>>>          }
>>> +
>>> +        error_free(local_err);
>> IIUC, in this new approach the property should always exist and so I'd
>> expect object_property_get_uint to always succeed.
>> IOW, is something stopping us using &error_abort and merely checking
>>    if (bsel !=3D UINT32_MAX)
>> ?
>
> I think that would work, although in the back of my mind I have a memory =
that we should try avoiding error_abort where at all possible.
>
> Markus, any thoughts/comments on error_abort usage?

&error_abort is an assertion, just like assert().

Assertions are strictly for programming errors.  When the program
detects such an error, it is defective and needs fixing.

Commonly, the program is in an invalid state then, and continuing
execution is unsafe.  Aborting it is the only sane option.

Assertions conveniently combine the error check and the abort, and also
scream "this is a a programming error" both to readers of the code and
unfortunate users tripping them.  Good!

I particularly dislike the pattern

    if (programming error detected) {
        error recovery that should never be reached
    }

where the code doesn't actually *tell* me it's a programming error.
This matters!  The error recovery needs to be treated with extreme
suspicion then, because it's not testable and almost certainly unsafe.

The pattern can also make me go "huh, I wonder how this error can
happen, let me figure that out", wasting my time.

Another gripe of mine: we often pass NULL where we should pass
&error_abort.

Questions?

[...]


