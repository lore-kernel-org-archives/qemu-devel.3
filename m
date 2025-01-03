Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9C92E7718F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jan 2025 17:24:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTlO2-0005zx-Rv; Fri, 03 Jan 2025 12:23:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTlO1-0005yt-1d
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 12:23:01 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTlNz-0001Oi-La
 for qemu-devel@nongnu.org; Fri, 03 Jan 2025 12:23:00 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso82563045e9.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 09:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735924978; x=1736529778; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XAvTPdAmDaVspmiDEBxv7slQUtV72xw5x5dlXyX0c1M=;
 b=FJxF+noSJ8HxYz48G6OKsR/gdJAOSVuO76NVhL5AYEl4q0TJYPdiU/dJotKKG/YLhX
 iCFCEXb4Al51Y+pbjIF5raiIH5TPIBtnK891sNrPiB+kwtYYroZgjYjO1LAwDO7TiPUu
 KObovYdAk8ejoGHVaEl/GDxnD6Y2uBSLJr38CiZm6sQwHymreyPx94Y9UoG7EAdmx+MP
 8CgEM2MG5jqHnJoo9LbDjDKi7cICColq8ZFw5lVgI12KXVN5JlQwFQSzjp5eJBqaP/H/
 /HBGwLP6vjfGQ9ERhy7L8ePJSlnUOuuU2k/doMaDZd8GTLiirHj+YC4RMz0fhm2o5PKD
 /2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735924978; x=1736529778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XAvTPdAmDaVspmiDEBxv7slQUtV72xw5x5dlXyX0c1M=;
 b=NKKiq89OF5zaXf5gaLfTCQrTiyWPEal/auuNLfpCX6EjJ7+ZgTnViw0UzGdMMGZNyr
 HRr2p5SbvlIeH4OAeyPmIuu3dADE6RJJ0GI/zL5EDTrLyRx3NOcV0t1g3xXHtIDEH0W4
 mZwKBLpNAjWC26zwHrMtjKOuCfYzbxMCYc1rp4yj5LOFDTWBe8tK1AMLzXPuKJXcETu7
 oqqS1NVt1aZwltTcb08+F4zbmF8n8fZoiMFH9ydaVf1hU/6Pq3+lp1Na1GOaPlBDb9b/
 4Xi2f+NW8iGJyXJtQbLemPhMmGA2ijOdU3C1WywtO1aLNRki7a23bQK6ALiteAzhRsHa
 EDcA==
X-Gm-Message-State: AOJu0YxRa3RpOZUobNo7SDddOZ2kxzuZ3fIWUX9aFnJu8SrCHsBSnXcp
 16pLHvI6agXtDQUGxxxBWsZfVPGPjMM/rY06TsS9fV6xyCSCibjjZAcrMM/LYgISNoahR71Ocat
 FxBs=
X-Gm-Gg: ASbGnctcwY+V9NYwiLuhcqLRB39LbK9JJkaUre4zC/s1YSh5r+SAAQ5vR6mp4gc3SkH
 IYL/hzYgx0ZagYJpTVtpbsC2iB2cfcoozfAX0Pim4LxlBjiAgl1QTsuP+UBdYafRlQyaeKDZHPc
 oyi2IWu1U13ZiHUIFTwIniEKX8TYf2bjh9rINBG2RqKL6uf7bMFEyKl3VCH9bmdnvD7UKcMEFho
 eWUkh3Lhz/kq+KQwxNsqKevSlhNUFOqBdO1smph9IRuo93D9XXOTJWjfAf+tq+PVe2Z8jf2FV1R
 OK05o5QebX6Pf0r+aHZRHQ8WHmQ7tq0=
X-Google-Smtp-Source: AGHT+IFTxnQJTNsUPy6I4zoFQVp3E/3c9NUQH1U+uPIkRSuUxWUgj8/hY7P/TVC42HeUE/58fMgwyw==
X-Received: by 2002:a05:600c:35cb:b0:436:1af4:5e07 with SMTP id
 5b1f17b1804b1-43668548867mr335075545e9.1.1735924977888; 
 Fri, 03 Jan 2025 09:22:57 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c8acb85sm40812573f8f.103.2025.01.03.09.22.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 03 Jan 2025 09:22:57 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v7 3/4] tests/qtest/boot-serial-test: Reorder pair of
 instructions in PL011 test
Date: Fri,  3 Jan 2025 18:22:38 +0100
Message-ID: <20250103172239.18562-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103172239.18562-1-philmd@linaro.org>
References: <20250103172239.18562-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In the next commit we are going to use a different value
for the $w1 register, maintaining the same $x2 value. In
order to keep the next commit trivial to review, set $x2
before $w1.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
---
 tests/qtest/boot-serial-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/boot-serial-test.c b/tests/qtest/boot-serial-test.c
index 553575ca75c..bcfa504826c 100644
--- a/tests/qtest/boot-serial-test.c
+++ b/tests/qtest/boot-serial-test.c
@@ -78,8 +78,8 @@ static const uint8_t bios_raspi2[] = {
 };
 
 static const uint8_t kernel_aarch64[] = {
-    0x81, 0x0a, 0x80, 0x52,                 /*        mov    w1, #'T' */
     0x02, 0x20, 0xa1, 0xd2,                 /*        mov    x2, #0x9000000  Load UART0 */
+    0x81, 0x0a, 0x80, 0x52,                 /*        mov    w1, #'T' */
     0x41, 0x00, 0x00, 0x39,                 /* loop:  strb   w1, [x2]        *TXDAT = 'T' */
     0xff, 0xff, 0xff, 0x17,                 /*        b      -4              (loop) */
 };
-- 
2.47.1


