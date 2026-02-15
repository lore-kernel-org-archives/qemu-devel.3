Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 310B9E63F19
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 22:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrkEL-0005XO-Dx; Sun, 15 Feb 2026 17:04:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vrkEI-0005Wn-36
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 17:04:38 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vrkEG-00052R-9J
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 17:04:37 -0500
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-7d4c65d772cso2165977a34.1
 for <qemu-devel@nongnu.org>; Sun, 15 Feb 2026 14:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771193074; x=1771797874; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h52ngLCzd/9lG0CAuePhG9DwNJOwalITs3nHRHFA3CA=;
 b=LJM+WJ+Nlmgjz/1ppZjXFt1lAQ1G0LevuoTq+99rlwMExhY1zKgMaPx4DJxDEuJeCE
 7DY4msaXfjy9MtXtA4wSXjRmJqNAvbmVdgLK2r4doKtyplup5v3psBheWJk6cPw96JYG
 8yK9/OBOTY7BdDvLWdvYVsnLKF0XQiY6YhkJo4gaxTA7itRI+QqVTzCCRasQ8+9Orbv+
 mU/UK1HI5D6fZLjpXNHzyMccrNH9a8V19LH1CHdSt13CeXY2MQb/R2sO2SBIkeM7aAFv
 1V2ONDAbFhBfc67MB7c5NzpiSLMdChfW4OxpV53g+Hv3rh6M/O/lsUOV3Qle7PgdqyiV
 +Bhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771193074; x=1771797874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h52ngLCzd/9lG0CAuePhG9DwNJOwalITs3nHRHFA3CA=;
 b=V07u04/iYO5CHb63NcfdthoFEgRnseMjlIBBUcN/7lof18rWsxzO/PK/SciEeQVjCl
 /5GPJCaaLId0jg5vc4Hyy59t/y8iu4KhTeJaZuiWyKX+wYIsRRYZvnvpBvsKqLlZJKSx
 5R0WFKD55MsbIp1uiIgEvuB1FYNWRQfhd8ccOaEVufLVhn78+X6t9E9CeqL4HQEV6lVI
 FfRVzg2+lLkn1ZLuSR9mfQQQj12DpawD7zkMMUT+d28kdAhOSRpqF2TiJedR5Gjp+2gf
 WGAbROTZHZn5JJFFV3kc9Bo+GKPi0gMyyCwJiD3vyFP3xvGI0lPuSEZviRojA7MAy8gA
 QuTA==
X-Gm-Message-State: AOJu0Yy096eTFDnmkRgz2zqbWXtPelrVHPJet1YK5z3j5zUAEoPv1t7Y
 DgAUYD0m0SkoQHVIAMow684hSoZOWisK3JJWSnC9wPa8FvgLGnvtiQ9eqv/Cs4Le
X-Gm-Gg: AZuq6aJrPozJa8ArHXd9MCw0UQoFvoICcmQMcqlcYZgjsWQbUoUMRjGMjObLmuusjMx
 /3ErdWqa779PHn3UPgI2Td3yOH6ba841+/8mzgweCFbIJTJbOBC/n/ZW+dLiFgrGzl8QvJty3SH
 KMqRj8+cy6zKepb2qJBnJHDwDKQeM0qqLYMPEzSPNFgeaK70/y5cYrPi75Z+O5HGdJORSUcxafq
 OWU1XlZO41jJZ284rMPNJszc7lPwMGqqdqjakZxJjMSJe4EYENmX0GoyemPf45qKuwGKSbQjuIw
 Lrqq4Og1e7K2YzgtClr/bm8Ue7KOykq63KFzE4GqXstBbdR9w5+2wbpKYyQpe0jFfSUol1rFNAh
 X1ieIWdtEp3mL8q/QjsPzfqApOuCa+KHa2wfrDtegJw0dqU7gXi7DTKvwPwyvxmc8d8LJ4ZKEaE
 8NQKMex9uji0Z3HBtsKZrps7HjPIBCinE8rNNnUUsqekuvskthNMngWGmORO/sQZdodaRmMsGSg
 2YwkJ8w7qHIFXbk
