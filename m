Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E27F2F01827
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 10:53:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vySo1-0006h1-T7; Fri, 06 Mar 2026 05:53:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misanjum@linux.ibm.com>)
 id 1vySnq-0006dh-Dl; Fri, 06 Mar 2026 05:53:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <misanjum@linux.ibm.com>)
 id 1vySnn-0008Lc-JJ; Fri, 06 Mar 2026 05:53:06 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6268NGRf1941479; Fri, 6 Mar 2026 10:52:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=GRb/9ZxVgGfsDZfEOPVKrqp6PL2J
 Osh6V+gjqVEviQQ=; b=XKMCDMtfK0MlL3lMrGJTStVsVOg2rTZ8TzmYPMwYSYdF
 tncFY50ucoNJEPTcoiNWvzGncDHm9jwl4VPkT67+jNEzZznlMmqr2S9U4Lrb0sqI
 XG+tokf7ngDLA0xPg8b6btnBo4oS6odIkTpMBY+i9Uw/9yBGN7WgjTnyrIaTZpjV
 2suahnzPRGgC5hh6i/ogmr5+qDdU9JHyGhqVYvrxJW3KcJtRYpBo62YSt3qEC83K
 bm+d9L8UBb/6N7LAqyPfGyDDWbv2HgMt26An9WsaXc2nFtGDTGrE3mEqiYb8Kqv6
 0K26cUD+NWsRO158cbdLKdfk2PTHQEgVSnDHyXOePg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckssmyjwf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Mar 2026 10:52:58 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6267kDHJ029080;
 Fri, 6 Mar 2026 10:52:57 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cmapsfm9g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Mar 2026 10:52:57 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 626AquTR8978994
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Mar 2026 10:52:57 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B2E4558055;
 Fri,  6 Mar 2026 10:52:56 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4966D58063;
 Fri,  6 Mar 2026 10:52:56 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Mar 2026 10:52:56 +0000 (GMT)
MIME-Version: 1.0
Date: Fri, 06 Mar 2026 16:22:55 +0530
From: Misbah Anjum N <misanjum@linux.ibm.com>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, anisinha@redhat.com, pbonzini@redhat.com
Subject: [BUG] [powerpc] KVM guest boot failure - hangs on startup after
 commit 98884e0c
Message-ID: <e0fa0840fa7758499aa8c64a148e5367@linux.ibm.com>
X-Sender: misanjum@linux.ibm.com
Organization: IBM
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDEwMSBTYWx0ZWRfX8neXklghXiC5
 eP5TlSS50J4M+2RQjLDSYk+fJHO2Xkq8LmUQPnE8lHy3taFjp4VLTawgVJedzX94wJxluOF+BUP
 15QQt7aKlrwRkngezxdNfDm5qxqy7nbLcEz+WsIXO40hlTh8Qa0WPw9pnUFmFvzNCcTAFPP9zxY
 I+G1uDoneTIraYW04gjtaHwNcaUFZEOQ5g1vnsIP4NVAIFjFAYnsKkQXMd1+K1GW5WpYPD4wuw5
 Ta+czrEv+8CLxsw7Xi6x/Q3Pr4GidrjIIzOH9786Rvrh7i5T+BpUpBoQES2TBtw+hANsy0SeX3j
 O/SWC7oTO3B7HYPakjzkg69CO2Sbm1RJhH+QxCsdHLp3y+8choWPsBJDN9BV28a3PF7xMLk7WbL
 Ib9XuAgEtcy8J2FgyUt8oo5HcqdnsSmGk4d9NluvNmlfnmZnVirieQQnhtCQqE+oFensJ6cftpd
 5EI722KzPqGdHvCFhEg==
