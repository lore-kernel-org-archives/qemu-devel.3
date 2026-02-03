Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDB6E8783D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:06:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHyc-000263-ER; Tue, 03 Feb 2026 10:06:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHyY-0001bS-8L
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:05:58 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnHyW-00023e-KK
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 10:05:57 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47ee937ecf2so8827925e9.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 07:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770131155; x=1770735955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=e/nUPom7HdBWDeyWRXsLINrGwvV3vAAlXW3k2FdYhiA=;
 b=wKHn+hSWISHaTmgBanznnuzPbwf3aC6v86ddHmHyKeFBUf/RvT4e/cxoePQr+4MnML
 N4hHL1scMDQXz5RFRXkwErsn1ODIM/uD5MIIkGgzazGjvjl9bgzWbTLeYcYr+OYcw4Cs
 ORnBONES1kp2SnUs75uG1m7TJMxX8EvEUfi5cSg99oj4AtFLEW+qa0HnkiTbCEeqxTG8
 XX4k2yRwMGqfRxQCGuoGzAoKY46685MjZDL7uE722yEneKZdDTDYIIfQBmZ1MfiLxtv0
 W/ZBlgbyGbqhSIJlcPh8WjkNQfoB0GzmLmJeJC2u690ALTlwOomz4iOq6vr3EFgrum9J
 zwpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770131155; x=1770735955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=e/nUPom7HdBWDeyWRXsLINrGwvV3vAAlXW3k2FdYhiA=;
 b=C8nUdZ5ji4SilCGfOYyll7iL1VO52diauINRndeo0if0cLWJMd61RbCa3RNCZExUWQ
 R+ZC90dAO9gKJPoil/KIqce4cDWdsuNkpg4brZXsnjOi6zKSxqAAAfmJN4EzarZDPN6C
 H+eH5HIbP9JN9Up8lY7uvYHrakPI0hcTsjqhvr6KkfPoFQwh7kiGlaBNY5DOwwN6qxDI
 0NYuBJdfE/X4cv8jE5rf8bZ61ot3EMq4Qs+5FTksdx6Vn6vVqNOELPdrzBWAH/MRQfF8
 9C8hrnNfxungt/6r64m1uSvir0lPeVe97QXfWWmK3C/8QW0gax0dCNU2SBQlNneSrg/Z
 96rw==
X-Gm-Message-State: AOJu0YzqNuqdP5GksVgZRrtONDwqadcw6/nsOhrsx1ZQy6Z0RqfKNutI
 m2Io2hJ7VyBj4qLk1AJImZOZ8qMVNQgtM3Cz1cNgh3/s7J/d3nBhNP7Vm85gH4OpfukYFEuf8qF
 q1+7TLr0=
X-Gm-Gg: AZuq6aKNHpcc328er25YA2yw3TowhrQIivQlQjpRjSnxUgxuKSVimSG+hxG5fDsDGI3
 4bET87c4r9x6rpyFBmDxA8aLSPoyVqyHDFlek7U4OK6iTNG3zI8bSS8fGUEU7sgh31xe5/A/5P9
 NUaGGo7m0i5NsQ7ENRRL+pkBmjESi0kiK7AknKbmsTEQyLkjlPFhf/6xh8PxjhYzxvJYJpLiHFq
 ntuslvXji6FmUiOon+ecyGFK6su3zgdIOS0ysv+vf0xid7Osnx0A4taVe1rsXpKdwCMAcRbgG2p
 RxMCgbK9Pt0pQaF3eWnng2DkJZWvE098lJfuDmylltUY8SNLKRYo365erl4NI5cRGuBm7mfKo6v
 c79KwRXpRrZfiMu8nQPQU3bg8IICY6GF5tNFYuomOGabvSGbRV6mr0IgpzgalaNqFuPxAceU9aP
 19ZIduD40scslp+4Ene+da1lf/X647V6njyWXEvPch0mwuttgxcSJ/VqzAR+Uj
X-Received: by 2002:a05:600c:8718:b0:477:9e0c:f59 with SMTP id
 5b1f17b1804b1-48305133282mr43975455e9.2.1770131154595; 
 Tue, 03 Feb 2026 07:05:54 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4830511bfc6sm124206475e9.2.2026.02.03.07.05.52
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 03 Feb 2026 07:05:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/30] target/ppc: Check endianness at runtime in
 ppc_data_endian_env()
Date: Tue,  3 Feb 2026 16:04:16 +0100
Message-ID: <20260203150436.71907-12-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203150436.71907-1-philmd@linaro.org>
References: <20260203150436.71907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Rather a runtime endianness check via env MSR over
a build-time one.

Now CPU can change endianness at runtime.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Anton Johansson <anjo@rev.ng>
Message-Id: <20260202210106.93257-11-philmd@linaro.org>
---
 target/ppc/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/internal.h b/target/ppc/internal.h
index e6e60de95a4..dda23b66096 100644
--- a/target/ppc/internal.h
+++ b/target/ppc/internal.h
@@ -37,7 +37,7 @@ static inline bool ppc_env_is_little_endian(const CPUPPCState *env)
  */
 static inline MemOp ppc_data_endian_env(const CPUPPCState *env)
 {
-    return MO_TE;
+    return ppc_env_is_little_endian(env) ? MO_LE : MO_BE;
 }
 
 /* PM instructions */
-- 
2.52.0


