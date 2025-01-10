Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC622E7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEzX-0000Q5-4i; Fri, 10 Jan 2025 08:23:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEz4-0008LL-IH
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:23:32 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWEz2-0005cc-0X
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:23:30 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aa6b4cc7270so314147666b.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:23:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515406; x=1737120206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=48g6qRzdUsGJbWFtW2KgF8TjHic1pStKCydxHudcjoc=;
 b=aLFZrCWyUzeyjJTLMBQm/Hf2x8lv/Upjusr+hbsJktldiucA4dwe4uky4xElIPlj+U
 hzlTU494JTPirAvags14wo0FZx8Mumy/H/YWSVMhNONCgF5KNNSW4dMNMrewB7622FNU
 TPJyyCTtkmdHIrmAONN2t+18Ky1Kt/dsKo93t1cgYjqINAUDJeUqLouIn0BecFRs5f8H
 KE4FkLr29bjtQlYfNt27cph9S1xT9v7lB4JdDjEbpJQzbrfgy7/+To/D+5Vt4hYWbMW/
 sr5h/M81mLroXUBryvF1LM6KSTDA/oxAR+VROpoB/TLW6CDGoArgMot4+AiKsG67Bj43
 pAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515406; x=1737120206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=48g6qRzdUsGJbWFtW2KgF8TjHic1pStKCydxHudcjoc=;
 b=OT3ex9risu49Ig9InkmqcdF59DLV80UXBs7Go3WDwcwTqw+6iyL8HMZy6cSaQ68ZBV
 GIorIDYJImhyGaUdAJbTZqXuUeqekRu6fFERddlf0EQiLK79/oPNZxDzL7l0nN4WJ6WX
 DEbZyVH9edZvUwy8iVk7Y79xQTJ3yKEojBVnETImAfED4UPor3idrNLItHmJ959ItreO
 iUUH66HSub5nbaHF7WYp3QIasYHWxrcYfB/rvV24hWD/nqiv3JuLW3DMPQyQL7eH3Ce+
 45sccFbWdSIX+180wg80gNhH42K9v9NAJ35NlNEaas0Pj52jFrZHnviZkTIN1vO403B9
 T2MQ==
X-Gm-Message-State: AOJu0YyNmzUjLxQCy82Q/ku4Wznu/tFnfjwK/lirRgQRxYx3Uf3MT8LS
 P5bMTD4uUXgvkum6zZnyICN+GH1IDyEsrfoDI/dEWzgj77Xz+ZpkUyei/rc0iy8=
X-Gm-Gg: ASbGncuP8wIftwHy0jKYlttaL63mO6pAhlvkCpiFCllFLdUFepTOXMHdABGT7eUnA+I
 hMNwR30u8MkPDmILH5M41QrUDF0/WVmuzTPDHm/7xk4cf/+MySyWy9xD9YwljJ2lDjE1WvjESdR
 XZqtqR4Bo2ZmyZyiTGKANYELrdzA3AjhigDsWLQ35Xk+CiJH+JhZrFPd23TUu8VHfA9c4AX9f1y
 2r3KrdcAfQf1MG482ddxSkYkIoTNGGL8IvimLVB+2/0KkTB9MjWRRA=
X-Google-Smtp-Source: AGHT+IE7YYPbhoTVIt+lMRUOWF2wKnOuo1GzsMi2ta8Cem4H+VwFvFoReemcgrpxXy7OG5ThzsXveg==
X-Received: by 2002:a05:6402:2548:b0:5d4:2ef7:1c with SMTP id
 4fb4d7f45d1cf-5d972e639e4mr23324001a12.24.1736515406264; 
 Fri, 10 Jan 2025 05:23:26 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c90dace5sm169304366b.60.2025.01.10.05.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 05:23:22 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0022A618BC;
 Fri, 10 Jan 2025 13:17:57 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PULL 32/32] MAINTAINERS: Remove myself from reviewers
Date: Fri, 10 Jan 2025 13:17:54 +0000
Message-Id: <20250110131754.2769814-33-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110131754.2769814-1-alex.bennee@linaro.org>
References: <20250110131754.2769814-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

From: Wainer dos Santos Moschetta <wainersm@redhat.com>

The time I spent contributing to QEMU was great, but I've not been active
for a long time now. So removing myself from the reviewers list of
"Integration Testing with the Avocado framework" and
"Build and test automation" subsystems.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-Id: <20250103194450.360789-1-wainersm@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250108121054.1126164-33-alex.bennee@linaro.org>

diff --git a/MAINTAINERS b/MAINTAINERS
index cab9018d9f..c1d954c9de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4152,7 +4152,6 @@ M: Alex Bennée <alex.bennee@linaro.org>
 T: git https://gitlab.com/stsquad/qemu testing/next
 M: Philippe Mathieu-Daudé <philmd@linaro.org>
 M: Thomas Huth <thuth@redhat.com>
-R: Wainer dos Santos Moschetta <wainersm@redhat.com>
 S: Maintained
 F: .github/workflows/lockdown.yml
 F: .gitlab-ci.yml
@@ -4198,7 +4197,6 @@ Integration Testing with the Avocado framework
 W: https://trello.com/b/6Qi1pxVn/avocado-qemu
 R: Cleber Rosa <crosa@redhat.com>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
-R: Wainer dos Santos Moschetta <wainersm@redhat.com>
 S: Odd Fixes
 F: tests/avocado/
 
-- 
2.39.5


