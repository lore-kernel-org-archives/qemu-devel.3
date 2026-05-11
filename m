Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C484CD37B2
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 15:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMT2B-0003iy-Dv; Mon, 11 May 2026 11:59:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wMT2A-0003ip-BW
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:59:06 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wMT28-00052y-7Y
 for qemu-devel@nongnu.org; Mon, 11 May 2026 11:59:06 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BEkCbw248462; Mon, 11 May 2026 15:59:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=mLlSdE
 pWGvZqisj8Os2Vg3yhnZYGQsdeZnzT5N5/ODw=; b=J5oWHmb9E4Z14oKsS6bZP7
 3DUbXEH1LbQX2AMbxYClQH7zo3ZWcHoEe9UJfq1m57HqCSwLsOGLlPOfIQ4QvoEK
 DDSzJ96yAJar3EgCivg5v1OBN0V+P71XmElaAWldxACUIOn8oNS7SmMNtil5AcLO
 KDnfZ/0jLHWPxLwv/yHZkSQ5Q72h4ae9Oytn5hs7zyrQ21GDCnnKPaf/KaY0QGS1
 5YHEHzJivJIs9dA+GZQryc7p1Its0vDCGY7Eox0QvugC2hM8/Ti2KsEj08lKMWH3
 H+g5ZAdQmfKXuCj8I7vlsNOYdoL+nwVrZMNRhGK5Tww4MWJPmgZ8bvGe+YILOGEg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e1ve714va-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 15:59:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64BFsSIF002438;
 Mon, 11 May 2026 15:59:00 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e2fmvx2hm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 11 May 2026 15:59:00 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 64BFww3t13042220
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 11 May 2026 15:58:59 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A17725805D;
 Mon, 11 May 2026 15:58:58 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0762E58065;
 Mon, 11 May 2026 15:58:58 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.111.34]) by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 11 May 2026 15:58:57 +0000 (GMT)
Message-ID: <90ea3dacb27252a623c0f95bad334e4702222d83.camel@linux.ibm.com>
Subject: Re: [PULL 089/110] target/s390x: Introduce common system/user meson
 source set
From: Eric Farman <farman@linux.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?=	 <philmd@linaro.org>,
 qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>, Thomas Huth
 <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali
 <alifm@linux.ibm.com>
Date: Mon, 11 May 2026 11:58:57 -0400
In-Reply-To: <5b1fd1f6-00ec-4575-9609-845218405403@redhat.com>
References: <20260506135524.20617-1-philmd@linaro.org>
 <20260506135524.20617-90-philmd@linaro.org>
 <5b1fd1f6-00ec-4575-9609-845218405403@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE3MCBTYWx0ZWRfX9DAp5YXXlUxS
 vUk9FjTXVSutwhYYZIbyyGv1ktwC8KNNoMvwgd7ZDG4jazfneY+4mR2OxDvsRepxE5Dok6PG1WP
 mksoSQ2g+N729Tt9eISAyAuMxi5HmXZjizHTRy45JIXYJ1HT8REAx4dQDtIwP5GvgWdkY7hGO2r
 AOfabwfJiNqw2lHSrfJkJC1RJ1VTOiT0rgFuD/tJ2WFGfjjXxIA+iA6IZNDH7Z2r4MttZcOmNvv
 yVXJJo2Y7NynraS6rFwHfDRn5nToVhAOnjlg7A+xzhuiGh0m117QC/JDJT9HAEPa0MTcLlT9E2r
 LUcykOPPQzOHS/POMBxvetbhnAbVobSBoHz8NYXNDAadox8CKwmfJ3OjyaksjbWUaN7iBC5mZGe
 iLcziGU/hvuTihyM3oSR+EmBWDJGbESQDfC45S4MPYrgGM0DlT5pXfuW1NK8+9AyJQks5jymgxi
 wJeueT+3jpQ33YknQdw==
X-Proofpoint-GUID: jjJEJ2wIipxRDMpp-alTlawBhYd_7Bfz
X-Proofpoint-ORIG-GUID: jjJEJ2wIipxRDMpp-alTlawBhYd_7Bfz
X-Authority-Analysis: v=2.4 cv=CeQ4Irrl c=1 sm=1 tr=0 ts=6a01fcc5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=PltiWBLiNB-bP36fWssA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110170
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 2026-05-11 at 17:48 +0200, C=C3=A9dric Le Goater wrote:
> Hello,
>=20
> On 5/6/26 15:55, Philippe Mathieu-Daud=C3=A9 wrote:
> > Introduce a source set common to system / user. Start it
> > with the files built in both sets: 'cpu_models_user.c'
> > and 'gdbstub.c' No logical change intended.
> >=20
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > Message-Id: <20260423135035.50126-4-philmd@linaro.org>
>=20
> This change introduced a regression with PCI passthrough which
> stopped working. Guest kernel reports :
>=20
>    [    0.156501] zpci: PCI is not supported because CPU facilities 69 or=
 71 are not available
