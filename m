Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2C5C83F0B
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhOJ-0000v1-NV; Fri, 04 Jul 2025 10:27:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhLu-00047N-VD
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:27 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhLp-0007zL-BY
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:21 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-73adf1a0c48so633255a34.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639116; x=1752243916; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EPqD2WiuW/V5KwVpgPbT8/RYmpheRb4cRCRm2q9oZgY=;
 b=U0Jfm6fHXOqrmOwr1xzlhDe0kZm1+8roOngtNaw+f5bm+YmDKkuVx6i8WndnMrVd/R
 +4hEN2D3jsWA4gD+mrDHhEyF6qWcvIOnPhMt2aQp5+45hvCqXFP8uD+VdlkjJFzZAm9X
 R+L0DPL+vOCN6AtLM1kAK/bHYhjprByeRn1LgJ+tvgXznLAOnCVh+FuuzBLOEot6HX8k
 d1XqNWTjzR/PPkW21U/Wcuxm+LFS9JuBFUolmE2GtJUTgZi+6QIsoWJGq0dLCXy3qG/k
 y6TVzzqu5zX6PjrsZyDIyEdUJmAcLQS1U/hGhIj2FNzUl2U10YXgbRTj2Ud5POcrCand
 BzPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639116; x=1752243916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EPqD2WiuW/V5KwVpgPbT8/RYmpheRb4cRCRm2q9oZgY=;
 b=fFNN5HdllQzJwrunx0xWjJyolxVVnFPgPrwb6NfYgQji0jgGgZfK71A+t4dk5Cpkhd
 +/dj33iaBlVwtipuipYyl2LOuUX4tUskKxm9QkryG/DeCyfx3yH1SJ7JgAhoz15L93UR
 fHzhcp4/+lcsocNONc8nEbywarZktFccbzX1+70P6rMPatEIxs9N1qY783ad0PCVYJVl
 bIx5McqAuOl2wdFOnAlOHdmUHgWwk0+DwVUHSV19lctQHZk8fVT85pPEUXnVHsMci9Qv
 /gnWKENzl0XwtukIKqGqXgzalG0rfdGXRKbkQBVy/Sd9od4L6UWZelq1d3MSHF87VfWf
 jvQg==
X-Gm-Message-State: AOJu0YxNLKzPoJ6mH9o9mog+KJJIUejPx8Cbouhe7JqpxV9GBMPbU5lc
 tBnxWIkAU4E5xm5pluPUcVww7SZQ5Lb2tvsWiz/M2MIyuncO280W+Trys5xn3ZhAEymBa5B4Ofx
 lAOGYC/c=
X-Gm-Gg: ASbGncudGNd3a65G4AhT2L+0x1pvSPJZRPkBlGfPb1BpZpY0bhVdtX0TuNFI1lXbLUr
 IBST5jmE6setJIx4txeGYKaqv/mLoJGmH0qqm9A82irAUUc94qhikFSb5AEgjUcADpzQHUFNAke
 NhYwX/tKZ6sUhiJb8rUEB++9qMneCsHhsj15vjh+ZoYysl4zXdyyAy8HZhsgY52ZYKl8WZgGmQF
 OjJbsdIWIgsxOH+e7hO3dg5/yNufnFPa+jezzyJaatOskyoJVL/2uB8bcAgLEx1utKRt1l+zemJ
 k/RcdRD+yQsyTKQfoHj9ufGns0zAyFDITLbzRwqXYdOiAAmfxdtB7uTvGw51PYfZDxv95FqUj+e
 TcC/55MMghpObBNTydBCAViT+yXxG/ztQ6uYmCfpBfuRAST6c
X-Google-Smtp-Source: AGHT+IGtw0H22Mn4k3L8E7vdgGk4Lf4uZv3kBFruNzpLgZgBHF3TUMwyzLoW8ijGKlMkyVO9yh5xug==
X-Received: by 2002:a05:6830:7101:b0:73a:9d3d:7bea with SMTP id
 46e09a7af769-73ca677b66cmr1470667a34.24.1751639115997; 
 Fri, 04 Jul 2025 07:25:15 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac5eesm310233eaf.29.2025.07.04.07.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:25:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 057/108] target/arm: Introduce do_[us]sat_[bhs] macros
Date: Fri,  4 Jul 2025 08:20:20 -0600
Message-ID: <20250704142112.1018902-58-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x329.google.com
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

Inputs are a wider type of indeterminate sign.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/vec_internal.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index bbf76f63b1..a1c10c60a1 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -223,6 +223,13 @@ int16_t do_sqrdmlah_h(int16_t, int16_t, int16_t, bool, bool, uint32_t *);
 int32_t do_sqrdmlah_s(int32_t, int32_t, int32_t, bool, bool, uint32_t *);
 int64_t do_sqrdmlah_d(int64_t, int64_t, int64_t, bool, bool);
 
+#define do_ssat_b(val)  MIN(MAX(val, INT8_MIN), INT8_MAX)
+#define do_ssat_h(val)  MIN(MAX(val, INT16_MIN), INT16_MAX)
+#define do_ssat_s(val)  MIN(MAX(val, INT32_MIN), INT32_MAX)
+#define do_usat_b(val)  MIN(MAX(val, 0), UINT8_MAX)
+#define do_usat_h(val)  MIN(MAX(val, 0), UINT16_MAX)
+#define do_usat_s(val)  MIN(MAX(val, 0), UINT32_MAX)
+
 /**
  * bfdotadd:
  * @sum: addend
-- 
2.43.0


