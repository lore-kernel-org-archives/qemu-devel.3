Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C86AC5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 13:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKH0I-0006qd-9C; Wed, 28 May 2025 09:39:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1uKGvD-00049c-8g; Wed, 28 May 2025 09:34:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anushree.mathur@linux.ibm.com>)
 id 1uKGv7-0000FP-9E; Wed, 28 May 2025 09:34:18 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54S5ZK7r007582;
 Wed, 28 May 2025 13:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=QljXPgNS3zb4qHEe2/u0MdQlcacM
 PXRmaem8M9pZP8I=; b=eKa4fOw/7zK5wd7H8IFHdUGLZ86zk4/b8U+y1jG6aAQ2
 VKHaWyCOMSCXXMUmsn/fEF6jngi837U2HfGfzP+bjG6yFGd9/yjF4ni1RW/M8b9k
 GzqLtCNUHv2T0CeGcnSfChj1RrLMW0i45g98lIimxvHTwiWpLBEXGByO6VRvOlR5
 ylLUmv2B64MOPmtkOOuM1dyOmSfxwZyDi9sCOl3miFqZrhNXUbVpFE9g3tW285cg
 zg/FBbq9MKdBVHBHEUjibY3wUmA8nDSyHcLX8lj/S0HQN7UvkjLJUWFfPsxoDBAM
 QIYTWWFSZxmFu4TdcQxQ0AX0U/xdM8ANIBHDeDQfwQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46wvfb25bn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 May 2025 13:34:07 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54SDBfwV006531;
 Wed, 28 May 2025 13:34:07 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46wvfb25bh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 May 2025 13:34:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54SAZY5T016121;
 Wed, 28 May 2025 13:34:06 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 46ureufw0h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 28 May 2025 13:34:06 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54SDY1QS24445530
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 28 May 2025 13:34:01 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 723DA5805E;
 Wed, 28 May 2025 13:34:05 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7866B5805C;
 Wed, 28 May 2025 13:34:03 +0000 (GMT)
Received: from [9.61.247.249] (unknown [9.61.247.249])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 28 May 2025 13:34:03 +0000 (GMT)
Message-ID: <96ce3e34-6d4e-4d92-a852-6eee5063140d@linux.ibm.com>
Date: Wed, 28 May 2025 19:04:01 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: richard.henderson@linaro.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
From: Anushree Mathur <anushree.mathur@linux.ibm.com>
Subject: CPU hotplug crashed the guest when using virt-type as qemu!
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI4MDExOSBTYWx0ZWRfX8gaEwT/p7jXz
 qNmklYmxl1oItlbNBDNN9Vs7F9tfHhaY1BM62D1ElfIYbiqzbp5uiZK3MPdHpjDGQs1QF7tXXZm
 DxIepMYNvqU/4wX++fGNlQaLYDIj4u+JFExqjn9nOVVegSK1jn9EoCR4gwKkx5p61SvUsrm5tvj
 NEf+rGKNovLuq0zXTb6DNrw9IT6UoMBIJrXt5TquMux/2Yd2TH58FeeF+mSc6bijEL3KdOcxqGg
 UAuGyFxOhrNAkgOMQx7KuEPkUnppc4yPXAqg0Ogp1TCfELdMdMt66dWvAznorX3X7z3a8CN7QIv
 CDXHKcysGB+hoDqsAJJKgCMHogFdK1WgXoqKIZJ4MwXrSlQ+Runq1HorwrSgm6wo08G03joXeqx
 qRbfRdVvLGJEIa3WeJqAfWpZY3smhtWiBvvt+HsFuEz+PKAYVZOC8xaRAD62d1U5+mi31TO4
X-Proofpoint-ORIG-GUID: yOEgPz_3EUwNa3BtXxm8RMPOtDR0HdV_
X-Authority-Analysis: v=2.4 cv=bt5MBFai c=1 sm=1 tr=0 ts=683710cf cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=p0WdMEafAAAA:8 a=S8Nqp2tqgMMLoWVdoMUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: QS4us7QXAGEuagAXdaviXQczuQsaBuqb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-28_06,2025-05-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 clxscore=1011 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505280119
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=anushree.mathur@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 28 May 2025 09:39:33 -0400
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

