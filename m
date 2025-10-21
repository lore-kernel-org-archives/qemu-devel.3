Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1C1CCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 13:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBCjW-0002DI-Gz; Tue, 21 Oct 2025 09:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vBCjU-00029f-7a; Tue, 21 Oct 2025 09:49:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vBCjS-0006pu-98; Tue, 21 Oct 2025 09:48:59 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L63tU3023364;
 Tue, 21 Oct 2025 13:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=dvuOvQ/G4kRwIdzue
 65rg25T9o5h4YkXezeMhpf5fwk=; b=dsrrL/YJLTw5A3efNEjIFTkg6Jr7NrxVR
 zc5pRDiVo6zUQrwF4ormr6k45DGgmVFHRjL6q2uuPQpNtoVn7pCDVsDZzEVUsMV4
 JoMbNl+p4xc6goyO2P3yU33atA5Z0AojNGkllLwzKQfhX7X2YlILqFhXR1wPl1bi
 MZTvWvVJe7H68ifpmdJMCpNdaWbEpZOzEolm4oM8ivKejepfVKJSQEmks67WOwQK
 W3CwxYiXGldnthZEwkum0u9HNVHTl5blbdp5zbmTqkyOe9cxctXreUe8sb4jZbKz
 teT521M5SpKZSw52tmt9r6f6BgdEe/PKtkus4IGDybaJq/A/6IURQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vnym0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 13:48:56 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59LDi5XL004530;
 Tue, 21 Oct 2025 13:48:56 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v30vnykw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 13:48:55 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59LCvcow011075;
 Tue, 21 Oct 2025 13:48:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vqx12r10-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Oct 2025 13:48:55 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59LDmp0813697534
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 Oct 2025 13:48:51 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 517F72005A;
 Tue, 21 Oct 2025 13:48:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5E5032004D;
 Tue, 21 Oct 2025 13:48:48 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com.com (unknown
 [9.124.222.96]) by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 Oct 2025 13:48:48 +0000 (GMT)
From: Aditya Gupta <adityag@linux.ibm.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 6/8] hw/ppc: Enable fadump for PSeries
Date: Tue, 21 Oct 2025 19:18:16 +0530
Message-ID: <20251021134823.1861675-7-adityag@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021134823.1861675-1-adityag@linux.ibm.com>
References: <20251021134823.1861675-1-adityag@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XxUICkWswyErCRxZb8_DeyIiWN3xbuBx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX+37sygYKK5i7
 2Sipzr6u5qGEDdL9X2kqx/thdG0xFjgVV1DdqU6roAE1rbqAZzkGhyaFJ0GfXPo5cfuKc8T+mdF
 QwKdeBSy5l5WhyTbDNJdHgbI48mE8NoeQnDp2if8Z2wZnaJiTWoqA4ZkEXppZVMjN1PWDNJmflg
 ASQWMiumnU9Y2BRgf6PLdsj8jPqZz85w5SD/KkRbMADacSs6jtcGw6oo3xe0gZcuPjrKzZguiNV
 V4fue3SDoJ6yjOjP2f8S8cIjCIP8nDKtfyUFkK+vYbxopYj/ci9bKy/ejgrUfoTW/H1iIwyyMEd
 9ZnRdNCQuRty3/7m4/8xRG1PBbmW6bIsszqotoEpc7YrMURomWxzsuf+rWdcJxOtUzOvaQQFtBc
 PXpxclpJ0pFKFXV0dqU3jmjJbYJlzw==
X-Authority-Analysis: v=2.4 cv=MIJtWcZl c=1 sm=1 tr=0 ts=68f78f48 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=8CxyIfRdMog4hT9rIj0A:9
X-Proofpoint-ORIG-GUID: YBBq9OfG_mDOoicZvVqVZ_SM0dKawCPu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_02,2025-10-13_01,2025-03-28_01
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

With all support in place for preserving memory regions, enable fadump by
exporting the "ibm,kernel-dump" property in the device tree, representing
the fadump dump information, in case of a crash.

Currently "ibm,configure-kernel-dump" RTAS call is already registered,
which tells the kernel that the platform (QEMU) supports fadump.

Now, in case of a crash, if fadump was registered, we also pass
"ibm,kernel-dump" in device tree, which tells the kernel that the fadump
dump is active.

Pass "fadump=on" to enable Linux to use firmware assisted dump.

