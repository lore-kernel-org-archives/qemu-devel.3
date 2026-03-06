Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 547A5FCB608
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 15:04:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWfo-0005nj-Nn; Fri, 06 Mar 2026 10:01:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWfA-0004bt-7j
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:24 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vyWf8-0002ku-Bv
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 10:00:23 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48370174e18so56790315e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 07:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772809221; x=1773414021; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7jDxYep7GJJUj8CcED/omiAOWuvK6uqil+IxrW6kQJI=;
 b=ZD8Eryam3nojrtIa5KoB9wscHdWOo4Xwj5lgMyoUYSNgPx5vlttFvzKeoJIF6xwhEU
 cSp1O7l68ogZIppWbAsia2jsnZ2R4dfxJoh1sQbWIGWhmba7ZtH7Lm7s6/TsTp6WZ0To
 +hlmnk8Mldvp8XhDzrPa6Khdz/yQiNX4ZYrHCbAwVsVUTIw3YhIun/6vGvcWe5MU23HJ
 nrtAp0Ilm1tGt1OTkvMqVbCRQgygzDxxhLYSnVScJn+VR21rzY5oX/vffr9+10GTsnmU
 k4oWjwqmcmxjCtjVyZXykTT3GYNJe4fRLszYdp5CdtytwZk5XnCBwnp9aikMeeackQ7Z
 HZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772809221; x=1773414021;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7jDxYep7GJJUj8CcED/omiAOWuvK6uqil+IxrW6kQJI=;
 b=BGmn8jqeRPnP+4+jiD0lMgT1k4MoLBJbuKe9ose9ucT0sJr4HaQFonWEH6BdYaUW5v
 Ni9ooxQzP0QBwy30qkqSDWQ7wfndb50kRDNjCnRF4UtU0uEMcRd+mu9VOfdjrYt8YRc1
 FVAbHqNQo0dslDLJQwfsKHuaEOys6d64ZItvtPK/i8uxs4OpilbgXtwiWStGtdEyhaUB
 VARb+X3tEbAfk5GKFFxXzn+ivNWvdOhuxdH1z2wSuVdC7e/r94aR0BqlZWV+rY3npGEs
 Em8+UwnMUW5wJj9K0R+OWU8t9rQF+ARJJgNmcrP8Pe/hSnNeHo0OYN1CNj20P9T5P29T
 sYUA==
X-Gm-Message-State: AOJu0YxV8Ei+y5ch4rdFRBOvca5tB/Fyfz1pYV2/LBPuDBpgHgxfppif
 rfqIiTAi9buTF3lqSbUmXKBmQbDxbbAkp0+dDiCtB7+7rpcpDvkw6A1Nc5SCWOaPGnhTomZuHlH
 J+QgH
X-Gm-Gg: ATEYQzyEBhcYIUTuh9IJNOf76oTvC0F9vX7uBDK6SgOggE5JBeGTlnWm1kdOsEXij28
 WbZuPlP1EW5HLgqGpvwAqb/HAOddBaAijUXAiKubUrnbIBYGNBGXiqnWabe54y54M2BR+3KBGEb
 rj/wKQbWAyhXsLoQqEoz/Nnsc5JEShEVOhiA3mmyiGG7Y77UpVLInEeJLl8OuMlL4bSTQMqivfw
 6ccHrQxB6YtZsL8at4rH7dR2weKAL8nxBlRfxec9QfX4bolotC1QdEbuMlCZl8YgaDloblS0yF8
 05YZ+YZGJQhjkxZKBcJhIYvYPljrrV+8I5uH1Eces116XyAWVTa3lkehkiQJaASv5JJp4vnxBlr
 Xp/FzumhGH+raT91jk3ApwxT8KSfJjdCNTz9sCwZ2P5K1/GX0rbC+TpY/zKEo9zfJuWZxSKD+15
 js5r0F4bRBLYcPIt/9LX03CYtUF/ZLiqCaXtsPYUuvFZySv7tAabJ0s9Q42br20EbpnthQgmxEJ
 iy6ZVh1/3BsJF3cRAV53NJJPwZ6Azk=
X-Received: by 2002:a05:600c:8218:b0:480:69ae:f0e9 with SMTP id
 5b1f17b1804b1-48526958b30mr46771045e9.16.1772809220873; 
 Fri, 06 Mar 2026 07:00:20 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485246ece8bsm28681845e9.4.2026.03.06.07.00.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Mar 2026 07:00:19 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 35/49] hw/arm: virt: remove hvf_arm.h include
Date: Fri,  6 Mar 2026 14:59:25 +0000
Message-ID: <20260306145939.2162189-36-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306145939.2162189-1-peter.maydell@linaro.org>
References: <20260306145939.2162189-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Mohamed Mediouni <mohamed@unpredictable.fr>

We don't need anything in this header, so drop the include.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
[PMM: updated commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260306130107.35359-4-mohamed@unpredictable.fr
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index cab2e21e8a..7456614d05 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -71,7 +71,6 @@
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/core/irq.h"
 #include "kvm_arm.h"
-#include "hvf_arm.h"
 #include "whpx_arm.h"
 #include "hw/firmware/smbios.h"
 #include "qapi/visitor.h"
-- 
2.43.0


