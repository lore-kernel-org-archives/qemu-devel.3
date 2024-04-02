Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CF8CD1284
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 14:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrf5q-0002cT-Qu; Tue, 02 Apr 2024 10:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrf5G-000229-6y
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 10:26:00 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrf5C-0000Et-BN
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 10:25:52 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-341c7c8adf3so3638553f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 07:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712067948; x=1712672748; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OjdzjLmAnFvDVsex65dJCtrM54ZeLuGIMveMRxi+eG4=;
 b=BVKZ2FGUPPvYTq2jCPV4KLtvC605Lsc2lPhk3LPf123LT0yE2xwSAOdFkdH1yUAYDA
 7vXtkfuh/XEaqcenP/b1hDcPikJ8ACgxRc7zSrGrf+672J08MqmK+jMeJRF+WLfzdVRM
 qBXxSBResep8M9lQyQIPjAWKCgOSt3E411XDZH/PdHwq//CjWYX8/JCi2/EGmgYlGkfM
 z5rZUcaXTx2K61uePDhHLysCDhxNaQt9yF690jxGci3JKE7qH5kFzERYZ+Dcf0wfYymn
 nSz24LpWO2//jXNITt3jobVGF5pZEY58nn8sSE0qnWrvOH3fQya4mTjTYE0ejSUSxwUT
 vOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712067948; x=1712672748;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OjdzjLmAnFvDVsex65dJCtrM54ZeLuGIMveMRxi+eG4=;
 b=X34kkgp592fC2tLoTfGA538QhzFErdNHkAEWv0SV09RrspLzjENlT71yIa8XFH/pXE
 p5WVN9ouJw0KOQdnacxpNj1Cxmb/Q5wGI9I6YIrmFDh1NTN3Bv6SA8KhHZaqxVmcXhn7
 yuyF+TUitaRkWqiyY8e1sjs3C5zxeeQnS6vRA5lTNNuwhWItvNIC3mCjvb6yLiQXyYBf
 XIQcKu7sxzJNyRgDEfroQakvKVpip4lKNlTNgWjtFBVhm6bPdAIgmDVYNxNbOddZSV7n
 QUHa4YuTBRL9j0gas6MJflXB97oaFrxd7Sj1KNLBWuCCe5UKEvDW/cBesnpIpSRkMVtR
 0HnA==
X-Gm-Message-State: AOJu0YyCIdBcj1MNrG8InyiARH3yvDxQ0xfnakGajcDJvocUfkFR6D7z
 UyZDl4yoNNOUzUxeoVC4EKVuMB9cTcW94TVWdb8CsY4xCrdgVSkIHV6+4z5zJExU6FS5ZoBPWA8
 6zXs=
X-Google-Smtp-Source: AGHT+IGYcAMyT0ce3AxxAxntLH9Goeq/9HJoQOd5CAofmb0FvpxhwPE554XSFu0VKUJa09jGvh1mDQ==
X-Received: by 2002:a05:6000:1a8a:b0:343:39a6:45a1 with SMTP id
 f10-20020a0560001a8a00b0034339a645a1mr9792770wry.59.1712067948073; 
 Tue, 02 Apr 2024 07:25:48 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 h18-20020adff192000000b003433a379a51sm520722wro.101.2024.04.02.07.25.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Apr 2024 07:25:47 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 11/15] plugins: fix -Werror=maybe-uninitialized false-positive
Date: Tue,  2 Apr 2024 16:24:26 +0200
Message-ID: <20240402142431.70700-12-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240402142431.70700-1-philmd@linaro.org>
References: <20240402142431.70700-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

../plugins/loader.c:405:15: error: ‘ctx’ may be used uninitialized [-Werror=maybe-uninitialized]

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20240328102052.3499331-15-marcandre.lureau@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 plugins/loader.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/loader.c b/plugins/loader.c
index 9768b78eb6..513a429c57 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -390,7 +390,7 @@ void plugin_reset_uninstall(qemu_plugin_id_t id,
                             bool reset)
 {
     struct qemu_plugin_reset_data *data;
-    struct qemu_plugin_ctx *ctx;
+    struct qemu_plugin_ctx *ctx = NULL;
 
     WITH_QEMU_LOCK_GUARD(&plugin.lock) {
         ctx = plugin_id_to_ctx_locked(id);
-- 
2.41.0


