Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A78606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 22:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QUTj/580
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xUA9l-00039r-H5; Thu, 19 Nov 2026 16:59:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xUA9k-000390-3p
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 16:59:00 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mliebel@qualcomm.com>)
 id 1xUA9g-0006Zd-SR
 for qemu-devel@nongnu.org; Thu, 19 Nov 2026 16:58:59 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJJ1kkm3148691
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 21:58:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=1ox2ZlUIMoP
 RycCE62DtwsyfoWgZo3Ly5koTPLonMq0=; b=QUTj/580BzkhvzIHPhV6aHIjnaz
 OOEoYR8p7uedTVjKwf6JlSNYxCt6LuMNilD5q62t/qrEdnmDuvMfBEORZQbo9iE+
 5ZHv/iYJkqCeiBg/fuF1HM+AwDfZkdBDoIImHfpgnWz0wY7q0YhHG85o/Xdbsu22
 Fthfpu3IMO0fHoe7tSST7HMVgl36XbZHh8HiYa0NUHn0Xgaw9awKiJqecRFf6xFo
 IEWTOdnNT4gZsypj5sQvzQelspu4AbxRFCalK8RoRpXdrcm6FcbHVP516l1mBfrK
 6o/EFt+s1T/i1UBogv7iCKcbmu4XyfasKcbcM9xtQ51Hs0vpQpbR+V2h9dQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com
 [129.46.96.20])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1yx6b18e-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 19 Nov 2026 21:58:54 +0000 (GMT)
Received: from pps.filterd (nalasppmta03.qualcomm.com [127.0.0.1])
 by NALASPPMTA03.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJLwrVR1783827; Thu, 19 Nov 2026 21:58:53 GMT
Received: from hu-devc-lv-u24-a.qualcomm.com (hu-mliebel-lv.qualcomm.com
 [10.81.81.31])
 by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 6AJLwrxj1783801
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 19 Nov 2026 21:58:53 +0000 (GMT)
Received: by hu-devc-lv-u24-a.qualcomm.com (Postfix, from userid 4282937)
 id 3D76A25229; Thu, 19 Nov 2026 13:58:53 -0800 (PST)
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Marco Liebel <marco.liebel@oss.qualcomm.com>
Subject: [PATCH v3 02/15] target/hexagon: allow writes to V85 USR coprocessor
 fields
Date: Thu, 19 Nov 2026 13:58:40 -0800
Message-ID: <20261119215853.987158-3-marco.liebel@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119215853.987158-1-marco.liebel@oss.qualcomm.com>
References: <20261119215853.987158-1-marco.liebel@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-GUID: I4dYGrH-pE2mG9pJ59ZfkzaZPttO6Z72
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDA4OCBTYWx0ZWRfX+ryNfRssD3ao
 9+DR3m24jAhSEogV9lKXvGXM74hje71sAnOub6OQElPGT8Yjk0yw4kV9A41kyYcy4Gpv53r7zxV
 hx9Y0kB2hYhz1XrI1UgJAXCDnD3q5XA=
X-Proofpoint-ORIG-GUID: I4dYGrH-pE2mG9pJ59ZfkzaZPttO6Z72
X-Authority-Analysis: v=2.4 cv=FPmOVOos c=1 sm=1 tr=0 ts=6aff711e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=qS8oT8J1kFDks1gOr5kA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDA4OCBTYWx0ZWRfXybxYoakWKXzp
 DjlB7+Ug66UOmTA0oRt6riIQU8UJctMAnAlE0i2WU4QDjw4oVNfdb805ONRJU8C2PSP2LfUMUw5
 apL1v1xtEs9rL3fHDzg9/80frJd6sR1UJHdTh37/UcABFSnildU/eyjyt+9Vye9K6LOhG0Cdrqa
 NzWiOSrcaMS/5riVm/bZxG/6fi3rGxZGmop7YPnz8SVTjwbiBBV5+HFG8nEvZnEdL2yIMeiU3V1
 qGRsq6c4CTUwGk6BTv2csWDQd4pkWBDaacRs7zQUPFJKdTe/nGg/VIDOf5C9BJh2Cduvkwq/EPQ
 S9e9xaq3mQlVHG3NG4mavy2ieoWs+/aXiqXL60C9pr0E3FCLUp++1sn4RTOc1DJ6qCNDfE2casn
 gi7a/NpvqoqoivV4nIVCMsSvjzP+m64YMEFVEiFWajifbANIeS84k8jVDqbJtEv7m0Pl4etTMkp
 zL2tMtndPlhGbuC6XiA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_05,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190088
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=mliebel@qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

