Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D8DC5DF94
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 07:51:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wylvT-0000xO-FT; Tue, 25 Aug 2026 03:50:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1wylvR-0000wX-II; Tue, 25 Aug 2026 03:50:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gautam@linux.ibm.com>)
 id 1wylvP-0008Ll-Qb; Tue, 25 Aug 2026 03:50:29 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67P2VV4o3750758; Tue, 25 Aug 2026 07:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=TrKVRXvZ7PrhYo4t0PDvvT/3TdP8MZ
 8oWavMNtkT+MA=; b=A8iSfdvmUTwMr4kggCBlqowFl1Qd+OD6VktkA8LHYHpi1/
 ZzPAW4P9tJrW0emvjCpnc3bxuY/zI8iCxjhxNsvSJVH194a7LuUNQR+iAzg+/99R
 YGQUu6mJnBhiz+fdrh5pWbHgRdi0uxIBh2e5D0+yRhxdNEE0AUO2KgLZGZI1Hfyh
 AfMlnc9X9wdh/iO0C5hut8pYTm16ian4eB+UdaR++D38MvNR1sgNaSN4bUyZHPQS
 73b2R6+SgiTcYcOtmFSGNm5tJnXI8psKSXb8hdTK88axrOH6gGEM8cZNDpHfdjqr
 mnLHRiuBUXPZzvkiG3XjZ/XK0LvsBLc3j4cSWxfA==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73g4pqx4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 07:50:16 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67P7fVgp023331;
 Tue, 25 Aug 2026 07:50:15 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfw32qn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 25 Aug 2026 07:50:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67P7oBkG43975088
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 25 Aug 2026 07:50:11 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3924A2004B;
 Tue, 25 Aug 2026 07:50:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E224720043;
 Tue, 25 Aug 2026 07:50:09 +0000 (GMT)
Received: from dhcp-9-123-15-208.bl1-in.ibm.com (unknown [9.123.15.208])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 25 Aug 2026 07:50:09 +0000 (GMT)
Date: Tue, 25 Aug 2026 13:20:07 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
Cc: milesg@linux.ibm.com, clg@kaod.org, harshpb@linux.ibm.com,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] ppc/xive: Trigger the pending interrupt for a guest
 after migration
Message-ID: <ao1JL2wQ1fPBBXYQ@dhcp-9-123-15-208.bl1-in.ibm.com>
References: <20260824070353.40016-1-gautam@linux.ibm.com>
 <a45db1dd-fef3-4ca3-aa07-953cce6193ed@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a45db1dd-fef3-4ca3-aa07-953cce6193ed@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Kbt5OucFm2_4G3zg2Fpurm8f-SAm3SHf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA2MyBTYWx0ZWRfXx4eid0lZAt+l
 /62OXMhTJvY7hWeQ6d0cZSFXDY8iRuk9w8lYr6sYtVi4WvC2iVSd/rx1+yPT/AGh5V4FEPO2N7c
 IPkhVJaQOOjqbS25OSsYAYbPTDm9ujw=
X-Proofpoint-GUID: Kbt5OucFm2_4G3zg2Fpurm8f-SAm3SHf
X-Authority-Analysis: v=2.4 cv=JZyMa0KV c=1 sm=1 tr=0 ts=6a8d4938 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=6BQz2k5P22MVwtsdnvIA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA2MyBTYWx0ZWRfX130VYjwkc/on
 gqDLNTNWUNO8xMQ13HcmUacFtp0mu+Uv8uanBe4j/gSjNZg5xd/OdLs1EMxbOmnHAk5u2hkOdhA
 nRNVMTJ/2pN+g0XvHUL19HxcI63wKDFCVLBGKEgLjvV+suhKOYFrtR/dmEE5x4usnLcT2oeIoWH
 aSQdmPiLBE3VkP/2UgehoQf4BNaV2q4KFHxmQ3qOTvjroZJOVMCDSEC1CES5/3d0JRibgKnqQnS
 vlRP1Yk1wCJn9TTPcbaxeyDj7PxVYbGKnVejyio3F/z2uj/NPu7IXkTP1PSioO5r7K1UH3/4aCR
 YKNI2AwLp7MZ4JQ4xjCEfrMTcfecYQFl2zq2qusifHe7HXYnVDiTJp8DuNdzmtpq11T1nFAdMNx
 Bhnuop2CjMAVl4RpzXLKvbSJVdFIpHwJoIYsB/+auKrnwD5EwNmPTef+81mRuKHeW2zhjnj7C80
 3QkuwnEVRbNPycnuHaQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_01,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250063
Received-SPF: pass client-ip=148.163.156.1; envelope-from=gautam@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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

On Tue, Aug 25, 2026 at 10:55:48AM +0530, Nikhil Kumar Singh wrote:
> 
> 
> On 24/08/26 12:33, Gautam Menghani wrote:
> 
> 
> Hi Gautam,
> 
> I was going through the implementation and had a small doubt regarding the
> scope of the fix for the TIMA rings. I can see that we are explicitly
> reading and setting the PIPR for TM_QW1_OS:
> 
> > +    } else {
> > +        uint8_t pipr = tctx->regs[TM_QW1_OS + TM_PIPR];
> > +        xive_tctx_pipr_set(tctx, TM_QW1_OS, pipr, 0);
> >       }
> 
> I guess vmstate_xive_tctx_post_load is a shared device code, I was wondering
> what happens in the case of the other rings? Should we also force a
> re-evaluation for TM_QW3_HV_PHYS or TM_QW2_HV_POOL to avoid similar lockups
> in those configurations? Or is this issue strictly coming only in the OS
> ring in practical scenarios? Please let me know your thoughts on this.

The OS ring is used by LPARs and KVM guests. The TM_QW3_HV_PHYS and
TM_QW2_HV_POOL are used by hypervisors (PHYP and PowerNV linux).
Since migration concerns only KVM guests and LPARs, handling the OS ring
is enough here.

> 
> Also, one minor suggestion. Since this logic is going inside the else block
> of if (kvm_irqchip_in_kernel()), I feel it would be better if we can add a
> line in the commit message mentioning that this specifically fixes state
> restoration for environments relying on QEMU's emulated XIVE.
> 

Yes agree, will add this in the commit message. I'll wait to see if
there are any other comments.

Thanks,
Gautam