X-Received: by 2002:a05:6820:f00a:b0:65f:6ae0:2944 with SMTP id
 006d021491bc7-677694a0622mr5567954eaf.64.1771193073837; 
 Sun, 15 Feb 2026 14:04:33 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40eaf101db0sm13556664fac.12.2026.02.15.14.04.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 14:04:33 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH v2 6/8] Hexagon (target/hexagon) Disassembly of invalid packets
Date: Sun, 15 Feb 2026 15:04:20 -0700
Message-ID: <20260215220422.212249-7-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260215220422.212249-1-ltaylorsimpson@gmail.com>
References: <20260215220422.212249-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-ot1-x342.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

We pass the Hexagon CPU version to disassemble_hexagon.  This allows
decode_packet to know if the opcodes are supported.

Note that we print valid instructions in a packet when one or more is
invalid.  Rather than this
0x0002128c:  0x1eae4fec	{	<invalid>
0x00021290:  0x1c434c04		<invalid>
0x00021294:  0x1e03edf0		<invalid> }

We print this
0x0002128c:  0x1eae4fec	{	<invalid>
0x00021290:  0x1c434c04		V4.w = vadd(V12.w,V3.w)
0x00021294:  0x1e03edf0		V16 = V13 }

Co-authored-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Co-authored-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/cpu_bits.h  |  4 +++-
 target/hexagon/printinsn.h |  3 ++-
 disas/hexagon.c            |  3 ++-
 target/hexagon/cpu.c       |  3 +++
 target/hexagon/decode.c    | 22 ++++++++++++++++++----
 target/hexagon/printinsn.c |  9 +++++++--
 6 files changed, 35 insertions(+), 9 deletions(-)

diff --git a/target/hexagon/cpu_bits.h b/target/hexagon/cpu_bits.h
index 19beca81c0..80d99f5df9 100644
--- a/target/hexagon/cpu_bits.h
+++ b/target/hexagon/cpu_bits.h
@@ -19,6 +19,7 @@
 #define HEXAGON_CPU_BITS_H
 
 #include "qemu/bitops.h"
+#include "cpu-qom.h"
 
 #define PCALIGN 4
 #define PCALIGN_MASK (PCALIGN - 1)
@@ -65,6 +66,7 @@ static inline bool is_packet_end(uint32_t endocing)
     return ((bits == 0x3) || (bits == 0x0));
 }
 
-int disassemble_hexagon(uint32_t *words, int nwords, bfd_vma pc, GString *buf);
+int disassemble_hexagon(uint32_t *words, int nwords, bfd_vma pc, GString *buf,
+                        HexagonVersion hex_version);
 
 #endif
diff --git a/target/hexagon/printinsn.h b/target/hexagon/printinsn.h
index 2ecd1731d0..d437d35005 100644
--- a/target/hexagon/printinsn.h
+++ b/target/hexagon/printinsn.h
@@ -18,10 +18,11 @@
 #ifndef HEXAGON_PRINTINSN_H
 #define HEXAGON_PRINTINSN_H
 
+#include "cpu-qom.h"
 #include "insn.h"
 
 void snprint_a_pkt_disas(GString *buf, Packet *pkt, uint32_t *words,
-                         target_ulong pc);
+                         target_ulong pc, HexagonVersion hex_version);
 void snprint_a_pkt_debug(GString *buf, Packet *pkt);
 
 #endif
diff --git a/disas/hexagon.c b/disas/hexagon.c
index c1a4ffc5f6..9a18f12854 100644
--- a/disas/hexagon.c
+++ b/disas/hexagon.c
@@ -31,6 +31,7 @@
 
 int print_insn_hexagon(bfd_vma memaddr, struct disassemble_info *info)
 {
+    HexagonVersion hex_version = (HexagonVersion)info->target_info;
     uint32_t words[PACKET_WORDS_MAX];
     bool found_end = false;
     GString *buf;
@@ -58,7 +59,7 @@ int print_insn_hexagon(bfd_vma memaddr, struct disassemble_info *info)
     }
 
     buf = g_string_sized_new(PACKET_BUFFER_LEN);
-    len = disassemble_hexagon(words, i, memaddr, buf);
+    len = disassemble_hexagon(words, i, memaddr, buf, hex_version);
     (*info->fprintf_func)(info->stream, "%s", buf->str);
     g_string_free(buf, true);
 