NPC and FPCOPROC are writable on V85. Remove them from the immutable
mask for that revision, without changing older CPU models.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
---
 target/hexagon/genptr.c             |  6 ++++++
 target/hexagon/reg_fields_def.h.inc |  2 ++
 tests/tcg/hexagon/meson.build       |  3 ++-
 tests/tcg/hexagon/packet_user.c     | 18 ++++++++++++++++++
 4 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
index 52615628e3..d226cc4ebb 100644
--- a/target/hexagon/genptr.c
+++ b/target/hexagon/genptr.c
@@ -562,6 +562,12 @@ static inline void gen_write_ctrl_reg(DisasContext *ctx, int reg_num,
             /* USR.FPSAT is reserved before v79 */
             reg_mask &= ~fGET_REG_FIELD_MASK(USR_FPSAT);
         }
+        if (reg_num == HEX_REG_USR &&
+            ctx->hex_def->hex_version >= HEX_VER_V85) {
+            /* V85 permits writes to NPC and FPCOPROC. */
+            reg_mask &= ~(fGET_REG_FIELD_MASK(USR_NPC) |
+                          fGET_REG_FIELD_MASK(USR_FPCOPROC));
+        }
         gen_masked_reg_write(val, hex_gpr[reg_num], reg_mask);
         tcg_gen_mov_tl(get_result_gpr(ctx, reg_num), val);
         if (reg_num == HEX_REG_QEMU_PKT_CNT) {
diff --git a/target/hexagon/reg_fields_def.h.inc b/target/hexagon/reg_fields_def.h.inc
index 32dbb2da30..4c0bd4674a 100644
--- a/target/hexagon/reg_fields_def.h.inc
+++ b/target/hexagon/reg_fields_def.h.inc
@@ -29,10 +29,12 @@ DEF_REG_FIELD(USR_FPDBZF,         2, 1)
 DEF_REG_FIELD(USR_FPOVFF,         3, 1)
 DEF_REG_FIELD(USR_FPUNFF,         4, 1)
 DEF_REG_FIELD(USR_FPINPF,         5, 1)
+DEF_REG_FIELD(USR_NPC,            6, 1)
 
 DEF_REG_FIELD(USR_LPCFG,          8, 2)
 
 DEF_REG_FIELD(USR_FPDAZ,         17, 1)
+DEF_REG_FIELD(USR_FPCOPROC,      20, 2)
 
 DEF_REG_FIELD(USR_FPRND,         22, 2)
 DEF_REG_FIELD(USR_FPSAT,         24, 1)
diff --git a/tests/tcg/hexagon/meson.build b/tests/tcg/hexagon/meson.build
index b3635be3fc..cb2e7e68b2 100644
--- a/tests/tcg/hexagon/meson.build
+++ b/tests/tcg/hexagon/meson.build
@@ -96,7 +96,8 @@ tests += {
   'misc.c': {'cflags': [cflags, '-mv71', '-O2']},
   'multiple-writes.c': {'cflags': [cflags, '-mhvx']},
   'overflow.c': {'cflags': cflags, 'exe_name': 'hex-overflow'},
-  'packet_user.c': {'cflags': [cflags, '-O2']},
+  'packet_user.c': {'cflags': [cflags, '-O2'],
+                    'qemu_args': ['-cpu', 'v85']},
   'preg_alias.c': {'cflags': cflags},
   'dual_stores.c': {'cflags': cflags},
   'framekey.c': {'cflags': cflags},
diff --git a/tests/tcg/hexagon/packet_user.c b/tests/tcg/hexagon/packet_user.c
index acc77202ef..1343a0287a 100644
--- a/tests/tcg/hexagon/packet_user.c
+++ b/tests/tcg/hexagon/packet_user.c
@@ -30,9 +30,27 @@ static void test_predicate_read(void)
     check32(new, 0xff);
 }
 
+static void test_usr_mask(void)
+{
+    unsigned old, value;
+
+    asm volatile(
+        "%[old] = usr\n"
+        "r0 = #-1\n"
+        "usr = r0\n"
+        "%[value] = usr\n"
+        "usr = %[old]\n"
+        : [old] "=&r"(old), [value] "=&r"(value)
+        : : "r0"
+    );
+    /* V85 USR writable bits. */
+    check32(value, 0x3fffff7f);
+}
+
 int main(void)
 {
     test_predicate_read();
+    test_usr_mask();
     puts(err ? "FAIL" : "PASS");
     return err != 0;
 }
-- 
2.43.0


