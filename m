Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9114DC9830D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 08:00:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA0r8-0007Sy-LI; Fri, 25 Sep 2026 04:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1xA0r6-0007RZ-H8; Fri, 25 Sep 2026 04:00:28 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1xA0r4-00059b-PU; Fri, 25 Sep 2026 04:00:28 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P4a21A061026; Fri, 25 Sep 2026 08:00:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=KLvIiG
 kVu94nGuZRbBeOQrjA4SOPaKYR/eZ+vSRmZpo=; b=Us3TNV92z8NKOvXVJ2eKQ1
 gfZBKDqcYjLsG2YAGltgyevJ8xS8B2SW4CW3ZF9xMeP6zEEvg5pKOhMmn4XIAuoy
 42sZU6+rsYxp9bigV36OgCS5u1+b1055kBXUbCEAoYlR3hQ1R4LPZ4z+lmThm0mD
 SxESFItsM6OBAlYUgRCWmGBJbNZP8oEsZF4rdIj94+Nh7wCB2HXSSoVcWfU/A9k8
 UrIYaR0SWYr0yg2S+KXq/8aFXfEZ9oYYdUKGhvkrRJ/srHuqvMoxJb7pDFr3NSB5
 OGnpix5ICnBR3zZUNI/V9rWLAjLk5qArsXoHutZXrISfzxKMaiupyWOoQxCpzNpA
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsnu37-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 08:00:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68P4lVTv3298370; Fri, 25 Sep 2026 08:00:21 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb8k1mav-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Sep 2026 08:00:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68P80HAs47645014
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Sep 2026 08:00:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C41EC2004E;
 Fri, 25 Sep 2026 08:00:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9A23920040;
 Fri, 25 Sep 2026 08:00:14 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.124.210.229])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 25 Sep 2026 08:00:14 +0000 (GMT)
Message-ID: <3dd5c06a456a49d07ff51be38fdbba651536dddf.camel@linux.ibm.com>
Subject: Re: [PATCH] target/ppc: Stop vCPU thread before calling
 parent_unrealize
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, sourabhjain@linux.ibm.com,
 rathc@linux.ibm.com, npiggin@gmail.com, milesg@linux.ibm.com,
 harshpb@linux.ibm.com, adityag@linux.ibm.com,
 richard.henderson@linaro.org, mkchauras@gmail.com,
 sshegde@linux.ibm.com, srikar@linux.ibm.com
Date: Fri, 25 Sep 2026 13:30:13 +0530
In-Reply-To: <20260924200552.2eab89e8-e2-amachhiw@linux.ibm.com>
References: <20260923121444.154175-1-shivangu@linux.ibm.com>
 <20260924200552.2eab89e8-e2-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab62a16 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=0D3Gg2UqQP5LkhYO5pUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ciS63oJ6oESdJt7VvX-PX1ewKKYkGPU8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDAzMCBTYWx0ZWRfX2gJKovaGcpU1
 GvlAqj9V5daJzXjRq2kzv1l6McPt1tBF309mjrmyVUtRB0BpC11blKLOgl0XF6CRMLXIwOZSyrD
 0S5F23kYPFy51sAWm65JhpE2t4Ejbd0bWPZmnV8OFMkP5gl2K5YbCy+EXgIccjfOinndiI8MKNq
 FJs/EVEKg9vPLp+aY7PyzTHA7aRdN72h1kclBJAjT4PETJNTWj6gWjf9L4fC8MnFJh9rEjo69+Z
 CoMfEoU5MhWRsVmeXOwdsbDn1R2rLGC1qAVoSrnB4EdI+MfnzTACd+4KRuUaYIGLO9JBCN2xJKL
 0BnssIdFzdz7SlYyXyD5+WWoZWvKmCDO/u3tycDOUJqqQBWY/vLOwwHH2e5co5NjomphDR8rmtx
 BXbBrfhw2lxBCzuPDXuvsS4G5467uPzaaUZFlkNm4JdYDeYNC3P4k1oUmM6CA9q9golbd21hptp
 9BRd1cOgeTE9KE4SPyw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDAzMCBTYWx0ZWRfXzcUxMNgr06GG
 1BtThE2srX8uNfhln7TWTzXj/dhJoYkJgMb/8KvYZWZ7exUou3PUvYuU/ki+oYBKbN5fz2SWUba
 h22+NAoFbX23xw/X/IC516HD2olDHPw=
X-Proofpoint-GUID: Wz9HJ8tDWobUFvjKUvV0irMJYHmtaOEV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250030
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

On Thu, 2026-09-24 at 20:12 +0530, Amit Machhiwal wrote:
> The fix is correct and the commit message is well written.=C2=A0 The ASan
> trace makes
> the race unambiguous: tlb_destroy() frees fast->table and desc-
> >fulltlb while
> the MTTCG thread is still running tlb_mmu_resize_locked() on the same
> structures
> via the queued tcg_commit_cpu work.
>=20
> Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
>=20
Thanks for review.

> Minor: I think a short comment above cpu_remove_sync() would make the
> ordering
> constraint self-documenting, e.g.:
>=20
> =C2=A0=C2=A0=C2=A0 /*
> =C2=A0=C2=A0=C2=A0=C2=A0 * Stop and join the vCPU thread before tearing d=
own accelerator
> =C2=A0=C2=A0=C2=A0=C2=A0 * state (TLB tables etc.) to prevent the running=
 thread from
> =C2=A0=C2=A0=C2=A0=C2=A0 * accessing freed resources.
> =C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0 cpu_remove_sync(CPU(cpu));

Seems this is already pulled via misc tree.

I plan to work on Philippe's suggestion to pull all cpu_remove_sync()
calls into cpu_common_unrealize(), that should take care of all such
caveats.

~Shivang.

