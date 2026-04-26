Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53A0FF885D
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Apr 2026 13:55:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGznv-0005qk-HQ; Sun, 26 Apr 2026 09:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGznc-0005dd-DE
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:45:38 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wGznZ-0001Lx-60
 for qemu-devel@nongnu.org; Sun, 26 Apr 2026 09:45:27 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2ab46931cf1so70770295ad.0
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2026 06:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777211123; x=1777815923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ghHQqqdOPpQtj4mRafd8WgiwBSS9PBadyD33IANm2ps=;
 b=JT6jexr7hD5wgc/xRMesK1A1eZSIW7cvElDSj0Z6AdLmZVia99+ttF4bSeEb88hORV
 kX+CT7aACdbeSLfA2weZxJcR3Qip6UiX0pJJCu9QRoMBbGgFN2/EtQhJaToMlDvRFbps
 vT1Iv0TKApzZwOs6U6j1Pv+V6cleetDSZNy8j/uxrdAJqRd96pa1h2LvDs1CE/KYTLOx
 KAfpihx3WGwn9cqKaDD0ElA/UqGNThKldngID/ALpRboEyTE+P7P44k9ZxkgT+Yrh7mW
 olk7ukqORepGn25wTjJ5MGFb8YdsdgaT906LCjJ8obiVX/ofC3FO3sW+KO5kvLWClvtR
 VzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777211123; x=1777815923;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ghHQqqdOPpQtj4mRafd8WgiwBSS9PBadyD33IANm2ps=;
 b=DiBfjldmM9geZGUroxU8ckKvWhuCmgtsjFrTx1m1snU1WXcRlNHXI0nl7g35wxDqsj
 gCcEPBSjtSAQQhMrOpQUwwr6zAVydJZlLL4sghkW7ViQMJNuP6fvuuupToVE4dVqdAJd
 BFaf1FaQL31l+SEG2zTK4Zv/GvZ3N893ZMZOb8ZGRtbf7djNCsZ3qTuUwo+kC4Xu05de
 qqPlVf3vf/r9GT74ffuLM6A32Kpe2pfAj3xKwT2cWUGBGeRLlnbfu8cLaPJ3vxFMmlGY
 Emxq34h7LT9SI8L+MN8B/Xunk02/uiDKH/5oYSV4Ax52hnrm59l8p/UZ2ABzfzWj9n1+
 Su8g==
X-Gm-Message-State: AOJu0Yz2Azwe9QHzKfU4NRNmQAf45tuyitnx6EITtRX9STzDWb7SLDOY
 MyM2u/sAs28mJ7QH/EMlJnsSLfrVjBYlDntv86n+0S6IdhLGxTOz7DG571RHmzXzLA+ggPJdp1R
 9UHCKDPo=
X-Gm-Gg: AeBDievSc81UTHTRx2DQQw9Jm3O9hIfcXcIkOdPfCt1tPjIzN9FJx3wacVz9Sd5ZdtC
 vRZzxEotb/ZH0uO+XbtTaC1fZQMTetB3AcRjJZdZMwA8fzhfcIhXltU2hV3PgKDa54Vr6I2hpw3
 yKyp47y3+ooeF04DrAoDnz6AGatXOU03+cPn0pk+M4OSu19xqfxdiDntrrR6p2IXvsEKf0mtXFf
 Ss8NZGM1Qfj6kuiOZm5lWb14Tx6rAYPcN4EXNYeAURMfuIO9d+gfj43S1H5eHW1BqnZUj8wB06Q
 OVGxECJZJkQmSmm0DB+3u0bV6NSXbx7DR9wK9bKPLQ064CpFQXwgIZG+Cw/4ZJ/gk9CoYQpgMtU
 8raGqYB2xUB/oGSFcGYYLfihsvaQtD0MbeWCxkjBRqCg2ZG/SZSVL8EJPluAI7l3N6q+N53Rt8m
 +LPbjpIXTZQLVT2u5Z55IVJ9piXbj6+PaxyCdqV83wgdi6+SjSQ+g=
X-Received: by 2002:a17:903:b4f:b0:2b0:be79:e521 with SMTP id
 d9443c01a7336-2b5f9edef17mr338946705ad.26.1777211123431; 
 Sun, 26 Apr 2026 06:45:23 -0700 (PDT)
Received: from stoup.. ([180.233.125.15]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5faa34ea7sm280544085ad.34.2026.04.26.06.45.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 06:45:22 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	qemu-s390x@nongnu.org
Subject: [PATCH 49/84] fpu: Inline float8_e4m3_pack_raw to single caller
Date: Sun, 26 Apr 2026 23:39:26 +1000
Message-ID: <20260426134002.865628-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260426134002.865628-1-richard.henderson@linaro.org>
References: <20260426134002.865628-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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
 fpu/softfloat.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/fpu/softfloat.c b/fpu/softfloat.c
index 5d58caf5ea..18f2ca900f 100644
--- a/fpu/softfloat.c
+++ b/fpu/softfloat.c
@@ -673,11 +673,6 @@ static uint64_t pack_raw64(const FloatParts64 *p, const FloatFmt *fmt)
     return ret;
 }
 
-static float8_e4m3 QEMU_FLATTEN float8_e4m3_pack_raw(const FloatParts64 *p)
-{
-    return pack_raw64(p, &float8_e4m3_params);
-}
-
 static float8_e5m2 QEMU_FLATTEN float8_e5m2_pack_raw(const FloatParts64 *p)
 {
     return pack_raw64(p, &float8_e5m2_params);
@@ -1474,7 +1469,7 @@ static float8_e4m3 float8_e4m3_round_pack_canonical(FloatParts64 *p,
                                                     bool saturate)
 {
     parts64_uncanon(p, s, &float8_e4m3_params, saturate);
-    return float8_e4m3_pack_raw(p);
+    return pack_raw64(p, &float8_e4m3_params);
 }
 
 static float8_e5m2 float8_e5m2_round_pack_canonical(FloatParts64 *p,
-- 
2.43.0


