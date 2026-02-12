Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23DAEDF021
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 03:35:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqNTc-0007jF-KO; Wed, 11 Feb 2026 22:34:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vqNTb-0007if-3x
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 22:34:47 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vqNTZ-0008Hl-OY
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 22:34:46 -0500
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7d45d37f8e4so1500592a34.0
 for <qemu-devel@nongnu.org>; Wed, 11 Feb 2026 19:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770867284; x=1771472084; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0C9mKY9bS8naSm+Nlm3pxudoZqNzxShH72AlppPstKs=;
 b=lCY9FB7PcEudwcpMVW62JnXEDrSsc0MSwkojFMokxHsPxNwX1jgnzxYYE98Cvl0Dpd
 uEwDAC6jJ+6c+nlpeac0uv25lugPl6LAoOXF9s+Y0AQXraD3leimwyvRrNatrE5XxvP+
 wi8DKVeBi5XPx6bNV7DNTMUJSAnqM/4gRxOL+1Ta9AifGDbYbqb+JZLflwR5OAMSzply
 X5SZRg3pd2Fr3hHfw6Gk2tT1f2fVgTH7ESiH1eDsThbsECEEy3Jk5eIFgcSCrbtAfxLP
 V0M9HGmg22fJw0BLd9NaDX7fgO1a+bkYvB8+tc6+/rDCX+a3vWV2tpLYqFuTpuZnNL+Q
 wMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770867284; x=1771472084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0C9mKY9bS8naSm+Nlm3pxudoZqNzxShH72AlppPstKs=;
 b=cJovOm8vOz+BWQvVUa7UW2J+m8G+m2X+0sAuVn0HvOWWxeRmr6M95vXkQZGtStaeRE
 RUcb80nvjVBm9gYYj7zBQm+sZChc6JGPM3x0P3pDgX325kWBLGaUEHjGBXdYcTUERJau
 FJoAqo5+89Rs6l+qxbylSIFqLbtaSozkiQInTSm8isZmLfOYTL+N5hoNAHwctCU8dZHT
 /7Htfl2WTnxXyi6Z7RT0nAMZA5Pfu+W5417bvAke80GpH0kd7xd5F82zpRsEyyCJP+ZY
 PdRkBB8kULz2EFxDKzfG7Yjji0j3hbdQUSK32KGmHnvl94sLe3dCpiyMIXyWDaW/ASOQ
 74dg==
X-Gm-Message-State: AOJu0YzMaC92VayLunS435y06jgGwkXuWh39VEuEGq+9HZ8aN0RxP+wS
 I6+UutSXPxcTakof/6uIfvSSDA+pjBlZP+8D0boQCIjUjxNkttimgE1SHUaKfQ==
X-Gm-Gg: AZuq6aIWUQGvmCcP8vOJVgXYgomelO/utLkKykfZHU28cHfAVurFRPFHKDop7XbBoAu
 NhN8BdQqxXlgQVVWD4oaAL0t5dw7kNL4iJSXE2pfxGpU5Sv0tEieYj4PQbdz9OjBudxiUY+/n/E
 G4m6VBYEQhIhjYKyJpyFhYbOLY0xZxHw94qzdgbmYTiqSqYvaRMyrt6TwLb8B3CCmcay1OTeQrn
 VpyJNQIioIHDRyygpYmHbCwM7cEq/t2+e3aoowwqSHwGpPAgKQLmzm4EUtGJ5sYYnzomj0PAswU
 1eaUOqC+0Hy0AO5wzIFxOQmo3Ds/ylxctjW00OmMN3rG6R3ipFug+TvlmoEQv7zP1AgSnDibtEo
 H7DBz1XO9fySZStn47nhm+QjXi17KB61Um/z2gZmX6+CLclrwSbGtXG0/bhqs60OXsaTGtfG3g8
 WQiS0z7pHeydNA0nfdY9szzIjZIVCTR6QpHqsKjsn3ZcA9hwTpJ9bECkbw1zqAIb6Mg/GgrABPZ
 09LcuB/9SmD6Q0e
X-Received: by 2002:a05:6830:490c:b0:7cf:e32f:de72 with SMTP id
 46e09a7af769-7d4b3ff6d3amr633366a34.6.1770867284440; 
 Wed, 11 Feb 2026 19:34:44 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d4a76e1b0csm2682858a34.14.2026.02.11.19.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 19:34:44 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH 5/8] Hexagon (target/hexagon) Check each opcode against
 current CPU version
Date: Wed, 11 Feb 2026 20:34:32 -0700
Message-ID: <20260212033435.3598-6-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260212033435.3598-1-ltaylorsimpson@gmail.com>
References: <20260212033435.3598-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32d;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-ot1-x32d.google.com
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

During decoding, check that the opcode is supported in the current
Hexagon CPU version

Co-authored-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
Co-authored-by: Brian Cain <brian.cain@oss.qualcomm.com>
Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/decode.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
index b5ece60450..0cff15e890 100644
--- a/target/hexagon/decode.c
+++ b/target/hexagon/decode.c
@@ -648,6 +648,18 @@ decode_set_slot_number(Packet *pkt)
     return has_valid_slot_assignment(pkt);
 }
 
+static bool opcode_supported(uint16_t opcode, HexagonVersion hex_version)
+{
+#include "tag_rev_info.c.inc"
+
+    struct tag_rev_info info = tag_rev_info[opcode];
+    if ((info.introduced && hex_version < info.introduced) ||
+        (info.removed && hex_version >= info.removed)) {
+        return false;
+    }
+    return true;
+}
+
 /*
  * decode_packet
  * Decodes packet with given words
@@ -691,6 +703,17 @@ int decode_packet(DisasContext *ctx, int max_words, const uint32_t *words,
         /* Ran out of words! */
         return 0;
     }
+
+    /*
+     * Check that all the opcodes are supported in this Hexagon version
+     * If not, return decode error
+     */
+    for (i = 0; i < num_insns; i++) {
+        if (!opcode_supported(pkt->insn[i].opcode, ctx->hex_version)) {
+            return 0;
+        }
+    }
+
     pkt->encod_pkt_size_in_bytes = words_read * 4;
     pkt->pkt_has_hvx = false;
     for (i = 0; i < num_insns; i++) {
-- 
2.43.0


