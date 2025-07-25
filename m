Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE11C87FCE
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 20:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufOvJ-0008Vm-2R; Fri, 25 Jul 2025 16:21:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufOrO-0005s9-F2
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:17:55 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1ufOrM-0000pT-Iz
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 16:17:42 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-74801bc6dc5so2500432b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 13:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753474659; x=1754079459; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d5tkjtMzBOBR6USVMTtNoVzWl8Jjj5UpHbw8uOgchWo=;
 b=BWe1xxu3aTFe+bOnbTAmJAsWPVDrALMi31eU677UH9GE6+uvDdxeKGj2Ob6qDMPDfm
 SqOz3/8sxqYlKiKGCW8DtOZg0ABVr3fyVOnen+Tg+L4PFy1FEYoZb7hBO4Q6+74cJU1m
 sT3c4JoMbfZK/k51cUqFzq518T6RoMs9h6NRxutuxqjKXoq7K1/ltEZPeE6ovINyjBJP
 naVi7rcnkrRQl+FQnb1bbtLXYNOehCmZGWdO6nN8clinZFmWlY+SfM+WY7wcOiStvf0Y
 JdjiPQqQytEuoo0Kogy83IPBKoFUOejw6cPEmOb4HDSAfl/2bfm3e2dg32EmBf+cgoov
 MOKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753474659; x=1754079459;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d5tkjtMzBOBR6USVMTtNoVzWl8Jjj5UpHbw8uOgchWo=;
 b=ViX7CF1ABHsMKAUsD9jvnYnrMWH8TyBd/9fNBbHpZx/N38eT5CRf/Xoza/ZzKqjW/Q
 edmqhbTOgHIZbp8qY2R622r+mvkIuOJ/3NO3PSqbK895JEn+Dw24hcXI9HmCLWA/PFnw
 J9JeIHgIKZQA8hsd5wqVyQhic0EKXtsebyULuFgfIsNsJ9Y2t1jUjAyp5EjgMvbNCZdG
 2/UEgavk8fk414psK0FVwI+nZ8OQsq4u8rHW9xTuYSpfFcDl6JU1+VyWqyrQg2iqoG0h
 RHp0k+Lwp3BVyN1wy6jUnHJ7Oi/hvmkTCs3tYv6L3oWzzDWGkMks2nllEv3WYX7/Egmt
 duBw==
X-Gm-Message-State: AOJu0YyQUqpjsCDg/Blgbkmp/X+3HS2su60m0VnSX9xZUCfkq0mHbWlH
 s8Zuoea3awsBs6+1iZbGf2FZCYRfDYO6VsEyzxpDGyR9aF0nuCCvujbyZEoxwoY1hnLB8Za+9AP
 +i3U6
X-Gm-Gg: ASbGncsajpJjdMVJDoQJ6Qk2zEjpez6yPHks1iktwLe+ES7MltQa253KpIitGUIvF3d
 bnNtPcFLBP35Q2t6oxArhQupGMCqtl+i/vp+4M2J9FNlRVNHQ15oprIHkJDq1QIj6Fz+4KZMfSm
 Un186GSCNvTyHuXOOFm8t8asYvThHGNUX77jy+ddg3pNBlL7Obsby1YQJF+z5FxhEQYXOiLOhLU
 X9X7I6fW/N3Usqo7FlCL4BwmxNaahkVKD82d/udLrt86TfsYblhYpg6HmYyZywY20gC5p+1MCPW
 KvyyvW90SqKxKvSeS2XNpqKD2s6XrDg3QRdUR9vmA7CZNogaWKFW3bEwj8eEboNTKHCbualOEFJ
 MOGGUQOzZtdWDusvI1QLV4g==
X-Google-Smtp-Source: AGHT+IHoXYj+0uQYOAbsELszkFweTzTJZgp1vu5sY9XyPFM5HhHmmEtIqVExzj5LtH/0HnT5hHuM6g==
X-Received: by 2002:a05:6a20:7d8b:b0:238:351a:f960 with SMTP id
 adf61e73a8af0-23d6e3b90d0mr5556271637.23.1753474659080; 
 Fri, 25 Jul 2025 13:17:39 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76408c023absm383611b3a.38.2025.07.25.13.17.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Jul 2025 13:17:38 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 2/3] migration: rename target.c to vfio.c
Date: Fri, 25 Jul 2025 13:17:28 -0700
Message-ID: <20250725201729.17100-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250725201729.17100-1-pierrick.bouvier@linaro.org>
References: <20250725201729.17100-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 migration/{target.c => vfio.c} | 2 +-
 migration/meson.build          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename migration/{target.c => vfio.c} (90%)

diff --git a/migration/target.c b/migration/vfio.c
similarity index 90%
rename from migration/target.c
rename to migration/vfio.c
index 12fd399f0c5..0b64e49ef06 100644
--- a/migration/target.c
+++ b/migration/vfio.c
@@ -1,5 +1,5 @@
 /*
- * QEMU live migration - functions that need to be compiled target-specific
+ * QEMU live migration - VFIO
  *
  * This work is licensed under the terms of the GNU GPL, version 2
  * or (at your option) any later version.
diff --git a/migration/meson.build b/migration/meson.build
index 36fb950b3b1..45e9445f97d 100644
--- a/migration/meson.build
+++ b/migration/meson.build
@@ -51,4 +51,4 @@ system_ss.add(when: uadk, if_true: files('multifd-uadk.c'))
 system_ss.add(when: qatzip, if_true: files('multifd-qatzip.c'))
 
 specific_ss.add(when: 'CONFIG_SYSTEM_ONLY',
-                if_true: files('target.c'))
+                if_true: files('vfio.c'))
-- 
2.47.2


