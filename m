Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95366C3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJXT-0003P3-E6; Tue, 06 May 2025 10:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVR-00027J-Jq
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:50 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVP-0002Al-PB
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:49 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cfa7e7f54so35759865e9.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542566; x=1747147366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5dLkOrlPPy6RqMrdEp3suypMzxm+aI7FzNluDE4RITU=;
 b=MxK2lRUPSrsV0Nxj/SWnvmyrnLbHHzmObMNj+wo+FEopXoZtZrdb1oiDLrzk2KeysE
 X7bXfw0gPKoShMY2SDzF+BWk8hUkTgEut64lXQreetdGaVIUUPql+wAp6zIkJs05rCC7
 jD61DGhV0Fj65rLUdG9MATbYqwZhiinZVKtBHnU5kglTd4Kk51/ad2p9tmAIi8ADk/5P
 p2++y/1FCTy+TLVPGq/7tnOoarHOBhrVJEdZcsLKWI8qxaY+Y0h9OiZdGc8g8apjOzaQ
 dYDU+4mKABdZGzve6Y5p+MxUF8EKRBBrxl7d2UOyBvRy/+3s3NA0HeNGrFzKDMEcZWvi
 Iq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542566; x=1747147366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5dLkOrlPPy6RqMrdEp3suypMzxm+aI7FzNluDE4RITU=;
 b=lLiMHLmdFyIZ9Xs0lt1OMbkyvGgFoSV3WsOBWvcPmUt5mxSLkvC3o6FauMr1uXhZLv
 yoXckSde4y+WsYMbf4cbKj1squ3kCrd8DzK7iNYUAmO/FBxo8fVApBdOl3k8wyA/aASY
 69S8KnDEjJxPPeUqeX6fflFpAl5WOPlbo1LDaFCjx77rIR34PqH1iahp+3CN7D4PCACe
 fpoRRMELNgSUfHQbehAxcKJJLqmL5HX44Jr3Ux3COBxEFxPKNJxMjbl/YAVlbzDC5mnr
 QFA0zUwL1zwGuX82RdEbyx2UY0faxzZmSgRb0BMDiIJ3DGqiSShuJzs08R0t2jFPujfG
 faiQ==
X-Gm-Message-State: AOJu0YzjHBMisTUIywkq2n/FsuYmU1fNMsjAlp6aXwXPhXFsJwjkY+rL
 HLgnS8BP/BdB2Z7IKNBeMCg1Qy7wTWOnI4OHnw0aVdm9NGQKGzSRHMleaaStdGX64Ye1OQa58YH
 Z
X-Gm-Gg: ASbGncvSk0oO0fwR4VSU9R3EqTXqz0hBlBgmyzJKbbCbeXrfF3tck6nyJLrOx/OvH8w
 0UEUFGVgMDRzcGZ+X7EYaWPQ/8zprYp/W6NNGlDzZ0CmRwc4yWnqL0a5+H3zt8Djk8AT9RQnRVX
 fTfl9o6lCAjayb9vmVPxTLib8fKbLAKEhClDox+aMT1NqS1u+8Bhmr+21bpKPqXaLIhVEhPg7QY
 XRjuqdlxlwGJApFgodLj4SySHMWZCiKt7afbV4HlHp8rDfbuZBPjK8yJ7m5nYxD9sDD+k7KcH7q
 cRxR4bENmc3bfgVoZic/k0LHDJoH/e1AQjBdpl9nbxSMw4E=
X-Google-Smtp-Source: AGHT+IGvtYQsl3VS9HxbyN20MES1ADFUhMX6SVJhDKVbWx2vFh4KadPHT6vlAxWE5yyJiy+xSyfKMA==
X-Received: by 2002:a05:600c:a10:b0:43b:c6a7:ac60 with SMTP id
 5b1f17b1804b1-441d3a6e29dmr204705e9.10.1746542565965; 
 Tue, 06 May 2025 07:42:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm169603435e9.20.2025.05.06.07.42.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:42:44 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/32] hw/pci-host/designware: Remove unused include
Date: Tue,  6 May 2025 15:42:08 +0100
Message-ID: <20250506144214.1221450-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

The DEFINE_TYPES() macro doesn't need the qemu/module.h include.

Fixes: 13a07eb146c8 ("hw/pci-host/designware: Declare CPU QOM types using DEFINE_TYPES() macro")
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250501183445.2389-2-shentey@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/pci-host/designware.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 183f838392c..b4bff145794 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -20,7 +20,6 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qemu/module.h"
 #include "qemu/log.h"
 #include "qemu/bitops.h"
 #include "hw/pci/msi.h"
-- 
2.43.0


