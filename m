Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 816E0C7EE31
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 11:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uV7DI-0005Jm-BX; Fri, 27 Jun 2025 07:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uV7D1-00057Y-90
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:25:32 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uV7Ct-00079b-Dk
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 07:25:25 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a6f2c6715fso2151772f8f.1
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 04:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751023521; x=1751628321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WJ9vXif3F4yHPbQYFiWo9MlpC4/NuUiREDS+hdYGJLY=;
 b=GKbQHWVs/QazYmv2cHG8gWbXN0/a/awKwUtgSD5Jxb9SssuPp2y4leBVdU6otxJUfq
 8UZtu9XJ2o9qAPIy8RHyskPJ4jkCFje4g5T7+LJS+baeAzdDiieO82IYHlCkm1FVebhq
 GgEob7PIr9KgtW08Mqwn3Kt9N+04kA5GJ9mlL5FeAHlMs7cE6HvFx5NAXE0vTv4HROSU
 TFo9Fstt0D9CTZiipofLnEFEezTMkPu3SV6f+9Rhe/xCMxWvMaxcII6hVO31zNT7bVKq
 7Ft0s7xY6ARbCUTGQUohDKOfsEpooWADDw76GdTv1k8pwGTNvS7gW+9ptsgqYSOkj5sB
 WBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751023521; x=1751628321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WJ9vXif3F4yHPbQYFiWo9MlpC4/NuUiREDS+hdYGJLY=;
 b=RE6sr7A8Wt5F+HySle0zvvgM52CO1iwyWaglHAR5JrkzSPZUeP4geqdv5x3VDh+DUU
 09yIoF25SC625Qa+m5OwBY7rhu4eGtCG0FRUIIBcbpYS392TNvlPqRjU6pVB9gS7dPra
 Fjrtq7/8iSdtrNGAtdpQIAZ15JpiudJR4EO5tBPs0gisktE51THPZimrvyFGpH6GduKW
 3uxv8lnlmR9dT6eisK6D6fNhuJV/9Hz9ofnJ84H65OMJpCmgwj8SgNESj1f1KfxMEq16
 qgvGye9vvEBFDIoCRZjinQAiMfKDGtBbbTqtcWQTzKPEeX6LcSDh+cpvjVIzEsEWdA1G
 uTNQ==
X-Gm-Message-State: AOJu0YzFWDazWtn4HpOgUPq7Ynsz9T5DrlID5XQzRKPgJXxVRTf0A6Fg
 YML3m5BTSJAwhshLXRJOCdxKqz50Vv5NlXyF5segaRUFgR18BNTSTrUQZ/sD8kavPr8=
X-Gm-Gg: ASbGncuCrF3+58+6wD6FMoj9XWNjW3duzXV6/PCuFehlQQotNpO/5U6rrYROd7/24tn
 LQBA5z8NLZYqzI4etZhG5Y7d84e7eTYY1qUuQhYQbbdRQd/PajCNpTKgJeMHxcxDHJEGHUhA9iO
 pARVcGS3JOBifCuQ7vWIVqdBMjAMni+mjl0tvtmrQVd8NFhIRcglcMAAleERQI9V1+LNmx5I7P0
 nCfZiO/ZG4Zn1p0CrxPyoosOeww/pYgW2gbWPFuJIGt7+X9OUa4Av73e7kql5ISFt8X313lSt5+
 S3j7SZjVwM92xp9D675xnzvDARZrVGyRivbdWoIgppnketkI0b/N0kAVwA/v4gk=
X-Google-Smtp-Source: AGHT+IGpXIpA4o2V1BK5q1lSKmxi5IbHRiOUfpiLFIH3/7TocXRRkBigzXG2Nn5prABUYaAtgIcopg==
X-Received: by 2002:adf:cc13:0:b0:3a4:cfbf:519b with SMTP id
 ffacd0b85a97d-3a8fe5b32f2mr2196411f8f.44.1751023520611; 
 Fri, 27 Jun 2025 04:25:20 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4538a4064b1sm48585015e9.29.2025.06.27.04.25.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 04:25:13 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8B0BB5F8A6;
 Fri, 27 Jun 2025 12:25:12 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 qemu-s390x@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: [PATCH 04/15] semihosting/uaccess: Compile once
Date: Fri, 27 Jun 2025 12:25:00 +0100
Message-ID: <20250627112512.1880708-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250627112512.1880708-1-alex.bennee@linaro.org>
References: <20250627112512.1880708-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250526095213.14113-3-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 semihosting/meson.build | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/semihosting/meson.build b/semihosting/meson.build
index f3d38dda91..b1ab2506c6 100644
--- a/semihosting/meson.build
+++ b/semihosting/meson.build
@@ -3,15 +3,12 @@ specific_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
   'syscalls.c',
 ))
 
-specific_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_SYSTEM_ONLY'], if_true: files(
-  'uaccess.c',
-))
-
 common_ss.add(when: 'CONFIG_SEMIHOSTING', if_false: files('stubs-all.c'))
 user_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files('user.c'))
 system_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
   'config.c',
   'console.c',
+  'uaccess.c',
 ), if_false: files(
   'stubs-system.c',
 ))
-- 
2.47.2


