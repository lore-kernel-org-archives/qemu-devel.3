Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A59B0F9EDC9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 13:04:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFXE7-0001LV-5X; Wed, 22 Apr 2026 09:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFXDz-0001Aa-Tx
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:02:40 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wFXDx-00019q-OQ
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 09:02:39 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso56316895e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 06:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776862956; x=1777467756; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UF2x3LQsFVeOwuh4smvXIT3vMnoh5OJHhwB45pzXnIE=;
 b=pU4dmjM98QUrZKuABjsV/7+yCrTiB0Jwxg5Do6ZsjpMgtEk37nhxZoyORvMj3vh+bE
 KC2spQWVMhxYP93YxRVfCpOKHvgkKrFzYr7EGc3vLaDpfpK/XkhncNtstWd6A1On2TDr
 t8FbVDPFb7YgII7kuaAk10VoY1YT9siAG41dSscjV3nkd1xgPo2zDQ4LjjQaOyWDfxE0
 I4WRx3/BC9Mr4tZBRoG99ZPybunm6E1xo2FGFC6Y8xs4DGFB8qEnivzdTSNbr5FdVG7I
 +zoDumHCgbkbhVwVl+7hPuCR6hegegXIycslUH52Mz+xdtzPnH8dBr/cQkOMzh2uhtr3
 xHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776862956; x=1777467756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UF2x3LQsFVeOwuh4smvXIT3vMnoh5OJHhwB45pzXnIE=;
 b=GDFyqDMT4yaigW6vtaL1P1o6RZ5tpdUKPc7dd+VxryfhtCl8tm92GLtYwuoqAlc2d7
 ZPGfjWRu2x6F5by+cj8PLII6HiKrS4u+e9W9gXC7ed1N6vybqZKg1VbaHTXzrKguzTtT
 MrRW1Oqa9BKRsQqqKnNDGsIqXJnMXH4rQ4aIoTU1Y9jtsLKXkj2UE2C9+6OgcQ/QDz0r
 PUjLZE8FJkL034wIpF87u2ut8dwD80RCN8fQOMZ1WAq0RWYvNB85csIdfnuHrj4oZTSo
 AlVpVIa9EwsFo/suwIzsWrknouWdRj1anr1y/K8BobTNZnnJEi5g5bW15JiZAXGUXxUg
 4Dmw==
X-Gm-Message-State: AOJu0YzOLjRNpG4fliPPhq+Oq33xRx3umt3/dQHLrHP2TNTmJg9ri30P
 kaBm/z5tFm1I0NvRZMfWQ25epHmkKRHgc52UkGHc/PHkpb5/VX7feE1Gafrg42UliYU=
X-Gm-Gg: AeBDieswN34m4FxsCcXSFrgu0jNzij/RIq3v0YDzGDBzCZhL/JDcr30ujOAhMUvUilx
 AjnDbh8uDPawbw6R0e05Orfzlq+6FaBDfrbna3fN7h83+VJEOkmdhJ3ZsDGu/Bp4s2tL2y30Reb
 RdNaSBtu4Impxc5KMkmo1B40lq2aS7IB/BN4Ql3NzNvnp55suWAsBqlghUcPpJUu+Ws3bBMUmZP
 mt7YEB/Ped03SfTQMiLwUrWYNW+Mxd3j2WZFayQS9VVlIWp/TwSKm01mo9Mn35Vrjy6aXGqG7RS
 KirMrQM40cFMzXB7KLTWVpdHrho1ZvcDZoBg+vi4AfFseBcd2Tuv+qwTClISXEsxUQQ4KtV2arU
 hQf8/YShGBZRbNiTC5fhpwmJWDfwJV9tlUQkD4UmDMqFle2ONnJkS9uTgeSaZ8yfEj4WKTGwAr2
 ZLbbok0pmAI+9GWpJ0l+rwJFEes4Tu76XDaw==
X-Received: by 2002:a05:600c:41d6:b0:487:2439:b7c8 with SMTP id
 5b1f17b1804b1-488fb745294mr205580125e9.1.1776862956044; 
 Wed, 22 Apr 2026 06:02:36 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc177dafsm550412285e9.4.2026.04.22.06.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 06:02:30 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B2A04614A7;
 Wed, 22 Apr 2026 13:52:52 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v3 22/32] target/arm: remove old syndrome defines
Date: Wed, 22 Apr 2026 13:52:39 +0100
Message-ID: <20260422125250.1303100-23-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422125250.1303100-1-alex.bennee@linaro.org>
References: <20260422125250.1303100-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x334.google.com
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

Now everything is defined with registerfields we can drop the old
defines.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - remove stuff dropped earlier
---
 target/arm/syndrome.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/target/arm/syndrome.h b/target/arm/syndrome.h
index d4dfab8cd15..04a71eebcb5 100644
--- a/target/arm/syndrome.h
+++ b/target/arm/syndrome.h
@@ -106,15 +106,6 @@ typedef enum {
     GCS_IT_GCSPOPX = 9,
 } GCSInstructionType;
 
-#define ARM_EL_EC_LENGTH 6
-#define ARM_EL_IL_SHIFT 25
-#define ARM_EL_ISV_SHIFT 24
-#define ARM_EL_IL (1 << ARM_EL_IL_SHIFT)
-#define ARM_EL_ISV (1 << ARM_EL_ISV_SHIFT)
-
-/* In the Data Abort syndrome */
-#define ARM_EL_VNCR (1 << 13)
-
 static inline uint32_t syn_get_ec(uint32_t syn)
 {
     return FIELD_EX32(syn, SYNDROME, EC);
-- 
2.47.3


