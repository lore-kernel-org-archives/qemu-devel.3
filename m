Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688B4C3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 08:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKBvk-0007w7-EK; Wed, 28 May 2025 04:14:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvb-0007u2-Po
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:24 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uKBvY-0005Cw-OS
 for qemu-devel@nongnu.org; Wed, 28 May 2025 04:14:23 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-44b1f5b917fso25867515e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 01:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748420055; x=1749024855; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=azdm+UxBkdRxIzgKmwhwW+GH3cYuHoEtpkJtFbR5x4c=;
 b=eCDfRk0jEnnEzUB7olLHyzPhQw7xnrF6qgBuqWmx397UMcnMYVHLelgYnyqVBfpKAh
 bHiHCoA8kgUotg3MJY8LLQm2pY1iZ93BZfRCupjLTqh/BIp5n7B2N1yJKqVMaAqgzFe6
 5igG37QxY6e5QxgcrIGYeTWXIIEG4Zym97xIavlPh3VFBp55+OMQCbnXE+wy8Z3n9tNw
 lROmHISvKVHQpBlajbCSSWBLqRflfJmw2/0J6DZUAJdO1N4GCPL3uYgEnzA+SJLqzNmR
 8D9j0gwNxCgsbn8zOpijqGJsw+SShCBKY7I6mEPs8gYx64wU+yc/lFzV6pAf9Ob8TAyb
 DyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748420055; x=1749024855;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=azdm+UxBkdRxIzgKmwhwW+GH3cYuHoEtpkJtFbR5x4c=;
 b=cs586kZNrNCi9O9NCUZUP62tZzxr4hCTBmk1spf4pv1r3GBnRU3nGvHOjehlw7luew
 BzgNxz1g2IgQUc+6njnAyk8RNuI/AxXqgHJrISJWRh+jXMakZga4VrjNiXevbdh+Ru9L
 L7BJIIrSMQBqNaiRLiR6dI6T19aiCa1jb50q2TnbdFLL8QHgIN99stL+1CFhDCU6rIid
 Rav7+8yQG/jWfzn7F2F8YP8YPW8JbNMvU+M0GAstK/Qh5ICNZe6o8Gyz7uX4+3xmTNKW
 V9cJPb+isBx8ocdwuNMiqKy0kqe8l6mrrchtvzxl4PswAaoJ7fwP5sIheoUedzqcUgj8
 vYwg==
X-Gm-Message-State: AOJu0Yx1JCv4hWRw1u2+K6b1eg+MHA7z3YUgs1zGJsqKJMYp1nkg6seg
 TK/OyNg/vIpJ5zlflMLteO4BH5Y/Rp2dnzfXhV+7fDwMXtRwdCjFSYHY1010go+TXhX12l0n04P
 +9awBgWdOAQ==
X-Gm-Gg: ASbGnctvS5KU8FV7T3/kTPRgQOLUk8+XQddn0O1IkF23GJNbYRi4Fsmv6W7Jyw1LLef
 HviPMjKySd6pDYE+NvGUn+6M4xPd+ZaR05GHrQa3uC1KWJqn0wqE2vgN2KlD46R7Z22J7F3VNu9
 nm9vD7U6Zl/bqNOjfaRghvbXRrMjgqHN1z0Oa0VxH+RDdqeUzfnRZOrlfnErLj1G3Cw/6xG2hpK
 WHWoNbI078lTBkeO6sS9r/FVjXq8naCeHengfhDUOSn+Rmzic/dID6aq7TKUAXhdRkqmhg9LKBg
 RykxTTs/vdoHny3RX9ZWcZDITyk1x5NE1/RRho4ggbSI884sEDXIjp34
X-Google-Smtp-Source: AGHT+IEitChxRskBOpckNlAeKZTGyH6lERsUE1B1sRmN0bJZFD/naYVMvVwy1aaSn5ZrBZHr38cAIw==
X-Received: by 2002:a05:600c:6308:b0:43d:2313:7b4a with SMTP id
 5b1f17b1804b1-44c9141ac4emr179687875e9.3.1748420055508; 
 Wed, 28 May 2025 01:14:15 -0700 (PDT)
Received: from stoup.. ([195.53.115.74]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4500e1d85b5sm13178645e9.32.2025.05.28.01.14.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 01:14:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 02/28] system/main: comment lock rationale
Date: Wed, 28 May 2025 09:13:44 +0100
Message-ID: <20250528081410.157251-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250528081410.157251-1-richard.henderson@linaro.org>
References: <20250528081410.157251-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250515174641.4000309-1-pierrick.bouvier@linaro.org>
---
 system/main.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/system/main.c b/system/main.c
index 1c02206734..b8f7157cc3 100644
--- a/system/main.c
+++ b/system/main.c
@@ -69,8 +69,21 @@ int (*qemu_main)(void) = os_darwin_cfrunloop_main;
 int main(int argc, char **argv)
 {
     qemu_init(argc, argv);
+
+    /*
+     * qemu_init acquires the BQL and replay mutex lock. BQL is acquired when
+     * initializing cpus, to block associated threads until initialization is
+     * complete. Replay_mutex lock is acquired on initialization, because it
+     * must be held when configuring icount_mode.
+     *
+     * On MacOS, qemu main event loop runs in a background thread, as main
+     * thread must be reserved for UI. Thus, we need to transfer lock ownership,
+     * and the simplest way to do that is to release them, and reacquire them
+     * from qemu_default_main.
+     */
     bql_unlock();
     replay_mutex_unlock();
+
     if (qemu_main) {
         QemuThread main_loop_thread;
         qemu_thread_create(&main_loop_thread, "qemu_main",
-- 
2.43.0


