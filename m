Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0494BFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 00:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIF9v-0006ms-Is; Wed, 29 Apr 2026 20:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIF9n-0006Xc-7f
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:31 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wIF9k-0006Jp-F3
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 20:21:30 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-82f9fdfc965so174006b3a.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 17:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777508487; x=1778113287; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PSIqyu6kWdNMcAAky/pBc9Ndq11vsOCHdvA3yGktP2I=;
 b=VGdJqjC/fRTTSWqKswA0FXFHVps1S5M/SHdK6SDk1iGWCFnl681tzQM+m4f/jWkRXD
 vyLTrEc1DL5Pbo7b69pCh9DefdNnH/I8ZCh8fqQefkjBKtcjJhfPNm9uxgIjJKSjL2T5
 ddnSmVrXQM7UkxMEQbyg+ult6eCVTdVIWGm5QUmpNOv8yFYwwHp6FpOEhZOvPd3dA8K5
 6HyblTRZ6PSdPbFA5jjEk8OBWBCiMUzuvs/Ew05BroaXIpjC4/fN33pzkahp/wicFSiP
 BJjc2DhMl+cDFPsGL7CgXBnkOTeXaZMXyBf6ZqRiXtDJgfVGckW33cnSHyvHN3N2uCbU
 ImPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777508487; x=1778113287;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PSIqyu6kWdNMcAAky/pBc9Ndq11vsOCHdvA3yGktP2I=;
 b=NFlIQlQ4dQX8RI8EeWCGbGJT5OAhdtfutQ0yEknXBma8vXZcLUYF2FR4AXWcq7bjwg
 tZvgW7fxupBBY59xm1ZI3BJkmuWru2HePYz4wnOStk7mrIlps++ZjEvHiXAEnz+d0i1x
 kyI4+dCLeZJFrI3wY4twJBmesVwxmJRL5/sLlk2W4DQTNQbZHKymGKIsDAvO9D1JuE43
 wYXLB+OQnUOEcAlBezPjejOgMAppadDryzoPLFSw4SH/aqannqyGGQhhAWXiqwgzUFS4
 +mcgzq3Oh82u5kDc/EqG4xQOzeCis143ykyLlLfk54ay4hANaAlzRGVZivm6EFY+n0iK
 pHoA==
X-Gm-Message-State: AOJu0Yz/AX5Rpo0NHRUrR9rmXNkLoItniYvErASfQS8+nWSTBrg4bHCm
 BkX8TBaq/in8aWfB5oiLlApiHm0lcaGE7GhCFbYXsZhRtQ1pZwAD2in3luIIyqxUbcRhIRA9KFR
 BZo4tPt0=
X-Gm-Gg: AeBDieuyZ3wsNwPcTOg7ksPkD0OSOc0zKeW685L0k/gm57pqNDl/IslcgSWPAmSt0Of
 xUZA/8BrW/MqzFEwMDgt9P3ck7jmYQdPmNPN5PfGQIsqfKEc7dXrb4WsYZY7nWm3u7uoiXfxSFE
 q71SbO/kjueaz8GfIrII7yvum6hQ9FAwRx7p6/QrsjOdULSOzDUMDGIOLNPtBZMWohEgWJRSVJe
 dC7Q1Fj+cMFpRU1WGSQAD0ECBBYnspl6RSEl/0oT7vAy6fl3/2uDD3rEPNj2sbFM+vNaiErYNFQ
 zeRJ0XXhIOgtVDIPV21esgNZezv/v0rd0lVoT5Dw/TI5ZQ4mct7v25XNTPrHwHU6QT+vxF/E4Wk
 oSx0NlRrZoDj7TsllJsfB1DfxFjo4fGVOVH3UP3huhxGYhSn7C4eni9RY5vxucQa4y7lZGSO0HS
 JSQluLdUF4KMUcH6cLStxpQC7h2CSr7bj3ZtaYO/SG
X-Received: by 2002:a05:6a00:1885:b0:82f:2384:212a with SMTP id
 d2e1a72fcca58-834fe1bec01mr733931b3a.26.1777508487119; 
 Wed, 29 Apr 2026 17:21:27 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-834ed5cd3b8sm3461727b3a.16.2026.04.29.17.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 17:21:26 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v3 16/47] target/arm: Add isar_feature_aa64_f8cvt
Date: Thu, 30 Apr 2026 10:20:15 +1000
Message-ID: <20260430002046.59739-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430002046.59739-1-richard.henderson@linaro.org>
References: <20260430002046.59739-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu-features.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/arm/cpu-features.h b/target/arm/cpu-features.h
index 60a16ef398..590a7f6cf7 100644
--- a/target/arm/cpu-features.h
+++ b/target/arm/cpu-features.h
@@ -1555,6 +1555,11 @@ static inline bool isar_feature_aa64_sme2p1(const ARMISARegisters *id)
     return FIELD_EX64_IDREG(id, ID_AA64SMFR0, SMEVER) >= 2;
 }
 
+static inline bool isar_feature_aa64_f8cvt(const ARMISARegisters *id)
+{
+    return FIELD_EX64_IDREG(id, ID_AA64FPFR0, F8CVT);
+}
+
 /*
  * Combinations of feature tests, for ease of use with TRANS_FEAT.
  */
-- 
2.43.0


