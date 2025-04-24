Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1BD5C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 09:48:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tBE-000836-7J; Thu, 24 Apr 2025 05:47:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tBA-0007zP-R7
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:47:37 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7tB9-0002at-4h
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:47:36 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-39c0e0bc733so674713f8f.1
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 02:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745488053; x=1746092853; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J4J0VMJ6GfvwPK+ehChCjxy21KDTNZZmDYppJFi+hTg=;
 b=H1KiyEGFkmqo+c9nDMQZx6uDHS+qSZJpXk2DV0id6h9pylbAAsiqTQpH60psywygLH
 QpmyGbG/rFaW1NIelgKvDoge1DatiKmEIGqndLFkGrs26EJ8+GyEK1PJ2fbO2vqYx/yE
 WNitpny42D7LsCMHx4bu+EdAlUp9jtjyMiQeV8GcMBDtZgNH1W1IhXwnZfutEBRcWfek
 ni9l17eEmkrvEzAaMoliT41gUiMKbGS5ChLqiKMkFPfhFifbLaquSxZ8GZny3p/HWUed
 OLxTguX3RL6NvhXoa0TdLCKHKNJyPlHCWdJbR+bnFJt46BTp2r5jPYAXOLYi4SaunSbd
 rkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745488053; x=1746092853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J4J0VMJ6GfvwPK+ehChCjxy21KDTNZZmDYppJFi+hTg=;
 b=InZi8lzMLT32px+T6qbHl/sNgEScLHfxRAW+SNZnzM+4nHXGD9dITJuCquRVFl8ScK
 iOAQ3V3IUza8emLUOazb3Z9WgczHQCxDnI+Asgvbm+NYp0jMft2yjbCzrti9qGJ6eIjS
 PzTpn5XGiadE9N5gNpa2um7UOWx83xAFzxuWYFWBxC2YwhNwtac7oiplpAaECvlyW8k9
 guTo2Kh7sgZaBDiVfgBzS5q28llWQUQC6FEsO8VQYdHYyxP1vyvbTNKHz8ARbUisonBW
 AUNiowE9n9HfL552tzodVk5XgI803OB//rkBe6Z9wU9d+Gzg5d+6QchcpIPNx3BJF2MS
 q8Aw==
X-Gm-Message-State: AOJu0Yy1Udhk67+FmoYana7Bg+76jF5Ztt1IFtldKSnP7bEuhq2oxnAB
 mM60yaalQokuPyGsu7iC+7iM1MuuhSl8BgXy6pObxKHwQ7gEVy9xRxxCR9Fb5GOYpy2XaEOrKX8
 1
X-Gm-Gg: ASbGncv4MftpskZQPJm+IsgkI8nnYJGqqunAi4E8r1331mesmgGjacbrZHfQNWMLymU
 Rwx8dT6SUG7juqLhHPWeWAvSMFSuDqoUj66dHb3IiGQKsqKSRZptcGWnqTMBn5uDGs+6ZqnZjD3
 GdfgqScoOntWXNh24UnRySHRn6KGgP9YuBWRvxvNvsP/8976ZE5bgJgj4Kl4GV/Dp/T6rnjcytQ
 OMDtaMrn4wtuo1vSJD0a+COJ//qrrBsEez4FUnPEGjTwYd51brh1UbAQvKUeZ39DiP/xY/Je0RE
 uyJrGFr11g/h+ylQNRFP9uX20En0tFFYh+fUH+PrSR5j/O6/AWLchomvcRiRqX7jVpX2yx/bZoM
 FubHn1OCyAuTT3AolVtnlY+aL20gcjII=
X-Google-Smtp-Source: AGHT+IE7CAQ+GrbTpu76I4sL5k581SWd2SReA43pqozmu9K6SWlw+XwRclvoLBgxzDhBrJ9APbPW1g==
X-Received: by 2002:a05:6000:22c6:b0:39e:e438:8e32 with SMTP id
 ffacd0b85a97d-3a06cfc5d0bmr1187599f8f.55.1745488053012; 
 Thu, 24 Apr 2025 02:47:33 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4409d2a2386sm14204155e9.14.2025.04.24.02.47.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 24 Apr 2025 02:47:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Richard Henderson <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 08/13] target/hexagon: Include missing 'accel/tcg/getpc.h'
Date: Thu, 24 Apr 2025 11:46:48 +0200
Message-ID: <20250424094653.35932-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250424094653.35932-1-philmd@linaro.org>
References: <20250424094653.35932-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

Since the macros.h headers call GETPC(), they need to
include "accel/tcg/getpc.h", which defines it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/hexagon/macros.h       | 1 +
 target/hexagon/mmvec/macros.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
index ee3d4c88e7b..6f82277a415 100644
--- a/target/hexagon/macros.h
+++ b/target/hexagon/macros.h
@@ -21,6 +21,7 @@
 #include "cpu.h"
 #include "hex_regs.h"
 #include "reg_fields.h"
+#include "accel/tcg/getpc.h"
 
 #define GET_FIELD(FIELD, REGIN) \
     fEXTRACTU_BITS(REGIN, reg_field_info[FIELD].width, \
diff --git a/target/hexagon/mmvec/macros.h b/target/hexagon/mmvec/macros.h
index bcd4a1e8973..c1a88392c05 100644
--- a/target/hexagon/mmvec/macros.h
+++ b/target/hexagon/mmvec/macros.h
@@ -21,6 +21,7 @@
 #include "qemu/host-utils.h"
 #include "arch.h"
 #include "mmvec/system_ext_mmvec.h"
+#include "accel/tcg/getpc.h"
 
 #ifndef QEMU_GENERATE
 #define VdV      (*(MMVector *restrict)(VdV_void))
-- 
2.47.1


