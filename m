Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF672EF3717
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 08:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzVz1-0002DG-OB; Mon, 09 Mar 2026 04:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misanjum@linux.ibm.com>)
 id 1vzVyy-00029r-Mj; Mon, 09 Mar 2026 04:28:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misanjum@linux.ibm.com>)
 id 1vzVyw-00064k-BU; Mon, 09 Mar 2026 04:28:56 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 628MunC81619459; Mon, 9 Mar 2026 08:28:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=qWPANR
 XN5XUakUS0b5bmXA4sxYJHHjWfYcG/S9+lF+c=; b=RtGipguhpxSDd2LZUqAbW9
 3VyIFxJz9NIH5xL9fKeNtoElFWDLYO+MGr24sCVZxaY9UJm0UCOsPIN0vqw05xNY
 rPV2NNszyZev7uesw7t/q4FIju8v4R1MA7eMGDWfChpDUTl4+F36uld3nMWscHHf
 2z/P5qDIzX+fmvwX7NjKMrRjcjoQShinKcc3Lvp9EQF5WJEATXeOcfFmG9ghlQb7
 VvAV5+zHYSwP7dxI1Pl0utCIDuu9y0M/CnOSX4bVsLtI+jhS0kuaWllOZJK+XwOk
 xjY0vySWiQlyQ1RgTyJDTNYeOLFFuPyzbdiaz9nTaxoyLJhxen8KrTKcCRCKJcnQ
 ==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcvr5gvj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 08:28:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62960BjI015706;
 Mon, 9 Mar 2026 08:28:50 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cs121uwtd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Mar 2026 08:28:50 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6298SnCd16188018
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 9 Mar 2026 08:28:50 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C650B58062;
 Mon,  9 Mar 2026 08:28:49 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3380958055;
 Mon,  9 Mar 2026 08:28:49 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  9 Mar 2026 08:28:49 +0000 (GMT)
MIME-Version: 1.0
Date: Mon, 09 Mar 2026 13:58:48 +0530
From: Misbah Anjum N <misanjum@linux.ibm.com>
To: Anisinha <anisinha@redhat.com>, Pbonzini <pbonzini@redhat.com>, Qemu
 Devel <qemu-devel@nongnu.org>, Qemu Ppc <qemu-ppc@nongnu.org>
Cc: npiggin@gmail.com, harshpb@linux.ibm.com
Subject: Re: [BUG] [powerpc] KVM guest boot failure - hangs on startup after
 commit 98884e0c
In-Reply-To: <e0fa0840fa7758499aa8c64a148e5367@linux.ibm.com>
References: <e0fa0840fa7758499aa8c64a148e5367@linux.ibm.com>
Message-ID: <2cc23a5ce64847dd8a9278c87f58119b@linux.ibm.com>
X-Sender: misanjum@linux.ibm.com
Organization: IBM
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDA3MyBTYWx0ZWRfX4HEiso9+I1xn
 8AbYlTtU9u2uW9K7G5ZmzZTvc39A4E/suTcFWLIi1BoHxWsWynMwSvuRSEosaSvazeXX6aPEgfQ
 wYOk7fCEHx5kSepDU1Z1UziIlPV7KmA/OYkqqSWn4FP3EJSvvxzJrFpo+gyxz9nFzUancDXxiH2
 SmOUSnOPD5kpyRbC8BbMDaggFRXkVSzXIf51IEvBM3Mgwl0QwS5swYchtyagHJh2JTfSvnXQ7ax
 kkW53aEqhRu73/tm/1qANdBWh3uIOSHjMl8aIhsGmUNMCdrUnkezaWFc8iVOTymxHMcJep7EG1W
 ujGaPnFDOavrFq0W9LoMEDlv0i9RIBAdiMtYkXzZLlsBRlGNiHsJSzlzgRv/jzRGLNdtqilgJqW
 YvAO9JbgQzNLZI+6hc4hf9OcRtFwnZVB6lURpz3AZbOXSy5wlcgdO/QKK1aJJ4Iwm/FtToyqsiy
 YAJNGvQsAbKRrdHbddg==
X-Proofpoint-GUID: M36JfjhXoOmMStt9bTZeIZ-SKpjc2p1w
X-Proofpoint-ORIG-GUID: 1m6dNZFaKALg67yzfIvjXed8lcrT1ljR
X-Authority-Analysis: v=2.4 cv=QoFTHFyd c=1 sm=1 tr=0 ts=69ae84c3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=I_unNf-_G6gpICKYEEsA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_02,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603090073
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
Following up on my previous report, I've attempted additional debugging 
to isolate the issue on ppc64le.

