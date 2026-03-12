Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021F5FED2E4
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 08:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0bHp-00007A-Kv; Thu, 12 Mar 2026 04:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w0bHk-00006V-Ak
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 04:20:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w0bHg-0000Q7-Q7
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 04:20:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773303641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8kBCDu2W7wtZ8iuPSNqtcrXsk1GVeUMpFB9vlhOvRLM=;
 b=eQ1QhRLTm9As45KaydTlwMddiaiN2EOsUFMV4JpriYzshz2UhRM96WZc5jcFznhcwfCkJr
 EfeaQ6kjNEDSyHSUl0F2xfWv8L9K7LfUlXtEmSO7x71VBbp24V72eyp+vkPVWv3fcwk7mu
 FT3WX3zi4WnUqGEwAOK6gLY5rhE+Olg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-685-rGEP94UcOaKCl9UTWaX0aA-1; Thu,
 12 Mar 2026 04:20:38 -0400
X-MC-Unique: rGEP94UcOaKCl9UTWaX0aA-1
X-Mimecast-MFC-AGG-ID: rGEP94UcOaKCl9UTWaX0aA_1773303636
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5084C180060D; Thu, 12 Mar 2026 08:20:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.12])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 41B7C30001A1; Thu, 12 Mar 2026 08:20:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CC00421E681B; Thu, 12 Mar 2026 09:20:32 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
Cc: Nathan Chen <nathanc@nvidia.com>,  "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>,  "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,  Yi
 Liu <yi.l.liu@intel.com>,  Eric Auger <eric.auger@redhat.com>,  Zhenzhong
 Duan <zhenzhong.duan@intel.com>,  Peter Maydell
 <peter.maydell@linaro.org>,  Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,  Igor Mammedov
 <imammedo@redhat.com>,  Ani Sinha <anisinha@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Daniel =?utf-8?Q?P=2EBerrang=C3=A9?=
 <berrange@redhat.com>,  Alex
 Williamson <alex@shazbot.org>,  =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@redhat.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: [RFC PATCH 1/8] hw/arm/smmuv3-accel: Add helper for resolving
 auto parameters
