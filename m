Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 566F2E77188
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:22:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX6KC-0004Mn-RE; Sun, 12 Jan 2025 17:20:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6K4-0004DZ-VX
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:20:45 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX6K3-0006rh-Dg
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 17:20:44 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4363dc916ceso28861005e9.0
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 14:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736720441; x=1737325241; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LHQwz6WpRZiIMj0pKqCUWLnwCFUQnRWpgUl34aEsFJg=;
 b=qkTnQYUbPKXkPKJZykx/i9/XOxZm4bJYXYT5ErJ3vBrPhU96MQyHqfTkRa6a9SCbfE
 59d3qWNFKQDcL2wAgoJ9JyOkJXYC/WvFiYDERo+yTU3VAwKYVOg3DukPBQG216lH/SNj
 K4ligzaIF4GzlxIsT3nP16o34uRZRG0XzIhpNfH4LAK6FijEcQGU44sP8DXXr0kdw9qz
 d0gUqKFKDaPdCyDA4zBERIBGT1hYxiK09uINHBQL/qfaDX43vcBPpvS0xJNdAwh46EZJ
 BJ3Vc0zJ+WFSnAvgrbxYSsXPqqMsT3Mgj8cAWcFRkS0mioKOzokiWs2sIU0rCMW6VR3h
 UNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736720441; x=1737325241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LHQwz6WpRZiIMj0pKqCUWLnwCFUQnRWpgUl34aEsFJg=;
 b=eVMa8HJFPGOWVvGjO+xRQiWE71hSBmvRsXhKVF31CEjBIcUAOmmLwpF6yjo8g5xAJD
 Vu0ktcsZRvqj12RJar7pm6Kd4zII383SFSPEdemnPU6oVmi6mtaeQM7/1Aug8zSP1i21
 /5alM6nw6LbpJkRAOYqu6C/D/6dybSv3emNum4VECqMhwDTyZ19dwiNdvJP0rLgisF9S
 fJqdL48WXWxCBtkm1C3gvX5HR6rKYw3M7meg7hRykrpatN61rg2lEKM4iROz8SZZ9O3E
 6dS7Ms/xUOqPk6/YEyBPBZfCVEfxKXLQpvgrGhWfnIIqMs9nC2MbkB9ENsMAEW73IjBt
 +KGA==
X-Gm-Message-State: AOJu0YzpGVHOSanE5tSin5LkEE4PseB1Sw/W8l7v2KrDZ8UFhjia5OyE
 4YepQurwJoWhbrE+eo6axor7dkwygwETzVB4Kl7uZGft+hAQPBQnKUKq9hxickcde8rQ2tWTOR5
 8SbI=
X-Gm-Gg: ASbGncv6kcJ+5R3xrFIerlDZKKZMMQIDyUi5/v456ibOZ6hFbgduZW970VHooO6l0P7
 NWkSS22qt60y66A3++jcTmQD3iSyD0y4T+p4AzRhAo7l9mAHPLopfqLwzy56J/qOjs/tnyJkRPp
 1dWs2RD2iqjib8AFj3SawHSETblxA3ufU3ocd1ycK6cb6hZIaXcyWfa6ZW/pzzg/nFO2nrEBneO
 v+bIezomxFjyLqd4DlN2eyM88+csFYdZZ3yJ8VdWTm8Omg//tCbyO0Qv0S7PcMuVMBwXqPu6Qi8
 Z3yFvb2V+IsIp7omNsaBG5IH455ASGo=
X-Google-Smtp-Source: AGHT+IHZe1KYE8wc/adwN5MwQdXvV+X+cZhzjqwRoQFob9j1V53VPxJPWi6sJ414ZybAgKLD9wFp6A==
X-Received: by 2002:a5d:6c6c:0:b0:386:4244:15c7 with SMTP id
 ffacd0b85a97d-38a8b0faaadmr13529907f8f.25.1736720440745; 
 Sun, 12 Jan 2025 14:20:40 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b81e4sm10752645f8f.64.2025.01.12.14.20.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 14:20:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Helge Deller <deller@gmx.de>
Subject: [PULL 39/49] target/hppa: Only set PSW 'M' bit on reset
Date: Sun, 12 Jan 2025 23:17:15 +0100
Message-ID: <20250112221726.30206-40-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112221726.30206-1-philmd@linaro.org>
References: <20250112221726.30206-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On reset:

  "All PSW bits except the M bit is reset. The M bit is set."

Commit 1a19da0da44 ("target/hppa: Fill in hppa_cpu_do_interrupt /
hppa_cpu_exec_interrupt") inadvertently set the W bit at RESET,
remove it and set the M bit.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Helge Deller <deller@gmx.de>
Message-Id: <20241231190620.24442-5-philmd@linaro.org>
---
 target/hppa/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 41538d39d62..dbd46842841 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -209,7 +209,7 @@ static void hppa_cpu_reset_hold(Object *obj, ResetType type)
     memset(env, 0, offsetof(CPUHPPAState, end_reset_fields));
 
     cpu_hppa_loaded_fr0(env);
-    cpu_hppa_put_psw(env, PSW_W);
+    cpu_hppa_put_psw(env, PSW_M);
 }
 
 static ObjectClass *hppa_cpu_class_by_name(const char *cpu_model)
-- 
2.47.1


