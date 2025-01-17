Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC388C02188
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:47:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmdy-0002GX-EB; Fri, 17 Jan 2025 08:44:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmd1-00012Z-3i
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:15 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmcz-0002HD-H3
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:43:14 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d3cf094768so3703051a12.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:43:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121392; x=1737726192; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4xuiCI7PA8RfyoMtUNzdFe3eSRNq2phrVz5fhVl8TLw=;
 b=d7qzB0Dg+c5stXWn2L321nKNY0XRVaQwlEJj7bHChaS6YvvIV2dh/bGRBM0AtsPi1n
 VVMyonDB20skRHdrwTeKvniHjGV9VQ082ZFJr0WHnSYhRiFBY7IPku/7ka7Q+MNh/BiG
 EakPDG7WsxbWW/fH2Hk+wokLTMEd8d7ODhlwijPJ5CAn4VW2vGdcKfh8nDZTugVV3eDs
 cHALDCdgJ8EfGjDTNHp3hkIec5fAiH+UlAZ/YnumfuRINxpNjLTBiW44/xsqNL2XCHm8
 1v0ojXQ5SvNP7Ckl2UdJGLK5HgP7NZJMnaH8hH4xJzKauh5bstafW4W5MR/+3n2tgA7+
 UOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121392; x=1737726192;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4xuiCI7PA8RfyoMtUNzdFe3eSRNq2phrVz5fhVl8TLw=;
 b=athHIcwTjT4tbChum8oqEHlmQSlb8rJaSPDRtYuBufRqZb+l5zQZhuP9pV8dsHkbrP
 FBK4h/llPCvMgsDwF3/OGpDB33lvzUWT/TlNJyRxsbij3ihRcgiFfevNktZH9qgs6986
 mBmE3w9T6dwY2Qmcb0WTXIfiz3CxcOlFKc5XcsHeQr00rtmZfAmDZvUwbQe/H8O2PhwU
 5UY5JvNVyrP+tbuXPkLr6xLdLfrHYjfWoCNovR+i24zk8aTi4P/DsCgAUaPYLMKw1wHb
 MdROzHqPCe6ELXdi5xwpXRR09F+mGDRsymhf3gSN/sC1RG1GNAXfHop/+XtU36z2ZN5a
 bbDw==
X-Gm-Message-State: AOJu0Yya0m8MVw7TSFphfbLyOwvaT9OE1v/0vQiNZeQjnCcUBlCnJABS
 lTFhAs8oaXQIypo+SSYMZi9Zbe9GhJxxBV8cWeMW6t6jnkPwsS9XEDUJW9YCBgw=
X-Gm-Gg: ASbGncvqErAAD/uhj04SeEBjtUpLlH1b4z2idFV/Ze40xGw8ta1udTjZ+Ap2QRUmCZ3
 oaFy2RBjCRcICCIWZk5I0lz81LrqQM736HZIK0lv8FSJPL+Djk5KeuqSLH+1OlEmOBZwQLq0G/B
 Fsico2itVtjSv9KZ9b6Tgd1exoOkBQG6DRxvAZHHKrJdGNKsI1sqUjCSvNfjW27aix/eH04d3xc
 U4gzaM6NFjEfZii5VSQEoKN5HWcPYwovr82zElFKH3ZGPDhEFRnOHA=
X-Google-Smtp-Source: AGHT+IGF+Gm/f1PNYFKM83X+vDlXCClrRtie2cNqA1eMIbmFB+odbv9zJX0hBJFbVVvLFQgugzrmqg==
X-Received: by 2002:a17:907:3e1d:b0:ab3:974:3d45 with SMTP id
 a640c23a62f3a-ab38b0a186cmr298609666b.1.1737121392001; 
 Fri, 17 Jan 2025 05:43:12 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384ce0f58sm172496766b.48.2025.01.17.05.43.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:43:07 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 7E7E26083E;
 Fri, 17 Jan 2025 13:42:59 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 27/37] editorconfig: update for perl scripts
Date: Fri, 17 Jan 2025 13:42:46 +0000
Message-Id: <20250117134256.2079356-28-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x530.google.com
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

We have two types of perl scripts in the tree. The ones from the
kernel are mostly tab based where as scripts we have written ourselves
use 4 space indentation.

Attempt to codify that in our .editorconfig

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250116160306.1709518-28-alex.bennee@linaro.org>

diff --git a/.editorconfig b/.editorconfig
index 7303759ed7..a04cb9054c 100644
--- a/.editorconfig
+++ b/.editorconfig
@@ -47,3 +47,16 @@ emacs_mode = glsl
 [*.json]
 indent_style = space
 emacs_mode = python
+
+# by default follow QEMU's style
+[*.pl]
+indent_style = space
+indent_size = 4
+emacs_mode = perl
+
+# but user kernel "style" for imported scripts
+[scripts/{kernel-doc,get_maintainer.pl,checkpatch.pl}]
+indent_style = tab
+indent_size = 8
+emacs_mode = perl
+
-- 
2.39.5


