Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59914CCD185
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 07:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8wMH-0005Ql-AZ; Wed, 15 Oct 2025 03:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v8wME-0005QO-LI; Wed, 15 Oct 2025 03:55:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v8wM9-0005Vp-Ay; Wed, 15 Oct 2025 03:55:38 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EK1vL9006552;
 Wed, 15 Oct 2025 07:55:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0/yb1k
 sTUF14uypdqa0Jauoqxg8o+fXMTpYCrihtvg0=; b=Zu3icTMTT3IeY+/BhfZmYL
 iY+4kvJkrCt+ztxhI/5qTBXYrAqJVrCIhKj7aXwN/Y7455vKuI3e/SWbCE5EpcwU
 5M9xb81d8Pvu+aj+A8ZCmgprDGALuyJ3qth/BIwlPPzC+SWJdRfgAWHiWa1/cevr
 8b0K47YyS1cTDUx7eGYTJ99o+AaZM0ypbBRUSvL64sLltTXACCxu0JUR4/P/S2wJ
 Axw4C2ZNYq08mMQuuYJqN2wduz6/IoLBumomp37eLVReA/6Ytk77gkDs2XFt5R2q
 DTvrXIcSt+fWtNtQOrUx01JhFcUmcezGviZ2fvVTciwHjab32irTvWpaLFJ7EUUA
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qcnraqr9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Oct 2025 07:55:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59F3oBeH018336;
 Wed, 15 Oct 2025 07:55:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49s3rf8tee-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Oct 2025 07:55:27 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59F7tO3h39518518
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Oct 2025 07:55:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E52AA20220;
 Wed, 15 Oct 2025 07:28:37 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 47D292021F;
 Wed, 15 Oct 2025 07:28:37 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.111.38.145])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 15 Oct 2025 07:28:37 +0000 (GMT)
Message-ID: <67f6a9617a0f128e75e0c8049041e81102518a16.camel@linux.ibm.com>
Subject: Re: [PATCH 2/3] target/s390x: Fix missing clock-comparator
 interrupts after reset
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Date: Wed, 15 Oct 2025 09:28:36 +0200
In-Reply-To: <20251014160743.398093-3-iii@linux.ibm.com>
References: <20251014160743.398093-1-iii@linux.ibm.com>
 <20251014160743.398093-3-iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5ZA6iws c=1 sm=1 tr=0 ts=68ef5370 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=jWqlWjeE-wqjcu1HJ-sA:9 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: mTkiX-LleTngwTmWI03H5lZa4BfTWL4t
X-Proofpoint-ORIG-GUID: mTkiX-LleTngwTmWI03H5lZa4BfTWL4t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEwMDE0MCBTYWx0ZWRfX0qZYGRZVU9ph
 lWB0Hor67YzzQAEpeoFdW/46Z0qZZKozTtWkxEIepzmW9zS/4yGQCMnb0HfXcdZVhOGqZ7CNCy4
 cYUwNxJOBfhuqT89JqIZasDARe0bg5IKGn3awHc4iEJFAVmclKknZ4RKWvfsH0EVmGHRua3ERl1
 vkeomeKyVL32bG966IenCHcPlXJXBCxOlzyIYrRUT+9xqIA8T95rCGpMBG0Zb5/q7C9fYTOK0K/
 7zX15licEGJrfRHqKQAckKeWSrwhEwoXsfTmISNXtkC8Ro0nMezitP7PcmMn1fD1Mlu3593zo1h
 qLGdkV5HLR0Q6IKpBSA/G/iPmForJH1RQr1qa8HmzmMLmVrqALoyIXzowKkZfmSCGVSO8THyiKG
 qtCOpB2M6K5rwBaAVTeY2tk7DIIFVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510100140
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Tue, 2025-10-14 at 18:05 +0200, Ilya Leoshkevich wrote:
> After reset, both TOD and CKC values are set to 0, so if
                    ^^^

This is inaccurate, only the TOD programmable register is set to 0.
I will fix this in v2.

> clock-comparator interrupts are enabled, one should occur shortly
> thereafter.
>=20
> Currently the code does not set tod_timer, so this does not happen.
>=20
> Fix by adding a tcg_s390_tod_updated() call. Initialize TOD clock
> before CPUs in order to ensure that the respective object exists
> during the CPU reset.
>=20
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
> =C2=A0hw/s390x/s390-virtio-ccw.c | 6 +++---
> =C2=A0target/s390x/cpu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 8 ++++++++
> =C2=A02 files changed, 11 insertions(+), 3 deletions(-)

[...]

