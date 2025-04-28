Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 943F6C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 13:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9OnD-0000TO-Or; Mon, 28 Apr 2025 09:45:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scgl@linux.vnet.ibm.com>)
 id 1u9KhF-0004N9-EI; Mon, 28 Apr 2025 05:22:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <scgl@linux.vnet.ibm.com>)
 id 1u9KhD-0002T3-Bz; Mon, 28 Apr 2025 05:22:41 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53S4SFMN002962;
 Mon, 28 Apr 2025 09:22:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=rQvt93
 5kSRh/yOUQATTETcG46DAvk1ww9iHhrYSQnsg=; b=CJm75AwpuUYCRX/IkfZ0Pn
 +Zt8HP/xyOqw78+trX53U3MnQAsAJeWcpVPHdXHFID5yuPzmhN64j7gP11Jf8rpy
 40G+ZFOImlN1MHrCN2O9DTLwadA1ZUiCiEmiSLPcnhcWr6Nb0R50LU4NWbyHTWvR
 97oiFPuKew0w9KLUEeA2cdGVP8HIe+b2Ltn28gToLfTOrPBoectYPiyOiTZOGGKn
 yBZyJNdlb4tbFlEAHQ1oVn6X/o2/AZxe5XA1T30+eLEUq3eIEwmTvKc/PGxDotUr
 9XJUN7W5Z7uSgjNBG+z5C+eyU/oTmzO9UTaqNMRDhu7Mcwv1uamohHqTr3V7mNwA
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 469jgjbxh4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Apr 2025 09:22:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53S8GO0V024595;
 Mon, 28 Apr 2025 09:22:34 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 469c1kwgcc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 28 Apr 2025 09:22:34 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53S9MUcd57278820
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 28 Apr 2025 09:22:30 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B5CBB20221;
 Mon, 28 Apr 2025 09:22:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 825E920220;
 Mon, 28 Apr 2025 09:22:30 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.152.224.80]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 28 Apr 2025 09:22:30 +0000 (GMT)
Message-ID: <e46a26bfafc52324e0e5c742891ac9293fbbccd1.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 1/4] hw/s390x: add SCLP event type CPI
From: Janis Schoetterl-Glausch <scgl@linux.vnet.ibm.com>
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>, qemu-s390x mailing
 list <qemu-s390x@nongnu.org>, Thomas Huth <thuth@redhat.com>, Daniel
 Berrange <berrange@redhat.com>
Cc: qemu-devel mailing list <qemu-devel@nongnu.org>, Hendrik Brueckner
 <brueckner@linux.ibm.com>
Date: Mon, 28 Apr 2025 11:22:31 +0200
In-Reply-To: <20250410150934.1331433-2-shalini@linux.ibm.com>
References: <20250410150934.1331433-1-shalini@linux.ibm.com>
 <20250410150934.1331433-2-shalini@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yU-FLKNSfBLl6CQ3GDcjCr-FblKm_ETf
X-Authority-Analysis: v=2.4 cv=C4/pyRP+ c=1 sm=1 tr=0 ts=680f48db cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=XR8D0OoHHMoA:10 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=0YA6Ppd6j1_3TYlVWzIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: yU-FLKNSfBLl6CQ3GDcjCr-FblKm_ETf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI4MDA3NSBTYWx0ZWRfX6NITvLHNDfHn
 jPL3MBYCf4Z2e/onSjr41UMtH81fD1E4SsaIKMhjUGL+RYU/DRwZPoLMXyvoaeYulxymKq3+Uwt
 UyiQw0qRxrV009FoBge/5dFeljRwD7rb3g4Bb4g+8Fpw/NBqob7uoVFGb51m8M+9De3lhf4K40S
 5DJws99Es6fKoEHMCTTHLsL79Mb+thNF+jD1H8XxZIRIcr2beFH5pvVxCXoxKrWXeM5/b4PHFR/
 74f5UxdM0SNAkUx32Fpinh51sMm7GxsSfItxscM4wiDF93ivCqd995+T0omJYpVovYhjAZ6oJGM
 zLJY8Gdp6VD8AeEp+79V3g6fuzxtZ4gdJhyQckt+L25dF2rMNkYu0LFqoEg1HeiyNn6kqymn/Rz
 NVDdf+AEyAZI6a6XjVlEKMgzahd+7a3BqMlUCPSzIrQEl6UP76msEJ3EwwBabTIJyKloivpg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-28_03,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0
 clxscore=1011 priorityscore=1501 mlxscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504280075
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=scgl@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 28 Apr 2025 09:44:40 -0400
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

