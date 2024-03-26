Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D523C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 17:11:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpAJt-0006lS-Ud; Tue, 26 Mar 2024 13:10:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpAJq-0006je-WB
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 13:10:39 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpAJp-0006ux-DY
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 13:10:38 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41491106419so2584705e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 10:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711473035; x=1712077835; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+JsRv6ixpj5OYV0Cs5MSuqaN+IRou4fELCwe6Dlois4=;
 b=PmhqRV9iTChQlK3CQg7W4/7rf0YeJ1uNaRVswR9WmxZrxZ9IBKAe7rsgxuql0QApFk
 hrDw05B2d6rlYahxibPpzYYFmsNsE+hSgm/qguLtnB6WC5XTlDCfq5B8xV8xHrf9nhmU
 ymop0N/gjBr1YwBqs5oi/bqHG8zaZsBtANztpgWBKd0raiiLZ9B8ZVgt1NlCHRCVPbum
 0UNpxPgmrIEbTSiwdtyyAS98z0toHJo9pJgyXav28n7usQXAGxzy2jzpFyseQAaHTUf9
 sVvt0s4TOAdy2b9J73bVS/KhiW9ICwO002OaddUYQwlOn9vcAQ90gYLrFx7grn0wGUsE
 7vmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711473035; x=1712077835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+JsRv6ixpj5OYV0Cs5MSuqaN+IRou4fELCwe6Dlois4=;
 b=YLaDnhrfL7Py4hP/HpKHa8mzO3GXueyG0fLJtM0QhVUdQx3J10SaVgtKNBuyn8cf29
 W+BuAf2zHEGfYlOiZU1SLF6vqqlcXw8QKF7F8GdU/FptcQD4k1otKG76hUjw0F3geTO/
 jTxy+xrwQWc/vn7LcTeC8a3VyTjpAgzbIvJdF+TetlWxFQ8SWugZsthLDZf5G8Y+XVA8
 H92yuBOAv1blFvEv5zCGljaJCdQg4OG/QsN3jFER2tJxuUKy8s7MuFXxdvCS1baOg3/2
 12n7JxZiwFWostTRBpJ6THKsbXbgXczhUUTM1Aw5/+1NtZImyYNaJdD3aDH8w7olVP2z
 4v5Q==
X-Gm-Message-State: AOJu0Yxle9JqUcHuMNhtKlxyx7f2cAMoVT+B3wvXrSh6GaAg5vxsSaXk
 gOGH4RrIyoZHR2b6Gx2sw/BgWSu75wfEHFn1AlGL6+rDWWvhOTOnBY1zf/hZFhwJzqNswO4G6At
 v
X-Google-Smtp-Source: AGHT+IFIbNTnLzNHM7oXL6ldw0NmymiL4lQ5opdUbPEQdjdfOaA0f7YrTHfOALu0meK/VrBCthU1cw==
X-Received: by 2002:a05:600c:3508:b0:414:8c26:4213 with SMTP id
 h8-20020a05600c350800b004148c264213mr3598054wmq.13.1711473035469; 
 Tue, 26 Mar 2024 10:10:35 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 q20-20020a05600c46d400b004132ae838absm12139352wmo.43.2024.03.26.10.10.34
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 26 Mar 2024 10:10:35 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH-for-9.0? v2 4/4] meson: Enable -Wstatic-in-inline
Date: Tue, 26 Mar 2024 18:10:09 +0100
Message-ID: <20240326171009.26696-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240326171009.26696-1-philmd@linaro.org>
References: <20240326171009.26696-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Compilers are clever enough to inline code when necessary.

The only case we accept an inline function is static in
header (we use C, not C++).

Add the -Wstatic-in-inline CPPFLAG to prevent public and
inline function to be added in the code base.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240313184954.42513-5-philmd@linaro.org>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index c9c3217ba4..f400f7d36c 100644
--- a/meson.build
+++ b/meson.build
@@ -591,6 +591,7 @@ warn_flags = [
   '-Wold-style-definition',
   '-Wredundant-decls',
   '-Wshadow=local',
+  '-Wstatic-in-inline',
   '-Wstrict-prototypes',
   '-Wtype-limits',
   '-Wundef',
-- 
2.41.0


