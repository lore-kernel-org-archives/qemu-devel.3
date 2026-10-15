Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D4ECC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 19:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHRAs-0008Jx-RS; Thu, 15 Oct 2026 15:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRAr-0008JI-55
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:31:33 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHRAo-0000Vh-J5
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 15:31:32 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FGkFds4100228
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:31:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=LIg0A2afJ7R
 Iw07Rf/DneHX813ap1jgtLTLPNL9vuds=; b=lna8rcw3ci6K6lwczU2klV8Sr67
 Uh1hw4Ywh8uUtIUqNlYkdueFM0/f7N3Hn6f9rhT1ydA0rH0/gsuishlI3wcZ2s7x
 XE7OWF1hiWUoNkrQshgOCvqp8bsBuscTq6U2BLn2Bh9gqKclv1SB5TFTvn6ZVGhE
 pqiKHIfLGJqbsay1CdyoXEOKHVzBQfA5Z8ODrcuAPfgtxlMHsGdcUNR5H+PtN72v
 cTYErBkehcd7XbgrUEWVXg8ccIzuW5vU6UZeDm1m13jdn6XFEUPxZnHNK3kn0FH8
 tgfdMnPn/Q8uop8DlQqyTzAhxZ/M4Nmj/rvCfBAWSe/X/3MUYtoDCrY0KJw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haw2ra59j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 19:31:28 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso9939328eec.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 12:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792092688; x=1792697488; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LIg0A2afJ7RIw07Rf/DneHX813ap1jgtLTLPNL9vuds=;
 b=VKAfDVHFsrSAWtoCX3kzAVNgdauKoLY03BCu9gIjSdXo2QyKfDV2CwnSe5cltXAL9x
 WMnW+itZBpydpHJ1yz7NqSf0QXNy6h3Rj7b2XJO8UlAuHSk/sHnm/nobbYuc1jpHqrw9
 c59Vj+IxZyXYhTGk2NtBkKqEOUmFK98SMzayyf24LUJfIeDNzxr4hISjMAstWE5BYS/R
 PnFwtSPhP7479Cn33wPXPwrZApSRXyGgWwSRHL2Gr7cOZ1Jg57TofjvWJC7a0exye637
 rIfTUxcgXQUEBpODsxkPlLr3QXtIzi9uDSogxZwChj4lBRyE2WK4HQkRyIYTwRMn07tm
 H7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792092688; x=1792697488;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LIg0A2afJ7RIw07Rf/DneHX813ap1jgtLTLPNL9vuds=;
 b=TmPX5E+EfTQ8WFjdA+QfrBih0Q6KW6hJbStMX2mHqxKUmtwefxp4hN4K2lu5JiuR6j
 wUHWYOPo/Oys1mF6XCDWkMTB/OzTP0D+zlYl0eVKrQ5SUCPuce9Kur/9o1cCZRuHXYgK
 hM7kqIMx+c4Wptx7HcEBDVGOWE+MTi1zp4KhPbCjGmhpFOvZyI8QFt8VhFLX0ix47XPD
 ciQNYd8Dg4StBR5X8HRu/4afNWUN9XTtW6Bd1bixspdPCjFKd+o3hwqrXabiPQP+Q37Z
 klx3QZ01w3DZsMs98+EblAPfR0pgDalb2iUhZkkm2yhBdSeoi6DWwyT73+d1k/QLJ8Yn
 6ONA==
X-Gm-Message-State: AFq9FYInyc76QG+FBzM6kvKL52DkJvsr+unsXvsj6XYQQCIFYdqJP2n8
 7JpWNCbrV/RhU/8eqmvRAjeYfOJu/sybp0VfvjHXv/pOAnsb4H0DBRmn97JvOYQnP0CduDL3zRd
 U4egGDyV+Y6HQOoqbREp9B38LuJnF/QlTN3aPeqMSwPoBKS8Uf5J9MPrtyDboqe21HA==
X-Gm-Gg: AYBFou1v6cC7dPzR8lfMcgsFisQ2msLZE9ZfU0Ks/qUpwTh5hxRB52V+CJw5sjxpwOU
 lNAkkm3ErES31wG05TQZ3idRDr5o2cyJKCCQ874XWqVZCmuQZRc3IjQvbZZtdwQqCKpxRacJqH6
 U+Utf9n/PON6hDW1OtKtcyIzlqbgdOlJ+2bNGVwuPZqs9DwLStN4TlcswuaGmRUHTGISu59havy
 Sr0CqlPIMj9R7D8kgKnNMy4Hav2z+ncp6NmnEfgyLHZzmy9foAppmvx1MQRuYJsv1d7vflLWlck
 MHkbAKTNgAWk3McMY61/7UQZCzgSIm8L184GyzROOhfvKbUCj4QItMrfiA2KX96uJ8nnP6REb+B
 H+YuAquiY2dRvqHL62/VgsLHM0BsK82802F8Oyp0NkZdWoDSDMFBzgK7MQkMj
