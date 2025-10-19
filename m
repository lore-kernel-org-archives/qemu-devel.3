Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56760CCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 19 Oct 2025 19:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAYzN-0005B1-4f; Sun, 19 Oct 2025 15:22:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vAYzD-0005Ag-Vo; Sun, 19 Oct 2025 15:22:35 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vAYzB-0006U7-7t; Sun, 19 Oct 2025 15:22:35 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59J8sXFo002476;
 Sun, 19 Oct 2025 19:22:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=pD5kw7
 J+RAOqSw0hy90uT2CMCDwM1nJjrOaerTW3eqM=; b=GJh7G/rD4iibhINNrvXrjt
 xKSAvVARfpUrHHyToZmHXbs2raM2qybXfFgxQN8q+xP84VM0zi//N/QRU4+MoLd+
 zsODfQhlx0RAEBWYCo0J8rbzJ0VP6RTYPK3tPqRONnj9tLP5PWYaRvVwZzKRCszp
 JGxML8LJLRiMDA1n4wGkNmrdc2PdpqpTmowICu3DHVYhE3lK987FRu9DgDwuE4FF
 ZdeKnH+yehfE+34lOSqV73NizirphUaiQeeCA0vLzUHxwpbh3S9cAHXjPbsJqtoL
 qJoZQRleESjaaF7CgbhtgaKOdNPebBXIj9b7EV4DsMDCNX8Cd8mYEGceIqyFmerQ
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vdbgd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 19 Oct 2025 19:22:30 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59JJMTNk019422;
 Sun, 19 Oct 2025 19:22:29 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vdbga-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 19 Oct 2025 19:22:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59JDuUZa032092;
 Sun, 19 Oct 2025 19:22:29 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vp7mjkjm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 19 Oct 2025 19:22:29 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59JJMPo257278826
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 19 Oct 2025 19:22:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E89B620043;
 Sun, 19 Oct 2025 19:22:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C01920040;
 Sun, 19 Oct 2025 19:22:23 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.22.247]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Sun, 19 Oct 2025 19:22:22 +0000 (GMT)
Date: Mon, 20 Oct 2025 00:52:20 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [PATCH v4 5/8] hw/ppc: Implement saving CPU state in Fadump
Message-ID: <gzakxmmxnvzhlogu2577s6zd2jq2fkuixzvhj3zuh56z2hqnxv@4iqas73suad3>
References: <20250323174007.221116-1-adityag@linux.ibm.com>
 <20250323174007.221116-6-adityag@linux.ibm.com>
 <6a6f9e93-c824-4c6a-a24f-9b6e5f0d9cee@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6a6f9e93-c824-4c6a-a24f-9b6e5f0d9cee@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: vU10g8vIO_r40iVO9PMZJnsHy0M5NhUU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX4n4B1s0IAFNl
 uC1O8K8L2qH/+OdpCavCh0MdC14pojzEwx1Oxtq/PwFd/6Cm7xWajbLTyxCv96ek6FhLlUOzpPZ
 ksu8X4Y74JEl71/fi/j9PcTMuZA+MFpgv02t5Fa/CI/N5xXXq4IXg8cp/JuEp51PJ3D2jY3QhSA
 m7bO2pyTqGR1yYdqSNKtR8d8Sa/OylIz7GLQPWSYYGwOsaQFzLez9eu84AXT/P7kOYBVktKdPNm
 SFSGYnpRhCY0I8ZttVqYJvJyhdhBTUuuG93IuDyiAitM6uJFsAgI9zFujgOLEJtY2vBem4SUdg6
 Ofb6G1Yy+6NvvKyQ71PohAZcIPXYX+pUhvQmBnhapVItQUmbE8SYwEoqqh6vPfLuQIkDNVFVhbQ
 aPb3JhYBH2PXcDuFYxd0b9IkmzDNNw==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68f53a76 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NEAV23lmAAAA:8 a=tIP5MtDxmwS9JYu4n2gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ITJCu52YRF823I9ml4oSD20V9-VMBzz2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-19_06,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 25/10/18 04:24PM, Sourabh Jain wrote:
