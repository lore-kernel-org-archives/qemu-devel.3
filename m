Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17382CD5BBE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Nov 2025 10:35:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vJUem-0004pL-1K; Thu, 13 Nov 2025 05:34:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vJUed-0004cm-Sd
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:34:16 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vJUeZ-0002F2-7q
 for qemu-devel@nongnu.org; Thu, 13 Nov 2025 05:34:15 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6418738efa0so1111267a12.1
 for <qemu-devel@nongnu.org>; Thu, 13 Nov 2025 02:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763030049; x=1763634849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eW3Cg6ZlZ8xyBhvunyG5qDqoZAJKrgoniT/tg7TJaLo=;
 b=VNr47sD/0qnU243vWCUvmdJmk7Uzq7LJALp12ZMSqIlVbW6QY2L89YxE4LrrX6ZUik
 olE5edMJT1Fr/PVcVjbmT4EIS8wSK1brGdVhKY+EREZRsxGzno97zcVQlV/umVIf8HJz
 BpW4E88VHurYJNB37SwxoB/Y3GnRKdhyioElirCogDJ1A+gTTG9zu7PuuSmdu2FXaa4P
 JGC9Brw7n0mt3fF4bx6YfvRQaSi879+skmG5qsxnfQnjQY5Fcyvix3raRydkhZHH2tAb
 lLkXoNOSwJPNTeJcSGObZB3R7bzJuYYUCkHgFrAlA6AeJSewTJY9ArhXT2ktL9NS0Oy0
 cW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763030050; x=1763634850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=eW3Cg6ZlZ8xyBhvunyG5qDqoZAJKrgoniT/tg7TJaLo=;
 b=rcDpTfDgpr/GWiNocVjXrYPPkH3D+KmRWvwrM/vJczK41+AyG4nON/ZmwvYoLHclRx
 pgM8+r2HGtCJ3musBReukFUyLkqC64rSlEOlcJOqOspI5HolqIQqvtrEZwObvxlyWKyh
 LUVlQoc8UaX2HQ+qmXQlAmR1JMrzFFVoArVgmyrfgCb2ZzxHwxx9e7NlRY316AGmW8Lz
 lcXU0Uz1xBedJiwyqvZjxI0/NzcGCLcudzBEAgff+xvL8hpAe8MwRzw0Te42tpTnInak
 PRIoGyalVK/9qBkYYcSxwy0dbqJg+Q81JX1sDVLGPTm85HZqaKL5lYUJLGgGeBmQstMG
 I5OQ==
X-Gm-Message-State: AOJu0Yx/kz2zGnGNkHHiYdSz5/lII8+usJUl8QW80fG9Uiqf3uHs9HeW
 jSQ7z2ruD4Mv24GyoDyjVl/kaIw0VIwzGsuyuZTDDM0OTz/BprGT7uvk9otmQdnIq+g=
X-Gm-Gg: ASbGncvSgTc670wVBnD04+JAt9HoklPgnif9m/WhE37SHt++jxCNsDzgo+4r7DdU77G
 OXW6zA1uvF0loegiXL6d/YawgtBbgW4o+TEVOkgMvYq8mAxwR7LoUbUFUnoICc77mJEc6ftUaq+
 CvYOMN94bupRyDbYkVLxnxm1YK+8DsWPkCtWqut52oLnTYA4lU+D7mq++rBJrkoNEHMgSb+kjXV
 58lqo8vfbW8vIHW8IKgbFFPYAB4cHlnWSwOKrAIxrWjQBZ0JHDgxAug2OYxEyLOCwdJjU+Ydb8e
 Lc1KYXQMWWEsBmrlWPjphKIJMWSLWWASh8GxmfHzYaYGypVoQjnKnjn6G6QQnzkZporRFHzVL9K
 urGNIQUArp2WqnqNnLX1km0/rWli2gYhpaOhP6743WRex2/RdZTV2tUnlLmdm9MGdOUwCc380zL
 az
X-Google-Smtp-Source: AGHT+IGiA501Lw9HJeuAJUAPz9VXFN5tdewSbIyqXm1nzcuoZ4l3Hdh2r3WBLNOWr91QcbpzD8vzJw==
X-Received: by 2002:a05:6402:3585:b0:641:66cc:9d91 with SMTP id
 4fb4d7f45d1cf-6431a56b3d7mr5734806a12.27.1763030049580; 
 Thu, 13 Nov 2025 02:34:09 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6433a3d6f5bsm1178240a12.6.2025.11.13.02.34.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 02:34:08 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A257E60DDF;
 Thu, 13 Nov 2025 10:25:27 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <thuth@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-s390x@nongnu.org, Li-Wen Hsu <lwhsu@freebsd.org>,
 David Woodhouse <dwmw2@infradead.org>, Ed Maste <emaste@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 17/18] gitlab: make the schedule rules a bit more general
Date: Thu, 13 Nov 2025 10:25:23 +0000
Message-ID: <20251113102525.1255370-18-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251113102525.1255370-1-alex.bennee@linaro.org>
References: <20251113102525.1255370-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x536.google.com
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

By default no jobs should run under the schedule and then we can be
more explicit for the ones that we need to. Otherwise I trigger all my
custom runners every time I do a scheduled run.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 .gitlab-ci.d/base.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
index 60a24a9d14d..921c5620008 100644
--- a/.gitlab-ci.d/base.yml
+++ b/.gitlab-ci.d/base.yml
@@ -45,8 +45,8 @@ variables:
     - if: '$CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_COMMIT_TAG'
       when: never
 
-    # Scheduled runs on mainline don't get pipelines except for the special Coverity job
-    - if: '$CI_PROJECT_NAMESPACE == $QEMU_CI_UPSTREAM && $CI_PIPELINE_SOURCE == "schedule"'
+    # Scheduled jobs should explicitly enable the run in their job rules
+    - if: '$CI_PIPELINE_SOURCE == "schedule"'
       when: never
 
     # Cirrus jobs can't run unless the creds / target repo are set
-- 
2.47.3


