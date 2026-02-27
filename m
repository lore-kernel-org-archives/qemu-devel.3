Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC78FEFB56
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Feb 2026 15:19:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvzbe-0000MQ-2I; Fri, 27 Feb 2026 10:18:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvzbZ-0000LS-Kj
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 10:18:13 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1vvzbX-0005kb-JA
 for qemu-devel@nongnu.org; Fri, 27 Feb 2026 10:18:13 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-65b9d8d6b7dso3497776a12.2
 for <qemu-devel@nongnu.org>; Fri, 27 Feb 2026 07:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772205490; x=1772810290; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qx6UauuEAtchW4d5VzAu9wKS8rEStNphyewNUDu7aIg=;
 b=zFzbTv3bNGG9RvWXyioqmJxicwuyRfUEM94DuQx/ISfQBgUnk1PmqFc4MpBaISAJ+B
 pMdyo7HsOUTWDC70/S73SRyt9E2gvjOD28jHJc5l6WEgTY8f5wl/b3/lo51b+1nMu2lv
 8CADPFVAaqUBRDBWl+K/rTCbv8hz/J3ASsaPyFNwZaZzqepBnPpt+V22+0hG3J0Q+ZLD
 v3xmw0LIh7qhRQ1J7anvPdMEvhixY26JjTw2GYYLfGxwHm5FNwKnjLqGYABGa7rV6JlV
 Nha6sKo8nssuxQioakQIdDRxfVP4dIitYoHrCRayjRc2r2qfO/2+sQSUmP+FKh1dtaXC
 P4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772205490; x=1772810290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Qx6UauuEAtchW4d5VzAu9wKS8rEStNphyewNUDu7aIg=;
 b=ntmX6eQ51OeIrSGrr0MvAY30/3mLAQpLwH2JIvW3DZpdf8Dx1BgprmbImn+NByXLUr
 0+glUjgYjpsqJKSqux54QMH/0LDqAzJ0b0pnJP08vhpsZ4rC/1Dpv0DqBwN166VbHsnH
 lK49uIYs6RlWMJIqwUFhUagSuB0DqOhcq/NGDGry6Pxcdt/Z7Xnd5o+KNTGz64J6A0Qu
 GyQ87nKKXDZvQUBwl6fWJolOtzkjCbByduUlTdNWn/GNlegVTBKO//rflU00BuEbEcdM
 DEGVSSTRAShIj0RFjlEUZ94UYYvSK/VxnA+7Qy/9SFedmPpsnlMB9XDdRzV1pQQFmuyp
 B4bA==
X-Gm-Message-State: AOJu0YwCTxd9U4OlVUH76jJnfCkKWgbcwTZYHOJoRrgxZA1wp5WW1w4Y
 fo6AR6rt3grrktVrPIymRsy4mlyXNGKZRuGZBAC/4PkQEsa2tpKPAUayPiW6cB/LMBc=
X-Gm-Gg: ATEYQzwNfCGGVaEUFzr2lWXAQ3QCtkmjDnJW7RUYtyiyqvzQ6coIZM2feIXQeu4PrTf
 L2+FnEgKH2szLUQiKM3I9AcgR6cHfRnUxLsiZl2y09AbPpkG4j2P5rL+ALGRIIh7tMxE8bGig2J
 oIm0i5l2v1jDFRvCN2kdhJr/JdA2B7MWC8qY0d1K7c6qQg4dQBBwZwVwV6lprj6ZJYon8qEvWcB
 z/Jwd6izWPTN31vgkibDyOjp/qAcTMSEQS/KZYJtbM6dQv6lOJd5+Spyaehm7aAkC86l15xuMSV
 SIwSaRowajYtr6bgZUK62WYCVPJ65076YPRBfUS2yW6Jj5r16FA22NL3La0mzQfbelDIyGDlEsk
 swdeil57fGCb3YH7wNCEjPeGg3aiCMi8fLy3xWfYJrV7KNyvElPbDpia0GrkeozI+mKsX8PoXSQ
 jLXF4/kvyNBxpY1ywunXBa3lM=
X-Received: by 2002:a05:6402:5245:b0:65a:382e:7254 with SMTP id
 4fb4d7f45d1cf-65fdd6e2174mr2314065a12.13.1772205490026; 
 Fri, 27 Feb 2026 07:18:10 -0800 (PST)
Received: from draig.lan ([185.124.0.126]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-65fabd36367sm1400697a12.5.2026.02.27.07.18.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Feb 2026 07:18:08 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8381A5F905;
 Fri, 27 Feb 2026 15:18:05 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 4/7] tests/vm: remove unused import
Date: Fri, 27 Feb 2026 15:18:01 +0000
Message-ID: <20260227151805.2335641-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260227151805.2335641-1-alex.bennee@linaro.org>
References: <20260227151805.2335641-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x52a.google.com
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
Message-ID: <20260226185303.1920021-5-alex.bennee@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

diff --git a/tests/vm/openbsd b/tests/vm/openbsd
index d1289d78d24..9aabfeec963 100755
--- a/tests/vm/openbsd
+++ b/tests/vm/openbsd
@@ -14,7 +14,6 @@
 
 import os
 import sys
-import socket
 import subprocess
 import basevm
 
-- 
2.47.3


