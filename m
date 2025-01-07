Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B517CE77198
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:08:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV4XN-0000RJ-Oa; Tue, 07 Jan 2025 03:02:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wt-0000F1-5D
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:36 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tV4Wq-0002vJ-9X
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:01:34 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-21675fd60feso25205305ad.2
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2025 00:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736236891; x=1736841691; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pQva3q+MWFJ9pcoUzbmbXwAhlkVRuQCmcAHZ1Ju2AJA=;
 b=OW0xabjX8sjeKQdWKQrzZt4/YpTaQuAVJaa78fKEIIKVTmYZwnSOJvbheStjiQ0KLz
 q4CBsH0/NwZQ+5biZHnwfw/iSKDOPEWo/v1nuZ0P99eoXd5D0XsNB8WGUcczaen7DIAq
 Zlur8/5KnfV7iwoYlx6lWg9V/4T8rHtCzWaXHm5L1m4eBlx5YdreDH1b9hTXOvWtIwu2
 f3U+pKoWuoYRWSZqz0/LuZ3bAQmqG4JCy7kgwjpi/AXFp85kOK6SvpuQeP7GqlsEYeO2
 uam+JC43aF1Y0Or4uDa30AxGN8Geo0FqYHyPCZ/moAZEvN+v/Yq8XKPs8DDuyAi8zlZw
 rnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736236891; x=1736841691;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pQva3q+MWFJ9pcoUzbmbXwAhlkVRuQCmcAHZ1Ju2AJA=;
 b=ACKZqoCVP1Q/8OJEG7RxQNR+AijKYmg6MBQIevvK56GFXmcCf6oqc2vnDZ9zPMTK+h
 voqRv/NjpX/fobslowF7oawXf8YY3tAGC55Kre8Zxz3StT/bUCL8qMJd1G9lpNvojKkS
 ntviIdmZns92ZE3OQ+rIrAo51ffo8svJlXiu3KeJgWXre7562D2ebZtbYnf0lBo31ELN
 bgQ6hsgrfQ7m0RduORzDma1H0OAoKKpluLEW+vXG6yCzBtNpgQQMtlFiZcGH2gt7HTO5
 Jf3nmwD58W6Fa6dF89SvSN2kHMFcU6vlTIx+ShZEE4k22GosEGw7GxV46kxM8AQfPpbT
 gMxg==
X-Gm-Message-State: AOJu0Yxw6MZ/bXBfEeiIJ+mNHDe729uOmujZQEfKq9pwxegJDp54oe22
 OR6Za7wk7ANuU6pHwooJk+fgwg4y3aNCgbhUAn6h/JZqlhuaJao60JYln48N96LLyYDGHHRhBD0
 +
X-Gm-Gg: ASbGncuDZbv1/QNZxFV5qXRr0YrhtXFyvyzg1YhtzWCa/gC9+Og91GvKmDapPlBCefs
 RbxO3WUhP8v4y9uIFv5HsdOLnM3uNxU+G9gLEpXysfExgAHxMeQRExtriFuAmgHmWW7wykq6zDh
 uPbrj7o8dZKqWK+l+sVXu2XYtQ+4BFUbRHDdkp/EHjQ3h+bHwv0IyOW32/Vn/80UCPOfaft/X83
 pr88GCaHGHvkZBMNPoDJcCPIdUpFpOEtNTSTHwRiHSNp0fbZwmBj6THTbyPEYd4nQPrK3TPTMkU
 +WweAX4qQuusWlDStA==
X-Google-Smtp-Source: AGHT+IHeQO42bX4DoL5+yaA8515ImXQfjACxFRvEXtE0AKOHbWeyPusH9PTEky1R9ZsgUtM+4W2TKw==
X-Received: by 2002:a17:902:ebcb:b0:216:59ed:1a9c with SMTP id
 d9443c01a7336-219e6f317c7mr817096595ad.55.1736236891088; 
 Tue, 07 Jan 2025 00:01:31 -0800 (PST)
Received: from stoup.. (76-14-228-138.or.wavecable.com. [76.14.228.138])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-219dc96eb12sm306765995ad.87.2025.01.07.00.01.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jan 2025 00:01:30 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org,
	pierrick.bouvier@linaro.org
Subject: [PATCH v2 16/81] tcg/tci: Move TCI specific opcodes to
 tcg-target-opc.h.inc
Date: Tue,  7 Jan 2025 00:00:07 -0800
Message-ID: <20250107080112.1175095-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250107080112.1175095-1-richard.henderson@linaro.org>
References: <20250107080112.1175095-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Now that tcg-target-opc.h.inc is unconditional,
we can move these out of the generic header.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg-opc.h        | 6 ------
 tcg/tci/tcg-target-opc.h.inc | 5 ++++-
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/tcg/tcg-opc.h b/include/tcg/tcg-opc.h
index 93622f3f6b..14aff6e7f9 100644
--- a/include/tcg/tcg-opc.h
+++ b/include/tcg/tcg-opc.h
@@ -303,12 +303,6 @@ DEF(last_generic, 0, 0, 0, TCG_OPF_NOT_PRESENT)
 
 #include "tcg-target-opc.h.inc"
 
-#ifdef TCG_TARGET_INTERPRETER
-/* These opcodes are only for use between the tci generator and interpreter. */
-DEF(tci_movi, 1, 0, 1, TCG_OPF_NOT_PRESENT)
-DEF(tci_movl, 1, 0, 1, TCG_OPF_NOT_PRESENT)
-#endif
-
 #undef DATA64_ARGS
 #undef IMPL
 #undef IMPL64
diff --git a/tcg/tci/tcg-target-opc.h.inc b/tcg/tci/tcg-target-opc.h.inc
index 84e777bfe5..ecc8c4e55e 100644
--- a/tcg/tci/tcg-target-opc.h.inc
+++ b/tcg/tci/tcg-target-opc.h.inc
@@ -1 +1,4 @@
-/* No target specific opcodes. */
+/* SPDX-License-Identifier: MIT */
+/* These opcodes for use between the tci generator and interpreter. */
+DEF(tci_movi, 1, 0, 1, TCG_OPF_NOT_PRESENT)
+DEF(tci_movl, 1, 0, 1, TCG_OPF_NOT_PRESENT)
-- 
2.43.0


