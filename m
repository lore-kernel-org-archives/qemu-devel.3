Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCFEC369D7
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:00:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kql-0001gE-BV; Wed, 23 Apr 2025 20:54:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqO-0000zx-Pn
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:37 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kpz-0004gs-5T
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:13 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so477718b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455990; x=1746060790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G9WIPyymM2ElF4UPWEqRA70/pK5WAg/CnC/iZWyOuxk=;
 b=tDyFJEEM67562oa4ypuQWdZdgG5zjowSdHqxR/QibStnNy6BZ6TZ0DHyzGB9e3O+aW
 kfByvevPdKPKRW8yoJGmPkV8w5rYdZUniZ9oKC599VOb77ZqGtl4Av1ogOBMjNGrnCOh
 8KR22rNoyB40hJxnF+PRgb13+R6tlhGNKs+1EYzhOUMtIS8ghWPhFu0eHGzsUfkPg524
 7RmKr6VeMi2rW/6yKExYldcHbwWzEWiUXGo82J8XN5sm0gZTlvzU/O4Tclo2s/8Dhvfs
 zO1lfQSRqblpA8gd2JpQJF6SqAO0eRVrGZThkVhTS5KXwkTIubEGua7/vp4ujTA8scDL
 i1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455990; x=1746060790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G9WIPyymM2ElF4UPWEqRA70/pK5WAg/CnC/iZWyOuxk=;
 b=mDuuonxpV/3aKQGEwF2YaRmneS+Nj/mA0O+qGhtTMbCpoAzP6Ync91sFgjzhidlGM7
 kLtLgCEGiFr/c1bFzmiZmyRUF2S4Skl3viq54BrfEAL5Yyp1HdxW8UPzNCb3EYJh7vEt
 qB560i/t69U1kqoiU/4HEbJRr1tL3R5Zx3FuMxFsY6CHmVYP22P3P7X7oxz9L7RYeHK9
 xvApKworLltBP/TiYA7cc/r04AQt6Wex7q15oqZDuqu9q0KLeqb/ShfhxO44l14R6Ufp
 tQtWZ8/KYEvGY5Ie4gYNVEsmjXVp+fqI5RN9Pk6X9zLLaKl8NYJZjj/s0bjU5/BtKawb
 Q5rg==
X-Gm-Message-State: AOJu0Yzxt7nz+qZWWtUv2759f1+mTldyS3CTxzVhZWgDLCkvJzO38aey
 TbzC8VZClPy9MDQdOTj4Z8pNbOREnFh+/fgrpqyHRZC8+a7x8gFtLRNRtypq7CHPp1NcGN3dA9W
 w
X-Gm-Gg: ASbGncujOd5H8aB8kKZe9ZbmUvNyw5UPu7uvL9lPZOx6T90J6f1NOVlKN2l+sh/VLtR
 aA24s/j72+Cn7wyUujDzw2gQbjyvGsXgIQ2GvoTzQbkmDcckUDD8TZTAtHMv3HwCdQmJ6pA3vvH
 FMfYP649gr2oVH82BnhQiJREIHx40jpVsYDPg/oXnP1rwJSfKgUif1Na7gc3+p2JSxIPYh2X8A1
 PXdXZIApf4G92lEzyWurUGhe5SMWf/1whHrxv8H9OhjCAhWfAl+uM/GNXBjOO3x2RLUZf/ObSmJ
 xHIuOaw5hZHYysVLDw/BYhscQyTLx+4Wu1q3xM3UmQNp5pKI/+xJ5ZDJ7xt3XAXpDT4DK0sDAwo
 =
X-Google-Smtp-Source: AGHT+IEWxJl050k8pmWBrls2go1GEKGzxNo3/TqReos9voIj2DqSGGZjL38Vi8UYsXAfJtnsltsHig==
X-Received: by 2002:a05:6a00:35c7:b0:736:326a:bb3e with SMTP id
 d2e1a72fcca58-73e24aed44amr1028469b3a.15.1745455989817; 
 Wed, 23 Apr 2025 17:53:09 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 047/148] semihosting: Assert is_user in user-only
 semihosting_enabled
Date: Wed, 23 Apr 2025 17:47:52 -0700
Message-ID: <20250424004934.598783-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 semihosting/user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/semihosting/user.c b/semihosting/user.c
index 515de3d2c0..98c144cb45 100644
--- a/semihosting/user.c
+++ b/semihosting/user.c
@@ -11,6 +11,7 @@
 
 bool semihosting_enabled(bool is_user)
 {
+    assert(is_user);
     return true;
 }
 
-- 
2.43.0


