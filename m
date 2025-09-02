Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EF9CA0FFE
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQoz-0006XE-0u; Tue, 02 Sep 2025 09:13:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQou-0006Ll-Kx
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:13:09 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1utQom-0004iE-8u
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:13:07 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3cdfb1ff7aeso2654366f8f.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756818775; x=1757423575; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=CSauTEkJuBQj4RaZCh61biRbjc/d+KfBt7h34CfebkE=;
 b=mw7u2XmWs3VZ/Xyscan6AaKTPUGPF0W9+Mc4BaDW/CG3Cuw+rqmVPNdJWA0ePt4pBq
 AKpmMgdJjo4NKX08l/1bme8Dk/+P3rBCSH+LnEH4KupTQIkKL+M9JALNArG/k8paXjHM
 HPuPDMNpT6qu4TwfGGYUdq21GRsYrtob8cjFhLE5SUKQIA9IEBgd4U5+Ad7Z6GFACkag
 gFe4mVbCimsM/Tkabfr3Yska84XWi486qPU5Axs04EhpLlPnfbh07HMsKiYVfDURNMhS
 E5V+0GTRf2GP2+wxbxKOySgchjz3KL1R+raFx1MXRNSh8LmSFym4Nizk15QXv5aNt/XU
 nb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818775; x=1757423575;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CSauTEkJuBQj4RaZCh61biRbjc/d+KfBt7h34CfebkE=;
 b=KxlRDlz9od8MwscLCiGb2HMZd2DxtQkhOxajSAz1Xt7j/LWTkOqvSDnQY/5YU62sIP
 +BOMKJ3XxtvNlrgB2WW49H1ah6LW3l8netlFj+EV3W0iHsLc7hzVlLLRLe2eKZBjfaqP
 JdAoe6JUIE3i2F9NPL6t3hIcHXssstCaIYSkQkDMaaF6jmnDZNhDdYPMUAgCtE1kkDU4
 cry1M7g3cVkLEMj3jB/FRcijCqsz+efcb/1SduR9G6hTXk1gSTNyhmjWmuJwqmIi41r2
 B700nAic1J0JHj+QuWELCv3ClfxTxCmBAK1zF9Om6KTAPeRA6LaSkz2LO/Jd5XOktd0N
 oaKg==
X-Gm-Message-State: AOJu0YxM3ATkwye7N4wtMFAJEnPS+DYbW5HUZC+kqugYeOXRVi9GP3VB
 55UMMo//cO2A/F2eh1hFudzZSktZm6AG/vzhpAylNteaZpxhrmvR/Hlxl6SvtRWRTFON07+q/U5
 TA0h3
X-Gm-Gg: ASbGncufUlG+EfwRyQYZAAzqoi24bXaaF/RYbb3Ib2yjeE/dLIuXbR+k0nkTLIXCmIR
 M8yG7hDJp7xBq52b56tTP+e60WJPoLkU/XKpURb5kHVgaDqV1X4anG2SE1l7HIo8K5Vk5g3oCfm
 nz+Oqwg6+ySi7xSpCaOkmeXAA20NV4VSRk3pIZ6YFFQYkyE87iLH/OHM2gDXNO62MktYmZ9jXcy
 aNfbYV3iYWTBT6CXKCWvqmq7zWv/oyUBstXyd26mFYKU5/O7kEbk7UTI+W//ApD2KWcYX+2HXmL
 uSAapGikMVDpkSZOmyy0NbDdiFTW0WiLDhJV3zAomdNVsfs7uC79JMC3M012m29SOZ+jN1XiQM8
 KZEzNYw23Kd22OF5s1lbEF/x7aEzUtwHGEmgVKJpL5eBnKkJ6+A/LET020TAyhNZM9nWc3fgNqy
 82NTNHMFo=
X-Google-Smtp-Source: AGHT+IEvwSCvG86AgZ7MCOhkyVCPJ1/Fv3FaTB1LBBmy4D+fzt6U/X5Xz0og05khw27aTIMDYEZA9A==
X-Received: by 2002:a05:6000:18ab:b0:3d6:a2d1:8ea4 with SMTP id
 ffacd0b85a97d-3d6a2d192c0mr4697000f8f.18.1756818775130; 
 Tue, 02 Sep 2025 06:12:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b85090262sm148145725e9.17.2025.09.02.06.12.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 02 Sep 2025 06:12:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/39] hw/isa/superio: Include 'system/system.h'
Date: Tue,  2 Sep 2025 15:10:11 +0200
Message-ID: <20250902131016.84968-35-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131016.84968-1-philmd@linaro.org>
References: <20250902131016.84968-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

From: Cédric Le Goater <clg@redhat.com>

Files using serial_hd() should include 'system/system.h'. Fix that.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20250901064631.530723-3-clg@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/isa/isa-superio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/isa/isa-superio.c b/hw/isa/isa-superio.c
index 2853485977c..941b0f91d75 100644
--- a/hw/isa/isa-superio.c
+++ b/hw/isa/isa-superio.c
@@ -15,6 +15,7 @@
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "system/blockdev.h"
+#include "system/system.h"
 #include "chardev/char.h"
 #include "hw/char/parallel.h"
 #include "hw/block/fdc.h"
-- 
2.51.0


