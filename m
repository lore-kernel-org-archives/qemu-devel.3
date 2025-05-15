Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383C5C3ABC9
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 10:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFVpP-0001Np-Ca; Thu, 15 May 2025 06:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVnk-0005Ym-Ci
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:27:00 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uFVne-0008Gq-JA
 for qemu-devel@nongnu.org; Thu, 15 May 2025 06:26:56 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso5035925e9.3
 for <qemu-devel@nongnu.org>; Thu, 15 May 2025 03:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747304806; x=1747909606; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wVaw38IJB5ualjLwd7Gyd/Z0jgsIF8bEQZE81xv9lGk=;
 b=wIedFG8FnRpySf74J+7lZkgwsH3sg407tKaUpBKQZiOysBsgzlpOZMTZnJZu0lMVRY
 y1oeut6FJNfskC+slw/mZ8V+0N3U/sQoCVlLCvptGAn7RBEqIpSn6OBSBikx4d6ivEXB
 +LQvuUiGlwpd7iQn8A5ogE74We75o5ngp6iHZ2Oy4u2y1q7C6+fABKh3XZbAfc4RWepV
 N9RJQM1ALIBIqPOhAP+HfqK5DCUewEucM6YiKoT2bgtopiIMhsJdT0loL2g0EeZLvqDm
 vwHSqYVpMq2siMUiFXbygfSnkIkHPXNpM8GHTN/AJ6VF4aVRGIVJp1tb+xExQeMAfTv1
 bwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747304806; x=1747909606;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wVaw38IJB5ualjLwd7Gyd/Z0jgsIF8bEQZE81xv9lGk=;
 b=bB1gzBqdQR2xrIlBpe37xkXEtnnn3ZV+yWb7z4MEGIdYEiUBHD2p1705i+ijuLnQ1f
 gfIwEGrMiaFbytcl/qn9D9DBO7Iqy1FlvoDhiGZF76KgUoWZ33P8/ZO9GBfr7Q4t/Ku7
 iqdDMjdcHzQJn/GtB3a8AZC2fBD1houlb9HY4xLz6F5F//iDdNG/K2MeumQHGOjEgPHo
 Je77LZ+nWI/if/zO51rZF0Xb4iFnsyrGf0qvEp8yT9iD2fIDyF5Zj5wQkRO+xBN/mtnJ
 +lcXzSQ+uTop8ug7GDMSIIiQ7zV/qLozXSjKt7q0PSDPwd6V0+klwjdgKFycaXkb6a1w
 pCLQ==
X-Gm-Message-State: AOJu0YxDSJFbzAaf7VnLq7CMVf5J7/9iYAo/ZPI2yEgYCEpFqe4ZrOmd
 keC0wPDGWQzX3sm2VZBeVZPA+/MT7fEZ7YtVO50EteMZGq2IHSLlkkpsiD2ljG0KYFaARtDqxnm
 J5rE=
X-Gm-Gg: ASbGncslff9yRHyjKkwky1tClIr/UtwHLJ5cFODkqZmV/FKufIsT75y1ZoJrF+eR0h2
 0LHzv6UMq0hZqAP8nykwdxlU1bR80xRuwkAh7cXli7n1eRMjF2i+ADXzRXJa/bf/khGaY3YY2km
 BqrpoZHYcBEnF9fo4xcrb7Hytdm8y/7vUIpWW7Ymv5j3MEdWJhuIOzYNL7rB+S267O49vFxIL5y
 vWCFyjRR6VFbfP+tAmk2uwG+OJp/OoQfMUVqZNi8eP887PHkv2swUryOUmrL212Phbx6x4Hamd/
 lKPks7N/SG+BDejP3hifLTxOWxvescAY5u1ti4Kzz6dYenfIAyOZHuHa1A==
X-Google-Smtp-Source: AGHT+IF+cCMpy12TCa/I+9WlChg2mA9SwNPAAsnbILCA21D+OVYIAgibPv9Sjn57dPgYLPCTt0gkeg==
X-Received: by 2002:a05:600c:5286:b0:43d:5ec:b2f4 with SMTP id
 5b1f17b1804b1-442f20e9008mr82841465e9.10.1747304806229; 
 Thu, 15 May 2025 03:26:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442f396c3a4sm65657855e9.26.2025.05.15.03.26.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 May 2025 03:26:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 47/58] target/arm/kvm-stub: add missing stubs
Date: Thu, 15 May 2025 11:25:35 +0100
Message-ID: <20250515102546.2149601-48-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250515102546.2149601-1-peter.maydell@linaro.org>
References: <20250515102546.2149601-1-peter.maydell@linaro.org>
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Those become needed once kvm_enabled can't be known at compile time.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250512180502.2395029-38-pierrick.bouvier@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/kvm-stub.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
index 4806365cdc5..34e57fab011 100644
--- a/target/arm/kvm-stub.c
+++ b/target/arm/kvm-stub.c
@@ -109,3 +109,13 @@ void arm_cpu_kvm_set_irq(void *arm_cpu, int irq, int level)
 {
     g_assert_not_reached();
 }
+
+void kvm_arm_cpu_pre_save(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
+
+bool kvm_arm_cpu_post_load(ARMCPU *cpu)
+{
+    g_assert_not_reached();
+}
-- 
2.43.0