Hi all,
I have reported this issue on gitlab at 
https://gitlab.com/qemu-project/qemu/-/issues/2984.

Steps to reproduce:

1) Start a guest with virt-type as qemu
<domain type='qemu'>
   <name>linux</name>
   <uuid>cba9037f-2a62-41f9-98c1-0780b2ff49b9</uuid>
   <maxMemory slots='16' unit='KiB'>419430400</maxMemory>
   <memory unit='KiB'>20971520</memory>
   <currentMemory unit='KiB'>10485760</currentMemory>
   <memoryBacking>
     <locked/>
   </memoryBacking>
   <vcpu placement='static' current='4'>1024</vcpu>


2) lscpu on host:
lscpu
Architecture:             ppc64le
   Byte Order:             Little Endian
CPU(s):                   40
   On-line CPU(s) list:    0-39
Model name:               POWER10 (architected), altivec supported
   Model:                  2.0 (pvr 0080 0200)
   Thread(s) per core:     8
   Core(s) per socket:     5
   Socket(s):              1
   Physical sockets:       4
   Physical chips:         1
   Physical cores/chip:    12

3) [On host] virsh setvcpus linux 800
error: Unable to read from monitor: Connection reset by peer

4) Guest is getting into shutoff state

5) I am seeing this issue on upstream qemu also



Tried reproducing while attaching gdb shows below backtrace which 
happened after hotplugging 249 CPUs in TCG mode:

Thread 261 "CPU 249/TCG" received signal SIGABRT, Aborted.
[Switching to Thread 0x7ff97c00ea20 (LWP 51567)]
0x00007fff84cac3e8 in __pthread_kill_implementation () from 
target:/lib64/glibc-hwcaps/power10/libc.so.6
(gdb) bt
#0  0x00007fff84cac3e8 in __pthread_kill_implementation () from 
target:/lib64/glibc-hwcaps/power10/libc.so.6
#1  0x00007fff84c46ba0 in raise () from 
target:/lib64/glibc-hwcaps/power10/libc.so.6
#2  0x00007fff84c29354 in abort () from 
target:/lib64/glibc-hwcaps/power10/libc.so.6
#3  0x00007fff850f1e30 in g_assertion_message () from 
target:/lib64/libglib-2.0.so.0
#4  0x00007fff850f1ebc in g_assertion_message_expr () from 
target:/lib64/libglib-2.0.so.0
#5  0x00000001376c6f00 in tcg_region_initial_alloc__locked 
(s=0x7fff7c000f30) at ../tcg/region.c:396
#6  0x00000001376c6fa8 in tcg_region_initial_alloc (s=0x7fff7c000f30) at 
../tcg/region.c:402
#7  0x00000001376dae08 in tcg_register_thread () at ../tcg/tcg.c:1011
#8  0x000000013768b7e4 in mttcg_cpu_thread_fn (arg=0x143e884f0) at 
../accel/tcg/tcg-accel-ops-mttcg.c:77
#9  0x0000000137bbb2d0 in qemu_thread_start (args=0x143b4aff0) at 
../util/qemu-thread-posix.c:542
#10 0x00007fff84ca9be0 in start_thread () from 
target:/lib64/glibc-hwcaps/power10/libc.so.6
#11 0x00007fff84d4ef3c in __clone3 () from 
target:/lib64/glibc-hwcaps/power10/libc.so.6
(gdb)


which points to below code:

/*
  * Perform a context's first region allocation.
  * This function does _not_ increment region.agg_size_full.
  */
static void tcg_region_initial_alloc__locked(TCGContext *s)
{
     bool err = tcg_region_alloc__locked(s);
     g_assert(!err);
}

Here, tcg_region_alloc__locked is defined as below:


static bool tcg_region_alloc__locked(TCGContext *s)
{
     if (region.current == region.n) {
         return true;
     }
     tcg_region_assign(s, region.current);
     region.current++;
     return false;
}

Thanks,
Anushree-Mathur

