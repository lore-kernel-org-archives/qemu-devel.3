Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15CFEF3718
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 08:57:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzWPx-0001p5-MO; Mon, 09 Mar 2026 04:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1vzWPr-0001n4-Al; Mon, 09 Mar 2026 04:56:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1vzWPd-0001Ox-6p; Mon, 09 Mar 2026 04:56:39 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 628KY7Ww1649593; Mon, 9 Mar 2026 08:56:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=BBBXhRP4CoQ1+bSAhNFHY58VV6nNbR
 OGKuqcakzbYpw=; b=DVmtsQ4GRxXbrhWUEI9w6mAxH19alzPBSI+1JEt8cf5Or/
 SqXqgJG34mGL9WLGf+fpE+IafTGHM0dk9bt33e1SrZW80D1I9NYqIAeIEEdQULi/
 9lY94ECDs6CIYWSziRLiDhHcAVfBHmANzQEXw3RoZG9FTNnHkL/N37Lx68OuPevJ
 CjncDtdAXwEikKNkyw6WD+zFrvirknRyQLh7Y0CfkTGoL1dUAiPAOby6yQLe/8z1
 4YnCca5dnSSdzg5204HyWJhQ7KyYgwJnDzYGUYjwQJZvzTegMXZIgLtcSR1tXjwp
 Gn79EP4wjaXwYxRZqsL2cKPS4Fx5Yg9BA9iPgDyg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvm5t9k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 08:56:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6295Zd1M025052;
 Mon, 9 Mar 2026 08:56:20 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs0jjv3dv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 08:56:20 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6298uGvt33882504
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2026 08:56:17 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D62012004B;
 Mon,  9 Mar 2026 08:56:16 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F32D720040;
 Mon,  9 Mar 2026 08:56:14 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.79.204.232])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon,  9 Mar 2026 08:56:14 +0000 (GMT)
Date: Mon, 9 Mar 2026 14:26:12 +0530
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Hari Bathini <hbathini@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Miles Glenn <milesg@linux.ibm.com>, Chinmay Rath <rathc@linux.ibm.com>
Subject: Re: [PATCH v4 00/10] Implement MPIPL for PowerNV
Message-ID: <qowkbzfxurfejfbecky4nwhgck7hs45dsq66sdxyp23od5plcd@h67km3gfkfzz>
References: <20260309072001.3136261-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309072001.3136261-1-adityag@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: bOfyBed9b_ymv9GTMyaptBBP-99gSKSz
X-Proofpoint-ORIG-GUID: EUp4sDt3BeqIijQtspHmTA4Q5iVYJcT0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA3OCBTYWx0ZWRfXxTkhtUbEntCI
 kXSy+rSylqCsTsd1XvhD/AgcOOf6Spib17rKEIDzfBAfdGOUFUqtrbdUFVtksfSZec1luUa4SNg
 kLIFnEiBMJR5BCjmmAA7QaIl4PFk3x0eUTHYIuKOJLg/TcvPTm9Nd8BtRcShqYPa0yMqDJs01KQ
 DD/m7eOd1mc2ewgq5x/80ELk9HdhS8XtSwZFCCks07hmectz278mORd4OM54b1HIjo/Lk0S0Rhl
 pjUAIEe1RMkizU+LJVjEAtOEIambpPCXKh/MOBISaIhPXRUDjZ8yv3QimcwFNeaqvkqf/nLvwIG
 CI1aWhReVaLkNpmYzQbUMKSgx2C5N+RLEkiaJ/214u3chsQr9MPmKU/nZ8Bhzlg8phk6buziU1J
 KqGgwkECDG/HKbQq+DSNpcQKk3aj/hmO5mEiV1JBvvRQeFOeASnbIXJrA+X0nIWAhaGuZGSDvF7
 X6cxjyd1D8uCwF0Q3aA==
X-Authority-Analysis: v=2.4 cv=B5q0EetM c=1 sm=1 tr=0 ts=69ae8b36 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=p0WdMEafAAAA:8
 a=VnNF1IyMAAAA:8 a=hSWd8L_6iOwG8_bK90wA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_03,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603090078
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

On Mon, Mar 09, 2026 at 12:49:49PM +0530, Aditya Gupta wrote:
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
> 1. Git tree for testing: https://gitlab.com/adi-g15-ibm/qemu/tree/fadump-powernv-v4
> 
> 2. Gitlab pipeline: https://gitlab.com/adi-g15-ibm/qemu/-/pipelines/2372098708
> 
> 3. Analysing generated vmcore:
> 
> 	# ls -lh /proc/vmcore 
> 	-r--------    1 root     root        4.5G Feb 25 07:33 /proc/vmcore
> 	# file /proc/vmcore 
> 	/proc/vmcore: ELF 64-bit LSB core file, 64-bit PowerPC or cisco 7500, OpenPOWER ELF V2 ABI, version 1 (SYSV), SVR4-style
> 
> 	# crash vmlinux vmcore
> 	...
> 	      KERNEL: vmlinux-38fec10eb60d-network      
> 	    DUMPFILE: vmcore-powernv-25feb26
> 	        CPUS: 4
> 	        DATE: Thu Jan  1 05:30:00 IST 1970
> 	      UPTIME: 00:05:23
> 	LOAD AVERAGE: 0.12, 0.08, 0.03
> 	       TASKS: 101
> 	    NODENAME: buildroot
> 	     RELEASE: 6.14.0
> 	     VERSION: #1 SMP Thu Apr  3 08:06:13 CDT 2025
> 	     MACHINE: ppc64le  (1000 Mhz)
> 	      MEMORY: 6 GB
> 	       PANIC: "Kernel panic - not syncing: sysrq triggered crash"
> 	         PID: 257
> 	     COMMAND: "sh"
> 	        TASK: c000000008066600  [THREAD_INFO: c000000008066600]
> 	         CPU: 2
> 	       STATE: TASK_RUNNING (PANIC)
> 
> 	crash> # ps and kmem -i works
> 
Hi Aditya,

I was able to get the fadump working on buildroot images, with this.
Thanks for this feature.

	Welcome to Buildroot
	buildroot login: root
	# dmesg | grep fadump
	[    0.000000][    T0] opal fadump: Kernel metadata addr: 653902a8
	[    0.000000][    T0] fadump: Reserved 768MB of memory at 0x00000035390000 (System RAM: 8192MB)
	[    0.000000][    T0] fadump: Initialized [0x36000000, 752MB] cma area from [0x35390000, 768MB] bytes of memory reserved for firmware-assisted dump
	[    0.000000][    T0] Kernel command line: console=hvc0 rootwait root=/dev/nvme0n1 fadump=on
	[    0.377005][    T1] opal fadump: Registration is successful!
	# uname -r
	6.19.6

	 <snip/>

	Welcome to Buildroot
	buildroot login: root
	# ls /proc/vmcore
	/proc/vmcore
	# ls -alh /proc/vmcore
	-r--------    1 root     root        4.3G Mar  8 17:08 /proc/vmcore


Tested-by: Shivang Upadhyay <shivangu@linux.ibm.com>

~Shivang.

