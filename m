Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A0CCA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:29:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENvx-0002SS-2n; Wed, 07 Oct 2026 05:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xENA1-0001jk-5W; Wed, 07 Oct 2026 04:38:01 -0400
Received: from rev.ng ([94.130.142.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anjo@rev.ng>)
 id 1xEN9y-0006XN-Vx; Wed, 07 Oct 2026 04:38:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rev.ng;
 s=dkim; h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive:List-Unsubscribe:List-Unsubscribe-Post:
 List-Help; bh=YbnFxmniTVtQNf+sg3qtCz/tUqf6JqV+sSt3d577c40=; b=HSGBLA1s4xMwqPE
 x76I0B2uw+uQn0wTblNI7caqZbwzQvn+2tbFKD3b73FLFAGaEJWkCa9u+3ai/wHga4j8Ep+73mFp3
 EJ0e9Nd186krXK1Ix0l+7v+sREPZ9LegSuTndH0xFc/tFfhHbvykDGKzBGSauAYf+bV1rbL6ITKMx
 tg=;
Date: Wed, 07 Oct 2026 10:43:14 +0200
Subject: [PATCH v2 08/18] target/riscv: cpu.c unconditionally check larger MXL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-rv-dedup-v2-8-8a2f0f296a7f@rev.ng>
References: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
In-Reply-To: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 daniel.barboza@oss.qualcomm.com, philmd@oss.qualcomm.com, 
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com, 
 alistair.francis@wdc.com, luoyonggang@gmail.com
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791362620; l=764;
 i=anjo@rev.ng; s=20260210; h=from:subject:message-id;
 bh=fO9kpHKHiJMLvNE+a+3W2IIgPNAZNXwxtmHJ5yB+698=;
 b=aQumlUl3JcRkR1VJoFtCWTihtywJenCgF9lNNoM3I8RuI2kBEwTKyzJeUYbQmPK7w+w8xhA8f
 I4AyJ4eO/E8AdMb2UuRPh/aOVO4/AlZbuKA8kpRsoPj8GM6RXZt00cn
X-Developer-Key: i=anjo@rev.ng; a=ed25519;
 pk=dKsZvj/g3kgDxnV1/SWg8a0YNGSpWtFGNsWIepQYKow=
Received-SPF: pass client-ip=94.130.142.21; envelope-from=anjo@rev.ng;
 helo=rev.ng
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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
Reply-to:  Anton Johansson <anjo@rev.ng>
From:  Anton Johansson via qemu development <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Signed-off-by: Anton Johansson <anjo@rev.ng>
---
 target/riscv/cpu.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index d1727ce2f5..c969994503 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1595,12 +1595,10 @@ static void riscv_cpu_validate_misa_mxl(RISCVCPUClass *mcc)
 
     /* Validate that MISA_MXL is set properly. */
     switch (mcc->def->misa_mxl_max) {
-#ifdef TARGET_RISCV64
     case MXL_RV64:
     case MXL_RV128:
         cc->gdb_core_xml_file = "riscv-64bit-cpu.xml";
         break;
-#endif
     case MXL_RV32:
         cc->gdb_core_xml_file = "riscv-32bit-cpu.xml";
         break;

-- 
2.52.0


