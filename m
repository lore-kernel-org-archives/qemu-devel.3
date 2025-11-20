Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12EB3CF9C7B
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Nov 2025 18:00:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vM8wf-0006vv-L6; Thu, 20 Nov 2025 12:59:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vM8wc-0006vN-AS
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 12:59:46 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vM8wb-00070V-0c
 for qemu-devel@nongnu.org; Thu, 20 Nov 2025 12:59:46 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42b3ad51fecso973088f8f.1
 for <qemu-devel@nongnu.org>; Thu, 20 Nov 2025 09:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763661583; x=1764266383; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yHdVko4CqE9nB/1z0KpwWAVnz/yDR+mVewV+tLlW9cM=;
 b=M+L72Xd+8HrA4S4PQsc+mnE20cBIYaim2aMxo/Tj2zkW2gpUoFR22fucVgWWUP2zkk
 oN0sroIP42+/qgDU7pfKvGjwsIcFOiciup0bvR3ffWBnf1cLGZZPDoChzgQdRoTcjvmw
 /CjPLh2Ss2fwR0pNhXzn4vlsJ4j/58EvD28/FjFQYkSxD811xucu/0ckgkJogj/yX87S
 Kmsi2zUZnHsmxpurUHnPD0OG5TRYH+lsEr4n/LF/jk1tgJzhw4ZNEwv7XCOt6bFodTQD
 Jw/V/dhXBR8NjybCwAoXtN1uOs8Sw/cAIaH4FHI6tmCyB+PplMU4E0aYA3Egoe4bg946
 lY/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763661583; x=1764266383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yHdVko4CqE9nB/1z0KpwWAVnz/yDR+mVewV+tLlW9cM=;
 b=HhhXMAlUiff6DXRZ8sglZzNy8gGd2/stLNTOZkA75HqQ9RYpBDwEr9WZ53zf76Qm/H
 o5M0uA+oMmyFlb9Q/QHGOPcmI/GjMCL87u88wzzCJ+hDJIAQcuXjXU6LsVeg7PcINy0t
 TCJKb84D7CEODbJ+kSjanAgrSQb7k1QO3zDVZYulnpcS5EUGHZ866wN9W1PBfnEHaO/9
 rwSZuLs7wmfYWbNOD68+0icnOr8Nsa+liFGJ302wSbBZ84u0wcuwTGrmVXlUvzuC+03t
 R58kGrNW/fiDGcGlvOsWZ8kNTgL2ArNw0hikE70ORQ8EgtcgtWNOlNbrNnbBXwh1fh2z
 yrSg==
X-Gm-Message-State: AOJu0YzTj8tJU2tJI5x91VXt6+n8otxZmCJAFUE2Uv4LpBuanvQheD/n
 nuYeyVn+bSOuR6hTxoCUgFEEO3zgHd7pM2G4+yJBEsX/GX8SF3cYrzx7R44C3anmBpMmw6LNs7i
 D3bIm7VYQrg==
X-Gm-Gg: ASbGncuU9CcGTiEgb1li1Z+6HStRBVY0TAfT4zoYbTEMfhmMBgALjaEpL+UYz1jAVxg
 QEck2vMmWNAea/pbjPl0hchgSD+Ej7KF4db/85s6Q8SVwMMfgyyDgPuhZizjHgJK/RdZdX/ma2T
 Ty87aiANAQbFQG5PUOVwzGwBLO2hFemqhSm7qAAbrrr3FHfBXukiByD5OZncf6bkOHQhA680SiR
 DdyhNB6MrcTCzUcdsUub7TkJ56XQKIslkDD4cHDEzdqmPg2fg05UwVdDN4Ku6XJcX6e6vl/1xne
 m0ebZ8omwlsZZC8pzd4f9Fqj6AkpUJXywN01mSinAymqnEk3zis2BBXV2A06h2bEMCe1U2Ekv5M
 LPVA1TD81/FVJl3qI8G5uFzKq+7aGWkjuFtIbDRyTdbSqC1MyHvHWcfWzMt+C65GTLlkWAgfq0v
 MeODC+tksq2NFHozmmX5/3Mh3r9wq2RZ4aVqWeacrrTxIsBPZIqahBflXhr2yg
X-Google-Smtp-Source: AGHT+IFNr4xS2tVjWh//IUCBlSP0VI8KMR3Vk9VMpDNVEdDbP9tquQ1nIVm4966gIupwbF6mIwLrsQ==
X-Received: by 2002:a05:6000:22ca:b0:3f7:b7ac:f3d2 with SMTP id
 ffacd0b85a97d-42cb9a4a111mr4392129f8f.43.1763661582723; 
 Thu, 20 Nov 2025 09:59:42 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7f2e454sm6910542f8f.2.2025.11.20.09.59.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 20 Nov 2025 09:59:42 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC-PATCH-for-11.0 4/5] target/sparc: Use big-endian variant of
 cpu_ldl_code()
Date: Thu, 20 Nov 2025 18:59:13 +0100
Message-ID: <20251120175914.6515-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120175914.6515-1-philmd@linaro.org>
References: <20251120175914.6515-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

SPARC is always big-endian.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/int32_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index b29f693a6bf..a777d17a01c 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -151,7 +151,7 @@ void sparc_cpu_do_interrupt(CPUState *cs)
         if (!env->fsr_qne) {
             env->fsr_qne = FSR_QNE;
             env->fq.s.addr = env->pc;
-            env->fq.s.insn = cpu_ldl_code(env, env->pc);
+            env->fq.s.insn = cpu_ldl_be_code(env, env->pc);
         }
         env->pc = env->npc;
         env->npc = env->npc + 4;
-- 
2.51.0


