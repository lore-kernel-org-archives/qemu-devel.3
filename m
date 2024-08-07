Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F12C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 08:36:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbc8j-0007G1-Rb; Wed, 07 Aug 2024 04:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbc8h-0007Ew-Dk
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 04:35:23 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sbc8f-0000mR-LX
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 04:35:23 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3687f8fcab5so719724f8f.3
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2024 01:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723019718; x=1723624518; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iMiHRlTwvpRnD6JI4WPGuSYm0+wy6tJZGmuKv86uCaw=;
 b=W0iUkiCtqmkGXlRnN3TiS4aQ3Fi8XRFXXyCWvItA3oSBaLoeccukIbjvmKwHTe1UcD
 dt44PVisKKnVY3l9AVrbPWjH1hUQOalpaHfbz3kAXrmqH4yC+OkonZLROtJYN9ef73qs
 D1xouHDvMV5dUq107ilYHW9FoxMkOzQljkdbbbNYtUbayIRX7dD9CNE9FdzcVFZAYHY7
 EUmaZNIlwsEEjXiX4R6Hnp5R3D55lIlMJA/5uthh+Fc0AjGrh2jtTutBqRpJgwrsVb2X
 h81XjBdDOKQl1FtwYxww6Dddr0BAl/alOv/c8bqPfsJr9G8zhxHYk0PWbBjarIgkoNAp
 zg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723019718; x=1723624518;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iMiHRlTwvpRnD6JI4WPGuSYm0+wy6tJZGmuKv86uCaw=;
 b=IMvCAlQ4KQscbt2U54ma3EZKM07XeBusi1vcKjyyhouXJsIjEXqRGnLWNitkCIWkgu
 Xm+qKbZ/pMNyuVACYbeAwjTdwiIfYjwjzBL2EWBtH9EvOezEsPWs0p+uTbm/R7Di3H2A
 7/XsfT2gGKKMQYXCgU6SkCv89evHTQlV7OSrxScBIUCHJN3uiwQs8zCzbJA9a3O9haeB
 CSoaCrDEKmBSccE2gR8+IeGDHrVMa3L3zq2i5DNOGarLK13EQ4IY+LHTz/q5rOomlpIE
 AEsQgPEnQzGrbjlfwoV996VXXL8DuZvBPjuAhKFDonG1Qbm68EOe8Xcha2oKOYETgzbH
 Ndbw==
X-Gm-Message-State: AOJu0YznjkMg6zM2x61cX08ft9BIYsEKhLqb0SDJFy278FfggB3NGF5U
 DD7S3WM8onMeEJkKkNvj/laM/7O3802ZkSxiK2q8YCod9Tbudp2Vj/zN76gouSnn9H84CRNcR/Q
 W
X-Google-Smtp-Source: AGHT+IH8hvz4AeHr+CwvxKh84i29hsNhQTl1Qmux9x0bR52C6L3B25yjZ6IXseW0zrt1IKnEbD/t5w==
X-Received: by 2002:adf:f14b:0:b0:368:5bb4:169b with SMTP id
 ffacd0b85a97d-36bbc0aeb7bmr11129214f8f.4.1723019718518; 
 Wed, 07 Aug 2024 01:35:18 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.212.120])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0c348sm15223764f8f.24.2024.08.07.01.35.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Aug 2024 01:35:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Zach van Rijn <me@zv.io>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/3] linux-user: Display sockaddr buffer as pointer
Date: Wed,  7 Aug 2024 10:35:06 +0200
Message-ID: <20240807083508.28134-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807083508.28134-1-philmd@linaro.org>
References: <20240807083508.28134-1-philmd@linaro.org>
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

Rather than 'raw param', display as pointer to get
"NULL" instead of "0x00000000". Remove spurious space.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/strace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index b4d1098170..7064afb486 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -434,9 +434,9 @@ print_sockaddr(abi_ulong addr, abi_long addrlen, int last)
         }
         unlock_user(sa, addr, 0);
     } else {
-        print_raw_param("0x"TARGET_ABI_FMT_lx, addr, 0);
+        print_pointer(addr, 0);
     }
-    qemu_log(", "TARGET_ABI_FMT_ld"%s", addrlen, get_comma(last));
+    qemu_log(","TARGET_ABI_FMT_ld"%s", addrlen, get_comma(last));
 }
 
 static void
-- 
2.45.2


