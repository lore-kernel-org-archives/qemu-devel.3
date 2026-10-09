Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F937CA601F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 18:59:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFFoD-0002rd-TF; Fri, 09 Oct 2026 14:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1xFFnr-0002op-2n; Fri, 09 Oct 2026 14:58:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1xFFno-0004aY-IL; Fri, 09 Oct 2026 14:58:46 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 699HaBAo699778; Fri, 9 Oct 2026 18:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=iCZO7dLO0jFn2JYfO
 SJgyjIDhn7OqYcujdICk5TLzrA=; b=AIr8pXZXhBlIaJaI+6aZPnXosCjb9RFkL
 AVRqSnVtX6RvtJWYkioJTZjZp71yc2m06d+/WwlRfGrHjJ1EUyTepcbOu9btParM
 jdqPCZpByIgo7vH3o5wIYzSoYplNipGgSKsw06f49HuIv0MZQwxaEslniQr0TGRX
 Sd/3FBPmIjZ3gix3t02dZ5YbaXQeMtpaTfOKtddpBEYTINpTg8s3Rwaac3htCbIy
 i4R73mUSDXVD1JG5Vbb2g6+5JCGlPA6qh9iWFBQvAwYwHHMCgAzVvQ/Ctdyi1sJx
 x3G2HTrbXPl2wCTbKMVvaI4EIcTrUrvuUJrHeLijNWs82OaSr7lFw==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h74terd6p-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 18:58:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 699H8FtM1142919; Fri, 9 Oct 2026 18:58:38 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6udd2epr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 09 Oct 2026 18:58:38 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 699IwbYe5505934
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 9 Oct 2026 18:58:37 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 35B6358059;
 Fri,  9 Oct 2026 18:58:37 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7FB2F58043;
 Fri,  9 Oct 2026 18:58:36 +0000 (GMT)
Received: from li-d664314c-3171-11b2-a85c-fa8047ef35bd.ibm.com.com (unknown
 [9.67.47.107]) by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  9 Oct 2026 18:58:36 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-stable@nongnu.org
Subject: [PATCH v2 1/2] target/s390x: externalize feat dependency array
Date: Fri,  9 Oct 2026 14:55:58 -0400
Message-ID: <20261009185559.144750-2-walling@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009185559.144750-1-walling@linux.ibm.com>
References: <20261009185559.144750-1-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA3NCBTYWx0ZWRfXzmqTj4EneL3V
 XEUCxrK47kn7LgKnzkCYIzKuLVwBfpLl/ggadiIz8KjV2wZ5IwT9yNoI2k6PWcwF6PtydkoDgcM
 YESKeSCaOh6f4n6L2WY/eazc/kvypiY=
X-Proofpoint-GUID: B9Ecr48wVmH-b3LdVLFfIybeMhwX3zfR
X-Authority-Analysis: v=2.4 cv=P42vFSAu c=1 sm=1 tr=0 ts=6ac9395f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=J9yxhjP8jEmLe4H_R3sA:9
X-Proofpoint-ORIG-GUID: B9Ecr48wVmH-b3LdVLFfIybeMhwX3zfR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA3NCBTYWx0ZWRfX8gL90xG79ale
 1pg7Xg9Von2JmO7xYSHxwb9hGYU3ruxgIahJ+wvclITGCxrbzoZFTLOHxit7HtPC+6CE6q8osYb
 5akbsFMyJbpocmf3fH3gvIhRTiRUH3i0ZwvmJI9BlAkpG59Aj6V9hqpuvQ/Ym00BbF/BYDaLpDI
 YhlUOee0GvLDUAOl2AOUgqF923RvHrFLPRqqFsArVeGSXgqso/nobZkf4y2JKcDlTDXTHUtEVF6
 8UNceS9HcrC/3lOCsrISV8aYJGkERfK6WevT6QeUcvH4cstRYDOqMO4wcF3boLFKYu83pPA180D
 g3qQnARNAtpPK8Velw1UdYqRnZwStj9nvsqrHQuHtQ8qDjcVGYDIDUhCJ4i8eVt9CWr/EsWvrcP
 YG5MRF67SQzlfvCRymbl5rcvtnmzLEI7ItQZzQy823alwTgnCAx1sBugofTJnStpZjQiKWmYjoI
 36+0xyUNM4dRAJWijQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_05,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1011 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610090074
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, UPPERCASE_50_75=0.008 autolearn=ham autolearn_force=no
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

