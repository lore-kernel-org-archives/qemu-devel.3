Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA117C55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 18:26:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrgJ4-0008VZ-Sr; Wed, 05 Aug 2026 14:25:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wrgIq-0008V1-70
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 14:25:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wrgIo-0007eC-5n
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 14:25:19 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675HSO5l3889483
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 18:25:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=anJk7IJzL8d
 kdA7D3bKcodd/3jx315ie4Oya1yu88O8=; b=Ik9mpSSsPBA+wzvRND4J2FIpbAn
 aKONOgkQkB3F8ifmInkZdTXU8r6URZzlwVoTxO2kx192nFUgS0ShsBetFVP1F84G
 pgsqV9qULrozkJPyE2vDQbvIbSMKQH5jJWEHi8PUPh6OX/oZAHL733US+M1nQM4V
 jdbZ0MiRdBnPOa6bkYBlTB2TwsXslxNvtDmToFy/LxxZ8B9Zva5pSLC6/+ZU+Zxj
 J1GUa83GcfWtknyRf40oKgPDVu+oUn4AXYvn77OsQ9+eFp0cgyc6DdE6/hn7sJWA
 dxNxj2c2B2PBGKBr7ZePugKWz9eEE+Ir7OQtQIYD0747iMewSBGxgnaEcSg==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv5x5sh5e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 18:25:16 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-92e63df032bso13969985a.0
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 11:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785954316; x=1786559116; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=anJk7IJzL8dkdA7D3bKcodd/3jx315ie4Oya1yu88O8=;
 b=kTq0Vca6PyWrMWuhHIMXk7EWt+uM7wtMpmc4JzArC8hlvM3A+QqyDSmW8Lg0Qeyjur
 IttTFegiUcHzk4+B5i2715vZ2L9I5+WmrdZWAVF7JKgPFYLziErxCOf1kO2d4bWByC2q
 EmsA+k6iRWMAeTg4si+gpZni2rb24tMQMWySo0nHZT5ds2mQNs1O825sMncCwc4V+Xaj
 KmudaV+pFlFGrR0uSNv5Hj0ayX+IhyRpMbhe5/3aHowIL3x5hqg0JtE4jL85TyRwfKNo
 Fk+xrq5Ty0hsncYV4YBIBWb7mxGiyDMRMHHDMGom9OSdZdwKr/uLZU0XaeFN2Dc6P2df
 G3Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785954316; x=1786559116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=anJk7IJzL8dkdA7D3bKcodd/3jx315ie4Oya1yu88O8=;
 b=cuDwk9nNRIqkKDHe+SU3RnPlFatHJ/34lAnK6noiVTP3mASfPAL37s6zUk8jcVuSdQ
 5GmMXDK7ppMTtkoADC4NBQ1NcjJQIYUyf+cN308/SLD9vJOeQLClGzvqiI0kwPlgDq0c
 B5L6q4YrFm9JZ7WvPo3MTwFa1w66H/1i1jjRLLx1yO6MPQXjR58JBKSg+jNKv7aImLFc
 MO/qnO/Oe0v4lv8T+ugkY05OQzgKCTQ5WZamJgikNGTZNoDNnqnTcKURYMwsH7W1Wsra
 PkbaFXCi3uPSU4oK6ZpKqljHc5TQwhcBiiUOiVVfPqM3lprYrW89S1hdKlz6gHaNeRsh
 4FSg==
X-Gm-Message-State: AOJu0Yz28QmY3Y3Gj4kVFFr95QDAYq6V7OM5yW3vWeZcb9QlZBMaRHgQ
 7L49PNLgHrovnPDe+vKOMzhybvYzuhBCdqxNaTyxh8L9Aqa3BuU0AAmz6Po+PFSV3o5Mxhu6OMj
 IIP3LvR2o6+7ACBzNfFbPd0UXwQStLuWtqcwH04eav/AGZtSkoerFAIKijoRaXefcwQ==
X-Gm-Gg: AR+sD12xKrulByLeSATv+3FWH3DSaQqe9AUrh1VxHIjg3/4OG2nk5K8HcF58tWCv5pq
 4Auh5o28DrCRN8YE0LPRem4ImkBaylS1DKmq/p4PD57XRpSNopZkZIvgPT5FKjOz3CZvRqaxDMf
 N+cQk+yn2SSdEGFml1yyDIrfIYcD7ru9Aq+0kQPagga6nVlR53r0vo4R56aDqCbzZ6UjHMeQNjP
 yNhNYDXmN4Ce0GQwQ+Rh4pxCXGvm32CpVgGjSMcDGeJWNsryBTA8hLS29v6TBJHgmyXTxFGBBMe
 OhZcyBceGgLzfuKC//GFHYNkR+1Sn6DZP+89cA+4n142MC8U56jyT6JmBdtVByRw9f5xe4XpcLQ
 Mp8XeW5CKSPSY4BbKdfg42pWs8JUtGUlbeg7wiw==
