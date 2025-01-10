Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5428E7719E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 20:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWLhz-0000WE-S4; Fri, 10 Jan 2025 15:34:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tWLhw-0000VK-Tv
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 15:34:16 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tWLhv-0005f2-4Z
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 15:34:16 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2165cb60719so44203015ad.0
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 12:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736541253; x=1737146053; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g9R9dQpF5UbzJZ6Kb11hyvYzYtKnLXxRBjcuMGn4NXM=;
 b=VtIpE3p59kQ0rOFVvsvhaAI+1nZgwi+N18g5A94+9znPjDvH9aWuheNf3HW896hPFJ
 FjAOibPt0pYM3F8aTPp/NJqg/oShxQs+kUeSFStQS/CYtCEAgZBSWKCICA/HtTURvaCR
 6GGR3bKZp46zX/60Mw0GYsbTg+RJYfG6/C9S7XjcpHzOdZguJzKVCNV0KG3Lji5oL0+Z
 G9qNQIJ8iu/9n7NOVZGs864I2EbQHx07utJydSJvORos2dtnFz3odLzbcovAEV5lOZcg
 ZBiEtROVJwIX1LOFy4QDzeSAmNQSc0kWuGEHMu052IaGa2/Z0zzdYDamVwVW8VFqumcs
 ipiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736541253; x=1737146053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g9R9dQpF5UbzJZ6Kb11hyvYzYtKnLXxRBjcuMGn4NXM=;
 b=X20JFfmV5aWRlwpLwHZAbhEf15tpts1uWQACgjnv9D90H4M4bzaDeuB4TZpWloWDHA
 6tO1EyxNmLVC+ud0KXPIoOQ2rTRe5ixMUH/vckyFTqsb5BCTDTI9OMIrXAR1AMTiBjJK
 7ROFQ7N5deTFEbbjE9Hvd/hiDLxWMh/MmsISdyVfUwO69XV8Cba39LJHghrOQvTmUxxK
 pjepPhkhG7a/QDx1FQIwhaCi2fdWDH+jHXn5G3ptgyWl0ermTyVCbkETIf/nTGGCUsCf
 jj5k0sLOnAfwoFWfHSnkgKN1irFuyBvzunpywAkc3rt9EZYLJYDfCBGXw7lilBfWXgX+
 FgMA==
X-Gm-Message-State: AOJu0Yw/1OzLZw1ks9rFCmMUdbQmUgaf0n9xCsiMDi169wWC6hVTlklE
 K1UVlFHORw6gEeRIWVoHhxnTbiC2vjN5IkR7w3NqmkpD1ZP91t2wDvTOjk20K8o4WvkSVhWdyx1
 ujwVCgA==
X-Gm-Gg: ASbGncs0q0UM1DisrQSLMpnk6/IYSmS7zyiDsUxl4ecp9TiiIyJZ0JBs+u1K0Cfqr3V
 jli9Kgl6siQb1w5c8r4ArGFZa6Q6Ec+7dJ44kmhkkO2CVejMhwSoSHil62vFQ7WVQbPZrMaOOH7
 l6Jtsq6N2g8EXJ9qJeDZhbfRBgHuBWb0tFU1Dx+ItyoOzs/j1Ua3q0SFuM1WYfnz+hTaTikBnhZ
 mGv/Fo3g4VM92v1hNlwQYfGdtuqLveV6B8Ncl/+YTJss+4qgaD1eWvQ
X-Google-Smtp-Source: AGHT+IH6wCuxtcT3FFj/3mFPlad27XCOZu4H48N7u/eV/WeqlO2/S9/Amz7cwBFmCK9dVz+afnoNIg==
X-Received: by 2002:aa7:88cd:0:b0:725:f097:ed21 with SMTP id
 d2e1a72fcca58-72d21f471d6mr17088257b3a.15.1736541253266; 
 Fri, 10 Jan 2025 12:34:13 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-a318e8ecacfsm3215947a12.38.2025.01.10.12.34.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 12:34:12 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 2/3] docs/devel/style: add a section about bitfield,
 and disallow them for packed structures
Date: Fri, 10 Jan 2025 12:34:00 -0800
Message-Id: <20250110203401.178532-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110203401.178532-1-pierrick.bouvier@linaro.org>
References: <20250110203401.178532-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 docs/devel/style.rst | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/docs/devel/style.rst b/docs/devel/style.rst
index 2f68b500798..d025933808e 100644
--- a/docs/devel/style.rst
+++ b/docs/devel/style.rst
@@ -416,6 +416,26 @@ definitions instead of typedefs in headers and function prototypes; this
 avoids problems with duplicated typedefs and reduces the need to include
 headers from other headers.
 
+Bitfields
+---------
+
+C bitfields can be a cause of non-portability issues, especially under windows
+where `MSVC has a different way to lay them out than GCC
+<https://gcc.gnu.org/onlinedocs/gcc/x86-Type-Attributes.html>`_, or where
+endianness matters.
+
+For this reason, we disallow usage of bitfields in packed structures and in any
+structures which are supposed to exactly match a specific layout in guest
+memory. Some existing code may use it, and we carefully ensured the layout was
+the one expected.
+
+We also suggest avoiding bitfields even in structures where the exact
+layout does not matter, unless you can show that they provide a significant
+usability benefit.
+
+We encourage the usage of ``include/hw/registerfields.h`` as a safe replacement
+for bitfields.
+
 Reserved namespaces in C and POSIX
 ----------------------------------
 
-- 
2.39.5


