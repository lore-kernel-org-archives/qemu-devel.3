Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F57C282D0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 22:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpahW-0005no-Kx; Tue, 04 Mar 2025 17:25:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpah9-0005SU-Fn
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:25:07 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tpah4-0006YS-6w
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 17:24:56 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5dccaaca646so557632a12.0
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 14:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741127092; x=1741731892; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MkolzpnShYDHmq3nWMVi4zmNW1Y0ZYg4oZccy87L1KU=;
 b=fN3j1WnL1TSd8yIMA1LMV95aKVG2bFy6GmnixgqX2WV43lr/clke4u4pJVsto+w6AW
 nCaNoul5hgxBp64IezZ96Ako2LMd0h94VZlRDVwv7mnXE8hsJbC95wuUN3r7GFB01NMJ
 rd73PtowENjFFgsjeJXPMTdNgC7Qd7RDkt/BgyJOL3yDE4T1+sVeXRUrrVRg39Y50f02
 esn+ak540LYYGTxE7O76i+jr4R/4omDlPFBTnXMURQKhQbIjcsWW/zKqwtiteKp6gEuw
 FQF0AnmCu11p7ATABbcWia2jYtyQks/WEptq3N8gAB6d0y1ekk9rEgKKyKzpqoC0tmfO
 cPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741127092; x=1741731892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MkolzpnShYDHmq3nWMVi4zmNW1Y0ZYg4oZccy87L1KU=;
 b=K8ryCRGk8zASn4ficGqOsJlF7OZSxR7Gc9dTLY06jNML5irTHGJjZ5AtCU6x6yzYP6
 KnFYC17eD87ef1Nz5gHdv0RbrVzSUx/WhECLtoFcAa/2AFL5lbVUZXc6pUWFvtqMscyb
 MvfvcD48NwCvFFt5T9Ki2A1w1PRE2jPnegUWMvlJvKbgPQBpL5wWXNRPRiOznTOnAY7D
 72k80TLqgSBUtxudBBREwDYWXNqPv3rzqt6S3ts9DDIQlL/MDZYtjnPVgwRl3pES+OP9
 J4q8Gk5fdhwl1+BkWLBJDo5bDlFbIPVGry5e2POPpcqBb2kzHyXcl9d9rgqiqSw3Ybz1
 Ccqw==
X-Gm-Message-State: AOJu0YwUB9AQ/Pv2IcsbNI4PkUETPcKi1Kz0f8Dfi7rVwVOMWwwRbKQx
 kLZII29IT2iFMSHcAFN1r19PGuZ6JwqQE7eShc4WRu5QLMqeq4nhwndczjwv+oc=
X-Gm-Gg: ASbGnctmUNWVQmueYNMDIs6t0u0qFfqOu+9TU4AYadoY1VKe5n2l6vmLoWmLW4iSNTq
 97/Jo7PWVK6kvk1C19U9m1D9+TObqbtdrpQ2IzCyJQndOtp2aFQJd+/BqL4atEF62N5Rd4ETvwU
 YvQ8j1u1VTXPL9V8DHz8yZJfjLNjnGn2E/RHVMKt0GMsVHfsRhqAwD1NRy4Or38y3WB1W+RhgMl
 MhtEMCxCpEUZQOmgSJv9zeuMjy069S01+di5Mvcp/DKUzqknkyzu9ESAnyUV59AMO+w2HAD3knJ
 RCw09dtL8fuqkFIOhaXRoX8WNJRkzPGXelXSDaCCn3RMNQo=
X-Google-Smtp-Source: AGHT+IF/9WCqsEKfWI+MjX6NEYmSaTCwLfUdBHMLjWQKrji/x7t1ghsjUX78fb6fiiHce90OnIjuRA==
X-Received: by 2002:a05:6402:2554:b0:5d3:e99c:6bda with SMTP id
 4fb4d7f45d1cf-5e584f51e2bmr4948594a12.16.1741127092568; 
 Tue, 04 Mar 2025 14:24:52 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e4c3b6dac5sm8726271a12.19.2025.03.04.14.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Mar 2025 14:24:45 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id CFCA75FE3A;
 Tue,  4 Mar 2025 22:24:40 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Li-Wen Hsu <lwhsu@freebsd.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-arm@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Riku Voipio <riku.voipio@iki.fi>, Warner Losh <imp@bsdimp.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Kyle Evans <kevans@freebsd.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ed Maste <emaste@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 14/32] tests/tcg: add message to _Static_assert in test-avx
Date: Tue,  4 Mar 2025 22:24:21 +0000
Message-Id: <20250304222439.2035603-15-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250304222439.2035603-1-alex.bennee@linaro.org>
References: <20250304222439.2035603-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x534.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

In preparation for enabling clang and avoiding:

  error: '_Static_assert' with no message is a C2x extension [-Werror,-Wc2x-extensions]

let us just add the message to silence the warning.

Message-Id: <20250226140343.3907080-13-alex.bennee@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - /defined/expected/
  - let us
---
 tests/tcg/i386/test-avx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/tcg/i386/test-avx.c b/tests/tcg/i386/test-avx.c
index 230e6d84b8..80fe363cfc 100644
--- a/tests/tcg/i386/test-avx.c
+++ b/tests/tcg/i386/test-avx.c
@@ -244,7 +244,7 @@ v4di indexd = {0x00000002ffffffcdull, 0xfffffff500000010ull,
                0x0000003afffffff0ull, 0x000000000000000eull};
 
 v4di gather_mem[0x20];
-_Static_assert(sizeof(gather_mem) == 1024);
+_Static_assert(sizeof(gather_mem) == 1024, "gather_mem not expected size");
 
 void init_f16reg(v4di *r)
 {
-- 
2.39.5


