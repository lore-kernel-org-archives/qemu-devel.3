Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1653AC531C9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 13:27:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnFva-0000MZ-Ms; Fri, 24 Jul 2026 09:27:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wnFvY-0000LI-Pa; Fri, 24 Jul 2026 09:27:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wnFvX-00060V-8A; Fri, 24 Jul 2026 09:27:00 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66ODBl7u1928999; Fri, 24 Jul 2026 13:26:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=JEZNBh
 QYnIKy/fSIcqkhWWSihNuyS8IZhVDAjg1Ulwo=; b=HuScMxt7Fm3RyLusXRLwzs
 n7Oi9Y9mFi0fBzMZybV6zJafWFYDTjPm7Po907By4+/pWSrCWv6/JuSY2lHWcSo+
 HfPX59aRJU2hoa+9Z+82GRvSXirUycnOeQ1Kq7krLPhXcNq+gZC/Eav/5eH8M7IC
 tLYYOjAvqL2DS1ohX1tRmduIBmkkuh7giIFsYZaP4QxJ3sBhBjezaaDrd6TREfP6
 PaORPIVA8RSmUYr/8j7U05zewabJOers4+ayIVwL2m6nPBchLBN/DxQXEcuXcioL
 2yaGRjoO/sTBL8gsb0q0LiC4H4i6owuwHXQ6T372ujgMTIlpp1pUPdfHjY85k1Bg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fm8h003xe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 13:26:56 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ODJiHe020499;
 Fri, 24 Jul 2026 13:26:55 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgpgyrsnb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 13:26:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66ODQqlt46072306
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 24 Jul 2026 13:26:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E57722012C;
 Fri, 24 Jul 2026 13:26:51 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 09E1A2012A;
 Fri, 24 Jul 2026 13:26:40 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.21.214])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 24 Jul 2026 13:26:39 +0000 (GMT)
Message-ID: <a8b0889c21501a3761b193310e444591f07b0cf3.camel@linux.ibm.com>
Subject: Re: [PATCH] tests/functional/ppc: skip remote interrupts test if
 -net user not built
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, adityag@linux.ibm.com,
 harshpb@linux.ibm.com, milesg@linux.ibm.com, npiggin@gmail.com
Date: Fri, 24 Jul 2026 18:56:41 +0530
In-Reply-To: <20260724144108.86a98713-59-amachhiw@linux.ibm.com>
References: <20260724085440.520125-1-shivangu@linux.ibm.com>
 <20260724144108.86a98713-59-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=LdcMLDfi c=1 sm=1 tr=0 ts=6a636821 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=C6orNQxUyivbYpHH3BoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GuHYRNhFjSoUNFPTThRb6IZzQS_Uik7b
X-Proofpoint-GUID: ZaCev8IOyZ4lG-v1__dOK_w-BN-agrnf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDExOSBTYWx0ZWRfX+/ErmwPcf0UP
 3nYQdU7E9+/uQlojXR/yRIMLhovU9eX8nO6glTWtwWYFJjbldp21TvZgkXATy8nCn8A9lSsnqu9
 DggnD4kdcIRRat7lnQHLiQDHNAhcKH2JeDPc59c2Jl2B9FGIf4qFw270/gOtmswWn9Rd/uhk3+w
 3qZcPLotxsF2v62aURe/uK3YaCLSUeNyOntO8T529292ES7yMCLeJ/J0HTlYqfldNNwYaJisXCS
 u5GMTCX7amE+MDSlELWOEz6H3rAsn32a85WOumHYcZ2LIyW6lQIOoHidZ8tu7210kpf1OeUAhde
 4OCPYk37xCz0hb43y17lbs7kONQIpz7y9TRQXNclfzpCCN5ScipxmfdH9Y0UuLRaiKudSceKqPy
 M2c5Fjx6tz42X4TuHnxC5ae0Tu3FC7N04jE5oCbOOGwwjzh1D3VZfABwqaWVdJHyDizykNyaj/0
 iieyBtGgV610LygJu/w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDExOSBTYWx0ZWRfXzygfbJnoegxz
 kX/Nusqa3cWJtqCQoDkHytxwLlCeVr9KcfCSTMQ54q0tCT5mbVxzJNlvqDQBB6ojM3kmKL/Jd+b
 nWjBWBC/bcw1Bnm19mkc7DMHjRTF5Ok=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 malwarescore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240119
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

On Fri, 2026-07-24 at 14:52 +0530, Amit Machhiwal wrote:
>=20
> Below change should be enough to achieve what you are trying.
>=20
> diff --git a/tests/functional/ppc64/test_powernv.py
> b/tests/functional/ppc64/test_powernv.py
> index bac2017e18df..f3e05e4d3810 100755
> --- a/tests/functional/ppc64/test_powernv.py
> +++ b/tests/functional/ppc64/test_powernv.py
> @@ -90,6 +90,7 @@ def test_linux_smt_boot(self):
> =C2=A0
> =C2=A0=C2=A0=C2=A0=C2=A0 def test_linux_remote_interrupts(self):
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.require_accelerator=
("tcg")
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.require_netdev('user')
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 self.set_machine('powern=
v')
> =C2=A0

Hi Amit,=20
 Thanks for proper fix, I wanted something like this. I'll try this and
send a revision.

~Shivang.

