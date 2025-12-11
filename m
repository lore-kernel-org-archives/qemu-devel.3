Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C625AD41D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 18:03:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTkz8-0000gi-DJ; Thu, 11 Dec 2025 13:01:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vTkz4-0000fc-NX
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 13:01:46 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vTkyy-00060h-Sx
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 13:01:45 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4779cb0a33fso5360495e9.0
 for <qemu-devel@nongnu.org>; Thu, 11 Dec 2025 10:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765476099; x=1766080899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IlUfoKCtrzpDxxKvD3ZWXZavaxQbw25a3orNPzaQiEk=;
 b=QjiJfidXd9/u1a5duBk2rOCnEBm3qF78LJj93Suq/VygM288gKTfS13MfaCazFHBND
 2EFXTW+2ytIBTPftJiVbqVwts+DOIMuChAJGiM2LC0S96TYfEE8UybeVULgl9z4o5d6a
 LleMmQqvaPlUTsDhNGQ6qIbxaSS6Yr5IrflT83SjKZz34FqVo+yYYqJtg50Q3JZekYDY
 k1gMYRkU28wEITmZRNe0XpTmESTqaaQmuokWEGDFsMkVzHA2bo3HmHxYncaVrjTkI5zK
 TKUMbJF1ro8gLuLD++sBT75WTV7pvgzb1UfTNAamqU1AuloarMDZ6tcnj33yyuoGYRq7
 0IcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765476099; x=1766080899;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IlUfoKCtrzpDxxKvD3ZWXZavaxQbw25a3orNPzaQiEk=;
 b=OSYK9NLhIrdvxVA4cxA5uF2/x3CpdvUsHnWNJYPvg1xwLEiFByrh3UzAtmg0oP42hB
 K6N8reI3Y3veoRhNVrbeMrDQDELashGZEPrX9Q0++FoLTOglPH0PuYE6LzsV+4oAZSBd
 YpKx3tKaIEu/qPZXei5kH1jwqeJr31kjrai1YZNVFzd+DWCBMsJCgtGCo8BE7f7WbmyY
 77KxYzQ0cv6eekp2dBQkozQ6ynlKFBY3UMoLYBpDDqSg7Ii6pPop07qk2LMFkAls53TU
 ZFkPcpxzQIOmxMYmGXAUZQ7MfzGg/Ut0eM9Vtb7TBQbkBi3dfVfPQ+TtQvvPZ6Li37u1
 gkvQ==
X-Gm-Message-State: AOJu0YwWyIB1sFCIt84EBHCGd998rPsI3aJ2Dmr2ApK5HIz0l06ZLWrJ
 CkwX3ycxzMb4/1rId9D4Pc2U7Igh7IY6lPaYtYIiOD1CrNaDc8/fbMO7sh0w12EN12s=
X-Gm-Gg: AY/fxX7Ioq1pggGjecedeue6x/ySgNLBMuLstcgRqhxiN7Qgt16ROXCGtxIsAF6F/gx
 ULm/95rDbM7RuMt8UE5gOLXXljUvl5i87iNoOA9/tC9nW9TY/44CiRclPQaF+J41P1Guj4TSH2K
 /P4AxIxn0GIK2r/01lbrwfZzmAA6CsEaCFhkvMbzFno3DWnQ/MJn4RMtGGiXqkD98Ha9vjtueds
 dLEdxKCtI6CVBKf+Em5Of/VllFWVFm9Rs328kxtaEea+cenUAx/CgIbJ1qbEcv3Zs3F7becP0eE
 rpCTv3031pQ9VDdFmnONDsDLqzPYMy9LnWsphF5+R7V8MuCMOYD5FJA5IeisRux995+0p9Vq1on
 TITmhBxjE05/GyEvT6sUQv+eDXKU1/+by+dmWsOrL7eyAdHiZZ3hYpkKZPFiZ3SlyYm/agT10pd
 6A6njk6vUauUY=
X-Google-Smtp-Source: AGHT+IFNNajq4jlOgpTAff0Bllofa3dLmQDGbeK90xVAxVciXlJC3XflfsI4+r0xjkMiMpN5RMx1xw==
X-Received: by 2002:a05:600c:3151:b0:477:557b:691d with SMTP id
 5b1f17b1804b1-47a838586d6mr78631615e9.25.1765476098137; 
 Thu, 11 Dec 2025 10:01:38 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a89f036a9sm49651595e9.12.2025.12.11.10.01.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Dec 2025 10:01:36 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 6BB2C5F94A;
 Thu, 11 Dec 2025 18:01:33 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [RFC PATCH 9/9] gitlab: add a check-maintainers task
Date: Thu, 11 Dec 2025 18:01:32 +0000
Message-ID: <20251211180132.3186564-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251211180132.3186564-1-alex.bennee@linaro.org>
References: <20251211180132.3186564-1-alex.bennee@linaro.org>
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

Now we have a more flexible get_maintainer script we can use it to
validate MAINTAINERS.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/static_checks.yml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/.gitlab-ci.d/static_checks.yml b/.gitlab-ci.d/static_checks.yml
index 61fe2fa39ab..c74698ad948 100644
--- a/.gitlab-ci.d/static_checks.yml
+++ b/.gitlab-ci.d/static_checks.yml
@@ -23,6 +23,15 @@ check-dco:
   before_script:
     - apk -U add git
 
+check-maintainers:
+  extends: .base_job_template
+  stage: build
+  image: python:3.10-alpine
+  needs: []
+  script: scripts/get_maintainer.py --validate
+  variables:
+    GIT_DEPTH: 1
+
 check-python-minreqs:
   extends: .base_job_template
   stage: test
-- 
2.47.3


