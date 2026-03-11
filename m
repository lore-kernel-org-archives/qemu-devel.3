Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F34E1125863
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 18:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0O04-0004LL-Q8; Wed, 11 Mar 2026 14:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phrdina@redhat.com>)
 id 1w0O00-0004Kk-6h
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 14:09:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phrdina@redhat.com>)
 id 1w0Nzw-0003c4-P6
 for qemu-devel@nongnu.org; Wed, 11 Mar 2026 14:09:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773252569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C+egDqlQen7LhHm473jK/dWANx3UdziiGDkwyiWfpXU=;
 b=hXHG0mwfoaoLYwKEs0pjtjqVxG4we/92HnE1U+WbbPsIR4rZi+PRQ4Az6sDigRZ/yfojS6
 f8zQ4Huza3wFQZuFFO3tvEDrrJD4jqaHQ29sug9UzOLCnbua0nAoNtIXfE0AHmlG841atK
 A50lPqy+GzBvg6ux/BCTHY2TBNGQHfM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-672-LVwnRTMmP0aQ8RU_FM_oYw-1; Wed,
 11 Mar 2026 14:09:26 -0400
X-MC-Unique: LVwnRTMmP0aQ8RU_FM_oYw-1
X-Mimecast-MFC-AGG-ID: LVwnRTMmP0aQ8RU_FM_oYw_1773252564
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C76EE195608F; Wed, 11 Mar 2026 18:09:23 +0000 (UTC)
Received: from antique-laptop (unknown [10.44.33.82])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4629C180066F; Wed, 11 Mar 2026 18:09:17 +0000 (UTC)
Date: Wed, 11 Mar 2026 19:09:14 +0100
From: Pavel Hrdina <phrdina@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: Nathan Chen <nathanc@nvidia.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, Yi Liu <yi.l.liu@intel.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC5CZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>
Subject: Re: [RFC PATCH 2/8] hw/arm/smmuv3-accel: Introduce _AUTO support for
 ATS
Message-ID: <abGvyiDRIsbfBvll@antique-laptop>
References: <20260309192119.870186-1-nathanc@nvidia.com>
 <20260309192119.870186-3-nathanc@nvidia.com>
 <87pl5cnp06.fsf@pond.sub.org>
 <98e7dd71-6669-4a82-bec8-f1dae2d861c3@redhat.com>
 <0bdcf7d7-136e-42f4-9fa9-d31f6ae6e19f@nvidia.com>
 <fd34b7a2-65ac-486f-bc17-23dd4f96a3df@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="v771NRE64UXbYwUz"
Content-Disposition: inline
In-Reply-To: <fd34b7a2-65ac-486f-bc17-23dd4f96a3df@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=phrdina@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


--v771NRE64UXbYwUz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 06:16:09PM +0100, Eric Auger wrote:
>=20
>=20
> On 3/11/26 6:08 PM, Nathan Chen wrote:
> >
> >
> > On 3/11/2026 8:31 AM, Eric Auger wrote:
> >> On 3/10/26 8:05 AM, Markus Armbruster wrote:
> >>> Nathan Chen<nathanc@nvidia.com> writes:
> >>>
> >>>> From: Nathan Chen<nathanc@nvidia.com>
> >>>>
> >>>> Allow accelerated SMMUv3 Address Translation Services support proper=
ty
> >>>> to be derived from host IOMMU capabilities. Derive host values using
> >>>> IOMMU_GET_HW_INFO, retrieving ATS capability from IDR0.
> >>>>
> >>>> Set the default value of ATS to auto. The default for ATS support us=
ed
> >>>> to be set to off, but we change it to match what the host IOMMU
> >>>> properties report.
> >>>>
> >>>> Add a "ats-enabled" read-only property for smmuv3 to address an
> >>>> expected bool for the "ats" property in iort_smmuv3_devices().
> >>>>
> >>>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>
> >>>> ---
> >>>> =C2=A0 hw/arm/smmuv3-accel.c=C2=A0=C2=A0=C2=A0 | 25 ++++++++++++++++=
+++++++--
> >>>> =C2=A0 hw/arm/smmuv3.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 12 ++++++++++--
> >>>> =C2=A0 hw/arm/virt-acpi-build.c |=C2=A0 2 +-
> >>>> =C2=A0 include/hw/arm/smmuv3.h=C2=A0 |=C2=A0 2 +-
> >>>> =C2=A0 4 files changed, 35 insertions(+), 6 deletions(-)
> >>>>
> >>>> diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
> >>>> index 617629bacd..8fec335557 100644
> >>>> --- a/hw/arm/smmuv3-accel.c
> >>>> +++ b/hw/arm/smmuv3-accel.c
> >>>> @@ -52,6 +52,12 @@ static void
> >>>> smmuv3_accel_auto_finalise(SMMUv3State *s, PCIDevice *pdev,
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>> =C2=A0 +=C2=A0=C2=A0=C2=A0 /* Update ATS if auto from info */
> >>>> +=C2=A0=C2=A0=C2=A0 if (s->ats =3D=3D ON_OFF_AUTO_AUTO) {
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->idr[0] =3D FIELD_DP32=
(s->idr[0], IDR0, ATS,
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_EX32(info->idr[0], IDR0, ATS)=
);
> >>>> +=C2=A0=C2=A0=C2=A0 }
> >>>> +
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 accel->auto_finalised =3D true;
> >>>> =C2=A0 }
> >>>> =C2=A0 @@ -124,6 +130,13 @@ smmuv3_accel_check_hw_compatible(SMMUv3S=
tate
> >>>> *s,
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smmuv3_oas_bits(FIEL=
D_EX32(s->idr[5], IDR5,
> >>>> OAS)));
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>> +=C2=A0=C2=A0=C2=A0 /* Check ATS value opted is compatible with Host=
 SMMUv3 */
