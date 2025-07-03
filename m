Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5162C83030
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 10:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXHbm-0003SC-7N; Thu, 03 Jul 2025 06:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHbh-0003Mq-Sk
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:55:58 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uXHbf-0000gw-9t
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 06:55:57 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a4e742dc97so553666f8f.0
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 03:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751540153; x=1752144953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ThHRepOjVOPYIURDCNeQdikGEVpKaGb//EjFvlftJxg=;
 b=bLd4yH6XSRQbDDgdLl23Uu+0l50OhpcuESsehK6js/4lLiHXWHZgpyO0CvmksTWjEB
 0Bvs4ItjQ/iauWeGn1Dp8Whzwn4PeSJyXDcfcUrA8ODACzQxydXcjWls+5dG29LGBtz0
 6j9st2/GRkpqjJFylzhJD1C6tAJf3pVYPMqnHb1YHCrDhJnM5m2hRfgI3E5qA9IGm6Eh
 a8rzQDOpeswy9qJaZrvkc4UyNThYK8BNx8u9pbBrLfF7WciM6dYUKcJgm3ZifRl3C/av
 xFUH5WMv3oKgn2+FnePLQib7OeEwTKn62jGZHuw7ZlP3k0oFYln545NwI2nBafp/gIff
 cU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751540153; x=1752144953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ThHRepOjVOPYIURDCNeQdikGEVpKaGb//EjFvlftJxg=;
 b=wxI9S6NXDK0oziJ7GB+hQI/3notv3Sv4QTvGnQUtZ82oO/wve+Ih0E2pvLxJoSFfVF
 KkmyzCkaREda4XKFJpUmYhAbIDltLCJgHrWYUWW2uy7mzgNrIqDW1uf++w/bTizBBoWv
 rHuGtZiFekDyS/qTkaEITBai0FjINSUYWZf42XWXlEh8S1owcgP37Y48gP6JnJSx7EWW
 fEYsTOTYlqv1edYedlWPFVkYwGbVNp3RzYi/CsWZKUzkMtpIyDFYyRzNhsPeX1/TXMMe
 lCmJSig5DJtXXVnmwvzKPNNetGqnG5xtqlN2/02piSgE4JrtS1UTSNwWtKwSSADw7e5s
 IiCQ==
X-Gm-Message-State: AOJu0YwWg6lEwupNjORAAXXVcrK4t9+8WzCjjJf8dJj4Mj/zH3qP/dqI
 rB5BGXjxSTTVaJYL0hNwDDyp8g1eV4ziSemauQPs9MhKH4o6FFcCIXPMznaQa5eI2UJwLjRe9OH
 wW15UG40=
X-Gm-Gg: ASbGncuYPu/PbFeSPWIYZpF6mmdESl2VG+7kovdEZ3FrDBfKgoZIzVQxygCO5zaZKcx
 XP8vIotcrCP+pPl1cN9+wyyHwRt1jtr/bhgg1FjyEG5Wlc4l1+MzZwHMM7uelC//XrWayncrNLn
 WFjmnL8wG/ImBoH/gdHdmJOiPAb4mqiEijZt9R7IoelYHxpZty+tipHVp4WvRj9beFogoqFPZfE
 KZr1mYs+QTr7N+D8bCuCzxs92rZ3G3ywK/kqt1sF8X1Im+RsYhgfwBHabr5k3L7r1LXnzwvpwt/
 /ckwvCHvltv/wYF8FsRcMx1I5xnCEgN74iLbaGHZqpKPeg7xhfY6BUeaiTaWeD8D1rvJe8FI3Yi
 g8LEFdZsZX8s=
X-Google-Smtp-Source: AGHT+IHIbewtIS4hSJa1mCuaiIjfjhd4Oy7tVjRfFIBcswnH773BBovjpNdcNQAcYJg3AxkQMprC2Q==
X-Received: by 2002:a05:600c:3f10:b0:43c:ed33:a500 with SMTP id
 5b1f17b1804b1-454ab34622dmr22498465e9.10.1751540153083; 
 Thu, 03 Jul 2025 03:55:53 -0700 (PDT)
Received: from localhost.localdomain ([83.247.137.20])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-454a9989fcesm23254235e9.16.2025.07.03.03.55.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Jul 2025 03:55:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v5 02/69] system/runstate: Document
 qemu_add_vm_change_state_handler()
Date: Thu,  3 Jul 2025 12:54:28 +0200
Message-ID: <20250703105540.67664-3-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250703105540.67664-1-philmd@linaro.org>
References: <20250703105540.67664-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/system/runstate.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/system/runstate.h b/include/system/runstate.h
index fdd5c4a5172..b6e8d6beab7 100644
--- a/include/system/runstate.h
+++ b/include/system/runstate.h
@@ -14,6 +14,16 @@ void runstate_replay_enable(void);
 typedef void VMChangeStateHandler(void *opaque, bool running, RunState state);
 typedef int VMChangeStateHandlerWithRet(void *opaque, bool running, RunState state);
 
+/**
+ * qemu_add_vm_change_state_handler:
+ * @cb: the callback to invoke
+ * @opaque: user data passed to the callback
+ *
+ * Register a callback function that is invoked when the vm starts or stops
+ * running.
+ *
+ * Returns: an entry to be freed using qemu_del_vm_change_state_handler()
+ */
 VMChangeStateEntry *qemu_add_vm_change_state_handler(VMChangeStateHandler *cb,
                                                      void *opaque);
 VMChangeStateEntry *qemu_add_vm_change_state_handler_prio(
-- 
2.49.0


