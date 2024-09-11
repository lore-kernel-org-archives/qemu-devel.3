Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F1E0EE499D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMKz-0000Ff-SA; Wed, 11 Sep 2024 08:20:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMKv-0008RW-U2
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:20:42 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMKu-0007z5-6h
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:20:41 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42ca6ba750eso5402905e9.0
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057238; x=1726662038; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GfEvkwnEEFGS6Fqt0EDQ+b0+iYRPDGyqpn6F5IpXr00=;
 b=hYpHYjuck/nEUKOYtEN/6CacPosDq5vpZlEjr6YczhrsocHGyG2/haq6eR6KUhMlb7
 RdfJDPkcD+pSTZcXuEKKKpriBWgtPkH56Y1p2CSd2HcccL68gfgonwh0kY0mMYng8znu
 vsdZnS+WbrbKCcLQjo9vDAH1NFs6U53XHzjAikCUtB0A9GP5Odw9MmXJcjzNTvB4put3
 Lkzhs6+j/73LXzp9bnle7+0A0YbDtJ+JuhW/TDSDyjl0McL+0Ur0MNUvSc6+8qrWAY8S
 d2u6VfVtjIOZ8wG44+hf3FSL+3hf0/Ouep269JV0RXMh96tvgRrGIIR9tnPeEV89YJ/Q
 lflg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057238; x=1726662038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GfEvkwnEEFGS6Fqt0EDQ+b0+iYRPDGyqpn6F5IpXr00=;
 b=q0Bz4MXtUmEKRdDtp/GQMUiiJ/I0HXdVjxOXG/KYzOzEm58VR4gOYjJQSRSPsv68zO
 UuXw118XttPM0PPRUSciFBS4+6UirR+9IMgccj5a28jSkOfboWrQeQ8LCV6DO62Nhbdt
 A3SIf5ZHpp7yH8xTp4LxjCYc0iuPYK4AacM64JBBqBR2FpOzJ2facdUfbvmb/V9fLFVp
 X+hvfUbYizYYvpgFIGEegmt+mih8W2G9JHBU8Q4C3epqJNNeQ3A//1uEZmSt1TLv+P/N
 qAsqYQARGxgaANZhvuXjgDm0TuuxejkD1gYRwXWDizA7Orf0zIfK8s5crhHWdWpEBerE
 YsIw==
X-Gm-Message-State: AOJu0YwimChL402Oj/ThYt+syPkO49WXzvXTev+bdlgv0WDpVo/TLCl7
 t4NqraELR0mkIS7zMIW88mjQqxmQext1hp2B7QAfRzPL/s0RZ5yrvDjJVIlZZt9QXwYi8OLRINS
 A
X-Google-Smtp-Source: AGHT+IFkF2GBTGlu4z0kQGqgN7aJaOVMI0P+pTkgSdGzuGeb811S1OLq0vTyy4V1ZRNWvyna1+Toog==
X-Received: by 2002:a05:600c:4fc8:b0:42c:bd4d:e8d6 with SMTP id
 5b1f17b1804b1-42cbddbd72bmr37897835e9.3.1726057238429; 
 Wed, 11 Sep 2024 05:20:38 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ca3a3cc31sm166500105e9.24.2024.09.11.05.20.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:20:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 56/56] ui: remove break after g_assert_not_reached()
Date: Wed, 11 Sep 2024 14:14:21 +0200
Message-ID: <20240911121422.52585-57-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240910221606.1817478-37-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 ui/qemu-pixman.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ui/qemu-pixman.c b/ui/qemu-pixman.c
index 5ca55dd199..6cada8b45e 100644
--- a/ui/qemu-pixman.c
+++ b/ui/qemu-pixman.c
@@ -49,7 +49,6 @@ PixelFormat qemu_pixelformat_from_pixman(pixman_format_code_t format)
         break;
     default:
         g_assert_not_reached();
-        break;
     }
 
     pf.amax = (1 << pf.abits) - 1;
-- 
2.45.2


