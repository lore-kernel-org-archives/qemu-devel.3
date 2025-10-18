Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94168CCD184
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Oct 2025 12:05:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vA5g9-0007qz-Cv; Sat, 18 Oct 2025 08:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1vA5g3-0007qf-DO; Sat, 18 Oct 2025 08:04:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1vA5g1-0000B5-C1; Sat, 18 Oct 2025 08:04:51 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59IAKMZZ014166;
 Sat, 18 Oct 2025 12:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Me0rNr
 bkiNfw6j197Kp9P4X7rdWJv62garweWbQP8Gw=; b=iFSYCJn0i8TbGWhdxBF36p
 Fh9gjKfy+U9ySp0XzVAjiJpGPKkpbEcc+pir2BD8nFkirJ/hHUWn2UgGfMaWpRX6
 KV+BbI/gbwh2l5w1DhqBpCcSpzs+NbNbJiW3VOoVroAXo+PLgj9o3G6OV2vDkNAU
 OlMC2hACSapHfqEbGY3CemswLETKT1fMtccdhR5k8MAARjAcMnyVAF54yvjaxWqJ
 bUUixYVPxH9bWtnCQMUqvNQhDzzKMHxvYT3lmDTKqbP/2X6KCCLnhRJUgGtMcFKh
 2CbnOR+mbm6frX2yZEUxqBVL60pXoRAU38PeKkBGZivCxKradnYgKh36MEepr0rA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31bs84p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 18 Oct 2025 12:04:46 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59IC4kFU009552;
 Sat, 18 Oct 2025 12:04:46 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31bs84m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 18 Oct 2025 12:04:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59IBI3nQ015016;
 Sat, 18 Oct 2025 12:04:45 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49r3sk1k5q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 18 Oct 2025 12:04:45 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59IC4fVd27394380
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 18 Oct 2025 12:04:41 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C0C792004E;
 Sat, 18 Oct 2025 12:04:41 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7DFD22004B;
 Sat, 18 Oct 2025 12:04:39 +0000 (GMT)
Received: from [9.39.28.54] (unknown [9.39.28.54])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Sat, 18 Oct 2025 12:04:39 +0000 (GMT)
Message-ID: <1d3f2a26-73be-4c09-814e-92e2933a04a0@linux.ibm.com>
Date: Sat, 18 Oct 2025 17:34:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/8] hw/ppc: Enable fadump for PSeries
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250323174007.221116-1-adityag@linux.ibm.com>
 <20250323174007.221116-8-adityag@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20250323174007.221116-8-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: d_IV7hP92Bfg1mr8LRbKa3FscAIDdpJV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX1mA6BvJZ2BgR
 YLkSnav4uJQ4cTgKfWSeZqa0wDDWJKsCy1JCzeQae4rWrNM31UHqh7X2iTE5HIzp4vrVOA0syHY
 t7sgTWPwmzSa2VOVncYeWpVlkNvkY/asxhjlC5xJZOIhdCyA6J0MszkmVYhUXICyQme66hHSkCv
 /OwWL6x8aBZJo10AlrUEg9xwK2xvnRMrLBQK2WFIcm2AWOqGXmGGP5x1AYyzroRRC2/xRzQOkyA
 2s46ZWWmaQvXbFKCQ3LjkUdkJKPVv6QHpdZ0tbUVL60NgU+eDqIiHQ6qVwswGDeoyQ4Q8HTVvmT
 yCmIr70oqVaFOq2Uf3d5wFkAsraa8Oa3AkCrKm8CR9Y4PCXRxuWi7OZvxvfAb2X14k3seGuRtDm
 Xd5T4/BFXqlNewWQs7vB39L1ciM/cA==
X-Proofpoint-GUID: hEfHnyON2QdBg7IAvzJmSphZxs9yywoW
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68f3825e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=6eMFpH33ACt_N_I4TK4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=sourabhjain@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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



