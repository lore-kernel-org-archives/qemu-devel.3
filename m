Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 987F8E8B39D
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 05:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnVI7-00082y-Lz; Wed, 04 Feb 2026 00:19:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVI5-00081b-Jq
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:19:01 -0500
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1vnVI4-00087U-6m
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 00:19:01 -0500
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-c47ee987401so250983a12.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 21:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1770182339; x=1770787139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1/POBbzvFsH1ygUjRGcpksWmZ9M+w+T/oFj7/7kP11s=;
 b=FrD9egJTIrHKnzNKQvVpeIXrcSdayNoRG5e73ErI0SUvVAB+Km8gyji35XN4HCPrC0
 4EKWOBqRaKUhGwgDFVPPQsxiMIytKtsdOGCyRh2USFp2w9LA8z9tekhvmOqixWMcU4Oo
 fydBk33kv5VtfW1N/uJhaw+XznjVb/zeHT4sODlHz33YfOBBAJ+UIlE5y17TrekHitvR
 koyvfKBVl//dKRB4DocH89rc0LyK10QkngZKePYaWq/eWkoh/iGu2GmqR4U10ZcqrZQW
 9oTBYxpR/0ZTLi1UhFonUP5J8lvOO2wN2Ll5AyHR/0Ds+diS+N8Pse7YNGqbSHoa8XzS
 R06Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770182339; x=1770787139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1/POBbzvFsH1ygUjRGcpksWmZ9M+w+T/oFj7/7kP11s=;
 b=hvaUsvYV+Ry8HhkuxYe+KNYnAa426+ERg2yTy4oKHh0WQ8LUj1/MheDWVlASGirB3t
 qPBa17W++5i8yZCGGY9wRTngWpHd16J40iCClqnpj7EMHw3n9LNelb6yDUIoBLF5g9qe
 JNc4OJ5G/5nWzVYR2ALxLJf2mhSGlKLhQuz6hoFGSHsTGjJXwZPOasfhO2N4Vb08rlyz
 ZP9mWqs5gU4uk47cA57gqR30gNUczLbSD20u/oqc0K+Nr1Fqcqd6E996rVCOA292vxi5
 vAZb8iCZqkxaka1hqF9oe2NBou9nRTEQ+8sVikoIyPVjCXXkaLGmTu7c4fqgjt3l/GX9
 oUIw==
X-Gm-Message-State: AOJu0YzfR4m4RYhSKCKWlyiHYr3bYvIUhT4bcbfYLe3rKzqyNQnc6iNl
 s0qw9ya1OqtAXAf12wN+fLLSlQnvfakqf3f51QgEL14Opa9KyDOAVY146BY6Mwq/shgbgh5uejx
 sDwHcXHbV4OpumgNYogiX3k/xkHD++CG7y0GS9vLxddULHwvLSsrd0rYkgtyRGg0z4nVcHrD7Dg
 42mfEhRavsAMq+RPomSW2PaQmup19mNzjWzwa4FFH+KRTB
X-Gm-Gg: AZuq6aJwnS4AYSNVcM9vu438rvyqPdqrJ+TLmV+x2EYYs79UaaKRjXMZA3b7OkFEQsY
 kg/CDt/8P0Fj/Lc/LxryOm+rgubEHnTsLyFYcINxN5jN+WqlxmK3NO6UYkN4tMPQVgakwk5sGJe
 xf8CtnReJAIpaGjDgANonWhnbyV1wGcnY+Nvw5JLpVGggbK7HuchbLHCaD/qT2MF5UQOsAd5ko2
 1oRySYBN5f3hQ+UD1GDtPpJuHLkKLXn0HeFnGH0kBDKGR+WtLwXbE6b2HNmumtroXU5USvLTNno
 mt7rdi06k1bPwXQoI0FEdtbn/HW46RoBjGPctNBhOSnR3KegwQ31MBq9aWQXt5J27tYQ3KoR+ZR
 /PkVNuVWDzarUglFE+OJVSEVsrpPa+u3q+f1A6VhZQZvmKdC4C8CHLCjonLxZ0Zdg+JwvhxfnF6
 +FCHGtEDUVBsRTYWB2jDjXHKmpXDkoM1e6Bd86I8avOVIOOyKSG6WDIg9iGzEMMPFuGk3CM5CWb
 VZjk1Kj/Iyd07o=
X-Received: by 2002:a05:6a21:328a:b0:38b:e8f3:7065 with SMTP id
 adf61e73a8af0-3937233e8efmr1805681637.19.1770182338793; 
 Tue, 03 Feb 2026 21:18:58 -0800 (PST)
Received: from duncan.localdomain (114-35-142-126.hinet-ip.hinet.net.
 [114.35.142.126]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35485eb8d90sm1266314a91.12.2026.02.03.21.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 21:18:58 -0800 (PST)
From: Max Chou <max.chou@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Max Chou <max.chou@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v3 18/19] target/riscv: Expose Zvfofp4min properity
Date: Wed,  4 Feb 2026 13:17:54 +0800
Message-ID: <20260204051756.667397-19-max.chou@sifive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260204051756.667397-1-max.chou@sifive.com>
References: <20260204051756.667397-1-max.chou@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=max.chou@sifive.com; helo=mail-pg1-x532.google.com
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

Signed-off-by: Max Chou <max.chou@sifive.com>
---
 target/riscv/cpu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 87827441d3..d2f25cd14b 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1384,6 +1384,8 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[] = {
 
     /* Zvfofp8min extension for OFP8 conversion */
     MULTI_EXT_CFG_BOOL("x-zvfofp8min", ext_zvfofp8min, false),
+    /* Zvfofp4min extension for OFP4 conversion */
+    MULTI_EXT_CFG_BOOL("x-zvfofp4min", ext_zvfofp4min, false),
 
     { },
 };
-- 
2.52.0


