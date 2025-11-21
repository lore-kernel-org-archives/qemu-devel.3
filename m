Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FBE9CFC516
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:28:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcnY-0003hE-EV; Fri, 21 Nov 2025 20:52:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMbah-0002O1-RC
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:35:04 -0500
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vMbaW-0005YG-Ig
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:35:01 -0500
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-37a33f49018so22313761fa.2
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 16:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763771671; x=1764376471; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q/LNyvQG4XVC2EIShm261QCUAXye4D5qWj6DTyVXrjE=;
 b=t7m3NKUZjxoBpuMLDt+hBbUgRB3c6vsUK2ycdFvjrwGw7gEtLkl3iGQGBJIH9c+vdU
 nyE/AAsgfizFag1ouNHsw4IBBndUyXFqjbqOzfO1ZGHxdY6jiP98unsbVuxjLYOL0lMz
 /20tXq93ZNNPSeClDsSTaCMOFPA/u0TrbsUwis7jqF28PD0MMYij64vYcKrxW83cxMeX
 RZ9rePLy2pPg+O2FEGzOe33OixMN3yFAeJMfiHO55jm6aC3AZ2z0BCVq8IHQSl0JaH0i
 8D1DyHmdCJ62w8Z450SfLrBK+2toiD9O4fAxcERQXIcnwLVsB4+FqC6AxUdHJGdG0use
 Szcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763771671; x=1764376471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q/LNyvQG4XVC2EIShm261QCUAXye4D5qWj6DTyVXrjE=;
 b=QdFjM51jYbg1KIn/wMR7HKGZ6dBvXdCPvoYYhWPsjFsDaG5kvad+GjmJyz59fTRNXH
 2F7mCohnuunBuTq+rZmX+7RXxaChki4UxIiKOBs4o/vkQ8ozGLGW09fCYxHhAtWcGqvm
 O6TmIyl3gW/AmkT5Qe/omD8D+UR6Y1PCkY0YHPq/hOgeDCt0vRu/C3zd217m9oEkApjw
 cyfej0arAIPD5F3DGpv/2A+C78CvsKMQJQj4AkPlDWsuJ0TET1cE91X7wZq9P3OUa3u0
 Q4mrBj3zTnf/rtkS9zcSZovAJouHQ6DIjY7BRR8/HVNQFVXINy0SQ/p+sbUailKrHTvE
 8pOg==
X-Gm-Message-State: AOJu0YwKgijlMHvZdJuFmZxJ0AUipJIKPZjSs4OLtWaDSyEFLk9Fjxbr
 Jbsv+oDuSQnxgP2PN1bCsMdr3v4d9lFBcheOfOM0M06uzqu8DJMkS1RusfuYHBJt8KuWJw3zeVd
 kHiI7Beuxdg==
X-Gm-Gg: ASbGncsWVfEDbl/cb7mpeuv3GobBnvDJK3AdpxS0fV+MTrgp2fDx7k0E+7LZqdMBjqS
 TgupPRO66hdbOpmoKG8JoQPj2MdvbYdpr2P0PVZEzHiBWRWzmhbhD7p3UuZYEplkv47HI/vJHXw
 fSwrufEXm5k6rtSXn99sQqtvwnGR4St5U0QiIxPOg0yeZJer3f/ny1JBJ5+96YnrR9Uoz/tnbFa
 vV4v3qpwiRmN+cz/uMjpwsIMMMkNisf3I+OMr3wBmyXQFV/z4COQUJma3KZA5w7a1QGYRgpmVoN
 CkI43f17saUh0gUMQ3XqkPWdCd5yltOhlxRHoZEL6mJwASrG0Ov/fFaGhfGUE1y7Hgc62LcvdTM
 ozdP2PsreuA6isBvvaJ/oKxhPJGXv8s1isNBBhVRCIQ8QukE1HGD5OvFcnFcn5+Nw0OiJn05le8
 h/81zKNaZbw2mHPG6SY0IG02jBYMw0dxZQHi/UfnIRaXieMWNuKO16/T5aANUr
X-Google-Smtp-Source: AGHT+IHi2XGY1TFl9wA1rCtz+bEe5WEfPewQzhXmx5u8D2IE8b9YHW2sB3qoaedzS00kIvOYQaqrpQ==
X-Received: by 2002:a05:600c:3111:b0:477:b734:8c53 with SMTP id
 5b1f17b1804b1-477c10deffamr25063045e9.12.1763732731485; 
 Fri, 21 Nov 2025 05:45:31 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477bf3b4fafsm46361865e9.14.2025.11.21.05.45.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 21 Nov 2025 05:45:30 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Subject: [RFC-PATCH-for-11.0 v3 04/21] target/sparc: Use big-endian variant of
 cpu_ldl_code()
Date: Fri, 21 Nov 2025 14:44:46 +0100
Message-ID: <20251121134503.30914-5-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121134503.30914-1-philmd@linaro.org>
References: <20251121134503.30914-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
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

SPARC instructions are always stored in big-endian order.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/int32_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index b29f693a6bf..a777d17a01c 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -151,7 +151,7 @@ void sparc_cpu_do_interrupt(CPUState *cs)
         if (!env->fsr_qne) {
             env->fsr_qne = FSR_QNE;
             env->fq.s.addr = env->pc;
-            env->fq.s.insn = cpu_ldl_code(env, env->pc);
+            env->fq.s.insn = cpu_ldl_be_code(env, env->pc);
         }
         env->pc = env->npc;
         env->npc = env->npc + 4;
-- 
2.51.0


