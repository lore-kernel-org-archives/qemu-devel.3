Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0708CD6E4C
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 10:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSuEu-00031P-D2; Fri, 29 May 2026 06:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSuEr-0002zr-7G
 for qemu-devel@nongnu.org; Fri, 29 May 2026 06:14:49 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wSuEo-00016K-K1
 for qemu-devel@nongnu.org; Fri, 29 May 2026 06:14:48 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso118763365e9.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 03:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780049685; x=1780654485; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G99Anl7Q/adNL+l2LO6ngRqKlQMvv0dNrSiIC3J0XuE=;
 b=EXXF1d2KRGXquoPCD/b98c4SQO26CY+r9dLJWs7ZgUUfQzHPO1q0aW3DCIRkwTfzDJ
 It2gf6YQ9sFrkSdsxIKi3hMx3vwC+sdpYphMPb2xBJuQbj45MPy9NsXiGH3z2Do0wkY8
 u9Sx8s2peG9K0uHAwJCrk3HaVU78G3EfuH7cTdN9Mq6KWN50zwEJxQibKA0S0Ra04Oga
 8KX2ua+DkHJdk7R5CQ37RP/XxWU3S9Zkkj1MtuYezOyB9RagNpZhGOktADnS1BgsNnBg
 o55BTdHIMHW9SZ2BFz1ywA3o0EC4cMQLpp3U2AsUkh5M3CVGvjHyU06zlv6DYIAlCjvT
 Curw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780049685; x=1780654485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G99Anl7Q/adNL+l2LO6ngRqKlQMvv0dNrSiIC3J0XuE=;
 b=F2qKry6MUbEa9qgoklcyaC7obj8DQFvQ0JVg3LwHJ0P2RAUZMvktMOPHNuxvQCxpi1
 C+Ge5i4g7hoQV3b2TFyav7rl3KaLFEf+PiQfgQLegr910zT1j9BudE4f+CasdGgJp9QD
 XdOWh6dcBKutpRjgh8TpJZMsn7+6meY5BzR3Js6L1GYfOKQ7EwJgy23Lyf+md1CiXVmL
 El6pTxrNzscFxVFmBeD6XLUGz77CC3sKjvxbPMNndlwLnc4WGblklivT7i1+69nn5yRE
 PBMwJ6NBGZyrmI2/8nE0iFRqMAbRNAMzED3RWCMKcg5e4wp516ImU9gtdk1OntIC67Ox
 YAug==
X-Gm-Message-State: AOJu0Yy/azJmb83KzlDGuBjFUAtiJx4odn5dip59ghbs+58M808F13TY
 nKN9W/fDlSKj+L0SaXSwTJNoZa44/tqIDPIyWsdpJ6ejCBL6z04P2j4rY82smHkP2ks=
X-Gm-Gg: Acq92OEl4auP6POYFUFJnabIWwrcjHtndyt2UBP5sPRjImBEnae88c7iAWz//XZdh0g
 W+XvnICcjzUeXTWtP3xfpEmtULTXXZwNhoTp5Gq244iKlXZR0RGJlTIZbHY1FCabYGYdghtzskV
 Hwc4ilC5VcPlBU2OktaWGviorTl37i2JKdNrg51Ms68/YJ2C+xjiktrhj4kwe2FQGxNmqHZgAJg
 j7lO8BqdA3fNlH+aEORW9vz7ymZjUvBLctX6ug+DWEjjKjXO/Ra3Tu1Nj3dhmcsECYJs/RvP/sD
 pbSvmmjD7Ugrlf+zykJHEJiNbOszONJWlDHVQXgxcidA2LRC6sOfAppUuPPLWYQHvnyexdRCEo+
 jAIOGX+8LcFPZGpgiuSGNPl8bVv1UFpTaB02tM7Kz/XeoMAHO4XHicahVO3pqzdeIFpyEqstc9t
 lHNRb+wUJfzCZonBJn+6eqAfkiH1J+rotkTA==
X-Received: by 2002:a05:600c:3b10:b0:48f:e230:1d12 with SMTP id
 5b1f17b1804b1-4909c0d2195mr43594515e9.31.1780049684855; 
 Fri, 29 May 2026 03:14:44 -0700 (PDT)
Received: from draig.lan ([185.124.0.195]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4909c0495fcsm18799075e9.0.2026.05.29.03.14.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 03:14:41 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id DC55160FAB;
 Fri, 29 May 2026 11:14:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 12/12] MAINTAINERS: add a section for AI agents
Date: Fri, 29 May 2026 11:14:37 +0100
Message-ID: <20260529101437.410181-13-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260529101437.410181-1-alex.bennee@linaro.org>
References: <20260529101437.410181-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

For completeness add a section to MAINTAINERS to catch changes should
we decide to merge this.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7eb5823da61..0a14b0aaaa4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4561,6 +4561,12 @@ M: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
 S: Maintained
 F: docs/
 
+AI agents
+M: Alex Bennée <alex.bennee@linaro.org>
+S: Maintained
+F: .agents/skills/
+F: AGENTS.md
+
 Build System
 ------------
 Meson
-- 
2.47.3


