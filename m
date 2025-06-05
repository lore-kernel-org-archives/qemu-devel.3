Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AAAC61CE7
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 08:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN644-0001ks-2l; Thu, 05 Jun 2025 04:35:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1uN63u-0001dq-NQ; Thu, 05 Jun 2025 04:35:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nsg@linux.ibm.com>)
 id 1uN63s-0006gw-8r; Thu, 05 Jun 2025 04:34:58 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 554L1vVD029308;
 Thu, 5 Jun 2025 08:34:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=UpRoQV
 jCmj1gavOpTeWieVIk1lGhFV5evf/S0QigwRc=; b=SShJAbg+XW+ua7OCG3f4st
 4RM69V/p0YQFb22fTqwFyH6rNd3QayfHF/PHFWdO+EpaTVKtxoQUoULFXbfS2x4R
 ggeWiAs7g86/aWKXJdR8Fln6lDM4bj4neEuZflWFOTHL1wUPO4YVyFM6s6s9T70Z
 PAeQqg9i+rL/rCXiAaoSVXnwC2MIywXs559biHProWMx9vlJSrdUEAd7IJoY/Ekh
 L90ob7p07thN924F1Ly6qhHlpsAU8YAI8FA4M7/eKzT0wp3TLQoyIRQ0d5CdERAr
 ucaj5MHn8Zc4zdcq6d0FmWYQdJzqjceyj1AP+aafO6H/SrrX8q/G0Ux/JJW2+tmA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geyfmtc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Jun 2025 08:34:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5554GuEW012569;
 Thu, 5 Jun 2025 08:34:50 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 470et2kjgk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Jun 2025 08:34:50 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5558Yjiv23134652
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Jun 2025 08:34:46 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D75062004E;
 Thu,  5 Jun 2025 08:34:45 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 815B320040;
 Thu,  5 Jun 2025 08:34:45 +0000 (GMT)
Received: from li-978a334c-2cba-11b2-a85c-a0743a31b510.ibm.com (unknown
 [9.111.39.61]) by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Jun 2025 08:34:45 +0000 (GMT)
Message-ID: <9bf3dbd97aea3e8811e3064c4f1f79ab3ba65ecd.camel@linux.ibm.com>
Subject: Re: [PATCH v5 2/3] hw/s390x: add Control-Program Identification to QOM
From: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
To: Shalini Chellathurai Saroja <shalini@linux.ibm.com>, qemu-s390x
 mailing list <qemu-s390x@nongnu.org>, Thomas Huth <thuth@redhat.com>
Cc: Daniel Berrange <berrange@redhat.com>, qemu-devel mailing list
 <qemu-devel@nongnu.org>, Hendrik Brueckner <brueckner@linux.ibm.com>
