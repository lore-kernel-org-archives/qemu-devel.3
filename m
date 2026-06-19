Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B32DCD4F26
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 15:57:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wabab-0007FM-2G; Fri, 19 Jun 2026 11:57:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wabaZ-0007EN-Qg
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 11:57:03 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wabaX-0001Ff-G7
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 11:57:03 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49222b6e871so19267415e9.3
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2026 08:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781884620; x=1782489420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XAcK458fLut29YrBXX4JA0FS5UqQPCx1uFviFFxfcaE=;
 b=ujhe+ROWrYTNwX0zPu+PKHVBOGsES+p7j29ltjalzel3080gGkHTPiCHt5+ulhOUoM
 p2pj/irap0x/Zjk34lkf9Fpwl+ow1jzuEgM8Gc6iMGloDrQfkoIa5wTCvnvbpj4jaObp
 0rUSyzK5g4iiAIPxvv7InlDilHTsy7VJ6gW9WOQ7uJdJcoGBppxL4pfEUXbh8bRTDEpa
 eLxS98ssO8tZp7h+lnZD47AViZJZ1uFspMLvU6GxeykCMmX/KG/WJRysK3pbdiKNvTQj
 5N4F/XlPpY9x+JdVUuSM58KFPlLdJ1GsoIPR68oRK2hSi5qB880QCAiRERBZnqrH5JSr
 20Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781884620; x=1782489420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XAcK458fLut29YrBXX4JA0FS5UqQPCx1uFviFFxfcaE=;
 b=kMgxsmkedj8FVDgi6cvKUvpefj1rDDoJE1JdEi7+fTOYiMck4s8PSH8WPHeaLv8n2L
 3fS8Euf98Po23THRQK3Pb9nMm8/PX3+EcwtttpP0fvoHUdqai1FOm72GklVegZSJ7xfP
 S+xDvzmLt62Ohbh3wDO7ryVtkuVeLJ8KqstSNvlWqcEhyno4pnb+GO1jC7dAYsccIVza
 70WQMsfFhnDhFNJxW/0H3/mFd4YB+fKmfntz/7jo4mnoEc2jsnjXbwaJ9AudyOmdc2ae
 C6ebCWbHWglA7+ueDjn6qvs+YMVYRzdMAbMDwdsaQSXhgtctKD14bs3MkgEKU/d/KzIo
 Bx9g==
X-Gm-Message-State: AOJu0YwZSUS4Y4tkOKX+/PZoZNfCZ5HBKIqCNb//ZjSHxd9BSXurZ2Mi
 zCIEeB1XKLSIaf1MTp6RNVIUh6Dor8p91Q5rQshSd/NgdSruZiUFdsuDQ3XzEZyVzrs=
X-Gm-Gg: AfdE7cmWZiG5xg8tXms7ii4JlLmWxx1LkRu3nwHdMeDmnSbBO6Yzy7h6kR3kz2sGeh0
 WpUHkIkU14K2oM2s7I3JhUbPrdgRDR0Yy/CYhTR/i3mD31ns7Y2h2FkIrIGWhnDXcesoPTySSzJ
 hOmN6KzQRMh93Rnk438aMHD+zWVINdiOcAvFlTIaHus/OYQtExnhE8MkTbX3VwpxGxE8EGMIPQ2
 On9eLZmKU28VKToTwc8FVM8s6zA7FHSZOt1KJINUZKidJ/a2HSk08AWt5oWWl1ZQZlOHO5IAXJw
 sb+B3aH59YfUCKomMeLcrC01j/YecVK2idUrJcOg0vhvuRRYhPeukbabP34NCTyRGp43kpXr8Cn
 kNE7ox1xvPES7/6FVly96OPchk0hPDccbPuCEhpXsVCygTixAG8RZ2MMLcY7rXSwXHVeC6nVyBG
 BVUsls1h0bzzAX
X-Received: by 2002:a05:600c:a07:b0:492:2c87:3d34 with SMTP id
 5b1f17b1804b1-4924233ef9dmr50085455e9.15.1781884620009; 
 Fri, 19 Jun 2026 08:57:00 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fce9590sm80114075e9.4.2026.06.19.08.56.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 08:56:58 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AB1425F94E;
 Fri, 19 Jun 2026 16:56:57 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <th.huth+qemu@posteo.eu>,
 Cleber Rosa <crosa@redhat.com>, Kyle Evans <kevans@freebsd.org>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Warner Losh <imp@bsdimp.com>,
 Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH 4/7] tests/functional: tell pylint not to check c-modules
Date: Fri, 19 Jun 2026 16:56:53 +0100
Message-ID: <20260619155657.944220-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260619155657.944220-1-alex.bennee@linaro.org>
References: <20260619155657.944220-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32c.google.com
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

To fix:

  qemu-test.test_pylint "/home/alex/lsrc/qemu.git/tests/functional/arm/test_integratorcp.py:83: I1101: Module 'cv2' has no 'imread' member, but source is unavailable. Consider adding this module to extension-pkg-allow-list if you want to perform analysis based on run-time introspection of living objects. (c-extension-no-member)"

Manually running python3 showed I could indeed import cv2 and call
those functions. Rather than allowing pylint to introspect lets just
tell it to skip c modules.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-ID: <20260612140531.3530387-1-alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20260614100902.885698-5-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/pylintrc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/functional/pylintrc b/tests/functional/pylintrc
index 049c3e76f12..949bea611fe 100644
--- a/tests/functional/pylintrc
+++ b/tests/functional/pylintrc
@@ -58,6 +58,7 @@ confidence=HIGH,
 # no Warning level messages displayed, use "--disable=all --enable=classes
 # --disable=W".
 disable=bad-inline-option,
+        c-extension-no-member,
         consider-using-f-string,
         file-ignored,
         fixme,
-- 
2.47.3


