Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F552D42BA3
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 16:05:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAtK0-0004z8-Fs; Tue, 12 Nov 2024 11:00:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tAtE7-0001sz-UP; Tue, 12 Nov 2024 10:54:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brueckner@linux.ibm.com>)
 id 1tAtE4-00015Y-1s; Tue, 12 Nov 2024 10:54:47 -0500
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACBeLoF026543;
 Tue, 12 Nov 2024 15:54:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=mrThCEedQQvZ2UbFf
 wQqapZ5uHmFPIJ5slOmDocSbVU=; b=YdApMzFiTP+IkwFiUcpy7XD3B5vBfeEeh
 50h+2GRDSZWNr7A3eCWm9w0vsD4CMMp6Y8LhVxkLlXR8syp76gd51KIr0raIy/Qh
 fuT6/RLEohjCmmzN1Ij0e1uCf4WKhsUgg141R5JXex4nDjSw3u1k6nn/riITTGaS
 ceS7NEuUa4d/Sna8T9Com0rxTbRqRaKiDWTggBrUig1rnL06DJaXg4p+4vn4MC/F
 noxNVj0k6+MTQqBepP3ohh5e7/qGfraHOFct2KQ4K9hxLCM1hGOIA8ZasMmmNgU0
 b/L+IQKNmPlEnZo9q/eSAheVJWfkI2JNAr6zTyzJEfuq2C6dbHshQ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42v6beh3rc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Nov 2024 15:54:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACEmkdT008076;
 Tue, 12 Nov 2024 15:54:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42tjeyjyun-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 12 Nov 2024 15:54:40 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4ACFsbk234603520
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 12 Nov 2024 15:54:37 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 251C820049;
 Tue, 12 Nov 2024 15:54:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E16AE2004B;
 Tue, 12 Nov 2024 15:54:36 +0000 (GMT)
Received: from vela.boeblingen.de.ibm.com (unknown [9.155.210.79])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 12 Nov 2024 15:54:36 +0000 (GMT)
From: Hendrik Brueckner <brueckner@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, thuth@redhat.com
Cc: nsg@linux.ibm.com, frankja@linux.ibm.com, mimu@linux.ibm.com,
 Hendrik Brueckner <brueckner@linux.ibm.com>
Subject: [RFC PATCH 08/14] s390x/cpumodel: add
 Miscellaneous-Instruction-Extensions Facility 4
Date: Tue, 12 Nov 2024 16:54:13 +0100
Message-ID: <20241112155420.42042-9-brueckner@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241112155420.42042-1-brueckner@linux.ibm.com>
References: <20241112155420.42042-1-brueckner@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5ItkL-zFLIsl27IQE_LGJtNvpJjW8tsa
X-Proofpoint-GUID: 5ItkL-zFLIsl27IQE_LGJtNvpJjW8tsa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=921 phishscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411120125
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=brueckner@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 Nov 2024 11:00:37 -0500
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

This facility introduces few new instructions.

Signed-off-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 target/s390x/cpu_features_def.h.inc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/s390x/cpu_features_def.h.inc b/target/s390x/cpu_features_def.h.inc
index 0b7be0e6e9..8be2e0e46d 100644
--- a/target/s390x/cpu_features_def.h.inc
+++ b/target/s390x/cpu_features_def.h.inc
@@ -90,6 +90,7 @@ DEF_FEAT(EDAT_2, "edat2", STFL, 78, "Enhanced-DAT facility 2")
 DEF_FEAT(DFP_PACKED_CONVERSION, "dfppc", STFL, 80, "Decimal-floating-point packed-conversion facility")
 DEF_FEAT(PPA15, "ppa15", STFL, 81, "PPA15 is installed")
 DEF_FEAT(BPB, "bpb", STFL, 82, "Branch prediction blocking")
+DEF_FEAT(MISC_INSTRUCTION_EXT4, "minste4", STFL, 84, "Miscellaneous-Instruction-Extensions Facility 4")
 DEF_FEAT(MSA_EXT_12, "msa12-base", STFL, 86, "Message-security-assist-extension-12 facility (excluding subfunctions)")
 DEF_FEAT(VECTOR, "vx", STFL, 129, "Vector facility")
 DEF_FEAT(INSTRUCTION_EXEC_PROT, "iep", STFL, 130, "Instruction-execution-protection facility")
-- 
2.43.5


