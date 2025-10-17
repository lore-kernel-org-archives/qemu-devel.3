Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBFDACCD19A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 11:40:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9inw-0006O4-GF; Fri, 17 Oct 2025 07:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v9int-0006Mh-9A; Fri, 17 Oct 2025 07:39:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1v9inf-0006a4-0b; Fri, 17 Oct 2025 07:39:24 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H8oNkP001269;
 Fri, 17 Oct 2025 11:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=6qzXNt
 CWlh6/Tpn8iIrhsp/urOxxZf4aNCVfAqS9WCY=; b=MRqBLTTJNXFbxLruH7nrFA
 bBSR9EvV8B6iuqOTlH48JEd+l1KB4cuMWCtNnXmoNqKuJMtD/O7bvD/FSyuMqA5z
 HfT0COjBLhKzYsFTbB+VLPjw8xEgD/LeCcwnlQoi09GGJyCfQon0fBgKCIn3edeP
 YtogVae+XVsWSz3dEvvlKu5uN0TbNyTqiGebl/p6hzuXN/+4Ju1vc48/q8wnEDew
 7M7CKbhIfs0XiBuecr8Horxp7B6XfFPZkozh5DfuTt9VqOrCYzFPvRjQI5GCm5n6
 js3yb6uk6OZcWoBp9/syFF4aL913DXbN89rW59LqArlK7aU5XGDwkg14X8wKnWjw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp8d97m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 11:39:06 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59HBHJhf024750;
 Fri, 17 Oct 2025 11:39:05 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49rfp8d97j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 11:39:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59H9RLNN015002;
 Fri, 17 Oct 2025 11:39:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r3sjvs2e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 Oct 2025 11:39:04 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59HBd0sM59572686
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 Oct 2025 11:39:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C9C7D20080;
 Fri, 17 Oct 2025 11:39:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9435820081;
 Fri, 17 Oct 2025 11:38:58 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.26.210]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Fri, 17 Oct 2025 11:38:58 +0000 (GMT)
Date: Fri, 17 Oct 2025 17:08:56 +0530
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
Message-ID: <m5l3cqemaikgnrjqej3zqcdpo4o6ukj3id3ojx2ron4wjpbtul@roskcbsdes2g>
References: <20250323174007.221116-1-adityag@linux.ibm.com>
 <20250323174007.221116-2-adityag@linux.ibm.com>
 <0827c237-df2b-4a7a-8157-c496c4fa98cc@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0827c237-df2b-4a7a-8157-c496c4fa98cc@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VnbX--9hTVvmD2IUgdXY7c1UrgbXc2xS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA4NCBTYWx0ZWRfX252cy+pWP7Id
 Asc9oytQ71oFWbrOoK1Djaqvu/OfcFBvisdZa1TOsSfZ4dvjRqHm8zASm+wBc8/hGvvVbc5BQG8
 2QqvHJDS452drl2nGM7p9msag39Jvh+33LZwjTzdDzUTAc7U6bq2N0zrdGg3XqR73twlEJAfuti
 PlzKj7e/VOWNsJQf6Ql6QdeM9dvQOiXipgya6S/xdzCxqxOAGVhNsKuhwpfQXxjZJoYrK7YFEmB
 oDQOV6x7GBoNoaelF1ucteJtRG2nYwkW5gfAJ0WIUmQPIDlZq0cK/raYT4tZmlmoSM3tG6MfcTC
 vQ7SbM3APmiQr8TbPW9Nfk5shDEP7RsFlORXvZpOOwNvOdlFlDCc1yVBQ6Ll5i07qdd6wb7yrXy
 obfeOeFRLkF8GPihnwlteR04mSZ22A==
X-Proofpoint-GUID: j0qFQ1OUnzkMgB3YNEnjYyR0Hxj2hNR_
X-Authority-Analysis: v=2.4 cv=af5sXBot c=1 sm=1 tr=0 ts=68f22ada cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=XncmF8QxduTZIhMjpCcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510120084
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello Sourabh,

Thanks for your detailed reviews.

On 25/10/17 02:10PM, Sourabh Jain wrote:
> Hello Aditya,
> 
> > <...snip...>
> > +/* Papr Section 7.4.9 ibm,configure-kernel-dump RTAS call */
> > +static void rtas_configure_kernel_dump(PowerPCCPU *cpu,
> > +                                   SpaprMachineState *spapr,
> > +                                   uint32_t token, uint32_t nargs,
> > +                                   target_ulong args,
> > +                                   uint32_t nret, target_ulong rets)
> > +{
> > +    target_ulong cmd = rtas_ld(args, 0);
> > +    uint32_t ret_val;
> > +
> > +    /* Number of outputs has to be 1 */
> > +    if (nret != 1) {
> > +        qemu_log_mask(LOG_GUEST_ERROR,
> > +                "FADump: ibm,configure-kernel-dump RTAS called with nret != 1.\n");
> 
> 
> No rtas_st for above failure?

Will add.

Also I think I should remove the LOG_GUEST_ERROR, since I mostly use it
for qemu side errors, wrong parameters is an invalid usage rather than>
guest/qemu error.

What do you say ? Should I remove qemu_log_mask here ?

> 
> > +        return;
> > +    }
> > +
> > +    /* Number of inputs has to be 3 */
> > +    if (nargs != 3) {
> > +        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
> 
> No qemu_log_mask for the above failure?

Thinking to remove it, as mentioned above.

> 
> > +        return;
> > +    }
> > +
> > +    switch (cmd) {
> > +    case FADUMP_CMD_REGISTER:
> > +        ret_val = do_fadump_register();
> > +        if (ret_val != RTAS_OUT_SUCCESS) {
> > +            rtas_st(rets, 0, ret_val);
> > +            return;
> > +        }
> > +        break;
> > +    case FADUMP_CMD_UNREGISTER:
> > +        if (spapr->fadump_dump_active == 1) {
> 
> 
> fadump_dump_active is bool, so comparing with an integer is not needed.

Nice catch. Thanks !

> 
> > +            rtas_st(rets, 0, RTAS_OUT_DUMP_ACTIVE);
> > +            return;
> > +        }
> > <...snip...>
> > +#define FADUMP_VERSION                 1
> > +
> > +/*
> > + * The Firmware Assisted Dump Memory structure supports a maximum of 10 sections
> > + * in the dump memory structure. Presently, three sections are used for
> > + * CPU state data, HPTE & Parameters area, while the remaining seven sections
> > + * can be used for boot memory regions.
> > + */
> > +#define FADUMP_MAX_SECTIONS            10
> > +#define RTAS_FADUMP_MAX_BOOT_MEM_REGS  7
> 
> Please move RTAS_FADUMP_MAX_BOOT_MEM_REGS to the respective patch
> if it’s used; otherwise, remove it if it’s not needed.

Again nice catch. It's not used anymore, will remove.

> 
> > +
> > +typedef struct FadumpSection FadumpSection;
> > +typedef struct FadumpSectionHeader FadumpSectionHeader;
> > +typedef struct FadumpMemStruct FadumpMemStruct;
> > +
> > +struct SpaprMachineState;
> 
> 
> Didn't understand the reason for the above forward declaration.

Yes, in this patch it doesn't make sense, when merging the 1st and 2nd
patch, then we see the use. Idea is as explained below.

It is because it's defined in spapr.h, and we use SpaprMachineState at
the end of this header in declaration of 'do_fadump_register'.

But spapr.h includes spapr_fadump.h, so can't include that else it will
become a cyclic dependency.

Hence forward declaration was a way to solve that cyclic dependency.

Thanks !
- Aditya G


