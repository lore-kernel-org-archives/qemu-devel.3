Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9404AFED2F0
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 08:39:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0bZx-00057I-Fv; Thu, 12 Mar 2026 04:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w0bZw-00056t-JS
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 04:39:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w0bZu-0004B3-Sl
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 04:39:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773304774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=myekPSBUUKjnkz3h2xVHWLeiTeE6y+z/jYJP+63yV3A=;
 b=aahnyPsFWIcuMiT8T68eUP5ttaIBNL768OUz8RmP9sBgSsJS/WtMATKn0Zw1iiX9/EaUIl
 p2u3xegIPRLl8DcEG8tBvpoCM8ftn6P4zHZ8DbxXC12oSjD+tzSryQXFBCQ6vxFbQZGZQJ
 dQS3VOtNn12/1j7YWA9m/Q2Teq8P1t4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-423-hfZbAo7bMk6xo-0MrpNINQ-1; Thu,
 12 Mar 2026 04:39:30 -0400
X-MC-Unique: hfZbAo7bMk6xo-0MrpNINQ-1
X-Mimecast-MFC-AGG-ID: hfZbAo7bMk6xo-0MrpNINQ_1773304769
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BBA29180034E; Thu, 12 Mar 2026 08:39:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.12])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2954E18002A6; Thu, 12 Mar 2026 08:39:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ADB7021E681E; Thu, 12 Mar 2026 09:39:24 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: Nathan Chen <nathanc@nvidia.com>,  qemu-devel@nongnu.org,
 qemu-arm@nongnu.org,  Yi Liu <yi.l.liu@intel.com>,  Zhenzhong Duan
 <zhenzhong.duan@intel.com>,  Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>,  "Michael S . Tsirkin"
 <mst@redhat.com>,  Igor Mammedov <imammedo@redhat.com>,  Ani Sinha
 <anisinha@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel
 =?utf-8?Q?P=2EBerrang=C3=A9?= <berrange@redhat.com>,  Alex Williamson
 <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [RFC PATCH 2/8] hw/arm/smmuv3-accel: Introduce _AUTO support
 for ATS
In-Reply-To: <fd34b7a2-65ac-486f-bc17-23dd4f96a3df@redhat.com> (Eric Auger's
 message of "Wed, 11 Mar 2026 18:16:09 +0100")
References: <20260309192119.870186-1-nathanc@nvidia.com>
 <20260309192119.870186-3-nathanc@nvidia.com>
 <87pl5cnp06.fsf@pond.sub.org>
 <98e7dd71-6669-4a82-bec8-f1dae2d861c3@redhat.com>
 <0bdcf7d7-136e-42f4-9fa9-d31f6ae6e19f@nvidia.com>
 <fd34b7a2-65ac-486f-bc17-23dd4f96a3df@redhat.com>
Date: Thu, 12 Mar 2026 09:39:24 +0100
Message-ID: <87o6ktxwzn.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Eric Auger <eric.auger@redhat.com> writes:

> On 3/11/26 6:08 PM, Nathan Chen wrote:
>>
>>
>> On 3/11/2026 8:31 AM, Eric Auger wrote:
>>> On 3/10/26 8:05 AM, Markus Armbruster wrote:
>>>> Nathan Chen<nathanc@nvidia.com> writes:
>>>>
>>>>> From: Nathan Chen<nathanc@nvidia.com>
>>>>>
>>>>> Allow accelerated SMMUv3 Address Translation Services support property
>>>>> to be derived from host IOMMU capabilities. Derive host values using
>>>>> IOMMU_GET_HW_INFO, retrieving ATS capability from IDR0.
>>>>>
>>>>> Set the default value of ATS to auto. The default for ATS support used
>>>>> to be set to off, but we change it to match what the host IOMMU
>>>>> properties report.
>>>>>
>>>>> Add a "ats-enabled" read-only property for smmuv3 to address an
>>>>> expected bool for the "ats" property in iort_smmuv3_devices().
>>>>>
>>>>> Signed-off-by: Nathan Chen<nathanc@nvidia.com>

[...]

>>>>> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
>>>>> index 068108e49b..197ba7c77b 100644
>>>>> --- a/hw/arm/smmuv3.c
>>>>> +++ b/hw/arm/smmuv3.c

[...]

>>>>> @@ -2128,7 +2134,7 @@ static const Property smmuv3_properties[] =3D {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, m=
si_gpa, 0),
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 /* RIL can be turned off for accel cases */
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("ril", SMMUv3State, ril, tr=
ue),
>>>>> -=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("ats", SMMUv3State, ats, false),
>>>>> +=C2=A0=C2=A0=C2=A0 DEFINE_PROP_ON_OFF_AUTO("ats", SMMUv3State, ats, =
ON_OFF_AUTO_AUTO),
>>>>
>>>> Is property "ats" accessible via QMP or JSON command line?=C2=A0 If ye=
s,
>>>> this
>>>> is an incompatible change: JSON values false and true no longer work.
>>> So what do you recommend to extend the property values. I guess we had
>>> some existing scenarios happening in the past. What is the best way to
>>> proceed?
>>
>> Is it a requirement to ensure boolean values are still supported when
>> switching to OnOffAuto? I found that the x86-iommu intremap property
>> had a change from DEFINE_PROP_BOOL to DEFINE_PROP_ON_OFF_AUTO [0].

We promise to follow a certain process when changing external
interfaces: docs/about/deprecated.rst.

This is why I inquired about external access.  No external access, no
compatibility worries.

I specifically asked about JSON, because going from bool to OnOffAuto is
mostly compatible in key=3Dvalue syntax: values "on" and "off" keep
working.

Mostly compatible, because qapi_bool_parse() also recognizes "yes",
"true", "y", "no", "false", and "n" for convenience, and these stop
working.  We have a knack for inventing convenience features that later
bite us.

JSON breaks entirely, of course: all values stop working.

Even with external access, compatibility worries start only after we
shipped the interface in a release.  Did we?

If the interface was released, we should keep our promise to follow the
process.  From time to time, that's so onerous and we're so certain that
nobody actually cares, we bend the rules.  This should not be done
lightly.

>> Should I add a custom property setter that accepts both boolean and
>> on/off/auto for backward compatibility, or is following the intremap
>> precedent acceptable? I'm happy to implement either approach.
>>
>> [0]
>> https://github.com/qemu/qemu/commit/a924b3d8df55a395891fd5ed341d0deb135d=
9aa6=C2=A0
>
> Maybe we also need to emphasize that libvirt integration is still under
> work (and waiting for that conversion to happen at qemu level). So do we
> really care about keeping the compat wrt QMP and JSON.=C2=A0

I can explain our promise and the process to you, but I can't make the
decision to bend the rules for you.


