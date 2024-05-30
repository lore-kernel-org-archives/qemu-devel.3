Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 039F1C25B74
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2024 14:54:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sChAI-000768-Db; Thu, 30 May 2024 10:54:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sChAH-00075c-2e
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:54:01 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sChAF-00022u-K4
 for qemu-devel@nongnu.org; Thu, 30 May 2024 10:54:00 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5789733769dso1946655a12.1
 for <qemu-devel@nongnu.org>; Thu, 30 May 2024 07:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717080838; x=1717685638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Ff5kcUAJ45GadRFMIQaizSyWAAAwMa/2teqDZZawXU=;
 b=ZgePRaYSm3Awekpvyz6aoU6jyRWdGmPqwHc8n7SWShuLSAvlB1IyO+s83QCbYC1S0m
 WBZ530ygbQ5kRmHXG9YvN26hJbRtE3MKOPZaMlF3v7/kPGwMgsLl2OWagInObc5QuGih
 m0YghU07O2kBYhqwa7N1JOgrcvi92eMoAO/KvEDzipX7hiwzu/rzA/4NJtELMmsnDz9y
 GqWmqDIQmqLR3t6ijkTppLDyQl5pdCMIwEJXIvZsF426lXEyq6bXPFAi1ZVeIdoKABmh
 VW+KD9U6asPMUYjf28z704JNnrkHN6+MM9AwDgoHawmwgZelWf/LVe89/G3nWatG3cFm
 j3FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717080838; x=1717685638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/Ff5kcUAJ45GadRFMIQaizSyWAAAwMa/2teqDZZawXU=;
 b=gGv2Ppdy4DMZixbsVu9ebpi3POemdFD6rUxHFAC9UgpC2AW4SkNG4ac8f6ILH89xA2
 bEnb5JP2/SWHzYXX4JLf7SNeH5T5WtONhE1WPXXRhluZrZbWi7DTCQ9INsXvsyk1lSt2
 mNLJbXmMha1wTWM6VSsoTe/36XH6iEsCJeKakKhOJLkFsLNh2W+FMkhRVY0NpSV8IY6C
 p+Ua/OywpaSXlksDFaENwE/WzoPy1JepEREZa8WVrmRzJy7rj3Xfyi3i/1/vtW4Usq/U
 sQxE81Z/DUiz3KNBSBDPQ+kXxnRBn+pzP1MJSKjYiew1fLy6fEIAr0qrYUjW6QwQrN0l
 8Pgw==
X-Gm-Message-State: AOJu0YxMZ/FSnwd4MzYGGyd7sktn/ORmLIcjrmwoOG4DK7ikrYqTngDH
 0aeh8byZqHxmctcz24gUaW8nsRGE+URiViMxUVccPP1uwYMLw9ZRDB7fYsnBwOixf80wqt8iaWC
 8
X-Google-Smtp-Source: AGHT+IHx9DhV18TajrF0q08sau6dKuyT702yn/PwGrOjRphUvf39AKXfXmHqton5FVlYWhqKehByUA==
X-Received: by 2002:a17:906:a854:b0:a5a:5b1a:e2e4 with SMTP id
 a640c23a62f3a-a65f0a69960mr179082666b.20.1717080837822; 
 Thu, 30 May 2024 07:53:57 -0700 (PDT)
Received: from m1x-phil.lan (xbn44-h02-176-184-35-50.dsl.sta.abo.bbox.fr.
 [176.184.35.50]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a626c93d38esm835954066b.90.2024.05.30.07.53.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 30 May 2024 07:53:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/3] target/mips: Restrict semihosting to TCG
Date: Thu, 30 May 2024 16:53:47 +0200
Message-ID: <20240530145349.41309-2-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240530145349.41309-1-philmd@linaro.org>
References: <20240530145349.41309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Semihosting currently uses the TCG probe_access API. To prepare for
encoding the TCG dependency in Kconfig, do not enable it unless TCG
is available.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/mips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/Kconfig b/target/mips/Kconfig
index eb19c94c7d..876048b150 100644
--- a/target/mips/Kconfig
+++ b/target/mips/Kconfig
@@ -1,6 +1,6 @@
 config MIPS
     bool
-    select SEMIHOSTING
+    imply SEMIHOSTING if TCG
 
 config MIPS64
     bool
-- 
2.41.0


