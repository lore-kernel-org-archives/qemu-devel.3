Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74EDEC1E9E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 11:17:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnxLq-0004m5-Us; Thu, 05 Feb 2026 06:16:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnxLd-0004gV-Qu
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 06:16:37 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vnxLZ-0003ms-Hm
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 06:16:32 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2a91215c158so7136895ad.0
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 03:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770290188; x=1770894988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NG8wnYEGimu+0Q8ny+fmkMWmNmBlD1DOR/UeATfalX4=;
 b=G5TnUPbiGXqKQL+jxxlTsVgiYDLeocGASAfYkT679uVMSslzWGnNgfwT+kHjUyO2Sd
 gQXo+WuDTk8ZnJ893HtkGo8bOgvZAGlpTCfenqRk4d+jzrB/GIImvJ1pLAjew3lqGxum
 UEMqdkWEooqnu7SY8vdwyIg7D4EvLNbojbqPPWYX9zd4mFufv9U2BJyAPI5/OUTC6BB2
 WBbNFYSKFutq+eOou7szUuovaMqz6cLh2HmTPkGORcDKJBsGajU+1YMGuEGHjFMMkDHq
 /m68aQV17Xa6TwxdqjSQ93vpSnVXsOUUYYo4KG8i0ggV86H9C/rrGSgfqDYJXWnwWndE
 OdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770290188; x=1770894988;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NG8wnYEGimu+0Q8ny+fmkMWmNmBlD1DOR/UeATfalX4=;
 b=QOxP0EKYY6085KB/wUQu+tMI0JblIsLiNtmC7LckcGAbojY3gbNtp5JRmm1u/giIeV
 Gkje3xL+9xBfdizLCA7PqsCpjQ2HF39Xm/JqIKLWTpSQfaslc7LFtX7AFHFoFtLbbP0+
 MvTUXyb/ZTUq8DQCiLwAbxgjHdsd7oRrGX3CFTO5+SxClPJpl91jT5On7mZ3yA6XqmDc
 za+Gl6pWcfjmYH4aqcZvU2QZmQcoMXh4jKDXhESW/qmy2I8JpjBNLpX866DLm/vL+yV6
 KfilZQ8/3iTGWEebXeXoUYmFZc0OV6raI7xl0TxDyFK9WGqoFXvthrPrCjCMALwXQia2
 sWzQ==
X-Gm-Message-State: AOJu0YwqnS35w8R/Tb9bD2YWIWUx5JWEw+W/RVfzX2de053oFtl5iDgX
 Gl/rv595nOEBSasoGAPN4YbrytK/A6hO0JnPCRpxiWEWThUWolvh0AzqKv7frKzA+PvI9OivxNE
 nKthYVRVMyA==
X-Gm-Gg: AZuq6aLdeFUUYSe3bs0R9NHeOwbTQ0KSnMXz+wcbwfRTRxrWe5zGq/NbAA5MPcFZfvE
 yXK0yTlXPJ+RyGdD5BG3AunwQi3HEh6TZkS7ZVwbYprtaA+VAfvRrAXC6igjMKtJPivIYgrg1wK
 dAtGS7YDLb23VVwh8mioOK0feeVd3NzVW17ZQ3hoG8pGpHPbnP36rQkjd73PoucIWi2LLSZwk55
 q0bXoHiMEGtDjHKyKM3zYsCSrtvDv6X1ect/WpN8ympkB7NYsZU+W9Ss16JmA2xISQjFdl/hOYC
 U1QaJnn0kon3asYb36ZiLaSIoicgfFMQuu+62Z5KFQXH4DajvviJkPQeFl/aVnEqIXqF6jFfXZj
 jZOOO5gvdfOjKRhGTfs+cLmlEgCM5SUrTQHTsYFgIyiv4ng2UbSRRaQ9y6T9xW+AXxFpdZs5moa
 SdWWlIFOeip9PTOhw/EohDzT+DAx4PLyQ=
X-Received: by 2002:a17:903:1905:b0:2a0:34ee:3725 with SMTP id
 d9443c01a7336-2a933cf990amr69131045ad.14.1770290187853; 
 Thu, 05 Feb 2026 03:16:27 -0800 (PST)
Received: from stoup.. ([2401:d002:dc0f:2100:7515:513c:b646:18b8])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a933851685sm51088435ad.13.2026.02.05.03.16.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 03:16:27 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: max.chou@sifive.com
Subject: [PATCH v4 0/9] fpu: Add conversion routines for OCP FP{4,8}
Date: Thu,  5 Feb 2026 21:16:13 +1000
Message-ID: <20260205111622.461497-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

Hiya,

This is the form of what I was talking about wrt spliting up the
patches and introduced FloatFmtExpMaxKind, as I suggested during
review of v3.  Since I've got no test case for these formats, I
haven't been able to do more.  Please test.

r~

Max Chou (8):
  fpu/softfloat: Refactor IEEE format NaN classification to share code
  fpu/softfloat: Refactor floatx80 format NaN classification to share
    code
  target/i386: Fix pseudo-NaN handling in FPATAN/FYL2XP1/FYL2X helpers
  fpu: Add overflow_raises_invalid to FloatFmt
  fpu: Add saturate parameter to parts_uncanon
  fpu: Add conversion routines for OCP FP8 E5M2
  fpu: Add conversion routines for OCP FP8 E4M3
  fpu: Add conversion routines for OCP FP4 E2M1

Richard Henderson (1):
  fpu: Introduce FloatFmtExpMaxKind

 include/fpu/softfloat-types.h  |   7 +
 include/fpu/softfloat.h        |  18 ++-
 fpu/softfloat.c                | 211 ++++++++++++++++++++++++----
 target/i386/tcg/fpu_helper.c   |  30 ++--
 fpu/softfloat-parts.c.inc      | 152 ++++++++++++++------
 fpu/softfloat-specialize.c.inc | 245 +++++++++++++--------------------
 6 files changed, 429 insertions(+), 234 deletions(-)

-- 
2.43.0


