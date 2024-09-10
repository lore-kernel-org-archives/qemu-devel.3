Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 972A6EB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 14:10:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1so1X3-0007ug-7a; Tue, 10 Sep 2024 10:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1X1-0007m2-9s
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:07:47 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1so1Wy-0006Wc-WB
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 10:07:47 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a83562f9be9so78615366b.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 07:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725977263; x=1726582063; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IsUfGT83ExXUAJJQLptvfbG4vLgQieFEBjde6vtierM=;
 b=cpOwIF5V2sARfRaaezi3XfCe2bohmIJkXVv8rh4pP1fHmdEXoVWWgT/LJSW61fcahV
 /jsIxQ2hvC2zmKF0zasnwuSz8fWE86Aku6wwRj5Yd2KqMzsXf7RhxaiXm/K5d18+Uk3I
 Dycc1hxLk8drz4zFshMH2VPvw2YrBzWgO58zqrnQt1wPnDBsDyv7z3gXTW7zoUuVDmQP
 SaRPwLklJ4yAp22R27odcak1/7/uJEs/2b+5G6/8SlVSWOc3qS8kjNvRGzAXiI/RdWCE
 St56dzfg+8RttEqjc43wQgiAIKZsBiwVg2LJmOF8RjC0NI1imG3HSuwZWk8TWJiSvnY3
 89VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725977263; x=1726582063;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IsUfGT83ExXUAJJQLptvfbG4vLgQieFEBjde6vtierM=;
 b=Re2/9xl5IMTsgNkefT7sjhHq3uE/3WoL9Il1QSoFNvUZDnevSeiI90a4inf4/z8Lly
 y3fUZpo9Srm1vRJoxDHE0uOeK8uu1GIQbtHG0g2xdFuqmPrL/jh3DGuaL8Qc7zLV7Bcb
 Y6z+Z/ltzRfKoF7r1xpz+IOorDZAdTAzeIZ3T/Bt04v4v7rCqGzxzD/zSXLLJtQDYiDj
 crf0qYhiCT5Azt0cxTpjHjIym8RTRzXrpgkPaIytnFLndmqOTGpzP3RW3dnR3UbwmuwA
 eQL/GZGu48gJVpeAsdcgDnQD4fQmqDCZoTi7WSr9zqrHj5MjBkIEgh4bsApmnL+J98zW
 La5w==
X-Gm-Message-State: AOJu0YxW1osMYCreM8k7mGqpbPMgpnYp8LvjY4JyzlvRc7NcEDe/YSPJ
 K9Bb2c/x7TWGKzfnOsMkiJPZ8Zz+et6Ua+u/lhx1DLqaB4N0wddmOY0rwNirXuA=
X-Google-Smtp-Source: AGHT+IEfpc61Ff8Z+U/qAeLxqjz1tp2OBS0Heq2Uz0SmZ3HkZLPX8o4XiHCg9zOlnny1JWh39jazzg==
X-Received: by 2002:a17:906:7949:b0:a86:80ef:4fe5 with SMTP id
 a640c23a62f3a-a8ffadece87mr102318566b.47.1725977263302; 
 Tue, 10 Sep 2024 07:07:43 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25a2c441sm487354166b.90.2024.09.10.07.07.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2024 07:07:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A0FFB5FA18;
 Tue, 10 Sep 2024 15:07:34 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, devel@lists.libvirt.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: [PATCH 10/26] contrib/plugins/Makefile: Add a 'distclean' target
Date: Tue, 10 Sep 2024 15:07:17 +0100
Message-Id: <20240910140733.4007719-11-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240910140733.4007719-1-alex.bennee@linaro.org>
References: <20240910140733.4007719-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
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

From: Thomas Huth <thuth@redhat.com>

Running "make distclean" in the build tree currently fails since this
tries to run the "distclean" target in the contrib/plugins/ folder, too,
but the Makefile there is missing this target. Thus add 'distclean' there
to fix this issue.

And to avoid regressions with "make distclean", add this command to one
of the build jobs, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-Id: <20240902154749.73876-1-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/buildtest.yml | 2 ++
 contrib/plugins/Makefile   | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 1d2afae996..8bc67ef7e9 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -345,6 +345,8 @@ build-tcg-disabled:
             124 132 139 142 144 145 151 152 155 157 165 194 196 200 202
             208 209 216 218 227 234 246 247 248 250 254 255 257 258
             260 261 262 263 264 270 272 273 277 279 image-fleecing
+    - cd ../..
+    - make distclean
 
 build-user:
   extends: .native_build_job_template
diff --git a/contrib/plugins/Makefile b/contrib/plugins/Makefile
index edf256cd9d..05a2a45c5c 100644
--- a/contrib/plugins/Makefile
+++ b/contrib/plugins/Makefile
@@ -77,7 +77,7 @@ lib%$(SO_SUFFIX): %.o
 endif
 
 
-clean:
+clean distclean:
 	rm -f *.o *$(SO_SUFFIX) *.d
 	rm -Rf .libs
 
-- 
2.39.2


