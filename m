Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E85FC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 21:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr27C-0003OX-AQ; Sat, 08 Mar 2025 16:53:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr270-0003Ha-W9
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:39 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tr26z-0000wJ-Cr
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 16:53:38 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cebe06e9eso2661455e9.3
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 13:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741470816; x=1742075616; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KC+aAUPu9a4BdYI7vGXvf2NZEQGI2J1QgDqj2UoWXTA=;
 b=TxpDV40Ih5wbYmOHSKZAYhToU+WCHgMELBjf46krSODamIeaCHAfdTOy2z+9b32sWm
 uVxuZnfH6ZmZe+MKIUpEB789HwT1RM3uL/y4p1DJxs3Y0owsCQFu0bSeixfzKMESwow2
 txTmnKyAbSFcDDd/lpMAeo7a/B8+xL14t/UKUFSQJYwEd54ZMaWmmcFmKdB8z1ATO2fM
 ijwlEVpwAUsRc6H29/3W6d3PCpgM3odKlqBreB7folf2ePq9qRJqBqekE95poZvKfT1r
 MMex4M4rDbByoYzl2KQKIbCqFxgBsEAHCdeGBVhz5vQgxFOHiewC2h9v1i4u7jOrz37v
 g5OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741470816; x=1742075616;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KC+aAUPu9a4BdYI7vGXvf2NZEQGI2J1QgDqj2UoWXTA=;
 b=NHrQg6V0X2eCziRvmvyHOWhzcJ6sQ9spcn8m8c8UkDqFeo6AJiHTTszerYQ9DAuZ1j
 +uSeUaWw5XpGsN/1rHkDozR0kkX2Lby3AmohCQpD9PVlj5YxjC+9wxTVLxaOSATOEkLp
 /0kbBdn2BJbi9/qWIAh/uCZB96yqDppQG69i+ITDZ8be+5Fn1fuphDkgVZio6DmU/ZYs
 oyChTVutvN+wmDYplZ7k6FNqhpM0dPOdmuy1B0h/KPMPmc+KiK8kTBU0UkvFlTL1SeKD
 JFUJ5OVQNUyRP0BvLmFTiJ3jeCMkXMwMjjxDymke+YVUkbc6QNWoFJEZkcBKjp2MU3X5
 UVfA==
X-Gm-Message-State: AOJu0YxpsdPbZgp09/CoS+fF+RgjOqgj0zHR4YcI5ZPFxpRnoQcf2KUd
 czFwMAQXSiBOffHBjMSdBTsRycP6og/Uoubmhf+PiP4sDa6nMyc7vyw+bCxfoFg=
X-Gm-Gg: ASbGncvvLE0QprekxBsI/ddCFPK0KX+zPzkKUvbWsaoTk55aRMIQeVn56DvUpFQXIjJ
 SVP70To0owv+7ROFfJk4h3kfmUUGMJXkpEq6+bW47Q/67omx1Grg0MpcgPzhMVAhdTGZo9rCmSV
 NlMG0QZxCcBx2884T4lIVG33O+CplR8bf29YJpMpakpZvjMiPQ2ksfDUKoFPknCByr1T+Vc23xi
 ptLgWEy3f34ZsYrjGNUb90E0ZOEGHWKsN/g0m21SaIbp7lsxDK9IWDCpbqpjIgo/cNYPTWYrksc
 BFICPB/BdW/TMTdI5/JqBvH64dvHkYWdEzSr/mOKjirh1YY=
X-Google-Smtp-Source: AGHT+IGRKLvxAZwc9J3YJpjIH3DiI/aPhD5ZC+tqNruyN6NXORVQ++DmxiYEBuIjXcKc1xl+nVrYlA==
X-Received: by 2002:a05:600c:4999:b0:43b:cb0c:3542 with SMTP id
 5b1f17b1804b1-43c6b80c724mr52489925e9.15.1741470815940; 
 Sat, 08 Mar 2025 13:53:35 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd8c314asm96314315e9.10.2025.03.08.13.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Mar 2025 13:53:34 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 1E0ED60533;
 Sat,  8 Mar 2025 21:53:28 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 16/31] tests/tcg: enable -fwrapv for test-i386-bmi
Date: Sat,  8 Mar 2025 21:53:11 +0000
Message-Id: <20250308215326.2907828-17-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250308215326.2907828-1-alex.bennee@linaro.org>
References: <20250308215326.2907828-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
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

We allow things like:

  tests/tcg/i386/test-i386-bmi2.c:124:35: warning: shifting a negative signed value is undefined [-Wshift-negative-value]
      assert(result == (mask & ~(-1 << 30)));

in the main code, so allow it for the test.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20250304222439.2035603-17-alex.bennee@linaro.org>

diff --git a/tests/tcg/i386/Makefile.target b/tests/tcg/i386/Makefile.target
index bbe2c44b2a..f1df40411b 100644
--- a/tests/tcg/i386/Makefile.target
+++ b/tests/tcg/i386/Makefile.target
@@ -22,7 +22,7 @@ run-test-i386-sse-exceptions: QEMU_OPTS += -cpu max
 test-i386-pcmpistri: CFLAGS += -msse4.2
 run-test-i386-pcmpistri: QEMU_OPTS += -cpu max
 
-test-i386-bmi2: CFLAGS=-O2
+test-i386-bmi2: CFLAGS=-O2 -fwrapv
 run-test-i386-bmi2: QEMU_OPTS += -cpu max
 
 test-i386-adcox: CFLAGS=-O2
-- 
2.39.5


