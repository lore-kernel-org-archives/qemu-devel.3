Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4AE7C5DF9D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 15:59:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyX4N-00058t-GN; Mon, 24 Aug 2026 11:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wyX4G-00056N-NX
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:58:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1wyX4E-0001jo-Gy
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 11:58:36 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67OFmqdt3234833
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:58:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=hqHcOSCT89R
 /6W399hvoyl5mlR8IRVQVtP0aWYvMCCw=; b=X4mZmvAtOv9jR3Q34EqnTl+UB0Q
 vUEuCX0D18LSSMi/CdgoY/CswXeX9up/QPfMEQxnlGgyEdmgh1kpWFGzCG5MnsOD
 lnFwijrVKrvyX019uWJFQp6bmve43telby2QmaIRr4+a4bHJuVUoUW4jZ3JVV0ZT
 HXk3M2/9axcXRCTd4bnRv+JkVDllqPyrSacIZqoaiRw1u3TuuZS4x1uw3L/znjZD
 h89Ga2uYv09MQy/AJlIsiKFYYFBMgDxr6TNL+lgnubojjSrIq0scYmNHtmeaxG9g
 TBTHuKJyuW7NwLEktX3HbpLKJ8gBD2NrL2PNSf2sGI9gPtzRJDGZZPQFntA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8gqnab11-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 15:58:32 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38dd87656d3so4814262a91.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 08:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787587111; x=1788191911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hqHcOSCT89R/6W399hvoyl5mlR8IRVQVtP0aWYvMCCw=;
 b=SZ/AVdP92C76PTLgMJsFAnDPnXd2wT2aofXJFW4rXnSxbJ5ct+073wzQOFK+NFNLpz
 enC3IpC32mGTjdeZQG6WE5cct++zfd1N+2sSUkqVebgM9ypRcCELw/4aq0h8fxo1soLj
 RCUYElXO/q1XNf8G7SlpSxTT+nimNAaCIfg1ZWDUmXM5pMTqnGwJIBCAF+NlCcP0etcp
 YFh6HAIfWSGyCYajhEFt4kLbPOGr5YHddaV1J6fYWZzU0CkRY1s8fwPo92cFTH38UA4/
 h53nSbwDKM5iKN4A9IEa2rNBziLG0u7h9lLLdaVifSys6HvnMG5d8y3aOszjjOflwRuL
 Xzpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787587111; x=1788191911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hqHcOSCT89R/6W399hvoyl5mlR8IRVQVtP0aWYvMCCw=;
 b=afA8knJ0qZnADnFEEa/Tl00acIQRK4Mn0UeyfBg0GCb7MGlNVqmzKsfjNl0lNXajet
 t1Jdrt7r0ssj743dF+trijbv/FkwtZLEEC9zykajZnuTsz4yTv/C7W/ef+Qn5oNBlAE1
 jdbel1a1hXnzdFc75NmuYToc3J174hsu+I5+G4noeA+0I2//TySP8aAN0qSuIgyDBjBX
 jSH15kvsX5/9NFrINGie7MwvOR205iQsHeAVOlHvmwpCqyNWuMT+ep2G9yT3b6+I8wVy
 q+jaMzdX3hqnzVq4BHHe6hKgHmGTb1TQT/4oWg42Ikm48IAos1+wA10A/bKguE2sAEn6
 MLxg==
X-Gm-Message-State: AFuF++mhcinAJsJCOW18A+axMYkbWCUYNrCsmyXLb4wHm4KBwkk1x1FL
 jT3cvrylKNtlHhxGapkBO1/diL4AFtY/KAUuO4UQNcKcQHQiu9laPXTvWvVKzfWdDpw7rQ2noCR
 tHv02zLqwlLKt+GW7VG5rattRLQ/8yZPQHDphAyKF6olo6Tigi6dWjHV0npF6wXzZXQRJ
X-Gm-Gg: AR+sD10Q2D2vCrts7lyuc1Nrm3j8EjFJ9Mvd4VKXhYMdFqi+Xh/jgz2ITsBD2sLyvoP
 aYubmDoSYWGP/3B7qmMrXyWyiUYEBZfm6YvbwUsfb9gMI466+qiaPB8sz3IAZCyJ7Q7p+C4K/fJ
 MC2PYYRFtkxLoufGv/Fsn8VwLre3A6RkuTTLMrwQUxQBOIdNY/7NXf8Grd3rhLAsQOvM8TOz6+m
 j7zYfK/Ko5f6ANMa5lq3cY6cBvpuoR/bznJyKAbE81UupqNjJVME9ycLwY1Q+BjUjP+LalpQxc4
 Hjy0XVtxmj8P/n6qSv0OKpsieThRDSzS3rz8K0GCzulFTQxa3WAMGpk99uky1SvIjwIH7vltryN
 zzwBs0lrI1UOeYdsJmNS1OkGTUyugH3ddpYCeiyksi0ZcsMmEvxDmxdoskTMnW1g=
X-Received: by 2002:a17:90b:280a:b0:38e:bfe:81e9 with SMTP id
 98e67ed59e1d1-395dee56103mr39855331a91.1.1787587111118; 
 Mon, 24 Aug 2026 08:58:31 -0700 (PDT)
X-Received: by 2002:a17:90b:280a:b0:38e:bfe:81e9 with SMTP id
 98e67ed59e1d1-395dee56103mr39855248a91.1.1787587110683; 
 Mon, 24 Aug 2026 08:58:30 -0700 (PDT)
