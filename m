Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44E75C3064D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 12:45:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sNAxu-0006YN-OE; Fri, 28 Jun 2024 08:44:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAwh-0004tS-NS
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:43:23 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sNAwY-0005j6-It
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 08:43:14 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a70c0349b64so74688766b.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jun 2024 05:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719578589; x=1720183389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ho2Bfe7yXa5eu8lKetJ/WAF5D27mUTaA0a7vXnXcLIs=;
 b=UiA3wMdDi9azzqANHOWxpBFdUIGqoYCn6onDTaSQohjFr5LzBnLnsnvxr5xxdzb+P8
 amdf8MDjFypgaTwKoZrmglvHySqszm14HaCvUAlbZtL8wNNG62sIRPPD5uLnNPZff4YY
 mGk8773BJPx9LTgE3UZyLTOg9bnA5YboV3krgxTX2VKJoUPT2fYp/yvq2xmYTirGvvCJ
 ZiuU53MCpnAYi+YH+YDclGYyzWSokTMfmD3yXFDXwDxRythWnNiCksqPXu8xG3jRW0Dy
 D4xkR/rwlPjhMoar55nRWL1ZKcjAZNvOTlNtfwT/agqD0yWsUONBQqwh6ij2HhBNHB6r
 ewYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719578589; x=1720183389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ho2Bfe7yXa5eu8lKetJ/WAF5D27mUTaA0a7vXnXcLIs=;
 b=hlveH9aaZPy5sK6zv74i7n429y2mfTrTuytCNdMvTDL6LsgVzqB53wwwFdpT2PLKJJ
 ijZbzWpkyt/DOT+WrkvUhDq6p5fzosd0pe4+t+PvMfo0lrqCWVRAP7HrNWONBgENJbuH
 4CV87vctqfTjxY7CwaLLPzZXEEsAvPYB//iZL8Wq7eieVbqc2w4N9pPwPYg9JE+95otS
 QIRTBZyI9oxzLxtWcnrFGCV2QxnaruPBqIgLYL3eaihRj40qaVcM1vmKgDEMAV7T5Mq7
 omJesKDi7H0OVSHlg3+5AAQHrYkm98CoQhC8Yc2JKmprYrAtOiQnFo4BxNu3k/7EfgRU
 lnIg==
X-Gm-Message-State: AOJu0YzOjU+3EJrgbr7Gd1shqYl69wNGXPyyhuMB2bN0O/IlzMghtWde
 Vzc7QozA7Qw2+KPi7pO3obVP6xkRXIhrvXE7UkKsFykd+bgNd1eGgRRlDIMLm1s=
X-Google-Smtp-Source: AGHT+IF4G8patYBExv+hrLhLi4FytMuhVq1PzZO7m0o0XKrHJ63Ng1gMHJxbe4YfWmLRAqEMyKouOA==
X-Received: by 2002:a17:906:b20b:b0:a72:8d40:52b8 with SMTP id
 a640c23a62f3a-a728d405f59mr429715766b.3.1719578588974; 
 Fri, 28 Jun 2024 05:43:08 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72b4125807sm34634166b.86.2024.06.28.05.43.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Jun 2024 05:43:03 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CE9505FA36;
 Fri, 28 Jun 2024 13:42:59 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Peter Xu <peterx@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH 09/23] plugins/lockstep: preserve sock_path
Date: Fri, 28 Jun 2024 13:42:44 +0100
Message-Id: <20240628124258.832466-10-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240628124258.832466-1-alex.bennee@linaro.org>
References: <20240628124258.832466-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x631.google.com
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

We can't assign sock_path directly from the autofree'd GStrv, take a
copy.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 contrib/plugins/lockstep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/plugins/lockstep.c b/contrib/plugins/lockstep.c
index 237543b43a..111ec3fa27 100644
--- a/contrib/plugins/lockstep.c
+++ b/contrib/plugins/lockstep.c
@@ -347,7 +347,7 @@ QEMU_PLUGIN_EXPORT int qemu_plugin_install(qemu_plugin_id_t id,
                 return -1;
             }
         } else if (g_strcmp0(tokens[0], "sockpath") == 0) {
-            sock_path = tokens[1];
+            sock_path = strdup(tokens[1]);
         } else {
             fprintf(stderr, "option parsing failed: %s\n", p);
             return -1;
-- 
2.39.2


