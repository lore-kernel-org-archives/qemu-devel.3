Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE102C02185
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 13:53:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYmm3-0002WW-Ti; Fri, 17 Jan 2025 08:52:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmlv-0002UP-8H
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:52:27 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tYmlr-0003lD-BH
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 08:52:27 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-aaec61d0f65so457112566b.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 05:52:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737121941; x=1737726741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zi1VkFTI50wNhaF65yTFWx7N5fJKMyRmjD/Fawk5sw0=;
 b=pxKpUO38wSVTrkw45sZyasy0WEVfSYAV+hkw+7UlYmyrjdii4E6SH59dnDOP1r80Uq
 bhD58vis1G0PzRfiIjfl4xdyaM6HAVgh9iJZT+V797s9qOgtVmBg+Omp8GFPwkVpXfOD
 tqlvjEucKgdllnksOXABeGof5INmAlyK3Wu5ACKNo2utWL5V/iiR7UrHxKNmzNLB4GAI
 yC+wMCWOEgvNcoVdOU4hIPHw5+Nik+hEzkD4jMuIspqMrRN/ETzVN30bCDjb2lzDSE6S
 HKtpOHelwbAXabwsIAeLxFUB8oX19bDHzjL5YP0sj6RA/p3MqUgbYCM1TT9Ezqd0Da4V
 QtLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737121941; x=1737726741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zi1VkFTI50wNhaF65yTFWx7N5fJKMyRmjD/Fawk5sw0=;
 b=EaJ415YIf4ucrqFc8V5iWBa8Z9oHvHU1aJmRbvjAr2h+rQasS5sXi1y6Avjg1wrcJP
 j06WRvhEAO1d10ZL5lJdW+ZC6JzHTYRtcRt2CQCAMANGScghVKGg/ie9mvfpeRlLOhZv
 7HDFKNjL5z28KkyxsZGdcXvKbQU5voL3epl5LfJk0+isvrR4wmXXw8fBVh1KW36934lM
 Z8pzmM/NbV6/WDHh90jcBpOg1VsUWqO1QNsHTjTAjLCsu1ilPZWf6ro1+WbYRuntSUVH
 3BonZuBTV2OtG4u6hmLrYZo8pH29Gp/eqAoY7gGI9Nrbdd2wnIiNKh3d6bHxPRusZMLp
 HoeA==
X-Gm-Message-State: AOJu0YwY2ttu05EgWTd+XwLSjcpv4ZamM8B0rD5bX28yoMI8ksKcDzyq
 9aNM9TEVig8wbPi+2iJQCN9sRjKIu7bU8IOWftj/8dVGpUuxLaEse0ZcBsS7DEg=
X-Gm-Gg: ASbGncvLwTXg32b57lGcISx2+QxpHesJcFoPwA7BIZp55c9Yx/Y9MQ0dNIZiHQUvXfl
 bGhcmsGzRdI1fBPiOGVpL3w5M3fa6MP/saX9XDUm4nu68kJOnfYPJlSxY9G6/bZKlt2YAtJgz7B
 7ypK3jdCqy01ONuXOtaNeufpeFpMBOJkbXPPIwJdOt4F9Ru/hkKk147jtIP3QdDpFbB6dfR/jyr
 r+xcqCRtod/ZJwW8ve6PEMzRZIUV6UCDC1MMe6DQld/E3ZIpLrhsyA=
X-Google-Smtp-Source: AGHT+IEy+X6vol4Daf2Pux81XnSa3lU4b9g0yDu2kHvB0hWhcTaQVph6ZJBAyAtQHxRO69EVY7Xv+A==
X-Received: by 2002:a17:906:478f:b0:aa6:acbb:3653 with SMTP id
 a640c23a62f3a-ab38b0a6059mr256769966b.12.1737121941383; 
 Fri, 17 Jan 2025 05:52:21 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab384f29031sm173241866b.97.2025.01.17.05.52.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 05:52:19 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DA0A4608E4;
 Fri, 17 Jan 2025 13:42:59 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 31/37] docs/sphinx: include kernel-doc script as a dependency
Date: Fri, 17 Jan 2025 13:42:50 +0000
Message-Id: <20250117134256.2079356-32-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250117134256.2079356-1-alex.bennee@linaro.org>
References: <20250117134256.2079356-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

When we update the script we should rebuild the docs. Otherwise
breaking changes made to the kdoc script don't become apparent until
later.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250116160306.1709518-32-alex.bennee@linaro.org>

diff --git a/docs/sphinx/depfile.py b/docs/sphinx/depfile.py
index e74be6af98..d3c774d28b 100644
--- a/docs/sphinx/depfile.py
+++ b/docs/sphinx/depfile.py
@@ -31,6 +31,9 @@ def get_infiles(env):
         for path in Path(static_path).rglob('*'):
             yield str(path)
 
+    # also include kdoc script
+    yield str(env.config.kerneldoc_bin[1])
+
 
 def write_depfile(app, exception):
     if exception:
-- 
2.39.5


