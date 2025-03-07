Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60B4FC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqcsa-0007VT-7A; Fri, 07 Mar 2025 13:57:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsW-0007UA-Ga
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:57:00 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqcsU-0007oT-NJ
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:57:00 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2fef5c978ccso3558533a91.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741373817; x=1741978617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+0vlhP+/ciA3q59qQifyZ8D/3OKhNe8zch9jvXIoi5A=;
 b=w7D/qhWZQZMho6FCx+LirGK9aIkw7zzz1u6E7FiW9MEjUxgkgno9powxby5pqECXL0
 zOmNR64RMBjhYADVSut8cS3b5ipmSI3LLkl609BiaKh83LSVUavtt0JH58oNZjkaOh53
 8cj/bNeOqWquRrhmrr1JJWY7r88+p9XP+v5T9oFolx3HO0U55I0tcSWLtaz5Ubr/aFAg
 I3Q+8XGRsvCmZpf8sWhgev1WRE5u0gTL9nAc+WbQjip+Xs9I/SygGF4DcaG+XSZo/G6h
 Vfvo+piS8tPLimnQa/d9OfaQDIvpLWqHlOcxCOrVNBLaO/UPFHmko1f7DMwj1YlTFprN
 bvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741373817; x=1741978617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+0vlhP+/ciA3q59qQifyZ8D/3OKhNe8zch9jvXIoi5A=;
 b=nQnKkx76VxspH7ThEDfMEJt0G/arQBSPwJkaNiXmIeXLWt/s/jquHVeHnywSJwmUyS
 fs8VAnJ5UbrHTE+ciAQ5/4nruzSQXIDpa6mdvaZucLxr8UStBqg59mZ9JmVk/oRQfiX3
 7E/5Hea8e0cnvx+JWvO0q4Dm2i6z90/aeLk9Cd07+bo/vbWtoUwebSRBhWjAg1JdfJ9j
 9gPO3cpK2UWcqL46b+B4EMISMmyGALRqGEiXzk0kZA4NOKK8DVuLZng+V6HyQpAtTcj7
 KyAB/7MCi8T/4zMhEizvUgzRoYDP3QhyVGpisAtzYW626FuFQtRJTjNNS80R86gK0Bxd
 8hKQ==
X-Gm-Message-State: AOJu0Yx/XwcTuxk6v5bSu3/QYe4AsbwHehb0ERT9Ajdcv9G/+8A4URxE
 myQUHpC6XR9Dzrj8s/YS6n8mM6KBxpeK2rs7DGzi2ROT8m773H/e5plC4f9YrO41R0wqe07QO58
 F
X-Gm-Gg: ASbGncup7PvEb4Lc2sj/QnCJjuuMentmKfWdoaWviCaZYO4Do8zaiT60JJLWfRzJSm5
 weRhld+dpBNttfjT8bVDtcLCbhT62vfPKWsHfx5cGD+XmUXuSciCbVLOvSFt6KDxYI4FrZ3aBFL
 RA51vrdnTrYmQ2jnjabtf6GG46xk3sSNw0viI3tMe6AMRN5lgTerqBHdMa6iaHFPirsUV0LSv9g
 iFtIZyKy2mTbs+XvgfAX4OIfuuwlmC7yQUfostnPsJacrd2POtDZC8hGp/6HwcRPkf7Nuq6DSKV
 gdbdtznjBxDzl4+7aUm7OmEpXvSmrC/QfROIfQyqdoFnt6+xTNIgDtK7prCT897bRWVil/Ybu12
 z
X-Google-Smtp-Source: AGHT+IH/8CGOizvE8NyWoZgHayF8ydxCdXF1WReFxrABEX308VrgXK1eoMG/wFgl40kty6/GIKI7wg==
X-Received: by 2002:a17:90b:3911:b0:2ff:5714:6a with SMTP id
 98e67ed59e1d1-2ff7ce895fbmr6273140a91.19.1741373817265; 
 Fri, 07 Mar 2025 10:56:57 -0800 (PST)
Received: from stoup.. (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff693534f8sm3391917a91.17.2025.03.07.10.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 10:56:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PATCH 13/16] accel/tcg: Build tcg-accel-ops-mttcg.c once
Date: Fri,  7 Mar 2025 10:56:42 -0800
Message-ID: <20250307185645.970034-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250307185645.970034-1-richard.henderson@linaro.org>
References: <20250307185645.970034-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

All that is required is to avoid including exec-all.h.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-accel-ops-mttcg.c | 1 -
 accel/tcg/meson.build           | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
index ba7cf6819d..bdcc385ae9 100644
--- a/accel/tcg/tcg-accel-ops-mttcg.c
+++ b/accel/tcg/tcg-accel-ops-mttcg.c
@@ -30,7 +30,6 @@
 #include "qemu/main-loop.h"
 #include "qemu/notify.h"
 #include "qemu/guest-random.h"
-#include "exec/exec-all.h"
 #include "hw/boards.h"
 #include "tcg/startup.h"
 #include "tcg-accel-ops.h"
diff --git a/accel/tcg/meson.build b/accel/tcg/meson.build
index 87c1394b62..81fb25da5c 100644
--- a/accel/tcg/meson.build
+++ b/accel/tcg/meson.build
@@ -20,7 +20,6 @@ specific_ss.add_all(when: 'CONFIG_TCG', if_true: tcg_specific_ss)
 
 specific_ss.add(when: ['CONFIG_SYSTEM_ONLY', 'CONFIG_TCG'], if_true: files(
   'cputlb.c',
-  'tcg-accel-ops-mttcg.c',
 ))
 
 system_ss.add(when: ['CONFIG_TCG'], if_true: files(
@@ -28,6 +27,7 @@ system_ss.add(when: ['CONFIG_TCG'], if_true: files(
   'monitor.c',
   'tcg-accel-ops.c',
   'tcg-accel-ops-icount.c',
+  'tcg-accel-ops-mttcg.c',
   'tcg-accel-ops-rr.c',
   'watchpoint.c',
 ))
-- 
2.43.0


