Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB513C77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:26:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTgDz-0002Aq-ST; Mon, 23 Jun 2025 08:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1uTgDn-0001zF-Vm; Mon, 23 Jun 2025 08:24:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1uTgDg-0001ZU-Pj; Mon, 23 Jun 2025 08:24:23 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N64Bf1017551;
 Mon, 23 Jun 2025 12:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=lRPEgU
 mljfTmyd/9jVJyGOsd4NRVAOGCrzW4NY7b4Kk=; b=DT6yhnvhY3BP5DhLNx/GxF
 JV3lHWeo4JlUuIC24SlE1sOTyzUD0Y7ZeA228+pxmNFOpfKfgl+ukUqdR6lEXBi9
 R3eORUPF/2eQ6pIq92IZv88C1W5BscXdz9v5QjVPZVu/0M7Y0woD0QqW7ZH59B8t
 YjwUuhraQXEDHpkubfStax5OmDSGKBYmVayy1NFznF7aAFh9PjoA02r+X4SLz7Jt
 lBbw4DEDd6UDe+kIcyeyH9mNlLhgnr9xxFZPDopCYrwv0i3o527GmgFQ6fSRoZFJ
 07rgVMqZtL0a2x/zxTLxyqrojYWp+Qt8JskccrvYI2UT3K2K8tl4l4Acbpu8GMWg
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmf2sfa4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 12:24:11 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55NCNnGa020931;
 Mon, 23 Jun 2025 12:24:11 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmf2sf9x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 12:24:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55NB7ZjH014988;
 Mon, 23 Jun 2025 12:24:10 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e72tem2r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 23 Jun 2025 12:24:10 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 55NCO9va14287444
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 23 Jun 2025 12:24:09 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E69FF58058;
 Mon, 23 Jun 2025 12:24:08 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 777255805B;
 Mon, 23 Jun 2025 12:24:06 +0000 (GMT)
Received: from [9.61.246.2] (unknown [9.61.246.2])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 23 Jun 2025 12:24:06 +0000 (GMT)
Message-ID: <888a0d9d-ed0d-4a9c-81b6-0b3f3e6fc0db@linux.ibm.com>
Date: Mon, 23 Jun 2025 17:54:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: CPU hotplug crashed the guest when using virt-type as qemu!
From: Anushree Mathur <anushree.mathur@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, richard.henderson@linaro.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, harshpb@linux.ibm.com,
 rathc@linux.ibm.com
References: <96ce3e34-6d4e-4d92-a852-6eee5063140d@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <96ce3e34-6d4e-4d92-a852-6eee5063140d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5FNKzws c=1 sm=1 tr=0 ts=6859476b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=p0WdMEafAAAA:8 a=-0eX4HzcuYmkXvSIhdUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA3NCBTYWx0ZWRfXx7bRa88VilQe
 w5ppb1YpG8vVmEjrrv6SPampqxiBN1ZbiDAGMzthjKfz/vE+x/+cLJEl16v3JbII5YcNTDVVVI3
 S1fL5D4G0FNTx1mWioIvjCxe8k4PuirORWSN/7xdmP9Y/rBwq71e3EYXcBTR3POrscakRZ0xXSM
 aMBe3qYz7D8nGhvEPJuOC8ITyZtbBJamV8rVkBs46YpB8YQq26KskjxJe6deXxCFs4U/EhG/39P
 sn7zgZuJVoqv6vG7MRyN0XdIMjVdulLMt87IN4v66sAShydAueBwdqhL9zq1N0XBFotakXlw4DC
 /xaQpwRnbU+vi2E8655fPmbYcZeIsq3p0xwdc6U+Y38eGogkt9KmYw132c8BR//gAB1/ucx7mHq
 hqcP7yvesG4FxhOEt5GNwY4Dod3D40+8Kj855mt8/65AH+zFfwNL94f+3BgqybnxxqAek1pY
X-Proofpoint-GUID: gh0GNVxrsZeZoPpJ_X-Gj4wJMag1ZM3N
X-Proofpoint-ORIG-GUID: M5Xiet4mJ_rOuF8b2XcK_tKauWFrW7Q1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015 adultscore=0
 mlxscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506230074
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=anushree.mathur@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Hi Richard,
Any updates on this issue? Would really appreciate your inputs here. 
Thanks in advance!


Regards,
Anushree-Mathur

