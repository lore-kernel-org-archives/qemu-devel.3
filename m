Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70F2EA8550
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 10:06:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vztyk-0008Lx-Qy; Tue, 10 Mar 2026 06:06:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misanjum@linux.ibm.com>)
 id 1vztyR-0008JF-5M; Tue, 10 Mar 2026 06:06:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misanjum@linux.ibm.com>)
 id 1vztyH-00063P-Qc; Tue, 10 Mar 2026 06:05:58 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62A6JWAJ1582348; Tue, 10 Mar 2026 10:05:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=bRvMJc
 nuUene4KnHZLIg390KCq3U9lQS5gd+arg6tC8=; b=aOOIb9YH7UD2rMVppko31C
 5Lo8bfoYPvXhAb0nQD9GCSunABelHdUDRDue8RZHJRgcfbKUHbIEPBdZ+l+Brb9E
 9JbbyZ55VGXgOM04yOxrMqTMJ7o9Tg+/g66kpoz65DkzVX2z9KbRD8gavFTfHByT
 XvSUqlf70xNnfOcHV6G3H3i8hYYzuHMSzALaEUL8nOicghAPtVNknfkF6nRwd0A7
 zSNXZ2KlpnyzgjrhkUXxPy7kbGe1gu+N+QQpml058JOUFXe59iMXOA5hwmpzY5qa
 LoXy0nY/yjHrxiFc8bdhv9t0hncY4XqJciEWIlG8zQyDIUxe3JLW+YAufVMh8K8A
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcuyaawb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 10:05:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62A6SdGF015652;
 Tue, 10 Mar 2026 10:05:40 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4crybn8ku3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 10 Mar 2026 10:05:40 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62AA5dDb31064714
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2026 10:05:39 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2C7E558054;
 Tue, 10 Mar 2026 10:05:39 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7738C5804E;
 Tue, 10 Mar 2026 10:05:38 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 10 Mar 2026 10:05:38 +0000 (GMT)
MIME-Version: 1.0
Date: Tue, 10 Mar 2026 15:35:38 +0530
From: Misbah Anjum N <misanjum@linux.ibm.com>
To: Ani Sinha <anisinha@redhat.com>, Pbonzini <pbonzini@redhat.com>, Qemu
 Devel <qemu-devel@nongnu.org>, Qemu Ppc <qemu-ppc@nongnu.org>
Cc: npiggin@gmail.com, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com
Subject: Re: [BUG] [powerpc] KVM guest boot failure - hangs on startup after
 commit 98884e0c
In-Reply-To: <7ACBCD63-B759-47FD-824F-0327726E47F6@redhat.com>
References: <e0fa0840fa7758499aa8c64a148e5367@linux.ibm.com>
 <2cc23a5ce64847dd8a9278c87f58119b@linux.ibm.com>
 <5bc7997d-329e-47a9-9b4d-750a3104094a@linux.ibm.com>
 <4797B580-7853-490E-8852-B6312619FE95@redhat.com>
 <e966c053-2e69-b185-532e-fcb4173b4daf@redhat.com>
 <b088f554af34cbcc4d88271e227074e1@linux.ibm.com>
 <ED4A083D-2B96-468A-BE77-211E9F3FA88D@redhat.com>
 <7bbeb3cb105934e95bf1a5356cfc4613@linux.ibm.com>
 <7ACBCD63-B759-47FD-824F-0327726E47F6@redhat.com>
