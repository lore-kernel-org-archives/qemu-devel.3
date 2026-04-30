Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E03FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 15:52:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wITgq-00023F-Qj; Thu, 30 Apr 2026 11:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wITgI-0001sC-AL
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:52:05 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1wITgF-0004hh-3u
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 11:52:00 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63UAaD7i1973593; Thu, 30 Apr 2026 15:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=DoyQCSGHIU/ZbjCtBGbb9+jz4nDHo9rL99JZUsnHx
 DY=; b=j6xbeubIPwKx2Fhm1Krmin5OXpOzlMqwHKUvrwHIWTafmv22NddW9AnAj
 x0nDgIpd1GkaY4K0yN+bbh1aDblZYJ+CFRMoSLd2eX1+fXtjAM6HyGW/hMPlVge3
 NHyRTGp9H3oa6fqyC9W1P6se50wfdARa4QrHI9D0AEnnHOZNtWlmcFQzmpQZcF/+
 aGurTO7EjBT68RxpoZiJB373S8BXR/u9VsCNKzJYxD+dbVMB4/Ds5uI5b2IgZlnp
 hCWnImkFsh7UYqdpkvTVv3a5snDUTQ1YKRdoiZYobRSCXty35ajKsvSWm4HQ2fEJ
 nS+Ms75dHaUaf4NKCks/lCuqzfa9A==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drn450rdk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 15:51:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63UFcjqk007202;
 Thu, 30 Apr 2026 15:51:55 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ds7xqkt24-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 30 Apr 2026 15:51:55 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63UFpseC23986940
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Apr 2026 15:51:55 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B9BCA5805A;
 Thu, 30 Apr 2026 15:51:54 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1E9A758054;
 Thu, 30 Apr 2026 15:51:54 +0000 (GMT)
Received: from mycroft-2.pok.ibm.com (unknown [9.47.158.222])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 30 Apr 2026 15:51:53 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, armenon@redhat.com, philmd@linaro.org,
 Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 0/2] Improve handling of response buffer size in
 tpm_emulator
Date: Thu, 30 Apr 2026 15:51:48 +0000
Message-ID: <20260430155150.2139517-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rzUi93Uh1TRDDJTBslMEyDmWIozMILkd
X-Authority-Analysis: v=2.4 cv=Ft81OWrq c=1 sm=1 tr=0 ts=69f37a9c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=N2rsYAxtXKW1HIGbKkMA:9 a=ZXulRonScM0A:10
X-Proofpoint-GUID: rzUi93Uh1TRDDJTBslMEyDmWIozMILkd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDMwMDE2MyBTYWx0ZWRfX/M7/nYhLJ1FG
 1fFd4oAJNvIcwMUMQ/nFxfKkHtWG4IrkFUfB0iWT6ZbL2xvxek23WN237xBnugS+4fZCt1oZ6Fk
 GSykwgSMMgzV3HIR997Bv5v0vRqyeAOnxMgvk8tQiYX/fxEYjk7egD31X4SrN3NJZIHdbYejvdZ
 vtiDECh1U5OOKK1nmvl5COckAZtxgtAIfbQfxT3SMT/m0HuybRQkkHjQeeoquFFcLnc/04WOXQp
 A/QhohiBtOvwsj8+qsEKqovNQyvYTsHGu+qjEYm6/7V+FQirr4SLinK9uC5cmUAOToN3N9TqlNy
 mqc0i+0y/TgkYuBP+oYKBBZ++3Jhu2Sr7cVf2IIxfOX04dW7vzZIUgtYX56kI1dseTGjwHy7Qhl
 OfVkZYFf2fbFSwyKzY8kmK318Wrh9s2H+vh/zATh0lVLi5hZInLy5TwXleZS2tAJllyJK8qZ3mJ
 JQ9c5RzgNOn2WRh/vKg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-30_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604300163
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series addresses some issues with the handling of the negotiated
buffer size that the TPM frontends tell the tpm_emulator (swtpm) to use.
Also, it improves on limiting the number of bytes read from the packet
sent from swtpm.

   Stefan

v3:
 - Changed 1/2 to require exact match of requested buffer size
 - Fixed to_read

Stefan Berger (2):
  tpm_emulator: Reject a buffer size different than what was requested
  tpm_emulator: Limit number of bytes read to negotiated buffer size

 backends/tpm/tpm_emulator.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

-- 
2.43.0


