Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DDDCA5FAD
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 02:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBje3-0007b2-I7; Tue, 29 Sep 2026 22:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBje0-0007Zw-EN
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:02:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xBjdy-00036p-IJ
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 22:02:04 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TNPvmU1353023
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=HFY8W13VOIb
 b68yilcZULKcqmsH8dyzBxsZJ/0SveBI=; b=VC9MKh4FtxbgtmeDf6/RIf+HXPs
 hXWJf2FBWShXME8zHJtmJ7tbN+FfxrAGkgpRDBWxBoNfzVRW493Od8g2uPtekK6m
 +NtMxJzv8YTY4eRiTOENt2v18s6KAwpb7H4fGcr4Ghw8iI9rH/6RARVn/f3AYwsp
 DPqBe3lYf2pTDZS+qvA9E4+4E9t+DDBP8wWcMRSXupy1qaFdbfq4qvwH5QgbxUkZ
 /yFyhIgvY1Y2G4QmOmKuXD0NQthm6HBl7kBcMxsb+SC4+U8/Tv651T22G78i9vwt
 jFHoxuqZ6FVRKwxt3xmrUQ8tF83D1TdyyZ8GvLsa9YFJu7xR+Izdul2ZEtg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0eswjs0t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 30 Sep 2026 02:02:00 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso1856465eec.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 19:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790733720; x=1791338520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HFY8W13VOIbb68yilcZULKcqmsH8dyzBxsZJ/0SveBI=;
 b=eX8+c4bSfbuElQELAhyLH0N3jPXsaRm3R4/uaIMN0Z6FzH8On+CsXj9gUQD6u4ARHB
 fMbd1rNoPoDzXg1aCrON6cE80ttDB+hXZGy9/qjnP16bT6C3FKpaPem14k50zHh+b8ow
 UXXpdQdMAOH3agfkkY95muERE0ce2eyXy9+tdBhGoUTxK4bLe9Q4e2vt4g3uK5Ip5DDt
 wkXg0ZsHPCteKC3b7WYGpFMC1boLxMNIljrIOPe7KiK9g3qwOauN9NsaKkKST9ehffNz
 iZ0X2IvmW3OiYZ+JcJZcego2pJTq9m/s3+1J/CLFqRv44oCDnsyC9sLOMRvnhFl5hjuq
 RFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790733720; x=1791338520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HFY8W13VOIbb68yilcZULKcqmsH8dyzBxsZJ/0SveBI=;
 b=udKbC98PilDoqX71bkoWaFNmeJOSbA5NEfQ7cpR1yDCUKM9euOaMPE75TQEYB5kOE7
 x/Jrxa5AMga1nMp4SeZfsAVtJqixoWjNso08I13miQqZZnkjOHgkh7q8xrRGDIr6NWzw
 BRXI6kIVq1aXzLR3gaeDxIj69L83t0Tn6YOX390x3QpyXA6nVo2+/A+FRb6WMSEfwi5x
 MtQVrn/qxyExn72Gc80dw+Y793EdzmBzbqIXIrAD27CYywCReVYuqoq66Wh36I4A1lwS
 vPoxbyNPJsx5pWgpn4Ngw/ooHLnpmolXKkqiiOXSNAuMLDAG6fRBx/nb6fh8KPw2BokN
 qJdQ==
X-Gm-Message-State: AFq9FYKzd5wSUQcQh+2ho8r//Nj9t5zyQiSHVDGr13ZTsEDaV79xhxgv
 IdSNsHVTjBtRB90rQR1lZcso7Jnve0/havk/dAMaH5bGA8Q2qP3bihhFlRX9+HXF+QxyIZ1n0EK
 pp+Ud7+f7W21+0N/4djdWWQJtn6+/JMab6HTjUy3H5OPSXVYFfYP9uaDmQh8RaaJWxg==
X-Gm-Gg: AYBFou3KO/n+UkdUhS8RvsEstMjDdJUozoWJUzq0Fn9SbNNTa6a0QTjQIK6glUA0hDx
 C75QGchQTr5nY5jC7grUtC5uyiQgGNBwcY++L9K+Nsn7vu5vjLe0qfzf1OhzdvTThqtn3G4j8vN
 b8/yt4hFTaecbCdxdl12C+jzzTxRMLhrqOwZ/qQbN0bMkjOMwoLFkqnowic7BCH5t2MXbfTbFmn
 f78DRbXf4U6aSOBybEb5FQbQc4/3xcGA5gs6n1j3v9XKbP/rbXD++MlGv6D0Wb3qTBNh3yTH8m3
 FJMt53FbLu0RwjJ2ZeKI1vgSXUpQui8gII2XE7Ggo+WXlcLHvDWrFpPYycIu71WHgnfllFvmzYl
 DWJpoCUiXraEl8YIIVvaIfZwqmNcwpwLuqTjCSUM0LQkS4VN1d/diU5n2UTLN