Message-ID: <35f6361f69ef4f09f80bd915f3460a28@linux.ibm.com>
X-Sender: misanjum@linux.ibm.com
Organization: IBM
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EK4LElZC c=1 sm=1 tr=0 ts=69afecf6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=CBYXZ0ShzhXhPLskG0MA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDA4MSBTYWx0ZWRfXxOdUhYCYBk1l
 Pvnbf32tGh2+NbH+NDK7JRGvDjOpn+7BU0a/oZ5h8C72kHs0Zqu6h2BlBIdl0Cas2sFW27IaRdG
 HIKw3rf9cEeaVWpg1PiVTML6FhJlxYRTguq17rRQCZZsqEtTZ0RwLEewiIYwGIcmoq8n9BV9jHn
 BB7dtEW9iB7ysvYamd0t1SoqQizeZIOWSw2gVUkaHa52Mmo0ccHjSnPrO5DjQvKWk2DWIPccqOa
 XxBksl7IBjh5snjTJsEFDPeXM6GG1BewDwIMnXXzbSwzBb6hc2XS60CIVnAJ8QxoN0xiVDKKYQ6
 sNRZ5ANUOxsBPf98oqdTWSrLqHiaI7+gsFFy3mqV/ZWXrEnz5aKLBd8tnGeUHiyRuMeAefkRWU1
 XEKkpsHYetW2FVXrr+6bxVxjsiVPIzgRy/nWirIl5bYeeH3ikYv9XvAAEcuuZiPec01NrIo6QYy
 NG7/l0rSHGN425QWbBw==
X-Proofpoint-GUID: akf-vR_JSVPt4vv0SIarfeyX_LM3WvBG
X-Proofpoint-ORIG-GUID: u62Hj4Nf2aT-r5TgcRtfJG3SViZgoSl7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_01,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100081
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=misanjum@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 2026-03-10 15:04, Ani Sinha wrote:
>> On 10 Mar 2026, at 2:38 PM, Misbah Anjum N <misanjum@linux.ibm.com> 
>> wrote:
>> 
>> On 2026-03-10 14:24, Ani Sinha wrote:
>>>> On 10 Mar 2026, at 2:09 PM, Misbah Anjum N <misanjum@linux.ibm.com> 
>>>> wrote:
>>>> Hi Ani and Paolo,
>>>> We have tested the code by applying both the original commit 
>>>> (98884e0cc10997a17ce9abfd6ff10be19224ca6a) and your fix patch 
>>>> (commit 9e5a6945181d4c1fce7f8438e1b6213f1eb79c14) on ppc64le.
>>>> However, the issue persists. We've conducted GDB debugging that 
>>>> shows the hang is occurring in a different location than what the 
>>>> fix addresses.
>>>> Since the original patch is breaking KVM guest bringup completely on 
>>>> ppc64le, and the fix patch does not resolve the issue, given the 
>>>> severity of this regression (complete KVM breakage on ppc64le), we 
>>>> should either find a quick fix or consider reverting the patch until 
>>>> a proper solution can be identified.
>>> Based on what you just described, it does not seem like the issue is
>>> related to 98884e0cc10997a17ce9abfd6ff10be19224ca6a at all. If you
>>> revert this patch in your local tree, can you confirm that your issue
>>> gets fixed?
>> 
>> Yes, the issue is not seen with the immediate previous commit:
>> 
>> commit df8df3cb6b743372ebb335bd8404bc3d748da350 (ani-df8df3cb)
>> Author: Ani Sinha <anisinha@redhat.com>
>> Date:   Wed Feb 25 09:19:09 2026 +0530
>> 
>>    system/physmem: add helper to reattach existing memory after KVM VM 
>> fd change
>> 
>>    After the guest KVM file descriptor has changed as a part of the 
>> process of
>>    confidential guest reset mechanism, existing memory needs to be 
>> reattached to
>>    the new file descriptor. This change adds a helper function 
>> ram_block_rebind()
>>    for this purpose. The next patch will make use of this function.
>> 
>>    Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>    Link: 
>> https://lore.kernel.org/r/20260225035000.385950-5-anisinha@redhat.com
>>    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> 
>> Looks like the next patch is enabling the functionality of the 
>> previous patches in such a way which causes bql_lock() to get stuck on 
>> architectures (ppc64le in this case) which does not support this 
>> feature yet.
> 
> This theory is not substantiated by code or evidence.
> 98884e0cc10997a17ce9abfd6ff10be19224ca6a introduces kvm_reset_vmfd()
> which is called by this block of code with the tip at
> 98884e0cc10997a17ce9abfd6ff10be19224ca6a :
> 
>    if (!cpus_are_resettable() &&
>         (reason == SHUTDOWN_CAUSE_GUEST_RESET ||
>          reason == SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET)) {
>         if (ac->rebuild_guest) {
>             ret = ac->rebuild_guest(current_machine);
>             if (ret < 0) {
>                 error_report("unable to rebuild guest: %s(%d)",
>                              strerror(-ret), ret);
>                 vm_stop(RUN_STATE_INTERNAL_ERROR);
>             } else {
>                 info_report("virtual machine state has been rebuilt 
> with new "
>                             "guest file handle.");
>                 guest_state_rebuilt = true;
>             }
>         } else if (!cpus_are_resettable())  {
>             error_report("accelerator does not support reset!");
>         } else {
>             error_report("accelerator does not support rebuilding guest 
> state,"
>                          " proceeding with normal reset!");
>         }
>     }
> 
> If cpus are resettable, this block will not be called and nothing that
> the patch introduces will have been executed.
> So I think you guys need to explain a bit more why you so strongly
> feel this patch broke it. I am confused and unable to reason this.
> 
>> 
>> Did you validate your patches on other architectures which does not 
>> support this feature yet?
> 
> As you have already seen, on other architectures, the entire block of
> code is not executed at all. Only SEV-ES, SEV-SNP and TDX currently
> exercises this.
> 

