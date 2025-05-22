Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 538D5C54E90
	for <qemu-devel@archiver.kernel.org>; Thu, 22 May 2025 15:18:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uI7gs-0005L9-Id; Thu, 22 May 2025 11:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uI7ge-0005IT-TE
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:18:27 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ktokunaga.mail@gmail.com>)
 id 1uI7gb-0007ju-IP
 for qemu-devel@nongnu.org; Thu, 22 May 2025 11:18:24 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2320e53167dso58582155ad.3
 for <qemu-devel@nongnu.org>; Thu, 22 May 2025 08:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747927100; x=1748531900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cCq9WAUGr8u3zKF9/a0wp/dlu28iL3FkRTchvocCuNo=;
 b=TPYaqX87SkkP+uNrxUG56/jIZnARyhMlwS5UTLykFDUzNeSAnce6e5AE2VD9hX31HZ
 Db7Bs3sGM9NFJ0vJt6g34rsaNnZJHLq5Nqab1+sxwD9HBdsSKjZM3fSrgXz861SWD/D/
 6Yjq04Ug1sPKvNLnydBpcpFVZCsE29Pg/Ycqcgz9sA86M3sCBkgakstJBLL+weiNqufc
 k9iI8ab4cfHjuqcE1Akl8dEb4Rx/hZqoHqRlP1SkdFaaa94CDZ6csHLrNd3OeQiWTFW6
 YJ6uhGZ0brP/kFbdK+ifzToOe4Win66W1b6+fBWltMZuKKZpmnMj6z+3G2jXo15Vqp00
 JGgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747927100; x=1748531900;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cCq9WAUGr8u3zKF9/a0wp/dlu28iL3FkRTchvocCuNo=;
 b=BMkQR6blfRHr1aAC15I5WB2BXpQLEWrRtfYwfyvgjjBi9zPfE1Krk4RidD/8oIrXV0
 26EPx+3eYIk8wr+dbfR39UzTHIpnFJyWUhU1q+oH6fFoniRz5/S8Y6Oujfg3gnJcmpq8
 xOGZAbWd30pdiZ1qj4MEECMUwV1tleJTRIZ71La3PkBd1nj5RI8sbFdf3zO4u8Pi6PlF
 id6u/A0ym6S40mhbbNJcvO3Gl/9N/HhhVyKlZqHHXGYRMUsMYFhJTVo1akxpsb0NKmlf
 9b67EHE0hiGujk3d2HhUtb7N4rSXzf0kzVEWEwmiwibtMQ6qCnu2ORbLWXb1M8zzXB9j
 1XCQ==
X-Gm-Message-State: AOJu0YzFONTFt9SgxgFG919cHRMqzH6Gmf8awKMl9Y8qG4Y3Fvv0+tJZ
 wNX5I6NHYEIkVRTtJsB1SQz0gPGIEq0ERgZeB+1XTw3nudHyabEqMFtwN/CMKw==
X-Gm-Gg: ASbGncsmbIVW6xPmmP8gxIDrOkPCqi/SCc7ohqZMZAtLjSoHe+Dj6/FzoAppmR0BnMj
 gF83O6qSWzOqpg2S8x0gNT01EvkbRrg7HauN1UDGIMslw2RQoi19ErI2wRD5MoKMa6b61DuLXTT
 Y+zl7m5u1dZ4/gdnV3Zuy2MSv3DBkwhW39JznNEOYUBaOcT/m16+RLSjKX88V4cBmWuYSEbCUWV
 W6ikolEyR+GuZFBBzwvWsxMnOfihW7iMGV6DJ2TZmNMsLIoUf/7KMMFebAShAm0ArwppVra1Nt8
 k6W0uXuJnH7E53EYI5likG5HmHNRJAK8vREMOnJDp9yxTNYq7KI=
X-Google-Smtp-Source: AGHT+IGhJnc7Z1q2+r+pY4vXa3hJe36Qf0wt5hdjKlEsyT708xfaMOH+EYfSc04YXasZ7ymtVggpkA==
X-Received: by 2002:a17:902:ea08:b0:22e:6801:b9c9 with SMTP id
 d9443c01a7336-231d43dcc72mr309468365ad.8.1747927099882; 
 Thu, 22 May 2025 08:18:19 -0700 (PDT)
Received: from ktock.. ([240d:1a:3b6:8b00:c732:a88c:b916:8b9f])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-231d4b017dasm110443555ad.98.2025.05.22.08.18.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 May 2025 08:18:19 -0700 (PDT)
From: Kohei Tokunaga <ktokunaga.mail@gmail.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, Stefan Hajnoczi <stefanha@redhat.com>,
 ktokunaga.mail@gmail.com
Subject: [PATCH 4/5] tci: define TCG_TARGET_REG_BITS based on TCG_VADDR_BITS
Date: Fri, 23 May 2025 00:17:29 +0900
Message-ID: <3edb13f42740984e2272425478bb58a6d985269e.1747922170.git.ktokunaga.mail@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1747922170.git.ktokunaga.mail@gmail.com>
References: <cover.1747922170.git.ktokunaga.mail@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=ktokunaga.mail@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

This commit defines TCG_TARGET_REG_BITS based on the value of
TCG_VADDR_BITS. For non-wasm hosts, TCG_VADDR_BITS matches the pointer size,
so this change preserves the original behaviour. For the wasm host, this
change enables support for 64bit guests.

Signed-off-by: Kohei Tokunaga <ktokunaga.mail@gmail.com>
---
 tcg/tci/tcg-target-reg-bits.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tcg/tci/tcg-target-reg-bits.h b/tcg/tci/tcg-target-reg-bits.h
index dcb1a203f8..0e5db44e22 100644
--- a/tcg/tci/tcg-target-reg-bits.h
+++ b/tcg/tci/tcg-target-reg-bits.h
@@ -7,9 +7,9 @@
 #ifndef TCG_TARGET_REG_BITS_H
 #define TCG_TARGET_REG_BITS_H
 
-#if UINTPTR_MAX == UINT32_MAX
+#if TCG_VADDR_BITS == 32
 # define TCG_TARGET_REG_BITS 32
-#elif UINTPTR_MAX == UINT64_MAX
+#elif TCG_VADDR_BITS == 64
 # define TCG_TARGET_REG_BITS 64
 #else
 # error Unknown pointer size for tci target
-- 
2.43.0


