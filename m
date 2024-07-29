Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A295DC49EA1
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 14:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYRbt-0003kz-57; Mon, 29 Jul 2024 10:44:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYRbr-0003dO-9o
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:44:23 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYRbn-0008Mh-7A
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 10:44:22 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a7a9a7af0d0so474252766b.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 07:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722264257; x=1722869057; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T3GszRkz8geRaMKEq8CHOzLhtMD92I0hXo79XzAv5so=;
 b=pEcO7j9I2xMgVr21v+Bp/m+53kOVGtrq3JgQQPNi7OVma39u+ZuECWWU2j5xSZcQb3
 QoLcy7y3vohvpv8JSyYMJUAkHu/ocKcqh5PbSR45uFp/mZa9u3ofw70KIHEScJtukEu3
 W3jkzdRmc4Y4jqpNpcgnpfmWIHOYyKExNfPVqyv5BeEa8ZemyOseGuQ0L9Js88s2oeGP
 AMIhPqGdvgsM8KR2ghD5y6btDCoJhT9Znac4dFVoEu8enCjTcSbayimbdr+rxLtjY7xK
 3gvsHVGlLaTZqxtEtTF0rAI0/KarMOp5WP0IQPNpGdswAgcomL5W11et68kR6dkUxSyw
 33TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722264257; x=1722869057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T3GszRkz8geRaMKEq8CHOzLhtMD92I0hXo79XzAv5so=;
 b=BlJFIX6tZMKp+Yh+BcvUJ3dPLPOuHrR+qycF8HgljSXLvUP9wq+pYPKD7cpBi9OXnc
 gzhxd1jF1xc3QclJ1jsgozpBACDuhYto7+6WuGyGggR4rF/rYLvaV6foIGzv5TmNuFEI
 vW5CUufHD7YYVMFSycP2IRfd0t4tmGv4n6Gaw6lnJQRje0QdzZ7LfbnJ1gp43wkGHN0R
 xcxfdeRaxLl7puouOfi4XZxI7PRYNJmN9hYikvADjw8VnnEGNQ9oXJXoSdNtIfMen3OL
 C2B0D7QrDyJBmjSO7JiYlVxTUphzDy2Xydyh3BqayhbGEhc4rqvtv96BBXvogmHpsP0a
 adoA==
X-Gm-Message-State: AOJu0YxWcdVNStopOohrIZARJvpztLL0+6ZoHNH6n6bPfPoKhrcfajAC
 FInwNgYTo0IWMotjJWwgtxGT0s8+QZYpbbX8POOOjj1Q2lQTXBnUOXmj+yic1mw=
X-Google-Smtp-Source: AGHT+IHsL9GVI03IDp731rAG6GHIVAfI+LUj5scFzgtsovFBrefGaBwW73UfGf+Y9O+g5aIIe7Nscg==
X-Received: by 2002:a17:907:c48e:b0:a77:da14:8409 with SMTP id
 a640c23a62f3a-a7d40135360mr437751466b.48.1722264257006; 
 Mon, 29 Jul 2024 07:44:17 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad41976sm518778766b.130.2024.07.29.07.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 07:44:15 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3374A5F92D;
 Mon, 29 Jul 2024 15:44:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, Weiwei Li <liwei1518@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-s390x@nongnu.org,
 Cleber Rosa <crosa@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Song Gao <gaosong@loongson.cn>,
 David Hildenbrand <david@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 02/14] gitlab: display /packages.txt in build jobs
Date: Mon, 29 Jul 2024 15:44:02 +0100
Message-Id: <20240729144414.830369-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240729144414.830369-1-alex.bennee@linaro.org>
References: <20240729144414.830369-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x632.google.com
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

From: Daniel P. Berrangé <berrange@redhat.com>

The lcitool created containers save the full distro package list
details into /packages.txt. The idea is that build jobs will 'cat'
this file, so that the build log has a record of what packages
were used. This is important info, because when it comes to debug
failures, the original container is often lost.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20240724095505.33544-3-berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/buildtest-template.yml  | 1 +
 .gitlab-ci.d/crossbuild-template.yml | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
index 8f7ebfaed8..844c26623d 100644
--- a/.gitlab-ci.d/buildtest-template.yml
+++ b/.gitlab-ci.d/buildtest-template.yml
@@ -9,6 +9,7 @@
     when: always
   before_script:
     - JOBS=$(expr $(nproc) + 1)
+    - cat /packages.txt
   script:
     - export CCACHE_BASEDIR="$(pwd)"
     - export CCACHE_DIR="$CCACHE_BASEDIR/ccache"
diff --git a/.gitlab-ci.d/crossbuild-template.yml b/.gitlab-ci.d/crossbuild-template.yml
index d9f81b7061..53051ec793 100644
--- a/.gitlab-ci.d/crossbuild-template.yml
+++ b/.gitlab-ci.d/crossbuild-template.yml
@@ -8,6 +8,8 @@
     key: "$CI_JOB_NAME"
     when: always
   timeout: 80m
+  before_script:
+    - cat /packages.txt
   script:
     - export CCACHE_BASEDIR="$(pwd)"
     - export CCACHE_DIR="$CCACHE_BASEDIR/ccache"
-- 
2.39.2


