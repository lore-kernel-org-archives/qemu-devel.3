Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF722CA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 22:38:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umgaM-0006Uf-RI; Thu, 14 Aug 2025 18:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1umgaK-0006SQ-HA; Thu, 14 Aug 2025 18:38:12 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1umgaH-0005SQ-Ka; Thu, 14 Aug 2025 18:38:12 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57EEVStj008526;
 Thu, 14 Aug 2025 22:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=x/hY+X7vCBYccp6aQkqc89H0iGxbWydHA+x5tttpB
 Ek=; b=SqrZTa68MxyFXgfQiyujQLV3Mfe8mooR8J3qglJa4QtQUdyiw1tFqCvZ/
 0y23xm3g+98CdWKX7aIrthd6mTKdqMhd7CK84jHgmf3bm47ElV2j51FrDhD8pyWC
 /lRcAq6e+yClb4kE+Rs7vCCTDDiRg6FnWOv8k5Z7Gh04VSxreDdM56oIGCe3j9xC
 7ImDWYkt2s84bRRlmvB5wrpt1v7PzI9YwcXXLiMOIpVUj/vPNofruIwh16WxymTp
 IWazuo36FiPF/L+ty45eAyd2aBZUA6SvxPFrlxwq3UrYPXsstso0r6cQ+BWjqYG2
 +WoY679sOwuXUMj/AiM5kT8c1F2kg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48ehaah4nc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Aug 2025 22:38:05 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57EMc54x001958;
 Thu, 14 Aug 2025 22:38:05 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48ehaah4n8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Aug 2025 22:38:05 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57EMYR2B017606;
 Thu, 14 Aug 2025 22:38:04 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ekc3x3he-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 14 Aug 2025 22:38:04 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 57EMc3Pp30868132
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 14 Aug 2025 22:38:03 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0F0C958050;
 Thu, 14 Aug 2025 22:38:03 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7072F58052;
 Thu, 14 Aug 2025 22:38:02 +0000 (GMT)
Received: from mglenn-KVM.. (unknown [9.10.239.198])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 14 Aug 2025 22:38:02 +0000 (GMT)
From: Glenn Miles <milesg@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>, qemu-ppc@nongnu.org, clg@redhat.com,
 npiggin@gmail.com, harshpb@linux.ibm.com
Subject: [RFC 0/3] Add IBM PPE42 support
Date: Thu, 14 Aug 2025 17:37:31 -0500
Message-ID: <20250814223741.29433-1-milesg@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KPRaDEFo c=1 sm=1 tr=0 ts=689e654d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=jRLB2SoPAAAA:8 a=NEAV23lmAAAA:8 a=1n2-_YmxxEDraPXalgcA:9
 a=yloqiLrygL2q3s9aD-8D:22
X-Proofpoint-ORIG-GUID: 3feAYPHmHtpb8tBjF4yyBom0v7s2DrGS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDIyNCBTYWx0ZWRfX2dGY6LLq0Tdz
 yHeFwgM1eWv2uzbup407qqS3Q9IVF+zlzP2QV1bO5tB7IOpfzqhdJzPykLa6bI2/ErHeBe6pr2O
 9iFHtljotmbZsO81F2qc0li6k3LWoFaet8arSIN62ayF/AaObyqva3EDADErDvRb9h/3qQE4Vrw
 jhrSuKtzc2/TsFaVaynkGF0n5koIxRihhwyztiSIAMtFWJb/6xGxJ9X2BcR+yf4JmxeMhaP8+oi
 0p0si8CqqkLznYrfUCohypG48ZQiNsUkylIDMbK0Q17oDRy5hhteVZweQ1u6Xkux+D3mqlQ4PPG
 Um3wxvUHwPTg+h75MpzG8WsZH4/FTa5JLXL2lJP48YShHu3E1RxytQ40Wj7O2DXiUgcbHgCE0uH
 iC3v35g5
X-Proofpoint-GUID: ARlKN_sVSkaY6czTFJwLKtBsumewD6WV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-14_02,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508120224
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
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

I am introducing this patchset as an RFC primarily so that
I can get some advice on how to go about testing this CPU.
Please read on for details...

This patchset adds support for the IBM PPE42 processor,
including a simple machine providing a platform for
testing the PPE42 instructions.

The PPE42 processor is used as an embedded processor in
the IBM Power9, Power10 and Power12 processors for various
tasks.  It is basically a stripped down version of the
IBM PowerPC 405 processor, with some added instructions
for handling 64-bit loads and stores and some 64-bit
logical operations.
    
For more information on the PPE 42 processor please visit:
    
https://wiki.raptorcs.com/w/images/a/a3/PPE_42X_Core_Users_Manual.pdf

I have some code that tests the instructions that are
specific to the PPE42.  It is a very basic test written
in assembly.  This can be found at:

https://github.com/milesg-github/ppe42-tests

There is also a prebuilt image there in the images
folder.

Building the image requires a forked version of an old
version of GCC, which can be found here:

https://github.com/open-power/ppe42-gcc

Even though everything that is necessary to build the
image is publicly available, it is not a simple task.
This is why I think it would be best to just use the
prebuilt image available on github instead of trying to
build it.

Also, there is currently no support for having console
output (this is also not supported in the actual HW).
All logging on actual hardware is done using in-memory
trace buffers that requires a special tool for translation
to a human readable format. Because of this, I'm thinking
this is not a good candidate for using the QEMU
"tests/functional" framework, which seems to rely a lot
on console output.

I do think it would be possible to use the qtest framework
to load the image and run it.

The existing test will cause a checkstop if it fails.
This leads to dumping the cpu registers, which aids in
debug.  There is currently no way to tell that the
test completed, other than checking the NIP address,
but this could be easily remedied by having the guest
code write some status to a fixed memory address and
then having the qtest code poll that memory address
to determine that the test completed within some reasonable
timeout period.

The one thing that I'm not sure about with using the
qtest framework is how to retrieve the image. If anyone
has suggestions or examples of that being done for a qtest,
please do share!

Also, if you think there is a better way to do this instead
of using qtest, please let me know.

Thanks,

Glenn

Glenn Miles (3):
  target/ppc: Add IBM PPE42 family of processors
  target/ppc: Add IBM PPE42 special instructions
  hw/ppc: Add a test machine for the IBM PPE42 CPU

 hw/ppc/Kconfig                      |   9 +
 hw/ppc/meson.build                  |   2 +
 hw/ppc/ppc_booke.c                  |   7 +-
 hw/ppc/ppe42_machine.c              |  69 +++
 include/hw/ppc/ppc.h                |   1 +
 target/ppc/cpu-models.c             |   7 +
 target/ppc/cpu-models.h             |   4 +
 target/ppc/cpu.h                    |  66 ++-
 target/ppc/cpu_init.c               | 286 ++++++++--
 target/ppc/excp_helper.c            | 171 ++++++
 target/ppc/helper_regs.c            |  30 +-
 target/ppc/insn32.decode            |  66 ++-
 target/ppc/tcg-excp_helper.c        |  12 +
 target/ppc/translate.c              |  35 +-
 target/ppc/translate/ppe-impl.c.inc | 805 ++++++++++++++++++++++++++++
 15 files changed, 1514 insertions(+), 56 deletions(-)
 create mode 100644 hw/ppc/ppe42_machine.c
 create mode 100644 target/ppc/translate/ppe-impl.c.inc

-- 
2.43.0


