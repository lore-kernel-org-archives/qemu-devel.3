Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D047BFCD0D0
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:20:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2m7z-00060x-Gq; Wed, 18 Mar 2026 04:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misanjum@linux.ibm.com>)
 id 1w2m7y-00060h-Bk; Wed, 18 Mar 2026 04:19:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misanjum@linux.ibm.com>)
 id 1w2m7v-00035V-RN; Wed, 18 Mar 2026 04:19:42 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62HLdRaX1188668; Wed, 18 Mar 2026 08:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=NaJVRh
 3ENp+2VF8/QOIE2WYFX+YSTnfJtheWgaYpzno=; b=hcctRplHFqTklNU1m5DPPt
 /GgSTHs3GhGAuri+3ZqcNNFiDZRRojSp6GpDpe0n3hileRm7dLIekAFaiaIJ3M7A
 XNuQyKFc1swr8o5E4xVZxVzUDf19bLODKhTJKx+5pH64gxszw5l9F/DzyBjgfqpp
 jn2gbe2FXj0Ok1ReV3ZO+2psRkLAp4eh5Y0Q1RxV4jABkXV6BVwejV7q3FwiJ3OU
 AmRLrgDNVuhaerIWZlhY6GgyYP91y1G/t5a+s/WiA9UX7vsnByaRkYbGhzNQVTXW
 19lY/0GIr82NZLefE+F9rP5wTF+VJSDy0sKBFkDOkjRog03P42i/LR2FewAowGBA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vfk5nh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Mar 2026 08:19:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62I4gM7Z014011;
 Wed, 18 Mar 2026 08:19:35 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcy55nr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 18 Mar 2026 08:19:35 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62I8JXkA33030892
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 18 Mar 2026 08:19:34 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F2A058056;
 Wed, 18 Mar 2026 08:19:33 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 23EA958060;
 Wed, 18 Mar 2026 08:19:33 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 18 Mar 2026 08:19:33 +0000 (GMT)
MIME-Version: 1.0
Date: Wed, 18 Mar 2026 13:49:32 +0530
From: Misbah Anjum N <misanjum@linux.ibm.com>
To: Ani Sinha <anisinha@redhat.com>, Pbonzini <pbonzini@redhat.com>, Qemu
 Devel <qemu-devel@nongnu.org>, Qemu Ppc <qemu-ppc@nongnu.org>
Cc: npiggin@gmail.com, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 vaibhav@linux.ibm.com, sbhat@linux.ibm.com
Subject: Re: [BUG] [powerpc] KVM guest boot failure - hangs on startup after
 commit 98884e0c
In-Reply-To: <B2B682DB-1467-4C42-AF74-346BC61DE31B@redhat.com>
References: <e0fa0840fa7758499aa8c64a148e5367@linux.ibm.com>
 <2cc23a5ce64847dd8a9278c87f58119b@linux.ibm.com>
 <5bc7997d-329e-47a9-9b4d-750a3104094a@linux.ibm.com>
 <4797B580-7853-490E-8852-B6312619FE95@redhat.com>
 <e966c053-2e69-b185-532e-fcb4173b4daf@redhat.com>
 <b088f554af34cbcc4d88271e227074e1@linux.ibm.com>
 <ED4A083D-2B96-468A-BE77-211E9F3FA88D@redhat.com>
 <7bbeb3cb105934e95bf1a5356cfc4613@linux.ibm.com>
 <7ACBCD63-B759-47FD-824F-0327726E47F6@redhat.com>
 <35f6361f69ef4f09f80bd915f3460a28@linux.ibm.com>
 <B2B682DB-1467-4C42-AF74-346BC61DE31B@redhat.com>