X-Received: by 2002:a05:7300:50ce:b0:34b:2df0:b3f4 with SMTP id
 5a478bee46e88-34cdd39ab94mr108158eec.36.1790733719840; 
 Tue, 29 Sep 2026 19:01:59 -0700 (PDT)
X-Received: by 2002:a05:7300:50ce:b0:34b:2df0:b3f4 with SMTP id
 5a478bee46e88-34cdd39ab94mr108140eec.36.1790733719284; 
 Tue, 29 Sep 2026 19:01:59 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c388cc02esm3174803eec.21.2026.09.29.19.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 19:01:57 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 14/21] target/rx: prefix helpers conflicting with other arch
Date: Wed, 30 Sep 2026 02:01:01 +0000
Message-ID: <20260930020108.217892-15-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
References: <20260930020108.217892-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfX/GnF1M6257A2
 Mi0mjClqxANz69JDHeSN4oL3ygukMJWD36GF3cjsXPEXYT/ZMZIbSgey6ZgNWAKC/3wAB4G2QXx
 fWy12DXPM4dkxN240yBq5bRJNa5XOY1drOelj2ZQPUAHTEZHlDK9nHcdCtpZo3CQb9//cUftkre
 cQVr4YGpOvFS7Gvbo3tUQqUO+QqTNnP9EVEEfEphKwC7ZJh2T06apqXibIH+EmKuYDRMMwhy6up
 mKtrC3tmyK56z8DzUoknyrETDjn7hS8mVoMajlePtiBIdPmzRY4hrUWiBNOg6DOjkwC7GAFYV7p
 Hp9Y4CbG25L4q73/3P3uqWZwkJhrDBU7rTgEwKCX8vJkh6URH70dlZhSBnw4RvFn/taLyYnW903
 VkINY/qDxEn7AkJ6BRvrf7XN5cvkhWLAUdT9UakCcHvZbo4YSVm+j225EKpXopnxIGNX1oizUbt
 YTVqEwNFj5dzdm6bexQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDAwNyBTYWx0ZWRfXwuoxaavf+O8W
 Vwrm+Gw+7tpeP6I72nYM1S7agctPVXGy2qmFC3efb/aRP6lLKGZG4e2G98bakuzDg6DozXICd0M
 wikDY84RP10zuYPcuFLqP87zpAw3KME=
X-Authority-Analysis: v=2.4 cv=LaWpeTfi c=1 sm=1 tr=0 ts=6abc6d98 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=6grbfbtxqwKGXmKduJgA:9 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: BEmOM2mYnkwK16oLYPYrftYhyuymSMZi
X-Proofpoint-ORIG-GUID: BEmOM2mYnkwK16oLYPYrftYhyuymSMZi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609300007
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/rx/helper.h    | 12 ++++++------
 target/rx/op_helper.c | 12 ++++++------
 target/rx/translate.c | 14 +++++++-------
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/target/rx/helper.h b/target/rx/helper.h
index 8cc38b0cb71..b1ef843be1e 100644
--- a/target/rx/helper.h
+++ b/target/rx/helper.h
@@ -4,11 +4,11 @@ DEF_HELPER_1(raise_privilege_violation, noreturn, env)
 DEF_HELPER_1(wait, noreturn, env)
 DEF_HELPER_2(rxint, noreturn, env, i32)
 DEF_HELPER_1(rxbrk, noreturn, env)
-DEF_HELPER_3(fadd, f32, env, f32, f32)
-DEF_HELPER_3(fsub, f32, env, f32, f32)
-DEF_HELPER_3(fmul, f32, env, f32, f32)
-DEF_HELPER_3(fdiv, f32, env, f32, f32)
-DEF_HELPER_3(fcmp, void, env, f32, f32)
+DEF_HELPER_3(rx_fadd, f32, env, f32, f32)
+DEF_HELPER_3(rx_fsub, f32, env, f32, f32)
+DEF_HELPER_3(rx_fmul, f32, env, f32, f32)
+DEF_HELPER_3(rx_fdiv, f32, env, f32, f32)
+DEF_HELPER_3(rx_fcmp, void, env, f32, f32)
 DEF_HELPER_2(ftoi, i32, env, f32)
 DEF_HELPER_2(round, i32, env, f32)
 DEF_HELPER_2(itof, f32, env, i32)