diff --git a/target/hexagon/cpu.c b/target/hexagon/cpu.c
index 09a0de3c2f..4b16214ace 100644
--- a/target/hexagon/cpu.c
+++ b/target/hexagon/cpu.c
@@ -314,8 +314,11 @@ static void hexagon_cpu_reset_hold(Object *obj, ResetType type)
 static void hexagon_cpu_disas_set_info(const CPUState *cs,
                                        disassemble_info *info)
 {
+    CPUState *cs_nonconst = (CPUState *)cs;  /* so we can get hex_cpu */
+    HexagonCPU *hex_cpu = env_archcpu(cpu_env(cs_nonconst));
     info->print_insn = print_insn_hexagon;
     info->endian = BFD_ENDIAN_LITTLE;
+    info->target_info = (void *)HEXAGON_CPU_GET_CLASS(hex_cpu)->hex_version;
 }
 
 static void hexagon_cpu_realize(DeviceState *dev, Error **errp)
diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
index b02a402dfa..4d95b7c690 100644
--- a/target/hexagon/decode.c
+++ b/target/hexagon/decode.c
@@ -827,19 +827,33 @@ int decode_packet(DisasContext *ctx, int max_words, const uint32_t *words,
 
 /* Used for "-d in_asm" logging */
 int disassemble_hexagon(uint32_t *words, int nwords, bfd_vma pc,
-                        GString *buf)
+                        GString *buf, HexagonVersion hex_version)
 {
     DisasContext ctx;
     Packet pkt;
 
     memset(&ctx, 0, sizeof(DisasContext));
+    ctx.hex_version = HEX_VER_ANY;    /* Allow decode to accept anything */
     ctx.pkt = &pkt;
 
     if (decode_packet(&ctx, nwords, words, &pkt, true) > 0) {
-        snprint_a_pkt_disas(buf, &pkt, words, pc);
+        snprint_a_pkt_disas(buf, &pkt, words, pc, hex_version);
         return pkt.encod_pkt_size_in_bytes;
     } else {
-        g_string_assign(buf, "<invalid>");
-        return 0;
+        for (int i = 0; i < nwords; i++) {
+            g_string_append_printf(buf, "0x" TARGET_FMT_lx "\t", words[i]);
+            if (i == 0) {
+                g_string_append(buf, "{");
+            }
+            g_string_append(buf, "\t");
+            g_string_append(buf, "<invalid>");
+            if (i < nwords - 1) {
+                pc += 4;
+                g_string_append_printf(buf, "\n0x" TARGET_FMT_lx ":  ",
+                                       (target_ulong)pc);
+            }
+        }
+        g_string_append(buf, " }");
+        return nwords * sizeof(uint32_t);
     }
 }
diff --git a/target/hexagon/printinsn.c b/target/hexagon/printinsn.c
index 4865cdd133..99f8020d5d 100644
--- a/target/hexagon/printinsn.c
+++ b/target/hexagon/printinsn.c
@@ -21,6 +21,7 @@
 #include "insn.h"
 #include "reg_fields.h"
 #include "internal.h"
+#include "decode.h"
 
 static const char *sreg2str(unsigned int reg)
 {
@@ -51,7 +52,7 @@ static void snprintinsn(GString *buf, Insn *insn)
 }
 
 void snprint_a_pkt_disas(GString *buf, Packet *pkt, uint32_t *words,
-                         target_ulong pc)
+                         target_ulong pc, HexagonVersion hex_version)
 {
     bool has_endloop0 = false;
     bool has_endloop1 = false;
@@ -83,7 +84,11 @@ void snprint_a_pkt_disas(GString *buf, Packet *pkt, uint32_t *words,
         }
 
         g_string_append(buf, "\t");
-        snprintinsn(buf, &(pkt->insn[i]));
+        if (opcode_supported(pkt->insn[i].opcode, hex_version)) {
+            snprintinsn(buf, &(pkt->insn[i]));
+        } else {
+            g_string_append(buf, "<invalid>");
+        }
 
         if (i < pkt->num_insns - 1) {
             /*
-- 
2.43.0


