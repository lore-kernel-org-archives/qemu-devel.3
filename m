Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 008B1CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 11:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRpZA-0002kQ-DW; Tue, 26 May 2026 07:03:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRpYq-0002bA-47
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:03:00 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wRpYj-00063j-7Y
 for qemu-devel@nongnu.org; Tue, 26 May 2026 07:02:58 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-459bf19e87bso6139451f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 04:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779793368; x=1780398168; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I3yYafY8TJmCrFTnnXsB+UoyMxcWEdJ2PX05QeDqqFg=;
 b=XaeDs8V8IMKLx9SmzPhkq6rNmRxc8on7aYmUg4HXeYonYtsryNMkKcvYT0J6i1J1/W
 GwQ/cuU/g+gi3lr2vr23iVJ9CJ2U2XRllW+RPGxVGn6KT1Aoc6z9iGk8L/7Pug8IwzTG
 qgP/dmMmA6LRqnYwQxKFTGqjmoHz2k8re+9RJYNZogXGOflUuv5ZVzJnbFcy9uDhhjxb
 Cd8UWsCqf1J4lzwlIT1HD54brDghspeqQVyNaW90Tu3XUZg8/IvRSeNamr+cJSa4G1R2
 o7opPigrakYxPAiL4z/pjGNrajxgGtNAES9QfzqjQbfcYdMwjfob4yCuRtJonCCQYGXq
 rzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779793368; x=1780398168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=I3yYafY8TJmCrFTnnXsB+UoyMxcWEdJ2PX05QeDqqFg=;
 b=GekDFumUcJ1rNB4b6GNSPHHz//BntMtp8GA8VWS68au8dv+TVFlKUz23cgt5mr/MxF
 Kzfoi419flVXKkk70de0cffS1YYV2v2/0wSC3G5WycVnQj30dAKu4H5K2Du7hvPHjaT3
 OplQNZs1Plia6VGxCMEsJ9qF4d+a9zXI73o38C2Xm/XZyA3uviC2w32ndJ/hvpVY80pC
 2dPd4LaABv+dOdvUaZBVeC4tdKjekiTDI/v2mQ0ciZF3Xe24q9tXH/3WaBsPjeAMPq2r
 fQux8YpfqU7iZ/kgsc20vtiFFQ6VJtz7TV0dzd0KSPlCM4tqnga8NAxd+Uv0BiVh51DN
 3mqw==
X-Gm-Message-State: AOJu0Ywg33sp/Ow+qGx0ikTzixGwKSSVHjV2WiCh38le63zaonrydNxQ
 zutCbFtIiIXjDpEme+lmiS0yyzeJGR00QJNtIXCurBaPl3cRkFfDYpX2oSyNNuNdwP4=
X-Gm-Gg: Acq92OGecKaQS+kbWstQOfCUmS/qSSQ0wderSXbhnmWmeGhXSy6Tk1CJ47BjBoYM/Id
 AP4LBJ1v9D8dC/HM2T9zFp2V9jcyc2hlh969YApLNRceOP0z/qP4b3czCUA5wYOiM9RgaKSXC10
 CWvVoMO4NwWfmoNJQ/4+KbhAETBJImg5gqq2pPjSlT48dWMUjcJrAInnfNO9eZ9QdR8PCZL6+Dk
 /BH+jDcDI0kTCDg2rj26c9Ci8vXXL1aZI3mDuiDd27gqbxaF48RkG73kn8dFe9VYMzrb/u9s1sK
 ie7JQ+c8nU/HsSZFaMW4/7HINA8A3hPATptXMMFKS0njpI7At94Yr07wa4xQILbD6+2sKSMg7E7
 wjdP8ftc0+EmIjdMG7DvhkYNCnhCA2iAg7qpqW37tB+WwXMwlVowVZFzYa84KcSAO5ewaM/ri00
 FbQzxVc6m05BhGRBfmsDeJUKZw7q+j1qumcg==
X-Received: by 2002:a05:600c:3b21:b0:490:6889:200 with SMTP id
 5b1f17b1804b1-4906889028cmr96776855e9.25.1779793368368; 
 Tue, 26 May 2026 04:02:48 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d48e23sm33380497f8f.20.2026.05.26.04.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 04:02:46 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4711060452;
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
Subject: [PATCH v3 08/14] gitlab: update issue template for binary test cases
Date: Tue, 26 May 2026 12:02:36 +0100
Message-ID: <20260526110243.470002-9-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260526110243.470002-1-alex.bennee@linaro.org>
References: <20260526110243.470002-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42c.google.com
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

Binary test cases are sketchy because they can be vectors for phishing
and other malware. Lets strongly hint that source bases tests are
preferred and binaries should have their provenance declared.

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260511161757.105994-1-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab/issue_templates/bug.md | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/.gitlab/issue_templates/bug.md b/.gitlab/issue_templates/bug.md
index 53a79f58284..e20f586008d 100644
--- a/.gitlab/issue_templates/bug.md
+++ b/.gitlab/issue_templates/bug.md
@@ -55,6 +55,10 @@ https://www.qemu.org/contribute/security-process/
 <!--
 Attach logs, stack traces, screenshots, etc. Compress the files if necessary.
 If using libvirt, libvirt logs and XML domain information may be relevant.
+
+If attaching binary test cases you should describe where they were obtained
+from, preferably linking to the original source. We greatly prefer test cases in
+the form of source code that can be audited before compiling by the engineer.
 -->
 
 <!--
-- 
2.47.3