X-Proofpoint-ORIG-GUID: x7QNeEZmURnZc8sQ0HA4JoOqAsNX09wx
X-Proofpoint-GUID: x7QNeEZmURnZc8sQ0HA4JoOqAsNX09wx
X-Authority-Analysis: v=2.4 cv=AobjHe9P c=1 sm=1 tr=0 ts=69aab20a cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=p0WdMEafAAAA:8
 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=UETNnugvo_MbejD8BVAA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_03,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 malwarescore=0
 spamscore=0 clxscore=1011 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060101
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=misanjum@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: 18
X-Spam_score: 1.8
X-Spam_bar: +
X-Spam_report: (1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, HEXHASH_WORD=2.999, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
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

Hi,
I'm reporting a critical regression on ppc64le that causes all KVM 
guests to hang immediately during startup. Git bisect identified commit 
98884e0cc10997a17ce9abfd6ff10be19224ca6a as the first bad commit. The 
commit completely breaks KVM functionality on ppc64le.

Regression Details:
Working Version: QEMU 10.2.50 (v10.2.0-1669-gffcf1a7981)
Broken Version: QEMU 10.2.50 (v10.2.0-1816-g3fb456e9a0)
Bad Commit: 98884e0cc10997a17ce9abfd6ff10be19224ca6a "accel/kvm: add 
changes required to support KVM VM file descriptor change"
Commit Link: 
https://gitlab.com/qemu-project/qemu/-/commit/98884e0cc10997a17ce9abfd6ff10be19224ca6a

Environment:
Host: Fedora 42, Kernel 7.0.0-rc2, Power11 (ppc64le)
Libvirt: 12.1.0
Guest: Fedora 42, Kernel 7.0.0-rc2
Machine Type: pseries with KVM acceleration

Build Configuration:
git clone https://gitlab.com/qemu-project/qemu.git
cd qemu
git submodule init
git submodule update --recursive
./configure --target-list=ppc64-softmmu --disable-tcg --prefix=/usr
make && make install

Reproduction:
Using virt-install:
/usr/bin/virt-install --connect=qemu:///system --hvm --accelerate --name 
'avocado-vt-vm1' --machine pseries --memory=32768 
--vcpu=32,sockets=1,cores=32,threads=1 --import --nographics 
--os-variant rhel8.0 --serial pty --memballoon model=virtio --controller 
type=scsi,model=virtio-scsi --disk 
path=/home/kvmci/tests/data/avocado-vt/images/rhel8.0devel-ppc64le.qcow2,bus=scsi,size=10,format=qcow2 
--network=bridge=virbr0,model=virtio --boot 
emulator=/usr/bin/qemu-system-ppc64
Result: Starting install...
         <hangs indefinitely with no output>

Using direct QEMU command:
/usr/bin/qemu-system-ppc64 -name avocado-vt-vm1 -machine 
pseries,accel=kvm -enable-kvm -m 32768 -smp 
32,sockets=1,cores=32,threads=1 -nographic -serial pty -device 
virtio-balloon -device virtio-scsi-pci,id=scsi0 -drive 
file=/home/kvmci/tests/data/avocado-vt/images/rhel8.0devel-ppc64le.qcow2,if=none,id=drive-scsi0-0-0,format=qcow2 
-device scsi-hd,bus=scsi0.0,drive=drive-scsi0-0-0 -netdev 
bridge,id=net0,br=virbr0 -device virtio-net-pci,netdev=net0
Result: <hangs indefinitely with no output>

Analysis:
The commit introduces VM file descriptor change support with 
architecture-specific hooks.
I attempted the following fixes without success:
1. Changed abort() to return 0; in stubs/kvm.c
2. Added early return in kvm_reset_vmfd() when 
kvm_arch_supports_vmfd_change() returns false

Git Bisect Log:
# git bisect bad
98884e0cc10997a17ce9abfd6ff10be19224ca6a is the first bad commit
commit 98884e0cc10997a17ce9abfd6ff10be19224ca6a (HEAD)
Author: Ani Sinha <anisinha@redhat.com>
Date:   Wed Feb 25 09:19:10 2026 +0530

     accel/kvm: add changes required to support KVM VM file descriptor 
change

     This change adds common kvm specific support to handle KVM VM file 
descriptor
     change. KVM VM file descriptor can change as a part of confidential 
guest reset
     mechanism. A new function api kvm_arch_on_vmfd_change() per
     architecture platform is added in order to implement architecture 
specific
     changes required to support it. A subsequent patch will add x86 
specific
     implementation for kvm_arch_on_vmfd_change() as currently only x86 
supports
     confidential guest reset.

     Signed-off-by: Ani Sinha <anisinha@redhat.com>
     Link: 
https://lore.kernel.org/r/20260225035000.385950-6-anisinha@redhat.com
     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

  MAINTAINERS            |  6 ++++++
  accel/kvm/kvm-all.c    | 88 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
  accel/kvm/trace-events |  1 +
  include/system/kvm.h   |  3 +++
  stubs/kvm.c            | 22 ++++++++++++++++++++++
  stubs/meson.build      |  1 +
  target/i386/kvm/kvm.c  | 10 ++++++++++
  7 files changed, 128 insertions(+), 3 deletions(-)
  create mode 100644 stubs/kvm.c

# git bisect log
git bisect start
git bisect good ffcf1a7981793973ffbd8100a7c3c6042d02ae23
git bisect bad 3fb456e9a0e9eef6a71d9b49bfff596a0f0046e9
git bisect bad e76c30bb13ecb9dc716fa629954bfb6253056ce2
git bisect good 9bdc612a18588975f5776ee4e562df607fea1b2c
git bisect bad 40c015e96942fd2a3e4d5ace6063b3333a3dd372
git bisect good df8df3cb6b743372ebb335bd8404bc3d748da350
git bisect bad 0f53f021ad1ede28dc8944686544e496cab02e5e
git bisect bad 9f0c2b3032639315faf141010a2603b0dbf56230
git bisect bad 98884e0cc10997a17ce9abfd6ff10be19224ca6a
first bad commit: [98884e0cc10997a17ce9abfd6ff10be19224ca6a]

Thanks,
Misbah Anjum N <misanjum@linux.ibm.com>