>=20
> and other devices (ap, ccw) are impacted too I think.
>=20
> > ---
> >   target/s390x/meson.build | 25 +++++++++++++------------
> >   1 file changed, 13 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/target/s390x/meson.build b/target/s390x/meson.build
> > index 6f98ce34d73..44f58ac2919 100644
> > --- a/target/s390x/meson.build
> > +++ b/target/s390x/meson.build
> > @@ -1,4 +1,9 @@
> >   s390x_ss =3D ss.source_set()
> > +s390x_common_ss =3D ss.source_set()
> > +s390x_common_system_ss =3D ss.source_set()
> > +s390x_system_ss =3D ss.source_set()
> > +s390x_user_ss =3D ss.source_set()
> > +
> >   s390x_ss.add(files(
> >     'cpu.c',
> >     'cpu_features.c',
> > @@ -15,15 +20,16 @@ gen_features_h =3D custom_target('gen-features.h',
> >                                  capture: true,
> >                                  command: gen_features)
> >  =20
> > -s390x_ss.add(gen_features_h)
> > +s390x_common_ss.add(gen_features_h)
> > +s390x_common_ss.add(files(
> > +  'cpu_models_user.c',
> > +  'gdbstub.c',
> > +))
> >  =20
> > -s390x_system_ss =3D ss.source_set()
> >   s390x_system_ss.add(files(
> >     'ioinst.c',
> >   ))
> >  =20
> > -s390x_common_system_ss =3D ss.source_set()
> > -s390x_common_system_ss.add(gen_features_h)
> >   s390x_common_system_ss.add(files(
> >     'helper.c',
> >     'arch_dump.c',
> > @@ -32,19 +38,14 @@ s390x_common_system_ss.add(files(
> >     'mmu_helper.c',
> >     'sigp.c',
> >     'cpu-system.c',
> > -  'cpu_models_system.c',
>=20
> This file is compiled anymore and the CPU features and facilities are
> not propagated to the guest anymore.
>=20
> Without this patch, cpuinfo reports :
>=20
>    features	: esan3 zarch stfle msa ldisp eimm dfp edat etf3eh highgprs t=
e vx vxd vxe gs vxe2 vxp sort dflt vxp2 nnpa
>    facilities      : 0 1 2 3 4 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 2=
1 22 23 24 25 26 27 28 30 31 32 33 34 35 36 37 38 40 41 42 43 44 45 47 48 4=
9 50 51 52 53 54 57 58 59 60 61 64 65 69 71 72 73 74 75 76 77 78 80 81 82 1=
29 130 131 133 134 135 138 139 140 146 147 148 150 151 152 155 156 165 192 =
193 194 196 197
>=20
> with :
>=20
>    features	: esan3 zarch stfle msa ldisp eimm dfp edat etf3eh highgprs t=
e vx vxd vxe gs vxe2 vxp sort dflt vxp2
>    acilities      : 0 1 2 3 4 6 7 8 9 10 11 13 14 16 17 18 19 20 21 22 23=
 24 25 26 27 28 30 31 32 33 34 35 36 37 38 40 41 42 43 44 45 46 47 48 49 50=
 51 52 53 54 55 57 58 59 60 61 64 72 73 74 75 76 77 78 80 81 82 129 130 131=
 133 134 135 138 139 146 147 148 150 151 152 155 192
>=20

Thanks, Cedric... I wonder if the above is addressed by this patch? (I have=
n't checked yet, but will
do that now.)

https://lore.kernel.org/qemu-devel/20260510204640.2178926-1-marcandre.lurea=
u@redhat.com/

Thanks,
Eric

>=20
> Thanks,
>=20
> C.
>=20
>=20
> > -  'gdbstub.c',
> > -))
> > -
> > -s390x_user_ss =3D ss.source_set()
> > -s390x_user_ss.add(files(
> > -  'cpu_models_user.c',
> > -  'gdbstub.c',
> >   ))
> >  =20
> >   subdir('tcg')
> >   subdir('kvm')
> >  =20
> > +s390x_common_system_ss.add_all(s390x_common_ss)
> > +s390x_user_ss.add_all(s390x_common_ss)
> > +
> >   target_arch +=3D {'s390x': s390x_ss}
> >   target_system_arch +=3D {'s390x': s390x_system_ss}
> >   target_common_system_arch +=3D {'s390x': s390x_common_system_ss}

