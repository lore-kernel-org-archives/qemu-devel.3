Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59930CDB466
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wceuj-000420-CH; Thu, 25 Jun 2026 03:54:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wceuh-00041Y-DS; Thu, 25 Jun 2026 03:54:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wceuf-0003B5-Kg; Thu, 25 Jun 2026 03:54:18 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P3mgbk2889642; Thu, 25 Jun 2026 07:54:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=eVtzcN
 WYEQsItyEw6TapXtbcVRcGZYzHT+YEt+16lQw=; b=UwCyYge1uwpr5klH4tfA9I
 1qPAJmVS/sOHz3UQCOXTuEO2oF+UumG316CO/OrTWFZFZHN+kzMcDUpwXQ9adjFJ
 hZmkO5hpixLV3ovmS9mN8NPwWv4zf/Ey0Lv9lJK9yCZWLSKzcZflnILg+Ylfbmum
 qoblDRwgHf1Oxjbw4ZKyEULyojS5r5X++FcCRxrepGld717zgIC8jChKVnQ7wPAM
 6ofKRaim+yJFQ1FIe/m5jcCpRzeoY5fmTiUMX9/ok0hG67l9XdP0n1ljAGUlVbDa
 XCIQv4eIXHWIeXO/oBojizpm2AQOSS/dvuBGTgWRffpC0Fajy4y/f7zwEpXkOGGw
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgt085y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2026 07:54:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65P7nfM5022381;
 Thu, 25 Jun 2026 07:54:14 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vyvs10-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2026 07:54:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65P7sB4M54198686
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jun 2026 07:54:11 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1B6A020043;
 Thu, 25 Jun 2026 07:54:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BFCE020040;
 Thu, 25 Jun 2026 07:54:08 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.124.222.12])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Jun 2026 07:54:08 +0000 (GMT)
Message-ID: <d8bad3e84d427b6626a7e197bff8a048777c0460.camel@linux.ibm.com>
Subject: Re: [PATCH 1/2] ppc/pnv: avoid regenerating DTB if external DTB is
 present
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Date: Thu, 25 Jun 2026 13:24:07 +0530
In-Reply-To: <ajzdgJ_PzoHE7VSj@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260623063156.1110370-1-shivangu@linux.ibm.com>
 <20260623063156.1110370-2-shivangu@linux.ibm.com>
 <ajzdgJ_PzoHE7VSj@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA2NiBTYWx0ZWRfX9NGTKNnkfctN
 GH0MO5CuAicDUtdXKq/A+ZueXyzSc5/BdApMTvISkT6brL8OO3NR+2gd05tF0yNG2m1WAkAC5nV
 ZYu+WZ9IrFaEGEJA1hsrsQw+0KXCdc/Fz16hgY/z77cfg2rgRXfwrKyE9HJViLINBeoGQmPHI5M
 US/9OR51st6XfMAeDhe8HsYDMhJ436xKH55AtIQ53v2nrsdSLFlg4p/hOT8gZHGZ5pGmF9ZQB6u
 ybs2y7eoXgPOT4zp3SdporvVLlU8koFct3v4MjiqK10i+Ca9f9sTgf0FfBpDlZzl89qzCseDd9O
 tsSDMj+jDDTT74XLGiV7UNofFbcC1ARcMjsYl7bQNuSBxO8e3dWwSomyaTF/oFySRXIeArTSeWX
 fnr5jtNk2MhaQ9SYMBbTuOp2dGivJp7GnhrdSdnWVxYzbumacYv3lAIOZDPMSZ5MdwjydQ9+ajR
 2cZrNRrBz+Q0GCe4jHg==
X-Proofpoint-GUID: PR1iEl6_f4pC_0-lkBrtnwvrxmj5AdWO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA2NiBTYWx0ZWRfX7wDOp/HjUPDl
 Z4KkRfP0H1KDTqcytFy/eur37HRwRC+X2U3CYaSDXmM3pJo2ro3l/+B3BOkOTwidFwxHkaz3W5r
 Wiec8NbPIP1Ode9qGODH2YApSQzStqU=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a3cdea8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=eQpERYQK_Wsg7VwN8_8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: FfMXbLOycuQmu4caAU72uOePg0MMEC9H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250066
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Thu, 2026-06-25 at 13:21 +0530, Aditya Gupta wrote:
> On 26/06/23 12:01PM, Shivang Upadhyay wrote:
> > Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> > ---
> > =C2=A0hw/ppc/pnv.c | 10 ++++++++--
> > =C2=A01 file changed, 8 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index 62812f22f8..6a636b5192 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -803,8 +803,14 @@ static void pnv_reset(MachineState *machine,
> > ResetType type)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mpipl_write_succeeded =
=3D do_mpipl_write(pnv);
> > =C2=A0=C2=A0=C2=A0=C2=A0 }
> > =C2=A0
> > -=C2=A0=C2=A0=C2=A0 /* Regenerate device tree */
> > -=C2=A0=C2=A0=C2=A0 fdt =3D pnv_dt_create(machine);
> > +=C2=A0=C2=A0=C2=A0 if (machine->dtb) {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int file_size; /* discard *=
/
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fdt =3D load_device_tree(ma=
chine->dtb, &file_size);
> > +=C2=A0=C2=A0=C2=A0 } else {
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Regenerate device tree *=
/
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fdt =3D pnv_dt_create(machi=
ne);
> > +=C2=A0=C2=A0=C2=A0 }
> > +
>=20
> load_device_tree is being done in pnv_init also, how about this ?
>=20
> 	/* only create new dt if -dtb wasn't explicity passed */
> 	if (!machine->dtb) {
> 		pnv_dt_create
> 		fdt_pack
> 	}
>=20
> also, keep this before the mpipl block, ie. after qemu_devices_reset
> ?
Yea, That makes sense.=20
ill fix this in v2.
>=20
> Thanks,
> - Aditya G

~Shivang.

