Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7772FCC9DB
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 08:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzsdD-0002Ek-Gg; Tue, 10 Mar 2026 04:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misanjum@linux.ibm.com>)
 id 1vzsdB-0002EF-Ck; Tue, 10 Mar 2026 04:39:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misanjum@linux.ibm.com>)
 id 1vzsd9-0003R3-K3; Tue, 10 Mar 2026 04:39:57 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62A7xZeq1275175; Tue, 10 Mar 2026 08:39:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=uMouKE
 GR53M/HoRxURDFB2da4xEFZqMiQEnLwR47YbY=; b=QzZ2xOmZBLEleiLrudNxoH
 aaEdzl572dkX5MQg1gVxEFiRupDNBZDCiVEoofNghw25jmQtyZtGrUIOuM3nTYUB
 caQEHt47otXHR4n4EmWdVcvbmfWun2Q7xnA/WmmBWpIkTbMA81HrO+TffQj3SLQM
 FKWs+SZDTf63hgTWmPUlhqMqiijL3kphZJnwy0co/UVPZHyFDq8Ywop6EYjDITf/
 l3sb4Iiqc0NCC5t1i00l3HtzhBGGey3uxM54nZuHOiA2H2xtMNLPFAixQAFcB5VL
 MBl88fbmg0ONEShe4QoHq3U/inCqixTYdoJMhBjhWhODYUIfuapNqdVeLRIIAzsw
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvr9sc9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 08:39:51 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62A6CD5j023481;
 Tue, 10 Mar 2026 08:39:51 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ct8ng19hh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 08:39:51 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62A8doZN7471618
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 08:39:51 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9CB6758068;
 Tue, 10 Mar 2026 08:39:50 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 428DE5805D;
 Tue, 10 Mar 2026 08:39:50 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Mar 2026 08:39:50 +0000 (GMT)
MIME-Version: 1.0
Date: Tue, 10 Mar 2026 14:09:49 +0530
From: Misbah Anjum N <misanjum@linux.ibm.com>
To: Ani Sinha <anisinha@redhat.com>, Pbonzini <pbonzini@redhat.com>, Qemu
 Devel <qemu-devel@nongnu.org>, Qemu Ppc <qemu-ppc@nongnu.org>
Cc: npiggin@gmail.com, Harshpb <harshpb@linux.ibm.com>
Subject: Re: [BUG] [powerpc] KVM guest boot failure - hangs on startup after
 commit 98884e0c
In-Reply-To: <e966c053-2e69-b185-532e-fcb4173b4daf@redhat.com>
References: <e0fa0840fa7758499aa8c64a148e5367@linux.ibm.com>
 <2cc23a5ce64847dd8a9278c87f58119b@linux.ibm.com>
 <5bc7997d-329e-47a9-9b4d-750a3104094a@linux.ibm.com>
 <4797B580-7853-490E-8852-B6312619FE95@redhat.com>
 <e966c053-2e69-b185-532e-fcb4173b4daf@redhat.com>
Message-ID: <b088f554af34cbcc4d88271e227074e1@linux.ibm.com>
X-Sender: misanjum@linux.ibm.com
Organization: IBM
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA3MSBTYWx0ZWRfXzIFZpDPV9n9X
 cQ8IHDJrlNJ5+/EANTT4++fd5gQF7Bg6w2onvcKN4QmY7iXqw1nJiYeUggDE2I9mqSwJr1dw+fr
 sPZg0YuL8GNp1rdCVGlu/X04WZ2f+yPXnAIyWKK+hAOChvwTGSFQ7E0avvuEmxF1oLhTFKZK5Gz
 j5AfKpCg8zhCPBnLnlsGfX3dUs6kdK3vynHnwEBYqLlv0CvoCG1OJ5WTElx9mc2f0RKffSXXgaR
 3AkF2s8UQXUB0djaHw1qYod3WklkARqtC/NEdsQ3vvcDjW0SF4moGcW+f3uHu+N7UDM0O3ycOqb
 yZlUQgCVFRMMV2/CR7uoVaZyuRhsYwiHXIHtrMxWe86F4OyAiaJGLgJi8v1OaHPG7Y3ncZ24cW4
 rDz/Fp6FaAEB57TWX1zh5QEIYBxgAQzYzu9INWRUuieZoCVBuks/wzgBFAW2NOmTv+pwOhO6VHw
 9eTJ9OIKQ13GsuTAFrw==
