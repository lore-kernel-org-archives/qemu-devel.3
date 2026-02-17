Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A917E9A03B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 21:24:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsSX9-0002jN-W1; Tue, 17 Feb 2026 16:23:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vsSX9-0002iw-5j
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:23:03 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ltaylorsimpson@gmail.com>)
 id 1vsSX7-0002KS-FE
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 16:23:02 -0500
Received: by mail-oi1-x231.google.com with SMTP id
 5614622812f47-45f015a3259so1411529b6e.2
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 13:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771363380; x=1771968180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lTbyHx/pgMkzLCi63IJBxq0762O7SfGtXcz6O/gjW6E=;
 b=Ze6/H55s23iCBKk8QXHA+Kabtm6tmFP0i63Pi58a+37sQhuCxot6q8kae/coxi1dRu
 L12OvyS5x6FenhhuEwUh2x9cxGQz1G8L6l8dUcJ/CHFg82Z3xk2OS66cQFHkz5sNL8hb
 PGDzAUpWg7Zz0ZsW2AG5qXlORnvGk8xtAjGTBpkNbszkoC5NrFgZwO6m36f0mVvG7WSN
 MESGDPj1Tj5OSc3yR5rWEEeSAyS85jmRK5SzkVhuUZNbuMi/3uDpFZQxZlcXm+9L8xzM
 SbcxMmtp/T86cdf7JZDl3vSmwp1WAk5qX14RgX1Pc6A6siJuUIgMjrqrvvLoeA1vJeL0
 MeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771363380; x=1771968180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lTbyHx/pgMkzLCi63IJBxq0762O7SfGtXcz6O/gjW6E=;
 b=IwXBEgeOERy0r0AkJ71MgJR3Z4T0K0eyg5MIfe16XTeZbbF5jkw88PrgIYsukJVRsx
 xcf9hB7DKQcWHcTP9qhdlK+E6O8vXzPlok4Lo+hD8K88iT3VKCthE9NS1I15rvnWQZGs
 sBzDilC+VF3EaDmWS21cCjcFEAZakfm9NbhsZzfmJBCq0HQoYOdBpj1olN0asA21FNKq
 TlP80rgoPdXW7kDkCnBRxQTWfIhJRsB62vOCiLQb7C3e1uw1qsu0N5Ob7VUrizQvB1S0
 mqYlwjgj5wWam9ktPuRPGcciOiIYaMYUV4Je9Jt5afvGhIDH7aYm2oNP+TLYFDQKi9rY
 3Tdg==
X-Gm-Message-State: AOJu0Yw4VIEHntqnOwWOa8V1J5oUh8JRsV+b/4fa/1FXIm1j6t1Ap3LR
 OsjaaxROehw3851jrW/W55puUv9D7ivTq0dFayo1Y82Bl7uMHOsi0lyRjfhEUA==
X-Gm-Gg: AZuq6aKhiLWnsiOz/MVcSrdN/HCfxBmldguXZ80OrlEx9Y4614dbAAv8bQkp2TWc7li
 3tXhWuEqIP8h3ia+VYvP5y6u43CgDeqSffNHuBGgIqSScjZNJHPr2uPA1GjUMi+Cj0wz6G/AfPj
 ZltEVmCf1B8mM3Ic9qjqUuAw3Qa+sPKFEj/ZeESs4rxeUEBiZEcXQqc58sWW6r0JT5HIUe4uck+
 ODHmV+mtWBF0lYiSjTG3DyVikX4aljkaUi3vYwHfxmvdv+gO13azb0a1ybP1fORQX4UTci/SEmK
 HzteXif2bJHFCmRRKznv90qa54mJzkgTsfUmWkwKiNgxuIqyRqNGuKGptQd3FTLeANAUCRcYlFl
 ailUCkTcQwascqSssDQDhAy/1gAApTRmzdzlgBXs3ebtonk5MPsFDEdl1orkvQqCrbwDh3nimLU
 PjjnBOZQaMyOvL62APh6B14UJ1n+Emcy8KOKqGfk4uHxshbjzjFxF/Cafv3x9J7rxgnz5OuKh17
 HrL7fzW8nmpFnpw
X-Received: by 2002:a05:6808:f0f:b0:450:b43b:3142 with SMTP id
 5614622812f47-463b41fa1ebmr6730069b6e.67.1771363379913; 
 Tue, 17 Feb 2026 13:22:59 -0800 (PST)
Received: from taylor-ubuntu.. (c-67-172-136-152.hsd1.co.comcast.net.
 [67.172.136.152]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4636ae8f86fsm12899319b6e.3.2026.02.17.13.22.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Feb 2026 13:22:59 -0800 (PST)
From: Taylor Simpson <ltaylorsimpson@gmail.com>
To: qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng,
 ltaylorsimpson@gmail.com
Subject: [PATCH v3 8/8] Hexagon (target/hexagon) Remove snprint_a_pkt_debug
Date: Tue, 17 Feb 2026 14:22:45 -0700
Message-ID: <20260217212245.95321-9-ltaylorsimpson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260217212245.95321-1-ltaylorsimpson@gmail.com>
References: <20260217212245.95321-1-ltaylorsimpson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::231;
 envelope-from=ltaylorsimpson@gmail.com; helo=mail-oi1-x231.google.com
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

Function is not used

Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
---
 target/hexagon/printinsn.h |  1 -
 target/hexagon/printinsn.c | 31 -------------------------------
 2 files changed, 32 deletions(-)

diff --git a/target/hexagon/printinsn.h b/target/hexagon/printinsn.h
index 6f84ef93c3..de962b5f2e 100644
--- a/target/hexagon/printinsn.h
+++ b/target/hexagon/printinsn.h
@@ -23,6 +23,5 @@
 
 void snprint_a_pkt_disas(GString *buf, Packet *pkt, uint32_t *words,
                          target_ulong pc, const HexagonCPUDef *hex_def);
-void snprint_a_pkt_debug(GString *buf, Packet *pkt);
 
 #endif
diff --git a/target/hexagon/printinsn.c b/target/hexagon/printinsn.c
index 22b305f018..a7e46f4bcd 100644
--- a/target/hexagon/printinsn.c
+++ b/target/hexagon/printinsn.c
@@ -118,34 +118,3 @@ void snprint_a_pkt_disas(GString *buf, Packet *pkt, uint32_t *words,
         g_string_append(buf, "  :endloop01");
     }
 }
-
-void snprint_a_pkt_debug(GString *buf, Packet *pkt)
-{
-    int slot, opcode;
-
-    if (pkt->num_insns > 1) {
-        g_string_append(buf, "\n{\n");
-    }
-
-    for (int i = 0; i < pkt->num_insns; i++) {
-        if (pkt->insn[i].part1) {
-            continue;
-        }
-        g_string_append(buf, "\t");
-        snprintinsn(buf, &(pkt->insn[i]));
-
-        if (GET_ATTRIB(pkt->insn[i].opcode, A_SUBINSN)) {
-            g_string_append(buf, " //subinsn");
-        }
-        if (pkt->insn[i].extension_valid) {
-            g_string_append(buf, " //constant extended");
-        }
-        slot = pkt->insn[i].slot;
-        opcode = pkt->insn[i].opcode;
-        g_string_append_printf(buf, " //slot=%d:tag=%s\n",
-                               slot, opcode_names[opcode]);
-    }
-    if (pkt->num_insns > 1) {
-        g_string_append(buf, "}\n");
-    }
-}
-- 
2.43.0


