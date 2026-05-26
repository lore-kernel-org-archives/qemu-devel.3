Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8368CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 15:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRtXi-0002K7-HX; Tue, 26 May 2026 11:18:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRtXh-0002Jf-Az
 for qemu-devel@nongnu.org; Tue, 26 May 2026 11:18:05 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRtXf-0007V3-LQ
 for qemu-devel@nongnu.org; Tue, 26 May 2026 11:18:05 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-43d75312379so9073276f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 08:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779808682; x=1780413482; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C2TCsy+hHJVh+03YKTLTLgv29mF+MOATXr2TeMxBsFk=;
 b=qROaeM6xSDY2Vbm01nbLYWiJFKG451Ts1CwWcxNqWmyIfPHa8fuYWZVob3jUWTM5XC
 BsyQMXmHD6x8NcHAmwCNewKUvNyBajjTXDj3+DTk81gtHTSy1BwJSTjVr7qm5QviaIJW
 RCLJQvju9SGCMuZsrZaMr3gmNiH7nVLm9nMVhFNRBS8wf4HBpKn1K6ByXsHMFpXsUaFI
 h0ouQazOdt5c6B8XN3QaTuxqBwaV+uin6EIsMAYgWoUwoy0GHoIW5HzR+7xiAplxw6Nj
 mX21TyhkoiaakQN75GZvnc2r0tbtdxrT4jc8g6WYG6ujuGQtAzywkMzhLdgllG6yaofH
 JwXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779808682; x=1780413482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C2TCsy+hHJVh+03YKTLTLgv29mF+MOATXr2TeMxBsFk=;
 b=m+2ZBV2gY/SN0LsSood+v2oagnX2bU9C5mUYaNWi2GPT3iXS6zb8eHxsT4ZMJUIWxW
 oNzclkjY3GOi98SPyn99fXDioLsJTeZRbHaUe/PR3HNM8WocDhh0YjY8u0bMnmleMwl1
 WbwySCYv4JdUh5O5x2ShYkX+btEoW2bkKbb/CKf1NuGXmqlLSDpd3K1hGPzX9TVpHTC8
 +WQZLhgdC15aXu6/0tBQVegGB21sWEHOIixKxR+mAGJdAasvEL9TGE+dz85Q2PN8XHx2
 KxzJSfxs9Ufsk8qFrkPJAMt5IrCMcB4xetU3M4qmdz0vlxGwKQMsxHVKcBCrPwDGdjbU
 w00w==
X-Gm-Message-State: AOJu0Yy9G0IAERfqCdJq0r524pv1Tl5XZ24FS0ubRubSMcdNZfZez9Xa
 K1ggxAY354YVwskah9XDCzCxv2bQDlg/0XbmLjOm3QHfK3HjBC4dVhusgQstwFtJ4S8mI1LDyMC
 WJuZp
X-Gm-Gg: Acq92OHtIGb9qKwd7bRlk4THIgU7uw+EEJ4Ag68DSDHJuKZ8DGhBm2GBjGbOxo3Jf/p
 lGch/bFn6K4daPBWwTLGKcYTZAZAi/0MRPDETf9YFhJ1jaw57kXH4JDsVlaYIFkOr5X16hGRZTk
 qC/GeEObleQVfp1L9MBYFqncPr59WelF8QqNIDU+kYftUbtJHw4bZ2cxJcb7tLCMTFpTXomBm9W
 umGrzU/9917TQf4GnEoKsnvKK3YCK2B8gsK8Qu2qSWY/P4ysWRh4/eSEDV8bUQWn+zmfMWV5VcX
 FPtX8s9rzoLQUXXbmJD2lxA/b+Tf45bk9GvNQIJUZPU22qEza48nBiB4x7b+LiRGXmCMBEgXjp+
 9tGBph537EkhBiJ//lmEyAZvoFPR4SkIn//oCPdR9rwdHgwQ6DMMyMwVN/yU6Ln7x4OAQCc8i2M
 MniymWdD2/j1gMprRnkv2Hno1J4p2N03JIWKmuSK/R6Cu5Vl0JBWBIHe5jiLM4bkEm2DiVsv69E
 njL4zVYLzTESZLtufgpgERlWdvg2mE=
X-Received: by 2002:a05:600c:2a8b:b0:489:1abb:5559 with SMTP id
 5b1f17b1804b1-4904226d9camr169071215e9.5.1779808682135; 
 Tue, 26 May 2026 08:18:02 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49042ce923asm111485275e9.35.2026.05.26.08.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 08:18:00 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH 2/2] linux-user: Move cpu_copy() to user-internals.h
Date: Tue, 26 May 2026 16:17:57 +0100
Message-ID: <20260526151757.2371476-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526151757.2371476-1-peter.maydell@linaro.org>
References: <20260526151757.2371476-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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

We only use cpu_copy() inside linux-user, so we don't need to have
the prototype in qemu.h available to code outside linux-user; move it
to user-internals.h.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/qemu.h           | 3 ---
 linux-user/user-internals.h | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 474489f046..07fe801628 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -368,7 +368,4 @@ void *lock_user_string(abi_ulong guest_addr);
 #define unlock_user_struct(host_ptr, guest_addr, copy)		\
     unlock_user(host_ptr, guest_addr, (copy) ? sizeof(*host_ptr) : 0)
 
-/* Clone cpu state */
-CPUArchState *cpu_copy(CPUArchState *env);
-
 #endif /* QEMU_H */
diff --git a/linux-user/user-internals.h b/linux-user/user-internals.h
index fbfd12237f..0380d44fe9 100644
--- a/linux-user/user-internals.h
+++ b/linux-user/user-internals.h
@@ -209,6 +209,9 @@ static inline void begin_parallel_context(CPUState *cs)
  */
 void init_main_thread(CPUState *cs, struct image_info *info);
 
+/* Clone cpu state */
+CPUArchState *cpu_copy(CPUArchState *env);
+
 /*
  * Include target-specific struct and function definitions;
  * they may need access to the target-independent structures
-- 
2.43.0


