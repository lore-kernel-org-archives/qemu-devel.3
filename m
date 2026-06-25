Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6D93CDB47F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wceXw-0005Mr-5E; Thu, 25 Jun 2026 03:30:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wceXs-0005MU-9P; Thu, 25 Jun 2026 03:30:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wceXq-00075K-MB; Thu, 25 Jun 2026 03:30:43 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P3mF7F2977620; Thu, 25 Jun 2026 07:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=rGwZyv
 ylViumYByre75TUQP/4+BPMU9LkGR03b2DunY=; b=fzScldpsyXFNj2RiWWCZDr
 ybt3JncOUPTUYmSxm8r7K5XbgLNoQB6EO8SZdIb2A5Q/9KVvDivN0ZJduV7sM3uo
 /missK/3wCdhXWeaRGFq0jGe9BXJ4XnB+fxfv9oRWaidxWJl1GuNd0cHCkQj0wht
 SYTA+fv/Jd5JzKnlEeL1S4ey0yDsIoaiAJtbod/KEeFGqiIhjxpd+TdmUbcdPome
 ZdN8aYue++U8qvb5kcHGks+/EPKZckU3aoClAOECJwN0H6pVjslcVP/zUTKYHExy
 yBU9zehYSdoPT7e/4mjXxY0MwpOxqWtZ0/mwBi1Z2C7GfyKJduDVe3xmzm1PH+Ww
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4rjbx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2026 07:30:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65P7JxgQ007967;
 Thu, 25 Jun 2026 07:30:36 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex56qn79u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Jun 2026 07:30:36 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65P7UXDR35324254
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Jun 2026 07:30:33 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0248020040;
 Thu, 25 Jun 2026 07:30:33 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C40122004B;
 Thu, 25 Jun 2026 07:30:30 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.124.222.12])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Jun 2026 07:30:30 +0000 (GMT)
Message-ID: <1548729cfdb7a13a2a0329af867b2f2f699a5987.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] ppc/pnv: add test to verify external DTB is honored
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 npiggin@gmail.com, milesg@linux.ibm.com
Date: Thu, 25 Jun 2026 13:00:29 +0530
In-Reply-To: <ajzSBFuXi_QP3kDG@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260623063156.1110370-1-shivangu@linux.ibm.com>
 <20260623063156.1110370-3-shivangu@linux.ibm.com>
 <ajzSBFuXi_QP3kDG@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDA2MiBTYWx0ZWRfX1XlbSpZOo0je
 OITrHoQDB/mQfT+EqqHTAvM9gxYxOdvAur9xKZIlNXAzEIwQNw2QT7KLX9dHJu29e/blRQf8+fS
 rxbohmVFdydE8/7lyoLno1av2YogHSM=
X-Proofpoint-ORIG-GUID: UMDnJVA0SccRjo2aa5dfGBo309-QmZtN
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3cd91e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=DjTxs3zHxN-JLsZsSIoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDA2MiBTYWx0ZWRfX1xUtwEuZ3d5X
 7LAYvpTjO6b+WEw6n+1yDG6fuETLJXalWf0aoZI58pGgGV9q9zBmOsZmkG9mTtKjJHGT2R3DOQd
 9E87GD9EobuLe+gAX26mlS8PmKxavRHMlM8KO2pT9RytSTOW4NbjQsLZWx+WA+QfCCVdRfhJmSi
 Uo9zMOnUi2swlxIwEn2wVfqnR2uwIzW1cX/21hHI6vJtGBup9ZtoSKtBtRgpsDtwTOeK7aISwj5
 QBGoyXOkwtuYAXMfC9FvcK5CQBBW9rVTAp/j7mqL1UadWL1xrUd48MVMbEzRGY+jaXrpQL8TjZT
 83IAPBot7B/nHqIoFax2DJZEL4R3NYKkW55A4FegJqwcfj0fg5Mhalinl2cNvszgHRqBrRQ3Xkc
 dAwCU4nQ8iFYTM+KVgFpjpjfupGahNAfZoWrO3BFIdS0nqaKu/AyYRzvLhmGWAoUl3LyExN9c1P
 zoIOTeFBdudatAQF6Vg==
X-Proofpoint-GUID: Dso7p2Vg-kk8N9dTfYdrgLtR_XHc73q8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606250062
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On Thu, 2026-06-25 at 12:32 +0530, Aditya Gupta wrote:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kernel_path =3D self.ASSET_=
KERNEL.fetch()
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sample_dtb_path =3D self.AS=
SET_SAMPLE_DTB.fetch()
>=20
> update the dtb also when you post v2, this dtb is of power10, works,
> but
> better to have power11's dtb here
Sure, ill change that. Is it possible we can put it somewhere else
other than personal github?=20

~Shivang.