Move the feature dependency array (dep[][2]) from cpu_models.c to
cpu_features.c, rename the array to s390_feat_deps, and externalize
its length.

This will allow the array to be used between both files.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 target/s390x/cpu_features.c | 126 ++++++++++++++++++++++++++++++++++
 target/s390x/cpu_features.h |   4 ++
 target/s390x/cpu_models.c   | 133 ++----------------------------------
 3 files changed, 135 insertions(+), 128 deletions(-)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index c634e741236..20f9947c7be 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -223,6 +223,132 @@ void s390_feat_bitmap_to_ascii(const S390FeatBitmap features, void *opaque,
     };
 }
 
+const int s390_feat_deps[][2] = {
+    { S390_FEAT_IPTE_RANGE, S390_FEAT_DAT_ENH },
+    { S390_FEAT_IDTE_SEGMENT, S390_FEAT_DAT_ENH },
+    { S390_FEAT_IDTE_REGION, S390_FEAT_DAT_ENH },
+    { S390_FEAT_IDTE_REGION, S390_FEAT_IDTE_SEGMENT },
+    { S390_FEAT_LOCAL_TLB_CLEARING, S390_FEAT_DAT_ENH},
+    { S390_FEAT_LONG_DISPLACEMENT_FAST, S390_FEAT_LONG_DISPLACEMENT },
+    { S390_FEAT_DFP_FAST, S390_FEAT_DFP },
+    { S390_FEAT_TRANSACTIONAL_EXE, S390_FEAT_STFLE_49 },
+    { S390_FEAT_EDAT_2, S390_FEAT_EDAT},
+    { S390_FEAT_MSA_EXT_5, S390_FEAT_KIMD_SHA_512 },
+    { S390_FEAT_MSA_EXT_5, S390_FEAT_KLMD_SHA_512 },
+    { S390_FEAT_MSA_EXT_4, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_SIE_CMMA, S390_FEAT_CMM },
+    { S390_FEAT_SIE_CMMA, S390_FEAT_SIE_GSLS },
+    { S390_FEAT_SIE_PFMFI, S390_FEAT_EDAT },
+    { S390_FEAT_MSA_EXT_8, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_MSA_EXT_9, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_MSA_EXT_9, S390_FEAT_MSA_EXT_4 },
+    { S390_FEAT_MULTIPLE_EPOCH, S390_FEAT_TOD_CLOCK_STEERING },
+    { S390_FEAT_VECTOR_PACKED_DECIMAL, S390_FEAT_VECTOR },
+    { S390_FEAT_VECTOR_PACKED_DECIMAL_ENH, S390_FEAT_VECTOR_PACKED_DECIMAL },
+    { S390_FEAT_VECTOR_PACKED_DECIMAL_ENH2, S390_FEAT_VECTOR_PACKED_DECIMAL_ENH },
+    { S390_FEAT_VECTOR_PACKED_DECIMAL_ENH3, S390_FEAT_VECTOR_PACKED_DECIMAL_ENH2 },
+    { S390_FEAT_VECTOR_ENH, S390_FEAT_VECTOR },
+    { S390_FEAT_VECTOR_ENH2, S390_FEAT_VECTOR_ENH },
+    { S390_FEAT_VECTOR_ENH3, S390_FEAT_VECTOR_ENH2 },
+    { S390_FEAT_INSTRUCTION_EXEC_PROT, S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2 },
+    { S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2, S390_FEAT_ESOP },
+    { S390_FEAT_CMM_NT, S390_FEAT_CMM },
+    { S390_FEAT_GUARDED_STORAGE, S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2 },
+    { S390_FEAT_MULTIPLE_EPOCH, S390_FEAT_STORE_CLOCK_FAST },
+    { S390_FEAT_MULTIPLE_EPOCH, S390_FEAT_TOD_CLOCK_STEERING },
+    { S390_FEAT_SEMAPHORE_ASSIST, S390_FEAT_STFLE_49 },
+    { S390_FEAT_KIMD_SHA3_224, S390_FEAT_MSA },
+    { S390_FEAT_KIMD_SHA3_256, S390_FEAT_MSA },
+    { S390_FEAT_KIMD_SHA3_384, S390_FEAT_MSA },
+    { S390_FEAT_KIMD_SHA3_512, S390_FEAT_MSA },
+    { S390_FEAT_KIMD_SHAKE_128, S390_FEAT_MSA },
+    { S390_FEAT_KIMD_SHAKE_256, S390_FEAT_MSA },
+    { S390_FEAT_KLMD_SHA3_224, S390_FEAT_MSA },
+    { S390_FEAT_KLMD_SHA3_256, S390_FEAT_MSA },
+    { S390_FEAT_KLMD_SHA3_384, S390_FEAT_MSA },
+    { S390_FEAT_KLMD_SHA3_512, S390_FEAT_MSA },
+    { S390_FEAT_KLMD_SHAKE_128, S390_FEAT_MSA },
+    { S390_FEAT_KLMD_SHAKE_256, S390_FEAT_MSA },
+    { S390_FEAT_KMAC_HMAC_SHA_224, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_KMAC_HMAC_SHA_256, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_KMAC_HMAC_SHA_384, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_KMAC_HMAC_SHA_512, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_KMAC_HMAC_ESHA_224, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_KMAC_HMAC_ESHA_256, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_KMAC_HMAC_ESHA_384, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_KMAC_HMAC_ESHA_512, S390_FEAT_MSA_EXT_3 },
+    { S390_FEAT_KM_FULL_XTS_AES_128, S390_FEAT_MSA_EXT_4 },
+    { S390_FEAT_KM_FULL_XTS_AES_256, S390_FEAT_MSA_EXT_4 },
+    { S390_FEAT_KM_FULL_XTS_EAES_128, S390_FEAT_MSA_EXT_4 },
+    { S390_FEAT_KM_FULL_XTS_EAES_256, S390_FEAT_MSA_EXT_4 },
+    { S390_FEAT_PRNO_TRNG_QRTCR, S390_FEAT_MSA_EXT_5 },
+    { S390_FEAT_PRNO_TRNG, S390_FEAT_MSA_EXT_5 },
+    { S390_FEAT_SIE_KSS, S390_FEAT_SIE_F2 },
+    { S390_FEAT_AP_QUERY_CONFIG_INFO, S390_FEAT_AP },
+    { S390_FEAT_AP_FACILITIES_TEST, S390_FEAT_AP },
+    { S390_FEAT_PTFF_QSIE, S390_FEAT_MULTIPLE_EPOCH },
+    { S390_FEAT_PTFF_QTOUE, S390_FEAT_MULTIPLE_EPOCH },
+    { S390_FEAT_PTFF_STOE, S390_FEAT_MULTIPLE_EPOCH },
+    { S390_FEAT_PTFF_STOUE, S390_FEAT_MULTIPLE_EPOCH },
+    { S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL, S390_FEAT_AP },
+    { S390_FEAT_DIAG_318, S390_FEAT_EXTENDED_LENGTH_SCCB },
+    { S390_FEAT_CERT_STORE, S390_FEAT_EXTENDED_LENGTH_SCCB },
+    { S390_FEAT_SIPL, S390_FEAT_EXTENDED_LENGTH_SCCB },
+    { S390_FEAT_SCLAF, S390_FEAT_EXTENDED_LENGTH_SCCB },
+    { S390_FEAT_SCLAF, S390_FEAT_SIPL },
+    { S390_FEAT_NNPA, S390_FEAT_VECTOR },
+    { S390_FEAT_RDP, S390_FEAT_LOCAL_TLB_CLEARING },
+    { S390_FEAT_UV_FEAT_AP, S390_FEAT_AP },
+    { S390_FEAT_UV_FEAT_AP_INTR, S390_FEAT_UV_FEAT_AP },
+    { S390_FEAT_PFCR_QAF, S390_FEAT_CCF_BASE },
+    { S390_FEAT_PFCR_CSDST, S390_FEAT_CCF_BASE },
+    { S390_FEAT_PFCR_CSDSTG, S390_FEAT_CCF_BASE },
+    { S390_FEAT_PFCR_CSTST, S390_FEAT_CCF_BASE },
+    { S390_FEAT_PFCR_CSTSTG, S390_FEAT_CCF_BASE },
+    { S390_FEAT_INEFF_NC_TX, S390_FEAT_TRANSACTIONAL_EXE },
+    { S390_FEAT_PLO_CLO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_CSO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_DCSO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_CSSTO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_CSDSTO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_CSTSTO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TCS, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TCSG, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TCSX, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TCSO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QCS, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QCSG, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QCSX, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QCSO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_LO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_DLX, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_DLO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TL, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TLG, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TLX, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TLO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QL, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QLG, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QLX, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QLO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_STO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_DST, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_DSTG, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_DSTX, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_DSTO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TST, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TSTG, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TSTX, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_TSTO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QST, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QSTG, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QSTX, S390_FEAT_PLO_EXT },
+    { S390_FEAT_PLO_QSTO, S390_FEAT_PLO_EXT },
+    { S390_FEAT_SIE_ASTFLEIE2, S390_FEAT_STFLE },
+};
+
+const size_t s390_feat_deps_len = ARRAY_SIZE(s390_feat_deps);
+
 void s390_get_deprecated_features(S390FeatBitmap features)
 {
     static const int feats[] = {
diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index 421978faa40..8097b219599 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -57,6 +57,10 @@ typedef struct {
     int bit;                /* bit within the feature type area (fixed) */
 } S390FeatDef;
 
+/* Tuple of features[][0] that depend on other features[][1] */
+extern const int s390_feat_deps[][2];
+extern const size_t s390_feat_deps_len;
+
 /* use ordinary bitmap operations to work with features */
 typedef unsigned long S390FeatBitmap[BITS_TO_LONGS(S390_FEAT_MAX)];
 
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index c41d629d680..c30ea2df175 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -440,137 +440,14 @@ void s390_cpu_list(void)
 
 static void check_consistency(const S390CPUModel *model)
 {
-    static int dep[][2] = {
-        { S390_FEAT_IPTE_RANGE, S390_FEAT_DAT_ENH },
-        { S390_FEAT_IDTE_SEGMENT, S390_FEAT_DAT_ENH },
-        { S390_FEAT_IDTE_REGION, S390_FEAT_DAT_ENH },
-        { S390_FEAT_IDTE_REGION, S390_FEAT_IDTE_SEGMENT },
-        { S390_FEAT_LOCAL_TLB_CLEARING, S390_FEAT_DAT_ENH},
-        { S390_FEAT_LONG_DISPLACEMENT_FAST, S390_FEAT_LONG_DISPLACEMENT },
-        { S390_FEAT_DFP_FAST, S390_FEAT_DFP },
-        { S390_FEAT_TRANSACTIONAL_EXE, S390_FEAT_STFLE_49 },
-        { S390_FEAT_EDAT_2, S390_FEAT_EDAT},
-        { S390_FEAT_MSA_EXT_5, S390_FEAT_KIMD_SHA_512 },
-        { S390_FEAT_MSA_EXT_5, S390_FEAT_KLMD_SHA_512 },
-        { S390_FEAT_MSA_EXT_4, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_SIE_CMMA, S390_FEAT_CMM },
-        { S390_FEAT_SIE_CMMA, S390_FEAT_SIE_GSLS },
-        { S390_FEAT_SIE_PFMFI, S390_FEAT_EDAT },
-        { S390_FEAT_MSA_EXT_8, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_MSA_EXT_9, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_MSA_EXT_9, S390_FEAT_MSA_EXT_4 },
-        { S390_FEAT_MULTIPLE_EPOCH, S390_FEAT_TOD_CLOCK_STEERING },
-        { S390_FEAT_VECTOR_PACKED_DECIMAL, S390_FEAT_VECTOR },
-        { S390_FEAT_VECTOR_PACKED_DECIMAL_ENH, S390_FEAT_VECTOR_PACKED_DECIMAL },
-        { S390_FEAT_VECTOR_PACKED_DECIMAL_ENH2, S390_FEAT_VECTOR_PACKED_DECIMAL_ENH },
-        { S390_FEAT_VECTOR_PACKED_DECIMAL_ENH3, S390_FEAT_VECTOR_PACKED_DECIMAL_ENH2 },
-        { S390_FEAT_VECTOR_ENH, S390_FEAT_VECTOR },
-        { S390_FEAT_VECTOR_ENH2, S390_FEAT_VECTOR_ENH },
-        { S390_FEAT_VECTOR_ENH3, S390_FEAT_VECTOR_ENH2 },
-        { S390_FEAT_INSTRUCTION_EXEC_PROT, S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2 },
-        { S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2, S390_FEAT_ESOP },
-        { S390_FEAT_CMM_NT, S390_FEAT_CMM },
-        { S390_FEAT_GUARDED_STORAGE, S390_FEAT_SIDE_EFFECT_ACCESS_ESOP2 },
-        { S390_FEAT_MULTIPLE_EPOCH, S390_FEAT_STORE_CLOCK_FAST },
-        { S390_FEAT_MULTIPLE_EPOCH, S390_FEAT_TOD_CLOCK_STEERING },
-        { S390_FEAT_SEMAPHORE_ASSIST, S390_FEAT_STFLE_49 },
-        { S390_FEAT_KIMD_SHA3_224, S390_FEAT_MSA },
-        { S390_FEAT_KIMD_SHA3_256, S390_FEAT_MSA },
-        { S390_FEAT_KIMD_SHA3_384, S390_FEAT_MSA },
-        { S390_FEAT_KIMD_SHA3_512, S390_FEAT_MSA },
-        { S390_FEAT_KIMD_SHAKE_128, S390_FEAT_MSA },
-        { S390_FEAT_KIMD_SHAKE_256, S390_FEAT_MSA },
-        { S390_FEAT_KLMD_SHA3_224, S390_FEAT_MSA },
-        { S390_FEAT_KLMD_SHA3_256, S390_FEAT_MSA },
-        { S390_FEAT_KLMD_SHA3_384, S390_FEAT_MSA },
-        { S390_FEAT_KLMD_SHA3_512, S390_FEAT_MSA },
-        { S390_FEAT_KLMD_SHAKE_128, S390_FEAT_MSA },
-        { S390_FEAT_KLMD_SHAKE_256, S390_FEAT_MSA },
-        { S390_FEAT_KMAC_HMAC_SHA_224, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_KMAC_HMAC_SHA_256, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_KMAC_HMAC_SHA_384, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_KMAC_HMAC_SHA_512, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_KMAC_HMAC_ESHA_224, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_KMAC_HMAC_ESHA_256, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_KMAC_HMAC_ESHA_384, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_KMAC_HMAC_ESHA_512, S390_FEAT_MSA_EXT_3 },
-        { S390_FEAT_KM_FULL_XTS_AES_128, S390_FEAT_MSA_EXT_4 },
-        { S390_FEAT_KM_FULL_XTS_AES_256, S390_FEAT_MSA_EXT_4 },
-        { S390_FEAT_KM_FULL_XTS_EAES_128, S390_FEAT_MSA_EXT_4 },
-        { S390_FEAT_KM_FULL_XTS_EAES_256, S390_FEAT_MSA_EXT_4 },
-        { S390_FEAT_PRNO_TRNG_QRTCR, S390_FEAT_MSA_EXT_5 },
-        { S390_FEAT_PRNO_TRNG, S390_FEAT_MSA_EXT_5 },
-        { S390_FEAT_SIE_KSS, S390_FEAT_SIE_F2 },
-        { S390_FEAT_AP_QUERY_CONFIG_INFO, S390_FEAT_AP },
-        { S390_FEAT_AP_FACILITIES_TEST, S390_FEAT_AP },
-        { S390_FEAT_PTFF_QSIE, S390_FEAT_MULTIPLE_EPOCH },
-        { S390_FEAT_PTFF_QTOUE, S390_FEAT_MULTIPLE_EPOCH },
-        { S390_FEAT_PTFF_STOE, S390_FEAT_MULTIPLE_EPOCH },
-        { S390_FEAT_PTFF_STOUE, S390_FEAT_MULTIPLE_EPOCH },
-        { S390_FEAT_AP_QUEUE_INTERRUPT_CONTROL, S390_FEAT_AP },
-        { S390_FEAT_DIAG_318, S390_FEAT_EXTENDED_LENGTH_SCCB },
-        { S390_FEAT_CERT_STORE, S390_FEAT_EXTENDED_LENGTH_SCCB },
-        { S390_FEAT_SIPL, S390_FEAT_EXTENDED_LENGTH_SCCB },
-        { S390_FEAT_SCLAF, S390_FEAT_EXTENDED_LENGTH_SCCB },
-        { S390_FEAT_SCLAF, S390_FEAT_SIPL },
-        { S390_FEAT_NNPA, S390_FEAT_VECTOR },
-        { S390_FEAT_RDP, S390_FEAT_LOCAL_TLB_CLEARING },
-        { S390_FEAT_UV_FEAT_AP, S390_FEAT_AP },
-        { S390_FEAT_UV_FEAT_AP_INTR, S390_FEAT_UV_FEAT_AP },
-        { S390_FEAT_PFCR_QAF, S390_FEAT_CCF_BASE },
-        { S390_FEAT_PFCR_CSDST, S390_FEAT_CCF_BASE },
-        { S390_FEAT_PFCR_CSDSTG, S390_FEAT_CCF_BASE },
-        { S390_FEAT_PFCR_CSTST, S390_FEAT_CCF_BASE },
-        { S390_FEAT_PFCR_CSTSTG, S390_FEAT_CCF_BASE },
-        { S390_FEAT_INEFF_NC_TX, S390_FEAT_TRANSACTIONAL_EXE },
-        { S390_FEAT_PLO_CLO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_CSO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_DCSO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_CSSTO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_CSDSTO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_CSTSTO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TCS, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TCSG, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TCSX, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TCSO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QCS, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QCSG, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QCSX, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QCSO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_LO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_DLX, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_DLO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TL, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TLG, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TLX, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TLO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QL, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QLG, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QLX, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QLO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_STO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_DST, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_DSTG, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_DSTX, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_DSTO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TST, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TSTG, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TSTX, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_TSTO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QST, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QSTG, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QSTX, S390_FEAT_PLO_EXT },
-        { S390_FEAT_PLO_QSTO, S390_FEAT_PLO_EXT },
-        { S390_FEAT_SIE_ASTFLEIE2, S390_FEAT_STFLE },
-    };
     int i;
 
-    for (i = 0; i < ARRAY_SIZE(dep); i++) {
-        if (test_bit(dep[i][0], model->features) &&
-            !test_bit(dep[i][1], model->features)) {
+    for (i = 0; i < s390_feat_deps_len; i++) {
+        if (test_bit(s390_feat_deps[i][0], model->features) &&
+            !test_bit(s390_feat_deps[i][1], model->features)) {
             warn_report("\'%s\' requires \'%s\'.",
-                        s390_feat_def(dep[i][0])->name,
-                        s390_feat_def(dep[i][1])->name);
+                        s390_feat_def(s390_feat_deps[i][0])->name,
+                        s390_feat_def(s390_feat_deps[i][1])->name);
         }
     }
 }
-- 
2.55.0


