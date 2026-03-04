Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8795BEF8FE7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 14:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxmqh-00010r-0t; Wed, 04 Mar 2026 09:05:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vxmqe-00010M-7M; Wed, 04 Mar 2026 09:05:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vxmqc-0002aX-7K; Wed, 04 Mar 2026 09:05:11 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 623NxJ9O103426; Wed, 4 Mar 2026 14:05:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=1FZGSH
 VCfdn4DSnbe+u2hWlQ7d4JG1a1rzHECXhSfnw=; b=PKkloonrMLJX76YkJdGqG2
 sFzGrvI1VvZmZFc15nDcUlPggnJG3ckViNZyfhOQ9fZjzfabUecf3ka+1RNv6N0s
 X1mPj+XHmS0ViZKAobF+IT7usURiKbagaC9xOljMmFRamUbdCS4xY8d8GSNpRrWO
 hsehQ4ny5ky083nVe6h1+2TcSsn0bsRwPUTsvCMqECT3P2+PRb+lU+pZTJZC3/bf
 pXukvqu6m7RJ5I0dYa8Y0LLNg6+0PdxMtbRgmL1siWGro2u/gcYmoXtN7o+K5xrB
 F1/QzOZfCgxjYSmEO5Llhh7IpYHLzmy8bsZ/mMfXAtFaa1ZUdNujdd58AUdFhw/Q
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskcym04-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 14:05:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 624CA9wY008774;
 Wed, 4 Mar 2026 14:05:07 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmdd1empt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 04 Mar 2026 14:05:07 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 624E56CE27787874
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 4 Mar 2026 14:05:06 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 039DF5805E;
 Wed,  4 Mar 2026 14:05:06 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5616058062;
 Wed,  4 Mar 2026 14:05:05 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.97.94]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  4 Mar 2026 14:05:05 +0000 (GMT)
Message-ID: <26c56fd29b69cc09bf1b090a258c2509d7512ac3.camel@linux.ibm.com>
Subject: Re: [PATCH v4 08/15] pc-bios/s390-ccw: Introduce CLP Architecture
From: Eric Farman <farman@linux.ibm.com>
To: jrossi@linux.ibm.com, qemu-devel@nongnu.org, qemu-s390x@nongnu.org,
 thuth@redhat.com, mst@redhat.com
Cc: jjherne@linux.ibm.com, alifm@linux.ibm.com, mjrosato@linux.ibm.com,
 zycai@linux.ibm.com
Date: Wed, 04 Mar 2026 09:05:04 -0500
In-Reply-To: <20260304025917.2157032-9-jrossi@linux.ibm.com>
References: <20260304025917.2157032-1-jrossi@linux.ibm.com>
 <20260304025917.2157032-9-jrossi@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JBlKkueZalrq_rr11boIMoYWmKkCJrxa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDExMCBTYWx0ZWRfXxaPyviRJZGlO
 CspqDiJzK6Wi+jm0+qY6xc14bfgEbkZ+RJW78GfhRc3qxxTAsHp9ObBfnu7vN1q2JPYXTW+wL2D
 sqCjmlwgTC3MV992TcBgPegD63vdShfHWgLTBvGWqSZhCwcx9++0ZfXn04ovAs35nK16nRtfFN2
 DqY/I8k0jPnXoDcpZwzvxpQLOUff1P3QcNhJOMNEdb1bhnYoIIHWGG2Y+oPNObpKSdSIb0gPLpj
 W0eYKs7SqAC++6NGdrXuVXki5goP3bapvCfzdgV+9l1HvAdaQljQnxnrbswNZf/23IV5eFMEfv2
 4HfIfLEV5YM7fqa86yDIAFUYNUSIuR3QPSx8mH/zETgbWDzWSYJZmqTIKdP5pp7Y31sI91aGQSs
 uI1q1g25wJUg9SuLs6ZEBsnAWPMd1OK5QSheoy0p0d1A/K8Y7GcLWcD/bTTFpmcD7/6e+z+bAA0
 6uQuw4KP02JdiOt/yKQ==
X-Authority-Analysis: v=2.4 cv=H7DWAuYi c=1 sm=1 tr=0 ts=69a83c14 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=loGuO3k-H2d5Vv0PgG8A:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: JBlKkueZalrq_rr11boIMoYWmKkCJrxa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_06,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603040110
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.703, RCVD_IN_VALIDITY_SAFE_BLOCKED=1.386,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, 2026-03-03 at 21:59 -0500, jrossi@linux.ibm.com wrote:
> From: Jared Rossi <jrossi@linux.ibm.com>
>=20
> Call Logical Processor (CLP) Architecture is used for managing PCI functi=
ons on
> s390x. Define and include the structures and routines needed to interact =
with
> PCI devices during IPL.
>=20
> Acked-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
> ---
>  pc-bios/s390-ccw/Makefile |  2 +-
>  pc-bios/s390-ccw/clp.c    | 99 +++++++++++++++++++++++++++++++++++++++
>  pc-bios/s390-ccw/clp.h    | 24 ++++++++++
>  3 files changed, 124 insertions(+), 1 deletion(-)
>  create mode 100644 pc-bios/s390-ccw/clp.c
>  create mode 100644 pc-bios/s390-ccw/clp.h

Reviewed-by: Eric Farman <farman@linux.ibm.com>

