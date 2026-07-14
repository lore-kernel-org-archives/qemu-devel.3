Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3DC4C4450A
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 19:20:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjifh-0005IX-VT; Tue, 14 Jul 2026 15:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjifg-0005Hc-LZ; Tue, 14 Jul 2026 15:20:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjife-0002Hs-Ve; Tue, 14 Jul 2026 15:20:00 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EJBxMv2176708; Tue, 14 Jul 2026 19:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=/omq2F1lVYIRBb/CmvsnumzCSnEOm0L0ptUdHysVp
 Fc=; b=SmGe9ULx0a14tadunJyZjWizDdHKPEKAonQ6Z7J+uj/y4W1KpAnQMF4fh
 4gSOWADWAFU9qdBa2O95Yh+ssbY3WjtNvXu3zdBIvvJvICDtLPpS0lCXt9KsXy0y
 WqFWoQ0bTLDLP0d59NNikVnSYhAU1gQYRrEt3RFfrPpswXpn3nLaDS5t95Wo8gTI
 iIn3qpLEOlXldVuhUUNgRdfNezYQ7r8n+64/trnaiY4v0QOzlM1PI0/e8IbxndY2
 SOlniYe6L1bPQleBIE8baEL3Q8GNWTwP8tKUCM3dNKMoBGmoHHDQvoMmvC7THylv
 xQkJ12IzRgCUoZ7t3KQyqpT712CKw==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegbqeqf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 19:19:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EJJd6c028896;
 Tue, 14 Jul 2026 19:19:54 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05q4jqj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 19:19:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66EJJoe925100612
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 19:19:50 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1DAB920040;
 Tue, 14 Jul 2026 19:19:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9E71C20043;
 Tue, 14 Jul 2026 19:19:49 +0000 (GMT)
Received: from li-d2cd37cc-2ca3-11b2-a85c-84ed3706e5a0.ibm.com (unknown
 [9.111.27.233]) by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 19:19:49 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Harald Freudenberger <freude@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 0/2] target/s390x: Make PRNO TRNG interruptible
Date: Tue, 14 Jul 2026 21:17:17 +0200
Message-ID: <20260714191948.342204-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a568bdb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=B7UdSxdMZZ_vB3PkcSYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDE5OCBTYWx0ZWRfX1DsbXlGDCIpw
 6Eg+OLNr90RhQi2A8KXu8Yu0jl6EjVKObyTnZ294hUam44bREQg2ItX6F/hVl5CNcRzl8LFhmAX
 E7OoJaQB7/idSqtHd0AfOQGHS2ljx+hQoQk4Kf2Mw3BmdFZqXwyvXpr5Eig5bLEyqNLyfHjayC+
 buiVyO1jAKOHqU+KRfudGKEC9EPeYZBpHcVMtgSu7V69cSI26yPkh23UAFmlXp6sSMDOJuP95bp
 C23Ydmw6Jq7Ql9WaFnEmrHYMkYSyuGJCWj5twAPX1knD0zvyMm24N8r6NTU3Ts9Istx8lLxzCf6
 NJhSm+6rIvJap1+nbyXDL/VxNRRxnNo7PIJb3URyuJqFCpGUBKzAqc4CmluSR8kG6DMyz+c4F1X
 6/XeGda8YgiT0MCzySYlg+HQqS4BMF2USDHYAKisXs96ISgNC5eNtP0bBSnpCTzrLhuHDZShlAG
 6cyMcQzTee8DGzQCfhw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDE5OCBTYWx0ZWRfX4iw2VIMyCNS6
 qWlCD0eSpggpy8ehHaNnqpZOL9DOzRtUGcFw+wPksR1Wg9VGwvlix5biuB3b93/frlWk61NOeDS
 mZFK/VpZPbitE1fCiK9latYxnrLecCQ=
X-Proofpoint-GUID: bL4Bli3XgqqtZ_I9MFlHqcDx35Wk27PK
X-Proofpoint-ORIG-GUID: bL4Bli3XgqqtZ_I9MFlHqcDx35Wk27PK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_05,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140198
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

v1: https://lore.kernel.org/qemu-devel/20260714113946.275122-1-iii@linux.ibm.com/
v1 -> v2: Use cpu_loop_exit_requested() (Richard).
          Apply R-b, since the change is trivial enough.


Hi,

Christian has reported that one can make a TCG guest stuck by running
PRNO TRNG with a huge buffer. This series fixes this by making PRNO
TRNG end on cpu_loop_exit_requested().

Patch 1 is the fix, patch 2 is the test.

Cc: Harald, because this may conflict with the CPACF series.

Best regards,
Ilya


Ilya Leoshkevich (2):
  target/s390x: Make PRNO TRNG interruptible
  tests/tcg/s390x: Test PRNO TRNG interruptibility

 target/s390x/tcg/crypto_helper.c | 22 ++++++++---
 tests/tcg/s390x/Makefile.target  |  1 +
 tests/tcg/s390x/prno-trng.c      | 67 ++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+), 5 deletions(-)
 create mode 100644 tests/tcg/s390x/prno-trng.c

-- 
2.55.0