> 
> > <...snip...>
> > +    curr_reg_entry->reg_id =
> > +        cpu_to_be64(fadump_str_to_u64("CPUSTRT"));
> > +    curr_reg_entry->reg_value = ppc_cpu->vcpu_id;
> 
> Aren't we suppose to store CPU ID in big endian?
> As per PAPR the format CPUSTRT and CPUEND node is
> 
> 8 Bytes Identifier (BE) | 4 Bytes Reserved (0x0) | 4 Bytes Logical CPU ID
> (BE)
> 
> It feels like storing vcpu_id as little endian may not get the
> reg entrie for CPUSTRT in above format, isn't it?

Will fix in v5.

> 
> Ideally we should have two struct to mange two types of Reg Entries.
> That way we can manage reserved bytes in CPUSTRT/CPUEND node
> easily. I understand that it will bring unnecessary complexity in
> populate_cpu_state_data function. So how about adding a note for
> future reference?

Will add a note about the format.
I also think another struct might be unnecessary complexity since we
just need it at 2 instances (CPUSTRT & CPUEND), and can be done with
simple bit math.

> 
> > +    ++curr_reg_entry;
> > +
> > <...snip...>
> > +    /* End the registers for this CPU with "CPUEND" reg entry */
> > +    curr_reg_entry->reg_id =
> > +        cpu_to_be64(fadump_str_to_u64("CPUEND"));
> 
> CPU ID as value to CPUEND reg entry needed, right?

Yes, will add in v5.

> 
> > +
> > <...snip...>
> > +            /*
> > +             * We will write the cpu state data later, as otherwise it
> > +             * might get overwritten by other fadump regions
> 
> Isn't the destination address of cpu state data and RMR region are
> different?
> 
> I don't understand the above comment. Can you please give more details.
> 
> > +             */
> > +
> > <...snip...>
> > +    /*
> > +     * Write the Register Save Area
> > +     *
> > +     * CPU State/Register Save Area should be written after dumping the
> > +     * memory to prevent overwriting while saving other memory regions
> > +     *
> > +     * eg. If boot memory region is 1G, then both the first 1GB memory, and
> > +     * the Register Save Area needs to be saved at 1GB.
> 
> Every region is copied to their destination address and as per below kernel
> function:
> https://github.com/torvalds/linux/blob/f406055cb18c6e299c4a783fc1effeb16be41803/arch/powerpc/platforms/pseries/rtas-fadump.c#L98
> 
> the destination address shouldn't  be same for fadump region then how come
> there
> is overwrite scenario? Am I missing something?

Yes, with current kernel logic, destination address of cpu state data
and RMR region are different.

I remember having faced some issue in past (don't recall, might have
been with powernv, or it might not exist anymore) hence the comment.

Ideally kernel should ensure CPU and memory regions don't overlap.

Possible overlap can be like, memory region being 0x0 - 512MB, and
generally the cpu region's destination also lies in this low memory.

PAPR says nothing about order of saving iirc. I kept current way to
ensure we have CPU registers even if such overlap happens.

What do you say ? Should we save CPU region first and then go with
saving memory regions ?

> 
> > +     * And as the CPU_STATE_DATA region comes first than the
> > +     * REAL_MODE_REGION region to be copied, the CPU_STATE_DATA will get
> > +     * overwritten if saved before the 0GB - 1GB region is copied after
> > +     * saving CPU state data
> > +     */
> > +    io_result = address_space_write(default_as, cpu_state_addr, attrs,
> > +            cpu_state_buffer, cpu_state_len);
> 
> Hope cpu_state_buffer will be freed automatically...

Yes, as it's declared with g_autofree, glibc/compiler takes care of
adding cleanup functions ensuring it gets freed.

> 
> > <...snip...>
> > +/* Number of registers stored per cpu */
> > +#define FADUMP_NUM_PER_CPU_REGS (32 /*GPR*/ + 45 /*others*/ + 2 /*STRT & END*/)
> 
> #nit-pick
> How about FADUMP_PER_CPU_REG_ENTRY ?

How about FADUMP_PER_CPU_NUM_REGS ? Basically explicitly saying it's
number of registers per cpu ?

Thanks for your reviews Sourabh,
- Aditya G


