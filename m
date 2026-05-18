Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5DFCD4F52
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 10:23:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOv8G-0003qL-JF; Mon, 18 May 2026 06:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOv7o-0003L5-2j
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:23:04 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wOv7m-0004gj-BP
 for qemu-devel@nongnu.org; Mon, 18 May 2026 06:23:03 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso20121345e9.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 03:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779099781; x=1779704581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l/noG8euWWJXCFN+kdLvLDAJYc4WlKtouT0lTZOgmZc=;
 b=Mh0kTC1cWruDmo+P9Vs77WMWuPCl6Uc2wDiIyPIm2/UAQ1Mao9NGR4sI21Y7M6rWzU
 mMBUg+F4534vSq8NWQgpRFswkv1JCsrOb3Gm3DI2W3iZyr0x4+aHI4szjhwQ0IdBx029
 wlZYeHDi248K9Gt8P+OV4WdKWEJDExilv/5fOtCbHg0uUlEiOwbueB7+mLByUz5lqzQt
 S6+QhyQA0gbRr0E/1fXEoEQrzhrMFLty8cgmG6+h2UD8MuZ+9fcGE5WtRwGjPukxmlnt
 fjZF8bowaHUsT87RIKBp5/BbVPouh8oJV6Ks9W8BdPmIFo5ASpgxVTvVIQbU90YyPaRQ
 woHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779099781; x=1779704581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l/noG8euWWJXCFN+kdLvLDAJYc4WlKtouT0lTZOgmZc=;
 b=ofBq24ALrBdg17dEY9MiMzqIdBpGnX65f0kcQ+OhNplmBRRdXwRaId+LSexRrSk3Vf
 KvbwHYGkWMxVsrTPuu7vVrrbBYawX7A1f1J8GmguV1gxkjqlnPtPUjtBfJI7vOVQnxaH
 PZow3FLNXw5ZAlI/9WP4WIKgf/b+Xd1w5sOAvNrimmjh39EnI88iZz8de0Wh84JE5i1Q
 3OHYHdTHzIRxmRe6nCtti4/Xb8Uj6BwFkXcVFzj+XuefcERjiIJsNOeqGxdfxQFKTPPS
 pl7o/ut+MceT98f6hFxAVNszE7QbdzXLfXbYtTrEn0nRRprpwX0l7gKwly69yK2zAobS
 uixA==
X-Gm-Message-State: AOJu0YzzydBY7Udss4QQlnU00awky1AdkqmW83Ia4sNr6vCI7eopzwBD
 GAfQ4nLfM/mvvI85GguPpjPaBwzBc8uhcf/UmobBfaLq/oiT9iPhmHgJ3nfPjkFSwHer70ifO/2
 XS8xmcHQ=
X-Gm-Gg: Acq92OFp2hP5BjpQJh5AGOQJvlTwLwm4i0QPNAururGueegvZ7Z70FKORwkL2ec183R
 JWgCEIEDsJbqC11/93rnpALRfhKtm0RyaY0LefEIIBQ8aEhgBMgFqfVhIGOdQxYTzMyhs+FggH9
 S1rVhGVMQ4NGQirqcap0tp/vRCbOBiiOAq+p3m562ZtkYKUlOzVXlDg4vnpkX/lNAltdpDiX5WX
 S4Zk/aqeA0DVfnIqqKqKA5pUwg1oFgqkgBvcGzz563sRFsWVfsEKY6fJzCh43y/tIbw7iW38SHH
 KSoXdtDczFcr9sJsjf7jdOXI0nnzlBkk1I7tFDbUJ9z0/6m12bsECnRNc11IOb159dM08iMjV9q
 SI2xkK96+3K+sid9usUNzPXMLaHjZRuPCGHb+fTDWW2aq17Hp/S8ALu5F3zFihE5fbcg3pIHhUr
 GGY7uk7dS4EGMNIRT3Ng3wHPUKD1gVo4RCTsiIu/gE59fdHLHL7Ostp9G1nWpVy2prbhWdtWD9o
 /eKoZb/eXE=
X-Received: by 2002:a05:600c:6383:b0:488:c014:34da with SMTP id
 5b1f17b1804b1-48fe651690fmr225386815e9.26.1779099780679; 
 Mon, 18 May 2026 03:23:00 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48fe4c88495sm241080755e9.4.2026.05.18.03.22.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 18 May 2026 03:22:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Song Gao <gaosong@loongson.cn>,
 Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 5/7] MAINTAINERS: Cover python.docker with Python library
 section
Date: Mon, 18 May 2026 12:22:20 +0200
Message-ID: <20260518102222.80735-6-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518102222.80735-1-philmd@linaro.org>
References: <20260518102222.80735-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Cc: John Snow <jsnow@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b15cc796a97..972a8346046 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3484,6 +3484,7 @@ M: John Snow <jsnow@redhat.com>
 M: Cleber Rosa <crosa@redhat.com>
 S: Maintained
 F: python/
+F: tests/docker/dockerfiles/python.docker
 T: git https://gitlab.com/jsnow/qemu.git python
 
 Python scripts
-- 
2.53.0


