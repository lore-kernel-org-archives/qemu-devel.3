Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD486C3DA59
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2024 11:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sVqqG-0006CP-Ec; Mon, 22 Jul 2024 07:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqqE-00064Y-Ii
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:04:30 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sVqqC-0002VH-KU
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 07:04:30 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a77d9217e6fso390107966b.2
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 04:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721646267; x=1722251067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yjOKFmUYW+JcwieNHJkzMimsCu5Ki6cUKvCgnrmOD/I=;
 b=AYh0wVkguaYPalmDlCMdW9zbOEvy+gh6gP8iK+WI/aAwNsuwM9iL8uVN71ecgK+lmY
 n0WM2BqTF3O0XAAAd2Mmim6zaa4fRZ2x1zStcYbmKA0iP/kt7D1gWzFTNvRoQFTjy5ib
 nozN5UoPlg5Tfqj5dXV2wxEC2ZsCMJ/OhRytsb7ELiI2zOZmEFdJ5hl7Z3ldz8EHIfo+
 UUURhfxlUR+jQ0i1DUcZW9L+mvwDl85icGID1rswDfl9iZNhoSJ7mSx/iwxePr2lmlR4
 rp00AOAFbDeykaEG4X1s1OtJHZK/eqJvQakCo4EUeMY2imjQbWdNzzoNaAsQDO60HZXv
 H6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721646267; x=1722251067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yjOKFmUYW+JcwieNHJkzMimsCu5Ki6cUKvCgnrmOD/I=;
 b=VUPODSlcBvXKLEdswQtllb70Dbm06kiHLKfUdYwhznVXrLHOnjeJyEVQxJz1UNYUAy
 y6wRkLzvXAhDYgxforjNGabP6E2ltlnOGaNsC81zZbQVPBAKuoCev4p572R42sHp/m2O
 17gZTXKGQFFAtPJQfDIvKUM0SWECWbB7h0uOYQ9BRBbj0uDL0MKQOfWJEvH+xTRMZwg8
 E1gr72SV4ITV49FO5R9DhdzTyga4iphuiN71eT0UR5sEF9euQR5uB0WkwgN0k4UjPCbS
 Tlk5/yXq24Cvko6ad8gpcZBwO0J/0Nif5vlzUvO3nQ3V8bBoa4kYLMELlAp0uYXUGvgr
 8lfg==
X-Gm-Message-State: AOJu0YwaB/tVDIBz1fP43LXRSK0IU1QY0vF9sGZPWyuuhdd3cfQTDFHL
 tqXz5mR0RyOO9Pqz6F6SSRDOP1c8aM+i74TW90O8aoZ5C2IFOHtbS9cdUbw9m0s=
X-Google-Smtp-Source: AGHT+IFWEDjP2FAqvkqFqDdIUT/UhZFEDiiqSUrvpmpHvrz+H3Pi390U8cg4Yev0KyDzZzU7yTmQDQ==
X-Received: by 2002:a17:906:c150:b0:a77:eb34:3b4f with SMTP id
 a640c23a62f3a-a7a4c00b86amr427897366b.17.1721646266987; 
 Mon, 22 Jul 2024 04:04:26 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7a3c8bf30csm414499466b.141.2024.07.22.04.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 04:04:22 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 07D3D6211A;
 Mon, 22 Jul 2024 12:04:15 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 15/16] semihosting: Restrict to TCG
Date: Mon, 22 Jul 2024 12:04:12 +0100
Message-Id: <20240722110413.118418-16-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240722110413.118418-1-alex.bennee@linaro.org>
References: <20240722110413.118418-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62d.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Semihosting currently uses the TCG probe_access API.
It is pointless to have it in the binary when TCG isn't.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240717105723.58965-9-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20240718094523.1198645-16-alex.bennee@linaro.org>

diff --git a/semihosting/Kconfig b/semihosting/Kconfig
index eaf3a20ef5..fbe6ac87f9 100644
--- a/semihosting/Kconfig
+++ b/semihosting/Kconfig
@@ -1,6 +1,7 @@
 
 config SEMIHOSTING
        bool
+       depends on TCG
 
 config ARM_COMPATIBLE_SEMIHOSTING
        bool
-- 
2.39.2


