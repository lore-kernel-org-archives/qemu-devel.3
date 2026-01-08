Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1784ED1489F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 05:39:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdifv-0004oE-4r; Thu, 08 Jan 2026 00:35:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdifo-0004gP-Dj
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:35:06 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vdifm-0005zt-HL
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 00:35:03 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a0bb2f093aso22177785ad.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 21:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767850501; x=1768455301; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Xf07gkf8loieydewrSi0TqozzzvAcAiesckod9deXKk=;
 b=lLnKQyIn0C8n1AbIn9jztKgU1D3QYc2vyJxAk75qQqYZ1nTmMjF9u7ROZKWbj0zlOV
 UQY+qqXhrtLA1qPIm+WeNkiP03feixbjVEeLgb1m/lnJjADiHNLMc1nXJCniQ7YlfT4V
 Nfy6d+K1n9ZgcdTaOOmXh7Rm4EDPtH8kU7mtqakQgZXo3O3t/XcOEycm1EjCo9PD1fgY
 7QSyljFvJob1UoigiglpaIcJD8mArKm6rlKPjbbDbsoZUkM9YASQm+atsu7ahyQmcdne
 Wmu7aQlglt5KEB0ckBF3GiaPrawftey5hLS6htGtdINZCEuMDWO0xdZEe2zEdpYTVnib
 FPiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767850501; x=1768455301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Xf07gkf8loieydewrSi0TqozzzvAcAiesckod9deXKk=;
 b=dQ+xet85fB/7gHcvYYVW4zpf1LqU/TkGOiHE5IZxuaCv1Mj+PHw7iFOu/mA/s1Udl2
 wvRhxTuk0AVAAzI87paYNdMc9ZOfYqiA8J8DPfZIwcd3q6IJZZgCl82Luy/isfQuBPJy
 u5j6D8fOBVv1X/9aeUEJVdNWG4UsyHAdTKKdEoqvp+PXyN67XwpCI4k4p/6DvSjENfXw
 kaOtTnm+FrRCYAjlxAnj193yGKiexUCcVC7TGX/FeIZQ8fRYQdEpZwnzhNtETiIFpwiM
 lYjGCuMFibP6692u/Iok100KNgmo9nrzOYajKZ+UNz+a1E1dSezt12bzt9heSl0o6Zyx
 T1bQ==
X-Gm-Message-State: AOJu0YwvVdT8DanF27MwUudaZDjPL324Q8lyY5RqQgeb+lOg9oPgF0eI
 9xEODDsdUxMfp9nofCIVYTKXoBBrg/4/rVWyhXmplWyAaPPpoMksfAbUS88GJjwyrYEATYS3Qs1
 NTpXyZSc=
X-Gm-Gg: AY/fxX5axCXt2OLaK0qyfNqMlQ2vJp5TKoLsPA+4RlbH/v1uoByTUMFCNZERW2rgKYl
 cisUPWlnVI5oOjdvP10U8+L/7jNjKA3ZWIczDKhAaKu6UkN9xGQGcwZxbtHb5JeKvE8GQi71zVu
 ysasUVXHwsDSeKt0j7P9tXtMmkXavGVn974fyeKhRLmTKBnS9EdSOp1WuFjskAQd0w1mRKKgqOI
 hnYUFxsHNRvKnLWdKwRjaCJqNMOq3BXXAkQBwURBYEBuJUTKKitl1bVGpj0gLSrc19cycLsANUE
 g811fiQOcDjjPTPndovtrimCUZPE36DkWUrgiqFDYy+80tFcOTPpP2q8zv2HJ2FVbB26hSXz2BC
 DjJgP9obj7OAN8glHcYU6IBnO3PigzcmaqK38QzFOrplzcoREeIBrXOUgBaqn9XvN0Q8WHA0fCv
 v7tseb7xrclRz3k0YmbQ==
X-Google-Smtp-Source: AGHT+IH0zhxy2vuwMe0T6+3rs848ckRiWTFrKDOI6/PzJgqkRTPJTulVxa4pq3uzi2BDvFs7QMB4uA==
X-Received: by 2002:a17:902:db11:b0:2a3:bf5f:926b with SMTP id
 d9443c01a7336-2a3ee4c2efbmr50621915ad.47.1767850501019; 
 Wed, 07 Jan 2026 21:35:01 -0800 (PST)
Received: from stoup.. ([180.233.125.201]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2d93sm66341465ad.63.2026.01.07.21.34.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 21:35:00 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 49/50] meson: Remove CONFIG_ATOMIC64
Date: Thu,  8 Jan 2026 16:30:17 +1100
Message-ID: <20260108053018.626690-50-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260108053018.626690-1-richard.henderson@linaro.org>
References: <20260108053018.626690-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

This config is no longer used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 meson.build | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/meson.build b/meson.build
index a18b3a5657..86c9cf7a91 100644
--- a/meson.build
+++ b/meson.build
@@ -2930,22 +2930,6 @@ config_host_data.set('HAVE_BROKEN_SIZE_MAX', not cc.compiles('''
         return printf("%zu", SIZE_MAX);
     }''', args: ['-Werror']))
 
-# See if 64-bit atomic operations are supported.
-# Note that without __atomic builtins, we can only
-# assume atomic loads/stores max at pointer size.
-config_host_data.set('CONFIG_ATOMIC64', cc.links('''
-  #include <stdint.h>
-  int main(void)
-  {
-    uint64_t x = 0, y = 0;
-    y = __atomic_load_n(&x, __ATOMIC_RELAXED);
-    __atomic_store_n(&x, y, __ATOMIC_RELAXED);
-    __atomic_compare_exchange_n(&x, &y, x, 0, __ATOMIC_RELAXED, __ATOMIC_RELAXED);
-    __atomic_exchange_n(&x, y, __ATOMIC_RELAXED);
-    __atomic_fetch_add(&x, y, __ATOMIC_RELAXED);
-    return 0;
-  }''', args: qemu_isa_flags))
-
 # has_int128_type is set to false on Emscripten to avoid errors by libffi
 # during runtime.
 has_int128_type = host_os != 'emscripten' and cc.compiles('''
-- 
2.43.0


