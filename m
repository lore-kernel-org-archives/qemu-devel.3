Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9636C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 16:24:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYpcj-0000HV-CU; Tue, 30 Jul 2024 12:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYpch-00009W-LB
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:22:51 -0400
Received: from mail-lf1-x135.google.com ([2a00:1450:4864:20::135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sYpcg-0003Z9-5w
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 12:22:51 -0400
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-52efc60a6e6so7645535e87.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 09:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722356568; x=1722961368; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xzDMp496rGrP+ZJVpvdPMnx/krw5GVt88UpcZ2FrH9M=;
 b=NWMXmfdjrxQOlAcs/nJvuzluGuwDzkB4Mw+7nb6K6qOFxXVuLqAuFdoCNfHz2OJqQH
 iybK/h9y2978wsKjc4qortPWYBRuYh+RcaoOP53mYhnjYIXPTGRltzBMGGUQLNcudqdx
 /j309EhMo5eNgknba3Q6GPVU+9LPD/S6ZGFaAUouiJLpUPzezKxvJpYXaO5P1O6LPCAR
 +srFLsOO0PFXUb7Whg54SpdZe6FzIxUQNW0BufOuhYXmOtAXckWdd9q6Pf3vJhW+9gkX
 izbg2JeO7U7kdJQCm1QxuBbgND4rQ9B7R3BGuLVmTD+SefdkrU0TfnpNicf1apmFQb/r
 /YyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722356568; x=1722961368;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xzDMp496rGrP+ZJVpvdPMnx/krw5GVt88UpcZ2FrH9M=;
 b=pyJd3YB8D/pRITnFG48kuATFJG7+hleaP1ulSuD+fIE+sn+KAQ81H//Z3JyhQ95x4J
 uQliRZMZwOkptbkmm04cZ5ZosMqxAD39TrG4iT7Tfs06mHdsGtQfII7thy33qXRvHkLr
 tiYKt0E/tMQuNPZ8nZxW7crqwvBSk+a1IBkrHBOIMztaW4OVHPDkxC+R9XOU5V2KvF0o
 dGRNZ8fJJpaetGAtGBuQ0IDWt7hl39CgCk1RltJvepPhukHE2OJpa5XMMXorcg3IcA0f
 ITZ55bR0vt6pmgXRL8JHqLl8quqFkYuZGYRqgGqRJNCoqVmGGSGnIChnjxIFdoNxjpum
 +ftg==
X-Gm-Message-State: AOJu0Yxi2GJfnoaBOjGBAKyRbTT5IalZGm3JDhw7hd80AZuUP5Kq440H
 wgeBANFS9/ZI7B/zlLBnkce8KEZYcueEUnI/3bE+iENA6yNkGbzQZrmzWlSsWfY=
X-Google-Smtp-Source: AGHT+IFhdvbNCMBjCEL74dY7Ca07Nb/jYB8vyIk9yJj9fiKvo5Vfh+bkyn0xF0SuautsuWHoKcVzfw==
X-Received: by 2002:ac2:5051:0:b0:52c:df8c:72cc with SMTP id
 2adb3069b0e04-5309b2bb607mr6887766e87.43.1722356567823; 
 Tue, 30 Jul 2024 09:22:47 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab23132sm663923866b.27.2024.07.30.09.22.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 09:22:45 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E170C5FA0C;
 Tue, 30 Jul 2024 17:22:38 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 11/14] contrib/plugins/cache.c: Remove redundant check of
 l2_access
Date: Tue, 30 Jul 2024 17:22:34 +0100
Message-Id: <20240730162237.1425515-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240730162237.1425515-1-alex.bennee@linaro.org>
References: <20240730162237.1425515-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::135;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x135.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

In append_stats_line(), we have an expression
   l2_access ? l2_miss_rate : 0.0
But this is inside an if (l2_access && l2_misses) { ... } block,
so Coverity points out that the false part of the ?: is dead code.

Remove the unnecessary test.

Resolves: Coverity CID 1522458
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240725164851.1930964-1-peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240729144414.830369-12-alex.bennee@linaro.org>

diff --git a/contrib/plugins/cache.c b/contrib/plugins/cache.c
index c5c8ac75a9..512ef6776b 100644
--- a/contrib/plugins/cache.c
+++ b/contrib/plugins/cache.c
@@ -558,7 +558,7 @@ static void append_stats_line(GString *line,
                                "  %-12" PRIu64 " %-11" PRIu64 " %10.4lf%%",
                                l2_access,
                                l2_misses,
-                               l2_access ? l2_miss_rate : 0.0);
+                               l2_miss_rate);
     }
 
     g_string_append(line, "\n");
-- 
2.39.2


