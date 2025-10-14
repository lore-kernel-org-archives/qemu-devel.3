Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEA76CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 16:29:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8htI-0005iW-UE; Tue, 14 Oct 2025 12:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v8htC-0005hT-66; Tue, 14 Oct 2025 12:28:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1v8ht9-0000DD-MH; Tue, 14 Oct 2025 12:28:41 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59EBaUxC023819;
 Tue, 14 Oct 2025 16:28:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=towMXVDRdEP3rConWooD2fzWrsQ+bEPd44RlbMDTd
 O0=; b=Ao9gY22/1zF/z7F8gvPG2sFVNvMXkBYR7KoMABK+2hEdIUT2/0M3xfRny
 54RGX0mFc2jAOg4BCs7vW6ueRNH8ymaD2HbkO0KK7pwFvXiNTjP87bMxBvb50BpX
 5Ltpo0z86OV6vk65Bqp+sz4ZmyrTk2wEaLemO77QU2BEaGByTc5skIkY5IalEr1I
 dzIRPaUZ9yge34wXkw51BYqUh1c8iruYfc9sUfhd6cIjWauKU8tdLqsqBtRNdAgA
 VzeJlJf8XdjwjBBb5F7gSRS/a0hc+5Ssh0x64OgMLACMVfi6IJJGAlbcGJVyEmxS
 RuNjI1kpApVaZjls4jsWM1bIE5fXw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qevyy7hr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Oct 2025 16:28:31 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59EF1noh016996;
 Tue, 14 Oct 2025 16:28:30 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r32jut7g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Oct 2025 16:28:30 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 59EGSSu745220222
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Oct 2025 16:28:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E5E3820113;
 Tue, 14 Oct 2025 16:07:46 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 76A8E20112;
 Tue, 14 Oct 2025 16:07:46 +0000 (GMT)
Received: from heavy.ibm.com (unknown [9.111.67.246])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Oct 2025 16:07:46 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 0/3] target/s390x: Fix missing clock-comparator interrupts
Date: Tue, 14 Oct 2025 18:05:12 +0200
Message-ID: <20251014160743.398093-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: tObvuBSWIKjl37WwzVYf_Jvda3BTC8hd
X-Authority-Analysis: v=2.4 cv=eJkeTXp1 c=1 sm=1 tr=0 ts=68ee7a2f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8
 a=PB3oYjNFGLwRpPt26AIA:9 a=HhbK4dLum7pmb74im6QT:22 a=cPQSjfK2_nFv0Q5t_7PE:22
 a=pHzHmUro8NiASowvMSCR:22 a=Ew2E2A-JSTLzCXPT_086:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX+m64OgmglAMJ
 ycQSR4LDufN5aXTftOmCcQ8dSAieTrHEZ4JaTYHbuXO5M6lUxV5fcdHRd0yQ00bMNqyW2hvD71n
 7GU+rvBeNM7Tp5pTuCsZicfxxBOqLrEQ5D7hvriovFhRt3k0XRTum93pc5qNeNGfsnPOlx24hG5
 kwOkDlFb6nuGCcBCJg/ubCUDo9OrLCgj9rQC4YHZkGYgYSdJrvd3/a2y99Yq9I/OTNvTO3o8BDQ
 jr9VBOdY6yFN3YmY3v/LDTKSlfvn2K3X1wOjz/g0BKDDAR7Id849EixMbBx5YI2m4DI1iH/Aqar
 6cgrKcq7GoS9OHMCSQPCSF4W5LHXTZvn/lZa8gBlRews0JS6jM3gxtqfcocivnNUC/cBKs7NNhR
 FtVfNeUU0UcJCRd9++1rAGIFAecG5w==
X-Proofpoint-GUID: tObvuBSWIKjl37WwzVYf_Jvda3BTC8hd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
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

Hi,

While trying to (so far unsuccessfully) reproduce [1], I found two bugs
in the clock comparator handling. This series fixes both and adds a
test.

[1] https://lore.kernel.org/lkml/ab3131a2-c42a-47ff-bf03-e9f68ac053c0@t-8ch.de/

Best regards,
Ilya

Ilya Leoshkevich (3):
  target/s390x: Fix missing interrupts for small CKC values
  target/s390x: Fix missing clock-comparator interrupts after reset
  tests/tcg/s390x: Test SET CLOCK COMPARATOR

 hw/s390x/s390-virtio-ccw.c              |  6 +--
 target/s390x/cpu.c                      |  8 ++++
 target/s390x/tcg/misc_helper.c          | 12 ++++--
 tests/tcg/s390x/Makefile.softmmu-target |  1 +
 tests/tcg/s390x/sckc.S                  | 53 +++++++++++++++++++++++++
 5 files changed, 73 insertions(+), 7 deletions(-)
 create mode 100644 tests/tcg/s390x/sckc.S

-- 
2.51.0


