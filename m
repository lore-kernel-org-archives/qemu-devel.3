Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9851CA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 01:25:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ur4jd-0005wz-6V; Tue, 26 Aug 2025 21:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4hs-0001fO-DH
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:12:10 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ur4hk-0000Hm-OD
 for qemu-devel@nongnu.org; Tue, 26 Aug 2025 21:12:04 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-77033293ed8so4091424b3a.0
 for <qemu-devel@nongnu.org>; Tue, 26 Aug 2025 18:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756257114; x=1756861914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xxE7jzMVEM5Ywa95KYNW7TydvGqPvjpMN/Env8Z0kps=;
 b=M6AGBwz2l4TLIF4/QFGbZpI6z1voVojsfo4Oa0lPe8ZG4Dg4TVs0SMc0oriQvJaGpi
 sx5E/rv1nn0nPg1a4eDKdmkTNBzWMF+DrSYt2FP4gUXt6bc7Qd12wymk9+NbfIw1MNyb
 Ub9P2bRU4MVXhE0+2MRbxzEM2gqVUJlBYtWiRPmtvcUQK49INv2zDgnzQjWXGIsBkFUN
 R+fY4HM4A2+H/ogq/lYz85yrnBhKni6tZmc5hSLhpq2yM1J/xBApjbzCbsIpjL0dzOaN
 LbbHZDfbbtTMFDJFWxwXuEdBgxCWWnRTftb4UFc9Iq9gdwuU99ufZf5bdeH1ZIsK5o+9
 6bdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756257114; x=1756861914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xxE7jzMVEM5Ywa95KYNW7TydvGqPvjpMN/Env8Z0kps=;
 b=UL2H9HFxDP1ORv19Jy7iwXK19xjEGh+paV9Cu/U9WkjijJGuYRRE7jHD44ZNGv3fLI
 obRfncG+9tVdvYbx2ljc19Ega7golS0NiIuFK3Czt7PT3cSVhK4Gn9NLQOVT1dihHrnM
 iH7OKwg4Lzdy0b8YKc+Uh0JLlU1xZJcnVu/P/bW2VpIm64VDlVbQ93Fbj1W9tkrHbq0/
 WtbtAWXu/LlGBhP5gUT/elAaN46oufAbFpsD7YDwhLFymmSdkGZe6MXRKdOqF8/vG9dy
 zYypkR9BcSmBantf91BiUET3+Xhi7BcfsRp2M3Ypgpehyswt/M70GmNmAHc0WwEG1RvW
 L1IQ==
X-Gm-Message-State: AOJu0Ywcmyd6cqx5EaeWzm9V4KZNcwhdebecpQ3MkM2ESM25XFSs6jlB
 7ecCgIOEft6wBbec4QEDmUjgNEz/IffkO9PH+Qjo15eJCGFkG6eWqWjdS75/h2oxWJh7LhLTDLh
 j5XGAHGM=
X-Gm-Gg: ASbGncsQgi4DQIadE5+tI5/G6brX0RmJGRL2ZHqGPrziGj9G5v1UpLV7rgfT24gGDCl
 ZRM/H/Qs1mDxr0s4nOxqidc4P2tbXcZQYkgeIgtVEvuusPY72CcYOqlD7xupFPlHAM4j8o4RcSU
 argHSyizJFwfKZK6vAqULuCUQfyqWXEDZ87lG5kDKUcD4sQXdv7iw7iLhU1roTPTD0+idVrKq8m
 m8RYjFjtQw/PgujJpu62ToKcwP/00CqFtfXwwOa7l6xMfZYmWzesa5AZh9iXejspG6vt8RX+HWH
 dKvc6IMbFghgxiO8UKh5qIFmR08ggzFALz3pt73UxbLriA2qnp2F9kgzZ+fPT/LN3dIQClZ9hMX
 LTxwSHDfZUR4PAw0vKwxKA4xkxA==
X-Google-Smtp-Source: AGHT+IFqZnVJZBlP19HMJi4h4agGBy1DbroqnNQ96ykiiyHlt48HIhte6M23RjF5YxMiM2Z4J5tiAA==
X-Received: by 2002:a05:6a00:6c8e:b0:76b:f318:2d41 with SMTP id
 d2e1a72fcca58-7702f9e0d45mr23278258b3a.7.1756257113806; 
 Tue, 26 Aug 2025 18:11:53 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-771f2b2d2bfsm4348408b3a.93.2025.08.26.18.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Aug 2025 18:11:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 54/61] include/qemu/host-utils: Use HOST_ENDIAN_FIELDS in
 muldiv64_rounding
Date: Wed, 27 Aug 2025 11:04:45 +1000
Message-ID: <20250827010453.4059782-59-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827010453.4059782-1-richard.henderson@linaro.org>
References: <20250827010453.4059782-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/qemu/host-utils.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index dd558589cb..5a7e623909 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -94,11 +94,7 @@ static inline uint64_t muldiv64_rounding(uint64_t a, uint32_t b, uint32_t c,
     union {
         uint64_t ll;
         struct {
-#if HOST_BIG_ENDIAN
-            uint32_t high, low;
-#else
-            uint32_t low, high;
-#endif
+            uint32_t HOST_ENDIAN_FIELDS(low, high);
         } l;
     } u, res;
     uint64_t rl, rh;
-- 
2.43.0


