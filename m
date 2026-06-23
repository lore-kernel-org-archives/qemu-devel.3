Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD197CDB46F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 15:43:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wc3Go-0001OC-Un; Tue, 23 Jun 2026 11:42:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wc3Gi-0001E4-7d; Tue, 23 Jun 2026 11:42:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wc3Gg-0000GG-3P; Tue, 23 Jun 2026 11:42:31 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65NBmgI91826629; Tue, 23 Jun 2026 15:42:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=JT9YY/
 qPTdIss2Pew5nqho3hYsJBKKcH8D7Y8EKJIrM=; b=KAD8KNBtWlmS3Fw1Q/hROQ
 4QJ3tnzR3EuPrjNqg5wFGWkRuj1VisgWcbbaBIqfJtUK44LQfz0vnM3m8f9W2mxq
 DAdObUf+qA07GUbVi82WbwHwSBC5myRI7zDVhaoU6+rvKzMUrVsp9TtmmINlckfc
 uEN+5iF7kZVhGHz2vyWFxq7PTI7VrBD6C9muCFLTW/z6Cqaa0J+AqOtFRM+YiG1l
 M7XyMZB4woscZ3g8Kabp455wjELaCEPCe1tMaovuE35JUntApc4SA3KcpnEk6tW3
 IRohwcpHhdRh6uUh6M5BMZmATJn2WA4Z3lp2O61PsDTpbPOOLiH6yp+nvCKSjofg
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgsq9v2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 15:42:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NFYewA030341;
 Tue, 23 Jun 2026 15:42:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vykrh2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Jun 2026 15:42:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65NFgNhf43057428
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Jun 2026 15:42:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BC73120043;
 Tue, 23 Jun 2026 15:42:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 758A820040;
 Tue, 23 Jun 2026 15:42:21 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.124.220.40])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Jun 2026 15:42:21 +0000 (GMT)
Message-ID: <ae00a32e337f66bff2bdd5a9a983231f0ae09ce1.camel@linux.ibm.com>
Subject: Re: [PATCH 2/2] ppc/pnv: add test to verify external DTB is honored
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, adityag@linux.ibm.com,
 harshpb@linux.ibm.com, npiggin@gmail.com, milesg@linux.ibm.com
Date: Tue, 23 Jun 2026 21:12:19 +0530
In-Reply-To: <20260623122410.5fae6f07-db-amachhiw@linux.ibm.com>
References: <20260623063156.1110370-1-shivangu@linux.ibm.com>
 <20260623063156.1110370-3-shivangu@linux.ibm.com>
 <20260623122410.5fae6f07-db-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEyNiBTYWx0ZWRfX1/ll5OjOevtu
 UkVYZm/tN6TMaHnMS6sbo1Iw264FOpgxfiRFFZxeF+tEThRiO0hdAMHzAomeG6dMLOYD8GiX3sb
 WDY9FpP1zbWefdOkBCuRIJE2GsMH60k1cvx7lnqB6eGa9wsjMK+wYNo5xxTLfLG5ShtlVDbFiFt
 Nu+BRmKa/lEtL4aPWkwSvQm2SFrkbZ59nAf14S/y3AhUYFWx3gxuRW5tnuc2u/4rZZUrHzAMgEt
 rvsr+kEn4B/vF6W2iW2SOcnI4CVPmFA+Cp3ox4M7rURpunzr0SspNWTGIwY/TPh0Z6QDwnoe9x6
 OGD2EePhjnvjdwfCNv3Kg40+0n04ZjRNtfUhWRSDyQWSxoq75GIEvnCFOPAFkRWrWW8oqCmEAhW
 doeQEVPt0BPRikkyKmuC0yHMnoWeGVQ9iiSbiEr4iv1eAqQqdjKozHvqrk/8/EWb9q48FqKTSRd
 VETlY0b4Jr6Yq6c2m8Q==
X-Proofpoint-GUID: 8L0cKeBLfi8UgfNN7gHtMsM-SSedujzc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEyNiBTYWx0ZWRfX2O4P2bWvXWiW
 3fmIjDAekFND7FSzaR4gvqxU4q3V/K4zdyeTkr2enySeBrYH5vO4bKsnZM62C54CfF0qu0sk4Gd
 UJ8kVX0CEl7KK0i89RO5ZL7f/V4qQao=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a3aa964 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=ID6ng7r3AAAA:8
 a=sQTfP1YnM9m7ZpRhDLIA:9 a=QEXdDO2ut3YA:10 a=AkheI1RvQwOzcTXhi5f4:22
X-Proofpoint-ORIG-GUID: mkO5YJczPLq6gE6UC9tFZjmiHZlUXtIZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230126
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

On Tue, 2026-06-23 at 12:27 +0530, Amit Machhiwal wrote:
> The test addition looks fine, but the commit message body is missing.
> According to the official QEMU submission guidelines at:
>=20
> =C2=A0
> https://www.qemu.org/docs/master/devel/submitting-a-patch.html#write-a-me=
aningful-commit-message
>=20
> =C2=A0 "Commit messages should be meaningful and should stand on their ow=
n
> as
> =C2=A0 a historical record of why the changes you applied were necessary
> or
> =C2=A0 useful."
>=20
> You may want to add a commit message body in the next version.

Sure Amit, Ill add the body.

~Shivang.

