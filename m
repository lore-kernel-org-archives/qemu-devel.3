Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266B0E7716A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMu03-0003DY-5W; Sun, 15 Dec 2024 14:09:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtzw-0002Uj-GQ
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:48 -0500
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtzu-0001WL-VI
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:09:48 -0500
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-71e10e6a1ceso667893a34.0
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289785; x=1734894585; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K+GZ9ZCLooOJN0Ye6NhWRD2E6T7UhJ11+zH6uUVM34k=;
 b=S/IQ+E+I5ZyhTAPwwGgk9HsdyDEPME63AD4fz8eSz4vUoaStdmzNYxVxxJEf86vVsF
 hNiqgythNiREu3B2MYpAkEB+DJX8GgxmwlzAdXCzl5XefJM2oGPqBhQnbqYLdZwyJ8tc
 p+5IRsw3r8mYsW6F9bL2EsRJWX7BSkjP1ehtPxKAjshATeVhi8ZuX+YnlYFoNeupGdb1
 TVLnR7H4P84uykSzJT9HA/PC+XEyeNxDe67D7LtYoGextL8RIQrJFGHsIMkxGo82vE0N
 LmKBP8khWRnAFrW9jGUGR3dFKOkWD8skFG7W/JQ9NTF4uf2hgquAQOS9JhRziLxeLq0j
 XOVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289785; x=1734894585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=K+GZ9ZCLooOJN0Ye6NhWRD2E6T7UhJ11+zH6uUVM34k=;
 b=B428indqoW/2dAE5xpQpyIEYQKjIemY41rZIQk6e6pqsqlUMdgXDKOad99kQVeBNVr
 wpjmh5+vZkbqzbliDMc+BKV1usfl7HB4d18Ts4KG21xybkSmqrR1Vp9Q7SmfepPTvn9u
 ls7uh3LDuFRzCgm6UJ8UAkjY49v2bBkt755qMxXmvCMJgc03kfHMnJ7eILud6VkXUare
 YLsyS1D9zCobjhe1Ai6lQGMp/+pLyloAuqiM02VCvueWXuOfv4jAwNJnp2nlB4pzT6lN
 A3HWfS6fI+mMRp/VLYjt7hdeQ927ukpUJ50qc1e/K4Gm52AOlVx4KSf1QzByr6ZIAH82
 pg0g==
X-Gm-Message-State: AOJu0YxqffB3v+CKR3MDaVb0GxLgbaXQ5xC54tPevYw8Ht7MuDwUwxZC
 5S/KDWTk5h36WEq5OnuXGOy7XanfveYWpOLNpfImpASaFX5yZZEnlZGufERuhVXlR2FEqz5qPn7
 AXKnbcbPk
X-Gm-Gg: ASbGncsfdFTBwXGgm+bwk+avj/UCUzWMjh8jNb8B9oq2iWtAC6B7tRMdXmw6ZGUUngw
 +0J5CCuYZyELVduhEU05f6z8C9ExV3PeiiXPqpNm/APxW81rvkzbjYPKRgdNuO6ZdCXhwF811KD
 0Fi7UVA72Twi0YyRgJUYS9WSQT48VsCw7A3sNTWA6qd+KGbZHwagkh0AneKLlyRy1I9Ergzlu7v
 uJf9F4GHzvYys4JuGdoBscnZDoatgQZdco6XZ1QuZeET8/Qtxudy3j+ULKwVVTb9aPJ/8BK1pmO
 FQXu8VIgbg4APHwDWqlJfEj4vmF33RwnpYNHrnH8WQ8=
X-Google-Smtp-Source: AGHT+IEiCpz5QlRa9H2oNgzo1ulL+3orpaQqyfYBC03EqO1phBMuGtFEbMrQP6CLk/EL/yej98bArQ==
X-Received: by 2002:a05:6830:44a3:b0:718:8dc:a5e with SMTP id
 46e09a7af769-71e3b84ec34mr5875790a34.9.1734289785261; 
 Sun, 15 Dec 2024 11:09:45 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4836f8c2sm1015316a34.34.2024.12.15.11.09.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:09:44 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 51/67] hw/rx: Constify all Property
Date: Sun, 15 Dec 2024 13:05:17 -0600
Message-ID: <20241215190533.3222854-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::331;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x331.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/rx/rx62n.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/rx/rx62n.c b/hw/rx/rx62n.c
index 560f53a58a..dfa27bc94e 100644
--- a/hw/rx/rx62n.c
+++ b/hw/rx/rx62n.c
@@ -257,7 +257,7 @@ static void rx62n_realize(DeviceState *dev, Error **errp)
     register_sci(s, 0);
 }
 
-static Property rx62n_properties[] = {
+static const Property rx62n_properties[] = {
     DEFINE_PROP_LINK("main-bus", RX62NState, sysmem, TYPE_MEMORY_REGION,
                      MemoryRegion *),
     DEFINE_PROP_BOOL("load-kernel", RX62NState, kernel, false),
-- 
2.43.0