I understand your concern about the code path analysis. Let me clarify 
our findings with concrete evidence.

Reproducibility Evidence:
With commit 98884e0cc10997a17ce9abfd6ff10be19224ca6a applied, we are 
able to reproduce the hang issue 100% of the time across multiple test 
runs. When we revert to the previous commit 
df8df3cb6b743372ebb335bd8404bc3d748da350, the same KVM guest boots 
successfully 100% of the time.

This consistent reproducibility strongly indicates that commit 
98884e0cc10997a17ce9abfd6ff10be19224ca6a is introducing the regression, 
even if the code path analysis suggests otherwise. This suggests the 
issue may not be in the code path, but rather in the changes introduced 
by the patch series.

As the author who led the development of this patch series, we would 
appreciate your help in figuring out this issue.

>> 
>>>> Analysis:
>>>> 1. This is not a confidential guest. This is a regular KVM guest 
>>>> running on ppc64le.
>>>> 2. The execution flow shows that qemu_system_reset() completes 
>>>> successfully and never enters the code path at line 529-543
>>> This is what I expected and therefore, no code related to coco guest
>>> rebuilding is getting executed. Your issue seems to be somewhere 
>>> else.
>> 
>> The issue occurs only with the introduction of this patch and not with 
>> the previous upstream commit as explained above.
>> 
>>>> 3. The hang occurs later in qemu_default_main() at system/main.c:49, 
>>>> after calling bql_lock()
>>>> 4. The ppc KVM guest boots fine with the previous commit - 
>>>> df8df3cb6b743372ebb335bd8404bc3d748da350
>>>> 5. This suggests the issue is not with error handling of -EOPNOTSUPP 
>>>> during reset, but bql_lock() getting stuck in qemu_default_main()
>>>> GDB Trace Analysis:
>>>> We set breakpoints at qemu_system_reset() and qemu_default_main() to 
>>>> trace the execution flow. The system successfully completes 
>>>> qemu_system_reset() without entering the problematic code path where 
>>>> the fix provided by you applies (system/runstate.c:529-543).
>>>> # gdb --args /usr/bin/qemu-system-ppc64 -name avocado-vt-vm1 
>>>> -machine pseries,accel=kvm -enable-kvm -m 32768 -smp 
>>>> 32,sockets=1,cores=32,threads=1 -nographic -serial pty -device 
>>>> virtio-balloon -device virtio-scsi-pci,id=scsi0 -drive 
>>>> file=/home/kvmci/tests/data/avocado-vt/images/rhel8.0devel-ppc64le.qcow2,if=none,id=drive-scsi0-0-0,format=qcow2 
>>>> -device scsi-hd,bus=scsi0.0,drive=drive-scsi0-0-0 -netdev 
>>>> bridge,id=net0,br=virbr0 -device virtio-net-pci,netdev=net0
>>>> (gdb) handle SIGUSR1 pass nostop noprint
>>>> Signal        Stop Print Pass to program Description
>>>> SIGUSR1       No No Yes User defined signal 1
>>>> (gdb) b qemu_system_reset
>>>> Breakpoint 1 at 0x69a688: file ../system/runstate.c, line 510.
>>>> (gdb) b qemu_default_main
>>>> Breakpoint 2 at 0xa9aeb8: file ../system/main.c, line 45.
>>>> (gdb) r
>>>> Starting program: /usr/bin/qemu-system-ppc64 -name avocado-vt-vm1 
>>>> -machine pseries,accel=kvm -enable-kvm -m 32768 -smp 
>>>> 32,sockets=1,cores=32,threads=1 -nographic -serial pty -device 
>>>> virtio-balloon -device virtio-scsi-pci,id=scsi0 -drive 
>>>> file=/home/kvmci/tests/data/avocado-vt/images/rhel8.0devel-ppc64le.qcow2,if=none,id=drive-scsi0-0-0,format=qcow2 
>>>> -device scsi-hd,bus=scsi0.0,drive=drive-scsi0-0-0 -netdev 
>>>> bridge,id=net0,br=virbr0 -device virtio-net-pci,netdev=net0
>>>> Thread 1 "qemu-system-ppc" hit Breakpoint 1, qemu_system_reset 
>>>> (reason=reason@entry=SHUTDOWN_CAUSE_NONE) at 
>>>> ../system/runstate.c:513
>>>> 513     AccelClass *ac = ACCEL_GET_CLASS(current_accel());
>>>> (gdb) n
>>>> 517     mc = current_machine ? MACHINE_GET_CLASS(current_machine) : 
>>>> NULL;
>>>> (gdb) n
>>>> 519     cpu_synchronize_all_states();
>>>> (gdb) n
>>>> 521     switch (reason) {
>>>> (gdb) n
>>>> 529     if (!cpus_are_resettable() &&
>>>> (gdb) n
>>>> 553     if (mc && mc->reset) {
>>>> (gdb) n
>>>> 554         mc->reset(current_machine, type);
>>>> (gdb) n
>>>> 558     switch (reason) {
>>>> (gdb) n
>>>> 574     if (cpus_are_resettable()) {
>>>> (gdb) n
>>>> 583             cpu_synchronize_all_post_reset();
>>>> (gdb) n
>>>> 587     vm_set_suspended(false);
>>>> (gdb) n
>>>> qdev_machine_creation_done () at ../hw/core/machine.c:1814
>>>> 1814    register_global_state();
>>>> (gdb) n
>>>> qemu_machine_creation_done (errp=0x10123e028 <error_fatal>) at 
>>>> ../system/vl.c:2785
>>>> 2785    if (machine->cgs && !machine->cgs->ready) {
>>>> (gdb) n
>>>> 2791    foreach_device_config_or_exit(DEV_GDB, gdbserver_start);
>>>> (gdb) n
>>>> 2793    if (!vga_interface_created && !default_vga &&
>>>> (gdb) n
>>>> qmp_x_exit_preconfig (errp=errp@entry=0x10123e028 <error_fatal>) at 
>>>> ../system/vl.c:2815
>>>> 2815    if (loadvm) {
>>>> (gdb) n
>>>> 2820    if (replay_mode != REPLAY_MODE_NONE) {
>>>> (gdb) n
>>>> 2824    if (incoming) {
>>>> (gdb) n
>>>> 2837    } else if (autostart) {
>>>> (gdb) n
>>>> 2838        qmp_cont(NULL);
>>>> (gdb) n
>>>> qemu_init (argc=<optimized out>, argv=<optimized out>) at 
>>>> ../system/vl.c:3849
>>>> 3849    qemu_init_displays();
>>>> (gdb) n
>>>> 3850    accel_setup_post(current_machine);
>>>> (gdb) n
>>>> 3851    if (migrate_mode() != MIG_MODE_CPR_EXEC) {
>>>> (gdb) n
>>>> 3852        os_setup_post();
>>>> (gdb) n
>>>> 3854    resume_mux_open();
>>>> (gdb) n
>>>> main (argc=<optimized out>, argv=<optimized out>) at 
>>>> ../system/main.c:84
>>>> 84      bql_unlock();
>>>> (gdb) n
>>>> 85      replay_mutex_unlock();
>>>> (gdb) n
>>>> 87      if (qemu_main) {
>>>> (gdb) n
>>>> 93          qemu_default_main(NULL);
>>>> (gdb) n
>>>> Thread 1 "qemu-system-ppc" hit Breakpoint 2, qemu_default_main 
>>>> (opaque=opaque@entry=0x0) at ../system/main.c:48
>>>> 48      replay_mutex_lock();
>>>> (gdb) n
>>>> 49      bql_lock();
>>>> (gdb) n
>>>> <hangs>
>>>> <system becomes unresponsive at this point>
>>>> Thanks,
>>>> Misbah Anjum N <misanjumn@ibm.com>
>>>> On 2026-03-09 18:53, Ani Sinha wrote:
>>>>> Yes seems this is an issue and I will fix it. Not sure if the fix 
>>>>> will
>>>>> address your issue though ...
>>>>> Can you try the following patch?
>>>>> From 9e5a6945181d4c1fce7f8438e1b6213f1eb79c14 Mon Sep 17 00:00:00 
>>>>> 2001
>>>>> From: Ani Sinha <anisinha@redhat.com>
>>>>> Date: Mon, 9 Mar 2026 18:44:40 +0530
>>>>> Subject: [PATCH] Fix reset for non-x86 archs that do not support 
>>>>> reset yet
>>>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>>>> ---
>>>>> system/runstate.c | 4 +++-
>>>>> 1 file changed, 3 insertions(+), 1 deletion(-)
>>>>> diff --git a/system/runstate.c b/system/runstate.c
>>>>> index eca722b43c..c1f41284c9 100644
>>>>> --- a/system/runstate.c
>>>>> +++ b/system/runstate.c
>>>>> @@ -531,10 +531,12 @@ void qemu_system_reset(ShutdownCause reason)
>>>>>        (current_machine->new_accel_vmfd_on_reset || 
>>>>> !cpus_are_resettable())) {
>>>>>        if (ac->rebuild_guest) {
>>>>>            ret = ac->rebuild_guest(current_machine);
>>>>> -            if (ret < 0) {
>>>>> +            if (ret < 0 && ret != -EOPNOTSUPP) {
>>>>>                error_report("unable to rebuild guest: %s(%d)",
>>>>>                             strerror(-ret), ret);
>>>>>                vm_stop(RUN_STATE_INTERNAL_ERROR);
>>>>> +            } else if (ret == -EOPNOTSUPP) {
>>>>> +                error_report("accelerator does not support 
>>>>> reset!");
>>>>>            } else {
>>>>>                info_report("virtual machine state has been rebuilt 
>>>>> with new "
>>>>>                            "guest file handle.");
>>>>> --
>>>>> 2.42.0
>>>>>> Is this a confidential guest that cannot be normally reset?

