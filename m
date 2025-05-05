Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE4F9C3ABB6
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 23:27:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uC5Bo-0001Te-TJ; Mon, 05 May 2025 19:25:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC5AT-0006rm-To
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:24:14 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uC5AR-0003wX-6B
 for qemu-devel@nongnu.org; Mon, 05 May 2025 19:24:13 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-224019ad9edso75559925ad.1
 for <qemu-devel@nongnu.org>; Mon, 05 May 2025 16:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746487449; x=1747092249; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FePGOnuFMFKSpyGOLnQnHaWTz9W0KMamhZVlYN31tfM=;
 b=zO1/mh++ra4fIMa748zGIk7nRN9zShfM/SjR1nxXLVKLnnJAhjj3qdRbQMAtG7l1eK
 RpNR9NpqXBvONd7XC/hSOdDAKgYI6VzGmFeiZkfPZgreXzJr1HMTx1MxiZbVfYew6UVG
 ePbsVw5zljpmfGGW2l8ZZVfqqmHvDaEsdA1HEAOOeqO/lZF8Vr3dBDwsIRPdPaBU3Neo
 VZ7YPHkEZ3oq1O2ksDYT/EQv1J+a6hh00jh4R/iBOvfwurIFiBxbXc0nSFyXkXjTS6ZK
 lNUxfX+k2w+DzBpEEUNmryAuHQc2KGwLS5mVF24e+Vw45V8ER9ca5y8dED+pBbAkWCbJ
 UIiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746487449; x=1747092249;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FePGOnuFMFKSpyGOLnQnHaWTz9W0KMamhZVlYN31tfM=;
 b=dG8m+hVg3odvWunJAmKfdpivSMubJQyWfZpvmYaLx8EhPuE1xVho9ljiqLTl+hRaKL
 kcyruEAQu1WpEEaB114tISNT41cdzx2QGG6pXa7couG7oIhJ+kGX2cOYG7ZQNXHSXsqj
 A0aoxo9xLXvy6W06yO222i1Ha0Gaj1sTyBs2e6WITWLzGgLj5IKhwIKMMC3o3r6Y/v9x
 9Hauv7Ri17gfEJWnZrASbE99Vr6a5eB5l0z0ZsfmFJrK8pYFY3AOq8fZva2bmMYmjSQg
 49zWUV2TKaXTukD053oXZ58vVtDq0hRGB25CRo16TpEG3a2JKQVHD1SNCfBLONn5IgRK
 b/3g==
X-Gm-Message-State: AOJu0YyCqxD3UnDgU8oDPtvGhS6GYGQxyNu+khw10vEbfMmTJto8lVnl
 o5jkgsXpzBk+yB0SXxTSBLrTD3C+Z6/GZXzESOxfWLA7BrVB/Yo/hRaGdpOv6Q4cgIEp7UcWubz
 jtFg=
X-Gm-Gg: ASbGncvvlpDSsj8Lg2+clNmgHYsAyGtDiR796aUrR7czYMBPc17h3VWdG+mDN2PWEeB
 ZpfMz7gCgwIIdkNgoqd+19ACHTBVjLXIuVcY8aJwplIoU1iCvmBqZXUc41yrZt9lpY4enJsDEbH
 EkWaEUz1Gc7BfHGnuBExPJSZ46TCxWBMJg87gOjS9fv3jYZKLER0aFMhtYLE0EpZX8wEpCM+giB
 B7mKxVC3ivfRtFwn/AFInPR7IFDKlAQ6m3P9zHMmW6AgfIPewNykcrv2pmg92MkdB6InzFuM4yU
 DM4totcmu4/9zpQm1JHfYHak+FZaFLnkly4CJgTUeOxOOtSVOM0=
X-Google-Smtp-Source: AGHT+IG4fx0CvaAjKNBoHndxnHIoiD3HJu4nruhwtm92fod++gF3qwZx+wAOg50uRK5w+IBGupV2nA==
X-Received: by 2002:a17:902:d4c2:b0:22e:2cf7:c677 with SMTP id
 d9443c01a7336-22e364b6de0mr10842955ad.47.1746487449067; 
 Mon, 05 May 2025 16:24:09 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22e16348edasm58705265ad.28.2025.05.05.16.24.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 16:24:08 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, anjo@rev.ng,
 Peter Maydell <peter.maydell@linaro.org>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 41/50] target/arm/tcg/vec_internal: use forward declaration
 for CPUARMState
Date: Mon,  5 May 2025 16:20:06 -0700
Message-ID: <20250505232015.130990-42-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
References: <20250505232015.130990-1-pierrick.bouvier@linaro.org>
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

Needed so this header can be included without requiring cpu.h.

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


