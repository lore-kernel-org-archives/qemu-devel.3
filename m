Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA426C35FFC
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 12:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx3ZW-00013c-NZ; Tue, 25 Mar 2025 08:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx3ZN-00012b-0w
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 08:39:49 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tx3ZK-0005Nn-Ia
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 08:39:48 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39ac8e7688aso499505f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 05:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742906384; x=1743511184; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uEliZr3OfJAnE0D5P6Q3RvPbW502QatPMezLPX4YXZs=;
 b=jSy8tzm4A3gmDdV392+YvGFxwhs1djQr9IjeivLK6m3J6nILfSFkcWMKA/NoMIR6UO
 31BJlh9K+L0FeI9gj6JJYXLW5+gn+Pe/9YtSZXwuDwNYnRg+e+NpanA43pnBY2C0QRQ9
 5dN9aLCaOEsr6+emL1o3HnSOBZa/nJRj/2wZF+aYb7vmY46lusIo/uFMLBQnlHiZZikJ
 vUTs7DQRkCTkRPSzB0OZhkzlL48+oAhUk9GS5dQzpNsNtKPJCJ20xegAPva5shzKpF55
 dbf6VNaL1F8BTpp3YvLTXs6P4GBryjVeIsOqifKyexAgj4m51DWwmJdj/x0SLhj8clpr
 kpMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742906384; x=1743511184;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uEliZr3OfJAnE0D5P6Q3RvPbW502QatPMezLPX4YXZs=;
 b=tFimjbWXZ8pg5ucdxQuniLkAOAIs81Igo//Ys5ZXnxkZDlzPX+rRYqthedQMq4mqnO
 W/6lH8rZ6kKRxrIVAyHcDMZPUyjt9NNeqBGHuStxg+v5KGeN4JKzyS1tlKwWu16O6acw
 8b/wOfzTDw8BX6i+dxeARYb8Co+XKCj4eJO/Zha1jItfXz3aGuJ5Gl6wvqLMErxugBao
 TMF27bDu9E47jeHzBwvL2wOVuwIm8ugY8RWRII4Qeska8iQ6Qbn8OOVArrXsb3CdQ2sR
 QDkEwPaDhHhyJhqIzJRGJqs/QgbEUOIxUTN13d52avuK9wyfPFnggsy33lWNqfldcEQg
 Mz+g==
X-Gm-Message-State: AOJu0Yx0CYjEsz6yk8p275K7VGqYpjDpuSuwHkYLJzL/tLZ1Tnrc4In6
 0FkmKP/xl3GGMYpLbSiU5tJRX32aDemsdWiguwC0Z91yT1OxlkZJrAyBfZaddg0qE2Q5xfvz6ek
 O
X-Gm-Gg: ASbGncshOLz0CaE+sE8L1XMOQeOlI1HyL55et7rSsEPEy+AG2xWFwO5n22m2TWyMJ+g
 izLqdd/P4+ayslMCyamSEWRwptVMpD/Mi1C7HxFR7UNh9+5yH0+C8zQGN1GAOArDytAV6OHA4an
 NH+wx9kuJcA9OjmsZ37Fc7W8iteBDMoT41uzsDP7TFbkzbkAdaShikpfdAGWlexzIj73fAaQFm7
 HBqKG3zAY4kFdX/1ER4GMcqffSvUjrkwtWEBvvXB2zLiuVJVTXP9MkznKY05ZdSQ6KBAOyFGpxG
 PQ7pmnUX+khnzkI7mFk2s9ALq4IyeI0OX6WuvWsiFIsqCJgdlEqJwn5fP02TZI8YyTMKVw0hb4Q
 Vsouah7n3yuN3AZeWq+4=
X-Google-Smtp-Source: AGHT+IE/PHN/AZPcBXIaWb9BEZGhJMFZYQ3T6m1zGoEecBOyBnAbE+QRms5YqM9Wc6O6ZS1UaOTQ3Q==
X-Received: by 2002:a05:6000:418a:b0:391:4b8e:a200 with SMTP id
 ffacd0b85a97d-3997f9127f6mr10389775f8f.32.1742906384424; 
 Tue, 25 Mar 2025 05:39:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39abfc2115asm7617239f8f.4.2025.03.25.05.39.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 25 Mar 2025 05:39:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Frederic Konrad <konrad.frederic@yahoo.fr>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 3/4] target/sparc: Log unimplemented ASI load/store
 accesses
Date: Tue, 25 Mar 2025 13:39:26 +0100
Message-ID: <20250325123927.74939-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250325123927.74939-1-philmd@linaro.org>
References: <20250325123927.74939-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

When the cache-controller feature is not implemented,
log potential ASI access as unimplemented.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/ldst_helper.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index b559afc9a94..d4de32d3c48 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -600,6 +600,10 @@ uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
         case 0x0C:          /* Leon3 Date Cache config */
             if (env->def.features & CPU_FEATURE_CACHE_CTRL) {
                 ret = leon3_cache_control_ld(env, addr, size);
+            } else {
+                qemu_log_mask(LOG_UNIMP,
+                              "%08x: unimplemented access size: %d\n", addr,
+                              size);
             }
             break;
         case 0x01c00a00: /* MXCC control register */
@@ -816,6 +820,10 @@ void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
         case 0x0C:          /* Leon3 Date Cache config */
             if (env->def.features & CPU_FEATURE_CACHE_CTRL) {
                 leon3_cache_control_st(env, addr, val, size);
+            } else {
+                qemu_log_mask(LOG_UNIMP,
+                              "%08x: unimplemented access size: %d\n", addr,
+                              size);
             }
             break;
 
-- 
2.47.1


