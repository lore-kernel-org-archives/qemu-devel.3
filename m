Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D995ACCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 11:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBtky-0002Pb-Kx; Thu, 23 Oct 2025 07:45:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtkq-0001ru-C3
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:45:16 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <harshpb@linux.ibm.com>)
 id 1vBtkn-0001ql-3t
 for qemu-devel@nongnu.org; Thu, 23 Oct 2025 07:45:15 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59N4v8qm025774
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 11:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=re1vd8/1Y7prOt3uK
 PfK5x3KjnvSzaWw1Duzi0t8l50=; b=pbKVbH5i8VmcZHnC7ujKj6PFPhuevNEvc
 eSKTLZ3qM3/v8YUjJcFp+8FTWhC2Mdrz2guE1XFG10LHIeFl1ZGq4nT78mTD/kka
 Su6ExVzIyBGkyblmts8gvRdDTVWWRnN9Aysz2s6Vyz5ZYI0MEGcApcNDAUS5AVCn
 PT5AdjUXoDs+eOy45FTPcP3qMLlTgSbw+DqJOGWtan7cGazozS/P+SgreD3I+tx5
 3JKRDnvu/SQSUjg60hQIJUpVA26gGyUo/VO3P42JVZUY5e7J7UlO+lni7KfDxz7g
 SVM4fO6uV2mlQwTMHiFao019BBr5jZlfbzWMrLT2vFRmTaqbm5i6A==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v32hrcq6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 11:45:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59NAgTRg024953
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 11:45:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqk5dtu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Oct 2025 11:45:11 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59NBj7JN21299748
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Oct 2025 11:45:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E3512004B;
 Thu, 23 Oct 2025 11:45:07 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2124020040;
 Thu, 23 Oct 2025 11:45:06 +0000 (GMT)
Received: from li-1901474c-32f3-11b2-a85c-fc5ff2c001f3.ibm.com.com (unknown
 [9.124.221.73]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 23 Oct 2025 11:45:05 +0000 (GMT)
From: Harsh Prateek Bora <harshpb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Aditya Gupta <adityag@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Shivang Upadhyay <shivangu@linux.ibm.com>
Subject: [PULL 30/32] hw/ppc: Enable fadump for PSeries
Date: Thu, 23 Oct 2025 17:14:17 +0530
Message-ID: <20251023114422.3675018-31-harshpb@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20251023114422.3675018-1-harshpb@linux.ibm.com>
References: <20251023114422.3675018-1-harshpb@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXwQXTUQ3adSN9
 tLvz/t8C6NQxPsSXtXDDVaJWQwRSVptYGT2MSp7p1TDuGiBM9PIVGeBr1XP0wiZXYiHTUvzdm+b
 EGVCGQbYVTN4Mn0EoLNJeBSxbpnK5zm7eMS6n3vtCRw8T+AAUKEA6ocLYSVraMLefKyNMM6K8mw
 tzGXbQ4+Iy1TEOrIeM8WUq7lWEV4Dr5DxtMQZFxdrZJzuTRc3rkodhpb0QCXp1/L6K4uV5xtI87
 DiqvlDESiFBy4FGpGDG8OANimP9SarOxxSki/XPOOcuJrPdvi0Z5ylQAzKCq+/vXCc7brIRON1E
 7dFkMXpD//sDsHaF6cB677MyGFXmY1fcoyhh9gmVvHsxnzZzBprgPcnn59uesLGt5rFtLjRQujK
 bqHD1dQ4Tb9ERK2zD/hDTJh+Xk4/3A==
X-Authority-Analysis: v=2.4 cv=OrVCCi/t c=1 sm=1 tr=0 ts=68fa1548 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=f7IdgyKtn90A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=B08fgxTpJCymiiQPXHEA:9
 a=oH34dK2VZjykjzsv8OSz:22 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-GUID: dytGWCsjOBcSx9L4y_U4OHyRabhKFsT4
X-Proofpoint-ORIG-GUID: dytGWCsjOBcSx9L4y_U4OHyRabhKFsT4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022
Received-SPF: pass client-ip=148.163.158.5; envelope-from=harshpb@linux.ibm.com;
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

From: Aditya Gupta <adityag@linux.ibm.com>

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
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Tested-by: Shivang Upadhyay <shivangu@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20251021134823.1861675-7-adityag@linux.ibm.com
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
---
 hw/ppc/spapr.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d6cfb9acbc..6764730beb 100644
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
2.43.5


