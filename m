Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E47CFCCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 11:45:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9itQ-0000Wu-UX; Fri, 17 Oct 2025 07:45:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v9itM-0000Vl-Hg; Fri, 17 Oct 2025 07:45:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v9itH-00074d-8i; Fri, 17 Oct 2025 07:45:04 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H8b2M5010095;
 Fri, 17 Oct 2025 11:44:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=5tsx+32Y6M27M6UnR+8r99UcTOTBHm
 nrSphsMIRzX3E=; b=H8Ue+otlcb1PbcFAzY0YYviU/9E3ukAfRtOUSwdQZJYspD
 9d1BkhqZz9ABFkq39uk6u1Q4006BbktGN77R7PeEMvjkGAMvFGLCr+57s+aKpnSg
 YqZoBxFZnpM9cRSp5Fre0ruQ3Tr4VPeTWPcYNxsve5fao1SGeFYKPkkfyaBrH2la
 LqwozOZXdPISGxwDd6BSbXG5bhqOqaJNXlVRzmqjgriTKPfI3O8FLHJatXdAtV9X
 RUKCs1bIjaFvqzF1UWDNGNcUzn4omX5WwmWlpyCuUayBnM4wf2B2BfnCBSY2FKmu
 m5na1Jb832LhDHh2k3y5LA5c5b3otPLycM3Ez1vQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qewujdpn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 11:44:54 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59HBP8Vf009547;
 Fri, 17 Oct 2025 11:44:53 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qewujdpk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 11:44:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59H9LcYp028104;
 Fri, 17 Oct 2025 11:44:52 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49tdg9m78k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 11:44:52 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59HBinOV29753750
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Oct 2025 11:44:49 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F938200AD;
 Fri, 17 Oct 2025 11:44:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0AE4220098;
 Fri, 17 Oct 2025 11:44:47 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.26.210]) by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 17 Oct 2025 11:44:46 +0000 (GMT)
Date: Fri, 17 Oct 2025 17:14:35 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [PATCH v4 1/8] hw/ppc: Implement skeleton code for fadump in
 PSeries
Message-ID: <x2eomjkxpq2znoxm3wuw4qtcxhz4sted7l7ql6pjxgy6yy3nxx@qz437owiq5w4>
References: <20250323174007.221116-1-adityag@linux.ibm.com>
 <20250323174007.221116-2-adityag@linux.ibm.com>
 <0827c237-df2b-4a7a-8157-c496c4fa98cc@linux.ibm.com>
 <m5l3cqemaikgnrjqej3zqcdpo4o6ukj3id3ojx2ron4wjpbtul@roskcbsdes2g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m5l3cqemaikgnrjqej3zqcdpo4o6ukj3id3ojx2ron4wjpbtul@roskcbsdes2g>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BRTPfeHBsMtrx2V6rpOnM5avjOLtqd6w
X-Authority-Analysis: v=2.4 cv=Kr1AGGWN c=1 sm=1 tr=0 ts=68f22c36 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6x9mzSOlJLTsJMIotBMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: fmCRRkbqlhHzQwwFtFMCyvOM6xyaQwse
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfXwBXzKelbQK2a
 +igSqr7d+aG2nIVIsjucExZOuEY+F+rOXX2boLnQOra4DdonMi30oDdZqEHuFGjJ5R3YfuISEtO
 LhYI0nrO5wJkhEC9tgKKNOWQka1iu3LlRTprLpOyz4MRlAUUIovLoQZK21re6kdf5wF+lWqPHbH
 y8NQpG5Xtr+4Y8vKbB7keCkyBw8uMkrbcHW9xqqc+fH9ixfjfJIYW0xFPXM2CnlshOI33EqEGXR
 Z9raJYG0S8Z55PZRVzc/spVhFggpbVog0mTmnnIofV/WQTo4HKhuhpiRIjTxsWerfPkhCoBMmf8
 Nz4uE6fHJN0lWHPDPvb47c1CiLHgp+xTAxuyBbPChgbeSe70u9djgQmzV03ChGDzPKl9b3ZMLPD
 D8PAbvDjzxEp+JHJy53wZNob7PWXuA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 25/10/17 05:08PM, Aditya Gupta wrote:
> Hello Sourabh,
> 
> Thanks for your detailed reviews.
> 
> On 25/10/17 02:10PM, Sourabh Jain wrote:
> > Hello Aditya,
> > 
> > > <...snip...>
> > > +/* Papr Section 7.4.9 ibm,configure-kernel-dump RTAS call */
> > > +static void rtas_configure_kernel_dump(PowerPCCPU *cpu,
> > > +                                   SpaprMachineState *spapr,
> > > +                                   uint32_t token, uint32_t nargs,
> > > +                                   target_ulong args,
> > > +                                   uint32_t nret, target_ulong rets)
> > > +{
> > > +    target_ulong cmd = rtas_ld(args, 0);
> > > +    uint32_t ret_val;
> > > +
> > > +    /* Number of outputs has to be 1 */
> > > +    if (nret != 1) {
> > > +        qemu_log_mask(LOG_GUEST_ERROR,
> > > +                "FADump: ibm,configure-kernel-dump RTAS called with nret != 1.\n");
> > 
> > 
> > No rtas_st for above failure?
> 
> Will add.
> 
> Also I think I should remove the LOG_GUEST_ERROR, since I mostly use it
> for qemu side errors, wrong parameters is an invalid usage rather than>
> guest/qemu error.
> 
> What do you say ? Should I remove qemu_log_mask here ?
> 
> > 
> > > +        return;
> > > +    }
> > > +
> > > +    /* Number of inputs has to be 3 */
> > > +    if (nargs != 3) {
> > > +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> > 
> > No qemu_log_mask for the above failure?
> 
> Thinking to remove it, as mentioned above.

On a second thought, I will keep the qemu_log_mask as suggested.
More logs helps for debug if kernel passes invalid arguments to fadump.

Is that okay ?

Thanks,
- Aditya G


