Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC576C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 15:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPku4-0005kl-Hp; Fri, 05 Jul 2024 11:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPku1-0005iK-IO
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:13 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sPktu-0000Qb-9p
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 11:31:13 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a724a8097deso220441866b.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 08:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720193464; x=1720798264; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=URiLbq4/9zVnXxv5mThe5iKKCIjw63PUulDUIw3Un1M=;
 b=yZFprYl5PuY7VKLq5AUieni/2MB2Uu93HQhE7S0QNArD/LBHD59O52KVG0RpA3z9c+
 9+8ZnqHlPNFP8l2PnVwo8K7v3JSYb+V6iKZvAPXSl3gm4wsBIA9IJfzb1NspY3xbFyza
 anlDv4boUeUhu9HEOqMRaduPxdqE2kR9tAPeG0nm3orZ7aK2pxAXA1/3MWUk9nSZtheV
 cfQiPzDs1vpfeER02d/AFgnp58R+pEVOR/hmCWCjn5Dn8ICuVUNtczFtm1ttthMs17i7
 IjqVja/8gtbk3PWYR4K+I4e21dxWWtF5VcPz7HMSRwKqwBdevfVx4vsqTTooVf9TaVxs
 nLxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720193464; x=1720798264;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=URiLbq4/9zVnXxv5mThe5iKKCIjw63PUulDUIw3Un1M=;
 b=jHQt2ph5IX6BIzi7OXqj9GsgOQipC5yAVJOSUYpqOO0dr76ban4BAv4Wi7GW9jjYWG
 yq1TAoYyN18GosomgfaGCcs6ZOLuzrANWYmn4u831Mp2bEZRKTjOpLry1KIzoTP8euqp
 578z7Y0fpxhItKGw1gEzwJuD9kCHID+QHEjRcK2iYcT/BU/OAP8UvLvHt7l5SrJdRzfN
 cHt6ekbvF+Ynl29G4LPtJR3j1EOXo+uRpgk1i32Kq5h/WxCh6u/3vPwqIXtpjYCv3cWg
 SyTkelU7Eo1r7NNzhnFPPFVlfnqzwTSOVqpnzrhAN02ASXfpQMKrPHPA03BgeSIxdTK1
 1gZQ==
X-Gm-Message-State: AOJu0YyKbdU5Q1g+jIDGVszCZz2cx9JxLiuckMMbHyqGTHc+cBT42yDF
 qUewg7zmz3ZWJHB/vZfNcPExvIXNfpkPJ0hd27iBZv3E8YgcAXTIkjcLy9ecdf8=
X-Google-Smtp-Source: AGHT+IHDTwsRfjq5/r5PvnJWvtW0w8JOzKVFK74WhJK/L24j9bnKL3IM5gVaKDOTIHeWkzzf0tcAPA==
X-Received: by 2002:a17:906:34d3:b0:a75:3f38:e0a4 with SMTP id
 a640c23a62f3a-a77ba7082c8mr373285266b.47.1720193464292; 
 Fri, 05 Jul 2024 08:31:04 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77c8e18f32sm78421466b.95.2024.07.05.08.30.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jul 2024 08:30:57 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id BD5F35F9ED;
 Fri,  5 Jul 2024 16:30:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [PULL 08/40] tests/tcg/aarch64: Drop
 -fno-tree-loop-distribute-patterns
Date: Fri,  5 Jul 2024 16:30:20 +0100
Message-Id: <20240705153052.1219696-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240705153052.1219696-1-alex.bennee@linaro.org>
References: <20240705153052.1219696-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

This option is not supported by clang, and is not required
in order to get sve code generation with gcc 12.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-Id: <20240630190050.160642-4-richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240705084047.857176-9-alex.bennee@linaro.org>

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target b/tests/tcg/aarch64/Makefile.softmmu-target
index 39d3f961c5..dd6d595830 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -39,7 +39,7 @@ memory: CFLAGS+=-DCHECK_UNALIGNED=1
 memory-sve: memory.c $(LINK_SCRIPT) $(CRT_OBJS) $(MINILIB_OBJS)
 	$(CC) $(CFLAGS) $(EXTRA_CFLAGS) $< -o $@ $(LDFLAGS)
 
-memory-sve: CFLAGS+=-DCHECK_UNALIGNED=1 -march=armv8.1-a+sve -O3 -fno-tree-loop-distribute-patterns
+memory-sve: CFLAGS+=-DCHECK_UNALIGNED=1 -march=armv8.1-a+sve -O3
 
 TESTS+=memory-sve
 
-- 
2.39.2


