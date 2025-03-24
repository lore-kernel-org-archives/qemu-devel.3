Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1075C36005
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Mar 2025 10:23:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twewp-00030a-3b; Mon, 24 Mar 2025 06:22:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1twewU-0002lp-3q
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:22:06 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1twewM-00072y-7a
 for qemu-devel@nongnu.org; Mon, 24 Mar 2025 06:22:01 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-ac3fcf5ab0dso389520066b.3
 for <qemu-devel@nongnu.org>; Mon, 24 Mar 2025 03:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742811711; x=1743416511; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/w+IEuyBCGdAvV9kPBGIFRRowKLnLTxEQYA10TL7J4=;
 b=Y3VaRFpCRmAeIgJBOdTu1NSAG0IHMwWXzHylPUubmnNjQCV5ygyj5/3mD77QZoy2kE
 tk2Tis3kAqTBLYIIomaIJnEKVaxXb4khDYQJNKcJ9EAcWAfj7O7R3fD3skTbdKujzlnn
 YDTINS53jGL33iTRpXqt3voTtH8U8987VRfbglRuwYW3lMCyi140XZJ0DoVBjCE4G+n4
 cI1gDzlRNeR12UOuptoLIkPfS9bGZnyxxagA5boP7el9wasRUM50vbpCBbxbyc+vGfyd
 63ajVmJpQbRAYy60/6ze190MyY2W/HgIqvv8Zi53vSO/99QUwY325TewLmyM9mbXQ+VW
 ZQeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742811711; x=1743416511;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R/w+IEuyBCGdAvV9kPBGIFRRowKLnLTxEQYA10TL7J4=;
 b=FY88w5vov1g9f2oyOary9gSBpWPTbNN3+i9oxL4yWYUdfN/oiVL+17+5+ESCHg8JDL
 M6PCc2a/RuQZDjflbdvVhGQlALO5g5PeypHWwIZwgEtEsOvdohup81bhhnhGKAsQ3AF4
 LOeuL7NjRyrq9yPnsiti/cneKu5G8sFT+8lZFYBnGqKmH7b+L+/Zm5WJ8KSngKRJ8X+b
 gGY8KA8Pni8TmjO7peKtFkvS3ZUszu/9zQF5Hj7M1/OiLxox0WDtS2RHwP0YnJIC2LlF
 QKeVDsR/DpQaGno2dmOcjTiC9XoXr5oBMWCv0SZqqEAcodEkmgntYyWlHU+WJhbdSTQa
 eYnQ==
X-Gm-Message-State: AOJu0YxjCI9OfhJpne3lCoDNJwsQBo0Bm5XqTKcQGwfQN3fcfve1STnF
 P/5C1xttmTeFeujJ1MXlFkBO5OPYzNqArS39HIywArXiVu6wMGR6/NBEjpwygA8=
X-Gm-Gg: ASbGncu+YCGlxTwUd32S5wVITzlf6TwDI3BefPbXeq/Iql7rDbfY1onc+0rokGN7nVA
 dmn6qx3oUikSIBv+9t0zW9ESOwvI3IPDW38ZL0Q+2zBNSIrbh6WAX28UONDpN6MJ/XuSMzYvDXe
 7aCZY9br+7IJa7AygCUDq1WECfUsDaeblkfNaCGG/ykxFdrFNOvS+UGyvAV4RxQYQ1LOfAC1vyV
 mMs6QJkjzgXycqL+rCtfAuh9p6DFhTEvk/TH5TL31uwbkrtWJSx9dP7tt9wv0Ps71vpVcll/AFN
 8U9Q+7vugY3F97k7boNmTYy0wCoxr3COZ86UZiktJATDyzs=
X-Google-Smtp-Source: AGHT+IEniK14YB2uRUb1E6OC100FQO95BAmaJkBYJCb+Wq6fYMp5GJ0YIEzBU+rFNUDjVp0Abz4i6A==
X-Received: by 2002:a17:907:3f24:b0:ac3:3e40:e183 with SMTP id
 a640c23a62f3a-ac3f20d30e8mr1200077766b.3.1742811711010; 
 Mon, 24 Mar 2025 03:21:51 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac3ef8e5152sm646514266b.47.2025.03.24.03.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Mar 2025 03:21:50 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9CAA85FE0C;
 Mon, 24 Mar 2025 10:21:43 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-s390x@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 11/11] include/gdbstub: add note to helpers.h
Date: Mon, 24 Mar 2025 10:21:42 +0000
Message-Id: <20250324102142.67022-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250324102142.67022-1-alex.bennee@linaro.org>
References: <20250324102142.67022-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x630.google.com
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

We've not yet deprecated but we should steer users away from these
helpers if they want to be in a single/heterogeneous binary.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/gdbstub/helpers.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/gdbstub/helpers.h b/include/gdbstub/helpers.h
index 6f7cc48adc..9b3a535b03 100644
--- a/include/gdbstub/helpers.h
+++ b/include/gdbstub/helpers.h
@@ -2,7 +2,9 @@
  * gdbstub helpers
  *
  * These are all used by the various frontends and have to be host
- * aware to ensure things are store in target order.
+ * aware to ensure things are store in target order. Consider using
+ * the endian neutral registers.h if you want the architecture to be
+ * included in an eventual single QEMU binary.
  *
  * Copyright (c) 2022 Linaro Ltd
  *
-- 
2.39.5


