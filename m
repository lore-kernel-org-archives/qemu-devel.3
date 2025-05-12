Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A548C3ABCB
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 18:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEXaI-0001cu-BB; Mon, 12 May 2025 14:09:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXX8-0002cz-Ma
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:47 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEXX5-0000BP-LI
 for qemu-devel@nongnu.org; Mon, 12 May 2025 14:05:46 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b1a1930a922so3516438a12.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 11:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747073142; x=1747677942; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oONThx//EO5WSiuREF023HuwIIuJ5yNwT7cwhGAiXZE=;
 b=STJw2EcZjNFDnYuXb/XUcCD+DkP+qvpZl24fkZlGvSoVW3eytrl+GaW+641pMjXQuW
 JmQD5lEd4VAHR/MjGZtvtkP0rMWfmUkXid4kGJku2a3XGjJDcvYEA56i0jiIHU7LG1Ci
 DwrpoObDcxWlGOBiAokNd0m0MGAgC6xBxYmCrQKpsrHPk/rVNCd8lW7djA/fu8vxRu0w
 FtysbL0k15fUVHudEe+3OQgBIr1Xf4qH3T+Lom2DHA9x55ZAEMkvPnMEkDav79dGMQoW
 bzoixR+hbJxhOQfP4AU2QO/qoOG8FWi7CJZs2KLJL42Yiy6kUsZjO6w1JPcbiw0LMcMQ
 EixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747073142; x=1747677942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oONThx//EO5WSiuREF023HuwIIuJ5yNwT7cwhGAiXZE=;
 b=El+6gxmo/CKWEAwV5x3iuRbq87ytWZXgroh6D6xkfyvwq7wVvxOviwqj5Rhx596tDc
 mANNSJSJtQk3PXfw2oWD5vTh1Xdx5/PKR9QY0Rz0VIoqueSOQc8Eta7uFBsWPjUaGs0O
 zJ36NnBsAfKnsG7zX7qNunUAS7d3haDrHt3BZLWwN2R0Dkt/cpz0YhDZSns8tpe2MA5+
 Fy8pRdaFtF0j/3V3t46zvGgOnS9edoubjIhMrN5FYELjlKAgXHf6qsIdVDjGHtA5jpIB
 Ww+vcwWVdt1Vi/1ZW7ZP5BhPGrjGxtkgN7CiQjgL7MsHp8ybp3o0Ca4DGcUuoGFnAnkL
 6lgA==
X-Gm-Message-State: AOJu0YzIeaQpJei69VHxwieAkXpl2nZrsksfEG0czTDs+joMbMy3y2RO
 U29d5fw6/Grrbj1WzKViSoB8/p1aSgDHJSMPgfph3fN/AArlaJJTWsw5bl3hbuE3jbxvj7ApBCI
 p
X-Gm-Gg: ASbGncs8hA/xNS8wsVe7VKsMqnVUBsBPcjllp2NFrk8ZLLS3VlJVxPqxVCOzej0uc7Y
 dEqIUvLfSWIZnl7YTk9LnW4z2uZXjuo4qCt/lo4mwyEQj1EBQ9XPP217Lh9rZkE/X0xmG9of44p
 ao2e5cpbCRDjtF5J4y9y+/WpnZGND5Y+w3x2A8WHa79KjFniaHKIzxQgUXc++lCRw6sNDXqi1yn
 Amf0qSNsLkqo5y6cc4mLd4Cp/0LnzF08JzkrminLDNMcxz+ESnH3xQEuNk9xmYbMr4VmtB6Gs6T
 6MsuOu34SvyYoTd9NwlljzVCkwlupzN1a14o9kmXRtSmqo+a3qo=
X-Google-Smtp-Source: AGHT+IGDr/hFIV7zSeR1MqUCWj3qYIVaOAhK58NysAKE8oD7L9hcv/5zp8VBN5nkmjJpsYAWjgK61A==
X-Received: by 2002:a17:903:32c1:b0:224:c46:d167 with SMTP id
 d9443c01a7336-22fc8b51a28mr201435875ad.16.1747073142056; 
 Mon, 12 May 2025 11:05:42 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc82a2e4fsm65792005ad.232.2025.05.12.11.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 May 2025 11:05:41 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, alex.bennee@linaro.org, anjo@rev.ng,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v8 34/48] target/arm/machine: reduce migration include to
 avoid target specific definitions
Date: Mon, 12 May 2025 11:04:48 -0700
Message-ID: <20250512180502.2395029-35-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
References: <20250512180502.2395029-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/machine.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/target/arm/machine.c b/target/arm/machine.c
index 978249fb71b..f7956898fa1 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -6,7 +6,8 @@
 #include "kvm_arm.h"
 #include "internals.h"
 #include "cpu-features.h"
-#include "migration/cpu.h"
+#include "migration/qemu-file-types.h"
+#include "migration/vmstate.h"
 #include "target/arm/gtimer.h"
 
 static bool vfp_needed(void *opaque)
-- 
2.47.2