X-Received: by 2002:a05:7300:f14b:b0:35d:19d7:84c with SMTP id
 5a478bee46e88-35d19d710b9mr10019416eec.3.1792092687701; 
 Thu, 15 Oct 2026 12:31:27 -0700 (PDT)
X-Received: by 2002:a05:7300:f14b:b0:35d:19d7:84c with SMTP id
 5a478bee46e88-35d19d710b9mr10019372eec.3.1792092686968; 
 Thu, 15 Oct 2026 12:31:26 -0700 (PDT)
Received: from debian.qualcomm.com (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3608308a87csm81355eec.28.2026.10.15.12.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 12:31:26 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org,
 richard.henderson@linaro.org, pbonzini@redhat.com, stefanha@redhat.com
Cc: pierrick.bouvier@oss.qualcomm.com
Subject: [PULL 01/20] target/hexagon: prefix helpers conflicting with other
 arch
Date: Thu, 15 Oct 2026 19:30:53 +0000
Message-ID: <20261015193112.145326-2-pierrick.bouvier@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
References: <20261015193112.145326-1-pierrick.bouvier@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfX7QaG+eTupEk4
 +vjBMvTjoI/sJoesaBwynFyCaG8AvpuLgmWdvfMyCaQ+CWOB6qfdX6HORZUlsLaGUJdZjopJLlH
 hQeRYlVwdHtnpDfOBp/8BlQ5uHixMGg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3NyBTYWx0ZWRfX1Q962DTqkSgM
 eutE9YLVkSrpxU5kotUZ+Rllb9eOC4xMILZJQQz9AzNkZaHelgXqx6i5O5BR0f443CvieefoOa4
 kNEM2DjXS4AmIl6uFhXKSfJiIaeeZzTg5xMJDAUOn9BiEGzlaZq21lTMPc/wXrdPuHI2i0viM5a
 87jiUKwklRm6eSNBWDUtDwyOcNluuq+yli3c+QLNgC9dOw98RTgWnYZWPhrQ7Ocic3AuqGnR6mO
 GwCcueD/UnOGmotmt2xsCOjAw0f8sy0xhmhVJAtIw/FCPfbmiun88DsYa3OnoxlYygd5MeFnaUR
 sq/kEe2MLc2lvRdUh3SRITYS8P0RqDf0ETv/R3eOXkOd/t1JW3ASJB9kb88kqhjoHEVINRg2BmF
 0LcWGQb0jNP5kfgv9kNXREslMOEMSy5V9Tk41Z+zRCm/ADFY8NthfdIcoNV1dlf08qZ0NoBpP/8
 s4gwLw/5habY5UOolUw==
X-Authority-Analysis: v=2.4 cv=BNMmP1QG c=1 sm=1 tr=0 ts=6ad12a10 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=0Tj3Q07uUtPDLrELhAkA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: SSpzVfFEqmfxGsli2-9GN8FZ3gQWwSrY
X-Proofpoint-ORIG-GUID: SSpzVfFEqmfxGsli2-9GN8FZ3gQWwSrY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150077
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

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20261014210526.104215-2-pierrick.bouvier@oss.qualcomm.com
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 target/hexagon/gen_tcg.h     | 2 +-
 target/hexagon/gen_tcg_sys.h | 2 +-
 target/hexagon/helper.h      | 4 ++--
 target/hexagon/hex_mmu.c     | 2 +-
 target/hexagon/hex_mmu.h     | 2 +-
 target/hexagon/op_helper.c   | 4 ++--
 target/hexagon/translate.c   | 4 ++--
 7 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/hexagon/gen_tcg.h b/target/hexagon/gen_tcg.h
index 80d8a7b6bac..ed05f97efed 100644
--- a/target/hexagon/gen_tcg.h
+++ b/target/hexagon/gen_tcg.h
@@ -1135,7 +1135,7 @@
 #define fGEN_TCG_J2_pause(SHORTCODE) \
     do { \
         uiV = uiV; \
-        gen_helper_raise_exception(tcg_env, \
+        gen_helper_hexagon_raise_exception(tcg_env, \
             tcg_constant_i32(EXCP_YIELD), \
             tcg_constant_i32(ctx->next_PC)); \
     } while (0)
diff --git a/target/hexagon/gen_tcg_sys.h b/target/hexagon/gen_tcg_sys.h
index c9f6b41a877..91ae3421f64 100644
--- a/target/hexagon/gen_tcg_sys.h
+++ b/target/hexagon/gen_tcg_sys.h
@@ -80,7 +80,7 @@
 #define fGEN_TCG_Y2_wait(SHORTCODE) \
     do { \
         RsV = RsV; \
-        gen_helper_wait(tcg_env); \
+        gen_helper_hexagon_wait(tcg_env); \
     } while (0)
 
 #define fGEN_TCG_Y2_resume(SHORTCODE) \
diff --git a/target/hexagon/helper.h b/target/hexagon/helper.h
index 997d87e38e6..b97295f243a 100644
--- a/target/hexagon/helper.h
+++ b/target/hexagon/helper.h
@@ -18,7 +18,7 @@
 #include "internal.h"
 #include "helper_protos_generated.h.inc"
 
-DEF_HELPER_FLAGS_3(raise_exception, TCG_CALL_NO_RETURN, noreturn, env, i32, i32)
+DEF_HELPER_FLAGS_3(hexagon_raise_exception, TCG_CALL_NO_RETURN, noreturn, env, i32, i32)
 DEF_HELPER_2(commit_store, void, env, int)
 DEF_HELPER_3(gather_store, void, env, i32, int)
 DEF_HELPER_1(commit_hvx_stores, void, env)
@@ -136,7 +136,7 @@ DEF_HELPER_3(sreg_write_masked, void, env, i32, i32)
 DEF_HELPER_3(setprio, void, env, i32, i32)
 DEF_HELPER_2(start, void, env, i32)
 DEF_HELPER_1(stop, void, env)
-DEF_HELPER_1(wait, void, env)
+DEF_HELPER_1(hexagon_wait, void, env)
 DEF_HELPER_2(resume, void, env, i32)
 DEF_HELPER_1(resched, void, env)
 DEF_HELPER_3(modify_ssr, void, env, i32, i32)
diff --git a/target/hexagon/hex_mmu.c b/target/hexagon/hex_mmu.c
index 0ca52ed666d..f98585a1d24 100644
--- a/target/hexagon/hex_mmu.c
+++ b/target/hexagon/hex_mmu.c
@@ -115,7 +115,7 @@ int hex_tlb_check_overlap(CPUHexagonState *env, uint64_t entry, uint64_t index)
 }
 
 #ifdef CONFIG_HMP
-void dump_mmu(MonitorHMP *hmp, CPUHexagonState *env)
+void hexagon_dump_mmu(MonitorHMP *hmp, CPUHexagonState *env)
 {
     HexagonCPU *cpu = env_archcpu(env);
     hexagon_tlb_dump(hmp, cpu->tlb);
diff --git a/target/hexagon/hex_mmu.h b/target/hexagon/hex_mmu.h
index 977a97da31a..2cfcd10949a 100644
--- a/target/hexagon/hex_mmu.h
+++ b/target/hexagon/hex_mmu.h
@@ -24,5 +24,5 @@ extern int hex_tlb_check_overlap(CPUHexagonState *env, uint64_t entry,
                                  uint64_t index);
 extern void hex_tlb_lock(CPUHexagonState *env, uint32_t PC);
 extern void hex_tlb_unlock(CPUHexagonState *env);
-void dump_mmu(MonitorHMP *hmp, CPUHexagonState *env);
+void hexagon_dump_mmu(MonitorHMP *hmp, CPUHexagonState *env);
 #endif
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
index accadd7927a..199a2827f96 100644
--- a/target/hexagon/op_helper.c
+++ b/target/hexagon/op_helper.c
@@ -93,7 +93,7 @@ G_NORETURN void hexagon_raise_exception_err(CPUHexagonState *env,
     do_raise_exception(env, exception, pc, 0);
 }
 
-G_NORETURN void HELPER(raise_exception)(CPUHexagonState *env, uint32_t excp,
+G_NORETURN void HELPER(hexagon_raise_exception)(CPUHexagonState *env, uint32_t excp,
                                         uint32_t PC)
 {
     hexagon_raise_exception_err(env, excp, PC);
@@ -1837,7 +1837,7 @@ void HELPER(resched)(CPUHexagonState *env)
     resched(env);
 }
 
-void HELPER(wait)(CPUHexagonState *env)
+void HELPER(hexagon_wait)(CPUHexagonState *env)
 {
     BQL_LOCK_GUARD();
 
diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index cd1abdf1461..ee8588e0677 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -140,7 +140,7 @@ intptr_t ctx_tmp_vreg_off(DisasContext *ctx, int regnum,
 static void gen_precise_exception(int cause, uint32_t PC)
 {
     tcg_gen_movi_i32(hex_cause_code, cause);
-    gen_helper_raise_exception(tcg_env, tcg_constant_i32(HEX_EVENT_PRECISE),
+    gen_helper_hexagon_raise_exception(tcg_env, tcg_constant_i32(HEX_EVENT_PRECISE),
                                tcg_constant_i32(PC));
 }
 
@@ -1163,7 +1163,7 @@ static void check_imprecise_exception(DisasContext *ctx)
     TCGLabel *label = gen_new_label();
 
     tcg_gen_brcondi_tl(TCG_COND_EQ, hex_imprecise_exception, 0, label);
-    gen_helper_raise_exception(tcg_env, hex_imprecise_exception, PC);
+    gen_helper_hexagon_raise_exception(tcg_env, hex_imprecise_exception, PC);
     gen_set_label(label);
 }
 #endif
-- 
2.43.0


