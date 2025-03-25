Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91D7CC36008
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 05:02:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twwOO-0004Sz-Ta; Tue, 25 Mar 2025 01:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwO4-0003u3-6V
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:40 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwO2-0005uu-Co
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:39 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2ff4a4f901fso9525491a91.2
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 21:59:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742878777; x=1743483577; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7b7Pa/XivG7M4hjK9jqso2S4d+dz1DGry6GtvIR3C8c=;
 b=diaOremllwQh2p6cetTrB/GPmfQ4PZRaJqG9+cngMMzymAIsj9irkTQYEG66ZVUnfD
 MgBgkYwymbgyBsk1tLRyw3/lOJ61chBEmu9Yq8cj2WK6NkSF4LMlpwhMiMJIalWL+nc5
 r89iU1Aok7QpaNKma8CRSpH6EhYQBW9+nekH8HDGa0wFXCPSjHUhOSrUfmH5bwiwpvsM
 kvQwryVgmOCsWa/PAvpGGi8+lxQpFA5oXFKGBojifLrPtJYncX9oA2W6oU/qV8ieO48t
 ODP4kBlvvC1yru2X2ZoW1PDcTKuNzw4G/Hy57W1KS8LTr1h6RZLhx+E3rKPEWir3tCKM
 E6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742878777; x=1743483577;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7b7Pa/XivG7M4hjK9jqso2S4d+dz1DGry6GtvIR3C8c=;
 b=sJS9V+NBS6jt+Qr/yfAkiSc9slTAKbPRktFYSUWrx+LfoQIwT2xuXvi+P4NNxTExTv
 F2YJGqwF4gijuS+gjFpKMTvVZBZbQygF/8RgStD67MyHx6jivdJid/zXCM72RWyKCg0M
 HDyckyu5Nc00IG2SD6OqG/T3J4By8K4+CIxgGst9F2JOdCwRubO1pw9gUAHPCiKv+QSd
 Qzsi10nRwyIGc8svApxuhGyhBWUiCaKVlpY1Lj34WegUaq/GDLzgf5/fY8lMzu3gERQ1
 PH+jXcTdt8BySEbcWjvAUognvwigvBX3rg1lCxgdOKOicpK5q9KfwzXtsSez6ds/WOD7
 7vSQ==
X-Gm-Message-State: AOJu0Yx4oYiCvFH3+nY7neJ8JpX12wATuU0aouNWa/P7EpS5bcjkNNwr
 SD/a88+DQwvfT7b2YjlPqu0MUvkzZOuq63Ky0cu7nEyi5nx8KajnAIUvHUI+Uih7/t4fcqRwdvI
 5
X-Gm-Gg: ASbGncuaywLaqV9H3AqMKcid23Auq54Q1RxCcwJCZ79nFgyJcTGAbmM7655rQlBGsvD
 nTFO2GYA9ki4D5PLcJ+T1zqOZnS99M7OxuEaMmARzLDgguKmWR715X8GEGf8pRrMUlGpw9pcL5e
 5DyvG44H3fajWI58op2RXmR066m/EiWWyCbmCXXn2uVOv1XWHPCFOpUHUZw5Mb809ruwNXh8O8t
 4k+IUHhvdkfUjqjZuqdmLu9am39xNTjd9NNH/YR10XL7J8eXzyvjJgOrGXXEPXVgeYfEkVT8ukE
 KDm6rLWt9Jy1JxOAwa5Pv+csJpAZZFuhO9ScCyvn+3vS
X-Google-Smtp-Source: AGHT+IE6/e75fo+Kg/zgnWaJm+LIfAfDzGoGdg/CTmdUB6XE9NW7yCx2vtaKJnH35gGHMugZZFYWOw==
X-Received: by 2002:a17:90b:2743:b0:2ff:4a8d:74f8 with SMTP id
 98e67ed59e1d1-3030fe721dfmr22138307a91.6.1742878776987; 
 Mon, 24 Mar 2025 21:59:36 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf58b413sm14595120a91.13.2025.03.24.21.59.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 21:59:36 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 16/29] exec/target_page: runtime defintion for
 TARGET_PAGE_BITS_MIN
Date: Mon, 24 Mar 2025 21:59:01 -0700
Message-Id: <20250325045915.994760-17-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
References: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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

We introduce later a mechanism to skip cpu definitions inclusion, so we
can detect it here, and call the correct runtime function instead.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/target_page.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/exec/target_page.h b/include/exec/target_page.h
index 8e89e5cbe6f..aeddb25c743 100644
--- a/include/exec/target_page.h
+++ b/include/exec/target_page.h
@@ -40,6 +40,9 @@ extern const TargetPageBits target_page;
 #  define TARGET_PAGE_MASK   ((TARGET_PAGE_TYPE)target_page.mask)
 # endif
 # define TARGET_PAGE_SIZE    (-(int)TARGET_PAGE_MASK)
+# ifndef TARGET_PAGE_BITS_MIN
+#  define TARGET_PAGE_BITS_MIN qemu_target_page_bits_min()
+# endif
 #else
 # define TARGET_PAGE_BITS_MIN TARGET_PAGE_BITS
 # define TARGET_PAGE_SIZE    (1 << TARGET_PAGE_BITS)
-- 
2.39.5


