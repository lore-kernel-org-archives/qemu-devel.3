Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BB74CAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 09:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0czE-00022d-5q; Mon, 22 Sep 2025 05:37:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0cz6-0001tM-3h
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:37:24 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v0cyz-0000c8-Ma
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 05:37:22 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46b7bf21fceso13542265e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 02:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758533833; x=1759138633; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tABHb0SIUKkh6uzz0t7I0iXZ4IfcRn4F5NgGsBOTZrw=;
 b=Khl+jliPAIywrHBFL75d+hjNd6bWBdoDKxzkPYuizrb/jOPBhdiSSkW8NoPfbYDjIs
 CkfRdZkbGAEj2nJD6Dy/TP9tqFXfO36kUDWjm7j2sO4WDoNWhq2gMENGw/i0XL+t/RIT
 ER9HKiTH8mw/wTiMdYMQR95a+pVxbontKvNdhe3kv1DPARgs1ku0hE2EkQX0qsxv+JDk
 lOblMQ7ssKYgzNL6hEyXLGlRsaRMuMYMl4bP8CC1izsli7XqTJZsi0WG0vSc+dT3c2Ow
 Fyt6rlrggwXSmeC1dTgnv+BLus7SOxaffy+dC2MK0c0PXYxINDhVQefhksjVWkTN4R/M
 edPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758533833; x=1759138633;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tABHb0SIUKkh6uzz0t7I0iXZ4IfcRn4F5NgGsBOTZrw=;
 b=viywd8qm+78ZT8X2nHOUuX9ij00Dj7jdtKGExcTzTbyB0EjB6UIZ2RwX+HGBU835k/
 zdpPRCGzzTVO7xLUCH3OkJU77pOUeXD6abDCL4Vj12VMzxkPzxPL0nA/ZEt1V45uKBfC
 Xn+pzOk9gTA1VYZCXI/7tezpFbrFPOgMmIhxJ+mYLZo0rh0WprlG4Wc0/gu3ppAs/jMK
 7V1EOhz3b6NWBoRBwqy2cRbyNFEauOXOO058WXUQvhRc81xN2QIw98d/F9sW1BKUDuoO
 2wtfbnHRAqHTiuWm1MUAuMbya6VEqCrrPjW/p1uNyYOgRjdhQFbp5AR/PvI5+pUyXWjP
 6IBA==
X-Gm-Message-State: AOJu0YyUxUeKDzlCJYCcd+K9AtZnZA9RMCYFzLJzIe725CSHSogNkre6
 OiBIcr5uESi2yfE08Gswwop/m/9sYzMHC+e3WuTL5Q47xd1bcAv4vfoWbcIVr/ezPH0=
X-Gm-Gg: ASbGncu6+ZtI2QLdjsBlZMfbdOn6b7uOUlM83qVpZuXrzPeFRpaOTvFLZjDrj6GDTv5
 NCIiLVPAc5LlfzAnJX/yv1eLbwHrYEF0Sa1Hql/hlfVNk4S+xLrNAPl/B7ZblUQSdArgyMtVd/K
 kAQuj0gs/asQMe9yRaaOx59pWHNYdymumfi9iPbBvJz1wnDYmqZyHQOKmyVRvllYBgIOZuVnLpq
 jUPijwvosX9dAq/0CxQTysLrzDz8Uc7Sdgna37Rjh24ubbHu1Bh4+C6/OWsaQBW3N3jGkbyXkDn
 sqRvmjDjchUHOKnc8vU5MG1LjtF0GdvSy+ZaiWRFD+gexZKsMgW/i133Nq7aOyC4h+zH4erF+ZT
 E2ghpy6ijQGXlf/QjHPUBMoA=
X-Google-Smtp-Source: AGHT+IGKYLCqTBbnTaHG0WoqROvB3mb3XtAIclhYxe32fQ7dUvSfxGOnGECyX9UUbZkMBeFeQmxJtQ==
X-Received: by 2002:a05:600c:1c0a:b0:45c:8e6d:a45f with SMTP id
 5b1f17b1804b1-467ee3057e3mr113776025e9.5.1758533833241; 
 Mon, 22 Sep 2025 02:37:13 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4613d14d212sm259930315e9.12.2025.09.22.02.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 02:37:12 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 987D25F8B9;
 Mon, 22 Sep 2025 10:37:11 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: [PATCH 01/25] docs/devel: fix typo in code-provenance.rst
Date: Mon, 22 Sep 2025 10:36:46 +0100
Message-ID: <20250922093711.2768983-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250922093711.2768983-1-alex.bennee@linaro.org>
References: <20250922093711.2768983-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/code-provenance.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
index b5aae2e2532..af5d7349e12 100644
--- a/docs/devel/code-provenance.rst
+++ b/docs/devel/code-provenance.rst
@@ -331,7 +331,7 @@ ChatGPT, Anthropic's Claude, and Meta's Code Llama, and code/content
 generation agents which are built on top of such tools.
 
 This policy may evolve as AI tools mature and the legal situation is
-clarifed. In the meanwhile, requests for exceptions to this policy will be
+clarified. In the meanwhile, requests for exceptions to this policy will be
 evaluated by the QEMU project on a case by case basis. To be granted an
 exception, a contributor will need to demonstrate clarity of the license and
 copyright status for the tool's output in relation to its training model and
-- 
2.47.3


