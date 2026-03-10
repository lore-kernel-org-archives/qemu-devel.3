Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0419EB1057
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 14:13:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzxpQ-0004ps-3X; Tue, 10 Mar 2026 10:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1vzxpL-0004pA-DS; Tue, 10 Mar 2026 10:12:52 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1vzxpI-0004jb-LL; Tue, 10 Mar 2026 10:12:51 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62ABVutO1764289; Tue, 10 Mar 2026 14:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=9yaVWQv2AGsUC3TwGnbiINItKheQ1c
 8cBOpWV2x78Cs=; b=lSl7k5lUnZtwQqCQDKmwqURYeBhT1m4j5jEQYgIx6mXfYm
 U1ZLJcqmZZ3KWjcukiAitwSzBQraCX8sN1BU4il2K8srONa85FNlvUumppinknSk
 t+7L47V9Oz/l9bEeEgoyywp3l2eOBWd/66Ue8ozct3JIk2Rggkl4bgebj68limxl
 hjQ0AZMZ4xaifyThBtqAbI0aX2LSp7XKMb/31Dd4V1yLgRa9IcmpeeYA9g18e07N
 m2OVnMVVHY7yBlDs3D8WStA+ffIIElKsYwg7Jz0SWOI1/dqmwOQC+lCDB0NZPQYI
 pMYVq7fcrjnK02xUSW45VZpij07yGT2vylQh4qYA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcuyb73t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 14:12:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62ABCFVP021365;
 Tue, 10 Mar 2026 14:12:43 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4crxbsshx3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 14:12:43 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62AECeVk29688200
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 14:12:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3B1AC2004E;
 Tue, 10 Mar 2026 14:12:40 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 21BD620043;
 Tue, 10 Mar 2026 14:12:38 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.79.204.232])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Tue, 10 Mar 2026 14:12:37 +0000 (GMT)
Date: Tue, 10 Mar 2026 19:42:35 +0530
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>
Subject: Re: [PATCH v5 00/10] Implement MPIPL for PowerNV
Message-ID: <abAmBV7g_bGNw0Ax@shivang.upadyay>
References: <20260310124619.3909045-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310124619.3909045-1-adityag@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EK4LElZC c=1 sm=1 tr=0 ts=69b026dc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=p0WdMEafAAAA:8
 a=VnNF1IyMAAAA:8 a=hSWd8L_6iOwG8_bK90wA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEyMiBTYWx0ZWRfX8Oic9HGL76dC
 mSXz+gj7MwWbJCYtmwKPrMDUAGPQXO1aCccfk7D7IOQzRH+Z/PHA8l1RkiSnB7BXQ3gMQtJKKIK
 3wiiAoVkXONiRVr5K20X+6Moc8kv7NQT712cH6RkB5x9FeoSp8IBch1t4gO5UgMkw0twWsnEmTD
 UADUbNhXMXCWnYHXk41rBX4vxax8hY17lsvvUGCtCitEdelQwef6XyeQCEFUCWE2eV9jhA27mxg
 udmaqVkAQDQgdCWqF6d4xHFaLOsCg2o6nOl5aVMoRinNnIGaaX3BWngNG9zcKnIKayB1USNumxG
 5NjNIxOdwZW8W/Rofxb8SpaYUXLyTdEPV3kPFp6wC4SUm0kCUlRsDN5bv0pQG6z1VgfM6lFzinJ
 hjuhyt1q77h5Ycv1iSXyC/TEksQ0/AFg+9Xky7gSMPw1Wf5xtcyV12sN3QWqP7PiQ+97EGC6dFo
 Xgnx4Iay1zAug1ABFTQ==
