Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F7ECD3000A
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 13:41:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1nDL-00075z-FY; Fri, 18 Oct 2024 09:40:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t1nDJ-000756-QL; Fri, 18 Oct 2024 09:40:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1t1nDI-0001gE-0L; Fri, 18 Oct 2024 09:40:21 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IA86gc014840;
 Fri, 18 Oct 2024 13:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=Hqr7pG
 ln3zixPvjDaGq+216Npx+0IDnaZG6qi8edrK8=; b=MQs9omOsUwyKvd3urdKUwF
 IlSWvUxmKG/qI0+fp2b2EwSFaf3ICNMt9iyPefTMoswpHanoe3ZTQzG+eKyhtiE7
 yMphlZiZwiuDXDV8vkCbb1DXjIj9ihDnclNDjKhVRymSncLGTFogZG5jyevt3Frr
 x3MPTl1tEH4KFOyfXVx8MkuB4VUssfHeMaPbhmYfixIZJQBiC8RfwR6DDC0q7d8U
 gmbAOxuxRiTd6JY45wv3NKEIIuyDq5h13TbGj8onlfg1kKPZ/uA2zP7wYauyjjiU
 4lr/SKzwrcI87J9ou1iPKPV8vORa8Mx/9K5TMS4QsF9SCXprDmTa/jKqCsxf7SNg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42aqgr94v1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Oct 2024 13:40:17 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49IB9WDR027499;
 Fri, 18 Oct 2024 13:40:16 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4283ty4wx0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 18 Oct 2024 13:40:16 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49IDeGDl14484036
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 18 Oct 2024 13:40:16 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6130F58043;
 Fri, 18 Oct 2024 13:40:16 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CA3C05805D;
 Fri, 18 Oct 2024 13:40:15 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 18 Oct 2024 13:40:15 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Stefan Berger <stefanb@linux.ibm.com>,
 qemu-stable@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL v1 3/3] tests: Wait for migration completion on destination
 QEMU to avoid failures
Date: Fri, 18 Oct 2024 09:40:04 -0400
Message-ID: <20241018134004.2110276-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241018134004.2110276-1-stefanb@linux.ibm.com>
References: <20241018134004.2110276-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1RPzNwBbzJHVVpVA7oqEmlxASimqLt8f
X-Proofpoint-GUID: 1RPzNwBbzJHVVpVA7oqEmlxASimqLt8f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 phishscore=0 mlxlogscore=883 malwarescore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 spamscore=0 mlxscore=0 suspectscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410180085
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Rather than waiting for the completion of migration on the source side,
wait for it on the destination QEMU side to avoid accessing the TPM TIS
memory mapped registers before QEMU could restore their state. This
error condition could be triggered on busy systems where the destination
QEMU did not have enough time to restore the TIS state while the test case
was already reading its registers. The test case was for example reading
the STS register and received an unexpected value (0xffffffff), which
lead to a segmentation fault later on due to trying to read 0xffff bytes
from the TIS into a buffer.

Cc:  <qemu-stable@nongnu.org>
Reported-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 tests/qtest/tpm-tests.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/tpm-tests.c b/tests/qtest/tpm-tests.c
index fb94496bbd..197714f8d9 100644
--- a/tests/qtest/tpm-tests.c
+++ b/tests/qtest/tpm-tests.c
@@ -114,7 +114,7 @@ void tpm_test_swtpm_migration_test(const char *src_tpm_path,
                      sizeof(tpm_pcrread_resp));
 
     tpm_util_migrate(src_qemu, uri);
-    tpm_util_wait_for_migration_complete(src_qemu);
+    tpm_util_wait_for_migration_complete(dst_qemu);
 
     tpm_util_pcrread(dst_qemu, tx, tpm_pcrread_resp,
                      sizeof(tpm_pcrread_resp));
-- 
2.47.0


