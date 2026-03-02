Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7CE5C624C2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 09:23:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwzU9-0001MN-8F; Mon, 02 Mar 2026 04:22:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vwzU7-0001LF-D9
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 04:22:39 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vwzU5-0007ib-Rc
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 04:22:39 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4806cc07ce7so47251365e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 01:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772443356; x=1773048156; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gxlGmMADfBkDj23qA/r1rspF51lHVkOiqdCHs5z6fO0=;
 b=PsXE9euLDwt8maLDX4x8bwfRkqzlrvyKjK2nRV2u6VtSo7+7VYx0TL/7axrYRKbESn
 m4bLA/gzOcehb+ZsGusHSgMBVC0CV9nRrgVJhcOAfsjov5qXGqEyHLO4bMwlwBugRF0D
 6kW58zBChsyqUw+IDOuie3AAIGcvRPRb/J1naeFL6Gjb9ClGSfqwn6qil5u27bB16SiP
 S35SM217gaei0vwp3OIUR9BdC0oHLcFHaIA5lgQwvZuKbMfpWADKccWEHG3vXgxGCO6c
 A7cw+QXSuFzu1ftyXj9vr5kx2mMCHOHLgZLCVz+H3r/+ZU9Gnpu/RNV+QpZLUk/4IJym
 1LEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772443356; x=1773048156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gxlGmMADfBkDj23qA/r1rspF51lHVkOiqdCHs5z6fO0=;
 b=lYZvwCw/e+/CVo2W4dHPx2KDwzr7yy0r7UIiBsg0STGYWAGLUayqyCtUUZGmxGwgpo
 w5fj7o9/7L7rQgK/aGk1UTyIjG9e7ytRCkym8eXNw42073NReSwsQYWJZbVl+3Hr6lr/
 8P+aRTOaaPmyBtbp3V/6yJWZu/vJNtgdqDzk0RVU8zos6La74FqDb1KwO5E/JpTnBOV1
 K0eLGcUuzeaO95Je5NP0LldY2XtAFZQENS2PYHayHdbXltnIOt5H1wNsu+KLwNvJBzK3
 55bHBqs1BFgK/O599rLNWPFqAS14YyeXf9AmXP/7netra3s5T5TvLRZ5VSzedzlLmeDg
 siBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/Y+zg1TENoB5bQL3QTEySqeZGmipFfJrh/Mbs94IsEiDa5QrBqTU6rNmBIs18aFPNW0UTWXfXpES5@nongnu.org
X-Gm-Message-State: AOJu0Yx7AUH32yMODPIxqOTYpcIy+X9H84sSw44YoUvt8MR7+RV3oRHT
 l1cJDMxD1Dp9m9U1e8NXulLMFgd94NXBjFppHm1ob1yA1YGiyiqNMdBu+gRMwDIq5n9mN0Q0KXc
 RZhoi
X-Gm-Gg: ATEYQzxtZ+5NHjr9BJybST1c5ZuOH5TwToGmTCAEBJTfoYvRK6kyYyi3HwscWFdErvw
 ZPEAJjazJKcYjLdsaWviBhspyPZnWs0OeyytmbLKBIyTXYRjQzwUQfDrbGUXyY8F5+vRXifn0GW
 +9Ta2Vs6Cq8idWp18lAQDHsuYErKE49ux7vtXwOKf4zLtB5rcrM4pthDsO3XCQ9N6F1L50rNw1f
 0fnQtZcbuk79O5sdKtjgbqQYlA3RNUZ1dC+LUYZxVJTK61ved50iLQwaRe0IWOlNWCIk+ZqWBUl
 xmsfat7Rzny8ipOvgLAPRhoYBP8kysjXhDNOnd4rAPRqvkizJHB3qr8qBdnKAgqM5IW5xa/7zOn
 moGO/44ZypfGMIOHHdXPCqD2q1m34Zb+MHx8YPTZPAOFSxin5uB9/tYWlemk34Fs20t/iPROoeq
 TlcHY3lP/TJ78evRe+gmMJ3A0y+DrY04vS1ZMkgb67b/I94G+Ns6XlLNdjZMAWRKohkN+SfDtuF
 fyUnlhh+HBuC+4jEavxeuidS2XlVwL7aT3BgmHE7Q==
X-Received: by 2002:a05:600c:46c4:b0:483:b505:9db4 with SMTP id
 5b1f17b1804b1-483c9c0f1d1mr198756705e9.31.1772443356398; 
 Mon, 02 Mar 2026 01:22:36 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb9d9c6sm129435305e9.14.2026.03.02.01.22.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 01:22:35 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Yodel Eldar <yodel.eldar@yodel.dev>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH v2 8/9] tests/qtest/test-x86-cpuid-compat: Free allocated
 memory
Date: Mon,  2 Mar 2026 09:22:24 +0000
Message-ID: <20260302092225.4088227-9-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260302092225.4088227-1-peter.maydell@linaro.org>
References: <20260302092225.4088227-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Fabiano Rosas <farosas@suse.de>

Free the test arguments after test execution.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/test-x86-cpuid-compat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
index 5e0547e81b..b2d884054a 100644
--- a/tests/qtest/test-x86-cpuid-compat.c
+++ b/tests/qtest/test-x86-cpuid-compat.c
@@ -65,6 +65,8 @@ static void test_cpuid_prop(const void *data)
 
     qobject_unref(value);
     g_free(path);
+    g_free((void *)args->cmdline);
+    g_free((void *)data);
 }
 
 static void add_cpuid_test(const char *name, const char *cpu,
@@ -161,6 +163,8 @@ static void test_feature_flag(const void *data)
     qobject_unref(present);
     qobject_unref(filtered);
     g_free(path);
+    g_free((void *)args->cmdline);
+    g_free((void *)data);
 }
 
 /*
-- 
2.43.0


