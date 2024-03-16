Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDA11C54E67
	for <qemu-devel@archiver.kernel.org>; Sat, 16 Mar 2024 01:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rlJJR-00032q-PI; Fri, 15 Mar 2024 21:58:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJJL-00030B-UZ
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:58:12 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rlJJJ-0000pN-WD
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 21:58:11 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1def89f0cfdso6711005ad.0
 for <qemu-devel@nongnu.org>; Fri, 15 Mar 2024 18:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710554289; x=1711159089; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=P54sXZhacQ5iITFNcA4P+H/BERfNZULzKjLOWe/9z8w=;
 b=RCce+MbghlQfnsVYXuGL3nKKrJKYMvSa728dbFR4Maq/W4NYQ2qpuXt4HqN2+9bzSt
 64id1jF3wBOvVFjvvCqq5KE28vsNE7YiRV5rMLQDLE+sFnakirO4RHg7GDrrhIcDz4uf
 o4+2wc5dI/Ob89EajtoivkGB6dBKpz3rMKglThbbhe8rbnxJ58nT/aNJRgdvyCy/73fS
 PrwAO7llhrBs/CwNugW/5OY9b+9EsrW0xerXYUJNmgghSD4x3sXPsXCPEC+D+xcLIuZw
 /LCdtjdJuxNoTsYdEDm3R74Z5X0kLJK0XJs0seAn8bPB9aMRJpqh4BWkGP3cMG94T16A
 RmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710554289; x=1711159089;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=P54sXZhacQ5iITFNcA4P+H/BERfNZULzKjLOWe/9z8w=;
 b=VBp76OrTpVOlN9WBxT/DyBE+iEfKpa8+LaMMLxV3zgEe69XhypE0ZYYvD+DL1Afffe
 +yGobCpwDmDF8fTyJtzQ9gXyKmzzo2uiP7A3okTPIQBeU/xLua7aDNDCbgpglGHucYWJ
 Y/7fSRI/9HYNTvgajYwSEoOxaAIFL5DYTO7pp7dO5MTI+1KzwnrksYktdriwBQTkOjbe
 VXaiLWw79o+DHRMr5i0v1DfYJXvIrDt+jjhIiUix/DyzulZT0F8d9SrkhJiONij8d53b
 gEFi+Qz5kIZbXYHx6Z4Hw2RoYpgwIPqjGPO2RyuQWeKRrN1N3Q6igcaH8yJ/seQNS16s
 Aeww==
X-Gm-Message-State: AOJu0YzaaBsXse/82EVklP/zG8ppeEm5E4DPt1mXep/eEZhwuswcOABu
 FM7FFRUAuc/pzVwZurknqZSeHrBykMpV+66XWuuV0jEA7enDPzALdEi49ETUrTd10Kg2yjWIo8M
 y
X-Google-Smtp-Source: AGHT+IFm6GJ3YABFaWUrd6IeXAo/KIyVFO1kj9TgM8c+J0ziEmHYj8+AS/E5mFfwiUtVK2ze9YbxsQ==
X-Received: by 2002:a17:902:f68b:b0:1db:cf64:7331 with SMTP id
 l11-20020a170902f68b00b001dbcf647331mr14824464plg.13.1710554288764; 
 Fri, 15 Mar 2024 18:58:08 -0700 (PDT)
Received: from stoup.. (173-197-098-125.biz.spectrum.com. [173.197.98.125])
 by smtp.gmail.com with ESMTPSA id
 b3-20020a170903228300b001dd42bbb08asm4592985plh.253.2024.03.15.18.58.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 18:58:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org,
	alex.bennee@linaro.org
Subject: [PATCH 22/22] plugins: Update the documentation block for plugin-gen.c
Date: Fri, 15 Mar 2024 15:57:20 -1000
Message-Id: <20240316015720.3661236-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240316015720.3661236-1-richard.henderson@linaro.org>
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/plugin-gen.c | 31 ++++---------------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index fd52ea3987..c354825779 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -14,33 +14,10 @@
  * Injecting the desired instrumentation could be done with a second
  * translation pass that combined the instrumentation requests, but that
  * would be ugly and inefficient since we would decode the guest code twice.
- * Instead, during TB translation we add "empty" instrumentation calls for all
- * possible instrumentation events, and then once we collect the instrumentation
- * requests from plugins, we either "fill in" those empty events or remove them
- * if they have no requests.
- *
- * When "filling in" an event we first copy the empty callback's TCG ops. This
- * might seem unnecessary, but it is done to support an arbitrary number
- * of callbacks per event. Take for example a regular instruction callback.
- * We first generate a callback to an empty helper function. Then, if two
- * plugins register one callback each for this instruction, we make two copies
- * of the TCG ops generated for the empty callback, substituting the function
- * pointer that points to the empty helper function with the plugins' desired
- * callback functions. After that we remove the empty callback's ops.
- *
- * Note that the location in TCGOp.args[] of the pointer to a helper function
- * varies across different guest and host architectures. Instead of duplicating
- * the logic that figures this out, we rely on the fact that the empty
- * callbacks point to empty functions that are unique pointers in the program.
- * Thus, to find the right location we just have to look for a match in
- * TCGOp.args[]. This is the main reason why we first copy an empty callback's
- * TCG ops and then fill them in; regardless of whether we have one or many
- * callbacks for that event, the logic to add all of them is the same.
- *
- * When generating more than one callback per event, we make a small
- * optimization to avoid generating redundant operations. For instance, for the
- * second and all subsequent callbacks of an event, we do not need to reload the
- * CPU's index into a TCG temp, since the first callback did it already.
+ * Instead, during TB translation we add "plugin_cb" marker opcodes
+ * for all possible instrumentation events, and then once we collect the
+ * instrumentation requests from plugins, we generate code for those markers
+ * or remove them if they have no requests.
  */
 #include "qemu/osdep.h"
 #include "qemu/plugin.h"
-- 
2.34.1


