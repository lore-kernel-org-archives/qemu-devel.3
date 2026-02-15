Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 896F2E63F1A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 22:05:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrkEM-0005YC-WC; Sun, 15 Feb 2026 17:04:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vrkEG-0005W1-Hk
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 17:04:37 -0500
Received: from mail-oa1-x30.google.com ([2001:4860:4864:20::30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vrkEE-00052I-Pj
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 17:04:36 -0500
Received: by mail-oa1-x30.google.com with SMTP id
 586e51a60fabf-40970f97638so1663270fac.3
 for <qemu-devel@nongnu.org>; Sun, 15 Feb 2026 14:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771193072; x=1771797872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kXEJCL5cVLliSmY30ZH77XTZKe2cKnewsMO5lSHXqmY=;
 b=h4XHvTwK7lL/tjXRdT/M94rc/k8mCC6BNeIvw+jrCikRd+q0Ypl635W+hIwFW9DTFa
 HnCaGG8Qgfh7Dx3u1pQPwAzYrRHKFR1jKvhCfmqUh4lkzkxdwLBwAGGXS9TqdyuIXMlT
 groblfYMX/yBxpACeJvXjXUvcCohqXpQMCC+tOLU72ZE9vm7ySLXAdPQS440FWhjmROK
 b1AfDJVfikhG0Dk3u4nAInFomJMERHfWTJkGGUSA37b+qzty2JDD62lCsPiIeyJALbyC
 LoYplffqDCmtVnSvoVL4DJI/Vskd3yyFRdVkwQ/lGZEXofuv6OpKE7pY5Co7+4hGl1w9
 V+OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771193072; x=1771797872;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kXEJCL5cVLliSmY30ZH77XTZKe2cKnewsMO5lSHXqmY=;
 b=k814Sx6r9eFhBa4FyUSMzNnyoB8zpYL09oIy35gKipO1DBhtV+TNt2CsFohFaIDtT/
 Qqb6VHow4DbLGGy/3+qB+DdAM7MaSa6s2uL68DiqfLI8QhEnJVGqlRBGk6uNJPASI0jK
 CyMBpA84n7ihUZOESuhFrC6z8pw8endj1pXIVRQzfj8mW4pKs4YjPzRjiW5Aq5ENylTq
 qBaDJnoHBLPO9qTQBqOhlGo78F56d66By0Bdv9meB4VRs0g62O49eXDvKQmXeg3xymwn
 O/CPc3zFfzbNB9ZbDtpG866YHVwEVPAGJ9SJDTvaJXcVX9BIDyiNyvr2ef7+YJ+fA52O
 fu2g==
X-Gm-Message-State: AOJu0YxBmTNnFGR3eFCpVoY1Y5mn9ti1JNvY3QiLUWdmH9eSyyw6YAAY
 9Kzie1db+6rAtdNogVe2OkE5RKom9D9mEvYatBnOWXjG4QxErF55/NxkjwVDxA==
X-Gm-Gg: AZuq6aIXGHwWGknJQmO0V+olr0WdMk+NJYrkr2fcuz0JHO9cb/Xgr0GYIc2k0+lI4aM
 bben7y2oAtD/YT+OzgfXArqbaFmmbrwhobjCKqUaqpGx0yw46+tXI/66yyRNPKmEANxn3aGALuy
 n0UA4plMuS6FqqLJSpzwnqqU+bWQuVGE7drmsP+XFInoqK0/YSUTBbbLAJ/gz/PA/cF2SMthncs
 /tBaeNHIy8GPOc4hgY1TORXHzP/KqEFT6wmEepV6tI3MiEtXre5oDsXk4CPWQvTAlwSXB438wD9
 1wSzPTFCBf1Cp+mNeiLNIpfnh9bok5QbQrHV4MVutWP3H3o2XN1KXm94QF/f5ab2pFtwvQ4NgKQ
 4ymiU8/gpAnbrOZUuRGWyuVnVsea08K9wBJrrtqoT62LCJClesAAIaSZjyZFcT4QYj9YBQ2bcim
 YsO6t5rK7HOBR5KFWHCcCgJjEHZ8w3gNP38VITH8KHuhh6E4WwmIEJPBOGDItwPzzO5Xp+7UhQm
 YvqRvc9PDJee+qm
X-Received: by 2002:a05:6870:6494:b0:409:74c7:1cbb with SMTP id
 586e51a60fabf-40ef3bab1e0mr4953045fac.7.1771193072463; 
 Sun, 15 Feb 2026 14:04:32 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-40eaf101db0sm13556664fac.12.2026.02.15.14.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Feb 2026 14:04:31 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH v2 5/8] Hexagon (target/hexagon) Check each opcode against
 current CPU version
Date: Sun, 15 Feb 2026 15:04:19 -0700
Message-ID: <20260215220422.212249-6-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260215220422.212249-1-ltaylorsimpson@gmail.com>
References: <20260215220422.212249-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::30;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oa1-x30.google.com
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
 target/hexagon/decode.h |  2 ++
 target/hexagon/decode.c | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/target/hexagon/decode.h b/target/hexagon/decode.h
index 3f3012b978..44fea2b37c 100644
--- a/target/hexagon/decode.h
+++ b/target/hexagon/decode.h
@@ -30,4 +30,6 @@ void decode_send_insn_to(Packet *packet, int start, int newloc);
 int decode_packet(DisasContext *ctx, int max_words, const uint32_t *words,
                   Packet *pkt, bool disas_only);
 
+bool opcode_supported(uint16_t opcode, HexagonVersion hex_version);
+
 #endif
diff --git a/target/hexagon/decode.c b/target/hexagon/decode.c
index dbc9c630e8..b02a402dfa 100644
--- a/target/hexagon/decode.c
+++ b/target/hexagon/decode.c
@@ -647,6 +647,21 @@ decode_set_slot_number(Packet *pkt)
     return has_valid_slot_assignment(pkt);
 }
 
+bool opcode_supported(uint16_t opcode, HexagonVersion hex_version)
+{
+#include "tag_rev_info.c.inc"
+
+    struct tag_rev_info info = tag_rev_info[opcode];
+    if (hex_version == HEX_VER_ANY) {
+        return true;
+    }
+    if ((info.introduced != HEX_VER_NONE && hex_version < info.introduced) ||
+        (info.removed != HEX_VER_NONE && hex_version >= info.removed)) {
+        return false;
+    }
+    return true;
+}
+
 /*
  * Check for GPR write conflicts in the packet.
  * A conflict exists when a register is written by more than one instruction
@@ -746,6 +761,17 @@ int decode_packet(DisasContext *ctx, int max_words, const uint32_t *words,
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