On 28/05/25 7:04 PM, Anushree Mathur wrote:
> Hi all,
> I have reported this issue on gitlab at 
> https://gitlab.com/qemu-project/qemu/-/issues/2984.
>
> Steps to reproduce:
>
> 1) Start a guest with virt-type as qemu
> <domain type='qemu'>
>   <name>linux</name>
>   <uuid>cba9037f-2a62-41f9-98c1-0780b2ff49b9</uuid>
>   <maxMemory slots='16' unit='KiB'>419430400</maxMemory>
>   <memory unit='KiB'>20971520</memory>
>   <currentMemory unit='KiB'>10485760</currentMemory>
>   <memoryBacking>
>     <locked/>
>   </memoryBacking>
>   <vcpu placement='static' current='4'>1024</vcpu>
>
>
> 2) lscpu on host:
> lscpu
> Architecture:             ppc64le
>   Byte Order:             Little Endian
> CPU(s):                   40
>   On-line CPU(s) list:    0-39
> Model name:               POWER10 (architected), altivec supported
>   Model:                  2.0 (pvr 0080 0200)
>   Thread(s) per core:     8
>   Core(s) per socket:     5
>   Socket(s):              1
>   Physical sockets:       4
>   Physical chips:         1
>   Physical cores/chip:    12
>
> 3) [On host] virsh setvcpus linux 800
> error: Unable to read from monitor: Connection reset by peer
>
> 4) Guest is getting into shutoff state
>
> 5) I am seeing this issue on upstream qemu also
>
>
>
> Tried reproducing while attaching gdb shows below backtrace which 
> happened after hotplugging 249 CPUs in TCG mode:
>
> Thread 261 "CPU 249/TCG" received signal SIGABRT, Aborted.
> [Switching to Thread 0x7ff97c00ea20 (LWP 51567)]
> 0x00007fff84cac3e8 in __pthread_kill_implementation () from 
> target:/lib64/glibc-hwcaps/power10/libc.so.6
> (gdb) bt
> #0  0x00007fff84cac3e8 in __pthread_kill_implementation () from 
> target:/lib64/glibc-hwcaps/power10/libc.so.6
> #1  0x00007fff84c46ba0 in raise () from 
> target:/lib64/glibc-hwcaps/power10/libc.so.6
> #2  0x00007fff84c29354 in abort () from 
> target:/lib64/glibc-hwcaps/power10/libc.so.6
> #3  0x00007fff850f1e30 in g_assertion_message () from 
> target:/lib64/libglib-2.0.so.0
> #4  0x00007fff850f1ebc in g_assertion_message_expr () from 
> target:/lib64/libglib-2.0.so.0
> #5  0x00000001376c6f00 in tcg_region_initial_alloc__locked 
> (s=0x7fff7c000f30) at ../tcg/region.c:396
> #6  0x00000001376c6fa8 in tcg_region_initial_alloc (s=0x7fff7c000f30) 
> at ../tcg/region.c:402
> #7  0x00000001376dae08 in tcg_register_thread () at ../tcg/tcg.c:1011
> #8  0x000000013768b7e4 in mttcg_cpu_thread_fn (arg=0x143e884f0) at 
> ../accel/tcg/tcg-accel-ops-mttcg.c:77
> #9  0x0000000137bbb2d0 in qemu_thread_start (args=0x143b4aff0) at 
> ../util/qemu-thread-posix.c:542
> #10 0x00007fff84ca9be0 in start_thread () from 
> target:/lib64/glibc-hwcaps/power10/libc.so.6
> #11 0x00007fff84d4ef3c in __clone3 () from 
> target:/lib64/glibc-hwcaps/power10/libc.so.6
> (gdb)
>
>
> which points to below code:
>
> /*
>  * Perform a context's first region allocation.
>  * This function does _not_ increment region.agg_size_full.
>  */
> static void tcg_region_initial_alloc__locked(TCGContext *s)
> {
>     bool err = tcg_region_alloc__locked(s);
>     g_assert(!err);
> }
>
> Here, tcg_region_alloc__locked is defined as below:
>
>
> static bool tcg_region_alloc__locked(TCGContext *s)
> {
>     if (region.current == region.n) {
>         return true;
>     }
>     tcg_region_assign(s, region.current);
>     region.current++;
>     return false;
> }
>
> Thanks,
> Anushree-Mathur


