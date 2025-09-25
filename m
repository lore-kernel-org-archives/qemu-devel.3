Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A03CAC5B1
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 15:32:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1nvH-0006GA-3y; Thu, 25 Sep 2025 11:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1v1nv7-0006Cc-3B; Thu, 25 Sep 2025 11:30:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1v1nuy-0002IJ-UN; Thu, 25 Sep 2025 11:30:08 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58PAhtBV018428;
 Thu, 25 Sep 2025 15:29:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=1ur6UufqHZ8pFSy8wqTeHmeF3ia5FTm9ZBOU9XM16aU=; b=bZXQRXLgRMpr
 yaZmFx2E6QR52ftf5hzWNoHU4DA94BjOimHM4iuz9xMguAKsWP9l4LMfmqiMQDW3
 2ska1KDkjU03aFLYeIPlpEm2gmSv8kS5QqdIFZQMlKsX5j1GO/EWrxP8L6IifcOA
 1BTnFIn14JfrLwaXLEwuclmI8WMx5vqeFMx8EteyoQ/LBvCkscrVXDq1z6OPkjvY
 dOMfEvSjouwafT5Dp5Icgg7XEr9bFjvGqDirWOzf13Tby5eI9Q3MncBTVgwsHWOW
 RpGF0EAZcBLTjstorAUpf8mEj4shVV2NbjDAeTWP18ZTA4+cukODo+ZTLWAYyb2T
 wBhsWgR9kA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499kwywr12-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 15:29:48 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58PFTlPf005845;
 Thu, 25 Sep 2025 15:29:47 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499kwywr0t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 15:29:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58PCL7Oa008359;
 Thu, 25 Sep 2025 15:29:47 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49a6yy6rh6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 25 Sep 2025 15:29:47 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 58PFTjTc31982332
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 25 Sep 2025 15:29:46 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC4DB5805C;
 Thu, 25 Sep 2025 15:29:45 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 64AB658051;
 Thu, 25 Sep 2025 15:29:45 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 25 Sep 2025 15:29:45 +0000 (GMT)
Message-ID: <6498d929eb80aeddc41f8a3c5b3f878f60599b57.camel@linux.ibm.com>
Subject: Re: [PATCH v5 2/9] target/ppc: Add IBM PPE42 family of processors
From: Miles Glenn <milesg@linux.ibm.com>
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, Chinmay Rath
 <rathc@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, clg@redhat.com, npiggin@gmail.com, thuth@redhat.com, 
 richard.henderson@linaro.org
Date: Thu, 25 Sep 2025 10:29:45 -0500
In-Reply-To: <2e723114-e98c-4912-adc1-495341f2f550@linux.ibm.com>
References: <20250918182731.528944-1-milesg@linux.ibm.com>
 <20250918182731.528944-3-milesg@linux.ibm.com>
 <2ac7b094-4365-46e6-9f44-50052e1b3827@linux.ibm.com>
 <a136e0ef3c7d04b7cc4cc1ef370ee046deed6e47.camel@linux.ibm.com>
 <a168b80b1fc1bb1b9fe9c41209271e644b441bb2.camel@linux.ibm.com>
 <2e723114-e98c-4912-adc1-495341f2f550@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J5Cq7BnS c=1 sm=1 tr=0 ts=68d55fec cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=8tudGf6dD7MqAKZgfVMA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: gR6Hy-Av2lCct5a9JFuu78V1aRkhfCIA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNSBTYWx0ZWRfXzRDbil0p6OJw
 +K7qOsSIRlW8yojUAlx53J1SZXg6ncwC1yK1GcAagvRkULToa7qctk/WWpbaKmBeFKlix/Bemwy
 3ihp3yCrAIZWzlc+70Mv60t8FSi3uprxMo3BvxEuk9v0xvQji1mAGmu4CTMM9iMqZ+Jo7BMUdPV
 QtkgI38dsXqCTbo/sK8cFzocF4VpuOmelU9bJx3o4obHGk9NPWoQkpfbF2Md44stpI5vKYPIf78
 VmVBTYhPefzMy5E+pnHMVHYSoOMY3sgQYIOrb2YLj3u2EK06br0jiMYq5VTSY9CllL0Hfo0OnwF
 V/sQRlECqYJ5Zw/T2Xt278VGkK32fxg1GjZkOwCFG9zDoLbYqfhsMhGLL7FLCLGCHxgfai18c5B
 VGlMNRii
X-Proofpoint-ORIG-GUID: LVvLL1XOtlvXMCsvJsjWiuHJnPdpZk5V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-25_01,2025-09-25_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200015
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, 2025-09-25 at 10:27 +0530, Harsh Prateek Bora wrote:
> Hi Glenn,
> 
> On 9/24/25 20:36, Miles Glenn wrote:
> > > > > @@ -6802,53 +6916,63 @@ static void init_ppc_proc(PowerPCCPU *cpu)
> > > > >    
> > > > >        /* MSR bits & flags consistency checks */
> > > > >        if (env->msr_mask & (1 << 25)) {
> > > > > -        switch (env->flags & (POWERPC_FLAG_SPE | POWERPC_FLAG_VRE)) {
> > > > > +        switch (env->flags & (POWERPC_FLAG_SPE | POWERPC_FLAG_VRE |
> > > > > +                              POWERPC_FLAG_PPE42)) {
> > > > >            case POWERPC_FLAG_SPE:
> > > > >            case POWERPC_FLAG_VRE:
> > > > > +        case POWERPC_FLAG_PPE42:
> > > > >                break;
> > > > >            default:
> > > > >                fprintf(stderr, "PowerPC MSR definition inconsistency\n"
> > > > > -                    "Should define POWERPC_FLAG_SPE or POWERPC_FLAG_VRE\n");
> > > > > +                    "Should define POWERPC_FLAG_SPE or POWERPC_FLAG_VRE\n"
> > > > > +                    "or POWERPC_FLAG_PPE42\n");
> > > > >                exit(1);
> > > > >            }
> > > > >        } else if (env->flags & (POWERPC_FLAG_SPE | POWERPC_FLAG_VRE)) {
> > > > Hey Glenn,
> > > > 
> > > > Did you miss adding the POWERPC_FLAG_PPE42 flag here  ^  ?
> > > > 
> > > > Thanks,
> > > > Chinmay
> > > No. All PPE42 processors will have bit 1 << 25 set in env->msr_mask, so
> > > it will always fall into the previous condition block and never enter
> > > the 2nd check.
> > > 
> > > Glenn
> > > 
> > Ah, sorry, I should have looked closer!  This is supposed to be
> > checking that if 1 << 25 is not set that we shouldn't be setting the
> > PPE42 flag either.  So, yes, I'll add that in v6.
> 
> While we are at it, can we also replace all hard-coded bit shifts with
> appropriate macros which reflect what these shifts are about. There are
> few more such checks in the patch. May be audit other patches as well
> for such instances.
> 
> regards
> Harsh
> 

Hi Harsh,

Normally I would agree with you, but I think that all of the hard-coded 
bit shifts in this function (init_ppc_proc) are hard-coded because the
MSR bits have multiple meanings depending on the CPU and this function
is called on all PPC CPUs.  So, in this context, I think that using the
hard-coded bit number is appropriate and this is probably why it has
remained as a hard-coded value in this function since 2007.

That being said, if you still feel strongly that these hard-coded
values should be replaced with macros, could you provide suggestions on
what would be appropriate names in this function?

Thanks,

Glenn


> > Thanks,
> > 
> > Glenn