Received: from hu-mathbern-lv.qualcomm.com (Global_NAT1.qualcomm.com.
 [129.46.96.20]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14186183c0esm41152935c88.12.2026.08.24.08.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 08:58:30 -0700 (PDT)
From: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
To: qemu-devel@nongnu.org
Cc: ale@rev.ng, anjo@rev.ng, brian.cain@oss.qualcomm.com,
 marco.liebel@oss.qualcomm.com, philmd@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: [PATCH v4 04/14] target/hexagon: fix PC advancement for non-COF TB
 terminators
Date: Mon, 24 Aug 2026 08:58:13 -0700
Message-Id: <c1dad05e0ace239cbddf7ee640d7c314d2bc0d5b.1787586642.git.matheus.bernardino@oss.qualcomm.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1787586642.git.matheus.bernardino@oss.qualcomm.com>
References: <cover.1787586642.git.matheus.bernardino@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEzNCBTYWx0ZWRfXyDjdBPdanJ8C
 85RMgRgd0IxOHAfbDSeA4CSt5NvAvx5UWTvIFK3JB6A1UaKjKNKbbRLHzrAI1u+DROSF/ZFP0GJ
 IQMVu6sWCaYm7NDdaH5J43lQUPdRuhI=
X-Proofpoint-GUID: Yt7bdE-qoWKdOSAtfBwVyRDaZ5Bh7gA7
X-Authority-Analysis: v=2.4 cv=fqXsol4f c=1 sm=1 tr=0 ts=6a8c6a28 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=4a9di1UdVY1t8Q3xuf0A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEzNCBTYWx0ZWRfX8GFCD9QQ9I61
 MQdwJGV7S4p1gS4BRUMag2GgqQk0wZ27KZNT5rhKoRpnL7251WzTBdz+s8276eU0SxUg/SD6I9a
 YMqoiOi/JQzNze9hJLhuAeLv4vyULi5v2jfs0IHb3Nh46ML+kujZU9YoXk3FqZJBp9PUtiYFiIn
 LqhY/KX1AOl8pteT/8ef+P9sJkyFOWo1fbj6sQ1mn50ECvLqWDWU7IGguS5eL11YRmvaAKfmlVv
 6Rr/xbAHA32LW34L1fS6Q8jfYCTG8neesjyqSQyJmEDOplY2vE46AfdmkGa4tCqHwmzug0HSnrV
 96Lh9hRCubYBSKmNCzEIobCRYPFHHbnokY4fTVIjnFr3rp8i9QIR14T1uJFgIx0OwhqOaQHzaKI
 Uw9ACdLo5ocmwOrah4WNmQLcJG7JmipvWn9gk3/rEtdSNZVF4sRPiwizN40PCf9LOhwNwnZfNvO
 Nx1MAkLOvT2wPpcS/sw==
X-Proofpoint-ORIG-GUID: Yt7bdE-qoWKdOSAtfBwVyRDaZ5Bh7gA7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_05,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240134
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

Some packets end a translation block without a change-of-flow. These do
not update the PC during commit, so gen_end_tb() leaves
hex_gpr[HEX_REG_PC] pointing at the same packet and the block gets
re-entered forever. Set PC explicitly to next_PC in that gen_end_tb()
branch to fix execution of next blocks.

Note that gen_start_packet() used to have a special case for
tlblock/k0lock, setting ctx->next_PC to the packet's own address. This
relies on the tlblock/k0lock helpers to properly advance the PC, which
is never done (only env->next_PC is updated, but that never reaches
hex_gpr[HEX_REG_PC]).  Drop the special case so these packets advance to
the following packet like any other non-COF TB terminator.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
---
 target/hexagon/translate.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/target/hexagon/translate.c b/target/hexagon/translate.c
index 29821ffe3d..da058fe976 100644
--- a/target/hexagon/translate.c
+++ b/target/hexagon/translate.c
@@ -217,6 +217,12 @@ static void gen_end_tb(DisasContext *ctx)
         gen_goto_tb(ctx, 0, ctx->base.tb->pc, true);
         gen_set_label(skip);
         gen_goto_tb(ctx, 1, ctx->next_PC, false);
+    } else if (!ctx->pkt.pkt_has_cof) {
+        /*
+         * Packet with no deferred COF that still ends the TB. PC is
+         * not updated during commit, so set it explicitly to next_PC.
+         */
+         gen_goto_tb(ctx, 0, ctx->next_PC, true);
     } else {
         tcg_gen_lookup_and_goto_ptr();
     }
@@ -293,6 +299,7 @@ static bool check_for_attrib(Packet *pkt, int attrib)
     return false;
 }
 
+#ifndef CONFIG_USER_ONLY
 static bool check_for_opcode(Packet *pkt, uint16_t opcode)
 {
     for (int i = 0; i < pkt->num_insns; i++) {
@@ -302,6 +309,7 @@ static bool check_for_opcode(Packet *pkt, uint16_t opcode)
     }
     return false;
 }
+#endif
 
 static bool need_slot_cancelled(Packet *pkt)
 {
@@ -581,10 +589,7 @@ static void analyze_packet(DisasContext *ctx)
 static void gen_start_packet(DisasContext *ctx)
 {
     Packet *pkt = &ctx->pkt;
-    target_ulong next_PC = (check_for_opcode(pkt, Y2_k0lock) ||
-                            check_for_opcode(pkt, Y2_tlblock)) ?
-                               ctx->base.pc_next :
-                               ctx->base.pc_next + pkt->encod_pkt_size_in_bytes;
+    target_ulong next_PC = ctx->base.pc_next + pkt->encod_pkt_size_in_bytes;
     int i;
 
     /* Clear out the disassembly context */
-- 
2.37.2


