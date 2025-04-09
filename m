Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C122FC369A1
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Apr 2025 13:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u2VLN-0003qa-Kf; Wed, 09 Apr 2025 09:19:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u2VLI-0003pF-6Y
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 09:19:51 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u2VLG-0001OK-F9
 for qemu-devel@nongnu.org; Wed, 09 Apr 2025 09:19:47 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-39c0dfba946so4317000f8f.3
 for <qemu-devel@nongnu.org>; Wed, 09 Apr 2025 06:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744204784; x=1744809584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GgHci5TdeWB9Jnt/+CYG1K2MnKTxniGuWHN5F+y5RDQ=;
 b=iLyAwMoXtXXSEVbNprhkeumXRGhMgA3xlmFQuZyr3YXvGcJAyu5+Cm/HEDs9mSAaRi
 dZGP/TwLeEdF3gnD1HdPuR4NLbbT0XcyxvIaQOebdcJeWDlVdAv7ghGR+bNJVi4qc54q
 kWvHXEzRMyRhGUmgLjcyP1yS1uWuCW7m4bpPE7TMOh38yWQuUn4ehoLoFnQdr7Uli1ta
 bYymgSJmrsKre+l0lBSmZk6eUiaNINR+cOU7mHeG7O7ZHTIGbV17Ofx670T9Vg1Ldd2M
 KKFDGWqCqmvnGKiCrrFHyWGSAIkfIij7n4ImJEq2mKGLrxPQOcHvhUX2KhcdgNFDeIu9
 8WKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744204784; x=1744809584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GgHci5TdeWB9Jnt/+CYG1K2MnKTxniGuWHN5F+y5RDQ=;
 b=K4QkrV6mCBsUgydUj+W4XRxqSH/GLO5Rvwy6f8S2aO4KlVpmmfH0VwomZtwtWY09gs
 ty7QcrhdyEK7Jovjmnxf0uuRt7iyhwQp6N/Bwexl8kStcF/9TCYMNPq9JKXN0I6/TSzQ
 1Gl02ydUNPjRfZ41EJ9OVmfo9KsPB5mHeFCv6pMcdC3/FW7zpiLvG3HOf3EQVVhTsYK8
 QGHRMtahQIYVMqs4j9JzhgH/ykdwm2NG0EYd6dIuYhfV0DSTtCOUJYE7yWfJQonLK0iB
 y8hFzm99oaGIOxKm30qt4pQcD1e8U2pMpLXIb4XFNpt329L0nMgKYXQ13fs2+nNq2y1p
 0Q2Q==
X-Gm-Message-State: AOJu0YyNLcg8UKRG7X8dKMg7as8fx9xB2oYDChBMQNXxbA7WzQunWjwq
 e0HeWisRf46xPROfMwhrx8Je1VrxmpJWTcvI7mhQCND6MqB4V8/Zz/Ho8aMWEpY=
X-Gm-Gg: ASbGncuGbo+bZtqnCwCz/9gwCsnNLtC7F5Ftj6llUP1wAMOJq3JUsX+4chIygVQrIW3
 ZDrbpPPfW4oh4m1J0vmqx5t4RYSNxvcIxeU7iA3yXFX+5zmybXNaZekYh107l63HYXryoiqx++y
 WzA9PM5+VVPiREjm5+wql5nXKSUbMkrUG3RgvTSKPfhU7Zb0dWqghX/zO3GGqbtQxKyfL85A4OY
 XDZagKbscf51qz6MNPOUNk73ufXezZIjjiEI3BTjmce6yy+aozQBhqYdAkvKvSBS9gbi94orsyg
 LVKINF+7xMaBbYkJvwtkcGfEGhfkrfJOEFmAyqCzwhbZmLHSVSMMMw==
X-Google-Smtp-Source: AGHT+IGn9rx5/KUUNL8CkgqvjYLC2lH0ye+ydSVMbj827edbwDuHbC/pV9tOl4VF8MXq4YtRsdULfA==
X-Received: by 2002:a5d:64eb:0:b0:39c:3107:d68d with SMTP id
 ffacd0b85a97d-39d885626a2mr2229181f8f.49.1744204784141; 
 Wed, 09 Apr 2025 06:19:44 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39d893f0b82sm1626392f8f.66.2025.04.09.06.19.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 06:19:43 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9C4D05F9E3;
 Wed,  9 Apr 2025 14:19:42 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: [PULL 2/3] plugins/loader: fix deadlock when resetting/uninstalling a
 plugin
Date: Wed,  9 Apr 2025 14:19:41 +0100
Message-Id: <20250409131942.1706923-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250409131942.1706923-1-alex.bennee@linaro.org>
References: <20250409131942.1706923-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x432.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Reported and fixed by Dmitry Kurakin.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2901
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20250404032027.430575-2-pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

diff --git a/plugins/loader.c b/plugins/loader.c
index 7523d554f0..0d6e082e17 100644
--- a/plugins/loader.c
+++ b/plugins/loader.c
@@ -370,7 +370,7 @@ static void plugin_reset_destroy(struct qemu_plugin_reset_data *data)
 {
     qemu_rec_mutex_lock(&plugin.lock);
     plugin_reset_destroy__locked(data);
-    qemu_rec_mutex_lock(&plugin.lock);
+    qemu_rec_mutex_unlock(&plugin.lock);
 }
 
 static void plugin_flush_destroy(CPUState *cpu, run_on_cpu_data arg)
-- 
2.39.5


