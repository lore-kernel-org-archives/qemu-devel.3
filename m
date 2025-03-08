Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4E6BC282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 23:11:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tr3Is-0004aS-Pu; Sat, 08 Mar 2025 18:09:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3Ib-0004NQ-VX
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:09:43 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tr3IW-00017x-7Y
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 18:09:40 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3913b539aabso418796f8f.2
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 15:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741475373; x=1742080173; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UiYDGY0x4W7ov/VJy7EJQHs//caAqbf3NrfbrKDB/Hc=;
 b=dmM55lIQyRTqS8et88SCourPaiveLdRnfeOW4liTwMvH67n92yigOdWvZ81JUmaePI
 8ydYEh0sihO5YvVonCyrg7s5n65wDb7ODUwpVfgwkbL4Di4teSeyU4AtqW4UURI2xig4
 2Shvrc9w3ne6MGKLTcdKWDlIuDEwBzL/7niRMcahNBo9ZnFL20n/uZ0PAjJITefwJIfo
 QHMLgZJKnSVng8WY9giadbXyoMFN2kbNeVY7Rk6klH95y9c4thliMP5YKFKmFF5WJkqq
 y+tzKNjQJ3kGNk03S6/fBQtdcglmj9quG9awmqJ5y1AwdZRrCc7dmcHtu/b3HN7soxOR
 igKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741475373; x=1742080173;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UiYDGY0x4W7ov/VJy7EJQHs//caAqbf3NrfbrKDB/Hc=;
 b=PVsmkTRp05W7n87qDwyEWzbnCqwJ+slAGpTcTZB1If6NnTHQdr0HEgDJlOFZkwxyzm
 DaoWonCLvwzWZy93M2oBHEmMbLQff53fLrcKzT9HeEZVXuQAJtuKfHOy4bCMs4Nb7PLO
 zmF7KWwaq6GZufrL70xXYp4d/q4ognEXXqct6JTVcK/yg1Z9nOEjMe/eCYKdgsmlU419
 tqnVxmjAqqYauS20f7OqDCZXNQLQwoduY80sm87xpZJDH3AUQz2mmpZcy42i5u6tZI2C
 xeOQF1HgIAYFzxbZXUhZfBu+UU9GZh+3He/2/cpOpdpbMnwiXMsWXZDlKYmTS6/FeG54
 XW4w==
X-Gm-Message-State: AOJu0YzzLhIVccjniAFIVvBPJlz7lbFUbVFtJ+O5ULbhvgNnDoBvo8Un
 Dj+Ay4gAVn/9KMSSziudl/Q5D/dlGq7JHAfsuEjAKMmAcmV7awEMtM3rS7fC2sV6INdVzXgBTXn
 BWBo=
X-Gm-Gg: ASbGncu1qrTJN2ViSqAUFraOM04AJ8X5JMRJfrO6nadCWsOoXnX7fH2HTOaB72+R0RY
 pELEWe9QmQ6A30LYdgaX1iaZ8yew6xk+8lM3JdVFGLFt7IdUpuouM4uGSMDrrj6Ee7cwFdERhBQ
 s+2ysi+kMQzLSpP3yKQ1Yy1DyIG9hlBobEET7Jw+Qd+gUcUUBjXsm3lLfer5L6L5t9h/8b+yT3Y
 LSV8xNXeT6klc+8JU6xeeeVII+ohVEfNPr4gBHoH7dAlATnJ1nnpXkIf9lkOTr/Y/Okmf9pwfM7
 gnAM4Db2WGjUhMcOg1BShpsEm+dIN8vNM7UkfnUzs01AYZ2A+v608I8RiAB+HhsTrsna0iiPQtc
 yaMXmgjZiJObo/jCYIl0=
X-Google-Smtp-Source: AGHT+IHYMJqZoHstkmUTso6ugEbg70sSuamLLXL2p0kaDugCZceiL2gWbQnBjC91i2JahXaPJtswDA==
X-Received: by 2002:a5d:5f8f:0:b0:391:2e0f:efec with SMTP id
 ffacd0b85a97d-39132d1faebmr5173255f8f.7.1741475373036; 
 Sat, 08 Mar 2025 15:09:33 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfe0004sm9859574f8f.40.2025.03.08.15.09.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 15:09:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Halil Pasic <pasic@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Tomita Moeko <tomitamoeko@gmail.com>, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Farman <farman@linux.ibm.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
 Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-s390x@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 02/21] hw/vfio/spapr: Do not include <linux/kvm.h>
Date: Sun,  9 Mar 2025 00:08:58 +0100
Message-ID: <20250308230917.18907-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308230917.18907-1-philmd@linaro.org>
References: <20250308230917.18907-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

<linux/kvm.h> is already include by "system/kvm.h" in the next line.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
---
 hw/vfio/spapr.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index ad4c499eafe..9b5ad05bb1c 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -11,9 +11,6 @@
 #include "qemu/osdep.h"
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
-#ifdef CONFIG_KVM
-#include <linux/kvm.h>
-#endif
 #include "system/kvm.h"
 #include "exec/address-spaces.h"
 
-- 
2.47.1


