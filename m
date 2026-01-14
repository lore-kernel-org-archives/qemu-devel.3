Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDACD31A3C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 10:16:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfxul-0001ZS-MW; Wed, 14 Jan 2026 05:15:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vfxuY-0001X4-Jo
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 05:15:35 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vfxuW-0001RW-QC
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 05:15:34 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-432755545fcso4980440f8f.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 02:15:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768385730; x=1768990530; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8h4sdiY9JE6rWdEg+rBvzQ9j/JVjXlREFX3wwiQ5gaU=;
 b=f9dG+uwmyu16BiX7UTARTDgqz4NrOnRe1hCJatQThY4PonRnpsr+BMoB3xDkAbodBj
 4CgUzQl0cklntuMtI25j+OmDkj6ox2p18r0J1ku5EPoSEE58YCsryCJRUtfgBI4QksNI
 aHtFsmioRCZftQhYBA0j0EMJzcicsYLCXZOHLq8f7Xc4XQY8ZG2f/t/ga7dxW5Klp0An
 Xcxa1+gj5iwuFqhI93UYe8VWA1vatr18uQZS91DcqTpj9gSDzgwbXBQznvValzzEu8RF
 K+atPFFhNpN5I7A/0qpAD0JRGzbKExullu9ur+qWQ8UE5GQ6CHknpkQTDMYK9jI5x+Vi
 c6Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768385730; x=1768990530;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8h4sdiY9JE6rWdEg+rBvzQ9j/JVjXlREFX3wwiQ5gaU=;
 b=Y0dMqlojFusSVRaK+8HTgD0wdZAzy+0w07fHw1arKIwFQMWZQodv/6Ya32haeiGiVi
 O2J0tD73z3M2VTnglJI0sOcKEeo408V1Ez+DBW1SRWJt2bnTk/ydcjVClvBEjKQQPVzU
 6w79aveNVPkGZ/UzA4wkPoNss1O0HbGpop868+ZVUNDPbz/uR6PUk5CIx0Ce8kHd7S+l
 3ofy9ULOpknCpWTevc73MSftEwB4cvdrs8r0DWLZCnO43C0lYwPT87TczO6SKvN1AqKH
 X9tGIk5hfYRWWMYzY/oB0JeVhrCWyiNtPQd1FV9w3slHSvpggm7nFq7J3+E2Szoltfbq
 7aSg==
X-Gm-Message-State: AOJu0YxGfGYDAhSt3uEtzsj5Vz+jITAfmAjvnHUWxvpABppNgmbrEPhJ
 TMy6Rlkq7z4K9AYGAMkqf2UETSkBLFMV8IoSuAHTkCAPNnc0IQtgwpRw5/ma3U/kYsM=
X-Gm-Gg: AY/fxX6HgFO9gU+vpOo/1y4+yEe2Ep2toACNBlerEpwF0us2KNz5TtXIEvL7QxYoFxA
 v1EXe59kdUgY36UWcAgeu1xQIoH8Zg6uj7xwRzk7y+BKoAbyA1ma16gsiu/H+VV5QpOQfvoGKZB
 4vF8fsfzIBaSLzKUvG6JLjQypYc6abi9qP7LmBRuGZnoyl2xva21Vr6FEdc/j0w/7sfWvXejngc
 lj88OtZat1/ine0a88tZ+clwS/rrzy9Bs+JW18ozA/ZZ4xmNyxH/ftTlwalxjt8aLH1724QKxN9
 60YxV46idH/i+OSdirXUjCqVLqFD6OFgGBYo/RisCD5Z6izfrTPh9iRPdjOnGdPINeJeo7lWEZG
 +fg8PguK2f3tNVJsh+oroOrW7brEUACy93qk3+uqmAfdvqPptxj4g99zS8CU+TKuJOQ8ha+m/ri
 tORF+f+n01DRc=
X-Received: by 2002:a5d:5d09:0:b0:431:a38:c306 with SMTP id
 ffacd0b85a97d-4342d6092f5mr1598309f8f.43.1768385729686; 
 Wed, 14 Jan 2026 02:15:29 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ede7esm50411437f8f.32.2026.01.14.02.15.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 02:15:29 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 563D55F803;
 Wed, 14 Jan 2026 10:15:28 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] docs/devel: fix bash-ism warning for configure
Date: Wed, 14 Jan 2026 10:15:25 +0000
Message-ID: <20260114101525.4039244-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42f.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hopefully this makes the meaning clearer.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 docs/devel/build-system.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docs/devel/build-system.rst b/docs/devel/build-system.rst
index b9797a374c7..35c77343914 100644
--- a/docs/devel/build-system.rst
+++ b/docs/devel/build-system.rst
@@ -66,7 +66,7 @@ Modifying ``configure``
 ``configure`` is a shell script; it uses ``#!/bin/sh`` and therefore
 should be compatible with any POSIX shell. It is important to avoid
 using bash-isms to avoid breaking development platforms where bash is
-the primary host.
+not the default shell implementation.
 
 The configure script provides a variety of functions to help writing
 portable shell code and providing consistent behavior across architectures
-- 
2.47.3


