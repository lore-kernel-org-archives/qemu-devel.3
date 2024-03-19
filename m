Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2F9CC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Mar 2024 05:14:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmRnp-0007AN-Sy; Tue, 19 Mar 2024 01:14:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmRno-0007A6-AP
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 01:14:20 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmRnm-0000e3-O3
 for qemu-devel@nongnu.org; Tue, 19 Mar 2024 01:14:19 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33d90dfe73cso2846828f8f.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 22:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710825256; x=1711430056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MdBay9QnTaqtTv3ytoKlMkJo6PR6wX7+4kTn1A8v8Fk=;
 b=oc82ToYTdG7HJDOBJLKyVaGJgQewY/rD+F8zeV170fBI9rz9EdNLH1VVjeEtWBkEy/
 vCHPQABivt3y6KoSqtDK4YJEmx/20f4RRXikbNNTf7BXoZiVSup1AUsZ8vHmWPGABjKl
 qUrL9h0CR3ybMYloElVriZvHD8ePBf5SW9PO0cKZCo3Vq5nJSUXMVM3aEFsz61HYyh2G
 MFCOhshdKktkr0pAx7TqKioSpDqPBCejSbVF55kdAgteibLkNXcOL5LcLvlJdCxSMkDK
 p2KIW0OYWT6ZSZ1Do+5fljlQTBsc8DpCHydqOsSkSlMmUbrTgTkncjTkl8QoP9ClW9z6
 Otew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710825256; x=1711430056;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MdBay9QnTaqtTv3ytoKlMkJo6PR6wX7+4kTn1A8v8Fk=;
 b=xHoRsNqIIQfLkwa5kaJozgdihE6o9HiPHu21fDjhIHLExVYftSKvKfY9JZMksLeUcq
 EjycFejVWMZcJ8h0f0tBR5/gQIBHPQEbSvxEWXHCU5p7BdjwpvaUvsXrwZoxeZb4BwdT
 YHrSEKxXFb2V2z/r9vwPE+qrBFBtyptZEUilcPpXD/y5D1TItXXz2vk/CvGzG6Of9Q/J
 HQpKAiBhakg6YrOXfJUaOjxiTpmWnGfLya0v7yaK2/IbJX/0/A7vkIIHhbhNqKMddPwm
 EWBIZn5AopzNx8UITlepNSH11mFEmxlRtnZC9WkzVTymdKwk3jIytW6lZdbE+zT0+ZCk
 hKHg==
X-Gm-Message-State: AOJu0YwnoH860l43AyVyFItk73IcSsgpD1bYUUQaefHiwJqJ1qvWCrIb
 yOXVrNcy5Ng0mjaPLpBnSeMuqi7SEKTYgFjEv/UazFzAolyRXCStPVIiYxJmfUTV/vgcBkjEYPU
 3
X-Google-Smtp-Source: AGHT+IGHkDnxnfjKPPGqzV4z5EyieBq7L3T6/ZBvtVVtJiUgAUE0VLhOAcCenK2IuCf81Kbr/gMEnw==
X-Received: by 2002:a05:6000:a92:b0:341:84ef:8bc9 with SMTP id
 dh18-20020a0560000a9200b0034184ef8bc9mr1285274wrb.7.1710825255731; 
 Mon, 18 Mar 2024 22:14:15 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.166.129])
 by smtp.gmail.com with ESMTPSA id
 j16-20020adfe510000000b0033e42ab5114sm11446897wrm.2.2024.03.18.22.14.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 Mar 2024 22:14:15 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/tricore/helper: Use correct string format in
 cpu_tlb_fill()
Date: Tue, 19 Mar 2024 06:14:13 +0100
Message-ID: <20240319051413.6956-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

'address' got converted from target_ulong to vaddr in commit
68d6eee73c ("target/tricore: Convert to CPUClass::tlb_fill").
Use the corresponding format string to avoid casting.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/tricore/helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/tricore/helper.c b/target/tricore/helper.c
index 6d9e80cc0c..76bd226370 100644
--- a/target/tricore/helper.c
+++ b/target/tricore/helper.c
@@ -76,9 +76,9 @@ bool tricore_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
     ret = get_physical_address(env, &physical, &prot,
                                address, rw, mmu_idx);
 
-    qemu_log_mask(CPU_LOG_MMU, "%s address=" TARGET_FMT_lx " ret %d physical "
+    qemu_log_mask(CPU_LOG_MMU, "%s address=0x%" VADDR_PRIx " ret %d physical "
                   HWADDR_FMT_plx " prot %d\n",
-                  __func__, (target_ulong)address, ret, physical, prot);
+                  __func__, address, ret, physical, prot);
 
     if (ret == TLBRET_MATCH) {
         tlb_set_page(cs, address & TARGET_PAGE_MASK,
-- 
2.41.0


