Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 870D1C531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 08:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woGz9-00033X-8n; Mon, 27 Jul 2026 04:46:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1woGz4-00032k-5p; Mon, 27 Jul 2026 04:46:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1woGz0-0006Ba-1a; Mon, 27 Jul 2026 04:46:48 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66R7liup1520421; Mon, 27 Jul 2026 08:46:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=uRDcIt
 wPm23xU/hJ49B3hGWzSZeUEau983fV44Q408g=; b=qTDpgd/xj6XxADPluRD2rz
 bUUZHCB5/xO2BX26BvpeRYS4ReLogwX0laMqT0sUF0DBLW7FWx2KpwtjANi3v6FI
 mKfrzoeZCxi5osZ+oeQF4WBWs0Sd/Ewug+AmzrttFCHmt87fQ1codRd03sVT2/+a
 3tLcRBXKB0FbXiATtgGmMBPq0kK3lg2dgztsVuec7OZvzwn/2QcFV9ltzEHexB9p
 wfifLTY1zVFYIJWRzZEK7qSK8uhi9GDzPjtRZuC6H/pAUgHpOhCD9h60GdaQhMxm
 CcwaXmN2yHUsPi0hbX2+44paXoKSquMQnnNiT+EXbFHl0BzowHYV4p8xF0lgBB+A
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyhxpxq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 08:46:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66R8fJAJ024918;
 Mon, 27 Jul 2026 08:46:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fq4rxs-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Jul 2026 08:46:42 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66R8kcrV46793048
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Jul 2026 08:46:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8C81F2012B;
 Mon, 27 Jul 2026 08:26:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D6F3720129;
 Mon, 27 Jul 2026 08:26:33 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.123.12.247])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Jul 2026 08:26:33 +0000 (GMT)
Message-ID: <800a62ca2b2fffe46fd29321244df2027f6dda01.camel@linux.ibm.com>
Subject: Re: [PATCH v2] tests/functional/ppc: skip remote interrupts test if
 -net user not built
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: adityag@linux.ibm.com, amachhiw@linux.ibm.com, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, npiggin@gmail.com
Date: Mon, 27 Jul 2026 13:56:33 +0530
In-Reply-To: <229c9cff-03f3-4404-a85a-dba831722e21@redhat.com>
References: <20260724085440.520125-1-shivangu@linux.ibm.com>
 <20260725174600.17683-1-shivangu@linux.ibm.com>
 <229c9cff-03f3-4404-a85a-dba831722e21@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDA4MiBTYWx0ZWRfXwYuxYO96vSUR
 U8kjX9nFK/+8LD9AshG7ib3O1+Ka8PU7dFC7wpAak6qvgeqlG4BfN+ittmhnT/qgKIQyt0qnz1h
 syOrCPVsHWNfhmoHkUX+G82ZchLdfTA=
X-Proofpoint-GUID: AoQx_n4o_5WllD_0cx0rxtZSxypjGfqK
X-Proofpoint-ORIG-GUID: rsf-U-j_7lIlmGnK1SX18qXLGnveX-aX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDA4MiBTYWx0ZWRfX6gYVoAKXJ7NM
 omQvVwmCl/rz3Xq/LiqETQGk7f4DXnuPoY3B3r7S9K9W8AyQ1eVQKePpFH08tAnwupIc4mWQiTa
 w/X4+EMZliTKkUQiJ8bTgUatwQLqd/v2kXE3W/TwxHW8UhDVDmRgrvHr+b3tkvhrUcn22wddvcY
 LG7MAoIRLSvCmS6M5GgTtAiScMBO20PzraqWO2BcsiNKC4nPKy7r573bfvFOzELNt4H8WjkjVyZ
 lIRPu+W2KwuNSwBJOFL96jMK8l3PA/d5mgI00oGeh9V/3HPxKZ5GH5dLhnnYayKvoQzYe9BORKQ
 AKR4E3mB1FBJC3cFu8UC4hSxNBQJ5W8Jp0fqEKZ+dejXbRq1s3OVXBq4D2IOkOUiv5gXJVb7vjP
 733cKVXIMsDjT475TV7fob/jn4Y8sxNr2d0o7Sd9ICPt2teIbjmg1017vV1p8h4vlILFSDLoRUd
 XWCd5cpj5+NdPt+1j2Q==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a671af3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=20KFwNOVAAAA:8
 a=m5iep5103XrP8k0eQ5EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_02,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270082
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

On Mon, 2026-07-27 at 07:59 +0200, Thomas Huth wrote:
> > =C2=A0=C2=A0=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # Have bel=
ow setup in this test:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 # 1. e1000=
e attached to pcie.6, which is from 7th PHB,
> > belonging to 2nd
>=20
> Fixes: 63f5ba80921 ("tests/functional: Add remote interrupts test
> ...")
>=20
> Reviewed-by: Thomas Huth <thuth@redhat.com>
Thanks, I'll add these tags to v3, Along with minor reordering,
suggested by Amit.

~Shivang.

