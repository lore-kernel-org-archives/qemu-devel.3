Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E4B0C021BE
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 07:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnXzS-0000Fh-DQ; Thu, 27 Feb 2025 02:07:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tnXzI-0000FK-Fk; Thu, 27 Feb 2025 02:07:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1tnXzG-0007oP-Ho; Thu, 27 Feb 2025 02:07:16 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51QMnM2M014472;
 Thu, 27 Feb 2025 07:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=L29g5t
 /45wTXgZ+3umU3gTnQvn7wI9UWdWxzE9tS6qU=; b=H6BSAHTpWEROGVDMXQcriQ
 ptLyfc0UTe2mF/Bbdm3a6Quyz7jdgASvUru56xuQLHz54xIpj/DN4LmqnPkA9zs5
 vWWUgUL/xU4bByOKADcYRj3qgcZ2dQUewoM0facHAJxZb5YU7aPKwwipg576XatM
 nGI52TSCjGnPhxi/jP+84SwWGtNdrwuZST7AQBj7I4mQwDLMFtOfeokgh0YCQZSY
 Txt76C42cZuD0dQVvODz93N8OZW/7PEVHh3Ms1NSCmAPf74B4PrFRzUJINqvDnZ/
 Exv0gz0HA9l/7zAOtu/HHsJrem9FWnjjp4elw1KbvTESut2qJdvDHKc442+H7eCA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452c3a1rx1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 07:07:12 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51R76mPj016118;
 Thu, 27 Feb 2025 07:07:11 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 452c3a1rww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 07:07:11 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51R3fLxa027376;
 Thu, 27 Feb 2025 07:07:10 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yum26ty7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 27 Feb 2025 07:07:10 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 51R777jp35783108
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 27 Feb 2025 07:07:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id ECDF620040;
 Thu, 27 Feb 2025 07:07:05 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8B5462004D;
 Thu, 27 Feb 2025 07:07:03 +0000 (GMT)
Received: from [9.124.211.149] (unknown [9.124.211.149])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 27 Feb 2025 07:07:03 +0000 (GMT)
Message-ID: <8108eb0d-7efe-4549-ba74-c7de50935dfe@linux.ibm.com>
Date: Thu, 27 Feb 2025 12:37:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] hw/ppc: Enable Fadump for PSeries
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250217071711.83735-1-adityag@linux.ibm.com>
 <20250217071711.83735-7-adityag@linux.ibm.com>
 <D82WUV05QWZP.10KAOOHN6YFFP@gmail.com>
Content-Language: en-US
From: Aditya Gupta <adityag@linux.ibm.com>
In-Reply-To: <D82WUV05QWZP.10KAOOHN6YFFP@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RU29WAAkl4rBsh19vxXHAHQ2_gDQTLy7
X-Proofpoint-ORIG-GUID: IOhmexxJr8DIdeFQMrGdckpECQeRYWHT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_03,2025-02-26_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 adultscore=0 spamscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270052
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

On 27/02/25 09:03, Nicholas Piggin wrote:

> On Mon Feb 17, 2025 at 5:17 PM AEST, Aditya Gupta wrote:
>> With all support in place, enable fadump by exporting the
>> "ibm,configure-kernel-dump" RTAS call in the device tree.
>>
>> Presence of "ibm,configure-kernel-dump" tells the kernel that the
>> platform (QEMU) supports fadump.
>>
>> Pass "fadump=on" to enable Linux to use firmware assisted dump.
>>
>> Logs of a linux boot with firmware assisted dump:
>>
>>      ./build/qemu-system-ppc64 -M pseries,x-vof=on --cpu power10 --smp 4 -m 4G -kernel some-vmlinux -initrd some-initrd -append "debug fadump=on crashkernel=1G" -nographic
>>      [    0.000000] random: crng init done
>>      [    0.000000] fadump: Reserved 1024MB of memory at 0x00000040000000 (System RAM: 4096MB)
>>      ...
>>      [    1.084686] rtas fadump: Registration is successful!
>>      ...
>>      # cat /sys/kernel/debug/powerpc/fadump_region
>>      CPU :[0x00000040000000-0x000000400013d3] 0x13d4 bytes, Dumped: 0x0
>>      HPTE:[0x000000400013d4-0x000000400013d3] 0x0 bytes, Dumped: 0x0
>>      DUMP: Src: 0x00000000000000, Dest: 0x00000040010000, Size: 0x40000000, Dumped: 0x0 bytes
>>
>>      [0x000000fffff800-0x000000ffffffff]: cmdline append: ''
>>      # echo c > /proc/sysrq-trigger
>>
>> The fadump boot after crash:
>>
>>      [    0.000000] rtas fadump: Firmware-assisted dump is active.
>>      [    0.000000] fadump: Updated cmdline: debug fadump=on crashkernel=1G
>>      [    0.000000] fadump: Firmware-assisted dump is active.
>>      [    0.000000] fadump: Reserving 3072MB of memory at 0x00000040000000 for preserving crash data
>>      ....
>>      # file /proc/vmcore
>>      /proc/vmcore: ELF 64-bit LSB core file, 64-bit PowerPC or cisco 7500, OpenPOWER ELF V2 ABI, version 1 (SYSV), SVR4-style
>>
>> Analysing the vmcore with crash-utility:
>>
>>            KERNEL: vmlinux-6.14-rc2
>>          DUMPFILE: vmcore-a64dcfb451e2-nocma
>>              CPUS: 4
>>              DATE: Thu Jan  1 05:30:00 IST 1970
>>            UPTIME: 00:00:30
>>      LOAD AVERAGE: 0.74, 0.21, 0.07
>>             TASKS: 94
>>          NODENAME: buildroot
>>           RELEASE: 6.14.0-rc2+
>>           VERSION: #1 SMP Wed Feb 12 06:49:59 CST 2025
>>           MACHINE: ppc64le  (1000 Mhz)
>>            MEMORY: 4 GB
>>             PANIC: "Kernel panic - not syncing: sysrq triggered crash"
>>               PID: 270
>>           COMMAND: "sh"
>>              TASK: c000000009e7cc00  [THREAD_INFO: c000000009e7cc00]
>>               CPU: 3
>>             STATE: TASK_RUNNING (PANIC)
>>
>> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> This is very cool, nice work. Does it work with KVM? I think... probably
> it could?

