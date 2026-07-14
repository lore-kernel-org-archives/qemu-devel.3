Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE53DC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 20:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjjnn-0006mK-Kg; Tue, 14 Jul 2026 16:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjjnl-0006lw-Pn; Tue, 14 Jul 2026 16:32:26 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1wjjnk-00055M-Ck; Tue, 14 Jul 2026 16:32:25 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66EJBkud2116293; Tue, 14 Jul 2026 20:32:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=iVmOD+E2KXl45OzVCscLedQsr/iM1JPo5Z2b1jDl8
 EY=; b=U08Qtol4o4pyeEYxzdgIF7rJnPVsTr/BmbgMlEkLDjkF5vVnVTbo5SoWw
 aZtFYYkV7QTzEloVwIqJL5nJgm5cknysRrxm/+6eRkcXAvdH3fo/rN1EOWJzGbD4
 4WsiEZ/nPS7ATFuIuH4FBqnuqDqUPe+UF/zf1xKco+0fxZXRJl96seEgaxi5181a
 BA+3MF9K5k+mThEW1wx/0REXoJ52BFNwNMllbt9AlWa6tpCWEctfau2oZ7APtWMR
 L0QnA0HfxkfwhhWZ0PXMXCSo2riNcsOPYcTqKQePYTQr7wePRCYb6UUlEluKQTvP
 Xb5UUPS4PBB89IFv6MzKBTDyn2LvQ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2a7nhk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 20:32:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66EKJgim018705;
 Tue, 14 Jul 2026 20:32:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc15jvmgr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 14 Jul 2026 20:32:19 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66EKWA6F41353678
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 14 Jul 2026 20:32:11 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9AC502008A;
 Tue, 14 Jul 2026 20:32:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A5BC020078;
 Tue, 14 Jul 2026 20:32:09 +0000 (GMT)
Received: from li-d2cd37cc-2ca3-11b2-a85c-84ed3706e5a0.ibm.com (unknown
 [9.111.27.233]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 14 Jul 2026 20:32:09 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Cc: David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v2 0/2] target/s390x/tcg: Set STCK/STCKF condition code after
 the store
Date: Tue, 14 Jul 2026 22:29:53 +0200
Message-ID: <20260714203206.363028-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDIwOCBTYWx0ZWRfXz4XW/Dq9wVki
 ZpLIUPmx96umLOS5g1h32S1sRk5afnqOPe/vLzSyurjiZoq9SdfywLDK9j2ptLQM52aRAFDux5F
 LUFCc1pwFN4lsOUJaFE4/eEyYatrYtQ=
X-Proofpoint-GUID: ziehbq3Nk9x2ostE98JPe69c1iM5oKZx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDIwOCBTYWx0ZWRfX2CHSOAAttEjp
 pffb7uovyf+97DS3Ewe5GMAHNbNecNADmlEUzXJSuV0N8YS1ml8azpWQKiFgkzH/pEYgLEOi073
 wYla48sWmrGywgNEAIorn9mxz10MOsbBSuMtayZVn2o90JMClUiIt884oJuUNBSzmjDBsDn+ssq
 lXHkqlbv2lI/DaMYXcsyLZnHpcXcajkVKg9ts2/xnZ278aSvch9kV/z2J8puIdwsChX1D4ZaNDF
 WeM4YINnHaLOqvca4/Xm0wsnA4VGSBJSXBNf/STom46T922xYBMIsNRjv44MP0q7sK9HAt7EO2R
 h5iU9T8Kv0SzXeew6EOlq2hVDk9nk01DqzlYtRsS9Qn1dboaNB79WZ6Pqj0m4hJyMu0WDSIjihD
 xqavrjNps0uLrVFuAoctZnWsq+qHUXeSwCFcXqUHyrHBVM1LSFtGC7sFk9Vo/bnn9Q0R2hW+zDl
 ltxsB7H5FiEpTAZ4GVA==
X-Proofpoint-ORIG-GUID: ziehbq3Nk9x2ostE98JPe69c1iM5oKZx
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a569cd4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=Bcv-tN_rAcf9K7wvu9IA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_05,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607140208
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

Hi,

Ido reported an assertion failure after failing STCKF and provided a
small assembly snippet that causes it.

This series fixes the issue and adds a test based on that snippet.

Best regards,
Ilya

Ilya Leoshkevich (2):
  target/s390x/tcg: Set STCK/STCKF condition code after the store
  tests/tcg/s390x: Test STCKF condition code on a faulting store

 target/s390x/tcg/insn-data.h.inc |  4 +--
 target/s390x/tcg/translate.c     |  2 ++
 tests/tcg/s390x/Makefile.target  |  1 +
 tests/tcg/s390x/stckf.c          | 44 ++++++++++++++++++++++++++++++++
 4 files changed, 49 insertions(+), 2 deletions(-)
 create mode 100644 tests/tcg/s390x/stckf.c

-- 
2.55.0