X-Received: by 2002:a05:620a:1b98:b0:930:f285:5ee9 with SMTP id
 af79cd13be357-93659657e60mr132638085a.20.1785954315623; 
 Wed, 05 Aug 2026 11:25:15 -0700 (PDT)
X-Received: by 2002:a05:620a:1b98:b0:930:f285:5ee9 with SMTP id
 af79cd13be357-93659657e60mr132632585a.20.1785954315202; 
 Wed, 05 Aug 2026 11:25:15 -0700 (PDT)
Received: from QCOM-UWl2o8bcGT.qualcomm.com ([187.11.154.152])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9364a3fc901sm209387885a.6.2026.08.05.11.25.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2026 11:25:14 -0700 (PDT)
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH 1/5] target/riscv: split 'debug' and 'sdtrig' flags
Date: Wed,  5 Aug 2026 15:25:02 -0300
Message-ID: <20260805182506.2943757-2-daniel.barboza@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805182506.2943757-1-daniel.barboza@oss.qualcomm.com>
References: <20260805182506.2943757-1-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Xea5Co55 c=1 sm=1 tr=0 ts=6a73800c cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=iMfxv9gflPUPBcmW7/Gq5Q==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=tCBkaT3a_NPXoLf7wY0A:9 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: AOaqUYZzutAeMZlCZS3SRm20jgDunfAZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDE1MSBTYWx0ZWRfX37svSNjph0El
 WLhfqQeSBM07bmDUsDFDNI8a0pgLkHgdnKXKg1elv5ax708IMkoBZ7PefGEAfoM4NF/GFBo258U
 ZSBmKFotg3KmiKhTV6fi1oIwhzoOoSZ+zgnUzOWUBhCA1Chycbi+7U/36Y74N12a3C5wZbCRRT1
 3oNCn4rxDXI5Fi0Jh7NI0EyOzhAQsGLLM0bWn/oeUeNVGHrLuC/SYbGsIoy/FIwk92wNjTn2Sp9
 nvwsxVPcQVK7n5TTtcnRx656kFLIz9a1RqT6OQeNfDejtLrrjlMuJTEHi/EirX/3oB4mSmehymL
 LEV7WEwe1Op1f5mFZhspGRBVYyTYd2c9lzLTAQxu+yO1ZF9J/P98q+w9PQ44tnFvTtrDZgdD6V1
 PCnVpumDJPUCziQnpZo9nEZXL2Pe3J3CBAcKQEQxMYinnWwMr/1cesW0rX4ZSqbM5cRBufnYOM7
 lew3Z4/c+WAQKTIA21g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDE1MSBTYWx0ZWRfX84vISkcyfXmF
 ppnDwwSj6S8EQbs06cuhSjw97Lr0UFrxxFVQgUXg18dM1bwBWZnQ+RRmmDgDnMNrBOHWg7+zrlQ
 PvMGGoJseM81IAGX0aZMvc3VNF15ifI=
X-Proofpoint-ORIG-GUID: AOaqUYZzutAeMZlCZS3SRm20jgDunfAZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050151
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

We need to support modern debug extensions that happens to be
dependencies of other things that we want to support (e.g. a riscv
server spec board).  These extensions, namely sdext, depends on Debug
1.0.  At this moment we support Debug 0.13, and so it happens that 0.13
and 1.0 aren't backwards compatible, i.e. we need design changes to
support both.

The easier way is to deprecate the Debug 0.13 support, together with its
legacy 'debug' flag and call it a day.  But there's a demand to keep the
0.13 support around and this idea got scrapped.

We're going to support both 0.13 and 1.0, where the 'debug' flag will
refer to 0.13 and 'sdtrig' to 1.0.  We need to split both in distinct
flags first to handle the backend changes, so:

- add a new cpu->cfg.ext_sdtrig flag;
- all code that checks "if debug enabled" now checks for both debug and
  ext_sdtrig;
- amend riscv_isa_string_ext() to keep adding 'sdtrig' in riscv,isa if
  we have just the 'debug' flag enabled.

Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
---
 target/riscv/cpu.c                | 21 ++++++++++++++++-----
 target/riscv/cpu_cfg_fields.h.inc |  1 +
 target/riscv/machine.c            |  2 +-
 target/riscv/tcg/csr.c            |  2 +-
 target/riscv/tcg/tcg-cpu.c        |  3 ++-
 5 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 5a82e6563b..db4f2b6459 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -247,7 +247,7 @@ const RISCVIsaExtData isa_edata_arr[] = {
     ISA_EXT_DATA_ENTRY(zvkt, PRIV_VERSION_1_12_0, ext_zvkt),
     ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
     ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
-    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, debug),
+    ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, ext_sdtrig),
     ISA_INTERNAL_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0,
                                 has_priv_1_12),
     ISA_INTERNAL_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
