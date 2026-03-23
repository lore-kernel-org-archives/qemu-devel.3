Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B1E0EC01C9
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 10:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4cvf-0001r7-L7; Mon, 23 Mar 2026 06:54:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4cve-0001qP-HT
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:54:38 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w4cvd-00064g-0D
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 06:54:38 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-487035181a7so12788285e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Mar 2026 03:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774263275; x=1774868075; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I7U+t0mh0uXcTLegLAg7uSCw/0hDr15+Khdgccskhac=;
 b=cMy+FFsmzg5cd0S7fXrjg4BIh7OJ3D7KK1an+FLe4LN/MH5Mfg6TnLncHFMfnAK6U2
 ALWblenQyucZVhQDc6qr5JY9I7K6an3PNr9KvsNBDjo0tdX8ye1j4Gi6w+ZP4W2akT42
 J9PCwLvzNXICbWaf/bOEiyoC0jXJCurlUwkqaBWybOMDZ+R8U+7Ke34YgC6oJJntgMS7
 SN30EiY0SmHndX6MYSHsDq/+KKioIQ1gs5yWBf+feQx8mAM16EfQ3TF44sMmt604u9PW
 z+6i/OPAsDCjygBYn1nTF4l8+jvyZ3oUmoZvYMAC2u3j1O5bF+y5sJbO3vh0812iFQk2
 8yGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774263275; x=1774868075;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=I7U+t0mh0uXcTLegLAg7uSCw/0hDr15+Khdgccskhac=;
 b=VJrHZFpfPCpTpDNDaT8mhofHsUio38J39jHILk7QVZ2jA02JkC1p6rvmlzaH3k8Sr4
 eZQr9hPjp8Xwg5cTkBCTF8JQ1WfJHe45v2izncaItCm615QCuWkosLe5Q9hV23E1tAPY
 WduHO2pr20eypcA4tQL+eQdINRtMD/A6xkuoG4stLULWGury0Il0fg/8LZC3qAA4Mjnl
 L0F/jgSyxr/x9QujVfg1LEjCGBOlyIq5N7m2rSXA0SszqJyehX4eeuZiU4FzeonRBOk5
 bAZ1cqd7iD0h7SXDmIKSBJ7u+tTh9JWRRSzFgeuAnW2eEW7m7U9PA48SBMar8BRP/Abp
 bIEA==
X-Gm-Message-State: AOJu0YxPXgLRHo+RNrXTqyPZL4bpwPscNbcEaY2gaQDle9AwlvyZL6JU
 Dn4IxCW/GFC4pfiViA8eXqPjH/YMfZv6x2f1pXk5670jLjQlynVbh0NSvmQ8z4gjCF/aMdCoyFz
 kvwaOE+0=
X-Gm-Gg: ATEYQzz1xteKTwzz9iULWBKH24ReafjplVcm/ODfCp2swC2s2tOKw20PTUAYovFz5yZ
 8b83SMr1ICnBRVgQVre8mCCth/kJPl+vwjneCse5rLEnOwHOS0iHHSwYJ1fWxc4q8M9WAWQmG1+
 u9FSqdEhlyLLUNOA4e+5RnzhbHRbV3oDRZ7R0qgtlQ6IwY7RJBnJpCA7UxbMNPz7A5xeHpBgvax
 ztf1+r+tVzsxhs8M2a8x3oOSbwPpVJKluk2ztyJI8Jnqv6FaUF2h2SFfCQfG+YERdMlVkqSj9QB
 /o13XvNMUjfcK9q//txGHHiZYDKQjG3nqvd4v0y/GDqgIa2H6CzIKGQzUvOoUoOYgRHXeztiDGy
 YtETj1t6lz2cpsV+NElsrweii3S+A8XgV9Y9UCaBTvH22JLZdYn8qCD2c8qotafuw+Gna9Kan8o
 mWwcjPNfYqOfsBDS21Lm++d5pqy2F4jagMijOIRqp4IAH1DcdmGzEwUo4tBYQPV7G6z6YI73lE3
 NlKq1c0zgu45iQyW+91QYhtcf/MN4o=
X-Received: by 2002:a05:600c:c84:b0:480:1c69:9d36 with SMTP id
 5b1f17b1804b1-486fee0d808mr167738005e9.17.1774263275278; 
 Mon, 23 Mar 2026 03:54:35 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486ff1dd9f1sm115483185e9.8.2026.03.23.03.54.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 03:54:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/10] whpx: arm: enable more enlightenments
Date: Mon, 23 Mar 2026 10:54:24 +0000
Message-ID: <20260323105429.4059580-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260323105429.4059580-1-peter.maydell@linaro.org>
References: <20260323105429.4059580-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Unconditionally enable some more enlightenments for whpx.  In
particular, linux uses AccessVpRegs without checking availability and
panics if it's not there, so it's important to expose it.

We also had a duplicate line where we set AccessHypercallRegs = 1
twice; remove the duplicate.

Microsoft’s VMM exposes SyncContext on arm64 and FastHypercallOutput
regardless of architecture unconditionally, so add those two to match
that configuration.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Message-id: 20260314221529.47841-4-mohamed@unpredictable.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/whpx/whpx-all.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/target/arm/whpx/whpx-all.c b/target/arm/whpx/whpx-all.c
index 3df60a950d..9e5bc03a21 100644
--- a/target/arm/whpx/whpx-all.c
+++ b/target/arm/whpx/whpx-all.c
@@ -832,6 +832,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     UINT32 whpx_cap_size;
     WHV_PARTITION_PROPERTY prop;
     WHV_CAPABILITY_FEATURES features;
+    WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS synthetic_features;
     MachineClass *mc = MACHINE_GET_CLASS(ms);
     int pa_range = 0;
 
@@ -942,7 +943,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     }
 
     /* Enable synthetic processor features */
-    WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS synthetic_features;
     memset(&synthetic_features, 0, sizeof(WHV_SYNTHETIC_PROCESSOR_FEATURES_BANKS));
     synthetic_features.BanksCount = 1;
 
@@ -953,13 +953,15 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     synthetic_features.Bank0.AccessPartitionReferenceTsc = 1;
     synthetic_features.Bank0.AccessHypercallRegs = 1;
     synthetic_features.Bank0.AccessVpIndex = 1;
-    synthetic_features.Bank0.AccessHypercallRegs = 1;
     synthetic_features.Bank0.TbFlushHypercalls = 1;
     synthetic_features.Bank0.AccessSynicRegs = 1;
     synthetic_features.Bank0.AccessSyntheticTimerRegs = 1;
     synthetic_features.Bank0.AccessIntrCtrlRegs = 1;
     synthetic_features.Bank0.SyntheticClusterIpi = 1;
     synthetic_features.Bank0.DirectSyntheticTimers = 1;
+    synthetic_features.Bank0.FastHypercallOutput = 1;
+    synthetic_features.Bank0.AccessVpRegs = 1;
+    synthetic_features.Bank0.SyncContext = 1;
 
     /*
      * On ARM64, have enlightenments off by default
-- 
2.43.0


