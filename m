Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E5FC3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 11:05:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVqqA-0005os-Mw; Mon, 22 Jul 2024 07:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqq9-0005i0-0z
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:04:25 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqq7-0002S3-Ct
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:04:24 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5a2ffc34431so1360469a12.0
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 04:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721646261; x=1722251061; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6Bff66en4q3ciCjIte8eGShr6vFbC86/IAqQsdiX7yI=;
 b=Y6pzBmek71k0omMZ7EkLieRtQ76+lwiCBDt7YBOgo+0eC5CTZfkA0+RKUu+ZiJ+jko
 d2rW69W0qddiSEW6II5vl1YY/UiUBYmVb36IoSf+IFaGTvPYmDXxMo10nK4IVQdx/lXf
 dAIyW6XP/791XE8sWS+6r6KgQNEnzxP1jSOefaoam9ezHtC/Ltbb7FRL+ysJKR7+w62O
 mwDGUF6NJ8ORdscof6VSl8TPGnviGNlV9FR658JbhVkoCsCJfBitepYLM2vqbhqzpZ+5
 EZ6cG+UcT7dqt9INPwXY2NVtyvYPm/a8LlKky8bYTu/lVcNpcBmP24lblKzysckX/dje
 Tyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721646261; x=1722251061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Bff66en4q3ciCjIte8eGShr6vFbC86/IAqQsdiX7yI=;
 b=akjfgD5NkINjtMBcJnwfF3aCdoUXRvtSDAYwp7V3YGjDsH8vH8ZP5mAsb47r9u3dT/
 53QvJlGCifltRQGH3N443TQ/YV9Vp/8PN6HSkVuwOAqYyA/zA66J1q8yZlm8vNtVlo0V
 Rod8SgipD4zqpodxeSv+8kKp7w1yg2V0tazN+fl1hW69KThAdM8/cy9MEZqN+eL5KbmJ
 TiAAwPYl8ZDt8wes7svh3y7uEkIUWbCJBueYI29jLhOIbxbznnf3/a7T99SrabnAX+E/
 qh5qMZTicOdxU2kdeCUhI5l8kQN4MNTi8q41FcKSS2ImJxPgGBMIv+Y2uTtx50xI9Rbm
 FA4A==
X-Gm-Message-State: AOJu0YyLrgJRde4lfcG7aAkIVcYvtCubspTd3pGd236+yLVUs7bevNeb
 mv49vUrmKPpi8mNK9K/VND9ilazoRUUWAzcm/nYlzdIauKhutyZvm7E7IP1ClOk=
X-Google-Smtp-Source: AGHT+IGvIaqImjfOHU4Cznapr8tkFtilw7FTYVC4J3FFCgz7ZWLVcGqUbRVC94rcLHdJxHCfnFOONA==
X-Received: by 2002:a05:6402:3590:b0:5a1:f9bc:7f13 with SMTP id
 4fb4d7f45d1cf-5a479f4fe93mr6178268a12.22.1721646260687; 
 Mon, 22 Jul 2024 04:04:20 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5a7344dd630sm2232918a12.54.2024.07.22.04.04.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 04:04:17 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 400CF5FA03;
 Mon, 22 Jul 2024 12:04:14 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20P=C3=A9trot?=
 <frederic.petrot@univ-grenoble-alpes.fr>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 07/16] plugins/execlog.c: correct dump of registers values
Date: Mon, 22 Jul 2024 12:04:04 +0100
Message-Id: <20240722110413.118418-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722110413.118418-1-alex.bennee@linaro.org>
References: <20240722110413.118418-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
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

From: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>

Register values are dumped as 'sz' chunks of two nibbles in the execlog
plugin, sz was 1 too big.

Signed-off-by: Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240620083805.73603-1-frederic.petrot@univ-grenoble-alpes.fr>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240718094523.1198645-8-alex.bennee@linaro.org>

diff --git a/contrib/plugins/execlog.c b/contrib/plugins/execlog.c
index 371db97eb1..1c1601cc0b 100644
--- a/contrib/plugins/execlog.c
+++ b/contrib/plugins/execlog.c
@@ -101,7 +101,7 @@ static void insn_check_regs(CPU *cpu)
             GByteArray *temp = reg->last;
             g_string_append_printf(cpu->last_exec, ", %s -> 0x", reg->name);
             /* TODO: handle BE properly */
-            for (int i = sz; i >= 0; i--) {
+            for (int i = sz - 1; i >= 0; i--) {
                 g_string_append_printf(cpu->last_exec, "%02x",
                                        reg->new->data[i]);
             }
-- 
2.39.2


