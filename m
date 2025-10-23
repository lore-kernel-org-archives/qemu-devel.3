Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30360CCD1BC
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 09:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBrJd-0004eL-S5; Thu, 23 Oct 2025 05:09:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1vBrJb-0004dH-EE; Thu, 23 Oct 2025 05:08:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sourabhjain@linux.ibm.com>)
 id 1vBrJY-0004ZZ-TJ; Thu, 23 Oct 2025 05:08:59 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N8Idxu027573;
 Thu, 23 Oct 2025 09:08:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=DZ6iR+
 sR6++tLWInGYNeH7wyBQoHOqcMJorA2Z78z9Y=; b=BD6kC0Kk2ai2ONxSfY27jH
 RzqBoVmxj1vOni03+bQIHY/L/A8B7i0Eb3apsn51AkbC2yQDN6Dyo1SB7ke0AlGA
 Ys5OpddbSEgwBT/bNfd1KxvxUGagPN0JXOeLW/qf8edX3W6747LnMZ3SrrQX6qh1
 6HzClaQ504XdYdkU5eWBLJxfnPFpVd4poAxQTE+zEJxaUQxTEyys743BkBECspbS
 pZXW/kJyJZrJw/d6snaPOelFUP2oyjzH+9EpgjFVFSd/Ot340xtyEwzCjbBa9tUJ
 VSNIzhXBTtG1FwZGdG+XTiF+UjOHr9+jPGDGWGvEWCTwEZBJ+4kKigJj/Pg3jCww
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31s9awq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 09:08:54 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59N98rU1000403;
 Thu, 23 Oct 2025 09:08:53 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31s9awm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 09:08:53 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59N95DA7017081;
 Thu, 23 Oct 2025 09:08:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vnky528e-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 09:08:52 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59N98mIQ39911832
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 09:08:48 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id BD2EC20040;
 Thu, 23 Oct 2025 09:08:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4CFD92004D;
 Thu, 23 Oct 2025 09:08:46 +0000 (GMT)
Received: from [9.109.204.116] (unknown [9.109.204.116])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 09:08:46 +0000 (GMT)
Message-ID: <2217b04e-680f-4071-80cd-cde41ff552ae@linux.ibm.com>
Date: Thu, 23 Oct 2025 14:38:45 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/8] hw/ppc: Enable fadump for PSeries
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20251021134823.1861675-1-adityag@linux.ibm.com>
 <20251021134823.1861675-7-adityag@linux.ibm.com>
Content-Language: en-US
From: Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20251021134823.1861675-7-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MCphFOcmkvsb45JZ7i6b1EOr4Yo7E4fZ
X-Proofpoint-GUID: x7e4KTemYpjdOxl20b_WFdImvWOAYDT2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXxjuZQkteF/qX
 xQxGtn8Zulu3wRpTbXXT0jRnlsnPtD359cgkMBeKHVpGV2kjT/c2ozd0AnhQ4Y3JUclSbp3mR4o
 0kXQ33hqN7TO0FoCUDx7gmdG2v2Hby2X9Elrtcreh+WTQhMleSkvpjWvnXX4AtGuePBlRceI+l9
 67q+6w4rrOV0MsNpcbcEr7YtVJ4vcPjjyDBrx6TI2/cFbqs8EbcdcpC4b2kl2xV37V7+1m4wupw
 fNCBtKh5QSSliF+kUs19D6GG/2pKz0jiOPcvVLgQe1l0cG9oV5AWkPxI2FjCpg1ly0Qp81PIWiR
 33f/w7pxcAwt0ps8ZUvenec46bvNwrTczlX1w/pEWVvS2NGR8Pb9OFyFSFoXzkX9t9Fp5H4L6hh
 IM4AWcVVkKal1cgN81t4UWAEQD+9qg==
X-Authority-Analysis: v=2.4 cv=IJYPywvG c=1 sm=1 tr=0 ts=68f9f0a6 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=6eMFpH33ACt_N_I4TK4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 spamscore=0
 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=sourabhjain@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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



On 21/10/25 19:18, Aditya Gupta wrote:
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
>   hw/ppc/spapr.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
>
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index d40d5a9dcde5..77da8c1b02f5 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -904,6 +904,8 @@ static void spapr_dt_rtas_fadump(SpaprMachineState *spapr, void *fdt, int rtas)
>   {
>       MachineState *ms = MACHINE(spapr);
>       MachineClass *mc = MACHINE_GET_CLASS(ms);
> +    FadumpMemStruct *fdm = &spapr->registered_fdm;
> +    uint16_t dump_status_flag;
>   
>       uint32_t max_possible_cpus = mc->possible_cpu_arch_ids(ms)->len;
>       uint64_t fadump_cpu_state_size = 0;
> @@ -953,6 +955,16 @@ static void spapr_dt_rtas_fadump(SpaprMachineState *spapr, void *fdt, int rtas)
>                       fadump_versions, sizeof(fadump_versions))));
>       _FDT((fdt_setprop(fdt, rtas, "ibm,configure-kernel-dump-sizes",
>                       fadump_rgn_sizes, sizeof(fadump_rgn_sizes))));
> +
> +    dump_status_flag = be16_to_cpu(fdm->header.dump_status_flag);
> +    if (dump_status_flag & FADUMP_STATUS_DUMP_TRIGGERED) {
> +        uint64_t fdm_size =
> +            sizeof(struct FadumpSectionHeader) +
> +            (be16_to_cpu(fdm->header.dump_num_sections) *
> +            sizeof(struct FadumpSection));
> +
> +        _FDT((fdt_setprop(fdt, rtas, "ibm,kernel-dump", fdm, fdm_size)));
> +    }
>   }
>   
>   static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)

LGTM
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

