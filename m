Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657C7C54E6E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 08:24:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjxQc-0006sk-8x; Tue, 12 Mar 2024 04:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxQH-0006fe-8m
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:23:47 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjxQE-0001EV-4U
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 04:23:45 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41342849a15so1418175e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 01:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710231820; x=1710836620; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kBwjgCbKhXeLtpORHnsvbw0J9Mzl7MSsZnlOxv2Y6SQ=;
 b=fSs6qo0GFAkMGB2bmquhsIJCIKlQ/JxQuCNk2gDul700mC6BlkRhybHda4s4OUUpj2
 xCN3jsP7xefOko3NNUcO09csX8dQuGxbUBS5Ih4swfRV+oktVTIygn/2I6KnCwgxJy9P
 Xj/CotK5P2lSMpE17ycZ1NA9K1tB4dqEQbkEHweXuVJWr0rX1Zwvx+mfX/+7ulJ7KJMp
 wG/ZcUhxIrrAG5AaxF4FxHDXODrCyuDYxdMkhKlSxvgDEHHex+4X7z0zAXDmP2me/8sg
 F54CHTPtDwPsazrGG2m4QrVtsDccCrAH7MvTXQJZxlabDZzrmbqfg+IBpwW30hv4A9c5
 vPhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710231820; x=1710836620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kBwjgCbKhXeLtpORHnsvbw0J9Mzl7MSsZnlOxv2Y6SQ=;
 b=ltRRbpdrT6PnIROK+XKtIDJzLUE3EFdGZ+Gyzgl58pCg0F1fRKVqTYYefYdrWl8fm/
 CI205AcqKFcCX824YEnw+9xuOtJVF2RnOlKWQiKOyixt8tyfFRE2iutlQw4/LeqfEqiq
 nA+CSIHGBiFTe9W3VwmtVWxhvuW0iErxKEc26T9XtIXVkWud+1eFXeRMBdelB33U8FdI
 km4qQvDpOlmDsS2tAdo7ZxhN7btyQrh6m4kvPr6g/MnpSDDMSv9xwLniqyuyVlHNE2w/
 gGiLuMyqxSQiAMwEQc4t6w/61vuIId4H+xhZwFuwFBE72rCR9m5xrMPrSK+pOOCBc+L1
 jvsw==
X-Gm-Message-State: AOJu0YxNCkabSyP3lTxHjQwYUXf2BgwoGtCI3uIdPIiS0EivqSU7oKf4
 twyHygBp3OE1KMnbjbb7DWAEOAyj5/ENIytKXEKaOw8KKnea+J3EoIw8C4ifsFIuTuNqy1ZsHYR
 V
X-Google-Smtp-Source: AGHT+IFKMPz742VVxfOXPDOCyls5ivetWrL3C+e6jIArHI8sLt4W+63N1BHtF6w734LprexC/BLouw==
X-Received: by 2002:a05:600c:5253:b0:413:166e:ad51 with SMTP id
 fc19-20020a05600c525300b00413166ead51mr6524890wmb.2.1710231819983; 
 Tue, 12 Mar 2024 01:23:39 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.139])
 by smtp.gmail.com with ESMTPSA id
 ea13-20020a05600c674d00b004132ae838absm5185974wmb.43.2024.03.12.01.23.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Mar 2024 01:23:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Subject: [PULL 09/13] hw/core: Cleanup unused included header in
 machine-qmp-cmds.c
Date: Tue, 12 Mar 2024 09:22:34 +0100
Message-ID: <20240312082239.69696-10-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240312082239.69696-1-philmd@linaro.org>
References: <20240312082239.69696-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Zhao Liu <zhao1.liu@intel.com>

Remove unused header (qemu/main-loop.h) in machine-qmp-cmds.c.

Tested by "./configure" and then "make".

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240311075621.3224684-3-zhao1.liu@linux.intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/core/machine-qmp-cmds.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 3860a50c3b..4b72009cd3 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -19,7 +19,6 @@
 #include "qapi/qmp/qobject.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/type-helpers.h"
-#include "qemu/main-loop.h"
 #include "qemu/uuid.h"
 #include "qom/qom-qobject.h"
 #include "sysemu/hostmem.h"
-- 
2.41.0


