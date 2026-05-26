Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C712CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 11:04:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRpZE-0002ny-Rk; Tue, 26 May 2026 07:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRpYr-0002by-JS
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:03:02 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRpYm-00069e-1M
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:03:00 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-49050bfe053so6051805e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 04:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779793374; x=1780398174; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DTpaoHXsbxRPDrR6tl3sC2jAbI1KwMvQGemEVDw47qc=;
 b=FL/vxVmahr9nXGq96OxkcZTfIwHfp7exsjp8mYd3h7NIhO1MrXM6vpyokoWAMIuqwt
 CFP+Dw15UDp5Mer+Dwt34dIFl/8WXXxB5WLZ7A5HFEd0BiihuSujCqCGKwVt8HdU7ZAR
 4rf9X7mNc1ABh9loC2pvl7COBYdxFMel6uYA89drhVRIYMNcNY/NYd22M9MPLuuFNy6a
 bIFiNOvA/5dWEMFbtcnDkzTqLdlaiUwHbIvMBnpigAjl1l0wiMXOM93IQT6wr78ja5WR
 KY6kItiFHjgbPzXgBgw6/nadlfMzsB5XzkIQt28eIeYg1zHVt7zPHmh07HhyDCtBu9JH
 CpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779793374; x=1780398174;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DTpaoHXsbxRPDrR6tl3sC2jAbI1KwMvQGemEVDw47qc=;
 b=OqyUgM/ED2jl426G1sei7d24xsMKDpgvlEGche4ktU4WyWt6zSsiJ4+1ilwNW58yqL
 gAtOT1Ju0jlLA6j+dPr0w4Xrcfrurx74TDoQ8SvNdm4UlcjVYX1mzMvn2mu+ntqOOuR/
 RmrasKRgvpSPR7zA3zsITtVaa/A+E59GQzz2oS/O6gbPJkZcvbM57DipwO88IVL6MfFW
 bdrTCP2VgUTZjt9DlOc+Po62eH666cyQUH8YRT7iYk6sg1DrLUXsemvfgBnlwohsalU0
 83746Bdgv6xzsfxEKM7uA8RjmBEPJGL5HmjbtaJUnErhJrUM4zBGU5PPTjDDx2nckzfY
 /MfQ==
X-Gm-Message-State: AOJu0YziHQSy6hlW2W6rgGwHfpvk5LqWOXFLFwtK7L9IzVqQl+s2bDCy
 7EE+fTJLjJTHc2lTp1tV19XdXCAJ9bZVL9cv/dMv4SBxdwRu4OSvgbo8y9SH/iboVKc=
X-Gm-Gg: Acq92OFfU4EZRnYsNFNG2VmkJc2RlVALftABEq0uhulVyyIWl9X0jM0CMu+aCpEm6a5
 z8Uf6OYuM5urHW7gqILP+yiuiOuoA3AFKWgi5JvMtoEJHVQZWVXriuJlAmZ1DRYqsga/sjCO9jy
 HsEhUD+fFS54OrHKqKpjuTUfjiW4fbbDIvYY5VcMmaUTHOGssRZpun6oLVCeNJbMxdZBh3ALmi2
 ZwUTdBiYzjndOkG7NnXzXb0livU7pa2v6abCGPGNkcDCPkl2BI2kysojpzPNwpLvhASpkC7ytV9
 0jQASsoZh8ETgbCOu2wOSjIhUuRlf6QykE4jhAFTeBGe7iCKFer2kV0EOk9RSz+aBrrIso9lmif
 yltkwW7SdV81NjQsEwceE3TmGNifUJTpZY/47HPZcEIUhWFd5RcIpYvq3gKXjrjPjRnxAf1WSrQ
 mvmS1eulz2gtL2hXJSCAYBeSKO0DP9Y6i2ag==
X-Received: by 2002:a05:600c:1f90:b0:490:5e2a:dbaf with SMTP id
 5b1f17b1804b1-4905e2adc0dmr149822745e9.21.1779793374140; 
 Tue, 26 May 2026 04:02:54 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490454c5eb0sm341583865e9.2.2026.05.26.04.02.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 04:02:51 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DB8B8604BC;
 Tue, 26 May 2026 12:02:44 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Kyle Evans <kevans@freebsd.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Song Gao <gaosong@loongson.cn>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Warner Losh <imp@bsdimp.com>
Subject: [PATCH v3 14/14] MAINTAINERS: Cover python.docker with Python library
 section
Date: Tue, 26 May 2026 12:02:42 +0100
Message-ID: <20260526110243.470002-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260526110243.470002-1-alex.bennee@linaro.org>
References: <20260526110243.470002-1-alex.bennee@linaro.org>
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Message-ID: <20260518102222.80735-6-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 08363ab5449..56c6e770513 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3479,6 +3479,7 @@ M: John Snow <jsnow@redhat.com>
 M: Cleber Rosa <crosa@redhat.com>
 S: Maintained
 F: python/
+F: tests/docker/dockerfiles/python.docker
 T: git https://gitlab.com/jsnow/qemu.git python
 
 Python scripts
-- 
2.47.3


