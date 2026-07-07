Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8CB8C43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 10:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh3AY-0003Fk-04; Tue, 07 Jul 2026 06:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wh3AW-0003FE-Fl; Tue, 07 Jul 2026 06:36:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wh3AU-0002QC-Sv; Tue, 07 Jul 2026 06:36:48 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6678Igfa2274380; Tue, 7 Jul 2026 10:36:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=We2Jos
 HzM6h8kcEhNxvtl65/kjS8XOuF83qH6Ql7T5I=; b=OuSqaaD+FNKO1xW8gi1/kS
 x4G0ebXILx4JJONUMvJBoNq+QLkkmxdRd8X8wjTlYbn+L2lNOwzcvHdTHixz9nsU
 PbWlH6rnOuaXZjxht4C7IL1Yq6ukl/l9w/s8Pj9fTkb2Y9d8fSuDB+9dLyD3+HPg
 O4gkM6nakFU/6A4CsDTCcNDlW7ln7Au+r2BI+/P9zju9j2tHhNCQztEfY/ZuiuE3
 so17CzIKZrSnSSmmHIVLIg8xpOEmvimQf5YNqLra+FvZ6OBYs7avERaGbMLmpSL8
 BdcysrZh7of+yHxOHdk/85W0GvaOBBUbmZF15bZkvDZ9de5MC9RRALhptZEtaUfw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6rkdq6fg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 10:36:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 667AYf1r003132;
 Tue, 7 Jul 2026 10:36:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvw2ghm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 07 Jul 2026 10:36:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 667AacCR51511692
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 7 Jul 2026 10:36:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CDF762004E;
 Tue,  7 Jul 2026 10:36:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AAA0D20043;
 Tue,  7 Jul 2026 10:36:32 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.26.166])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  7 Jul 2026 10:36:32 +0000 (GMT)
Message-ID: <593b59c90b8f0351ff992cc087dcf44ebd06d114.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 22/28] target/ppc: Move Fixed-Point Load/Store
 String instructions to decodetree.
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Nikhil Kumar Singh <nikhilks@linux.ibm.com>, Chinmay Rath
 <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 richard.henderson@linaro.org, peter.maydell@linaro.org, stefanha@redhat.com
Cc: milesg@linux.ibm.com, vishalc@linux.ibm.com, tshah@linux.ibm.com,
 ojaswin@linux.ibm.com, aboorvad@linux.ibm.com, amachhiw@linux.ibm.com,
 sv@linux.ibm.com, shivani@linux.ibm.com, mkchauras@gmail.com,
 uverma@linux.ibm.com
Date: Tue, 07 Jul 2026 16:06:31 +0530
In-Reply-To: <85806173-0fb8-46d2-a69b-6743de12b2c5@linux.ibm.com>
References: <20260520160728.2283628-1-rathc@linux.ibm.com>
 <20260520160728.2283628-23-rathc@linux.ibm.com>
 <85806173-0fb8-46d2-a69b-6743de12b2c5@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=M7J97Sws c=1 sm=1 tr=0 ts=6a4cd6bb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=7BpaQaQElbc-jZQ56EUA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDEwMCBTYWx0ZWRfX8rPdKlIbJ+Fi
 yyAnkrqehrkY2TE46wX0l6iGoZyGvqGCM8STmps+QyAiq0TWozZ+IfCCDKa7UF/+MELxhuIPHw+
 ENqAimZXkfvC3dwRf7w5/cW2x5Gv3cmNDmnnQXOGFy3ZFnDO0UTmeDkNvcgHMOehW5Tp6y4IrNC
 DFVqwRXmuq0iVt8fcTtf5qNkNucOMM5Xyaekx5Q00+wYev4jr+GGGyFHk0WejFpig3rzDhBZUdn
 GB0Mb3H3tcnW1xGHogf4JGhXR8dUSPI7zly278I3iqu+KPn1pRIQrBxB0OBOJkd/FDTmMiBuhI+
 rqUyogqmcavez+Q4wsmNcWSsiBuo5mU/04Eyo7uVHzuwtye1KHKDNTde/kCBWK9GMWubdYYNluE
 UrXSOweFbFRTwbYwfRlTswr83/x12c7pDIRfcn+z0lGEddDNIG1exZq0CK5l1BPIuRB6PMVmELC
 8ud6IxGqUNs7bmbcAXQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDEwMCBTYWx0ZWRfXxX4LXlvOqHZG
 r7OCLsglyeDtkLNi4FVRDi1sWmaT4szaBipWhdNNpmLVdE4jXnQ9PElyE7nj/LKCQsrwKdcInUA
 6eSdAcXZ1pglSwlEhEAlvjZvSxAkC8E=
X-Proofpoint-GUID: R1zSvxy_LyoV1NBYuaFpAccrNLmj3pt_
X-Proofpoint-ORIG-GUID: 9KRZ_GjkgXUjnpwpqsdOdKRh2wodWqyV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070100
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

On Mon, 2026-07-06 at 23:39 +0530, Nikhil Kumar Singh wrote:
> > +
> > +=C2=A0=C2=A0=C2=A0 return true;
> > +}
> > +
>=20
> You are using gen_addr_register and gen_addr_reg_index, do_ea_calc
> instead.
>=20
Hi,
 Seems like these functions are refactor-able. I can send in another
patch to clean it across all usages.

~Shivang.

