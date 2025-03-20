Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F8AC28B30
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Mar 2025 22:32:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tvOQR-00034c-9L; Thu, 20 Mar 2025 18:31:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPQ-0002SC-3M
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:30:44 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tvOPC-00078v-6Q
 for qemu-devel@nongnu.org; Thu, 20 Mar 2025 18:30:39 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-223fb0f619dso27815535ad.1
 for <qemu-devel@nongnu.org>; Thu, 20 Mar 2025 15:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742509822; x=1743114622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=purOXWOR3Fj7UU3csfI8HYdWZCzZY8lYxjlph8NWhiA=;
 b=fx4nM3Ge4SpFeTgcjVWdqsGL7XG6zcOky2aq8RpbIQuSoK2IirJkaZ+oOaxD5IFYwG
 v+myYGnjOtHHSDJpYUEr/pFHnH5uYKFkl3d2iUPY9fYMGtaS6ppDiRYVLtGJGMVlGoiI
 qsYEp8YPI8YtczVocQf7zaER1bq2GfkPgC1jl0UiLbs2MsMJIHsCTzY/GabKUsBpS3Wg
 jRm80l3PaJSf3ABTLUHIlNUOWdy0ENEcwVMXzO7q6r4TXZzvf4nWtCoCq+4iRlKSZn4i
 SqcRwbowtkL0+GLRM5mzT65+fWmRjBQDYbEixZbREQPxHHTlwheI9wFfudD8UsLOL6dy
 DsrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742509822; x=1743114622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=purOXWOR3Fj7UU3csfI8HYdWZCzZY8lYxjlph8NWhiA=;
 b=Dh5OGMVfvX52bXMttlSPu0fIH3cZeXWghUO32omu+MIsBJzBM0oGLkAV5ERyKvtKo3
 5Pa8G6HQoaUlRMiWXlELqVilx7/hE5Dy+8kKcw2jnAc9v/9jpXhN3deYcSt8oS5Z1cxO
 WeyfdlL/seAs9Y3GjSUsdbgzt/zwFDy3rlfuvg0O42G7HSEew6ihUvNziqrbRBSSyQZU
 XOQr6ckgHIWFb/xz4dVh5IsVHFjmDWB1vvFfAM/mOrQf5eILhBBgPHBTu/JyC/JBMpQZ
 hfTeFdFJoy4yDBAgedmLXN9eZA8nqWH9JsjkihEj5d/3JTilFu8wti+rOHibPfyet+yw
 PvmA==
X-Gm-Message-State: AOJu0YzCv8vUi9f6KCEHqC6EO7h3iHfpfZp8MdYBCRsTno1BSOn/vzu3
 Ta6B+J1bSAgZRJsd9qc5fn40Jg372iEmCD2ReKiy3Run5pplkVHfJHfaDaxisEjSGTETVdsRvnF
 g
X-Gm-Gg: ASbGncvUWHg3qJ876ZDMvaKEos/sQuDZG0tTo+G+XBqM5+83fjC6jF5Wp5YB2s5oWrw
 PK01U0Z3UEmCt+uG/ZurFBRSlKhVu7iq89Bm13CZzQ1RQTjuKkCrMQnCMm38XXmTlNI3ib+e9OE
 wDv5cK/I+Z4w3VTng+mBFM2TfVUF8hM73htAnQLvnOLEU2ogzl9RlOEjejOzswOywRCrlQNEkAn
 s4f/pPx4JuYZTwklJ5xG1zg9mrSzKYHHYIrwwK0WXiEE9Kr8fdW0gCXjJjof2bCv4BWjwfjPlye
 bFtdZklwnvsOEnCXdHH6XYS2n0zJRPSiiHoJmiIckPLd
X-Google-Smtp-Source: AGHT+IHaNLh4H3nOX0n5FztI8RzThHS/Cd+JnSg5LqxEttWiRhXwEic0w9kPLtKsb41I99998VMKRg==
X-Received: by 2002:a17:902:d4c7:b0:221:7b4a:476c with SMTP id
 d9443c01a7336-22780d80176mr12012615ad.18.1742509822336; 
 Thu, 20 Mar 2025 15:30:22 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22780f4581csm3370145ad.59.2025.03.20.15.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 15:30:21 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 09/30] exec/cpu-all: remove exec/cpu-defs include
Date: Thu, 20 Mar 2025 15:29:41 -0700
Message-Id: <20250320223002.2915728-10-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
References: <20250320223002.2915728-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index e5d852fbe2c..db44c0d3016 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -23,7 +23,6 @@
 #include "hw/core/cpu.h"
 
 /* page related stuff */
-#include "exec/cpu-defs.h"
 #include "exec/target_page.h"
 
 #include "cpu.h"
-- 
2.39.5


