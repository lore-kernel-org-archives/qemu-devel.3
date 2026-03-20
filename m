Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB3B51098797
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 15:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3c8I-0007d2-Lk; Fri, 20 Mar 2026 11:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3c85-0007YZ-TR
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:51:20 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1w3c83-0005XJ-TZ
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 11:51:17 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-b97bca3797dso270674066b.0
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 08:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774021874; x=1774626674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2Fv5imt9etkCyxA426f2RtHofD804x2pDCK4rcq9hJc=;
 b=OGFzzahRIFAGKF2Ig8pxRZP5J0w0CyfDVYSQ9HOJOhmqn39BinzHaFw0HUShdVMwZc
 K9bYMqAt8CX3jg4Fe6NQgi0fUzCvpZ8JrkMQjNhHePJZh1qbB2SNx2IplqH2Z0w3f12q
 A7JAHY7VD5LZhHjL4wDvO3HhWCw0lGh8QTohc0Isjvo0WffhCwLvU63agzpk/yiO4ehI
 5GIC2UheaEdNX0OQdawFiloVMQwbPs1eKadkvDKgwO3/PWzWPJkdRYS7kRJTIJchKwYV
 2U+QPdbRjTNN225UaGuv+rgDZHv1Pfvrx6+FO2YbuS3w2tE2gXtldAW8/R0PkXaXtLvw
 EyJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774021874; x=1774626674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2Fv5imt9etkCyxA426f2RtHofD804x2pDCK4rcq9hJc=;
 b=b6yHe2dKT163wzRBIszrddrF3dWb3lED183ksZ4C/Iq7c0YS6Oo7cbIOGvp5eNfyfJ
 4FU+OKEk57De2srSuI78ubMlPXg37MExQCEWQSa0HMp7nhJgFeXQtqaIQYLs8QLphRkv
 9KvXAuzWp2CQ477myRM439Y5RWnMZam9fooCXJjDnVI+W3v99qae+hYmGfH1pRZm2T3x
 BOvbRBm0oeWIHo0NQigrGKSfZ/tRL/XpxA7NWuyNe3V5HXa0zzsCib2XKvU4EzTanBBW
 ex5FhIIbtgHnAdIoh/Nnl3jOEtif94zVAlq+u2kKAXBwUXz+4JV+jcoltXYnqZQmj8x5
 UjNQ==
X-Gm-Message-State: AOJu0Yx5Uo/V0jJzlLMswv22ogQdSfZ4Kd/ADAJ5Gohzc3Fa5kmTPLsl
 IrUqiOP0VKB+reK260HfbPho8Hv7i5bIpYFLVihVj3Ak2BYmJxfPdhvA2/83elzUrT0=
X-Gm-Gg: ATEYQzyLi2O8yNChWBJdMZDk77UuH4OT5Eftl88klidNM0W9mD4AFsOESFlnyBdM0ni
 kpW6SCBY1sUrA5HpM3xzpq0/kIZfD/7EsdRg4M7fs4XzPOZAbZGN5dP3baF4+4PXtFJqxCZxJER
 kZROtw8DXXvEHnyIB7Bc8qg49VEpsnTuetjnq1sbM/SJGhqPIt6aJjo7y6qSIW6IFJ4depuhTwE
 TtdeLv8l5kOkVZHKQSmFE+Ixb+0wf3RhGHXBCNg6jrJQ6VwbBc4lSlQyeF4Nl7K3RY5p+zKYElQ
 ry0Q2t4Tj+zBUS0wktVb6GrD4kidVojspzIe6uv+Dx4k5ZBtXpWvcK7017ZZPosIfsduYU8VaEe
 4wdOgq+iflxlU9mSNcnBHvuL6Nmd6igWLlsS1Hrqa8tIfEx8V/adBiZZFcoJ3wA10Z/CSwCOk/g
 i8TAy7W72hnF4+40SIHz8GA9A=
X-Received: by 2002:a17:907:3fa8:b0:b98:33c5:1bb2 with SMTP id
 a640c23a62f3a-b9833c56788mr190108466b.25.1774021874174; 
 Fri, 20 Mar 2026 08:51:14 -0700 (PDT)
Received: from draig.lan ([185.124.0.237]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-668cd050c4esm1426956a12.0.2026.03.20.08.51.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 08:51:11 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 3D4AD5F932;
 Fri, 20 Mar 2026 15:51:08 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Warner Losh <imp@bsdimp.com>, qemu-arm@nongnu.org,
 Thomas Huth <th.huth+qemu@posteo.eu>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Brad Smith <brad@comstyle.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v3 5/8] tests/lcitool: Remove python3-sqlite3 from the list of
 needed packages
Date: Fri, 20 Mar 2026 15:51:04 +0000
Message-ID: <20260320155107.2143191-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260320155107.2143191-1-alex.bennee@linaro.org>
References: <20260320155107.2143191-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

From: Thomas Huth <thuth@redhat.com>

According to commit 7485508341f4 ("tests/docker: Add sqlite3 module to
openSUSE Leap container") that introduced this line, the sqlite3 package
was only required for Avocado. We don't use Avocado in QEMU anymore since
a while, so we can drop this package now from our list again.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-ID: <20260316135407.209072-2-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/lcitool/projects/qemu.yml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/lcitool/projects/qemu.yml b/tests/lcitool/projects/qemu.yml
index 5e34e953514..b78a1d7f2e0 100644
--- a/tests/lcitool/projects/qemu.yml
+++ b/tests/lcitool/projects/qemu.yml
@@ -101,7 +101,6 @@ packages:
  - python3-setuptools
  - python3-sphinx
  - python3-sphinx-rtd-theme
- - python3-sqlite3
  - python3-tomli
  - python3-venv
  - python3-wheel
-- 
2.47.3


