Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D79C83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:42:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcAv-0006G3-9J; Tue, 01 Jul 2025 10:41:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcAt-00065F-7g
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:41:31 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcAr-0006ts-GM
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:41:30 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a503d9ef59so2661167f8f.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751380886; x=1751985686; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Etx308N3I1KijyhBGAM+HBbz94lNBN0h4vUS6IObI1U=;
 b=jYr4xBdGUdF0mZmiNvEIcRNilYiRxfAnyTOs88nbbSYA73z4wZAGKbQ1kDRysSdik2
 5Jho8o1BrzkldoNeVLmeOySb0jPkJbenpSWGated7YSVNVKnSra28sUyUJ7eZk6FABiu
 7ECMVh0l2WpEHNyM0dGd0r6ugi05KzpI7uvTsn6GWCmngf5zInNvILBHz7XwwSoqp41y
 bobRYrWo1xesXsZdjBTVauVODw6ESGVi6nm6u8VBhx8qCu/E0khhJIAOyLFjx/AvPIiM
 e8Y21ilyCkMPFUHWbCzbrgglV+ggTfcyNIG1f+2EVNcGswkuaz+3ScR/5LLKKxRD6kvi
 H5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751380886; x=1751985686;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Etx308N3I1KijyhBGAM+HBbz94lNBN0h4vUS6IObI1U=;
 b=BMg4V7iJbptjeD//9K/9jaxNBlOG045zps9z8e2fUwLYER7ZJ38Ev5aZcRfsula1EX
 fpcAqaBhdSYz7Aqm1RS2RMtyag9xHiAHXmhK757jYmPQFeI9vUe4UMDbnvIHZixEUj9/
 ACVZvVJMFZatnJwRbJB63PuC0rjuFWBfP0kFXjxLlVtm+7bgHd4mZSLv6kpfi6tkLv39
 LufVRVIpOg+iFmVO/kKI3yCvcEssyrixHU385DMzSMFnaqGbgZ+yTuqWZaWfYL0x6fyv
 rPVEbB4gAo3wnluJX11rHYK3SMIKMN8AxPmRLKE059OR9ogbBw0EBrbmuhqZmUNU2Ac3
 GmwA==
X-Gm-Message-State: AOJu0YwwKophO7TOGxRyLX4KJHajRQWDl6o8rnQsqJS+RfS+6GWp6unB
 qaYxMv9+wBRsb+g3L0sPbh/PiAk9CDBDGobGE7cxI9vWnzAjv81ejKhJa+YkB5EGMXdUig15gJO
 z1vFe
X-Gm-Gg: ASbGncsqQzx47uIz4w0jsMzaTwXZ+d8F+WWXJAmCp78e23fgxd1m15KZtvU0uB9EXC7
 h/sQLT1JVO/vLxwqGxnCIt839WdKQCiBDPq8ONOmsrBpd5yblX78ZHDw/1imcR+WJi96lFQQCgI
 /J89/97SWGUKd2vRVc4N5EfX0A8eA8aXNWE9ApGjGaRWwt7XHhScKEakMWAOJz2ck7wZRmjbadB
 bACkN7OHw0ea6VvbHGLmIyvLQdDeyGV0L3CvOQ7Awe4fmHLZLwx30ixr/W2zvtZ9G9r60XOKFb4
 SvIwTcI7SJr9Z52diXM+Mp1LTDwI3SZ26+9A158lyav6JzU2pt6x+c7Y/k7fg7frpTvdp9cxTXi
 sEt+5JMLsGzv0tmHstRr+2ObT+hokqW2qVnLrz0phWco9D30=
X-Google-Smtp-Source: AGHT+IEM9Ta0wApzTaYBFL+f7zVWjerX0IRuoepj+Pt1ShEMtLgTneA++jrgGaaConVIc5FII/qMpg==
X-Received: by 2002:a05:6000:2d08:b0:3a4:ec23:dba5 with SMTP id
 ffacd0b85a97d-3a8f435e55dmr11808340f8f.5.1751380885663; 
 Tue, 01 Jul 2025 07:41:25 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80b516sm13127569f8f.41.2025.07.01.07.41.24
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:41:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 12/68] accel/tcg: Prefer local AccelState over global
 current_accel()
Date: Tue,  1 Jul 2025 16:39:20 +0200
Message-ID: <20250701144017.43487-13-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tcg-all.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/accel/tcg/tcg-all.c b/accel/tcg/tcg-all.c
index d68fbb23773..c674d5bcf78 100644
--- a/accel/tcg/tcg-all.c
+++ b/accel/tcg/tcg-all.c
@@ -82,7 +82,7 @@ bool one_insn_per_tb;
 
 static int tcg_init_machine(AccelState *as, MachineState *ms)
 {
-    TCGState *s = TCG_STATE(current_accel());
+    TCGState *s = TCG_STATE(as);
     unsigned max_threads = 1;
 
 #ifndef CONFIG_USER_ONLY
-- 
2.49.0


