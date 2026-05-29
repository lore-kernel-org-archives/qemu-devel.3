Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC390CD6E45
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 05:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSq1Z-0006qB-VT; Fri, 29 May 2026 01:44:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSq1Z-0006q3-7y
 for qemu-devel@nongnu.org; Fri, 29 May 2026 01:44:49 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSq1X-0003QF-If
 for qemu-devel@nongnu.org; Fri, 29 May 2026 01:44:48 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49050bfe053so41028245e9.3
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 22:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780033486; x=1780638286; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/cYbdfaqmpYJRLVUARw7au1J1KZSHJ4WufZBcgdY62s=;
 b=vqSTw5BXurKaB4f88jKpmbwkwP+0SXRlSKgk7YooL0mvVXN8Dxmyjq76HRExiN6C96
 B+SpWof9O4ASdWKcz1UwpJH9r67Zj0JE0zfFTf0pkahSUBvFn3FBWusr1aigRuHpLthC
 HDcHJj2JAEF6gS0DdYQi2tehRKUOns6MeqJ0h2SMul/qJpIkjRKRYAdrIWo66u8SO2Ix
 U2QXHz3gO+ntZR12u3HDo6WcPFm4ZeBG8QHAHNmj6iXUYj3jXhkOoho3FpJQ1vrSrXq4
 SnWLsQfggBmRtURygLPGqNWkf1zCapv/l6I4RkHSXBanINpv5tcbT9i8PuVolrP3B5Jr
 FkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780033486; x=1780638286;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/cYbdfaqmpYJRLVUARw7au1J1KZSHJ4WufZBcgdY62s=;
 b=IGg3KuPCDvRKwKH0frJdqEgg90RHULl+BFJDNDwU97X1KEHMmU6wgZDuvNI4VPFZuA
 5TYCrZ0OWoYLZKDM45qZ22XaZN3k+cxsU75Zbqv+/OUQ3pW2RMpmFGrpHEVvrM8iPnm5
 dDBu8Pni4S/hNC/O7uz6UvLPg++xROcCpJ7U8pNUclZzW+H6iQ3ykUQIif/o6rQZpIJt
 +tf5de0UagWS9lRALWfVrZTXBT+O8iWOMp037JZ/b7O4JKPkMvpJPlN+8VzTx/iMbcmU
 MfuECddsPW7GAC+afbUOZOEPmhtrFXF7k3gTMf+DnrwO1VupD/r9P4psSyaF3zpLwV4k
 vZLg==
X-Gm-Message-State: AOJu0Yzj4mFOaSQ6RMstSeQIlkpzCGyhhFMg1r3XEyqk5JUXtXeM0YBN
 DXFUZn3hR0LKqUSux0k1+VtSeYyJ6MRJnDvxBKHRfc+jRdKkZvA36cY0JZjKiR4IdlA=
X-Gm-Gg: Acq92OEo2MMW4v3ppRFqlU2VoS2NBMko4x+K5ZrfLns+JT+7aqBwiPi9oQNnlkXRQYW
 XtKyL8d7KjBhgFguAV5ZlU2rPk8BIo5Csboy7TWW1iZ4rA2md+tDKNAYUSfe/NxBamuDqyjbxrx
 si9ibbNfeDQynxOgdsMpjlFMmUtmKrT0CWDUZEfOcSNXy2/srUY/B5PnEbmRsNDmPyeQYtvSZcg
 p3dZGbDCbvkgACBM6QOY7g9sJ/vawVjW4sZIWogBIvly8AvUyvk8jW2QXTyet0bbpATHYbfdyjD
 hjXrwuDXnXIraRHmFRk2/LgCHMVqNI3gd8bYzjzjWapkkcKjfqIzf5LeXzW/6QsbAbzZRbxb9hQ
 mnQNJSVf+mVu2ZPbIelpcXJ7MNieM0SAJlUB1z/k01UHPMmzachOpR9ZtRe35SPrQKNWZm2bu44
 vrkKGvLfW1l/jW+aSzm2mSBvctO/eAVIVP5Hy3KOEqcTNf
X-Received: by 2002:a05:600c:1550:b0:490:5191:6e1a with SMTP id
 5b1f17b1804b1-4909c0beca6mr22613715e9.24.1780033485894; 
 Thu, 28 May 2026 22:44:45 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909d68980csm19903235e9.1.2026.05.28.22.44.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 22:44:45 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E937960ECD;
 Fri, 29 May 2026 06:39:32 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 11/13] MAINTAINERS: Cover debian-xtensa-cross.docker with
 Xtensa section
Date: Fri, 29 May 2026 06:39:29 +0100
Message-ID: <20260529053931.283970-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529053931.283970-1-alex.bennee@linaro.org>
References: <20260529053931.283970-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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
Message-ID: <20260518102222.80735-4-philmd@linaro.org>
Message-ID: <20260526110243.470002-13-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index 2dc6559c414..13894537aba 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -445,6 +445,7 @@ W: http://wiki.osll.ru/doku.php?id=etc:users:jcmvbkbc:qemu-target-xtensa
 S: Maintained
 F: target/xtensa/
 F: hw/xtensa/
+F: tests/docker/dockerfiles/debian-xtensa-cross.docker
 F: tests/functional/xtensa/meson.build
 F: tests/tcg/xtensa/
 F: tests/tcg/xtensaeb/
-- 
2.47.3


