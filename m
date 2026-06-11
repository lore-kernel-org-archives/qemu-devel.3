Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F10B1CD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 16:26:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXiE4-0003jm-QQ; Thu, 11 Jun 2026 12:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wXiDx-0003j5-5U
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 12:25:45 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wXiDu-0007RZ-4C
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 12:25:43 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so40207395e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 09:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781195140; x=1781799940; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AX3GiLTOFLOOPxiWr4BGTgpgyPiCgwv+RqYv7ckAKBQ=;
 b=TgoSg4+V6JVgkB7LjjWORjltXxFdKASE39qPR5E35FMs9nWMaYb9Ixe8+GDZcCNUEU
 9KueSBi6tcycFh1GuSjyC0OWPRdrbWzHcBjErndE/UIe7esETKxiao5g2E5ytg2ejcay
 ifvdvLZVse+fGBZVde6VNg9mZQOVoGvbCsKylJ/mekL5kAYwv77XClqqOaJ0yie1FE2o
 Pg/HUdrAfSclsiALspdEtkaAolWHKWMaF/4BSErKMXQM2NHleCJ209hkVfSUx3HSRxUr
 3ldayRU27FnO8vwi8tGWDxAGAuEdN3RQkvLIauika2w7hOvN65cl2aTkaAOEXsmFNClq
 A8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781195140; x=1781799940;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AX3GiLTOFLOOPxiWr4BGTgpgyPiCgwv+RqYv7ckAKBQ=;
 b=joP6t8OGv5yZTE7KTVmtMXm58kGJluzIanagsIFVALdozlOuTce9dykdpZ4CwE1bsm
 Ro6s/bvx3yTK4bclIzJobjvOYQxdWXzfeY8ZNyrJpWpp6vmUpJERN4KCKYXpITY86XOk
 Xhf6r/PiMVCF+FX625LM1whJwEXY1sYxVJWDPI+RPiIAVVOByPS6dJ5x8bC7NC+GaOTC
 Ye+VGmYPmxKiwvmkE9QLr8AMk6Wm9FgVCS2RJDoudNxmkOK1ilIKBf+IJW1lpEyqLemR
 B0wSmkOFj/M96N985l967IjxWD5gmER0hrcgqDyL8zBDj3q5cm537anncdj8/QOELvfG
 Hh7Q==
X-Gm-Message-State: AOJu0YxUJ120izMbc8VZmG661/o0DZbsIX+MS/EyJJJO75LBMi+GdB6V
 /bjEOEHTHqjGPi1F5VU3USqOE9qPhUpyo37afKQv/6QkzlxdvjPaxzCV0FRo8pvomHo=
X-Gm-Gg: Acq92OEcYjxgdwddb8R8d4d43kTJNr+M5KMkyIXwiCbGKOIa46cOUd8spG3aQ1GQPux
 wCFfFRSuTiPQLuP9E/cdB6ej66YhDuixLgE8KJJURAC781529bQm1cRvJifW+zBBIw/kS8zcTPC
 RyBfdGCH1WRKzVgbFwSv2VNqt/g9zwVBs4r4zLXj7CK8BaqIyuiEWJ0tIWEBh+JFALnIONXzHsk
 /BIcWb5LB8IbYNdCeyWeJq3tE5KNaLHHE2bmzPfhl8YUIt+wePexdcriCaDkHd0RUrMcp2TXDDD
 6ng/92twB1xGKitXtvLntHTkOK9vsHX4Ipg4jgVo3EAuO7v4nag/xeDT5nXBEkZpgcQByKnxzvu
 xErmbpZnOJppQVXsk7n2WkWhqnAvaVz5b6dvexC0/mzfEfKbBhEsfYG5Pz2qLQJL41Ber4QS1tu
 yAZGtBFpN1jQQUA2wtFCYCh0g=
X-Received: by 2002:a05:600c:3b07:b0:490:bb45:79ef with SMTP id
 5b1f17b1804b1-490e534a723mr51202095e9.0.1781195140388; 
 Thu, 11 Jun 2026 09:25:40 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2c9057bsm89453545e9.5.2026.06.11.09.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 09:25:39 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id A417D5F894;
 Thu, 11 Jun 2026 17:25:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [RFC PATCH] tests/functional: allow pylint to introspect cv2
Date: Thu, 11 Jun 2026 17:25:36 +0100
Message-ID: <20260611162536.2184620-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
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

To fix:

  qemu-test.test_pylint "/home/alex/lsrc/qemu.git/tests/functional/arm/test_integratorcp.py:83: I1101: Module 'cv2' has no 'imread' member, but source is unavailable. Consider adding this module to extension-pkg-allow-list if you want to perform analysis based on run-time introspection of living objects. (c-extension-no-member)"

Manually running python3 showed I could indeed import cv2 and call
those functions.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 tests/functional/pylintrc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/functional/pylintrc b/tests/functional/pylintrc
index 049c3e76f12..c4c5237aa9d 100644
--- a/tests/functional/pylintrc
+++ b/tests/functional/pylintrc
@@ -82,3 +82,5 @@ disable=bad-inline-option,
 
 # Minimum lines number of a similarity.
 min-similarity-lines=20
+
+extension-pkg-allow-list = cv2
-- 
2.47.3