On 23/03/25 23:10, Aditya Gupta wrote:
> With all support in place for preserving memory regions, enable fadump by
> exporting the "ibm,kernel-dump" property in the device tree, representing
> the fadump dump information, in case of a crash.
>
> Currently "ibm,configure-kernel-dump" RTAS call is already registered,
> which tells the kernel that the platform (QEMU) supports fadump.
>
> Now, in case of a crash, if fadump was registered, we also pass
> "ibm,kernel-dump" in device tree, which tells the kernel that the fadump
> dump is active.
>
> Pass "fadump=on" to enable Linux to use firmware assisted dump.
>
> Logs of a linux boot with firmware assisted dump:
>
>      $ ./build/qemu-system-ppc64 -M pseries,x-vof=on --cpu power10 --smp 4 -m 4G -kernel some-vmlinux -initrd some-initrd -append "debug fadump=on crashkernel=1G" -nographic
>
>      [    0.000000] fadump: Reserved 1024MB of memory at 0x00000040000000 (System RAM: 4096MB)
>      [    0.000000] fadump: Initialized 0x40000000 bytes cma area at 1024MB from 0x400102a8 bytes of memory reserved for firmware-assisted dump
>      ...
>      [    1.084686] rtas fadump: Registration is successful!
>      ...
>      # cat /sys/kernel/debug/powerpc/fadump_region
>      CPU :[0x00000040000000-0x000000400013df] 0x13e0 bytes, Dumped: 0x0
>      HPTE:[0x000000400013e0-0x000000400013df] 0x0 bytes, Dumped: 0x0
>      DUMP: Src: 0x00000000000000, Dest: 0x00000040010000, Size: 0x40000000, Dumped: 0x0 bytes
>
>      [0x0000000921a000-0x0000000921a7ff]: cmdline append: ''
>      # echo c > /proc/sysrq-trigger
>
> The fadump boot after crash:
>
>      [    0.000000] rtas fadump: Firmware-assisted dump is active.
>      [    0.000000] fadump: Updated cmdline: debug fadump=on crashkernel=1G
>      [    0.000000] fadump: Firmware-assisted dump is active.

Kernel is printing twice about fadump is active. :)

>      [    0.000000] fadump: Reserving 3072MB of memory at 0x00000040000000 for preserving crash data
>      ....
>      # file /proc/vmcore
>      /proc/vmcore: ELF 64-bit LSB core file, 64-bit PowerPC or cisco 7500, OpenPOWER ELF V2 ABI, version 1 (SYSV), SVR4-style
>
> Analysing the vmcore with crash-utility:
>
>            KERNEL: vmlinux-6.14-rc2
>          DUMPFILE: vmcore-fc92fb373aa0
>              CPUS: 4
>              DATE: Wed Mar 12 23:39:23 CDT 2025
>            UPTIME: 00:00:22
>      LOAD AVERAGE: 0.13, 0.03, 0.01
>             TASKS: 95
>          NODENAME: buildroot
>           RELEASE: 6.12.0-rc4+
>           VERSION: #1 SMP Fri Jan  3 00:15:17 IST 2025
>           MACHINE: ppc64le  (1000 Mhz)
>            MEMORY: 4 GB
>             PANIC: "Kernel panic - not syncing: sysrq triggered crash"
>               PID: 269
>           COMMAND: "sh"
>              TASK: c00000000a050b00  [THREAD_INFO: c00000000a050b00]
>               CPU: 0
>             STATE: TASK_RUNNING (PANIC)
>
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> ---
>   hw/ppc/spapr.c | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 3cbc6a7409b7..f6e666ad4344 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -904,6 +904,9 @@ static void spapr_dt_rtas_fadump(SpaprMachineState *spapr, void *fdt, int rtas)
>   {
>       MachineState *ms = MACHINE(spapr);
>       MachineClass *mc = MACHINE_GET_CLASS(ms);
> +    FadumpMemStruct *fdm = &spapr->registered_fdm;
> +    uint16_t dump_status_flag;
> +    bool     is_next_boot_fadump;
>   
>       uint32_t max_possible_cpus = mc->possible_cpu_arch_ids(ms)->len;
>       uint64_t fadump_cpu_state_size = 0;
> @@ -953,6 +956,18 @@ static void spapr_dt_rtas_fadump(SpaprMachineState *spapr, void *fdt, int rtas)
>                       fadump_versions, sizeof(fadump_versions))));
>       _FDT((fdt_setprop(fdt, rtas, "ibm,configure-kernel-dump-sizes",
>                       fadump_rgn_sizes, sizeof(fadump_rgn_sizes))));
> +
> +    dump_status_flag = be16_to_cpu(fdm->header.dump_status_flag);
> +    is_next_boot_fadump =

Do we really need is_next_boot_fadump variable?

> +        (dump_status_flag & FADUMP_STATUS_DUMP_TRIGGERED) != 0;
> +    if (is_next_boot_fadump) {
> +        uint64_t fdm_size =
> +            sizeof(struct FadumpSectionHeader) +
> +            (be16_to_cpu(fdm->header.dump_num_sections) *
> +            sizeof(struct FadumpSection));
> +
> +        _FDT((fdt_setprop(fdt, rtas, "ibm,kernel-dump", fdm, fdm_size)));

Is this common in QEMU to call _FDT to add prop to the FDT? Feels odd.

> +    }
>   }
>   
>   static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)


