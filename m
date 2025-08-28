Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58279CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urauH-0003Yp-AI; Thu, 28 Aug 2025 07:35:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urauD-0003UL-UG
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:35:02 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urauB-0005pr-V0
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:35:01 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3ceb830dd58so66531f8f.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 04:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756380898; x=1756985698; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=aFlNi84zHV+DQWq3I7X+awnNfmQLP9zzDTB0j2InexA=;
 b=VftZQsTz8arM7vHrrrACvbYJgWh/JIt2KIsIlLsZYUsfRsXNfEbLmH6pS6mXmfc/TP
 Xgr/n5oj9H5U+oNtab+pAPaD9RTH+KynbEUoobYuMYekPog3yYJyQ7iIZxRvtycxL0tB
 yXEGVnO+Nm1OAAJ6njS4rrR3XqnhrNJrXLdssC8oP/oAgHsxnXOmIXaV1ppn5GPVvHGO
 OahwWirZquxHZD/CjnHTqKOQCjBOPs92mThlNSSkgr3p3k934K1tYzQrOzpPr6LLqeq5
 3VQJ8o/d89NlZGzNKJmOQDi/DUM0p7a460oueUr9zn53z0yFKxQW4SUhkjdDoPuOn/zt
 3zyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756380898; x=1756985698;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aFlNi84zHV+DQWq3I7X+awnNfmQLP9zzDTB0j2InexA=;
 b=trxaAwstsq7hq6N2tAwQeVnB/1EtMG+Nlk28ipIDHN4ZB/No+D/Mpa2CWPkM4XnHrv
 s09OC9+rIz7ReK2YJWboBio8pzVhywqzYOrSGmzfNuRtcFN25oMaKbqzxZ7Sqmof55a5
 s0chU+0rzFm1ijXlw7iFHZE4nrm+aUyRP+ekSMvEhPkVqaYXuTnUF/dLJqBvKiiFpAoY
 5cw9ctkDZ/VhX/crH3hoZ/IrR0hfQzysR2D6Pgidn4AdJX6C48nUYOEmyFJ8A4DIUHGZ
 qL3HzcRXHrEVvyETj14rkBqM1j0rX/k5qykGVAy/VxlvFZ888IUe+z2SsEPid4M7Z1xH
 zmfg==
X-Gm-Message-State: AOJu0Yz866gdU2hHUfY6FIeKMrzalCQiz5fWPA739ky454HaCU7TlP6s
 d1RkGyv5s6ToEg6EfU1VoYaxL8b9KPG87BxhtnNaciLhR4wZOYgmPnepCXFNApWCcGRNGQJ6cES
 muAoU
X-Gm-Gg: ASbGnctbX2M7SbQxBlPJ9DtO2bsq4KsvyYfOPsm1NZ2tNe/lGRBRd6jSDHusq4mleWg
 A9fhtc63LQ5nTDSH7rRX4p4BXEX4228ytBdalFvAYk7ItxHvj2SLvG8KhV/5MF2V2LOip6ciYh3
 yZb0Bm+vO9bax6ysMkJqqyHKWFGcGyb6fMgPd/QAGbXj4IXDtGcZyWB9TpbO2ytHVOk1XKTKrP2
 zuKELt2bN81zK3tzFLrdUXKKsLnOWlEAEHoqK54vZ/fbhnZ7WODI61ZgVzX/f4Yl1/VMgpkPvVm
 5FjZz0gZKvXYQFJC/PAyI2YnjRPDUs5WaxNElqWy2vDis3Ikm+EUXw+nTetihz5DyI23ZCjwXFv
 O7Ea8/ZFGk5gu1zYsC8srnCaIGrbxieiSWDCSysY=
X-Google-Smtp-Source: AGHT+IEfmyEPNcbFz4decERQggBDX/a08LH19W9Gp5h0QPxhqPxrZUdQZc/myLWPbE7i8nB79UuUVg==
X-Received: by 2002:a05:6000:26cc:b0:3c9:83f3:bdb7 with SMTP id
 ffacd0b85a97d-3cbb15c9df6mr7802537f8f.30.1756380898230; 
 Thu, 28 Aug 2025 04:34:58 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b79799c33sm28691015e9.5.2025.08.28.04.34.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 04:34:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/32] MAINTAINERS: Put kernel-doc under the "docs build
 machinery" section
Date: Thu, 28 Aug 2025 12:34:20 +0100
Message-ID: <20250828113430.3214314-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828113430.3214314-1-peter.maydell@linaro.org>
References: <20250828113430.3214314-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x431.google.com
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

We never had a MAINTAINERS entry for the old kernel-doc script; add
the files for the new Python kernel-doc under "Sphinx documentation
configuration and build machinery", as the most appropriate
subsection.

Mauro has kindly volunteered to help with maintenance/review
of this area of the codebase, so add him as a maintainer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Message-id: 20250814171324.1614516-9-peter.maydell@linaro.org
---
 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f074e43712..8147fff3523 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4441,6 +4441,7 @@ F: po/*.po
 Sphinx documentation configuration and build machinery
 M: John Snow <jsnow@redhat.com>
 M: Peter Maydell <peter.maydell@linaro.org>
+M: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
 S: Maintained
 F: docs/conf.py
 F: docs/*/conf.py
@@ -4449,6 +4450,8 @@ F: docs/sphinx/
 F: docs/_templates/
 F: docs/devel/docs.rst
 F: docs/devel/qapi-domain.rst
+F: scripts/kernel-doc
+F: scripts/lib/kdoc/
 
 Rust build system integration
 M: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
-- 
2.43.0


