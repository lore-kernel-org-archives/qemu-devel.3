Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AECE3E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:43:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuKJ-0001D4-Q0; Wed, 18 Dec 2024 08:43:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKH-0001Cd-W5
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:42:58 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKG-0005dG-GF
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:42:57 -0500
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3eb8accbde3so381396b6e.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529375; x=1735134175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wosSj0kWkq5cs0VFJpmmiyQOLWqM761SJCj5OeJxoag=;
 b=cU97gTqrNY62lNYHNmj8GIbpwweot4IQt+Q5VoHlNqNGPNFdGY7YGFx9tpUl5Aj2mp
 vH4+3lV4auwuOfdtWt5+mIwoZTy7HBAS2uuqsoVIJJW1cMr/CICwhMKmqASXgQWQjXhm
 tlt7kjw4GvrMvoMe5/U9d1vOmI4vnxlFJsH/ik/eGsuMmCD/Rn6I44vyC2ygluo/K+BH
 55Z2w/kkEafKNNnG2T3hTOi6lAJh7STTynMQ4EHC5Xj3liTbozkOCMNy/Adt/JE+jVKS
 TBDWyZ54/8uGrVe6MBY2345Ap22SPgpu2HW9LFFneG41fwCmAdl8kjiDVgi6NL4fRs0x
 PPUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529375; x=1735134175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wosSj0kWkq5cs0VFJpmmiyQOLWqM761SJCj5OeJxoag=;
 b=PrVQesc90Q47JdbfqIz9lJi2ni/ktSlTePm5bawXojNocxT/9gbSf4jC2Kdya2RAyZ
 khW2h2zKfzuIc7ITiol/IoacqcP5y9yOUDOGKulsv8ex01/uzHEaHh1wPBxUqLsgLOrR
 O15yC6h3hXDvGHHyza5aT3kosijnLfWKp8XGz2Stwqu8gosij/P+3v3zqdArDM5lqVFT
 WdtUMkgo1pFyeQPSEH/tRNhrDCCraKFy0IZyB87TmwSS9KQMNkKp280lAb9q8GLXlICx
 dQLSUFAOCAkAcJ39TG40UzLXXJumGdEndgSXvybv/508hao97+eNe/yNwLd8ZPHlrziI
 3Ecw==
X-Gm-Message-State: AOJu0Ywv+YBtq/6SHweYE9z2hq9osFQ551sSjDrY+GCGJF121VtcS7tH
 yANLj7C/4S2CGfwVxQuaM9beFXQBiuF54BCSDXGeI8MKKI3jG1wR1yTlhCVFtSJBAXZjzsmHZ2B
 YsSdeKYvk
X-Gm-Gg: ASbGnctXOjzSnEosAvHEebUleGlKy4dD3hHTDQZfAIf0aNJ9K8/v7eig9IcPIRk+X+J
 2zUqHmTyrtNNkJF1dO6YMUV9Xee3JCm9WbUpd55mvj5dTfnlFFBY3VcETc4U9ENFTlVYvPL2+Mp
 3hjxNhsuy5eMLOpJYxiZoH5jeUQjv0qjH3Nfyxum1bv8Is89EdzNQRkvUIvRPI3tLTuZl/gBEEp
 Cd8Zse1altSDMBx9D1l4T8h+rQJbjTLGRTRe+R7PRx8OJQOAUpb58WLfNyGtif5
X-Google-Smtp-Source: AGHT+IEp8zoCh+qFjCE5koC+XJuvTX55Y0zkZ6B8OZ2XNcr+L/k/ot7dRlQpQEYXoDZpxiw7kpw7Fw==
X-Received: by 2002:a05:6808:1492:b0:3eb:615a:eccf with SMTP id
 5614622812f47-3eccd0c8f2bmr1274106b6e.10.1734529375248; 
 Wed, 18 Dec 2024 05:42:55 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a502sm2870951b6e.9.2024.12.18.05.42.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 05:42:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 01/24] migration: Constify migration_properties
Date: Wed, 18 Dec 2024 07:42:28 -0600
Message-ID: <20241218134251.4724-2-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218134251.4724-1-richard.henderson@linaro.org>
References: <20241218134251.4724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22b.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 migration/options.h | 2 +-
 migration/options.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/options.h b/migration/options.h
index 79084eed0d..a360f93a44 100644
--- a/migration/options.h
+++ b/migration/options.h
@@ -20,7 +20,7 @@
 
 /* migration properties */
 
-extern Property migration_properties[];
+extern const Property migration_properties[];
 
 /* capabilities */
 
diff --git a/migration/options.c b/migration/options.c
index ad8d6989a8..24cc8471aa 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -85,7 +85,7 @@
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT_PERIOD     1000    /* milliseconds */
 #define DEFAULT_MIGRATE_VCPU_DIRTY_LIMIT            1       /* MB/s */
 
-Property migration_properties[] = {
+const Property migration_properties[] = {
     DEFINE_PROP_BOOL("store-global-state", MigrationState,
                      store_global_state, true),
     DEFINE_PROP_BOOL("send-configuration", MigrationState,
-- 
2.43.0


