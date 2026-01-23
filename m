Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCEED74EDB
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 14:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjIc8-0004OE-R4; Fri, 23 Jan 2026 09:58:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIbz-0004II-HD
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:58:12 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vjIby-0007on-2u
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 09:58:11 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4801c731d0aso18267115e9.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jan 2026 06:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769180289; x=1769785089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IlUfoKCtrzpDxxKvD3ZWXZavaxQbw25a3orNPzaQiEk=;
 b=iBFnD60PbE5n0mhYQA+23r7QKw1JrB0bSl54KsboyzgSYjRMmUxzCfEWYDju42OlRB
 Czs4lI1GSnmT2UsILkMt+KvHC05f1IFv0o2yUOy+ii4KZoWkaPc0Sz4U4Zi9ZSTGIXPx
 iuJL+d0Sv6ZaSgumsEZEx7pNKVkplg2QWgs4BBxJIH/O7e3tlF3KgvvUD/Cb7NyWFOo5
 LAH0sVysH2kORs8fuA7nXfcENPOpc38CGxQXmo4VxsNT73wy1pVPbxOz8A2c87DJH/D+
 mE1YALbTyOvhR7+15XuZCgLG63u/hxvpTM9mus609b7OlHuJdZv6lqV8NR/IC1oCedPP
 zOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769180289; x=1769785089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IlUfoKCtrzpDxxKvD3ZWXZavaxQbw25a3orNPzaQiEk=;
 b=JFyGjPPtw8ZVirkgrPqmma3Zruek6OC6cK6b34alSYpHnJW4C4YpNw5sGj0MrXLuD0
 i6LZlTclnw0plwxrJyHlis7uMIepNqyXjYREieAM1JqSk6NzWoDQkme7v8XBfRQ9RyWT
 nKWFKN2GldGPFPL9wv8r8tv/4zXhBUG1WfWmmlBeC0X1F/aPs8X1ZydgAQGdqcmu2ReI
 wGt2HdX0H0q62ydefkT/qEjvuzPc7PntLKnkAHymBxUWN5UyKAfFIdx+SCeVf0tUMIei
 MSz8t+XXU+E7i1+RaulvwJ2QdC1aOdI7H1q5Qwsw4AUyjFWr73EhE6BdUaNc+Er7aOno
 DA7g==
X-Gm-Message-State: AOJu0YykM8KZhNBQv/UzuICrsoy7ZK06FybWsiii53YkyBgrY9fIEQfS
 D7PBEN52G2470UTBPcc/Xv7zCanAao43dZFH2Kv3Lp3+ay+JrsIs5BC06My4NoZdR1E=
X-Gm-Gg: AZuq6aI139Szv1CAzMAFUH3yvmvpMtPfu5WX1d1KVmC0P6KE8iqePA3Fnj5lVp2FPYQ
 qhjQHDFuBZdx6cRqT1EW5NS4BABzI3d5kYbOduFUqrIRk3yxL3xAm02yxkYpIRJcCR676yKnDmB
 B/vcOQBpknc+9JUtlG2v39plItYntioiPgf3hfrIUdkU9sljo11EU0vAU/l71EdhnlxGRFKls+N
 Ijv/uGMkaX2c7ZmmXlf0Zso4WBMTnKi79qitYqEsOIBzv9SaqJ4HlTjR4SpA/Ogt5H19lrG4NWl
 Q2SBCmXKCq2uw4vlWHZUrgwnas6BA1lpdih1dyE/Ij4H7X6IH7OC14xjWMMoTNOPlj4D2VIGzJH
 2Op01iA5t8tKPt/Ca+V7d2qAGOkQ6eLMlIsHi/td1yedpzJ2zWZpsY1NbcT4e3bqj3kY6qyOlif
 ANZmVtq2lBObaq
X-Received: by 2002:a05:600c:8b05:b0:480:49ce:42cc with SMTP id
 5b1f17b1804b1-480511f3c12mr25788675e9.9.1769180288629; 
 Fri, 23 Jan 2026 06:58:08 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d3ae17esm27238715e9.0.2026.01.23.06.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Jan 2026 06:58:04 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DA3DC5FC68;
 Fri, 23 Jan 2026 14:57:51 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Joe Perches <joe@perches.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 16/16] gitlab: add a check-maintainers task
Date: Fri, 23 Jan 2026 14:57:49 +0000
Message-ID: <20260123145750.1200879-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260123145750.1200879-1-alex.bennee@linaro.org>
References: <20260123145750.1200879-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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


