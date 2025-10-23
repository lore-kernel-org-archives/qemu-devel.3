Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A03CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:18:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtKp-0002LA-2c; Thu, 23 Oct 2025 07:18:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vBtKm-0002BJ-Da; Thu, 23 Oct 2025 07:18:20 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vBtKj-0006L5-0u; Thu, 23 Oct 2025 07:18:20 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N68EwM021232;
 Thu, 23 Oct 2025 11:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=qnOzLG+A4yWbKubDhnECJQgCWHsdIR
 ipdQtCP6oc2jU=; b=YKOr627AuTAC1MitAycEI8bAlXJq+fvHiZreCqLzyCDJKR
 KlXR0jIh9m4c/2qVyvSGHJWcPVh5D6I2PghGGS4wjdWSA7abKQUtThAEBQe6hL3V
 DfvSFnSdwLnE8ZDd8G9olmERHzkDM1gml/asXqOIwL8cE8w8K/7uSxQmiqVzPVtH
 BOji8DaCX6fV00GI5Sxjb+YDDCYfscPlgD78RNYdzcHmhCSkrX69IKARthw+OmSR
 Uch15I4g1tQ+06sEKjflT4nCmDc6f3eG3Aow2+YRKF7HcmimtmHTSQIpIuzq36JX
 Oc9GZPcS/WutkUVHgl1wf6yO88a/oP80tam8k0LA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31cgf83-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:18:14 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59NBG8ba009263;
 Thu, 23 Oct 2025 11:18:14 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31cgf7y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:18:14 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NAU0ES032096;
 Thu, 23 Oct 2025 11:18:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vp7n5c2b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 23 Oct 2025 11:18:13 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com
 [10.20.54.102])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NBI9Ip21627444
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 11:18:09 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D2C620043;
 Thu, 23 Oct 2025 11:18:09 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B31AB20040;
 Thu, 23 Oct 2025 11:17:59 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.124.222.253])
 by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Thu, 23 Oct 2025 11:17:59 +0000 (GMT)
Date: Thu, 23 Oct 2025 16:47:54 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v5 6/8] hw/ppc: Enable fadump for PSeries
Message-ID: <jemz4qnj7ljjfxf4ia76luq5k7dftudrakjdp2ewdc7j5673aj@ubexpabxs4a7>
References: <20251021134823.1861675-1-adityag@linux.ibm.com>
 <20251021134823.1861675-7-adityag@linux.ibm.com>
 <2217b04e-680f-4071-80cd-cde41ff552ae@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2217b04e-680f-4071-80cd-cde41ff552ae@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: S-YQM-ZURIEqKDpC3P-jA8XB_dDatvhW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX2U5HKsg7uYUG
 rCNo0+BYB9EF/WquXY05/WonKPj/3DDrfybQzPpbhsl/HkT0DgbaRYps9fd8VHmyFdDyyX9obDC
 J6jRLXXWFiR5lm8KwWvfuOOIp1qNWT1L9Dn6X72MwnYB1D+QwI5sGxpdttoEJ8LC+uL1afdZ8bd
 0OWcCaYDxLAWial8xKlJjcgKIGrXyOH9OyROpA43Ff1AV90ECTov044zFxfMAL0eBfFmvTd9cGx
 IY8Skqv3bCZt53yeNtIlmx2O+3CJ/XA04E1umpDZb2HMzSwhGWa3tK3Q7BUyeKZL+R7AX62YqAw
 4cZ5woXB6bnQ/lW1ExJc9y0XjrOFdaZvzVSwHyV3ujn1PET5Pbs0/82HQcb1xI4zQt1oLocvcdF
 DrgNT0p+ZsrSdRpvgglR3TsGGpC7ug==
