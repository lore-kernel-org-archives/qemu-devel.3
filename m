Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F311C02185
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 11:39:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXfFc-00054i-IL; Tue, 14 Jan 2025 06:38:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFa-00053s-Rp
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:26 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tXfFZ-0005Od-Ay
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 06:38:26 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-aaf6b1a5f2bso155134166b.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 03:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736854703; x=1737459503; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=swWbfqbBQuWTwxy/6Yz7+TAY9SVPbs3mxyJnC781jXo=;
 b=TNEHmavfEMqqSLUYe6Hr/S1/kFHIHAc1rwruZ9rKrZcgarSkMmoNRzr6NRLsldAw3u
 hs7aEe/HnBAEoTcAtzmv2ooYZxHZ0Do+/1Lw87ZGB7FWXl5sGhSR2BDM1gpwE933sIb8
 iKzdVW+gQrIYMLOzFcqYaN0wJHJRCaVdc6JR3G8JliQvYK0TSg9OJdRO1614YQ875yaa
 +1nW+6IyMbVpZpjj+GWYSskkxzqJFFLJlcY8MRK9bcz5dJmA66Trzbs2vVC9mzjryQ0w
 ytILp2BQtXC3O9tM1oXnP5nCijywt9GTjdJKqauyS3cawtt/fqSOOKZKER6sM4aeO6cp
 iU+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736854703; x=1737459503;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=swWbfqbBQuWTwxy/6Yz7+TAY9SVPbs3mxyJnC781jXo=;
 b=gOjPaTlhpkahw/irk9UF+dLw0S3bb1O19hqda8Ys07j34pUiZHGuleYpzJtAaDhWnW
 2mJPAVGDebeLdum6QpUn3XSUmy07MPjYO4ZtyLZWeHL0vzovMFjHEt+WTvxrrt2GUVvM
 6MofUiNmgRrPoozV5LmMVjZTPxpV9s/agS+VVW/xFLU0wItj0Jn/AULP1nwJjR53/JY4
 lturSQPopphJzW3qxJ6y+pCyozzU9fNwY5wDlwla/dleCVRRpOQ+pGJyFFxC4ZOI2cDn
 asRGAkxjunChiTK8f8QhbWVzlsI0GXr6oJmh3Fdqs8H8alHmpZTgcK60FEzUpxLbYKEs
 S7Kw==
X-Gm-Message-State: AOJu0Yx68OrdmB952xGdqb77iLXJge+lEhIC9sBQ+EMGybdbE5OIgUtB
 9PciQ5xxk6rMHfqm/DyPI5Lk7umtnf/fuGkTVVTJwiGIWbjvj4Y0LyLror9Qy5Q=
X-Gm-Gg: ASbGncvej+LmF9mbEMCmZE3CNDF6ZI/pxnUcWs9w9A3qxfQ2nA952R4gwpsOzs9MQpy
 KVaJCWrQaGxCMYaBqnUoY8nFeagy9fCQBh9kcGMOgYTR2wrrvcPm3Lnf5gHOhq84PUltQhS5O34
 KTMpTwEHwmUWjiVDcLitO4BW51QpQhv8jH0JnpvhUXEDFzt6uwRQTEiu03KvJ9mah1jx4j0vLWR
 iCwJcOJaOh7baxWLHOE1VbK6NJxgl8CLbtGJujehutKoeO502HUAYs=
X-Google-Smtp-Source: AGHT+IF654gxsZBx/NjacLL0k1wtqmTyt7g3pPocG6DwycMN/lQ4y6g/2NyaLYU64s2G+0cPocpNig==
X-Received: by 2002:a17:906:c14f:b0:aaf:1f6:7423 with SMTP id
 a640c23a62f3a-ab2c3cb6e2dmr1669429266b.18.1736854703475; 
 Tue, 14 Jan 2025 03:38:23 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c913605csm615049866b.82.2025.01.14.03.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 03:38:22 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 122525F932;
 Tue, 14 Jan 2025 11:38:22 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefan Weil <sw@weilnetz.de>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 03/37] semihosting/syscalls: Include missing
 'exec/cpu-defs.h' header
Date: Tue, 14 Jan 2025 11:37:47 +0000
Message-Id: <20250114113821.768750-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250114113821.768750-1-alex.bennee@linaro.org>
References: <20250114113821.768750-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

target_ulong is defined in each target "cpu-param.h",
itself included by "exec/cpu-defs.h".
Include the latter in order to avoid when refactoring:

  include/semihosting/syscalls.h:26:24: error: unknown type name 'target_ulong'
     26 |                        target_ulong fname, target_ulong fname_len,
        |                        ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250103171037.11265-2-philmd@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/semihosting/syscalls.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/semihosting/syscalls.h b/include/semihosting/syscalls.h
index b5937c619a..6627c45fb2 100644
--- a/include/semihosting/syscalls.h
+++ b/include/semihosting/syscalls.h
@@ -9,6 +9,7 @@
 #ifndef SEMIHOSTING_SYSCALLS_H
 #define SEMIHOSTING_SYSCALLS_H
 
+#include "exec/cpu-defs.h"
 #include "gdbstub/syscalls.h"
 
 /*
-- 
2.39.5


