Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7C4AC5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 04:00:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfu3s-0004Ar-8k; Thu, 29 Feb 2024 22:59:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bryan.zhang@bytedance.com>)
 id 1rfu3b-00047L-AJ
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 22:59:36 -0500
Received: from mail-qk1-x72a.google.com ([2607:f8b0:4864:20::72a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bryan.zhang@bytedance.com>)
 id 1rfu3Z-0005el-Ro
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 22:59:35 -0500
Received: by mail-qk1-x72a.google.com with SMTP id
 af79cd13be357-787ba57afd1so109857985a.0
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 19:59:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1709265570; x=1709870370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LDfqc5wzpzBRvYvGuAKd8VY57k0ymWvb8fJxeCIdafc=;
 b=lgxNcKTKT14vdC44P/CitbwLWd1aPp37w3JGPZuxSIgyxG6X5iLXypGv+HZMiT8Yxw
 IWA1KlEkGXIxnCOmUOaK2ROg2xP1ihfZ0RdzxppBY9lFX5OfWzSGKxDiCMYHLzy2RDFo
 f/iZvv5T6YJ+nkqvN33flK+tcpwSB2lG9qG0XumVu5d0wXq7B23XcEPjtn/66ufk/UiJ
 prleR4ly0l7RrJsKm7iymF6ZleQlHphcgcacKsEYU4oay6rmP+CTVbjeHVNpziuPdsFM
 zsyy0zqVENnSS4Ax/RAxceG4qVP1FxmL5iXx4lzueyA+cfbrofFmFFukE4P9hLkC8kYD
 31OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709265570; x=1709870370;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LDfqc5wzpzBRvYvGuAKd8VY57k0ymWvb8fJxeCIdafc=;
 b=flhxV/ElhgUVdiHUut1E+Vv/v1cBIiX8P4WAFSNXnFl2qtdc0+CVDas0DaiUL5Y9HR
 fOQruehQbKGpu8FRV0JEnv7UQZ+mfdiYKk1ujk9tHQblzFjJybCnuV9Tocz0lF9P3gsa
 JLwuk19VusOgSJ6AYCh9lH747/l2yEcps2oCukeQV8Clw4kU4qaJCss6TiM6tAwilnco
 /WdSgSdrtCeY6e+55X572YWLnCejClnxjbwtnFgVW+6y87prIl714k/JHDSLTEy22/fM
 1wHOqprJLTnEJMVKdXoi+cQHhfRrQOcULhc/dK8t8j+D2QKiWrBRancqeL6WS3NQw4s9
 YizQ==
X-Gm-Message-State: AOJu0YzTUnEVrXH7Vi/0GhsuH7NueMyApfmtRanLrxQvEK2QqinkhSKz
 QjXFOJshzK0tYZzPLzF51l8YyDFDaYsPo9aGVLKdEHu36OdleVgVtE81n+ld/WdvyR1NjfGPz/8
 X
X-Google-Smtp-Source: AGHT+IHYS+jSTmkJRyy+sreG9hpp/UKhhlGOlMYM/4my1dUTUcppAcek9n+QU0JwMm51sewhAvihcQ==
X-Received: by 2002:ae9:e30a:0:b0:787:389c:fc1d with SMTP id
 v10-20020ae9e30a000000b00787389cfc1dmr599734qkf.73.1709265569679; 
 Thu, 29 Feb 2024 19:59:29 -0800 (PST)
Received: from n36-186-108.byted.org. ([130.44.212.90])
 by smtp.gmail.com with ESMTPSA id
 c21-20020a05620a165500b00787c6703539sm1296986qko.90.2024.02.29.19.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 19:59:29 -0800 (PST)
From: Bryan Zhang <bryan.zhang@bytedance.com>
To: qemu-devel@nongnu.org,
	peterx@redhat.com,
	farosas@suse.de
Cc: hao.xiang@bytedance.com, Bryan Zhang <bryan.zhang@BYTEDANCE.COM>,
 Bryan Zhang <bryan.zhang@bytedance.com>
Subject: [PATCH 1/2] migration: Properly apply migration compression level
 parameters
Date: Fri,  1 Mar 2024 03:59:00 +0000
Message-Id: <20240301035901.4006936-2-bryan.zhang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240301035901.4006936-1-bryan.zhang@bytedance.com>
References: <20240301035901.4006936-1-bryan.zhang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72a;
 envelope-from=bryan.zhang@bytedance.com; helo=mail-qk1-x72a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Bryan Zhang <bryan.zhang@BYTEDANCE.COM>

Some glue code was missing, so that using `qmp_migrate_set_parameters`
to set `multifd-zstd-level` or `multifd-zlib-level` did not work. This
commit adds the glue code to fix that.

Signed-off-by: Bryan Zhang <bryan.zhang@bytedance.com>
---
 migration/options.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/migration/options.c b/migration/options.c
index 3e3e0b93b4..1cd3cc7c33 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1312,6 +1312,12 @@ static void migrate_params_test_apply(MigrateSetParameters *params,
     if (params->has_multifd_compression) {
         dest->multifd_compression = params->multifd_compression;
     }
+    if (params->has_multifd_zlib_level) {
+        dest->multifd_zlib_level = params->multifd_zlib_level;
+    }
+    if (params->has_multifd_zstd_level) {
+        dest->multifd_zstd_level = params->multifd_zstd_level;
+    }
     if (params->has_xbzrle_cache_size) {
         dest->xbzrle_cache_size = params->xbzrle_cache_size;
     }
@@ -1447,6 +1453,12 @@ static void migrate_params_apply(MigrateSetParameters *params, Error **errp)
     if (params->has_multifd_compression) {
         s->parameters.multifd_compression = params->multifd_compression;
     }
+    if (params->has_multifd_zlib_level) {
+        s->parameters.multifd_zlib_level = params->multifd_zlib_level;
+    }
+    if (params->has_multifd_zstd_level) {
+        s->parameters.multifd_zstd_level = params->multifd_zstd_level;
+    }
     if (params->has_xbzrle_cache_size) {
         s->parameters.xbzrle_cache_size = params->xbzrle_cache_size;
         xbzrle_cache_resize(params->xbzrle_cache_size, errp);
-- 
2.30.2