In-Reply-To: <CH3PR12MB754899F3426FCB494EA7154FAB46A@CH3PR12MB7548.namprd12.prod.outlook.com>
 (Shameer Kolothum Thodi's message of "Tue, 10 Mar 2026 09:01:03
 +0000")
References: <20260309192119.870186-1-nathanc@nvidia.com>
 <20260309192119.870186-2-nathanc@nvidia.com>
 <87tsuonp7r.fsf@pond.sub.org>
 <CH3PR12MB754899F3426FCB494EA7154FAB46A@CH3PR12MB7548.namprd12.prod.outlook.com>
Date: Thu, 12 Mar 2026 09:20:32 +0100
Message-ID: <87v7f1xxv3.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Shameer Kolothum Thodi <skolothumtho@nvidia.com> writes:

>> -----Original Message-----
>> From: Markus Armbruster <armbru@redhat.com>

[...]

>> Nathan Chen <nathanc@nvidia.com> writes:
>>=20
>> > From: Nathan Chen <nathanc@nvidia.com>
>> >
>> > Introduce smmuv3_accel_auto_finalise() to resolve properties
>> > that are set to 'auto' for accelerated SMMUv3. This helper
>> > function allows properties such as ATS, RIL, SSIDSIZE, and OAS
>> > support to be resolved from host IOMMU values, while avoiding
>> > triggering auto-resolved values for hot-plugged devices.
>> >
>> > Auto mode requires at least one cold-plugged device to retrieve
>> > and finalise these properties, and we fail boot if that is not
>> > the case.
>> >
>> > Subsequent patches will make use of this helper to set the
>> > values when we convert the values to OnOffAuto. New auto_mode
>> > and auto_finalised bool members are added to SMMUv3AccelState.
>> > smmuv3_accel_init() will set auto_mode to true when 'auto' is
>> > detected for the accel SMMUv3 properties.
>> > smmuv3_accel_auto_finalise() will set auto_finalised to true
>> > after all 'auto' properties are resolved, and subsequent
>> > calls to this function will return early if auto_finalised is
>> > set to true.
>> >
>> > Suggested-by: Shameer Kolothum <skolothumtho@nvidia.com>
>> > Signed-off-by: Nathan Chen <nathanc@nvidia.com>
>> > ---
>> >  hw/arm/smmuv3-accel.c | 38 +++++++++++++++++++++++++++++++++--
>> ---
>> >  hw/arm/smmuv3-accel.h |  2 ++
>> >  2 files changed, 35 insertions(+), 5 deletions(-)
>> >
>> > diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
>> > index 17306cd04b..617629bacd 100644
>> > --- a/hw/arm/smmuv3-accel.c
>> > +++ b/hw/arm/smmuv3-accel.c
>> > @@ -35,11 +35,34 @@ static int smmuv3_oas_bits(uint32_t oas)
>> >      return map[oas];
>> >  }
>> >
>> > +static void smmuv3_accel_auto_finalise(SMMUv3State *s, PCIDevice *pde=
v,
>> > +                                       struct iommu_hw_info_arm_smmuv=
3 *info) {
>> > +    SMMUv3AccelState *accel =3D s->s_accel;
>> > +
>> > +    /* Return if no auto for any or finalised already */
>> > +    if (!accel->auto_mode || accel->auto_finalised) {
>> > +        return;
>> > +    }
>> > +
>> > +    /* We can't update if device is hotplugged */
>> > +    if (DEVICE(pdev)->hotplugged) {
>> > +        warn_report("arm-smmuv3: 'auto' feature property detected, bu=
t host
>> "
>> > +                    "value cannot be applied for hot-plugged device; =
using "
>> > +                    "existing value");
>>=20
>> Why is this warning useful?
>>=20
>> Does @auto's meaning depend on whether the device is cold- or
>> hot-plugged?
>
> If SMMUv3 accel=3Don and properties are set to "auto", we require
> at least one cold-plugged vfio-pci device to retrieve the associated
> host SMMUv3 information and finalise the QEMU SMMUv3 properties.
>
> In this series, "auto_mode" is set if any accel property is specified as
> "auto". The properties are then finalised using the first cold-plugged
> device and "auto_finalised" is set.
>
> Since we later fail the guest boot(see below) in the reset phase if
> auto_mode is set but auto_finalised is still false, the above hotplug
> case should not really happen. In that case the VM would not boot.

Sounds complicated.

> So likely we can get rid of the hotplug check above. Need to do
> a bit more testing to confirm we cover all corner cases.
>
>>=20
>> > +        return;
>> > +    }
>> > +
>> > +    accel->auto_finalised =3D true;
>> > +}

[...]

>> > @@ -867,8 +891,12 @@ bool smmuv3_accel_attach_gbpa_hwpt(SMMUv3State *s=
, Error **errp)
>> >
>> >  void smmuv3_accel_reset(SMMUv3State *s)
>> >  {
>> > -     /* Attach a HWPT based on GBPA reset value */
>> > -     smmuv3_accel_attach_gbpa_hwpt(s, NULL);
>> > +    if (s->s_accel && s->s_accel->auto_mode && !s->s_accel->auto_fina=
lised)
>> {
>> > +        error_report("AUTO mode specified but properties not finalise=
d.");
>> > +        exit(1);
>>=20
>> How can we get here?
>
> This is reached from the SMMUv3 reset handler when auto mode is
> specified but no cold-plugged device has been attached to finalise the
> accelerated SMMUv3 properties.
>
> If no such device is present, "auto_finalised" remains false and we hit
> this path during reset.
>
> C=C3=A9dric mentioned that we should not exit during the reset phase. If =
that
> is the case, we likely need another way to handle the scenario where
> auto mode is specified but no cold-plugged device is present.

What exactly does the "auto" feature buy us?  Is it worth the
complexity?


