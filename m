Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80595C28B24
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 18:07:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqc37-0003Nc-12; Fri, 07 Mar 2025 13:03:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqc32-0003Kh-UB
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:03:48 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqc31-0000us-Ai
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 13:03:48 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43bdf0cbb6bso12560225e9.1
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 10:03:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741370625; x=1741975425; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J4WceDIEs6qy2mz0/CkEqDnKb2HdT3DG3c81fgnQQN8=;
 b=nu+oST6CY/1HHPYB2qr/OpLT9l67uG44MEr/DdVib5/XcvgE4FMcEahcoWGGeJIG1H
 WkmBNYx45LIh58MxNiRoSeOAvqMTeDNC8Sk49fmiMmU61VucTW7JEROgG8YviG7s3k1r
 jtMz4ttqdbJQ997xf0E4vKpgkL5jeZshh0LpIUX4vQ+bH/ZUdaU1aN5611iMzcwnQ/Lo
 gsjie8RCiPkzf0W/xgnVYVBnaYznlIQavgFEX5RCZbWQUaNeynnBgOThEVCutSJVLc5u
 hJYe5JTc2h1swIAFE+HaIqog8nHaUYGpdmvk9tSh4Hx8tAXa/BG773iAQcm9NHng/XOV
 Bh0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741370625; x=1741975425;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J4WceDIEs6qy2mz0/CkEqDnKb2HdT3DG3c81fgnQQN8=;
 b=CxoVad/FCoj8RFafshprBPXC0Enb8A3p2FLPC1279nyPZ6mpYHW38SrZZcDMErdmNY
 64fiaJ1eZ0Elt6Kv4tT06sM9jeu7tpkn078xcIQqiwNfmgtxWprUPlJZEkV6J7B/28v+
 lI7SwT9PW3+552PDpIHqf5r5szKbeDeRyZ6dmTHjc0l5KLSC7SYpg01exMEf+CIN5fmN
 kPfB3i2VjU8+S/HWIa0WKz4a0N6VmhD74TFUwZ5A3Dt3Um+1+WVttoc6ZraxiYQS+VJe
 fDBzyBw6TBzZ1fIpbqFFNas+F28XOO5JF3eq53NK9uOVglrlWA+4JVIPUGs2RcoG/q6r
 Vqeg==
X-Gm-Message-State: AOJu0YxKa0SMACsWN0igZW130yvaDTXCCSQZ2egDHUxbLlEk6+ODwpn2
 ud4zMuyXgJg+jXfkegag9fBe2f4iB5kiTJcuATjs/WMQY2PAJp/yvPLT3C2S5yIEn3rASSO8mnf
 Tjq0=
X-Gm-Gg: ASbGncugNw6RbnRnD/OIEJCNhcQvARt4PCQPmJN52Ymkb0CBW3BuTzCpPo50kKBOxQN
 VObe+fyuYY25o16Fa1KDzFuMPCRx3lR09zDD4L9cR/B+sjOBREhnk3gA6GIHlcVWSOukJA/VMxR
 8w7CqeuBlJ+m8VkoEZdSKGx/5C5jTiZIZ56xTfzsLc2KGmShnsbBBjQbUU/TGbp7wWR9ZsHPDhi
 dxOvSc6H+j1VtzVWxtawM0vUE/yzieBl0JBRv7QfH1F7RgTz5HFxipRaQRhFoWwkwRetpUh7I50
 qIdFUDwKt/NjdHsMpl4gisfJQZNFqnpLPLgBOcUdHvsi1IUpTjWIgDRhzyPCHZ9um1jlAvPGGNc
 JWSyPBomEOwBTkzJXkng=
X-Google-Smtp-Source: AGHT+IENdobWa78DHN7taYvyUia80YoI2km9M/IOHa3nNnJsg+wiICIpvLN5fVTrb2DUViXZ9quCCA==
X-Received: by 2002:a05:600c:4447:b0:43b:d0fe:b8be with SMTP id
 5b1f17b1804b1-43c68718900mr35580865e9.30.1741370625106; 
 Fri, 07 Mar 2025 10:03:45 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bdd831719sm61522465e9.0.2025.03.07.10.03.43
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 07 Mar 2025 10:03:44 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, qemu-s390x@nongnu.org,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 01/14] hw/vfio/common: Include missing 'system/tcg.h' header
Date: Fri,  7 Mar 2025 19:03:24 +0100
Message-ID: <20250307180337.14811-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250307180337.14811-1-philmd@linaro.org>
References: <20250307180337.14811-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Always include necessary headers explicitly, to avoid
when refactoring unrelated ones:

  hw/vfio/common.c:1176:45: error: implicit declaration of function ‘tcg_enabled’;
   1176 |                                             tcg_enabled() ? DIRTY_CLIENTS_ALL :
        |                                             ^~~~~~~~~~~

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/vfio/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 7a4010ef4ee..b1596b6bf64 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -42,6 +42,7 @@
 #include "migration/misc.h"
 #include "migration/blocker.h"
 #include "migration/qemu-file.h"
+#include "system/tcg.h"
 #include "system/tpm.h"
 
 VFIODeviceList vfio_device_list =
-- 
2.47.1