@@ -1079,7 +1079,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
 
 #ifndef CONFIG_USER_ONLY
 #ifdef CONFIG_TCG
-    if (cpu->cfg.debug) {
+    if (cpu->cfg.debug || cpu->cfg.ext_sdtrig) {
         riscv_trigger_reset_hold(env);
     }
 #endif
@@ -1241,7 +1241,7 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     riscv_cpu_register_gdb_regs_for_features(cs);
 
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
-    if (cpu->cfg.debug) {
+    if (cpu->cfg.debug || cpu->cfg.ext_sdtrig) {
         riscv_trigger_realize(&cpu->env);
     }
 #endif
@@ -1258,7 +1258,7 @@ static void riscv_cpu_unrealize(DeviceState *dev)
 #if defined(CONFIG_TCG) && !defined(CONFIG_USER_ONLY)
     RISCVCPU *cpu = RISCV_CPU(dev);
 
-    if (cpu->cfg.debug) {
+    if (cpu->cfg.debug || cpu->cfg.ext_sdtrig) {
         riscv_trigger_unrealize(&cpu->env);
     }
 #endif
@@ -2834,6 +2834,11 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
 };
 
 static const Property riscv_cpu_properties[] = {
+    /*
+     * The 'debug' flag enables support for the legacy Debug
+     * 0.13 spec.  In case cpu->ext.ext_sdtrig is also enabled
+     * the CPU will enable Debug 1.0 instead.
+     */
     DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
     DEFINE_PROP_BOOL("big-endian", RISCVCPU, cfg.big_endian, false),
 
@@ -3055,7 +3060,13 @@ static void riscv_isa_string_ext(RISCVCPU *cpu, char **isa_str,
     char *new = *isa_str;
 
     for (edata = isa_edata_arr; edata && edata->name; edata++) {
-        if (isa_ext_is_enabled(cpu, edata->ext_enable_offset)) {
+        if (isa_ext_is_enabled(cpu, edata->ext_enable_offset)
+            /*
+             * We've been adding 'sdtrig' in riscv,isa for
+             * Debug 0.13 for awhile.  Until we decide to
+             * move away from it we'll keep doing it.
+             */
+            || (!g_strcmp0(edata->name, "sdtrig") && cpu->cfg.debug)) {
             new = g_strconcat(old, "_", edata->name, NULL);
             g_free(old);
             old = new;
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 9eb47af0a7..e32af40c90 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -105,6 +105,7 @@ BOOL_FIELD(ext_zvfbfmin)
 BOOL_FIELD(ext_zvfbfwma)
 BOOL_FIELD(ext_zvfh)
 BOOL_FIELD(ext_zvfhmin)
+BOOL_FIELD(ext_sdtrig)
 BOOL_FIELD(ext_smaia)
 BOOL_FIELD(ext_ssaia)
 BOOL_FIELD(ext_smctr)
diff --git a/target/riscv/machine.c b/target/riscv/machine.c
index 0ab613a298..a744462d48 100644
--- a/target/riscv/machine.c
+++ b/target/riscv/machine.c
@@ -228,7 +228,7 @@ static bool debug_needed(void *opaque)
 {
     RISCVCPU *cpu = opaque;
 
-    return cpu->cfg.debug;
+    return cpu->cfg.debug || cpu->cfg.ext_sdtrig;
 }
 
 static int debug_post_load(void *opaque, int version_id)
diff --git a/target/riscv/tcg/csr.c b/target/riscv/tcg/csr.c
index 36f2004bc5..850fbf32fc 100644
--- a/target/riscv/tcg/csr.c
+++ b/target/riscv/tcg/csr.c
@@ -804,7 +804,7 @@ static RISCVException have_mseccfg(CPURISCVState *env, int csrno)
 
 static RISCVException debug(CPURISCVState *env, int csrno)
 {
-    if (riscv_cpu_cfg(env)->debug) {
+    if (riscv_cpu_cfg(env)->debug || riscv_cpu_cfg(env)->ext_sdtrig) {
         return RISCV_EXCP_NONE;
     }
 
diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
index 4af5cd9c73..02bbdaef8e 100644
--- a/target/riscv/tcg/tcg-cpu.c
+++ b/target/riscv/tcg/tcg-cpu.c
@@ -182,7 +182,8 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState *cs)
              ? EXT_STATUS_DIRTY : EXT_STATUS_DISABLED;
     }
 
-    if (cpu->cfg.debug && !icount_enabled()) {
+    if ((cpu->cfg.debug || cpu->cfg.ext_sdtrig)
+        && !icount_enabled()) {
         flags = FIELD_DP32(flags, TB_FLAGS, ITRIGGER, env->itrigger_enabled);
     }
 #endif
-- 
2.43.0


