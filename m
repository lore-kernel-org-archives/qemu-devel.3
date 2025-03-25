Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B070CC3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 05:08:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twwON-0004SK-Pi; Tue, 25 Mar 2025 00:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwNy-0003nn-Kq
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:36 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1twwNw-0005s1-Ae
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 00:59:34 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-301918a4e3bso9479854a91.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 21:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742878771; x=1743483571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4oOs5VbZVOvjmzXBjhiG3M4+ph6BhOZ9OEQr0J3OxEc=;
 b=KcdnRnb0Te7hatntx83UKIQy5/DBhqGnSRXGmYw6iKbDccM25r4fiQk+FU53qf9nt7
 +mYtIIWED3FojU6nG5blodn03wYAp/HDTmKIzJ+qW6XD9A/8qM3WhqoAFjRaJP9V1RdN
 jVkthaulWTQTmemN0VNwOapBZgw0YUFIC6OUhw8NSq5X16Idrw8XfqwPMYi6pnu69i1k
 u5ln0Un67MkUvH7d2qOWgM+1yXP07oHu/13HCMWGhi7Z6LcCektoXG5wb6uFd0UcHrAg
 uAVsTNBCbk2QLTJka6QuJUbKtaIJWK4iD452J1c9v/ftRIY08QEXAR4vJszO3smnmO/a
 0woA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742878771; x=1743483571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4oOs5VbZVOvjmzXBjhiG3M4+ph6BhOZ9OEQr0J3OxEc=;
 b=LYIssq1dT2DQDLII2Q3/QGhC4gVyAPTQcAkMffUxovTXTPQ6DKwWVg5iT1zd+PAi3d
 a7M79anTiEU4Lsei+YdbkBiDfqgGGIjN1ee9LEJU+UskrHyx6UxzBM77VlMGc+xNMm/B
 Qq594MCh4b+xIUN9spC7nkYPhVejsq0FSMy1okKes8ruQILspau0ZdcuQKpAU7I5L9cT
 1y4GZQte2VGWmI9cAT3TUTh2OTGLgfNvIZMst4TryACJdC6yloCFwpolrL1xfEs/R1mK
 Bx6xW5Sf452kXCO23P67MgneZTwPqhmuKbX2krOA3bFGwWCsiBjZNjeGfFGmYt2huitA
 4nPg==
X-Gm-Message-State: AOJu0YwDpD/NFX0iWdHD46oo88XN8TTxOT8l/mCxTm0bg2z547AT3Sa7
 irNjF6XjT9y2cvs1RiZlKv8iVj0V9nvdkUxfm4UNY1EMY6rDLygELhTrbBsCpQkkifq06HeJhpC
 T
X-Gm-Gg: ASbGncuUvkKF0D2k9Jun25BAl2nqtz5ihBE6yGyFQCVioR9VK4g4H6iXa2p0gKPcPYh
 DNfUK1L2MehVGM2SKqLf2WyA+o0R/o/E9dUhvnx8+JYH8LxeIHetEDa/+uzBCstRe6/3e3m/+K2
 vad0ZeuJ4zDLXYwzSc2hxCDWtfQsAtGUNgtk47da7J3Hpon91wcAMixjanAz6xebDdZW7fkOr7z
 he5WXwkknu3JS4vD7dqfBVdHq7XCdlvFvL4gB+SYbkX27NE+8pdW1dS4Sn4uODi0QmZvR1Qwb/1
 WDB5EQTEoyfvw1fN1xQ6rn2XLQ24ButDTuPmOjtvP1wJenEHsAXvLf8=
X-Google-Smtp-Source: AGHT+IFMmlkYsXzeL5u3McRmsvIC3ugcT7OUO/5VRCqbHDoGqy5n9HjN6AzZXS/dqwuovLHKOYS3Dw==
X-Received: by 2002:a17:90b:4cc1:b0:2ff:5cb7:5e73 with SMTP id
 98e67ed59e1d1-3030feebe86mr22119927a91.23.1742878770766; 
 Mon, 24 Mar 2025 21:59:30 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-301bf58b413sm14595120a91.13.2025.03.24.21.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 21:59:30 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 10/29] exec/cpu-all: remove hw/core/cpu.h include
Date: Mon, 24 Mar 2025 21:58:55 -0700
Message-Id: <20250325045915.994760-11-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
References: <20250325045915.994760-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102f.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/exec/cpu-all.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
index d4705210370..d4d05d82315 100644
--- a/include/exec/cpu-all.h
+++ b/include/exec/cpu-all.h
@@ -20,7 +20,6 @@
 #define CPU_ALL_H
 
 #include "exec/cpu-common.h"
-#include "hw/core/cpu.h"
 
 #include "cpu.h"
 
-- 
2.39.5


