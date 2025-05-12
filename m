Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9EFC3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:14:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXev-00075j-5S; Mon, 12 May 2025 14:13:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXXC-0002rb-MY
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:50 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXXA-0000EG-B3
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:50 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-afc857702d1so4125633a12.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073146; x=1747677946; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IO5E5SNmIeDx8PW0b+RfMLgVUuAcPfL8utSgWSmdyqA=;
 b=I63TYeF2FUlULW+434kE+Cxkdwax93J9kI9rMWR3/W7s6jdALr/gTTjWmNOX78ziz3
 6g1haD/YDxwca4CB0KMUC08DP00nwxDH322tTCYtXVVQMBE1hdyaOfK5cnFhNi41A+8b
 S2SkVQOIRN51z8JWzL2gGAkgbwWqbKAmS6SwOMV8NBSfK/TSwPdsN9qzoVCL0UTLQ0Jb
 9kAFJ+TxAMWyi/hvHcSzeA9Dg+1Q23B1i3QupBi9VEueSrw9HTeEW8LHQ4rVGjdU5FmV
 m9z/gzQOqyjtwjv9fFHwIY3ZF/MvPvtOgJp4fbaTL+TifXiWia7r9qi8+O+IgZ9E41Vw
 NrVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073146; x=1747677946;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IO5E5SNmIeDx8PW0b+RfMLgVUuAcPfL8utSgWSmdyqA=;
 b=G4yVSilWRn1o54fLD2132xuC1YDT5wPU25OKRScjo3WxKb0n1VQZtk6vSmpnoNV7UZ
 JofEis9XDitxrAalNaPx4gH93oTGlDf/VC5WCLCpaoi6b5Ii67nGNjZDfnSd2/vXhge/
 3Sdxwqro5rmVsOQIZAvO5SG3syvZ31ZV/brWVSJX2fIAEEsAl3AgDEBljTcAQa/2B3SH
 mXwScn647oeaBILRiciGrK/5x9Dc5i8n3BDZmNPEY4Rz2Bmny/CzUi8iborGmJWvVIJO
 T369shkin8M8TTWDwoG8C+nBBN2zKyt5jUUZD4wwYKEgOfCUMfDWVnyT9VysF+n8Z9ne
 B2hQ==
X-Gm-Message-State: AOJu0YyZWItUzKNo4Me4MibEezGo1Ez6ztxgkjz5nIPfywFr7xRS9Nix
 BIsgCnz8m1MoHOWpJSemoodXuH9jzUl+t0u6jnOaXGxEDJ9k6LRULJdVzEoZJoNX7iztPyuieoS
 Z
X-Gm-Gg: ASbGncuRHNKBGXzOfeKFx/+2qVVTbXE1kXwFh+ShyLxEZBc+kFFNOacZYFaby/aFM7i
 m3U/Hon2OM02EnAI54QqGqmdS3CWw4b9BY8+Hau45sOBfpTh0dlDH0Y2Khsj+kmBqK0UisXqYu2
 uLwiRhFAbD/OLK3N4xI+unFyVkLkG+jJpti2MGPNCfwMu5J3YtfqNUjCWjKpP9j7WaTb8kRXlSN
 sKGGk/I5s4Gk8Nu6UKAGV5dMhDfi/6LbHA5gBZRl3zyQzva9clOY5MlvLW+b5jYeu/iyd8RmGRA
 D/hsAVbP6sWVq8ZE+ihKdJGopoVlr7O/TFT7su+eAytqldjQzPM=
X-Google-Smtp-Source: AGHT+IHj+ksKGYhPnHifXirA+gi4i431YFqKs1JUn41Q6PWik4/CLP03qf1Wl3GK9Z24iyTARgkJLg==
X-Received: by 2002:a17:903:2443:b0:22f:b6cc:421e with SMTP id
 d9443c01a7336-22fc8b592bamr200772745ad.26.1747073146460; 
 Mon, 12 May 2025 11:05:46 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:46 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 39/48] target/arm/tcg/vec_internal: use forward declaration
 for CPUARMState
Date: Mon, 12 May 2025 11:04:53 -0700
Message-ID: <20250512180502.2395029-40-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52e.google.com
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

Needed so this header can be included without requiring cpu.h.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/tcg/vec_internal.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/target/arm/tcg/vec_internal.h b/target/arm/tcg/vec_internal.h
index 6b93b5aeb94..c02f9c37f83 100644
--- a/target/arm/tcg/vec_internal.h
+++ b/target/arm/tcg/vec_internal.h
@@ -22,6 +22,8 @@
 
 #include "fpu/softfloat.h"
 
+typedef struct CPUArchState CPUARMState;
+
 /*
  * Note that vector data is stored in host-endian 64-bit chunks,
  * so addressing units smaller than that needs a host-endian fixup.
-- 
2.47.2


