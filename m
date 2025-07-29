Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA229C83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 12:00:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugixx-0002TV-Az; Tue, 29 Jul 2025 07:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugixw-0002Ku-9U
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 07:57:56 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ugixu-0006DD-4S
 for qemu-devel@nongnu.org; Tue, 29 Jul 2025 07:57:55 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3b78a034f17so1610461f8f.2
 for <qemu-devel@nongnu.org>; Tue, 29 Jul 2025 04:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753790271; x=1754395071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TG80+zF9cKTj43CmNOK9rOUn4HX8lMYw2LzKA/8cZOU=;
 b=gMgofA3Z1nwEmubRRDOlwcg4w/gEC/8kvXm0fEk+uEjur4mmeLaXrKa13XjiGSGnIZ
 uZ2nc2yMGylklFCM1zbJzHxAo4HAAvVNQ1r+dPV5PFQt6q6/yEI7cP/PbzV0U5KEZFD0
 ksUXqv5sRAwgZLvYEzh76tkwvy0gA62CWMFEdgmSlp0rUOeW82+e7k3kmbxfpaODziU3
 0Ul+WpOQUgZe/DWXaya3ODVGHdFJ2bdVFLzTgmy7KQB1j2JNYb01adpDpQ3MtUoav/We
 WwqE2+tDjqoC063lht3l7v36bVcQc1DUZ1J2iiimRejYctBlFGTWMGr8YjboIuJDNsdX
 q1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753790271; x=1754395071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TG80+zF9cKTj43CmNOK9rOUn4HX8lMYw2LzKA/8cZOU=;
 b=keScX/M+yQL149eNb5ixfIZxfGUgMxEkGxlSOfElh+dMX383nmbmyowk18mdjHDyUJ
 UMktspEKYTVHa/75LNduSyfDJmEIZO9qkWmlHXMGTXcP46U4XWzMaQv6s8ky9DAvwQPq
 5E3CblgXkOdbl+A4JU5bK1qIDy4rUeFQQUjsB5lwhzj0uMSiHGficAmwq12hZhaiTN1x
 hPvSZTgRsEpIASvhOGBMSg3YzpIckeddZ6H+tMTNQEdu5iH9K86sIK1maPHJpNOjZRCm
 3dPTQgbPBsD0OCZkFoQH2AA9VGNDsMHae0u8qBpZwUga7BD/uz9xrRE83vmsLghshgXj
 14+w==
X-Gm-Message-State: AOJu0YxLvIB71BpllwjbM2irk7vsmWgPPgqaXtgkCY4mgKOkqWI9qOet
 97sbbiiuKrVZ2GGfg0+Fs2lk7yeEK/4sSmYt+g/d/51SnUhCcW1YAsJHLAOc4+iWkLwYtFP7tmp
 0Mlxh
X-Gm-Gg: ASbGncuot63XS2ejYcjlH6zpf+0rwl/kgZGf5H14StGD5M6EoOPXNMhZgZjEqe9PQtM
 Pn9TCY9Lun/xFunTcD3pBC/bYfuckFY++uQ9IibmcCl2P38XEYX4i98ZcRX927x5bgr5T8ztVWU
 K3q6mCWGknTqmhTsckZIlk0C8IzBKpK8sapWveGu8bBap6LFl7MsP7GjE56XnaD45RKxh9teOdG
 ejeF+meZqNq0zv+NOZBFCs6IzOTMEfROJycR2zYGUAVm6qpDkY9UZJ4V2gV+UUUdyPh5PpdZgxo
 6aMC+Lbc6N14xeH4rHvKmsCTbdCWHbNHG7etI7QBIU2EwRQqjODJeHZzUqj0vrk6nwsPUlr34aE
 IkyZhhp5LlZL1yYe98Kk55JgvlNI4hpj1I+HsLv5X0jEQttBt0qEkgGI51Bf2g50lly5Ny8qS
X-Google-Smtp-Source: AGHT+IFclYbd4WOVimBxVNDWFVn3DGNRqOYThxeo2rGiI6yuZAUvHFBHslxuyrd9G8czP7ZJQaXTgQ==
X-Received: by 2002:a05:6000:2083:b0:3b7:924a:998f with SMTP id
 ffacd0b85a97d-3b7924a9d34mr1521035f8f.5.1753790271000; 
 Tue, 29 Jul 2025 04:57:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b78ba267e3sm4298065f8f.59.2025.07.29.04.57.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 29 Jul 2025 04:57:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: [PULL 3/9] hw/vfio/vfio-migration: Remove unnecessary
 'qemu/typedefs.h' include
Date: Tue, 29 Jul 2025 13:57:28 +0200
Message-ID: <20250729115735.33619-4-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250729115735.33619-1-philmd@linaro.org>
References: <20250729115735.33619-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

"qemu/typedefs.h" is already included by "qemu/osdep.h".

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250708085859.7885-3-philmd@linaro.org>
---
 hw/vfio/vfio-migration-internal.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/vfio/vfio-migration-internal.h b/hw/vfio/vfio-migration-internal.h
index 54141e27e6b..814fbd9ebae 100644
--- a/hw/vfio/vfio-migration-internal.h
+++ b/hw/vfio/vfio-migration-internal.h
@@ -13,7 +13,6 @@
 #include <linux/vfio.h>
 #endif
 
-#include "qemu/typedefs.h"
 #include "qemu/notify.h"
 
 /*
-- 
2.49.0


