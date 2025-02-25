Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30709C021B6
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 11:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmsoU-0001fV-G2; Tue, 25 Feb 2025 06:09:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmsnx-0001XY-Ae
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:08:50 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tmsnv-0007kI-OZ
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 06:08:49 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4399deda38cso33192155e9.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 03:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740481725; x=1741086525; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cXGP6wzkZErmn2F04TQmNlmyR3CeFAZYW4eH79gDg7o=;
 b=YuWHG7bvBaWPqP7QT3rkvU/Zv6mmG8v5HygVj3dPKRlKn05E/yUZECzsIzhTbfeGhz
 WAMykDpiYRK15O11cQkhXgaW2lOIcmWsIccXFp9lswMJ5hPMyLjPHSh1SYQbQRl73Z0H
 yPmTDEcZ2k81oIG1rzGaq02lZ0DMy6OEtABDZp/K0axp/3VO16IQeeAtuOR9ZbgYgaFd
 zHhO47l16HU/Syzyrv0QZv8pqZ5JmH1GqKk8W28mYFgBTGA07VF1j1f8bSyviJFIa9vJ
 OZ99/KrmfLqBaieNTcQdenRyMtIuCTRbecoerfeV5Mwv8CmBjNzDUt1hcoXbbF7XoQKo
 C8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740481725; x=1741086525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cXGP6wzkZErmn2F04TQmNlmyR3CeFAZYW4eH79gDg7o=;
 b=doNRiU2+f7BSDVenPFDR2I6KcF2POaOZZRh+F/HB0+btHExw/xvPZ4/ZI7oBfh1Fvr
 1uYIiSmGpvt1/0liZE5CULO9Mg8e0FuOA99CiKBMMbaIz8cI7W7/DvPc9dHP5EpVsz0Z
 H4eUzqR5j1RgCWgvUjcR55evkrTtWqG8G6SZ2wbZ+x1qkq35Fi+F4PYKJZzSIj54d5bl
 JmgOmSYgcCh1imCinv6BiKElvcjlk4frWz+TQNONc7Udu/RPROOaETsVlPbSNN2pB1D3
 Ej4uJgJbESIVGnGEk8Zk+oToE3dqMd8dutEuyp6zlsW0tnOdITUBXjd5Iqf1evqiVN44
 Q9WQ==
X-Gm-Message-State: AOJu0YzhBzlgSsEX97sNWcHNpcaM6Gi7E+Txw5CynqIvYjKnEQZ4+s85
 /nzvhaQSE5/zmTauRaDlZlJ+gcXNEL2YHwK0K7LnCrr9V6+s6L29FEfvynXqWE8=
X-Gm-Gg: ASbGncvqfvJB/yPfgYic0JuZ4IZUKG/L6L70Xpx/ak3bkc3jG2LjwA6QoiftF9xFKpq
 hBRej/hzS3cxVjat7Qajj/BLoEmJsTATBqqRLr+Eo0ZOlvGpApPWjtTvrMLNCsvTvUoCduSDrVw
 8mMgtA2LD0J3KrwH0E1ssb6qNgSjX7a/tx1CVQfi8tvKRNIab+O3r+MQtFtmM+n3z0raiZt553O
 8jGFWnbEWFAJt8VGfcDFhmgVdg1qSZpJCavT9x53tV3OeBGDNIfTqGLq1R7xXKVw4eXi83urHQu
 fCvak0u4Uwth0mn68rc5RlYtQ3tP
X-Google-Smtp-Source: AGHT+IGsy/RqBFd06tETCtxhAw5hpQRYwExwI8EikFRM0h/sw6AoS/YvKex7xdT3HiD0yC4o1cgPNg==
X-Received: by 2002:a05:600c:4753:b0:439:9a28:9e8d with SMTP id
 5b1f17b1804b1-43ab0f313a0mr24678915e9.12.1740481725626; 
 Tue, 25 Feb 2025 03:08:45 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b02ce65dsm136562215e9.1.2025.02.25.03.08.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 03:08:44 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 41A355F9D0;
 Tue, 25 Feb 2025 11:08:44 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PATCH 01/10] plugins/api: use tcg_ctx to get TARGET_PAGE_MASK
Date: Tue, 25 Feb 2025 11:08:35 +0000
Message-Id: <20250225110844.3296991-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250225110844.3296991-1-alex.bennee@linaro.org>
References: <20250225110844.3296991-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Requiring TARGET_PAGE_MASK to be defined gets in the way of building
this unit once. As tcg_ctx has the value lets use it.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 plugins/api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/api.c b/plugins/api.c
index cf8cdf076a..10b258b08d 100644
--- a/plugins/api.c
+++ b/plugins/api.c
@@ -287,7 +287,7 @@ uint64_t qemu_plugin_insn_vaddr(const struct qemu_plugin_insn *insn)
 void *qemu_plugin_insn_haddr(const struct qemu_plugin_insn *insn)
 {
     const DisasContextBase *db = tcg_ctx->plugin_db;
-    vaddr page0_last = db->pc_first | ~TARGET_PAGE_MASK;
+    vaddr page0_last = db->pc_first | ~tcg_ctx->page_mask;
 
     if (db->fake_insn) {
         return NULL;
-- 
2.39.5


