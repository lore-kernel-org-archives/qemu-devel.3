Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2A1CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 20:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8lJD-00025p-Kc; Tue, 14 Oct 2025 16:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lJA-000246-HR
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:07:44 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v8lIs-0005Jt-8k
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 16:07:44 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-b57d93ae3b0so3480918a12.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 13:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760472441; x=1761077241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oewVOJfgxyjUz8vTExFpafNqiBn7o4ivsK84dIOvlkk=;
 b=VuH0MLrSlBrhIO4/yPund5eI9sFzQIE6FsmZiiXMHfCJQGMMU0fN1wxLdfH8UHaI9y
 GFyEPgfV81Z7oaPG+W2Yg3UQlMG9p9wDZKimHcKvvklT9AkB+T/1UFzLQY1Oij/WQZOI
 Cxo1hmQvfa4UbE+mBdu5kOJqfZPu/2nf8IoHJ8c7e73bF33d9wjLDQO+MJvqMOCKMjW5
 2feN9r4w94FTKfD6KpcgG4HBW6YMYKruFf7/uugWsQRExgLZm8zszDoFL6WGfy0joqe5
 mzYIxU7EATWigfJIzK14mUbDAGyRQ5pjc9WFeRg/gCh8XZQxRqaZLVCPh2g12PdCmBWc
 jM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760472441; x=1761077241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oewVOJfgxyjUz8vTExFpafNqiBn7o4ivsK84dIOvlkk=;
 b=sM19iccxjDDPpddA5JQdvSueUngvuvzZRgOs9idRWexezyM00wyBZYxmWbMtE9H1hl
 EIq1AQSynO2GCCHdCOhYyO7M1I1XPKyDOw8hy5WGaHZwmkGeqyOVP/O3S70YSAe7+bCv
 ZPlPqAFue9YL6fauXucUZDT8OiZ78S2kBDZ5g64fCPZ6AhuPuwlo9PtiGHVFKRo/eS94
 59IHZ3qNNk6TgnknTtQkmtBr514wy4JCn6EfGvMSQEi0zt/TsNPjxneIOopDzkW66xc8
 xbAJ0XsgfT9pMT4FP6ZcNe1lM+euqVCF5jmi7k5h97Vdm0gXASy1wxGbsySx2LdO8vG/
 1AJQ==
X-Gm-Message-State: AOJu0YxuLSqhymI3CtyT+XFaJ7us6GzV111sgwpmha890PFEJg8BRVVe
 0VINTw+l5zAn9QGTFD/EE2FsHQoGirmpiVg3KwJwW4wgpj+lthLiQRbyhIlGwmAcnyKnbz5Qmd4
 Jyf5ww2M=
X-Gm-Gg: ASbGncuk3BN58m3xfNwMhFeuPb2DAeyA8N8dO5UW2FDfz64dFhJbqmVAjI9HxkTLUwB
 ZbD2ZVmMpAyfWMcy29BbK9J8YAaPioHxxP+uWVeuJixJRDqkyEq6wxKzBlfZzb1Uc/Z3vviyFgW
 +Y9PlPc58iR3XTerft6839zitXDNRtkARuKfpwfEJQcVJ1fgiAPJsMmg5F3NkE6sDog9RRA8SYT
 lgv9wet6YV3Pg2mwJKz+9FmraZiJTUVaxDrMJuYDyt4XuosKtPzPnzEf1T2iE0QNErz4eotLIoc
 7sfWIIAfUUxuLYxAiqeB4mui+9kLs/aHbuDIW4v6nY32eHS+Gqs3SrBpNcIzopO0fTowb0anDIs
 kuD+J+QmsIWST6bz6qgAwwkxC2rQrtMihN4R9XkZ2mhv1475W+l4=
X-Google-Smtp-Source: AGHT+IEGTiKAdR+kvOmGu7djBOIA7v3L1wPDaSJ6eZKVT/XY+jM8j8mm9NKnfvjCgDMymFcB4Iqg8Q==
X-Received: by 2002:a17:903:3c2c:b0:246:7a43:3f66 with SMTP id
 d9443c01a7336-29027213356mr334659415ad.7.1760472440728; 
 Tue, 14 Oct 2025 13:07:20 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034f93ea2sm172100975ad.126.2025.10.14.13.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 13:07:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PATCH v2 02/37] target/arm: Define CP_REG_SIZE_U128
Date: Tue, 14 Oct 2025 13:06:43 -0700
Message-ID: <20251014200718.422022-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014200718.422022-1-richard.henderson@linaro.org>
References: <20251014200718.422022-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/kvm-consts.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/kvm-consts.h b/target/arm/kvm-consts.h
index 54ae5da7ce..1b3c10c0d3 100644
--- a/target/arm/kvm-consts.h
+++ b/target/arm/kvm-consts.h
@@ -30,6 +30,7 @@
 #define CP_REG_SIZE_MASK       0x00f0000000000000ULL
 #define CP_REG_SIZE_U32        0x0020000000000000ULL
 #define CP_REG_SIZE_U64        0x0030000000000000ULL
+#define CP_REG_SIZE_U128       0x0040000000000000ULL
 #define CP_REG_ARM             0x4000000000000000ULL
 #define CP_REG_ARCH_MASK       0xff00000000000000ULL
 
@@ -37,6 +38,7 @@ MISMATCH_CHECK(CP_REG_SIZE_SHIFT, KVM_REG_SIZE_SHIFT);
 MISMATCH_CHECK(CP_REG_SIZE_MASK, KVM_REG_SIZE_MASK);
 MISMATCH_CHECK(CP_REG_SIZE_U32, KVM_REG_SIZE_U32);
 MISMATCH_CHECK(CP_REG_SIZE_U64, KVM_REG_SIZE_U64);
+MISMATCH_CHECK(CP_REG_SIZE_U128, KVM_REG_SIZE_U128);
 MISMATCH_CHECK(CP_REG_ARM, KVM_REG_ARM);
 MISMATCH_CHECK(CP_REG_ARCH_MASK, KVM_REG_ARCH_MASK);
 
-- 
2.43.0


