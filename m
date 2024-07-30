Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834E9C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 02:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYcOd-000892-RB; Mon, 29 Jul 2024 22:15:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcOc-00088I-1X
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:15:26 -0400
Received: from mail-qt1-x833.google.com ([2607:f8b0:4864:20::833])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sYcOa-0005OY-Ir
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 22:15:25 -0400
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-44fffca4fb7so15994891cf.1
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 19:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722305723; x=1722910523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tLrGX9Afltcgokadlb0YQI/9367xWPIB4Lrlteq6PUs=;
 b=lKC96hVuyT0lJ2/NTcQXobo4zAhvwRzccJx8FSrVkn8VStKQx4ZW9dyumJLR1k/sFV
 bfAViSU62GkU9JILNTAE2hMHiKa+BWz7TQak6jKK30MS8YD9voGubv+XEUUMuiFICBCC
 BftSEa5IRbOrD/54XOThO2Ic0Gq3nL254GFg0GrCGhvJiLWuw3CTTUtPMPOcbB/X8zvf
 qQmgwFoIgxZr5EVjYe/gaLXAsosXwYAgF7qjF5l+lrlNxWfc3hf8XlovJtjB6MMy28Y2
 +LbpUmRts7TyziXZVYIFq+lhhc751iDbi9FU2hTjDkk9RSVZg79ktd3P4YUQzgMnZNhZ
 TQjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722305723; x=1722910523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tLrGX9Afltcgokadlb0YQI/9367xWPIB4Lrlteq6PUs=;
 b=UOjn0+1LqqKAQx9gCdExCwEH39E20iitb4xcZNpUT1u4dR1VDvSMkxrvsIPZ7drFfW
 +HIkFXnUwRhzH/1vkB6FQxXzWxOIWS9uSavHTXFTi5pYPUXZKbaapYLgi0t6XUNa1TqV
 hp0DTfmfj7mHnGTgPVEwc9xmem7aQFO/GjW5+ImDIul4FSUJQ+4UFU25SsTfyQ5r6+bb
 wRatoNPmaq47xqMoECiH5sD+4Gzy/Gk6J7zO4jkPhaZT/q56bPvQa0OAi5Hs6Ur2XBoo
 ovJs6kcqtBMBRAWq8KPpyJd8fW9+KTwpb4mNCCdo8kxaqrzpcgRhTrWWR5SGhfeqr/P5
 xDyw==
X-Gm-Message-State: AOJu0Yzv16W5cyCphlF1z4H8FYVZmWvjIGpE3eeuWAptjTiVHdLPwGhY
 /LfPM2fugTOTmgJ+WDEM9y5DeQs8i7qQP+c53hgt8hsXwmzmalMFzlvsw6qAisc2/HFRjqcmwhH
 FJNc=
X-Google-Smtp-Source: AGHT+IGmZlGXbPQaMFUPkW2EUPbFQhCxhFr3kltuYgJsJd2wCPq6BJgcHeZQTkupelS8S5F/UHyjgQ==
X-Received: by 2002:a05:6808:3086:b0:3d9:2bbb:1cb4 with SMTP id
 5614622812f47-3db23a7dcf5mr10395701b6e.35.1722301932573; 
 Mon, 29 Jul 2024 18:12:12 -0700 (PDT)
Received: from stoup.. ([203.56.128.103]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7a9f7c6ff4bsm6750206a12.4.2024.07.29.18.12.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 18:12:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH for-9.1] tests/vm/openbsd: Install tomli
Date: Tue, 30 Jul 2024 11:11:58 +1000
Message-ID: <20240730011202.480829-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240730011202.480829-1-richard.henderson@linaro.org>
References: <20240730011202.480829-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::833;
 envelope-from=richard.henderson@linaro.org; helo=mail-qt1-x833.google.com
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

Tomli is now required by configure.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/vm/openbsd | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index 5e646f7c51..49cab08782 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -32,6 +32,7 @@ class OpenBSDVM(basevm.BaseVM):
         "pkgconf",
         "bzip2", "xz",
         "ninja",
+        "py3-tomli",
 
         # gnu tools
         "bash",
-- 
2.43.0


