Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09BF0C3DA61
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 09:40:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYjLM-0003hK-4t; Tue, 30 Jul 2024 05:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLI-0003UO-SJ
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:28 -0400
Received: from mail-lj1-x235.google.com ([2a00:1450:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sYjLF-0000X1-K8
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 05:40:28 -0400
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-2ef2cce8be8so56889371fa.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 02:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722332424; x=1722937224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2hTb07T/lHUckLF9pRQZzZ733VhUGgQBsCLUx7kwgYc=;
 b=iqS8Xpws2CoA+TwvDX8+LigcHyYvEFkNraE3ZayKDHJT5r8Dklzx2cRQLfEr5vNjaq
 p02m8CBFrbyup1G5TDUiGZQs9Gtu+YE3OWB4j8y/Ywvc3jwMmRbEtWRQugQGKYf1HUpQ
 SrlBFUPYZfsMfN31dffih9Vey24CGoRLLS+ScrK6UTj9HpaDsWyO5O+2M5Wr/jDWxqWP
 UIgLCdwbuX5x/gopL/X2ZCYspnb1ScX9WSEmPaQHi90EJJDasEsM/7JxOJHrweM8gkqZ
 7jX1/CrHfehu295kL+PDBvgVCjpogQepTEu/t6XaMtEcCbSHnqfbHvbf1BrvfBafX/ba
 k/2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722332424; x=1722937224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2hTb07T/lHUckLF9pRQZzZ733VhUGgQBsCLUx7kwgYc=;
 b=uZyPmJTZUM3RHQP/wf7bl2i3ec8j1d2yEWQmFV/a5QIBzRl5fSZVACWAvCj+CLGEEW
 hsYvdIOGVVwhDFuNF6CA95td9M2SgN3M5WcXnFLmtXuISW5BYq1krwMqG2CwNGy5HzX2
 Z3W5aWoBokRul+nsF/2n1E0SskSoeei1utWP1opJrPKL7TbMPUJ/Nx3mvxGVyi0ED6jw
 qCxgYFqYpcm2c/OdCO5JWj9SXCVgHHun6vLZcN5WHdp0KsK28g02e04UWYeiDvqTLEOI
 vOAjGTV+GfXn8bZqPgllspIrr4sd1+EJ24sJEu5OfHo1oXrBQWsthqOtJfquceafnPdm
 cUdQ==
X-Gm-Message-State: AOJu0YyJBk4RLtdJQU8LNUzM30OobzmqGMKsOSXBIUXaGQgILMPvr6x8
 DH+4c1zmZpOMJ37xCmPWlm8wmEQZiZo7/GJwoZQ2T7eU8ez0PwGctz3AKDn8sn/7Ns7K5B1J04t
 S
X-Google-Smtp-Source: AGHT+IH0l9SaoMYKqRC50b7VqcyLkdhJssvyjTnNLoEqGCVEhpzPbh4mrdx1ZAXJj4P7g4PhTGH99g==
X-Received: by 2002:a2e:87d5:0:b0:2ef:1c0a:9b97 with SMTP id
 38308e7fff4ca-2f12ebcaea9mr74174751fa.3.1722332423812; 
 Tue, 30 Jul 2024 02:40:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b36862549sm14194974f8f.106.2024.07.30.02.40.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 02:40:23 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/21] hw/arm/smmuv3: Assert input to oas2bits() is valid
Date: Tue, 30 Jul 2024 10:40:01 +0100
Message-Id: <20240730094020.2758637-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240730094020.2758637-1-peter.maydell@linaro.org>
References: <20240730094020.2758637-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::235;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x235.google.com
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

From: Mostafa Saleh <smostafa@google.com>

Coverity has spotted a possible problem with the OAS handling
(CID 1558464), where the error return of oas2bits() -1 is not
checked, which can cause an overflow in oas value.

oas2bits() is only called with valid inputs, harden the function
to assert that.

Reported-By: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Mostafa Saleh <smostafa@google.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20240722103531.2377348-1-smostafa@google.com
Link: https://lore.kernel.org/qemu-devel/CAFEAcA-H=n-3mHC+eL6YjfL1m+x+b+Fk3mkgZbN74WNxifFVow@mail.gmail.com/
Signed-off-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/smmuv3-internal.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
index 0ebf2eebcff..b6b7399347f 100644
--- a/hw/arm/smmuv3-internal.h
+++ b/hw/arm/smmuv3-internal.h
@@ -599,7 +599,8 @@ static inline int oas2bits(int oas_field)
     case 5:
         return 48;
     }
-    return -1;
+
+    g_assert_not_reached();
 }
 
 /* CD fields */
-- 
2.34.1


