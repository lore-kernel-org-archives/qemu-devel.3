Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48DAFC87FCE
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:36:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwp4-000241-8C; Sun, 27 Jul 2025 04:33:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufwod-0001Ts-Q1
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:33:08 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ufwob-0000CG-Sz
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:33:07 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6153a19dddfso97098a12.1
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753605184; x=1754209984; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p2m3SQZYfWKv+UrChBy8PfS+Pzpe60G8PEJwAKSc7FQ=;
 b=oftDTxRmYvaQqMd+wuchp6BITllrCy8nlGXCcd7gU5N9nN1Jfbryuq2+wQyl+V1HUf
 zMuaRS3XtwW/3QwFiigsl08kNwxQVjr3w9kgzj1KBgUBaQrPdKqMdwu297aci+g6YhQ8
 LhT47xlvvcaYHRTw3DM+LnlQxJr56QAcTv3JdfsEs8t98KHKRjhyhdThYpD0JqeuwHY1
 57be3dGt9yINBFHPynHuVrr0RkVlrW7V2EzSFcq97btNP/hm7vIrkFvtW7S4ZuEgjrtp
 uhzK4IwOjofyQkkDibiVNdfv6xpzCUQmRO6N8AO1SzEHyuZBnTTTlee3WSKVjeSNnkW7
 DEIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753605184; x=1754209984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p2m3SQZYfWKv+UrChBy8PfS+Pzpe60G8PEJwAKSc7FQ=;
 b=AfLwaBihxsde67JSctHtOmwrrreRSVVL5wGJ0Q5grx3MqEjsetew1BFEHJz05I3uGA
 vrtuQHSocAj5Rk1/qpAtB3jct3uuzFucJCfyqtwXNSi/PaQTHrGWUsu6IBKdP33LNuJR
 l7XPbP5xly5xfiy1IOmbinK6cke2lpcNuq45TLny8q9zQf111+LVdCn/sWQy/13TylIi
 lyqcFgHvBv0NsJVf7u4b3LFIn8vQpGFTEOtudI8URz+boqSZSSwdqmm0zBvtTI82dCML
 un08xyL4piP02apAg+vkK6SWQgJHss04vL6TDTbyCH3luUHDKuhH7umIjfjraOEpSh3z
 hCOQ==
X-Gm-Message-State: AOJu0YwsXfYnE2jV/v2rLCGVQM3neddcudPpUb9YlWp6sdqRc6JxqZRB
 Ny/wshk+lP1zamt9lMg/x2UwmvmyIf+ofLTJej1WznBE3HFkqMZzoV14xK6L3ZsplghBkxwjsWu
 uFPRp
X-Gm-Gg: ASbGncv/5VtI6xLQT/7LW60ABPqRBZD+Tn5Xj7jUfITgLnuQzy4Wuy+ZwFPKsXorxIF
 aXQAoVB6hXexzvnRT8Ja+nn6on/t6zO+xYRCUds+FdoF2TZWZlu6WWjygeI42rx+f+HLvpIT8DL
 cJ5mns6fC5LST1pDCjmvpShAfE094hm08jUYwKqXrzeEZoYao3yWCbYiOhvV18VRLDYVz0gaR2X
 2wKzzOibTRx7NyldXKxH42+6g+8NE6r+eKd/wNDZaOBrIq6WcqITVAH63H3vh2PI0i4WkN3Ha3G
 HHlWgNdECPnp/lbf7vzhSHPmdJIKT4hkB91JNpqo+eDna7kpzUSLMspMhtAaUkKZ8u9RZF+nQZ+
 +Y+QnGmK9mdJWnQ5niL6LUlY=
X-Google-Smtp-Source: AGHT+IGrYLbRqVCUsiNGrR5sdZ5thkb+19q6ayql8x2Qjm9c7UhyRAfWKJnNYePIlsp7JFsI2AAaww==
X-Received: by 2002:a05:6402:51c7:b0:614:d585:35b3 with SMTP id
 4fb4d7f45d1cf-614f1bd3616mr6746684a12.1.1753605184133; 
 Sun, 27 Jul 2025 01:33:04 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61500a5723bsm1911048a12.16.2025.07.27.01.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:32:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6E0F35F8B5;
 Sun, 27 Jul 2025 09:32:54 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Subject: [PULL 04/14] docs/user: slightly reword section on system calls
Date: Sun, 27 Jul 2025 09:32:43 +0100
Message-ID: <20250727083254.3826585-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250727083254.3826585-1-alex.bennee@linaro.org>
References: <20250727083254.3826585-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52e.google.com
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

Expand the description slightly and quote ioctl(). I did ponder
mentioning something about why DRM ioctls are often missing but I see
we have the I915 ones so I guess its just no one has done them.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20250725154517.3523095-5-alex.bennee@linaro.org>

diff --git a/docs/user/main.rst b/docs/user/main.rst
index b8ff203c212..05de904225c 100644
--- a/docs/user/main.rst
+++ b/docs/user/main.rst
@@ -20,10 +20,14 @@ QEMU user space emulation has the following notable features:
 System call translation
 ~~~~~~~~~~~~~~~~~~~~~~~
 
-QEMU includes a generic system call translator. This means that the
-parameters of the system calls can be converted to fix endianness
-and 32/64-bit mismatches between hosts and targets. IOCTLs can be
-converted too.
+System calls are the principle interface between user-space and the
+kernel. Generally the same system calls exist on all versions of the
+kernel so QEMU includes a generic system call translator. The
+translator takes care of adjusting endianess, 32/64 bit parameter size
+and then calling the equivalent host system call.
+
+QEMU can also adjust device specific ``ioctl()`` calls in a similar
+fashion.
 
 POSIX signal handling
 ~~~~~~~~~~~~~~~~~~~~~
-- 
2.47.2