On Thu, 2025-04-10 at 17:09 +0200, Shalini Chellathurai Saroja wrote:
> Implement the Service-Call Logical Processor (SCLP) event
> type Control-Program Identification (CPI) in QEMU. This
> event is used to send CPI identifiers from the guest to the
> host. The CPI identifiers are: system type, system name,
> system level and sysplex name.
>=20
> System type: operating system of the guest (e.g. "LINUX").
> System name: user configurable name of the guest (e.g. "TESTVM").
> System level: distribution and kernel version, if the system type is Linu=
x
> (e.g. 0x50e00).
> Sysplex name: name of the cluster which the guest belongs to (if any)
> (e.g. "PLEX").
>=20
> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/s390x/event-facility.c         |  2 +
>  hw/s390x/meson.build              |  1 +
>  hw/s390x/s390-virtio-ccw.c        | 14 +++++
>  hw/s390x/sclpcpi.c                | 92 +++++++++++++++++++++++++++++++
>  include/hw/s390x/event-facility.h | 13 +++++
>  5 files changed, 122 insertions(+)
>  create mode 100644 hw/s390x/sclpcpi.c
>=20
> diff --git a/hw/s390x/event-facility.c b/hw/s390x/event-facility.c
> index 2b0332c20e..60237b8581 100644
> --- a/hw/s390x/event-facility.c
> +++ b/hw/s390x/event-facility.c
> @@ -4,6 +4,7 @@
>   *       handles SCLP event types
>   *          - Signal Quiesce - system power down
>   *          - ASCII Console Data - VT220 read and write
> + *          - Control-Program Identification - Send OS data from guest t=
o host
>   *
>   * Copyright IBM, Corp. 2012
>   *
> @@ -40,6 +41,7 @@ struct SCLPEventFacility {
>      SysBusDevice parent_obj;
>      SCLPEventsBus sbus;
>      SCLPEvent quiesce, cpu_hotplug;
> +    SCLPEventCPI cpi;
>      /* guest's receive mask */
>      union {
>          uint32_t receive_mask_pieces[2];
> diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
> index 3bbebfd817..eb7950489c 100644
> --- a/hw/s390x/meson.build
> +++ b/hw/s390x/meson.build
> @@ -13,6 +13,7 @@ s390x_ss.add(files(
>    's390-skeys.c',
>    's390-stattrib.c',
>    'sclp.c',
> +  'sclpcpi.c',
>    'sclpcpu.c',
>    'sclpquiesce.c',
>    'tod.c',
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index 75b32182eb..7f28cbd1de 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -260,6 +260,17 @@ static void s390_create_sclpconsole(SCLPDevice *sclp=
,
>      qdev_realize_and_unref(dev, ev_fac_bus, &error_fatal);
>  }
> =20
> +static void s390_create_sclpcpi(SCLPDevice *sclp)
> +{
> +    SCLPEventFacility *ef =3D sclp->event_facility;
> +    BusState *ev_fac_bus =3D sclp_get_event_facility_bus(ef);
> +    DeviceState *dev;
> +
> +    dev =3D qdev_new(TYPE_SCLP_EVENT_CPI);
> +    object_property_add_child(OBJECT(ef), "sclpcpi", OBJECT(dev));
> +    qdev_realize_and_unref(dev, ev_fac_bus, &error_fatal);

I wonder if we should drop this and add control-program-id directly
on the event facility. I don't see what purpose having the intermediate
level sclpcpi serves.

> +}

[...]

> diff --git a/include/hw/s390x/event-facility.h b/include/hw/s390x/event-f=
acility.h
> index ff874e792d..ef469e62ae 100644
> --- a/include/hw/s390x/event-facility.h
> +++ b/include/hw/s390x/event-facility.h

[...]
   I.=20
> +struct SCLPEventCPI {
> +    DeviceState qdev;
> +    SCLPEvent event;

I think you should just inherit from SCLPEvent, which in turn inherits from=
 DeviceState.
So without the qdev.

> +};
> +
>  #define TYPE_SCLP_EVENT_FACILITY "s390-sclp-event-facility"
>  typedef struct SCLPEventFacility SCLPEventFacility;
>  typedef struct SCLPEventFacilityClass SCLPEventFacilityClass;

--=20
IBM Deutschland Research & Development GmbH Vorsitzender des Aufsichtsrats:=
 Wolfgang Wendt Gesch=C3=A4ftsf=C3=BChrung: David Faller Sitz der Gesellsch=
aft: B=C3=B6blingen / Registergericht: Amtsgericht Stuttgart, HRB
243294

