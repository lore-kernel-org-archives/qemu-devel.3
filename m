Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46BA5C021AA
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 13:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk0pe-00026M-PS; Mon, 17 Feb 2025 08:06:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tk0pd-00026D-Eu
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:06:41 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tk0pb-0004lP-Hp
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 08:06:40 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2fbfc9ff0b9so6551349a91.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 05:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739797598; x=1740402398; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7QzO70em+SWmM19nvv4jHPXxR+fFgMfgrFERsTk++Jo=;
 b=blhRGow/TedrWfYyj72BanNkbT2YeBSCdgqS/ABl1MAdOB46ROClz2asbAzsXB0mKC
 eunIBGf7EEDUFCmn8WmWKQdy20WqG4XUgBimSFD+ShIVaCvPotD2/UfpWBuv/X3cESCG
 L6XeuD79tlW9Di6+WfOg6UOoyZYJKjABc6E1G5up8+Q87WkBjV1VlMId2E6+uJRoYuLj
 3M3aF5j3GoynDq0ClpYaX/dRQlM0E51RivGW1Bfxt0Vnmhitzyf5QA2a/12a79fwsBcS
 nxnI+KndgJTpXTNNzc6vJNRFcCMvENexoeXv3O3Ga4WEK5iLfb9d/VlNmwyYrHylyCLw
 WgNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739797598; x=1740402398;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7QzO70em+SWmM19nvv4jHPXxR+fFgMfgrFERsTk++Jo=;
 b=d88/dsUrBhfbXKyLX7fXENrzKNcd96+jKa0ob32NrQBFWV7d+cb03K98Qlkmmmob9W
 U8Fv4FpntPfvYH7jHYE0wdOa0AVILOXxGcsE0WpMcXLYuzdRu6Cfkq0xnLP0StcAbO8f
 DLHWbBsbcG8UawD3sx5PFS0Vj1eOd4i9WRodifr3jh0NdDcg2aE60OjpcZLAkppXqEMr
 DQ0VeXByP9EuKhaSGb4ehhDOlv91mpKQy2jPcq15z5O3wuk5lo3cZykpm6ER+G5xw/5X
 so/LRVArwCmmFuY8gYhHji+x5CQQKA3vKRYTs4DEsWdrm63PWW4/5ipQU+diMnhWQBJk
 GjSQ==
X-Gm-Message-State: AOJu0Yzb7Z0zu00pHqovWWjoh3rswXHzzHnwpyiD0/WKYCq/siH1EQaE
 7rERbeZQmGMuiabZx/DNdiGeYfJFSo0+I0eQ97x3cYzsu3i7Y+IqUubNZb25SoslztwVNvv2x+7
 xlM8=
X-Gm-Gg: ASbGncuClzU96+kUUJo7+nRZ1VLQazbwzfuTXzAhSjxkyybXT6Sqiz9Zv4yauPRvK5i
 /OunEZyqhC73JhKM6aI2L15IpHM5jFeml0MaKFeLUwvjfBGTLZN8dfAumG9qyYL5iqH+2ttzOSt
 O/6Dx9dcFFlEgP3WY6EMVI1glS4gVbMyFUDYn73PWJHUwxKJUqXQYI+3VKsJpvTpZ6Cd1JPv1xG
 DlgkBe5GXNiGINWfTSL0SR1etheBVfaja0oS8PClXnI4sRvrIMk1suUnyfP2K8yMa0PWcSOEakO
 ARQUMVWXJ1lvoOauCe3PgoCDJc1V27jgpkJn6CExGzY=
X-Google-Smtp-Source: AGHT+IH1xk4zg8VHhAQG551UBjtC6HiXPMunJlDfERBcimEi0uX3yk7W6k0vljHaGv2t/Wt26CcGVA==
X-Received: by 2002:a17:90b:4c0c:b0:2f6:d266:f45e with SMTP id
 98e67ed59e1d1-2fc40d14fcemr14940725a91.2.1739797597690; 
 Mon, 17 Feb 2025 05:06:37 -0800 (PST)
Received: from localhost.localdomain ([176.167.144.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d545d046sm71339195ad.114.2025.02.17.05.06.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Feb 2025 05:06:37 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 1/5] accel/accel-cpu-target.h: Include missing 'cpu.h' header
Date: Mon, 17 Feb 2025 14:06:06 +0100
Message-ID: <20250217130610.18313-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250217130610.18313-1-philmd@linaro.org>
References: <20250217130610.18313-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=philmd@linaro.org; helo=mail-pj1-x102c.google.com
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

CPU_RESOLVING_TYPE is declared per target in "cpu.h". Include
it (along with "qom/object.h") to avoid when moving code around:

  include/accel/accel-cpu-target.h:26:50: error: expected ')'
     26 | DECLARE_CLASS_CHECKERS(AccelCPUClass, ACCEL_CPU, TYPE_ACCEL_CPU)
        |                                                  ^
  include/accel/accel-cpu-target.h:23:33: note: expanded from macro 'TYPE_ACCEL_CPU'
     23 | #define TYPE_ACCEL_CPU "accel-" CPU_RESOLVING_TYPE
        |                                 ^
  include/accel/accel-cpu-target.h:26:1: note: to match this '('
     26 | DECLARE_CLASS_CHECKERS(AccelCPUClass, ACCEL_CPU, TYPE_ACCEL_CPU)
        | ^
  include/qom/object.h:196:14: note: expanded from macro 'DECLARE_CLASS_CHECKERS'
    196 |     { return OBJECT_GET_CLASS(ClassType, obj, TYPENAME); } \
        |              ^
  include/qom/object.h:558:5: note: expanded from macro 'OBJECT_GET_CLASS'
    558 |     OBJECT_CLASS_CHECK(class, object_get_class(OBJECT(obj)), name)
        |     ^
  include/qom/object.h:544:74: note: expanded from macro 'OBJECT_CLASS_CHECK'
    544 |     ((class_type *)object_class_dynamic_cast_assert(OBJECT_CLASS(class), (name), \
        |                                                                          ^

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250123234415.59850-13-philmd@linaro.org>
---
 include/accel/accel-cpu-target.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/accel/accel-cpu-target.h b/include/accel/accel-cpu-target.h
index 0a8e518600d..37dde7fae3e 100644
--- a/include/accel/accel-cpu-target.h
+++ b/include/accel/accel-cpu-target.h
@@ -20,6 +20,9 @@
  * subclasses in target/, or the accel implementation itself in accel/
  */
 
+#include "qom/object.h"
+#include "cpu.h"
+
 #define TYPE_ACCEL_CPU "accel-" CPU_RESOLVING_TYPE
 #define ACCEL_CPU_NAME(name) (name "-" TYPE_ACCEL_CPU)
 typedef struct AccelCPUClass AccelCPUClass;
-- 
2.47.1


