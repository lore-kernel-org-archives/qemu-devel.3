Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7820C282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 06:43:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq4va-00026N-Up; Thu, 06 Mar 2025 01:41:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tq4vF-0001zG-RI
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:41:35 -0500
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tq4vD-0006Fg-BW
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:41:33 -0500
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-223959039f4so4517975ad.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 22:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741243290; x=1741848090; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u8ypN9EJmJMZh7TFGUmek2PnxWXl5cKb09yiek0NZ2U=;
 b=dBEFF7lurAx+It2cAt4WxRomZ9F/Mi4V3f8PoiZ+nTMcx2dubmM1EshHfudoxfdTAM
 nVfqxOMtRRGxQ4htTiOmaaLhYqk9sSB6FrfjLGFuKn5rT16HIPAAtyHwWvdI/SHIw/zJ
 yUghuvw+DxwZpTwUe653IFZpkFnY5s5g2WYNTLkApxlSZbIYY+RoUvWp56cRoXm78joE
 71iOlZ8RX83+cg0k1vOxdIgNuNVD07eXYLYb8y3Nn/a4KoZwmxWui5G9LY48qE/nlYLZ
 v1M5oWHkUtNNxkDZ8/ZyI09jrEMwV5AmmssiVxm3Fw+9K4EnJWA/9J9ew2Ghc8JYQb4L
 a/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741243290; x=1741848090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u8ypN9EJmJMZh7TFGUmek2PnxWXl5cKb09yiek0NZ2U=;
 b=OsBK7UoHeCtwAdZLeN8PfeqWRw8ql6HL01RoOKkpcygedDp3AMvw06uEFLsCZeNUub
 bcgFhzVIDgsbBEOR41r0zCcqF1XeIeeNJoZ4degm7OX8i8PrX3JX7KK4Hoiz5TkNxD+j
 b9RHFJEGes2GYgMxWHn8FfR97rF42zlAHzhNg5WGVuXOG2XBS5QRGdkvJyjt4kM5QXBZ
 FZm0rj5erYyp4jNRlPipTy9uaijqVbMIDSCqo+Yb4VZorqic/2z4n1GJCexH9qJ1QCOr
 PHXlBdPQek3unwAWD7JbhRAvKF7I9Flx74/EhpdAPHldS3KPaEapeBWg7iOgZDSVSk5s
 J8tw==
X-Gm-Message-State: AOJu0YxLJWqszJs0AvmPnKmiOyfr2F0a6qpZ8bARll8z6lpzV0uE5wC1
 mHZKJeHPhQYa4XlQ/ku+93GdBVDuBDqFz7rO+uPMSNrkMaXZi/fot20HqfFsv4dEZsGSbuQYvf9
 1
X-Gm-Gg: ASbGnctv/5f8Vi7pYHEc1IUo7crJ3qZPMx8StbmdnjZTKDLBHV+9vDahmwNTCF06A6L
 qAiSyLHDtLdcLqYytG59osCFmJZUQvl/fuaV63kRCmSwV/mcox+FZGLWfwJl6dlr6CkoE11tjLB
 QHH9odAwTyEEkHPcBwWkyB7S/RRmRgymV+7UpMbox9UnlWfVLo8P3lPV+MHwswesz6fZOwwPA/M
 W+WAGmyQZ/r7ObfdTmPC5fYPxryLsklhHg/5QwE6vwxfVqnFqwwWxGMr4+cgjhfsENnc3nox+U/
 rPkb8Pua/tMxqcw2Hsndk6+b80YgXy2ZcpklfNjjQAVf
X-Google-Smtp-Source: AGHT+IGn4dWWM597zT6vcugXa0NyDMgvYpsWMNNAPMD1rOUygPXJy4ZLiCcv5xBAeUFD0Zu/7LztKQ==
X-Received: by 2002:a17:902:e752:b0:223:3bf6:7e64 with SMTP id
 d9443c01a7336-223f1c96f97mr108234575ad.24.1741243289884; 
 Wed, 05 Mar 2025 22:41:29 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a91cffsm4769355ad.174.2025.03.05.22.41.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 22:41:29 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, pierrick.bouvier@linaro.org,
 manos.pitsidianakis@linaro.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 richard.henderson@linaro.org, Marcelo Tosatti <mtosatti@redhat.com>,
 alex.bennee@linaro.org
Subject: [PATCH 4/7] hw/hyperv/hyperv-proto: move SYNDBG definition from
 target/i386
Date: Wed,  5 Mar 2025 22:41:15 -0800
Message-Id: <20250306064118.3879213-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250306064118.3879213-1-pierrick.bouvier@linaro.org>
References: <20250306064118.3879213-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62d.google.com
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

Allows them to be available for common compilation units.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/hyperv/hyperv-proto.h | 12 ++++++++++++
 target/i386/kvm/hyperv-proto.h   | 12 ------------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/include/hw/hyperv/hyperv-proto.h b/include/hw/hyperv/hyperv-proto.h
index 4a2297307b0..fffc5ce342f 100644
--- a/include/hw/hyperv/hyperv-proto.h
+++ b/include/hw/hyperv/hyperv-proto.h
@@ -61,6 +61,18 @@
 #define HV_MESSAGE_X64_APIC_EOI               0x80010004
 #define HV_MESSAGE_X64_LEGACY_FP_ERROR        0x80010005
 
+/*
+ * Hyper-V Synthetic debug options MSR
+ */
+#define HV_X64_MSR_SYNDBG_CONTROL               0x400000F1
+#define HV_X64_MSR_SYNDBG_STATUS                0x400000F2
+#define HV_X64_MSR_SYNDBG_SEND_BUFFER           0x400000F3
+#define HV_X64_MSR_SYNDBG_RECV_BUFFER           0x400000F4
+#define HV_X64_MSR_SYNDBG_PENDING_BUFFER        0x400000F5
+#define HV_X64_MSR_SYNDBG_OPTIONS               0x400000FF
+
+#define HV_X64_SYNDBG_OPTION_USE_HCALLS         BIT(2)
+
 /*
  * Message flags
  */
diff --git a/target/i386/kvm/hyperv-proto.h b/target/i386/kvm/hyperv-proto.h
index 464fbf09e35..a9f056f2f3e 100644
--- a/target/i386/kvm/hyperv-proto.h
+++ b/target/i386/kvm/hyperv-proto.h
@@ -151,18 +151,6 @@
 #define HV_X64_MSR_STIMER3_CONFIG               0x400000B6
 #define HV_X64_MSR_STIMER3_COUNT                0x400000B7
 
-/*
- * Hyper-V Synthetic debug options MSR
- */
-#define HV_X64_MSR_SYNDBG_CONTROL               0x400000F1
-#define HV_X64_MSR_SYNDBG_STATUS                0x400000F2
-#define HV_X64_MSR_SYNDBG_SEND_BUFFER           0x400000F3
-#define HV_X64_MSR_SYNDBG_RECV_BUFFER           0x400000F4
-#define HV_X64_MSR_SYNDBG_PENDING_BUFFER        0x400000F5
-#define HV_X64_MSR_SYNDBG_OPTIONS               0x400000FF
-
-#define HV_X64_SYNDBG_OPTION_USE_HCALLS         BIT(2)
-
 /*
  * Guest crash notification MSRs
  */
-- 
2.39.5


