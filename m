Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CD38C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 01:04:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kmi-0005Bx-NW; Wed, 23 Apr 2025 20:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kme-00058z-Ot
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:44 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmb-0004Io-Vu
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:44 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-7369ce5d323so302811b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455780; x=1746060580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C24thF1lHDac0cqqp26h4qdOGOfLrlU2eZE0vToxCKw=;
 b=WJJYQW48c7huLeV6vLagRESM0EL7R5d9Pk26QwYSH8SAk3MYO7m3i6gauqWeAAMICY
 aFjEA4GjyC4XAld9JPHu1O0HEbYINjrXSThwY99Cpd2FoU144sHeuRLNGs1xqfcPtiU/
 Zjxegvy7GRPweOFCzrlZIw21tzbs4Yj2wiw7WB4VYttbHFumsOs30hhhodYovsrMJ26G
 1FdwTjdVMVN/jdH+3tcL2nU8QkKKsnLl5lrHsjyV3jy0AB1iwHXulm6ylHHU4HiK7uMj
 ai27GuqE0WsuhW9fUM2VhrhwmkiuH8KZy3FBp6AEsVexcs8MLY6ug64RSie+EtXKxgx8
 v7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455780; x=1746060580;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C24thF1lHDac0cqqp26h4qdOGOfLrlU2eZE0vToxCKw=;
 b=FogR5Y9gGpgsYbZV6zkdEyiUtdYsM1iccYgOsM1l6dS5e6dJZXwIl2oUrHhbqzNnmo
 tP4UrQI3pOE2VjcCBf9ercs1HZgVkYe6SYjP5TDkkz2G48Gudun5G+BWGYArtN1JsHaQ
 UwP86glD/BFJgujE389S7mzyXZWbmSh7m8h/1TJPUGaBf4Ew9RTMz1QPX7onJ1/GYwwE
 4f3RR3dLTbWWSe+jWNalg9qFnVKasr7orVAzG3CdwwzGiqC9tu2wb+1TOscMP90CwwNl
 FnIaY0AWm8mu4xgZ958IFA+iJgDFjjWcI0FRLvgFVW3xA94j7vNUoWveiQTbH5h8yps/
 HXLw==
X-Gm-Message-State: AOJu0YwyVGaMpwf1T2siPylomuEtfU9lPwoytFjKhEMUe6QzEUrx4RGQ
 fod7tWu7etaMkiMdVhxSnux1ODv85rUJWiNYflLEe0KDMZqixqyBwHr4kT1jfG2KczoiwfeyunA
 o
X-Gm-Gg: ASbGncsmueMfjVl5rdxloMKdvltkAVtvgSjc1Orj6x8YBk1Pn9FGoTt2t7FNqRRl+Gi
 yyrXjSR9mUytn4RxdNieNXwrriRWHhB9lSwE0yOV/mW3zCqlBOhCIOrsMEciUkavt7Td73iUWWb
 JbXCS0dhLKaUwOrEbHWmA4NoxzpFgUhmYziOZyt7a5CymWD2hSDzBMtRuBYRjykVvLM4vkJt7FS
 az/zRvaMS1+LN9kpMA4K9DacXnG41IxCOpjn6vDVriiJISIhE/1zSCPvBfWDLMJ2eAPCouC+paz
 zS7FRoLj+LAadjiqRcW8nAWlHBIhLrT9GrPPkHC/vVa4l1q8Nk719Q0NsN6L3xSV5jucA7QQbTQ
 =
X-Google-Smtp-Source: AGHT+IEiebLaxUBaWmS4J5UPiS3Ym03+wahm35OEUL07pCJrW7lQmyr7swW3uwEPgczRL8ykUS7MlA==
X-Received: by 2002:a05:6a20:c89b:b0:1f5:5ed0:4d75 with SMTP id
 adf61e73a8af0-20444fbb7c8mr859178637.31.1745455780601; 
 Wed, 23 Apr 2025 17:49:40 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.49.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:49:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 008/148] exec/memory-internal: remove dependency on cpu.h
Date: Wed, 23 Apr 2025 17:47:13 -0700
Message-ID: <20250424004934.598783-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Needed so compilation units including it can be common.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250317183417.285700-9-pierrick.bouvier@linaro.org>
---
 include/exec/memory-internal.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/exec/memory-internal.h b/include/exec/memory-internal.h
index 100c1237ac..b729f3b25a 100644
--- a/include/exec/memory-internal.h
+++ b/include/exec/memory-internal.h
@@ -20,8 +20,6 @@
 #ifndef MEMORY_INTERNAL_H
 #define MEMORY_INTERNAL_H
 
-#include "cpu.h"
-
 #ifndef CONFIG_USER_ONLY
 static inline AddressSpaceDispatch *flatview_to_dispatch(FlatView *fv)
 {
-- 
2.43.0


