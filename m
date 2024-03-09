Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A25EC54E60
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 19:31:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj2Iv-0003Rz-Uv; Sat, 09 Mar 2024 14:24:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2Iu-0003Ki-Hv
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:24:20 -0500
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rj2Ir-0002lL-R5
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 14:24:20 -0500
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a293f2280c7so503146466b.1
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 11:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710012256; x=1710617056; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=97WMuYDRb3w8xARFK/GrtRAFlIvridMB6pm6DUjdKys=;
 b=RW1+ZiNnMgLzrLGBaoUUPSwngxaNdd3W+WXdEhzOXZOWCy+yZcdobHSaXJ+zldWyTS
 oGaMmb3fGBcRz0r8bZEFWshEt5SaC3h8hCe3P12d6WDYKfm4CmO+DvdYHSxoZCyHxlxh
 w3QLC/LTMKMwc0nmImY0x6A28KOL49ikbvt7PZYYfNzKQ9Y/jxAFblXggbQnGWMvF18R
 N1s/58tvUAU0pi4GiOMGpus95CSRR0lH7Vyfg+dtubUjISF+dzPZEHJUAUZXssAhE40o
 44v7ffVBpilwvuoRwMnOf2mBdV6ECRduBL1w4aHZFyio1NXPU6CxLgH0MwuHbV+LkGXH
 mRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710012256; x=1710617056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=97WMuYDRb3w8xARFK/GrtRAFlIvridMB6pm6DUjdKys=;
 b=nyAYjVtqXijPiJC0AqRlthce9uJhPAbhFETSOYSkenhjpoZrr6//6RSXGruvGXY7RY
 A/T0r8k7Viha1IWcwaNeYIzMoUBS/EvSADkDIfc80iN/IiUdcZT2xVgIhTEAOaCduJ6X
 ZkXsXoH22Y7n5ezU6yH6t7AMeIzwNbOeT8fRDO41+UpyHhwLgaJP1S7KEUcr/mEf35Nq
 4rCFr0G7TyUQsR6lcOo6xC9TMzSeSq0B2cMPjIAfINSqs+X8bpqu7F36TUWV/K+NHGif
 4PNNP9Bq2mJU19G5CNJRRxFK9DcdtTSCbLm05Y0gEMzLu5Vl9213qIdj4FFF5cs0zfHC
 Uykg==
X-Gm-Message-State: AOJu0YyvIssTxKA1dX6WiCGyPjfEX+gbm/Y3lE0aAoUqgEQi6JhPuEP4
 fg/X0XDKh8a2ejUTyn+QOTJjRG5L4m8XgOSs1wxLYHF0onZP2GSdsZUmCwj/Q9VuF82j9F5aPJC
 8
X-Google-Smtp-Source: AGHT+IHu5x1rS7vf33hD/x5FbZhOzPD/xRWv1qGkw9cFC8XfZuY6JIqWN/Q1RZ95WsBkgIm3l4ycIw==
X-Received: by 2002:a17:906:ba87:b0:a45:f262:bc2f with SMTP id
 cu7-20020a170906ba8700b00a45f262bc2fmr1624704ejd.5.1710012256103; 
 Sat, 09 Mar 2024 11:24:16 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 l23-20020a170906a41700b00a440ec600e3sm1176464ejz.121.2024.03.09.11.24.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 09 Mar 2024 11:24:15 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 20/43] hw/i386/pc: Use generated NotifyVmexitOption_str()
Date: Sat,  9 Mar 2024 20:21:47 +0100
Message-ID: <20240309192213.23420-21-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240309192213.23420-1-philmd@linaro.org>
References: <20240309192213.23420-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x635.google.com
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

NotifyVmexitOption_str() is QAPI-generated in
"qapi/qapi-types-run-state.h", which "sysemu/runstate.h"
already includes.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240301185936.95175-3-philmd@linaro.org>
---
 hw/i386/pc_piix.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index e123458bbc..ed777e3d61 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -61,6 +61,7 @@
 #include "hw/xen/xen.h"
 #include "migration/global_state.h"
 #include "migration/misc.h"
+#include "sysemu/runstate.h"
 #include "sysemu/numa.h"
 #include "hw/hyperv/vmbus-bridge.h"
 #include "hw/mem/nvdimm.h"
@@ -383,9 +384,6 @@ static const QEnumLookup PCSouthBridgeOption_lookup = {
     .size = PC_SOUTH_BRIDGE_OPTION_MAX
 };
 
-#define NotifyVmexitOption_str(val) \
-    qapi_enum_lookup(&NotifyVmexitOption_lookup, (val))
-
 static int pc_get_south_bridge(Object *obj, Error **errp)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
-- 
2.41.0


