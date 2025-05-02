Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297BEC3ABAA
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 22:06:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAyVr-0000xc-Kl; Fri, 02 May 2025 18:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAyVp-0000x4-OD
 for qemu-devel@nongnu.org; Fri, 02 May 2025 18:05:41 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uAyVn-0003pi-W6
 for qemu-devel@nongnu.org; Fri, 02 May 2025 18:05:41 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-ac2af2f15d1so317610766b.1
 for <qemu-devel@nongnu.org>; Fri, 02 May 2025 15:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746223537; x=1746828337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UaWnKiyFM4+wRp+EN3RtpqOmiTPrUy+zx8+J85aJGYo=;
 b=z6JMCwfql0MVH7hW7IzKvSk+GMVU2oQ0RAr4jtgbYaGjcZ6kytJbzKnohlWoQ7sVL5
 IJUYkYC1Q96SKwdGoRdBISjSJ4FIkvFEB/ud5cwNgkPHdfWd12J4KE7PZofuQc+ApMDf
 hjIN7bMYrkzNapCadSHdyk1emzOJX16p6jjnjrr0uyKukKwBTMluSdSbciWE59l8bdQL
 SQkpGtXM3q9XJZrixPqklapXivmRxhW8niTeT6fc8C0ws1aolbwVu9Ytx82wijvi1NHK
 pdUBYaMRyOKyMDfuhAW3lvnb7C3YUqHlUKTvIrCIB5upA8/ymb0iL+hOitOvP1yp9Qwp
 SjGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746223537; x=1746828337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UaWnKiyFM4+wRp+EN3RtpqOmiTPrUy+zx8+J85aJGYo=;
 b=NzeFUCfUY4l0jDrtefDDjRP8uEilns0hn1CP5lDxs/EieHyW7E6pmeLGVdXWGk48La
 QRLgQXilXOTj8ExngUB+b1Q4vlWJar5UY5oE6bwUw30elcgufM6faDDBGJqbwPrUj+07
 Er84o5eGkt6po3ftefQ1i0r9hfSvfwuFN+yqNM9VGowr6Rvrwa6UdeKUjZqTSBJfjXDu
 7izZFRp612Gf1JVm1x/T+FE0L0WUOkbeMmy4A1IlZ0Y39LyLJRPg7twClcorgYXudWLD
 JNdnofnN+xsRnYZHTJWDZMFpp/04f6m7afwXxFVhBz/X9CPSqEOcSe+ve/5b3XRPCzus
 ZJBA==
X-Gm-Message-State: AOJu0YwadmIvKChrQ8+JPBYDRYl8oNwP1oeBXS9bwgHIkQFTt03JIPR5
 tymQmGf8rxITWPQ/q10iU3uHanVr0OxrxT/eIdqsbR1ZuR4mvEsd9l2apghs6aRbvtu5BUqKS/q
 J
X-Gm-Gg: ASbGncuLXuQPYZuNusD8Efm7qpyJ+lv472B0/Ia7+zpgLa9iwf7Jn8V/eCwEDRGPq2l
 I4N+K5FRCknpDICTGzQrntk/fBiufpSFWUgvSsPx//gV57eKP01nUkOCeahNRJlnpqCmj+krBC7
 1UL4hZkNfl3EYTEhT821AcKODQyo5jy3LjXM4DBYeW/vscnjomUUM+O0HtrUQqDIjNnhA5hRm3z
 22UXEXNIK6jWZbn5XGyUQfjIQHLaEsOC0Jq5+wwfEi343FJ/nD5n/Uix5DGnoQ5B1nFs+IKqewF
 ka+FWNJvYr56htpRl7E0op3FB4SOP0QSNFevwEh9XXFqusKHlu67GjSlh7w+aTfYzKY8FRHvuMp
 YWWSKGN9NaZLq4JPcbW04BZD09Q==
X-Google-Smtp-Source: AGHT+IGu+hyKzL5Lwd3noDQVNCzFSdMa09h7W0sx8QOKedsgfFYH+zG3oEelZa4C44/Dtdpa4zHFVw==
X-Received: by 2002:a17:907:388a:b0:aca:db46:8170 with SMTP id
 a640c23a62f3a-ad19088cdc7mr69267266b.60.1746223537364; 
 Fri, 02 May 2025 15:05:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ad1891f6b05sm104554566b.86.2025.05.02.15.05.36
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 May 2025 15:05:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 2/2] semihosting/uaccess: Compile once
Date: Sat,  3 May 2025 00:05:24 +0200
Message-ID: <20250502220524.81548-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502220524.81548-1-philmd@linaro.org>
References: <20250502220524.81548-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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
---
 semihosting/meson.build | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/semihosting/meson.build b/semihosting/meson.build
index f3d38dda91d..a0a1c081f43 100644
--- a/semihosting/meson.build
+++ b/semihosting/meson.build
@@ -3,9 +3,7 @@ specific_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files(
   'syscalls.c',
 ))
 
-specific_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_SYSTEM_ONLY'], if_true: files(
-  'uaccess.c',
-))
+libsystem_ss.add(files('uaccess.c'))
 
 common_ss.add(when: 'CONFIG_SEMIHOSTING', if_false: files('stubs-all.c'))
 user_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files('user.c'))
-- 
2.47.1


