Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A9D2E77180
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 14:46:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLNxL-0006tS-Rf; Wed, 11 Dec 2024 09:44:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLNxJ-0006rc-LX
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 09:44:49 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLNxI-0003rx-4T
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 09:44:49 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-434e3953b65so31548365e9.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 06:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733928286; x=1734533086; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fSuUeuHUzdC2KZRVDcvXd5GipqOsmtMAsr2Y358lzSM=;
 b=lEVfV+3pWsD6nlCUwDrGawexp989/56IuYNn0tbbUuRcfOt53hzztSTSGY2rt1XtLR
 1DnOAgU1mL0l/k73+McFcvvMvhlGNw9pUGSVhAjEfJsY3exsVuSJHzVwFk43Ow+1n9DM
 gEvky56OvTcHAh0FhlZ4Mvwb2y6Ff4Asp9fiCwp6SzjD3fA3e5rMbcsrE7ZdSBwJIL+d
 Gg4Kdc6hTJzDHxKbHXEOSf19ciW33P1OloLcaPlZXzfZyMk45r6QmaXk+yS/62+bXau4
 LBP4p5QhfJkrtjokX1KYplJGHDjCfHrbiFWRgW/afBVpMNJwsiCg+bPN3cRzlOyFJ2fi
 F+qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733928286; x=1734533086;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fSuUeuHUzdC2KZRVDcvXd5GipqOsmtMAsr2Y358lzSM=;
 b=N95+MOvM9yEpQzTDWKubTo3X/cHFCpCIL0bhtxCYO+sTV9fdpJHzxFQxqjN3FHfmjG
 okrMOm7D9/L+KDTSMwb+r+E7qhZXy1rCQK/AyLB1qBYb//5l7ZLh33+eDiYlgL42RbBP
 uS5SLckns7IKxrm7XBjAL9x8h51aKuUjQPsu0Vs6yvVUQTlsrFLmN+wzRNo4b7Nh0x8x
 2fd1Ubgyr8l/mjD7DtOEavlDuJ3i6BEPCtkqDUVwtYkqNEKuMs+nhA4MAsPvWIiVzYBP
 ArPTwHWHVU5ymDUcMglGrbwqpLWi9H7VK7tbJCQPKRKltqgxHkeruQhpHOZ9qvn6WG5G
 2w/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbnw7igTtjSvFXoQeYaw3fvVzQHE/Ck6fKAcDvfporRI2eW9LlDaNVSKueUpx4mvqJ+Qlps8F6Qq8K@nongnu.org
X-Gm-Message-State: AOJu0Yw0xhsFttvl4LihDsU5PdZbJ8JI28ThLmUupishHmsmyGYUpQf+
 R44OKNtLb/2J/WUN+Op49CUlJmpJ4sznLDzbAKfxdMg3PSHuBkP/mzOd6uTJfGZIBu6O7a4r5Vv
 k
X-Gm-Gg: ASbGncut9i2gSyiLZHibjWGW5LMopU5n2FjV2WRj+Y0HPPY9fQDAm5X5F4NANM6uB9E
 495t8EYGlHPyyhj6m+1Ot1/Ud9cVv28Bu6to0UlhDI/tJCk+KtTrHERYVwWs489WUg/U5lIPAoG
 6Xq/DcSQs020IhM0jo2HPKCOICiqUTlDQoCTpkymzL64D1FdZis0qc4D3lOX13BtcbOZHm4f741
 gjLy4qzTjbLLbKHQIGd15qt2n0MboUfdpG4ohm7QfLMJYnhHCpLgZo0QpeA
X-Google-Smtp-Source: AGHT+IHpq0I473Nb4T7KVbJZ2ScG1jEHVeQwT2VUr4DbNX/a3tglfQaC8upbkyr4wbFCkTWWpMR9Rg==
X-Received: by 2002:a05:600c:468c:b0:434:9936:c823 with SMTP id
 5b1f17b1804b1-4361c387b63mr25218865e9.18.1733928286461; 
 Wed, 11 Dec 2024 06:44:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4361e54ef20sm19477685e9.5.2024.12.11.06.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 06:44:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 4/6] target/arm: Add decodetree entry for DSB nXS variant
Date: Wed, 11 Dec 2024 14:44:38 +0000
Message-Id: <20241211144440.2700268-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241211144440.2700268-1-peter.maydell@linaro.org>
References: <20241211144440.2700268-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

The DSB nXS variant is always both a reads and writes request type.
Ignore the domain field like we do in plain DSB and perform a full
system barrier operation.

The DSB nXS variant is part of FEAT_XS made mandatory from Armv8.7.

Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
[PMM: added missing "UNDEF unless feature present" check]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/a64.decode      | 3 +++
 target/arm/tcg/translate-a64.c | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/target/arm/tcg/a64.decode b/target/arm/tcg/a64.decode
index 331a8e180c0..c4f516abc18 100644
--- a/target/arm/tcg/a64.decode
+++ b/target/arm/tcg/a64.decode
@@ -245,6 +245,9 @@ WFIT            1101 0101 0000 0011 0001 0000 001 rd:5
 
 CLREX           1101 0101 0000 0011 0011 ---- 010 11111
 DSB_DMB         1101 0101 0000 0011 0011 domain:2 types:2 10- 11111
+# For the DSB nXS variant, types always equals MBReqTypes_All and we ignore the
+# domain bits.
+DSB_nXS         1101 0101 0000 0011 0011 -- 10 001 11111
 ISB             1101 0101 0000 0011 0011 ---- 110 11111
 SB              1101 0101 0000 0011 0011 0000 111 11111
 
diff --git a/target/arm/tcg/translate-a64.c b/target/arm/tcg/translate-a64.c
index b2851ea5032..953386c0416 100644
--- a/target/arm/tcg/translate-a64.c
+++ b/target/arm/tcg/translate-a64.c
@@ -1959,6 +1959,15 @@ static bool trans_DSB_DMB(DisasContext *s, arg_DSB_DMB *a)
     return true;
 }
 
+static bool trans_DSB_nXS(DisasContext *s, arg_DSB_nXS *a)
+{
+    if (!dc_isar_feature(aa64_xs, s)) {
+        return false;
+    }
+    tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
+    return true;
+}
+
 static bool trans_ISB(DisasContext *s, arg_ISB *a)
 {
     /*
-- 
2.34.1


