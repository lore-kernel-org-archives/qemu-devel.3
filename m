Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D2D8C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXXb-0003Tt-Lg; Mon, 12 May 2025 14:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWq-0002Rb-My
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:33 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXWo-0008VL-CQ
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:28 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-af908bb32fdso3775375a12.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073124; x=1747677924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ylmW/mRzMuupLX6PASMDyZOaBb+Dv5gnstRJQXcdzYM=;
 b=w98JqCu2vXZdwsXwb2d3otH9TFT9UajIsCPwloKfUKfvLIDA4iou29qBLD7N1AZOHd
 30dMhPp4fa50A2d6Gj0nzleAiL1nkKfPgdRK0DqRqjrBJAiT4Cx/WkWVNBq1BehLoXRr
 hec+VI65aUBfYE0Unxaz6k/fsqTFA054iRQXewqRVjYXJ/Vemcnt7lDzdsXiwBTWGt1D
 7wfdJIcEcjaGEAT6UqhbBcVhQjpaz4i2xFEBSTXZfSrovuvdGrMmnbmN/1cDMCuvLsKl
 UhNBAq7hQzPbFktS0c14AU+tcW/FGKE7T+QpwlxwPdnVIcIAEBjv+C7wfUWeOj+YG2bS
 H8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073124; x=1747677924;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ylmW/mRzMuupLX6PASMDyZOaBb+Dv5gnstRJQXcdzYM=;
 b=Adv5vIzxMS737nWOhJhGejet332OUWn1RrSEoUdHuffdyn781EZE1eTcuFevn+6B8x
 nmGnktV/+SEewzBfxA2iXgrvbKMIxuc8h5ovS2jOoduO0Arh2Fh5u22tuqJgUUS0uLAM
 SSWE1RqZe6exkfdjseEVnS8fEx4Yvr0xx4SlAz52Jroo7TwzalNRg0cwHT8yFlEPNba/
 v8dsLvNtd0zkdntdQcBOaOt/yPSwilqFAA+D/G4V6M0x4VsRcTeLu9UUxYHXS21m/2NE
 368yYe9YDnUYQgw7Qgfzi5DW8xhIy50pbQgswRg+tPR9qeDKeGZISWUwScX61NzgCOD0
 83Fw==
X-Gm-Message-State: AOJu0YzLiLaGwZDzWr7Qhh3p0Ll6DJt+EoRQfY0QiZDDowM0simhZNrD
 NfCexTN1km103NuDXfKwDbEc/FcAlwhlbKpLVu56k9D54osqgY1l8cDcGEGXn3QN2SRV4JcynMb
 r
X-Gm-Gg: ASbGnctowHEYyzzngEcChmd7t802EoezO97Eyq/SWEhnIA3XKyZxUkjHaBGKcUea/64
 ZDhRc8/edEGFPhJGTqz1ZoSwwEU26pzdEzx1GQgh/ekq8cefEJTYvUlwhR2FWGlhXx4B85akqEZ
 FnOAxsLvdiiIT7OLbvXud62CHoKrX+xzAm+o+ImtudjVZ8qWSXdpEguwgcrx+3Q4q/vCkMSps8G
 0CaiZJXy0q+RPWjal6DfBkIqK/qzGopbZNMv5RdyNMcRtQ7EcoxfmxQVHomsEXXn0IXOak3V+r1
 FKql98dO5aaWGBroJAITnO1ZK6FFqyUzpRpI4DioG/bF8nc5L4M=
X-Google-Smtp-Source: AGHT+IFnCAwgn7a7X5kZmBX+jZkAWwfoFbz5Gf/9MOjs3udFDxQLRtalnYZlQkwiO8PcKgx9CaND1w==
X-Received: by 2002:a17:903:1b0c:b0:22e:491b:20d5 with SMTP id
 d9443c01a7336-2317cb4d743mr5608975ad.26.1747073124392; 
 Mon, 12 May 2025 11:05:24 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:24 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 14/48] target/arm/helper: use vaddr instead of target_ulong
 for probe_access
Date: Mon, 12 May 2025 11:04:28 -0700
Message-ID: <20250512180502.2395029-15-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52c.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/helper.h        | 2 +-
 target/arm/tcg/op_helper.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/helper.h b/target/arm/helper.h
index 95b9211c6f4..0a4fc90fa8b 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -104,7 +104,7 @@ DEF_HELPER_FLAGS_1(rebuild_hflags_a32_newel, TCG_CALL_NO_RWG, void, env)
 DEF_HELPER_FLAGS_2(rebuild_hflags_a32, TCG_CALL_NO_RWG, void, env, int)
 DEF_HELPER_FLAGS_2(rebuild_hflags_a64, TCG_CALL_NO_RWG, void, env, int)
 
-DEF_HELPER_FLAGS_5(probe_access, TCG_CALL_NO_WG, void, env, tl, i32, i32, i32)
+DEF_HELPER_FLAGS_5(probe_access, TCG_CALL_NO_WG, void, env, vaddr, i32, i32, i32)
 
 DEF_HELPER_1(vfp_get_fpscr, i32, env)
 DEF_HELPER_2(vfp_set_fpscr, void, env, i32)
diff --git a/target/arm/tcg/op_helper.c b/target/arm/tcg/op_helper.c
index dc3f83c37dc..575e566280b 100644
--- a/target/arm/tcg/op_helper.c
+++ b/target/arm/tcg/op_helper.c
@@ -1222,7 +1222,7 @@ uint32_t HELPER(ror_cc)(CPUARMState *env, uint32_t x, uint32_t i)
     }
 }
 
-void HELPER(probe_access)(CPUARMState *env, target_ulong ptr,
+void HELPER(probe_access)(CPUARMState *env, vaddr ptr,
                           uint32_t access_type, uint32_t mmu_idx,
                           uint32_t size)
 {
-- 
2.47.2


