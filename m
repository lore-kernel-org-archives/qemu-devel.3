Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B3FCD5BA4
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 18:33:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPlZ3-0007GN-Hv; Wed, 20 May 2026 14:22:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYm-0006si-Hh
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:24 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPlYk-0000Un-H6
 for qemu-devel@nongnu.org; Wed, 20 May 2026 14:22:24 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-3697f25d26eso2679828a91.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 11:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779301341; x=1779906141; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RgEwye1A/H/zER4vq4nD2iWWcMLX2i9wMfampUnYlVM=;
 b=oo6RFte0wdn5iVdGvdzksGp9vXbHzatLM424balUatPMIiTFRgZA/ew2yH+JWPaWWH
 NGOpifu+qtjbUQSK1PVLMijHu0/Kbfj+0rL5JzuV4uvvtM+XfgKT47NrzY8+3tcbF/bJ
 qv374ZSmN1XLL13GvnVk1S7Oql6s8eh4ZT4pQTleOAeYUJVjgqq5Vbgwqn5cNDLY/bbV
 yj6RMVq5zSrZktqNMyz0UVkCRVzW+CXdBWVHTKCZ1jNYrstlZjrngj/mFLHS0/T7hbi6
 E/ppYkYtY80XnEWwgwuQCLRwhaYhBSd+pu0KJymESXY2yR9SpE7x645iwC1w8B1xqeU+
 uDPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779301341; x=1779906141;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RgEwye1A/H/zER4vq4nD2iWWcMLX2i9wMfampUnYlVM=;
 b=s/3WdL46mYmmqi7v846gIcP6lAmnw3uWjesw0be8Jg/2VgeV8hArFQhv5JzbId4xbr
 Z3ZwEhMdB1CkUKk30KKLvI0Yi/2zZ8pfXcW6a/FWdj+rMIGmRO8R3N+iRcNXZxuJSe+0
 Ks8OiKNCF92fuSLl2yO924dlr2PksNsgMsT3aSmRbOOvCRkiSLdr1pU+jrJER4QZL/8n
 J2Gao/9z2b0a56316PaJwGjD23RrspJphaZwmr8hK21D9zC1AEcmRjGoP4LiZ9NuHymV
 u/GKJhz/iySH0b2p+CMjLbTkW7upRMv9Zgmg/Hd4Z6Qp1o56ZtJu0ByksBDzB433eubY
 1omQ==
X-Gm-Message-State: AOJu0Ywh6Zu8j6xm5sA9GVxoWMAIiCAm/WEVZuJIS6F2iEds7VVvC9rn
 gwOVCmPXdFSxFnsPStPkvTo2T/bsTcXr85zLxCuThkJcDt/rn3XP3yaKMxPksEkXBP0YNTapr4E
 AbavuHf0=
X-Gm-Gg: Acq92OGvvZbLmjsfVL9G1rKc1x5knQzBn3gDMUVPQJYi9cEMqQ09kCJpiEmakPILUQb
 mDTyzdGtuySIauP7zubiVYL4bULjWDZDgyzPLTTf+fae6+lrwljTo3RqH+G6/nAQEDNtgEHIsPT
 BY+DlZ2nOLHgDl/PIUtshelTzxo4GAurEXtXlulus8Q9rU9xK49RT/Pgbk0BT0TcWYIR8oM+TiX
 sh3PD/YABmBpFjm6nlVQr0Bz76Rxf15qFSjFFM1kCrSXjPMKgbgEmd+j8ju4Nozb4XCJVe5VK6e
 qWNfbERTn3iyOrrd8woml7mMy/ZSQJVjH4Z/BC0yVspnNVhBQxV9szCnrzc45wbLMuECwX3lrOv
 Uka2i9wRSJctv+ZuWEMi9BEXPU0KujtlDhLG5YXnXu3ksawt3hXI+3JpAeTejVO8EMn8fe+YjHm
 D72JHNfsVoiJzFZn4dwqk2XioQrmT3
X-Received: by 2002:a17:90b:4a92:b0:368:a27f:9083 with SMTP id
 98e67ed59e1d1-369519c71e0mr21655080a91.7.1779301340891; 
 Wed, 20 May 2026 11:22:20 -0700 (PDT)
Received: from stoup.. ([71.212.142.33]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3d210b4esm274764a91.17.2026.05.20.11.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 11:22:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v6 09/64] target/arm: Update SCTLR bits for FEAT_FPMR
Date: Wed, 20 May 2026 11:21:18 -0700
Message-ID: <20260520182213.872945-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520182213.872945-1-richard.henderson@linaro.org>
References: <20260520182213.872945-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 498af7db08..c114510446 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -1485,6 +1485,7 @@ void pmu_init(ARMCPU *cpu);
 #define SCTLR_DSSBS_32 (1U << 31) /* v8.5, AArch32 only */
 #define SCTLR_CMOW    (1ULL << 32) /* FEAT_CMOW */
 #define SCTLR_MSCEN   (1ULL << 33) /* FEAT_MOPS */
+#define SCTLR_EnFPM   (1ULL << 34) /* FEAT_FPMR */
 #define SCTLR_BT0     (1ULL << 35) /* v8.5-BTI */
 #define SCTLR_BT1     (1ULL << 36) /* v8.5-BTI */
 #define SCTLR_ITFSB   (1ULL << 37) /* v8.5-MemTag */
-- 
2.43.0