Message-ID: <526d7172f3933baf913bf4b105a6fa9a@linux.ibm.com>
X-Sender: misanjum@linux.ibm.com
Organization: IBM
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: OPa5kKVrhMf26jWPDRq-3HSoIzDwyug9
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69ba6018 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=wMR-pP4OzeqKIkH-kCoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE4MDA2OSBTYWx0ZWRfXz9ld1dJnbMXK
 5RTNqkMXWg1VnxcDnl32ql+T1W3z0nc5Ti/vTULcGWL1X82VGwmiwEpMhObVn0vM6NClxqED9U4
 yjdjOR95itI+kYM0zukIKPgEdseZSZ8IQ1WSF+3N0tTbKyGEeXvtnSvYGR0btCoQcyxu6rfQtnI
 KDBNFZ0G81zSr+JS2M7wjetncYUapkienjyLuIBfR6ysjztpdH2mDPQqQ/R5ZE0ifoXux3jFhqF
 JOlywSsgL6FxB+IharjYNMhQARIuhgQsSqGAuEZEtADLDos5Zex1Pz1hUilpLs09pINO7X/YMBT
 2osKqqniBK/k5lgkqpDWgTzJyyU0BdAXr5QhGbzFXc9VHfqrlJ0oI0cbfoWR4peTVEZhv/RzxAU
 5W+rhU6t15k34NDFSJLwPvV1r+D2M/7d7adTaRMzZu7oXhI/DRdMZfF9VIK5axb46/EveZtg5Ni
 /rTZ84q4gf/DMaJlgFg==
X-Proofpoint-GUID: YcRCGRnOWnps9ErtT4eJVRAbv513-kTy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_05,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603180069
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

Hi Ani and Paolo,

Following up on the KVM guest boot issue due to commit 98884e0c, I have 
conducted additional testing that reveals important new information 
about the nature of this issue.

The hang is specifically triggered when SMP is configured, that is, when 
-smp parameter is provided in the QEMU command. This is also validated 
via KVM Unit Tests involving SMP which are failing due to the same 
commit.

Test Results:
Without SMP (boots successfully):
/usr/bin/qemu-system-ppc64 -name avocado-vt-vm1 -machine 
pseries,accel=kvm \
   -enable-kvm -m 32768 -nographic -device virtio-balloon \
   -device virtio-scsi-pci,id=scsi0 \
   -drive 
file=/home/kvmci/tests/data/avocado-vt/images/rhel8.0devel-ppc64le-hpb.qcow2,if=none,id=drive-scsi0-0-0,format=qcow2 
\
   -device scsi-hd,bus=scsi0.0,drive=drive-scsi0-0-0 \
   -netdev bridge,id=net0,br=virbr0 -device virtio-net-pci,netdev=net0

SLOF 
**********************************************************************
QEMU Starting
  Build Date = Oct 26 2025 18:45:22
  FW Version = release 20251026
  Press "s" to enter Open Firmware.

Populating /vdevice methods
Populating /vdevice/vty@71000000
Populating /vdevice/nvram@71000001
Populating /pci@800000020000000
...
...
Result: Guest boots successfully

With SMP (hangs indefinitely):
/usr/bin/qemu-system-ppc64 -name avocado-vt-vm1 -machine 
pseries,accel=kvm \
   -enable-kvm -m 32768 -smp 32,sockets=1,cores=32,threads=1 -nographic \
   -device virtio-balloon -device virtio-scsi-pci,id=scsi0 \
   -drive 
file=/home/kvmci/tests/data/avocado-vt/images/rhel8.0devel-ppc64le-hpb.qcow2,if=none,id=drive-scsi0-0-0,format=qcow2 
\
   -device scsi-hd,bus=scsi0.0,drive=drive-scsi0-0-0 \
   -netdev bridge,id=net0,br=virbr0 -device virtio-net-pci,netdev=net0
...
...
Result: Hangs indefinitely at bql_lock() in qemu_default_main()

KVM Unit Tests:
Running kvm-unit-tests confirms the SMP dependency. Note that tests 
explicitly involving SMP (smp, smp-smt, atomics) all fail with SIGKILL, 
while single-threaded tests pass.

