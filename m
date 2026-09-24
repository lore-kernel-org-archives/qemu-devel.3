Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D627C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:47:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9jnI-0000EQ-Lu; Thu, 24 Sep 2026 09:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1x9jmz-0008SY-F3; Thu, 24 Sep 2026 09:47:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1x9jmx-0007D4-T2; Thu, 24 Sep 2026 09:47:05 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC64jo2190518; Thu, 24 Sep 2026 13:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0CD/1t
 ViWzwTxKWfN4MuA5w6F8byN1lymKZJcarEBdw=; b=YW6PY26vgRbAbiWwWvp3b8
 CQdlGgUNgPF78n1ZvC5bzU9C4c/SRjqnQNskQLWaI6YFzohWp1m8+EyDwNEB2hYp
 H5y3Ohkat4x3fju2xUIqJ0YAChSjLi63b0UCmCNbT7ptl1aqI9BVIyChs/qz3REc
 9AoQveviDdELIfykuLzP82Ra3ez2r3lnzw8NetiNgkIFbLx0qm2DRswzHagVSWOZ
 BYlGdTlWJoeN+SWvQnR4Nu13QDpLIpMLrHkY8QyiUfWbyPAHZKEzqZ0EmBfyBBdT
 +bAPZC/bxyg+/ABCmAi5Mw/5nx5rhOkZZLumzDsDD4U7aztupn3R4BJQ3L94n80Q
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskg2sgpx-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 13:46:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OCHn3O2061821; Thu, 24 Sep 2026 13:46:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb8jx3uv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 13:46:57 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68ODkrbL44892582
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 13:46:54 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CAAA420040;
 Thu, 24 Sep 2026 13:46:53 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B44820043;
 Thu, 24 Sep 2026 13:46:50 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.19.125])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 13:46:49 +0000 (GMT)
Message-ID: <338d8c4bd54ce8e39c6b4a04b4092d01b55f9faa.camel@linux.ibm.com>
Subject: Re: [PATCH] target/ppc: Stop vCPU thread before calling
 parent_unrealize
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: sourabhjain@linux.ibm.com, rathc@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com, harshpb@linux.ibm.com, adityag@linux.ibm.com,
 richard.henderson@linaro.org, mkchauras@gmail.com,
 sshegde@linux.ibm.com, srikar@linux.ibm.com, amachhiw@linux.ibm.com
Date: Thu, 24 Sep 2026 19:16:49 +0530
In-Reply-To: <bb91d62a-f15a-42e5-813d-5ec7e6d92479@oss.qualcomm.com>
References: <20260923121444.154175-1-shivangu@linux.ibm.com>
 <bb91d62a-f15a-42e5-813d-5ec7e6d92479@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: ngpUx1z8neyj2AMJ9leCYrCmvqZMZoiA
X-Authority-Analysis: v=2.4 cv=I43w19gg c=1 sm=1 tr=0 ts=6ab529d2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=iqso5IhQRuI9CBSb_mEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1NiBTYWx0ZWRfX0AxFDsm0UL/z
 XXUKgG9Q4t+6h9uE1zn3x69t5rGDYVYbR3QJkwdCdPvTSyrPQAndlCXZ4ygRD3n5kI3OC+y6Vwh
 qpjv6vU9y3u8G85Hx2xbsB+7oaoNOEM8BhBoAsbrn2zrW6RYOYsgMMSo6j2EETgCiaJzE49yLmH
 lcYSq5RQSTrhXFR2i7gHGSxjKENd64votQ/vbjedOI+29E+wgHnkVW6eHrMYdLgZfsmjaMbBEpx
 pN9SQhrw2ZzPAmAi65Tg/ao3heuPN6855MvcxuC3arBLid2oAnxIXuW6WWwFp31CRLFilJbxl/C
 BWqxJFJLRnjLsXxKK/RQSvo+4l9wBgD3wUhMY7eyfKZ9ugcoLwzBhvpUj+6DQbh7JtaO4MjKsTj
 dOnUkEu35cBgJaHvom1fGxKlWLg0SI1KUkTtECn6ue6a27VFOSwGv46JeGRQxzCGlfQx8+z+DCI
 ZyAnPhY6WvBgwkJGFzA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1NiBTYWx0ZWRfX73ihH2Tb8lgq
 bvxMIcbVf1TpM+AfBT139fTDmqs772VLqRhsJEFsXB27Gx5Dvc7W/oLTnQDHP+vpwCVsXHNm74f
 vbxQIwbFJVnwCYgHpNp7eCz6f2W/WB8=
X-Proofpoint-GUID: 85K5WgHe-3y-RYy99p6bvWlrRY_0ZASZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240056
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

On Wed, 2026-09-23 at 15:39 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> > Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> > ---
> > =C2=A0=C2=A0 target/ppc/cpu_init.c | 4 ++--
> > =C2=A0=C2=A0 1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> Good enough for now:
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
>=20
Thanks Philippe.

> But long term we should move the call to cpu_common_unrealize() IMO,
> it shouldn't be called per-target.

Good suggestion, As this should be same for all archs.

~Shivang.