> >>>> +=C2=A0=C2=A0=C2=A0 if (FIELD_EX32(info->idr[0], IDR0, ATS) <
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_EX32(s->idr[0], IDR0, ATS)) {
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Host S=
MMUv3 doesn't support Address
> >>>> Translation"
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " Services");
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> >>>> +=C2=A0=C2=A0=C2=A0 }
> >>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* QEMU SMMUv3 supports GRAN4K=
/GRAN16K/GRAN64K translation
> >>>> granules */
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (FIELD_EX32(info->idr[5], IDR5, GR=
AN4K) !=3D
> >>>> @@ -844,8 +857,12 @@ void smmuv3_accel_idr_override(SMMUv3State *s)
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* By default QEMU SMMUv3 has RIL. Up=
date IDR3 if user has
> >>>> disabled it */
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->idr[3] =3D FIELD_DP32(s->idr[3], I=
DR3, RIL, s->ril);
> >>>> =C2=A0 -=C2=A0=C2=A0=C2=A0 /* QEMU SMMUv3 has no ATS. Advertise ATS =
if opt-in by
> >>>> property */
> >>>> -=C2=A0=C2=A0=C2=A0 s->idr[0] =3D FIELD_DP32(s->idr[0], IDR0, ATS, s=
->ats);
> >>>> +=C2=A0=C2=A0=C2=A0 /* Only override ATS if user explicitly set ON o=
r OFF */
> >>>> +=C2=A0=C2=A0=C2=A0 if (s->ats =3D=3D ON_OFF_AUTO_ON) {
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->idr[0] =3D FIELD_DP32=
(s->idr[0], IDR0, ATS, 1);
> >>>> +=C2=A0=C2=A0=C2=A0 } else if (s->ats =3D=3D ON_OFF_AUTO_OFF) {
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->idr[0] =3D FIELD_DP32=
(s->idr[0], IDR0, ATS, 0);
> >>>> +=C2=A0=C2=A0=C2=A0 }
> >>>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Advertise 48-bit OAS in IDR=
5 when requested (default is
> >>>> 44 bits). */
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->oas =3D=3D SMMU_OAS_48BIT) {
> >>>> @@ -923,4 +940,8 @@ void smmuv3_accel_init(SMMUv3State *s)
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->s_accel =3D g_new0(SMMUv3AccelStat=
e, 1);
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bs->iommu_ops =3D &smmuv3_accel_ops;
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smmuv3_accel_as_init(s);
> >>>> +
> >>>> +=C2=A0=C2=A0=C2=A0 if (s->ats =3D=3D ON_OFF_AUTO_AUTO) {
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->s_accel->auto_mode =
=3D true;
> >>>> +=C2=A0=C2=A0=C2=A0 }
> >>>> =C2=A0 }
> >>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> >>>> index 068108e49b..197ba7c77b 100644
> >>>> --- a/hw/arm/smmuv3.c
> >>>> +++ b/hw/arm/smmuv3.c
> >>>> @@ -317,6 +317,12 @@ static void smmuv3_init_id_regs(SMMUv3State *s)
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 smmuv3_accel_idr_override(s);
> >>>> =C2=A0 }
> >>>> =C2=A0 +static bool get_ats_enabled(Object *obj, Error **errp)
> >>>> +{
> >>>> +=C2=A0=C2=A0=C2=A0 SMMUv3State *s =3D ARM_SMMUV3(obj);
> >>>> +=C2=A0=C2=A0=C2=A0 return FIELD_EX32(s->idr[0], IDR0, ATS);
> >>>> +}
> >>>> +
> >>>> =C2=A0 static void smmuv3_reset(SMMUv3State *s)
> >>>> =C2=A0 {
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->cmdq.base =3D deposit64(s->cmdq.ba=
se, 0, 5, SMMU_CMDQS);
> >>>> @@ -1971,7 +1977,7 @@ static bool
> >>>> smmu_validate_property(SMMUv3State *s, Error **errp)
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 error_setg(errp, "ril can only be disabled if
> >>>> accel=3Don");
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return false;
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->ats) {
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (s->ats =3D=3D ON_OFF=
_AUTO_ON) {
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 error_setg(errp, "ats can only be enabled if accel=3Don");
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 return false;
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>> @@ -2128,7 +2134,7 @@ static const Property smmuv3_properties[] =3D {
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_UINT64("msi-gpa", SMMUv3S=
tate, msi_gpa, 0),
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* RIL can be turned off for accel ca=
ses */
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("ril", SMMUv3State, =
ril, true),
> >>>> -=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
> >>>> +=C2=A0=C2=A0=C2=A0 DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats,
> >>>> ON_OFF_AUTO_AUTO),
> >>> Is property "ats" accessible via QMP or JSON command line?=C2=A0 If y=
es,
> >>> this
> >>> is an incompatible change: JSON values false and true no longer work.
> >> So what do you recommend to extend the property values. I guess we had
> >> some existing scenarios happening in the past. What is the best way to
> >> proceed?
> >
> > Is it a requirement to ensure boolean values are still supported when
> > switching to OnOffAuto? I found that the x86-iommu intremap property
> > had a change from DEFINE_PROP_BOOL to DEFINE_PROP_ON_OFF_AUTO [0].
> >
> > Should I add a custom property setter that accepts both boolean and
> > on/off/auto for backward compatibility, or is following the intremap
> > precedent acceptable? I'm happy to implement either approach.
> >
> > [0]
> > https://github.com/qemu/qemu/commit/a924b3d8df55a395891fd5ed341d0deb135=
d9aa6=C2=A0
>=20
> Maybe we also need to emphasize that libvirt integration is still under
> work (and waiting for that conversion to happen at qemu level). So do we
> really care about keeping the compat wrt QMP and JSON.=C2=A0
> Thanks

I think it should be safe and to change the type of the property, it's
not part of any QEMU release and not even implemented in libvirt.

Pavel

>=20
> Eric
> >
> > Thanks,
> > Nathan
> >
>=20
>=20

--v771NRE64UXbYwUz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEcbzs91ho/coWWY7aUi1kczAH4YwFAmmxr8oACgkQUi1kczAH
4YwO1w//cn7LFClRRyqCF+LkkqUTBZdNeXgsr167gkMc0ZEgAvXEUu68nvXyMUjk
zmH/ZUfEDazEFjSD6iRkvhef2OAoHVV0uuofdW0wD2w/uq32OthanKqI3sLjxcrs
osa/uhAZ1XSHWPg2RmGeaYjHcKdv7LrFvOrZGffHYuVSuCPpnWoLQ3VcOiWyKq6b
AR4ddZtv45tPpjKZwgMjYFry+cENAedNqUHn/RFeVH3yo1W3SUDQgSp7y0vDSaBC
mrAXX3BDZ1fLZKcPekDxQeW3dPZt+MTiS3g3NPK/NUQKuLLJVLU8cpBf3enBLuZA
QuYV+ULe3GaZGAeVh2ilGospDuC5fY5uLHs5bQHuZVEyp8PKpxh04n28UPOgaHuA
m63B7DEm7lzLYy4AytHPQk5BLsIVQiZrh4Ajavb/UBvXyUs2BrpChUph6biEuZTQ
GiYzMXXJlVowp/DFZITyJBZD+MCBtqnOAUET7h20nY9b5tc4cxMU+KuMq+5yrtHa
tnpLOsQ61lI7EjVjMyZDhFfkkkgbCgFfbkdtLEXicRmgg7nhUyA91OHEHhDLtiV8
TI+FHpg2d7lEGVP31WKHCH5Mq7mEFwu8B+kwo1tftXvrKPVAPtFQ1I/l+Le8fBGn
rCpgSWqhIt7ZyoHvytN/LMdw6VU73L5u6+8SDtnwz6/hOOhp7+Y=
=+khF
-----END PGP SIGNATURE-----

--v771NRE64UXbYwUz--