X-Proofpoint-GUID: gFCxKgW4leMx-oWP3oTufUMensEQt6MR
X-Proofpoint-ORIG-GUID: leOVdiTHlaqPeKGPWnOJkhoPw4IZFl8G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100122
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Mar 10, 2026 at 06:16:07PM +0530, Aditya Gupta wrote:
> Overview
> =========
> 
> Implemented MPIPL (Memory Preserving IPL, aka fadump) on PowerNV machine
> in QEMU.
> 
> Fadump is an alternative dump mechanism to kdump, in which we the firmware
> does a memory preserving boot, and the second/crashkernel is booted fresh
> like a normal system reset, instead of the crashed kernel loading the
> second/crashkernel in case of kdump.
> 
> MPIPL in PowerNV, is similar to fadump in Pseries. The idea is same, memory
> preserving, where in PowerNV we are assisted by SBE (Self Boot Engine) &
> Hostboot, while in Pseries we are assisted by PHyp (Power Hypervisor)
> 
> For implementing in baremetal/powernv QEMU, we need to export a
> "ibm,opal/dump" node in the device tree, to tell the kernel we support
> MPIPL
> 
> Once kernel sees the support, and "fadump=on" is passed on commandline,
> kernel will register memory regions to preserve with Skiboot.
> 
> Kernel sends these data using OPAL calls, after which skiboot/opal saves
> the memory region details to MDST and MDDT tables (S-source, D-destination)
> 
> Then in the event of a kernel crash, the kernel initiates MPIPL with another
> OPAL code (opal_cec_reboot2), this request goes to Skiboot.
> Skiboot then triggers the "S0 Interrupt" to the SBE (Self Boot Engine),
> along with OPAL's relocated base address.
> 
> SBE then stops all core clocks, and only does particular ISteps for a
> memory preserving boot.
> 
> Then, hostboot comes up, and with help of the relocated base address, it
> accesses MDST & MDDT tables (S-source and D-destination), and preserves the
> memory regions according to the data in these tables.
> And after preserving, it writes the preserved memory region details to MDRT
> tables (R-Result), for the kernel to know where/whether a memory region is
> preserved.
> 
> Both SBE's and hostboot responsiblities are implemented in the SBE code
> in QEMU.
> 
> Then in the second kernel/crashkernel boot, OPAL passes the "mpipl-boot"
> property for the kernel to know that a dump is active, which kernel then
> exports in /proc/vmcore
> 
> Testing
> ====================
> 
> 1. Git tree for testing: https://gitlab.com/adi-g15-ibm/qemu/tree/fadump-powernv-v5
> 
> 2. Gitlab pipeline: https://gitlab.com/adi-g15-ibm/qemu/-/pipelines/2375470651
> 
> 3. Analysing generated vmcore:
> 
> 	# ls -lh /proc/vmcore
> 	-r--------    1 root     root        4.5G Mar 10 12:30 /proc/vmcore
> 
> 	# file /proc/vmcore
> 	/proc/vmcore: ELF 64-bit LSB core file, 64-bit PowerPC or cisco 7500, OpenPOWER ELF V2 ABI, version 1 (SYSV), SVR4-style
> 
> 	# crash vmlinux-38fec10eb60d-network vmcore-powernv-10mar26
> 	...
> 	      KERNEL: vmlinux-38fec10eb60d-network
> 	    DUMPFILE: vmcore-powernv-10mar26
> 	        CPUS: 2
> 	        DATE: Thu Jan  1 05:30:00 IST 1970
> 	      UPTIME: 00:00:50
> 	LOAD AVERAGE: 0.57, 0.19, 0.07
> 	       TASKS: 83
> 	    NODENAME: buildroot
> 	     RELEASE: 6.14.0
> 	     VERSION: #1 SMP Thu Apr  3 08:06:13 CDT 2025
> 	     MACHINE: ppc64le  (1000 Mhz)
> 	      MEMORY: 6 GB
> 	       PANIC: "Kernel panic - not syncing: sysrq triggered crash"
> 	         PID: 238
> 	     COMMAND: "sh"
> 	        TASK: c00000000a0f3200  [THREAD_INFO: c00000000a0f3200]
> 	         CPU: 0
> 	       STATE: TASK_RUNNING (PANIC)
> 
> 	crash> # ps and kmem -i works
buildroot fadump test and `make check-functional-ppc64` are passing on V5.

	Welcome to Buildroot
	buildroot login: root
	# dmesg | grep fadump
	[    0.000000][    T0] opal fadump: Kernel metadata addr: 653902a8
	[    0.000000][    T0] fadump: Reserved 768MB of memory at 0x00000035390000 (System RAM: 5120MB)
	[    0.000000][    T0] fadump: Initialized [0x36000000, 752MB] cma area from [0x35390000, 768MB] bytes of memory reserved for firmware-assisted dump
	[    0.000000][    T0] Kernel command line: console=hvc0 rootwait root=/dev/nvme0n1 fadump=on
	[    0.473711][    T1] opal fadump: Registration is successful!
	# echo c > /proc/sysrq-trigger

	<snip />

	Welcome to Buildroot
	buildroot login: root
	# ls -alh /proc/vmcore
	-r--------    1 root     root        4.3G Mar 10 14:07 /proc/vmcore
	#


	> make check-functional-ppc64
	<snip />
	16/16 func-thorough+func-ppc64-thorough+thorough - qemu:func-ppc64-fadump                OK               65.42s   2 subtests passed

	Ok:                9
	Fail:              0
	Skipped:           7


Tested-by: Shivang Upadhyay <shivangu@linux.ibm.com>


~Shivang.