Yes it does, atleast for crashing CPU :)

But there are problems with reading the CPU regs, regs don't seem 
correct for non-crashing CPUs.

Crash is able to work perfectly for the crashing CPU as of now (as the 
registers are stored by the kernel in that case).

>
> Are you able to add a functional test case for it? This is something
> that people (including me) will forget to test...

Sure, I will add a test case.


Thanks for your reviews Nick.

It might take few weeks for me to post another version, will see into 
the tests in qemu and arrange the code bit more nicely.


- Aditya G

>
> Thanks,
> Nick
>
>> ---
>>   hw/ppc/spapr_rtas.c    | 6 +++++-
>>   include/hw/ppc/spapr.h | 3 ++-
>>   2 files changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
>> index 0aca4270aee8..bd2ed16a46e3 100644
>> --- a/hw/ppc/spapr_rtas.c
>> +++ b/hw/ppc/spapr_rtas.c
>> @@ -692,7 +692,7 @@ static void trigger_fadump_boot(target_ulong spapr_retcode)
>>   }
>>   
>>   /* Papr Section 7.4.9 ibm,configure-kernel-dump RTAS call */
>> -static __attribute((unused)) void rtas_configure_kernel_dump(PowerPCCPU *cpu,
>> +static void rtas_configure_kernel_dump(PowerPCCPU *cpu,
>>                                      SpaprMachineState *spapr,
>>                                      uint32_t token, uint32_t nargs,
>>                                      target_ulong args,
>> @@ -1109,6 +1109,10 @@ static void core_rtas_register_types(void)
>>       spapr_rtas_register(RTAS_IBM_NMI_INTERLOCK, "ibm,nmi-interlock",
>>                           rtas_ibm_nmi_interlock);
>>   
>> +    /* Register Fadump rtas call */
>> +    spapr_rtas_register(RTAS_CONFIGURE_KERNEL_DUMP, "ibm,configure-kernel-dump",
>> +                        rtas_configure_kernel_dump);
>> +
>>       qtest_set_command_cb(spapr_qtest_callback);
>>   }
>>   
>> diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
>> index fa63008e57ec..bde3bdc4b80c 100644
>> --- a/include/hw/ppc/spapr.h
>> +++ b/include/hw/ppc/spapr.h
>> @@ -768,8 +768,9 @@ void push_sregs_to_kvm_pr(SpaprMachineState *spapr);
>>   #define RTAS_IBM_SUSPEND_ME                     (RTAS_TOKEN_BASE + 0x2A)
>>   #define RTAS_IBM_NMI_REGISTER                   (RTAS_TOKEN_BASE + 0x2B)
>>   #define RTAS_IBM_NMI_INTERLOCK                  (RTAS_TOKEN_BASE + 0x2C)
>> +#define RTAS_CONFIGURE_KERNEL_DUMP              (RTAS_TOKEN_BASE + 0x2D)
>>   
>> -#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2D)
>> +#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2E)
>>   
>>   /* Fadump commands */
>>   #define FADUMP_CMD_REGISTER            1