Logs of a linux boot with firmware assisted dump:

    $ ./build/qemu-system-ppc64 -M pseries,x-vof=on --cpu power10 --smp 4 -m 4G -kernel some-vmlinux -initrd some-initrd -append "debug fadump=on crashkernel=1G" -nographic

    [    0.000000] fadump: Reserved 1024MB of memory at 0x00000040000000 (System RAM: 4096MB)
    [    0.000000] fadump: Initialized 0x40000000 bytes cma area at 1024MB from 0x400102a8 bytes of memory reserved for firmware-assisted dump
    ...
    [    1.084686] rtas fadump: Registration is successful!
    ...
    # cat /sys/kernel/debug/powerpc/fadump_region
    CPU :[0x00000040000000-0x000000400013df] 0x13e0 bytes, Dumped: 0x0
    HPTE:[0x000000400013e0-0x000000400013df] 0x0 bytes, Dumped: 0x0
    DUMP: Src: 0x00000000000000, Dest: 0x00000040010000, Size: 0x40000000, Dumped: 0x0 bytes

    [0x0000000921a000-0x0000000921a7ff]: cmdline append: ''
    # echo c > /proc/sysrq-trigger

The fadump boot after crash:

    [    0.000000] rtas fadump: Firmware-assisted dump is active.
    [    0.000000] fadump: Updated cmdline: debug fadump=on crashkernel=1G
    [    0.000000] fadump: Firmware-assisted dump is active.
    [    0.000000] fadump: Reserving 3072MB of memory at 0x00000040000000 for preserving crash data
    ....
    # file /proc/vmcore
    /proc/vmcore: ELF 64-bit LSB core file, 64-bit PowerPC or cisco 7500, OpenPOWER ELF V2 ABI, version 1 (SYSV), SVR4-style

Analysing the vmcore with crash-utility:

          KERNEL: vmlinux-6.14-rc2
        DUMPFILE: vmcore-fc92fb373aa0
            CPUS: 4
            DATE: Wed Mar 12 23:39:23 CDT 2025
          UPTIME: 00:00:22
    LOAD AVERAGE: 0.13, 0.03, 0.01
           TASKS: 95
        NODENAME: buildroot
         RELEASE: 6.12.0-rc4+
         VERSION: #1 SMP Fri Jan  3 00:15:17 IST 2025
         MACHINE: ppc64le  (1000 Mhz)
          MEMORY: 4 GB
           PANIC: "Kernel panic - not syncing: sysrq triggered crash"
             PID: 269
         COMMAND: "sh"
            TASK: c00000000a050b00  [THREAD_INFO: c00000000a050b00]
             CPU: 0
           STATE: TASK_RUNNING (PANIC)

Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>
---
 hw/ppc/spapr.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d40d5a9dcde5..77da8c1b02f5 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -904,6 +904,8 @@ static void spapr_dt_rtas_fadump(SpaprMachineState *spapr, void *fdt, int rtas)
 {
     MachineState *ms = MACHINE(spapr);
     MachineClass *mc = MACHINE_GET_CLASS(ms);
+    FadumpMemStruct *fdm = &spapr->registered_fdm;
+    uint16_t dump_status_flag;
 
     uint32_t max_possible_cpus = mc->possible_cpu_arch_ids(ms)->len;
     uint64_t fadump_cpu_state_size = 0;
@@ -953,6 +955,16 @@ static void spapr_dt_rtas_fadump(SpaprMachineState *spapr, void *fdt, int rtas)
                     fadump_versions, sizeof(fadump_versions))));
     _FDT((fdt_setprop(fdt, rtas, "ibm,configure-kernel-dump-sizes",
                     fadump_rgn_sizes, sizeof(fadump_rgn_sizes))));
+
+    dump_status_flag = be16_to_cpu(fdm->header.dump_status_flag);
+    if (dump_status_flag & FADUMP_STATUS_DUMP_TRIGGERED) {
+        uint64_t fdm_size =
+            sizeof(struct FadumpSectionHeader) +
+            (be16_to_cpu(fdm->header.dump_num_sections) *
+            sizeof(struct FadumpSection));
+
+        _FDT((fdt_setprop(fdt, rtas, "ibm,kernel-dump", fdm, fdm_size)));
+    }
 }
 
 static void spapr_dt_rtas(SpaprMachineState *spapr, void *fdt)
-- 
2.51.0