Date: Thu, 05 Jun 2025 10:34:44 +0200
In-Reply-To: <20250603135655.595602-3-shalini@linux.ibm.com>
References: <20250603135655.595602-1-shalini@linux.ibm.com>
 <20250603135655.595602-3-shalini@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (3.56.1-1.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ea09f6EH c=1 sm=1 tr=0 ts=684156ab cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=Deb6QIgZBvp3a0EnJhoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: SuoX7UuILO-WI1PU7gNPVPTkjHXkTqxP
X-Proofpoint-ORIG-GUID: SuoX7UuILO-WI1PU7gNPVPTkjHXkTqxP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDA3NCBTYWx0ZWRfX7fvEWRodfYsI
 cA/aTb7/0Efmk5BqMTGrT23gR42SvJOBFyHfbBvH+skX7ezA2dDwemXTTMlZHTVrKlYvl2o71YW
 EuuKmrSqDgO6MlbwY3JIP0wi1+dfDWa+nkPLgu0XpcFCDCZhV1gcwEB1gGkHUjab/gP0wbuULiS
 4ITho6eNjNmwcqEWW88Tcl/odaL6b99jqM9UNOO1Y68lRQpHyOs1t242xDK/EHe8mW7aJrdfVsz
 S++5Xs+KDd1xijcrpfxJLHlBQd534JdI9cpzt4/2gE5vHFVah9kCoY/kDv+1m79orVz+S7PNMem
 lP+6m3gucXSeb7eDK8LDEzJvr7MyIf/73EQDW/P5v9LUSeNJbDNfhu8+T8bdVg1Vuep/5QaGGqV
 9IOvQkQQMppHWN5w1AzbF1ZzMHx3FYOboAumPk3IaonkHQudKDLoU50I4fNF4jrcVAPZqj8Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_02,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999 bulkscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 phishscore=0 mlxscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506050074
Received-SPF: pass client-ip=148.163.156.1; envelope-from=nsg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 2025-06-03 at 15:56 +0200, Shalini Chellathurai Saroja wrote:
> Add Control-Program Identification (CPI) data to the QEMU Object
> Model (QOM), along with the timestamp in which the data was received
> as shown below.

[...]
>=20
> Signed-off-by: Shalini Chellathurai Saroja <shalini@linux.ibm.com>
> ---
>  hw/s390x/sclpcpi.c                | 47 +++++++++++++++++++++++++
>  include/hw/s390x/event-facility.h |  5 +++
>  qapi/machine.json                 | 58 +++++++++++++++++++++++++++++++
>  3 files changed, 110 insertions(+)
>=20
> diff --git a/hw/s390x/sclpcpi.c b/hw/s390x/sclpcpi.c
> index 935fa87acd..ec711e2291 100644
> --- a/hw/s390x/sclpcpi.c
> +++ b/hw/s390x/sclpcpi.c
> @@ -15,7 +15,9 @@
>    */

[...]
> =20
> +static void cpi_init(Object *obj)
> +{
> +    SCLPEventCPI *e =3D SCLP_EVENT_CPI(obj);
> +
> +    object_property_add_str(obj, "system_type", get_system_type, NULL);
> +    object_property_add_str(obj, "system_name", get_system_name, NULL);
> +    object_property_add_str(obj, "sysplex_name", get_sysplex_name, NULL)=
;
> +    object_property_add_uint64_ptr(obj, "system_level", &(e->system_leve=
l),
> +                                   OBJ_PROP_FLAG_READ);
> +    object_property_add_uint64_ptr(obj, "timestamp", &(e->timestamp),
> +                                   OBJ_PROP_FLAG_READ);
> +}

I think it would be cleaner if those were class properties.
You could use object_class_property_add_str in cpi_class_init,
but I think it'd be nice to use DEFINE_PROP_(STR|UINT64) and
device_class_set_props.
I'm not sure if DEFINE_PROP_STR can be used with a char array,
in any case you'd need to allocate the extra null byte.
If it doesn't work with the array just go ahead an heap allocate
the strings.
(You could also define a DEFINE_PROP for fixed size strings/char arrays,
which would be useful to have in general, this has come up before)
> +
>  static const TypeInfo sclp_cpi_info =3D {
>      .name          =3D TYPE_SCLP_EVENT_CPI,
>      .parent        =3D TYPE_SCLP_EVENT,
>      .instance_size =3D sizeof(SCLPEventCPI),
> +    .instance_init =3D cpi_init,
>      .class_init    =3D cpi_class_init,
>  };

[...]

> diff --git a/qapi/machine.json b/qapi/machine.json
> index 5373e1368c..1f2db68032 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -2279,3 +2279,61 @@
>  # Since: 1.2
>  ##
>  { 'command': 'query-cpu-definitions', 'returns': ['CpuDefinitionInfo'] }
> +
> +##
> +# @S390ControlProgramId:
> +#
> +# Control-program identifiers provide data about the guest operating sys=
tem.
> +# The control-program identifiers are: system type, system name, system =
level
> +# and sysplex name.
> +#
> +# In Linux, all the control-program identifiers are user configurable. T=
he
> +# system type, system name, and sysplex name use EBCDIC characters from
> +# this set: capital A-Z, 0-9, $, @, #, and blank.  In Linux, the system =
type,
> +# system name and sysplex name are arbitrary free-form texts.
> +#
> +# In Linux, the 8-byte hexadecimal system-level has the format
> +# 0x<a><b><cc><dd><eeee><ff><gg><hh>, where:
> +# <a>: is one hexadecimal byte, its most significant bit indicates hyper=
visor
> +# use
> +# <b>: is one digit that represents Linux distributions as follows
> +# 0: generic Linux
> +# 1: Red Hat Enterprise Linux
> +# 2: SUSE Linux Enterprise Server
> +# 3: Canonical Ubuntu
> +# 4: Fedora
> +# 5: openSUSE Leap
> +# 6: Debian GNU/Linux
> +# 7: Red Hat Enterprise Linux CoreOS
> +# <cc>: are two digits for a distribution-specific encoding of the major=
 version
> +# of the distribution
> +# <dd>: are two digits for a distribution-specific encoding of the minor=
 version
> +# of the distribution
> +# <eeee>: are four digits for the patch level of the distribution
> +# <ff>: are two digits for the major version of the kernel
> +# <gg>: are two digits for the minor version of the kernel
> +# <hh>: are two digits for the stable version of the kernel
> +# (e.g. 74872343805430528, when converted to hex is 0x010a000000060b00).=
 On
> +# machines prior to z16, some of the values are not available to display=
.
> +#
> +# Sysplex refers to a cluster of logical partitions that communicates an=
d
> +# co-operates with each other.
> +#
> +# @system-type: operating system (e.g. "LINUX   ")
> +#
> +# @system-name: user configurable name of the VM (e.g. "TESTVM  ")
> +#
> +# @system-level: distribution and kernel version in Linux
> +#
> +# @sysplex-name: sysplex which the VM belongs to, if any (e.g. "PLEX ")
> +#
> +# @timestamp: latest update of CPI data in nanoseconds since the UNIX EP=
OCH
> +#
> +# Since: 10.1
> +##
> +{ 'struct': 'S390ControlProgramId', 'data': {
> +     'system-type': 'str',
> +     'system-name': 'str',
> +     'system-level': 'uint64',
> +     'sysplex-name': 'str',
> +     'timestamp': 'uint64' } }

This is unused now, so you can get rid of it and put the
documentation sclpcpi.c.

--=20
IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Gesch=C3=A4ftsf=C3=BChrung: David Faller
Sitz der Gesellschaft: B=C3=B6blingen / Registergericht: Amtsgericht Stuttg=
art, HRB 243294

