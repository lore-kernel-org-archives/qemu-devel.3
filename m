Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFA510F2840
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 15:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w69CW-0007xA-Tl; Fri, 27 Mar 2026 11:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1w69CT-0007vm-56; Fri, 27 Mar 2026 11:34:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1w69CR-00007I-OO; Fri, 27 Mar 2026 11:34:16 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62R6GvFc510428; Fri, 27 Mar 2026 15:34:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=n8TyVn
 rpunaUhbbVbWqddBsOrVZCG94gOjG+haFY8Fw=; b=LTbJFvXwwF+PeF6Dl78YaG
 yOLvXNyZOWDYQgiq1w77uNmHYZjsJoINku+KSuuFQgsUI6xcc8CHGDzaaFZiP30c
 ak7hikEoTDfW0hCsiXnPGQUCVjIBpEsUorWrsfeKPfEnFcH0bdOymKCV1zDq5kEB
 P5LW6gm7l2Zvt4s7tQq7p0UANMZUTVaJI1QMxnVpD9fRkWxINvSdp+jHioCg6h3g
 jgGbjb8I58tbW5VLjOFDo8u8P+8exT3+N2XS+8O2PIT28dJ6O+RjFcx56lslCHOU
 p+SowfPhdDf/Y0CgbmOr6sFUn2ZQx/kwE1k4B6VmaJNXvgo8fPrzGCvFhtZoNPGQ
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kwaav8v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Mar 2026 15:33:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62RAsSDZ008745;
 Fri, 27 Mar 2026 15:33:58 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26np0293-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Mar 2026 15:33:58 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62RFXsP156426924
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 27 Mar 2026 15:33:54 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5B98B20040;
 Fri, 27 Mar 2026 15:33:54 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C6E2620043;
 Fri, 27 Mar 2026 15:33:51 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.124.223.21])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 27 Mar 2026 15:33:51 +0000 (GMT)
Message-ID: <8f88329a0ebcabe15ac3afd95526e924bc2a0ad3.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ppc/pnv: generate dtb after machine initialization
 is complete
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 milesg@linux.ibm.com, Aditya Gupta <adityag@linux.ibm.com>, Harsh Prateek
 Bora	 <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-stable@nongnu.org,
 Nathan Chancellor <nathan@kernel.org>
Date: Fri, 27 Mar 2026 21:03:49 +0530
In-Reply-To: <CAFEAcA86otB1+BeQ_Gca7VcF4c+rJ4r9SxwhkTOkCHEAas_KWw@mail.gmail.com>
References: <20260327124136.983955-1-shivangu@linux.ibm.com>
 <CAFEAcA86otB1+BeQ_Gca7VcF4c+rJ4r9SxwhkTOkCHEAas_KWw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: DGZzYK4svF2rAIAaL-MeeS98b86nctqx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEwNSBTYWx0ZWRfXyIqhAb2RdO0h
 Aswqf6uk1lbnbBxLCWO6aZAvesjqCU3SoNxjc/5DNcMMouaK+b3XpM+unDmGE/0RqlOt4EmS6lJ
 4L+WJ60dWI8rM3PW2tcFnvMlC3Ha68Nd//keJoQC1UJ255x9mTUuyCSLX4Bo9Y22FtKUWsThB/c
 wznyu7AMxSoHw4kcaJuklBvCZ0KrzwjanuBsn86khoGnTEIdsgKFjsv+mk4lNdIMdzk8hQG/Ug4
 kZhWdqZHGKuznv8x9EEzIRpVpl0QeTshc0mQjzaVDMXBz2n6kAFXIzdsAs3JilKZxzD19iLvBam
 ZDK8H5YdW5yDvLJHiZANZ46rh/JWTD68dpBHLLmcht86JOffDQ+cIr1/5NI7ChPJJHC05tHbU+M
 40clL9spdiPJ9cmbaGDZCv6W4xahrO0iZvyBmk2eCbHdp+M6NwK12oaCH/a79n0tB166teb+Ko+
 3qTVij7CAHRHnaxbVeQ==
X-Proofpoint-GUID: 9jRPn2Op6XonSqHs9zPspXXqkL8Uk21a
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c6a368 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=KKAkSRfTAAAA:8
 a=hqwLdyxPSz1zucFdf7cA:9 a=QEXdDO2ut3YA:10 a=vj2x8GP_oQgA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270105
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 2026-03-27 at 12:54 +0000, Peter Maydell wrote:
>=20
>=20
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Thanks Peter.

~Shivang.

