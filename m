Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E24AD6CFA6
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 22:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vj2up-000880-4y; Thu, 22 Jan 2026 17:12:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj2ud-0007nj-6m
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 17:12:24 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vj2ua-0003UN-7f
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 17:12:21 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-4358fb60802so918414f8f.1
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 14:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769119938; x=1769724738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/ODkndRwX/R09xiWds3ROCMF/P61RrewKW7dQu09WfU=;
 b=YDVboT70inQmhQLADYrA6gjYupaCB9rAcdTrvpiVVeUKvmR3F31H2NjH8MsbHGbusC
 hvWQKxBj3kDztRN3aUHeatpf2w8dOQnIqUwxgJmeCzuuFTOPGXuwKOMTqqMrDZKcw+u7
 YSvBwJDtqCLwqCaLRa6BYIJwDARMWwK1KxFYmEinm5MgkGSxX27Pa6VS8O0NM3eVMnkE
 yFTPUzf8tqEeTGNFcWt2Ep1ZsrmdESD9Rjuw7CZ+/8az5lIbdvOeHwpEWe38goG42Cqj
 g+vGBTcojyztJpfjinE34O7bF+CvCs0bsmwlu3O/LjkgP2iL34FNyw/6XHUij5i+405b
 N17A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769119938; x=1769724738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/ODkndRwX/R09xiWds3ROCMF/P61RrewKW7dQu09WfU=;
 b=PLFHbr013bwoM+CO1iC0uMQ/7BPRCGVW7TcH4ixDrec3P11K2zgByzJdyQq/rvUwn0
 u8JqdQmOJLMJye+qFSTdvB+GKUrvb38hJTep90/NLvIvFC31GaYToY/qLDWg3cmB5WDN
 fVpPJiiUtHQYcdl3N+mhyrdMViZvnJAMRXKdUckb8Id63jeRdn8bALgUrZD73F9Dl6Jg
 b//P7LMhXE/nKgA0wGQLXNGYYAK/+TbJnrn6/vtmZ7Vm2zuKuekP5Fd7A5670uZm5hyP
 wXkNtNEEcpsDfD/woPsZx8642BmfDa1DFbWJJuVGdJpM4XuOxswpcKsPePAqbQY2FN+M
 /jrg==
X-Gm-Message-State: AOJu0YwItpLDxTtKLBX/nvZOIGn/LoMm0T6UTtZCRwB3vxIeNy8OgeZ8
 HqvoFMwOH8/gFwv+sqKlQcNQSug6DAKY+lBvACOxRzv0ijzvMXiEiWvgMnoozZ/OfivGQGYOYeG
 kmLanxlc=
X-Gm-Gg: AZuq6aKSCFb3s6lXv3CMrxjLPfF6OqlG2oXC+InD00sJFcU1NVUXwOXXXNE482apAAX
 70iAn4T+JyS+rXxfmhSbPoUfPLOHp8YJ81UBsD9SI9wfrGIc5RWDBlFP2My+13VInGy860hvwWe
 lF4ZDnhhBbEvc0tk5NVIFJBiZ9k+r/AatRtHkTGZlKtVrmcVKqE9XE82s7UTx7EHB+kYyg4Oc7d
 oySQbNRjii1kcgTvlwmN5JNPNm8oDu9mVdZBFsm6g9ROXB4w9xia0LcMlh88hjbDDn+euIOOmb+
 9sfRRx3Q8u1Syr3UzPmjiOQkjM8IXiXKW/Z8l5EKzdzOtODr5nccQ75dq+SVzYt59cnY59zJ0W+
 ZillmTZ1uPVtIZM1ct5hCPuj5RtrPcwEloFreO7kSyw/xuM6trYk6usIB6GFGTQXJ61mObyU7a1
 Pfk0Yb0g1UAyl5JxNtIXQ+Mg2P1w5ldbRQG2YN2SGNfSKG8KNklEDsLO2SVYWA
X-Received: by 2002:a05:6000:2584:b0:42f:b555:5274 with SMTP id
 ffacd0b85a97d-435a5fe4995mr7244506f8f.20.1769119938328; 
 Thu, 22 Jan 2026 14:12:18 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c02c91sm1728579f8f.9.2026.01.22.14.12.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 22 Jan 2026 14:12:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Chinmay Rath <rathc@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 10/11] target/ppc: Check endianness at runtime in
 mo_endian_env()
Date: Thu, 22 Jan 2026 23:11:04 +0100
Message-ID: <20260122221106.57184-11-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260122221106.57184-1-philmd@linaro.org>
References: <20260122221106.57184-1-philmd@linaro.org>
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
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Rather a runtime endianness check via env MSR over
a build-time one.

Now CPU can change endianness at runtime.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/ppc/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index 714629079b5..7dfca0b41a3 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -31,7 +31,7 @@ static inline bool ppc_env_is_little_endian(const CPUPPCState *env)
 
 static inline MemOp mo_endian_env(const CPUPPCState *env)
 {
-    return MO_TE;
+    return ppc_env_is_little_endian(env) ? MO_LE : MO_BE;
 }
 
 /* PM instructions */
-- 
2.52.0


