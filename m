Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C59FCFD317
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 09:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNTJM-0007ro-0L; Mon, 24 Nov 2025 04:56:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNTGW-0004nY-2q
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:53:53 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vNTGR-0001pE-JU
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 04:53:46 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-429c48e05aeso2518501f8f.1
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 01:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763978020; x=1764582820; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SVhsGDh2IaDeIGTWqZmT8NM7yOJxg/PM846qyZOwP98=;
 b=LfRlUYf+Mo2w5jYCWTk0JUoy9shyqyKhRTS8tbOrM5t69JZ71G/g8I9Jxiqi+GryKT
 ao3QUszW1nRJZISehZc3O/ONcct1slhiVOkwQ7Gb9aPYVwMYX3EoZmr85sWSzzg29Idk
 3HZ+trKpiifDD51OWigczlTaE6Ox0+dCgN1vOpU6MrxrN3hNxkzTTtFTKsFcimMkARhm
 34Uj+eKGdkABHkpkVSqiDlhciyVsfBw2RwFTAVdW20RUvSd8oo4UNyHJPK4m9bkVbU9p
 4txz99YwAx3xGfESbx4Q/3POYTutr4FnXgELOtsbgR/JFjQCc0RprUlmEn3bAoVHkCkd
 IxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763978020; x=1764582820;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SVhsGDh2IaDeIGTWqZmT8NM7yOJxg/PM846qyZOwP98=;
 b=NZkFLqcmX83ZZcdT19EVMXlNLXAUu/P4LzyBpf6N7CTMIBYwqrwLfbB/jl+T70e577
 9BYPVkf1HAe+0mTlSf6/YsRleyVUzXdF4uziYqwzF1mp3Fe05ELjSx2aXUA7C6SMNUVK
 cy8K4OSQaZrrJaVJiW/E9k5yMohu4Do6NTPz2Jm+Y7xhNxQYqE/DIANPeKbjggRIgHsK
 yGB6uPtFb40f57Q22VYEcNkyktXx9GNuKAMp3mhaEpGqPh76161KcO6/bKeT8wPdVjGc
 W+9GFikFHbbCU2ULHRVkXBwZJkgoVVITiqIXEQV1vqzsubTL8oeDoi02WL8HSL3wzK/I
 sk5Q==
X-Gm-Message-State: AOJu0YyuXh+5XQdbZAZLipvcQtpMsnY0UoT2FSyzcy+5xkXYHR8r+OY4
 Y2rAUQH7R21iRiq1oTS5QnxxyTERuGiMWUrD4JMvK33Fj84Gh0wcDrreQ4yDJXDrnmw=
X-Gm-Gg: ASbGncuW1RZYQgbJR7vTI21mwJnDLu2muTQJxEtAhL8knu7JdEgrWo6V06sBNmMJmEM
 ug3VEaXaYY/QTP3ekHhV89Cy275fOn45brY+FaHCvKF/pxFIDfdNyz8cRyU36V9/1aJWYnVkB7U
 hGAlGI1Zz9KndCZDvkxeHljYw3u41qYokeW//eyd3f5E13Zj7AL/60KKhQUNe0qxNAq90Z0PfMJ
 UhGKc2lahocHUljisWwuoG1DY2XmGIbLjTqjjsWNWrcZskzLRuMaJR/Na63PKclAYiStfc1XRmz
 zmdDCL0g6iqZUxFqIKC3bosBoNbJA0lycorh2pmI3oItNSJ8MLjAhXH66+niPiC+eMdYBSSfkzk
 dJSansexslth1ONNT7ZQdbkLO3JRQ1GsGmMR8dtGhRmyqOeJILqfBR69/P3HW3CjY9IoOIe511s
 7cXn/l9+0GoB+lDAriCP4e0A==
X-Google-Smtp-Source: AGHT+IFs8D/lIF0RHcujtcL7kZPbakLF6FjYecrwXbx/LjaNHnQD1ucPRuqtID0Y6x0HD9B8j4MpMg==
X-Received: by 2002:a05:6000:228a:b0:429:cc39:99c0 with SMTP id
 ffacd0b85a97d-42cc12f1bddmr13193329f8f.1.1763978019807; 
 Mon, 24 Nov 2025 01:53:39 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fba201sm27217921f8f.32.2025.11.24.01.53.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Nov 2025 01:53:38 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id B106F5F861;
 Mon, 24 Nov 2025 09:53:37 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PULL 1/6] contrib/gitdm: add group-map for Huawei
Date: Mon, 24 Nov 2025 09:53:32 +0000
Message-ID: <20251124095337.537277-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251124095337.537277-1-alex.bennee@linaro.org>
References: <20251124095337.537277-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x430.google.com
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

While we do see contributions from the top-level domain some
contributors also post via other addresses.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Message-ID: <20251119113953.1432303-3-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/contrib/gitdm/group-map-huawei b/contrib/gitdm/group-map-huawei
new file mode 100644
index 00000000000..c287dd5d2b3
--- /dev/null
+++ b/contrib/gitdm/group-map-huawei
@@ -0,0 +1,5 @@
+#
+# Some Huawei contributors submit via another domain
+#
+
+mchehab+huawei@kernel.org
diff --git a/gitdm.config b/gitdm.config
index 9db43ca1422..05a2dad2291 100644
--- a/gitdm.config
+++ b/gitdm.config
@@ -36,6 +36,7 @@ GroupMap contrib/gitdm/group-map-amd AMD
 GroupMap contrib/gitdm/group-map-cadence Cadence Design Systems
 GroupMap contrib/gitdm/group-map-codeweavers CodeWeavers
 GroupMap contrib/gitdm/group-map-facebook Facebook
+GroupMap contrib/gitdm/group-map-huawei Huawei
 GroupMap contrib/gitdm/group-map-ibm IBM
 GroupMap contrib/gitdm/group-map-janustech Janus Technologies
 GroupMap contrib/gitdm/group-map-netflix Netflix
-- 
2.47.3