I implemented the architecture-specific hooks for ppc64le. After adding 
the following changes and recompiling QEMU and testing with the direct 
qemu-system-ppc64 command, the hang persists with the same issue - no 
output and complete unresponsiveness.

Could you suggest what additional changes are needed to ensure the VM FD 
change doesn't affect architectures that don't support this feature?

Tested with the following changes:
File: stubs/kvm.c
Changed the abort() call to return 0:
int kvm_arch_on_vmfd_change(MachineState *ms, KVMState s)
{
return 0;  / Changed from abort() */
}

File: target/ppc/kvm.c
Added the following stubs:
int kvm_arch_on_vmfd_change(MachineState *ms, KVMState s)
{
/ ppc64le doesn't support VM FD changes for confidential guests */
return 0;
}

bool kvm_arch_supports_vmfd_change(void)
{
return false;
}

GDB Backtrace:
I ran QEMU under GDB to capture the hang state. The backtrace shows the 
vCPU thread is waiting on a condition variable:

Thread 4 "CPU 0/KVM" received signal SIGUSR1, User defined signal 1.
__syscall_cancel_arch () at 
../sysdeps/unix/sysv/linux/powerpc/syscall_cancel.S:77
#0  __syscall_cancel_arch () at 
../sysdeps/unix/sysv/linux/powerpc/syscall_cancel.S:77
#1  0x00007ffff58a9678 in __internal_syscall_cancel (nr=221) at 
cancellation.c:49
#2  0x00007ffff58aa220 in __futex_abstimed_wait_common64 
(futex_word=0x10131ba10, expected=0, op=393, abstime=0x0, cancel=true) 
at futex-internal.c:57
#3  __futex_abstimed_wait_common (futex_word=0x10131ba10, expected=0, 
clockid=0, abstime=<optimized out>, private=0, cancel=true) at 
futex-internal.c:87
#4  __GI___futex_abstimed_wait_cancelable64 (futex_word=0x10131ba10, 
expected=0, clockid=0, abstime=0x0, private=0) at futex-internal.c:139
#5  0x00007ffff58ae0bc in __pthread_cond_wait_common (cond=0x10131b9f0, 
mutex=0x101222ce0 <bql>, clockid=0, abstime=0x0) at 
pthread_cond_wait.c:426
#6  ___pthread_cond_wait (cond=0x10131b9f0, mutex=0x101222ce0 <bql>) at 
pthread_cond_wait.c:458
#7  0x0000000100b9bea8 in qemu_cond_wait_impl (cond=0x10131b9f0, 
mutex=0x101222ce0 <bql>, file=0x100c59900 "../system/cpus.c", line=472) 
at ../util/qemu-thread-posix.c:240
#8  0x00000001006a0408 in qemu_process_cpu_events (cpu=0x1019dd260) at 
../system/cpus.c:472
#9  0x0000000100913354 in kvm_vcpu_thread_fn (arg=0x1019dd260) at 
../accel/kvm/kvm-accel-ops.c:50
#10 0x0000000100b9b30c in qemu_thread_start (args=0x1019f1fe0) at 
../util/qemu-thread-posix.c:414
#11 0x00007ffff58aed94 in start_thread (arg=0x7ffff0bce320) at 
pthread_create.c:448
#12 0x00007ffff59555f8 in __GI___clone3 () at 
../sysdeps/unix/sysv/linux/powerpc/powerpc64/clone3.S:114

Thanks,
Misbah Anjum N <misanjum@linux.ibm.com>


