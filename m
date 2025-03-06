Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A22EC282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 06:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq4vS-00024U-Rg; Thu, 06 Mar 2025 01:41:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tq4vD-0001z7-HB
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:41:32 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tq4vB-0006FI-FY
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 01:41:31 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2241053582dso4630785ad.1
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 22:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741243288; x=1741848088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/2Cqyz5MzW0BJMcv6vHkDTQpGUU3r1TqAgpaR0U/jco=;
 b=n4aHhMnVBQSbD9pztvFAonCbKYus7euHaZTfQjtw+1HR8A5qmhMxlNj5cbF8ZLIeCh
 xWygHoDiYWlGjJjRgSoQ3azYO/4wwuEsE9JTdVegMp7p4P3h4TKYfFrUKaqM/Y6aGonB
 RZB6TGfoeXW4dCtTfsawyW6RAK2pDaXpT2FtLOXYD0iViLnPKmVcZpgEAX1qNpS1BPRv
 noEpkBEtgqdi6k4DLImNifA9GdlFFgJufzGZgxMnblhqKH29MEPxOLHHmuK1BA8HK8b1
 +1FrFwDu3PswJOfrT9AdpDB1R+Cce2p2pJBrlgyKly2VZnrWboATWELF1jrLAU+9ygZf
 DG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741243288; x=1741848088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/2Cqyz5MzW0BJMcv6vHkDTQpGUU3r1TqAgpaR0U/jco=;
 b=bU3FqO9FOerO8BMvufEUGQd2VoKnICiNZAMepJoB8AEA/BPXlyF1PcX4+r96bxiOaU
 6FNBdyVk6FtZspH1S2YXT1hDO18h7sHbZrPtPLQFBuQYwshyz3KwXSrI9uh4113R+H90
 x+hcFB/VdjgOTWca6zcfYk7qT5FjYIY75kZtF1KHOMnheAthJFMmkG6DrttNXUD/TkGx
 xsy0ermX/PCe8Bi35eOx/e2/dgVvP0UOzm93KPU9qL4HYz5BSRPdr6DFZiDD22eK2wln
 3ngbqpxDL+R3d3xuZc5EK1YLNqnH9gH5ikGkNnaP+5S7eM6hIQnoZ2flXQtGxiMhJION
 6mjA==
X-Gm-Message-State: AOJu0YzMw67ZHPMGqVYpw2gjAFsH31q2/6Alwc0//7oEeOvHtgQ7HwX9
 yk4RiJfL5/hCpaaYw1gJg57/aaxYUIEaibQgq+WIVflssn2z+mNVOdHSsThNGhc/4ASdhAeMOk1
 q
X-Gm-Gg: ASbGncu/ehP00z3yaaYcEKKoTcVKk2tuqRWN0EJq4V9swacOW37xnJ/a9FqCr3xkSfS
 pNGegiS2i6+hVZOl6xaaGj5uOdtdYL5+Ozj9LcNrvo7iEpPsP1Uym1d5r7gG4E/gwEX5GZ5F3El
 O6AOCxeHVYEmilaybteWuqvT/5ySRfW+JxJm0pQyB8cfjw0X3nYvW1Y5GEMm/3qS8GSJs8kfHAk
 5Mw6O+mQKcgy29v7D8+Q57Jl+jWSGZYgExWJF1T/dpuIv+G+tVhrU1lUM2Sd4rAbEOqtQdW9Uga
 3TcKHNNESEekY8VCoVc8ubGp5zFsq+7qHjgC1foF7JGg
X-Google-Smtp-Source: AGHT+IEhtCs9J6dNUfTXZfoSz7KQgHmZ66yfg8KDNs+eagI9gyF0lZ1IhFG6M2GKXybBGTCI/9l/Mg==
X-Received: by 2002:a17:902:cec7:b0:21f:7a8b:d675 with SMTP id
 d9443c01a7336-223f1c7968amr102765835ad.4.1741243288018; 
 Wed, 05 Mar 2025 22:41:28 -0800 (PST)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410a91cffsm4769355ad.174.2025.03.05.22.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 22:41:27 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, philmd@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, pierrick.bouvier@linaro.org,
 manos.pitsidianakis@linaro.org,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 richard.henderson@linaro.org, Marcelo Tosatti <mtosatti@redhat.com>,
 alex.bennee@linaro.org
Subject: [PATCH 2/7] hw/hyperv/hyperv.h: header cleanup
Date: Wed,  5 Mar 2025 22:41:13 -0800
Message-Id: <20250306064118.3879213-3-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250306064118.3879213-1-pierrick.bouvier@linaro.org>
References: <20250306064118.3879213-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/hw/hyperv/hyperv.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
index d717b4e13d4..c6f7039447f 100644
--- a/include/hw/hyperv/hyperv.h
+++ b/include/hw/hyperv/hyperv.h
@@ -10,7 +10,9 @@
 #ifndef HW_HYPERV_HYPERV_H
 #define HW_HYPERV_HYPERV_H
 
-#include "cpu-qom.h"
+#include "qemu/osdep.h"
+#include "exec/hwaddr.h"
+#include "hw/core/cpu.h"
 #include "hw/hyperv/hyperv-proto.h"
 
 typedef struct HvSintRoute HvSintRoute;
-- 
2.39.5


