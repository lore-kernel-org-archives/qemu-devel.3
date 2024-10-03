Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C001ACF34AE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 14:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swMu8-0001Rb-33; Thu, 03 Oct 2024 10:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swMu6-0001RA-Aq
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 10:34:06 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swMu4-0005Xb-P6
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 10:34:06 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42cb57f8b41so13648235e9.0
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 07:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727966043; x=1728570843; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UIRX407hgwnjoisfCwDQ2w8aP49x/yvTbjNOX9wTl3E=;
 b=TkNE+wyLuWvcFblOMlDMZ0WaKl5JbACyp40yKaH8HhgKqNhqJHSTVeBcKbBXHh/LAB
 5skHg5z3zUDZHyALiibGu6wsgpjWOHDttU0VYfhJ9mgMhmrdEx3UPUKOTOI9nevGGqAk
 0eht8hBxBpgw8SvqqGBJ/4HfrXLtA0Zq4S9+5s1HAwqnpBsNoTpu6+0HZVwbUJefmp7D
 5O6Kaeqt5qDORd64XFm648GFPoXu5tvbtUx+O0nArPa8RryTpwAlO2Idhh+VzdTrjqBI
 0oUzcbxUEJc8RbLbRHv9e+XRMW1/8OPU+Wq2X0wBMzQtUHFNjGduMWWWE6qKP2j0G/0Q
 Uljg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727966043; x=1728570843;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UIRX407hgwnjoisfCwDQ2w8aP49x/yvTbjNOX9wTl3E=;
 b=myG5Q8UiL6MEnH8zT/Ate759zBnqQQiXojqQsFidq08UKsuVAdg7GJNxU+884Hj1Wu
 XNXMgEQ5UFa3CZP85x90H8AtGlhFcxbi+Feny8IRrryK16YZzp8w01hllT2fd9be/Q74
 d1kmIJBWOfTKnehD0yQpSPbWGh9zeYQSlG46FdQpFy/7YCT8WUcvXQwZY3UmFHtb9iHq
 hOVAqxVy7sALC5rOkkH4kq6J5lA6J7bKp5mBkiyeabTvcQCOxtRjzHSsae5dps/6/4Uc
 381/6SFESdQdHjpahpxal7hAy3eqdFD77hQ8Z/au9rVv6KAdfqH1rRnuDN9Cxa6Z7Io9
 XH5w==
X-Gm-Message-State: AOJu0YyPGkxUVYPulfaex8ZMVDRHmilGSzvYyLmB7ALIWkwdp5/vP0Xh
 pIT17BvzWZejokn7FGBEM9jvkem+e4f+aKznm6xd2zfkWVH7a8BYi0Wz1PQLQSdc0pC+cXsObtI
 v
X-Google-Smtp-Source: AGHT+IH5Oab/LMrXmkgKAmiBX/RJxfN/EnTesdfRW7PHSph6xQVoiEOu7INodxafGdGtJ8vpQ1fVcA==
X-Received: by 2002:a05:600c:1d88:b0:42c:a387:6a6f with SMTP id
 5b1f17b1804b1-42f777c365fmr61672515e9.20.1727966043067; 
 Thu, 03 Oct 2024 07:34:03 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f802a01fesm16925865e9.32.2024.10.03.07.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 07:34:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-trivial@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH] docs/devel: Mention post_load hook restrictions where we
 document the hook
Date: Thu,  3 Oct 2024 15:34:01 +0100
Message-Id: <20241003143401.1676548-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

Accessing another device in a post_load hook is a bad idea, because
the order of device save/restore is not fixed, and so this
cross-device access makes the save/restore non-deterministic.

We previously only flagged up this requirement in the
record-and-replay developer docs; repeat it in the main migration
documentation, where a developer trying to implement a post_load hook
is more likely to see it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
This came up in an IRC discussion.

 docs/devel/migration/main.rst | 6 ++++++
 docs/devel/replay.rst         | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/docs/devel/migration/main.rst b/docs/devel/migration/main.rst
index 784c899dca6..c2857fc2446 100644
--- a/docs/devel/migration/main.rst
+++ b/docs/devel/migration/main.rst
@@ -465,6 +465,12 @@ Examples of such API functions are:
   - portio_list_set_address()
   - portio_list_set_enabled()
 
+Since the order of device save/restore is not defined, you must
+avoid accessing or changing any other device's state in one of these
+callbacks. (For instance, don't do anything that calls ``update_irq()``
+in a ``post_load`` hook.) Otherwise, restore will not be deterministic,
+and this will break execution record/replay.
+
 Iterative device migration
 --------------------------
 
diff --git a/docs/devel/replay.rst b/docs/devel/replay.rst
index effd856f0c6..40f58d9d4fc 100644
--- a/docs/devel/replay.rst
+++ b/docs/devel/replay.rst
@@ -202,6 +202,9 @@ into the log.
 Saving/restoring the VM state
 -----------------------------
 
+Record/replay relies on VM state save and restore being complete and
+deterministic.
+
 All fields in the device state structure (including virtual timers)
 should be restored by loadvm to the same values they had before savevm.
 
-- 
2.34.1


