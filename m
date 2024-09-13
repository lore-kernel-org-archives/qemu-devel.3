Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B922FA375A
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 15:20:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sp815-0005d1-Rt; Fri, 13 Sep 2024 11:15:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp80E-0002PJ-5g
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:31 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sp80C-0007pP-8T
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 11:14:29 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-42cb6f3a5bcso13906095e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 08:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726240467; x=1726845267; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Fude+uQBvTUC4WQt1NMV57c6fElhXstVxcGWa2blBAU=;
 b=t45f7JXqcJSIawSKF81+g0Kxls+omxPJg6k/KPkpjfLwqWidPSHPI2N73GTGxTpVig
 yw2F1TFrYhfnoKDBrCEiThdRh0GlKBcZ4H5wWTdOSsHk358IbFEa7QXe8C7CAKInxE3o
 fqv/AbIIGOiAe4jqiQGHnSd+f3DQX3NTlnNdi6lrkIEDMQZVGnuwA9J/p8y50Vt8HveL
 VBZZCH9YAMvoMkMN9bLjcT2SbC5OOCUy7+qPkl8XdiKAjuMucw6OMnuUL98SYhHSWWTY
 WRtyZRJZXDxs3E9sfgJNnZwEnho3Kv7mUtujKrNpZhNCUbl6yoLsn/0Q6XpZLz4v7KMH
 kwOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726240467; x=1726845267;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fude+uQBvTUC4WQt1NMV57c6fElhXstVxcGWa2blBAU=;
 b=H7SOD2FWLgIaKq6WVpEc3Fx5xcwVz+PdH343X0/vFRYeL0+WB8HOrlCnO8bAF4Xahh
 ZOoSDBj1cLjia7ijPnn0FX5R3FBfvExZyMwhMYORVf2f9URxgEs4CnvJ2skOQ5NxuKTk
 XX5LAmhREpeKl8WzOhoiiZq/F9Ym028aUSnQlQGy/qrTM1tW5uGD5ElG0s0nKmNMWtJ0
 nvOFAIIRiEf9XWZmB3VV/5tfgukTlD6yp8ddgJRqsQfAOm+tSHNz37NapmD3U8S9Zh8o
 cSJIeZPjpnz254LfMIua9WAipeKmgLqjz0yStahvCkYRHKsYr+4TrfqBektxLix3662V
 HNrw==
X-Gm-Message-State: AOJu0YzERP/CljAKEIrg1skCauj90FvD96clPVijczzRNLTGHAYES/nF
 f0jIfcrKU9a8GEFuCQX5R+JrB7a61bK6b3tM7qC1sGnjZBkQEKiGFqcVMB+wx1OwJQ+ZYD/lQ6X
 e
X-Google-Smtp-Source: AGHT+IG5uyABQnJRg8IN+dRjrtngQJQTWqFKcRcEpKWPTLvh2/xBNuobPA6+1ay+6yOgB7DuKuXJ+g==
X-Received: by 2002:a05:600c:1c9a:b0:42c:b187:bdd5 with SMTP id
 5b1f17b1804b1-42d964d6625mr33684025e9.22.1726240466690; 
 Fri, 13 Sep 2024 08:14:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42d9b16bfbfsm29152325e9.22.2024.09.13.08.14.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Sep 2024 08:14:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/27] MAINTAINERS: Update Xilinx Versal OSPI maintainer's
 email address
Date: Fri, 13 Sep 2024 16:14:09 +0100
Message-Id: <20240913151411.2167922-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240913151411.2167922-1-peter.maydell@linaro.org>
References: <20240913151411.2167922-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: Francisco Iglesias <francisco.iglesias@amd.com>

Update my xilinx.com email address to my amd.com address.

Signed-off-by: Francisco Iglesias <francisco.iglesias@amd.com>
Message-id: 20240906181645.40359-3-francisco.iglesias@amd.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8be4f524779..b9812d46525 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1058,7 +1058,7 @@ F: include/hw/display/dpcd.h
 F: docs/system/arm/xlnx-versal-virt.rst
 
 Xilinx Versal OSPI
-M: Francisco Iglesias <francisco.iglesias@xilinx.com>
+M: Francisco Iglesias <francisco.iglesias@amd.com>
 S: Maintained
 F: hw/ssi/xlnx-versal-ospi.c
 F: include/hw/ssi/xlnx-versal-ospi.h
-- 
2.34.1