On 2026-03-06 16:22, Misbah Anjum N wrote:
> Hi,
> I'm reporting a critical regression on ppc64le that causes all KVM
> guests to hang immediately during startup. Git bisect identified
> commit 98884e0cc10997a17ce9abfd6ff10be19224ca6a as the first bad
> commit. The commit completely breaks KVM functionality on ppc64le.
> 
> Regression Details:
> Working Version: QEMU 10.2.50 (v10.2.0-1669-gffcf1a7981)
> Broken Version: QEMU 10.2.50 (v10.2.0-1816-g3fb456e9a0)
> Bad Commit: 98884e0cc10997a17ce9abfd6ff10be19224ca6a "accel/kvm: add
> changes required to support KVM VM file descriptor change"
> Commit Link:
> https://gitlab.com/qemu-project/qemu/-/commit/98884e0cc10997a17ce9abfd6ff10be19224ca6a
> 
> Environment:
> Host: Fedora 42, Kernel 7.0.0-rc2, Power11 (ppc64le)
> Libvirt: 12.1.0
> Guest: Fedora 42, Kernel 7.0.0-rc2
> Machine Type: pseries with KVM acceleration
> 
> Build Configuration:
> git clone https://gitlab.com/qemu-project/qemu.git
> cd qemu
> git submodule init
> git submodule update --recursive
> ./configure --target-list=ppc64-softmmu --disable-tcg --prefix=/usr
> make && make install
> 
> Reproduction:
> Using virt-install:
> /usr/bin/virt-install --connect=qemu:///system --hvm --accelerate
> --name 'avocado-vt-vm1' --machine pseries --memory=32768
> --vcpu=32,sockets=1,cores=32,threads=1 --import --nographics
> --os-variant rhel8.0 --serial pty --memballoon model=virtio
> --controller type=scsi,model=virtio-scsi --disk
> path=/home/kvmci/tests/data/avocado-vt/images/rhel8.0devel-ppc64le.qcow2,bus=scsi,size=10,format=qcow2
> --network=bridge=virbr0,model=virtio --boot
> emulator=/usr/bin/qemu-system-ppc64
> Result: Starting install...
>         <hangs indefinitely with no output>
> 
> Using direct QEMU command:
> /usr/bin/qemu-system-ppc64 -name avocado-vt-vm1 -machine
> pseries,accel=kvm -enable-kvm -m 32768 -smp
> 32,sockets=1,cores=32,threads=1 -nographic -serial pty -device
> virtio-balloon -device virtio-scsi-pci,id=scsi0 -drive
> file=/home/kvmci/tests/data/avocado-vt/images/rhel8.0devel-ppc64le.qcow2,if=none,id=drive-scsi0-0-0,format=qcow2
> -device scsi-hd,bus=scsi0.0,drive=drive-scsi0-0-0 -netdev
> bridge,id=net0,br=virbr0 -device virtio-net-pci,netdev=net0
> Result: <hangs indefinitely with no output>
> 
> Analysis:
> The commit introduces VM file descriptor change support with
> architecture-specific hooks.
> I attempted the following fixes without success:
> 1. Changed abort() to return 0; in stubs/kvm.c
> 2. Added early return in kvm_reset_vmfd() when
> kvm_arch_supports_vmfd_change() returns false
> 
> Git Bisect Log:
> # git bisect bad
> 98884e0cc10997a17ce9abfd6ff10be19224ca6a is the first bad commit
> commit 98884e0cc10997a17ce9abfd6ff10be19224ca6a (HEAD)
> Author: Ani Sinha <anisinha@redhat.com>
> Date:   Wed Feb 25 09:19:10 2026 +0530
> 
>     accel/kvm: add changes required to support KVM VM file descriptor 
> change
> 
>     This change adds common kvm specific support to handle KVM VM file
> descriptor
>     change. KVM VM file descriptor can change as a part of
> confidential guest reset
>     mechanism. A new function api kvm_arch_on_vmfd_change() per
>     architecture platform is added in order to implement architecture 
> specific
>     changes required to support it. A subsequent patch will add x86 
> specific
>     implementation for kvm_arch_on_vmfd_change() as currently only x86 
> supports
>     confidential guest reset.
> 
>     Signed-off-by: Ani Sinha <anisinha@redhat.com>
>     Link: 
> https://lore.kernel.org/r/20260225035000.385950-6-anisinha@redhat.com
>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
>  MAINTAINERS            |  6 ++++++
>  accel/kvm/kvm-all.c    | 88
> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  accel/kvm/trace-events |  1 +
>  include/system/kvm.h   |  3 +++
>  stubs/kvm.c            | 22 ++++++++++++++++++++++
>  stubs/meson.build      |  1 +
>  target/i386/kvm/kvm.c  | 10 ++++++++++
>  7 files changed, 128 insertions(+), 3 deletions(-)
>  create mode 100644 stubs/kvm.c
> 
> # git bisect log
> git bisect start
> git bisect good ffcf1a7981793973ffbd8100a7c3c6042d02ae23
> git bisect bad 3fb456e9a0e9eef6a71d9b49bfff596a0f0046e9
> git bisect bad e76c30bb13ecb9dc716fa629954bfb6253056ce2
> git bisect good 9bdc612a18588975f5776ee4e562df607fea1b2c
> git bisect bad 40c015e96942fd2a3e4d5ace6063b3333a3dd372
> git bisect good df8df3cb6b743372ebb335bd8404bc3d748da350
> git bisect bad 0f53f021ad1ede28dc8944686544e496cab02e5e
> git bisect bad 9f0c2b3032639315faf141010a2603b0dbf56230
> git bisect bad 98884e0cc10997a17ce9abfd6ff10be19224ca6a
> first bad commit: [98884e0cc10997a17ce9abfd6ff10be19224ca6a]
> 
> Thanks,
> Misbah Anjum N <misanjum@linux.ibm.com>