X-Proofpoint-GUID: bKMyIOlKdatxtq0Fas0r2zqDY-7uekhJ
X-Proofpoint-ORIG-GUID: r1U6irR30eNpMmgTfiTqKkbq8R4QYnsS
X-Authority-Analysis: v=2.4 cv=QoFTHFyd c=1 sm=1 tr=0 ts=69afd8d8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=3Sbswig0Dp_GqtFDjRYA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603100071
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=misanjum@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
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

Hi Ani and Paolo,

We have tested the code by applying both the original commit 
(98884e0cc10997a17ce9abfd6ff10be19224ca6a) and your fix patch (commit 
9e5a6945181d4c1fce7f8438e1b6213f1eb79c14) on ppc64le.
However, the issue persists. We've conducted GDB debugging that shows 
the hang is occurring in a different location than what the fix 
addresses.

Since the original patch is breaking KVM guest bringup completely on 
ppc64le, and the fix patch does not resolve the issue, given the 
severity of this regression (complete KVM breakage on ppc64le), we 
should either find a quick fix or consider reverting the patch until a 
proper solution can be identified.

Analysis:
1. This is not a confidential guest. This is a regular KVM guest running 
on ppc64le.
2. The execution flow shows that qemu_system_reset() completes 
successfully and never enters the code path at line 529-543
3. The hang occurs later in qemu_default_main() at system/main.c:49, 
after calling bql_lock()
4. The ppc KVM guest boots fine with the previous commit - 
df8df3cb6b743372ebb335bd8404bc3d748da350
5. This suggests the issue is not with error handling of -EOPNOTSUPP 
during reset, but bql_lock() getting stuck in qemu_default_main()

GDB Trace Analysis:
We set breakpoints at qemu_system_reset() and qemu_default_main() to 
trace the execution flow. The system successfully completes 
qemu_system_reset() without entering the problematic code path where the 
fix provided by you applies (system/runstate.c:529-543).

# gdb --args /usr/bin/qemu-system-ppc64 -name avocado-vt-vm1 -machine 
pseries,accel=kvm -enable-kvm -m 32768 -smp 
32,sockets=1,cores=32,threads=1 -nographic -serial pty -device 
virtio-balloon -device virtio-scsi-pci,id=scsi0 -drive 
file=/home/kvmci/tests/data/avocado-vt/images/rhel8.0devel-ppc64le.qcow2,if=none,id=drive-scsi0-0-0,format=qcow2 
-device scsi-hd,bus=scsi0.0,drive=drive-scsi0-0-0 -netdev 
bridge,id=net0,br=virbr0 -device virtio-net-pci,netdev=net0

(gdb) handle SIGUSR1 pass nostop noprint
Signal        Stop	Print	Pass to program	Description
SIGUSR1       No	No	Yes		User defined signal 1
(gdb) b qemu_system_reset
Breakpoint 1 at 0x69a688: file ../system/runstate.c, line 510.
(gdb) b qemu_default_main
Breakpoint 2 at 0xa9aeb8: file ../system/main.c, line 45.
(gdb) r

Starting program: /usr/bin/qemu-system-ppc64 -name avocado-vt-vm1 
-machine pseries,accel=kvm -enable-kvm -m 32768 -smp 
32,sockets=1,cores=32,threads=1 -nographic -serial pty -device 
virtio-balloon -device virtio-scsi-pci,id=scsi0 -drive 
file=/home/kvmci/tests/data/avocado-vt/images/rhel8.0devel-ppc64le.qcow2,if=none,id=drive-scsi0-0-0,format=qcow2 
-device scsi-hd,bus=scsi0.0,drive=drive-scsi0-0-0 -netdev 
bridge,id=net0,br=virbr0 -device virtio-net-pci,netdev=net0