@@ -18,7 +18,7 @@ DEF_HELPER_2(set_psw_rte, void, env, i32)
 DEF_HELPER_2(set_psw, void, env, i32)
 DEF_HELPER_1(pack_psw, i32, env)
 DEF_HELPER_3(div, i32, env, i32, i32)
-DEF_HELPER_3(divu, i32, env, i32, i32)
+DEF_HELPER_3(rx_divu, i32, env, i32, i32)
 DEF_HELPER_1(scmpu, void, env)
 DEF_HELPER_1(smovu, void, env)
 DEF_HELPER_1(smovf, void, env)
diff --git a/target/rx/op_helper.c b/target/rx/op_helper.c
index 36df7d377e5..5a7a87943fe 100644
--- a/target/rx/op_helper.c
+++ b/target/rx/op_helper.c
@@ -147,12 +147,12 @@ void helper_set_fpsw(CPURXState *env, uint32_t val)
         return ret;                                                 \
     }
 
-FLOATOP(fadd, float32_add)
-FLOATOP(fsub, float32_sub)
-FLOATOP(fmul, float32_mul)
-FLOATOP(fdiv, float32_div)
+FLOATOP(rx_fadd, float32_add)
+FLOATOP(rx_fsub, float32_sub)
+FLOATOP(rx_fmul, float32_mul)
+FLOATOP(rx_fdiv, float32_div)
 
-void helper_fcmp(CPURXState *env, float32 t0, float32 t1)
+void helper_rx_fcmp(CPURXState *env, float32 t0, float32 t1)
 {
     int st;
     st = float32_compare(t0, t1, &env->fp_status);
@@ -407,7 +407,7 @@ uint32_t helper_div(CPURXState *env, uint32_t num, uint32_t den)
     return ret;
 }
 
-uint32_t helper_divu(CPURXState *env, uint32_t num, uint32_t den)
+uint32_t helper_rx_divu(CPURXState *env, uint32_t num, uint32_t den)
 {
     uint32_t ret = num;
     if (den != 0) {
diff --git a/target/rx/translate.c b/target/rx/translate.c
index 132d495710c..bd445bc0634 100644
--- a/target/rx/translate.c
+++ b/target/rx/translate.c
@@ -1252,7 +1252,7 @@ static void rx_div(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 
 static void rx_divu(TCGv_i32 ret, TCGv_i32 arg1, TCGv_i32 arg2)
 {
-    gen_helper_divu(ret, tcg_env, arg1, arg2);
+    gen_helper_rx_divu(ret, tcg_env, arg1, arg2);
 }
 
 /* div #imm, rd */
@@ -1864,16 +1864,16 @@ static bool trans_SATR(DisasContext *ctx, arg_SATR *a)
         return true;                                            \
     }
 
-FOP(FADD, fadd)
-FOP(FSUB, fsub)
-FOP(FMUL, fmul)
-FOP(FDIV, fdiv)
+FOP(FADD, rx_fadd)
+FOP(FSUB, rx_fsub)
+FOP(FMUL, rx_fmul)
+FOP(FDIV, rx_fdiv)
 
 /* fcmp #imm, rd */
 static bool trans_FCMP_ir(DisasContext *ctx, arg_FCMP_ir * a)
 {
     TCGv_i32 imm = tcg_constant_i32(li(ctx, 0));
-    gen_helper_fcmp(tcg_env, cpu_regs[a->rd], imm);
+    gen_helper_rx_fcmp(tcg_env, cpu_regs[a->rd], imm);
     return true;
 }
 
@@ -1884,7 +1884,7 @@ static bool trans_FCMP_mr(DisasContext *ctx, arg_FCMP_mr *a)
     TCGv_i32 val, mem;
     mem = tcg_temp_new_i32();
     val = rx_load_source(ctx, mem, a->ld, MO_32, a->rs);
-    gen_helper_fcmp(tcg_env, cpu_regs[a->rd], val);
+    gen_helper_rx_fcmp(tcg_env, cpu_regs[a->rd], val);
     return true;
 }
 
-- 
2.43.0


