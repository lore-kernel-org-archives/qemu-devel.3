Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6656C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 11:52:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFBe0-0007j9-Ah; Thu, 06 Jun 2024 07:51:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sFBdy-0007gu-Hm
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 07:50:58 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sFBdw-0000t2-U7
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 07:50:58 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-57a85cc2d96so1009181a12.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 04:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717674655; x=1718279455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yrxyXfZs5W1u+v7cQkEqlaviI1dtC3fwnNPGtYTmuWE=;
 b=KLu3UfbRWC0NKZ3ZXGaKyAxJdBvPs2kkbpYnltxsUNbzDLyddAzBQwEvIqSMqjDRRI
 x8KoiYIlZOowv3OLZJ8Pe57Hadg0GzwtZ8SY4faLgOjtXcSxrqXePTPD1FTDvN/yvxco
 ViYr9bXyo7xQ1HVxdnZpd11Zcq7GntD3W4tWkMuNLw40ovy0PmiminMXaVU6c7pvj4Qh
 IE7PCV3IvT8WdxNv7xuWzUtD2U0l+k3VO5v5W45Tup+JWJ3WYqM0MbynuM6kgEQY1bYp
 xIyxU22HbsD63D33C/ytiApcmCu22/FufmEhrJdUYsSvmpS0cl58j71HV/BZDfb5kit0
 juFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717674655; x=1718279455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yrxyXfZs5W1u+v7cQkEqlaviI1dtC3fwnNPGtYTmuWE=;
 b=aLUb5W7U/GoWvYc8eLuYiJHhjJL6eDODPBShmq+zRoyOIL9uOrKA/1jW5PiN6+8DDw
 zYIjVGCFqClenYl8BcfJIovKWHqPdYYsTd7gnaEmILhcueVn+ywkEeMVagTdvw1Oi9o9
 RIrqHuhoK8akITbm5Y78OiKA36q0qCrNGZ44TMP8/UIFHMytgvoNFBuJKWfqahChr0nP
 THkvfo7CUxQR9Cb3EROQNAewQ1/1M+gMRbdpMv9GydWHw2eiLgIp1nORXk2KLc3vu9uC
 QM4VRzKyf5zgXcb1nqKReIAa80oBrIbAL/4NeD9EWMw4KevQZhIS0kQMJnJHUnaqwRl6
 A6OQ==
X-Gm-Message-State: AOJu0Yx+a2cGe8DyvgCcoG6N620Kznr0cpPgOTc0P0WakkZpig0fNrnI
 QylDH2fsCzcK8emePqaS/tg0XFoDBacfm2U9+IPqZP+hje9/scEs6vtWl2B8tuQ=
X-Google-Smtp-Source: AGHT+IEfoGSvKexfenco8QQm+eVQgXRBaznFkbNLu6wwiyr0BxcRiZ2vviY0Z+TQkg8EjJzA9EpZgA==
X-Received: by 2002:a50:a68c:0:b0:57a:4b31:5d71 with SMTP id
 4fb4d7f45d1cf-57a8bca482cmr3564687a12.26.1717674655545; 
 Thu, 06 Jun 2024 04:50:55 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aadfa3c47sm971703a12.16.2024.06.06.04.50.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 04:50:52 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8BA365FA2A;
 Thu,  6 Jun 2024 12:50:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 07/12] tests/lcitool: Delete obsolete centos-stream-8.yml file
Date: Thu,  6 Jun 2024 12:50:42 +0100
Message-Id: <20240606115047.421045-8-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606115047.421045-1-alex.bennee@linaro.org>
References: <20240606115047.421045-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

We've missed to delete this file when removing support for CentOS 8.
Since the current upstream version of the lcitool removed support
for CentOS 8 now, too, we have to remove the file before updating.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20240601070543.37786-2-thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240603175328.3823123-8-alex.bennee@linaro.org>

diff --git a/tests/lcitool/targets/centos-stream-8.yml b/tests/lcitool/targets/centos-stream-8.yml
deleted file mode 100644
index 6b11160fd1..0000000000
--- a/tests/lcitool/targets/centos-stream-8.yml
+++ /dev/null
@@ -1,3 +0,0 @@
-paths:
-  pip3: /usr/bin/pip3.8
-  python: /usr/bin/python3.8
-- 
2.39.2


