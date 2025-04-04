Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3CCC36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 11:57:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0ffQ-0007xZ-Bg; Fri, 04 Apr 2025 07:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u0ffH-0007wi-6D
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 07:56:51 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1u0ffF-0003Th-JO
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 07:56:50 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso20453165e9.3
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 04:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743767805; x=1744372605; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=P2gcOtt+gxPX5fgEaxbtD7A8Eq1QGj6vnJIN/Oj6Jb0=;
 b=HFsCSt2fvE3JtTzTDeSj0l5c6JQ/tuRsVbo/Qa0LyJQgoKcSf989nupJswqVsmsEnR
 IkvvhlIvBA5NqKfley6ZoUk09eDofgyVeFvG+M/FsdJ9pLANDmjBze/9TqM6BQ9oraW4
 rTUH6tl92eQXpYOeSRVpKB03Qz6SFrbbseQd70NFSYhAZlJ4jI65DmKOcXj2ugvMjRgL
 Y+//QazIHJrj7zhWbfKjOIqRnPf6cX2AlCTVlBe2SmBYLIJCAolio1mJfuihFXMZrZPo
 wd6iG4IblEcQjWOQWG4dQO0F78SovnhwfXzijK4WnYbDVa49lJOiV2oUiAAXa++7SFfq
 LFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743767805; x=1744372605;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P2gcOtt+gxPX5fgEaxbtD7A8Eq1QGj6vnJIN/Oj6Jb0=;
 b=OrM7w3+JkpmDXohXE9OIPzun2GWaqVXPyb4buoLM25BAnZF9MFZspTH0xTJXXxe8M1
 +81cvzsLGUsp+4J1lRDILKGSM9q9HTA1BsTqsj4AmmiFxddS4DOAfvgcLIc+ay0R1YcP
 LgTkY1WQacrE/8NZz7uQFMS042kUr5S/1Czb0gMBIn5T1KEad+6EpIBho2dcTgZRL9AJ
 vf1srscD+qT/hFworFn+mH8gvz4nKNlEkeYVCXBStykRPQXRtgmYi/eihZyiJBW3fs7r
 gCtXw65+1m5uq87cnJhwibX43qRVAH7vF8t0fQsJ3YaV24ztH87JaJ0rzgGLtueP4YQt
 qxmQ==
X-Gm-Message-State: AOJu0YzU1CJMGcvZdqLrvIrJNlDxF0L2FzDm4ZdjjxG3oHdWLOABSJuH
 zxRaPMRXdVum3yV5CuZeTiUwFvV0WbiWKsLNseSylWTcB+TwVpR6eLOKezmbRtk=
X-Gm-Gg: ASbGncuJ+S6QGS1mWwxv+ON9ocO7m9YnubArPR/q0SA5kxpLRCeReCZ8KlKF5LNfZ4Y
 79ODU6aLIOs6MsQRI10JlghtlH4VKawvvKJh7H7WPKsEKejlIXjFgMMQS407i/vqxBz3OjnK7eR
 V5RdCih4TjosiBh+7G2wYJwpyRSzxIHZvWIOVLhC2gNJ72GCZrPwdZAWyoL95fkL6g0x8ZuDt1O
 gki3qShY1V5vu7GhaE1MyyhBvqRbXSwm+xIbvp1iHknVf8LEGtHkElcy+iTOPud7BRu93c0wA/k
 LceSAu1EDf4UJAr7KNtrgPRafy3YkVzUrjaC3ku5a5LOuTQ=
X-Google-Smtp-Source: AGHT+IEz0JIxlLAZGzMXEc+om5uh2BgtBrm8KNX+i1iDKiznEpGMuExJihn/yRjENymE26w7WmhMFA==
X-Received: by 2002:a05:600c:5246:b0:43c:f64c:447f with SMTP id
 5b1f17b1804b1-43ed0db363bmr18558115e9.29.1743767805600; 
 Fri, 04 Apr 2025 04:56:45 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec17b46bbsm47078965e9.36.2025.04.04.04.56.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 04:56:45 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 57A075F871;
 Fri,  4 Apr 2025 12:56:44 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org (open list:ARM TCG CPUs)
Subject: [RFC PATCH] tests/tcg: fix semihosting SYS_EXIT for aarch64 in boot.S
Date: Fri,  4 Apr 2025 12:56:41 +0100
Message-Id: <20250404115641.258048-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32e.google.com
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

We don't expect to hit exceptions in our testing so currently all the
vectors report an un-expected exception and then attempt to exit.
However for aarch64 we should always use the extended information
block as we do in _exit. Rather than duplicate the code on the error
handler just branch to the _exit handler with a failing status code.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/tcg/aarch64/system/boot.S | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tests/tcg/aarch64/system/boot.S b/tests/tcg/aarch64/system/boot.S
index 8fbcba757e..81a60b9c43 100644
--- a/tests/tcg/aarch64/system/boot.S
+++ b/tests/tcg/aarch64/system/boot.S
@@ -73,9 +73,8 @@ lower_a32_serror:
 	mov	x0, SYS_WRITE0
 	adr	x1, .error
 	semihosting_call
-	mov	x0, SYS_EXIT
-	mov	x1, 1
-	semihosting_call
+	mov	x0, -1
+	bl 	_exit
 	/* never returns */
 
 	.section .rodata
-- 
2.39.5


