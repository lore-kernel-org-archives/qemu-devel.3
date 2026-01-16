Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55171D4A5EE
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 03:40:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgagO-0005AJ-Ch; Thu, 15 Jan 2026 22:39:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgagM-00058O-CU
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:39:30 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vgagJ-0008OL-I2
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 22:39:30 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-c46d68f2b4eso990563a12.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 19:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768534757; x=1769139557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7cyYL4DVaKa33AbZpjE1YQS7WRtchLKWVUrU1QN8V2g=;
 b=R4RExKIzf0ritcDA9bcq1VKwEhi+nBYwOByNRTHwI2TkswdXms792Vuk7+XM2JpiJc
 LEiL5/L3zDt2nlwhRkVgR3oSzI+C9Pi1i2yIyOSxMcE6yEyxi045FsvaZ9zh5GHIEVB0
 zcU9gX8ELh61yyeDecNTa9SsdrDFM3LBZiatyP/5B6pspQvOm8En4/1JZmzBhZMSHa3X
 8p93R6HgY93NoDyu+iSJcdW2iFYgr2rgPdOCGg7e14jpnmexgQDd9MSxinL7cKeDOlNc
 qsdUtTlqrQSnJqze2QvbNCbvos7UoMgYjFgZuJGOrHdsC3myQOWzjdI16onBaeCEJf/C
 OEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768534757; x=1769139557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7cyYL4DVaKa33AbZpjE1YQS7WRtchLKWVUrU1QN8V2g=;
 b=Ojn9XnsYE3x6pqlhND22yVOZaThOYpFZ8tPiM9Wt70tWSeQi8zzOEdlbHtZ+X5axvk
 sj/jZV1HWLDGOhfNPxl7qeklP5P8D1/UOGv9lASCh6zZJKlAwtLj9b0wb93KIMjQkFdP
 yHs1PxgeO8EkxwyVio231WJRJW7RRcZKtH0xasxyI7lwv++rVgdKnjdrcEo6b+Pcn6nf
 If+5qKeg1Xk5jl3Wph7sZv2NFrx11IAEH+NOdg5OMieIWm38GR04smyATfiaR85kQIkm
 y1coHS7GJhMpe1iCIN7KC4FFy4MiCQMrJTovp11hIzYzh4F6IHfDrnixcdXD2PEN8d7t
 eqEg==
X-Gm-Message-State: AOJu0YxpGuVSB+uwOw//m4eX4yBvo1xKfKkb9AAPUR1UDn6zH6IgsKcB
 5Zsp51CGUme+UF9tF6YywdrPScAMNeik3Dq/v0H3u4C3qGW9pzHB0jaPYqc8cYILs++OhoVjM2s
 E0sGBJo0vMQ==
X-Gm-Gg: AY/fxX5868eGILnQw1qhtK8UobWvhDsaYZ13yrs3mYFIsNIZAEs+weCRXlwIzkce4PD
 UUeExv/8ToBW2rsKQEb/5N36CDiQNXAnIk820NSi0FXob187SGDA8bHXLXVS9jEqxES4H1pg4LZ
 48YviWBdKlYIPoI5ru4xY6oGOz0G/IyrJUhuTAGsb936Ej6PRzU5yGz8CuymSplFQVSDmCYr5jc
 0Ok+ygXWuzdEEDdpwUhubjJ5k5bINerfkW7GxiAkMK1GSfHeIlyVXbIl41fo8JJ0HMAyAj1TmUw
 5Stjjlnrn91y0b++Rwc9FpSeuzLD/Z6Qa8eu+SzIrGwe2xL25sX+PG99hlubPwn0LQ0xY95FaC3
 fA4uaWPe+ecmX9Fj6l5jl4dOz4Xwm1XNcPtVuFGa0TUYl9hh+FUWOlHT1vVnQiRcQPWWwoLu8j1
 wyx9o4N5ieQV69aZmMTQ==
X-Received: by 2002:a05:6a21:2d4a:b0:35b:b97f:7471 with SMTP id
 adf61e73a8af0-38dfe62a16cmr1815926637.4.1768534757306; 
 Thu, 15 Jan 2026 19:39:17 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a7190ca9d5sm6527975ad.25.2026.01.15.19.39.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 19:39:17 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: ktokunaga.mail@gmail.com, berrange@redhat.com, pierrick.bouvier@linaro.org,
 thuth@redhat.com, pbonzini@redhat.com, philmd@linaro.org
Subject: [PATCH v2 47/58] linux-user/hppa: Drop CONFIG_ATOMIC64 test
Date: Fri, 16 Jan 2026 14:32:53 +1100
Message-ID: <20260116033305.51162-48-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260116033305.51162-1-richard.henderson@linaro.org>
References: <20260116033305.51162-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/hppa/cpu_loop.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/linux-user/hppa/cpu_loop.c b/linux-user/hppa/cpu_loop.c
index 356cb48acc..e5c0f52d94 100644
--- a/linux-user/hppa/cpu_loop.c
+++ b/linux-user/hppa/cpu_loop.c
@@ -83,20 +83,8 @@ static abi_ulong hppa_lws(CPUHPPAState *env)
                 uint64_t o64, n64, r64;
                 o64 = *(uint64_t *)g2h(cs, old);
                 n64 = *(uint64_t *)g2h(cs, new);
-#ifdef CONFIG_ATOMIC64
-                r64 = qatomic_cmpxchg__nocheck((aligned_uint64_t *)g2h(cs, addr),
-                                               o64, n64);
+                r64 = qatomic_cmpxchg((aligned_uint64_t *)g2h(cs, addr), o64, n64);
                 ret = r64 != o64;
-#else
-                start_exclusive();
-                r64 = *(uint64_t *)g2h(cs, addr);
-                ret = 1;
-                if (r64 == o64) {
-                    *(uint64_t *)g2h(cs, addr) = n64;
-                    ret = 0;
-                }
-                end_exclusive();
-#endif
             }
             break;
         default:
-- 
2.43.0


