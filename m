Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD88C3DA7E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 16:25:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpcf-0008Ps-2r; Tue, 30 Jul 2024 12:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYpcd-0008H4-0Z
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:22:47 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYpcb-0003Xg-5Y
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:22:46 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a7ab76558a9so2406366b.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 09:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722356563; x=1722961363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GN1HaihudaqLLrp8IlR/d+UPmyEvWng1714T4YdfQiw=;
 b=a5PCfiwKoOmxH0ejGoXYV0/Rf6AIelag6X6c7gm6HIV1emMUAHokRmFpm9PHF+dKk3
 CLLc2T89j+9cfcdTU3xnC23totFQNQyi2FJVOfXwiaBcyoiOVhNb+/LLDUDO0UIWuCRZ
 2qTzUWWPolKkdwqx5wnmdynzml1J29p/f5RDc1nrhL1XX+Jjkb785WJqMKNz3RuEJ8Kh
 TdIeao12/tEG/GP+H2hLWUpBNq2+bljNlcBmaxSeX3IGnFYhGnNB8K2wP9+n9O7rxw/w
 0Ibf+qc3Z2We0nYxatfwp3qAyk0BeEZgFOpOujw6VKZGXCBPmXxDvM3xN3JhxUFOd1JS
 hQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722356563; x=1722961363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GN1HaihudaqLLrp8IlR/d+UPmyEvWng1714T4YdfQiw=;
 b=MmGWxaOuKsd10S17KS7r9MjMi5/rNv8SfO3FS/OKFQH376G8pWLce7P7TrBGjS5HD0
 XKGEqKGhYLOPw9/u/TJBLGl6bLEEgtRh0jUEFIhI/dxsffZ3S7KvuJdm3dOPRAz4vKlF
 Mk46uFDF++z8T6Tm6tS/FWJKqIPA2P92U/UGU82pVVQoMsetnyder/ClZP/YVZ8d4CrC
 6RWuXi60tQEbpOprGANhoTTT+vdR/jeA8T1CHlLaDXESZf22HerZFphOyrXil1qm/y94
 WWFvLrFBaCB7hQwyMO+Sych6OY62jarmbpLOgxyft/M6FvtmF7DmyOetFZZXjTVIAXm4
 iRbQ==
X-Gm-Message-State: AOJu0YwnUJawn/SKFAJePgrsiN9NOdZj7l3sy8zLm4oTJ0TvnJz1D/G0
 AAbTmBBGxPk+Wv+eeFZycFZpK8VlMpQo6lTuNn1wKnoHkt6RmOnQC+PoOGaCfrPFdieKSncOWGn
 n
X-Google-Smtp-Source: AGHT+IEZUi76y+V7xML2jV9HXN1xlLgI3lAsBABwkfJb7aFBEh+AgUPwQ411TozVDM9sWnNzGBIZ8Q==
X-Received: by 2002:a17:906:c10f:b0:a77:ca9d:1d46 with SMTP id
 a640c23a62f3a-a7d85abb7e7mr296828066b.33.1722356563324; 
 Tue, 30 Jul 2024 09:22:43 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5ac6377e06fsm7493819a12.28.2024.07.30.09.22.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 09:22:40 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 671A05F94C;
 Tue, 30 Jul 2024 17:22:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: [PULL 06/14] docs/devel: update the testing introduction
Date: Tue, 30 Jul 2024 17:22:29 +0100
Message-Id: <20240730162237.1425515-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730162237.1425515-1-alex.bennee@linaro.org>
References: <20240730162237.1425515-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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

Move the mention of "check-help" up to the intro text and also mention
the meson test integration.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240729144414.830369-7-alex.bennee@linaro.org>

diff --git a/docs/devel/testing.rst b/docs/devel/testing.rst
index 23d3f44f52..b984c5dd26 100644
--- a/docs/devel/testing.rst
+++ b/docs/devel/testing.rst
@@ -3,13 +3,28 @@
 Testing in QEMU
 ===============
 
-This document describes the testing infrastructure in QEMU.
+QEMU's testing infrastructure is fairly complex as it covers
+everything from unit testing and exercising specific sub-systems all
+the way to full blown acceptance tests. To get an overview of the
+tests you can run ``make check-help`` from either the source or build
+tree.
+
+Most (but not all) tests are also integrated into the meson build
+system so can be run directly from the build tree, for example:
+
+.. code::
+
+  [./pyvenv/bin/]meson test --suite qemu:softfloat
+
+will run just the softfloat tests.
+
+The rest of this document will cover the details for specific test
+groups.
 
 Testing with "make check"
 -------------------------
 
-The "make check" testing family includes most of the C based tests in QEMU. For
-a quick help, run ``make check-help`` from the source tree.
+The "make check" testing family includes most of the C based tests in QEMU.
 
 The usual way to run these tests is:
 
-- 
2.39.2