# ./run_tests.sh
FAIL selftest-setup (terminated on SIGKILL)
PASS selftest-migration (2 tests)
PASS selftest-migration-skip (1 tests)
PASS migration-memory (1 tests)
PASS spapr_hcall (9 tests, 1 skipped)
PASS spapr_vpa (13 tests)
PASS rtas-get-time-of-day (10 tests)
PASS rtas-get-time-of-day-base (10 tests)
PASS rtas-set-time-of-day (5 tests)
PASS emulator (4 tests)
PASS interrupts (13 tests)
FAIL mmu (terminated on SIGKILL)
FAIL smp (terminated on SIGKILL)
FAIL smp-smt (terminated on SIGKILL)
SKIP smp-thread-single (qemu-system-ppc64: -accel tcg,thread=single: 
invalid accelerator tcg)
FAIL atomics (terminated on SIGKILL)
PASS atomics-migration (1 tests)
PASS timebase (12 tests, 1 known failures, 1 skipped)
SKIP timebase-icount (qemu-system-ppc64: -icount shift=5: cannot 
configure icount, TCG support not available)
FAIL h_cede_tm
PASS sprs (14 tests)
FAIL sprs-migration (14 tests, 1 unexpected failures)
PASS sieve

Thanks,
Misbah Anjum N <misanjum@linux.ibm.com>


On 2026-03-10 15:42, Ani Sinha wrote:
>>> This theory is not substantiated by code or evidence.
>>> 98884e0cc10997a17ce9abfd6ff10be19224ca6a introduces kvm_reset_vmfd()
>>> which is called by this block of code with the tip at
>>> 98884e0cc10997a17ce9abfd6ff10be19224ca6a :
>>>   if (!cpus_are_resettable() &&
>>>        (reason == SHUTDOWN_CAUSE_GUEST_RESET ||
>>>         reason == SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET)) {
>>>        if (ac->rebuild_guest) {
>>>            ret = ac->rebuild_guest(current_machine);
>>>            if (ret < 0) {
>>>                error_report("unable to rebuild guest: %s(%d)",
>>>                             strerror(-ret), ret);
>>>                vm_stop(RUN_STATE_INTERNAL_ERROR);
>>>            } else {
>>>                info_report("virtual machine state has been rebuilt 
>>> with new "
>>>                            "guest file handle.");
>>>                guest_state_rebuilt = true;
>>>            }
>>>        } else if (!cpus_are_resettable())  {
>>>            error_report("accelerator does not support reset!");
>>>        } else {
>>>            error_report("accelerator does not support rebuilding 
>>> guest state,"
>>>                         " proceeding with normal reset!");
>>>        }
>>>    }
>>> If cpus are resettable, this block will not be called and nothing 
>>> that
>>> the patch introduces will have been executed.
>>> So I think you guys need to explain a bit more why you so strongly
>>> feel this patch broke it. I am confused and unable to reason this.
>>>> Did you validate your patches on other architectures which does not 
>>>> support this feature yet?
>>> As you have already seen, on other architectures, the entire block of
>>> code is not executed at all. Only SEV-ES, SEV-SNP and TDX currently
>>> exercises this.
>> 
>> I understand your concern about the code path analysis. Let me clarify 
>> our findings with concrete evidence.
>> 
>> Reproducibility Evidence:
>> With commit 98884e0cc10997a17ce9abfd6ff10be19224ca6a applied, we are 
>> able to reproduce the hang issue 100% of the time across multiple test 
>> runs. When we revert to the previous commit 
>> df8df3cb6b743372ebb335bd8404bc3d748da350, the same KVM guest boots 
>> successfully 100% of the time.
>> 
>> This consistent reproducibility strongly indicates that commit 
>> 98884e0cc10997a17ce9abfd6ff10be19224ca6a is introducing the 
>> regression, even if the code path analysis suggests otherwise. This 
>> suggests the issue may not be in the code path, but rather in the 
>> changes introduced by the patch series.
>> 
>> As the author who led the development of this patch series, we would 
>> appreciate your help in figuring out this issue.
> 
> I am really not sure what changes in that patch can cause this
> breakage in a completely unrelated area when the changes are not even
> executed.
> 

