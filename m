Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C6ECD1267E
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 10:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8H2G-00032P-Pu; Tue, 05 Nov 2024 05:43:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t8H2A-0002xS-GT
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:43:40 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1t8H28-0003Qf-Tb
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 05:43:38 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c9388a00cfso6183206a12.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 02:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730803415; x=1731408215; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PNuzYa5+nZdqvnGVKWFxmNuP1iytRrvncpaN0YbpD8M=;
 b=mTRCD0vSx0l/sTOp/Zq43dapnB4SdZ9JBwyT9BFf3nmP+/3QuLMGfY17USqQxKcnrI
 1E5nHJw9v8u7nsh8oxRVZjJCK9VHN9Nxnd2K1bJeVqQPB2j2zRiTaBdKdMT2lldrkv4h
 9EmfNJ78YpqY9xpEu/QaeayFJBwaHFCPy6fIt8q+j/Hl0HBxNzM98UjZgTlQztWQX2z3
 iHUOqpktx0kZjPEN9Kz09Jxddadt+GvXib5eyx8jXRLSQWyG7S4OEShtg3+N1r8Xp/AT
 O3lLqrs5gO0okwHMua3RvwjqVnAQwJwOpNGyJ175zW513541YAxFKo3LTmfxgcTVYWiS
 e5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730803415; x=1731408215;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PNuzYa5+nZdqvnGVKWFxmNuP1iytRrvncpaN0YbpD8M=;
 b=MLT1F5UQibr2KoOMeX49YvhHJWsR/0DKtWm6s0MXcE6Qd8fAQHtCHw3nos+teIYWhM
 Jt9W8A7BEqLe1Tq/mmmzzom3sVwnnt61RF4vyi+2dqArQpcSPc8vjObLfal/aIqAlEii
 oG47H5AEjp425T+fSIjubO3pel912NiNmbiIRes06/gia9URWK1bfB8+yfxc/gOnG0xr
 iKJPsV1UFAbUdUOM6H63hV9NZ0JkRNaK19CG9L3MgxHF1tyV7Xa2CoKmPUe0evNG60jp
 ZV4VgWjUK4hAVbfpfwsF1ko/gnflYXThrJVXXSCivO91H6dxO9jswPgZIi9cotXVjalM
 l+Mg==
X-Gm-Message-State: AOJu0YwuFPg8k9WhhOVm6urpoyXbDzCacrOnBh33invdZkFvQH1uRBvM
 0lyh3A++b1q/edQHcKfYivMpHKfZ4xxyjYKavOqAfwpvRkId2NoDmCQF3GL1oF4=
X-Google-Smtp-Source: AGHT+IGNtRr5h7FKCZw+7WnVCzvyL5E5fYqa/ZQ8UV8o0477NgO5qn1rkowwsD4MxI7t1K6Q/j5oew==
X-Received: by 2002:a05:6402:1ed2:b0:5ce:cfc4:1f90 with SMTP id
 4fb4d7f45d1cf-5cecfc42115mr6374979a12.1.1730803415135; 
 Tue, 05 Nov 2024 02:43:35 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5cee6ab05casm1121106a12.26.2024.11.05.02.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2024 02:43:34 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BA52F5F89E;
 Tue,  5 Nov 2024 10:43:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 1/3] contrib/plugins/cflow: fix warning
Date: Tue,  5 Nov 2024 10:43:31 +0000
Message-Id: <20241105104333.2534823-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241105104333.2534823-1-alex.bennee@linaro.org>
References: <20241105104333.2534823-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52f.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

contrib/plugins/cflow.c: In function ‘plugin_exit’:
contrib/plugins/cflow.c:167:19: error: declaration of ‘n’ shadows a previous local [-Werror=shadow=local]
  167 |         NodeData *n = l->data;
      |                   ^
contrib/plugins/cflow.c:139:9: note: shadowed declaration is here
  139 |     int n = 0;
      |         ^

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20241023212812.1376972-2-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/contrib/plugins/cflow.c b/contrib/plugins/cflow.c
index 6faa55d10d..b39974d1cf 100644
--- a/contrib/plugins/cflow.c
+++ b/contrib/plugins/cflow.c
@@ -136,7 +136,7 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     g_autoptr(GString) result = g_string_new("collected ");
     GList *data;
     GCompareFunc sort = &hottest;
-    int n = 0;
+    int i = 0;
 
     g_mutex_lock(&node_lock);
     g_string_append_printf(result, "%d control flow nodes in the hash table\n",
@@ -162,8 +162,8 @@ static void plugin_exit(qemu_plugin_id_t id, void *p)
     data = g_list_sort(data, sort);
 
     for (GList *l = data;
-         l != NULL && n < topn;
-         l = l->next, n++) {
+         l != NULL && i < topn;
+         l = l->next, i++) {
         NodeData *n = l->data;
         const char *type = n->mid_count ? "sync fault" : "branch";
         g_string_append_printf(result, "  addr: 0x%"PRIx64 " %s: %s (%s)\n",
-- 
2.39.5