Thread 1 "qemu-system-ppc" hit Breakpoint 1, qemu_system_reset 
(reason=reason@entry=SHUTDOWN_CAUSE_NONE) at ../system/runstate.c:513
513     AccelClass *ac = ACCEL_GET_CLASS(current_accel());
(gdb) n
517     mc = current_machine ? MACHINE_GET_CLASS(current_machine) : 
NULL;
(gdb) n
519     cpu_synchronize_all_states();
(gdb) n
521     switch (reason) {
(gdb) n
529     if (!cpus_are_resettable() &&
(gdb) n
553     if (mc && mc->reset) {
(gdb) n
554         mc->reset(current_machine, type);
(gdb) n
558     switch (reason) {
(gdb) n
574     if (cpus_are_resettable()) {
(gdb) n
583             cpu_synchronize_all_post_reset();
(gdb) n
587     vm_set_suspended(false);
(gdb) n
qdev_machine_creation_done () at ../hw/core/machine.c:1814
1814    register_global_state();
(gdb) n
qemu_machine_creation_done (errp=0x10123e028 <error_fatal>) at 
../system/vl.c:2785
2785    if (machine->cgs && !machine->cgs->ready) {
(gdb) n
2791    foreach_device_config_or_exit(DEV_GDB, gdbserver_start);
(gdb) n
2793    if (!vga_interface_created && !default_vga &&
(gdb) n
qmp_x_exit_preconfig (errp=errp@entry=0x10123e028 <error_fatal>) at 
../system/vl.c:2815
2815    if (loadvm) {
(gdb) n
2820    if (replay_mode != REPLAY_MODE_NONE) {
(gdb) n
2824    if (incoming) {
(gdb) n
2837    } else if (autostart) {
(gdb) n
2838        qmp_cont(NULL);
(gdb) n
qemu_init (argc=<optimized out>, argv=<optimized out>) at 
../system/vl.c:3849
3849    qemu_init_displays();
(gdb) n
3850    accel_setup_post(current_machine);
(gdb) n
3851    if (migrate_mode() != MIG_MODE_CPR_EXEC) {
(gdb) n
3852        os_setup_post();
(gdb) n
3854    resume_mux_open();
(gdb) n
main (argc=<optimized out>, argv=<optimized out>) at ../system/main.c:84
84      bql_unlock();
(gdb) n
85      replay_mutex_unlock();
(gdb) n
87      if (qemu_main) {
(gdb) n
93          qemu_default_main(NULL);
(gdb) n

Thread 1 "qemu-system-ppc" hit Breakpoint 2, qemu_default_main 
(opaque=opaque@entry=0x0) at ../system/main.c:48
48      replay_mutex_lock();
(gdb) n
49      bql_lock();
(gdb) n

<hangs>
<system becomes unresponsive at this point>


Thanks,
Misbah Anjum N <misanjumn@ibm.com>



On 2026-03-09 18:53, Ani Sinha wrote:
> Yes seems this is an issue and I will fix it. Not sure if the fix will
> address your issue though ...
> 
> Can you try the following patch?
> 
> From 9e5a6945181d4c1fce7f8438e1b6213f1eb79c14 Mon Sep 17 00:00:00 2001
> From: Ani Sinha <anisinha@redhat.com>
> Date: Mon, 9 Mar 2026 18:44:40 +0530
> Subject: [PATCH] Fix reset for non-x86 archs that do not support reset 
> yet
> 
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  system/runstate.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/system/runstate.c b/system/runstate.c
> index eca722b43c..c1f41284c9 100644
> --- a/system/runstate.c
> +++ b/system/runstate.c
> @@ -531,10 +531,12 @@ void qemu_system_reset(ShutdownCause reason)
>          (current_machine->new_accel_vmfd_on_reset || 
> !cpus_are_resettable())) {
>          if (ac->rebuild_guest) {
>              ret = ac->rebuild_guest(current_machine);
> -            if (ret < 0) {
> +            if (ret < 0 && ret != -EOPNOTSUPP) {
>                  error_report("unable to rebuild guest: %s(%d)",
>                               strerror(-ret), ret);
>                  vm_stop(RUN_STATE_INTERNAL_ERROR);
> +            } else if (ret == -EOPNOTSUPP) {
> +                error_report("accelerator does not support reset!");
>              } else {
>                  info_report("virtual machine state has been rebuilt 
> with new "
>                              "guest file handle.");
> --
> 2.42.0
> 
> 
>> 
>> Is this a confidential guest that cannot be normally reset?
>> 