X-Proofpoint-GUID: RRHq5kPG5qW8KFt2w37gi1Lv9A64taKi
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68fa0ef6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=gwc0g8rqIRSIA0_rrhAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=adityag@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On 25/10/23 02:38PM, Sourabh Jain wrote:
> 
> 
> On 21/10/25 19:18, Aditya Gupta wrote:
> > With all support in place for preserving memory regions, enable fadump by
> > exporting the "ibm,kernel-dump" property in the device tree, representing
> > the fadump dump information, in case of a crash.
> > 
> > Currently "ibm,configure-kernel-dump" RTAS call is already registered,
> > which tells the kernel that the platform (QEMU) supports fadump.
> > 
> > Now, in case of a crash, if fadump was registered, we also pass
> > "ibm,kernel-dump" in device tree, which tells the kernel that the fadump
> > dump is active.
> > 
> > Pass "fadump=on" to enable Linux to use firmware assisted dump.
> > 
> > Logs of a linux boot with firmware assisted dump:
> > 
> >      $ ./build/qemu-system-ppc64 -M pseries,x-vof=on --cpu power10 --smp 4 -m 4G -kernel some-vmlinux -initrd some-initrd -append "debug fadump=on crashkernel=1G" -nographic
> > 
> >      [    0.000000] fadump: Reserved 1024MB of memory at 0x00000040000000 (System RAM: 4096MB)
> >      [    0.000000] fadump: Initialized 0x40000000 bytes cma area at 1024MB from 0x400102a8 bytes of memory reserved for firmware-assisted dump
> >      ...
> >      [    1.084686] rtas fadump: Registration is successful!
> >      ...
> >      # cat /sys/kernel/debug/powerpc/fadump_region
> >      CPU :[0x00000040000000-0x000000400013df] 0x13e0 bytes, Dumped: 0x0
> >      HPTE:[0x000000400013e0-0x000000400013df] 0x0 bytes, Dumped: 0x0
> >      DUMP: Src: 0x00000000000000, Dest: 0x00000040010000, Size: 0x40000000, Dumped: 0x0 bytes
> > 
> >      [0x0000000921a000-0x0000000921a7ff]: cmdline append: ''
> >      # echo c > /proc/sysrq-trigger
> > 
> > The fadump boot after crash:
> > 
> >      [    0.000000] rtas fadump: Firmware-assisted dump is active.
> >      [    0.000000] fadump: Updated cmdline: debug fadump=on crashkernel=1G
> >      [    0.000000] fadump: Firmware-assisted dump is active.
> >      [    0.000000] fadump: Reserving 3072MB of memory at 0x00000040000000 for preserving crash data
> >      ....
> >      # file /proc/vmcore
> >      /proc/vmcore: ELF 64-bit LSB core file, 64-bit PowerPC or cisco 7500, OpenPOWER ELF V2 ABI, version 1 (SYSV), SVR4-style
> > 
> > Analysing the vmcore with crash-utility:
> > 
> >            KERNEL: vmlinux-6.14-rc2
> >          DUMPFILE: vmcore-fc92fb373aa0
> >              CPUS: 4
> >              DATE: Wed Mar 12 23:39:23 CDT 2025
> >            UPTIME: 00:00:22
> >      LOAD AVERAGE: 0.13, 0.03, 0.01
> >             TASKS: 95
> >          NODENAME: buildroot
> >           RELEASE: 6.12.0-rc4+
> >           VERSION: #1 SMP Fri Jan  3 00:15:17 IST 2025
> >           MACHINE: ppc64le  (1000 Mhz)
> >            MEMORY: 4 GB
> >             PANIC: "Kernel panic - not syncing: sysrq triggered crash"
> >               PID: 269
> >           COMMAND: "sh"
> >              TASK: c00000000a050b00  [THREAD_INFO: c00000000a050b00]
> >               CPU: 0
> >             STATE: TASK_RUNNING (PANIC)
> > 
> > Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
> > ---
> >   hw/ppc/spapr.c | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> > 
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index d40d5a9dcde5..77da8c1b02f5 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -904,6 +904,8 @@ static void spapr_dt_rtas_fadump(SpaprMachineState *spapr, void *fdt, int rtas)
> >   {
> >       MachineState *ms = MACHINE(spapr);
> >       MachineClass *mc = MACHINE_GET_CLASS(ms);
> > +    FadumpMemStruct *fdm = &spapr->registered_fdm;
> > +    uint16_t dump_status_flag;
> >       uint32_t max_possible_cpus = mc->possible_cpu_arch_ids(ms)->len;
> >       uint64_t fadump_cpu_state_size = 0;
> > @@ -953,6 +955,16 @@ static void spapr_dt_rtas_fadump(SpaprMachineState *spapr, void *fdt, int rtas)
> >                       fadump_versions, sizeof(fadump_versions))));
> >       _FDT((fdt_setprop(fdt, rtas, "ibm,configure-kernel-dump-sizes",
> >                       fadump_rgn_sizes, sizeof(fadump_rgn_sizes))));
> > +
> > +    dump_status_flag = be16_to_cpu(fdm->header.dump_status_flag);
> > +    if (dump_status_flag & FADUMP_STATUS_DUMP_TRIGGERED) {
> > +        uint64_t fdm_size =
> > +            sizeof(struct FadumpSectionHeader) +
> > +            (be16_to_cpu(fdm->header.dump_num_sections) *
> > +            sizeof(struct FadumpSection));
> > +
> > +        _FDT((fdt_setprop(fdt, rtas, "ibm,kernel-dump", fdm, fdm_size)));
> > +    }
> >   }
> >   static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
> 
> LGTM
> Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

Thanks for all your reviews Sourabh !


