Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5ACBF588F9
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 16:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wErbO-0004ON-KW; Mon, 20 Apr 2026 12:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1wErb8-0004H5-1Z
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:35:46 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osama.abdelkader@gmail.com>)
 id 1wErb4-0006wK-LA
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 12:35:45 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-43d7605ec91so2996520f8f.3
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 09:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776702941; x=1777307741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FQ1rVK19/qJNkjYfDUfyMPEwbr5/ZW05YHhhFCPJhZc=;
 b=fEvNsz2bxf2YpF0XNA+c33gH/MQoXiZRaf86x6TXMh5lDRC8p0A5R+QxI75adIZNx5
 jnEXA7N6jGRYLMBRPO4efiM/pLpq65unwG6o9ffIXBwDAPlFC/nwflUJFisRb3c5IMrI
 6nwBEWATZCksNqjBCbhTWhbSgDfCB/Ru3drOVHG2eakSIrtgRNQ77FqA0Y/qxDcGIJeD
 /Ebibypip2iYWa52wr3MlnexioMMhlIwUBLQ4YiufeU+C7NPq/dVGXqxi4azvYyymGns
 1YiblLKMybTsRexDakT9AHr1uRu60ZKqIpms5foLVbdkFWxDzDMvVHgEAO+UOQzIFVFq
 mqOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776702941; x=1777307741;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FQ1rVK19/qJNkjYfDUfyMPEwbr5/ZW05YHhhFCPJhZc=;
 b=jJctEeOaNveetRmuahbdWVWGiOREjL59iTKxh1RlkO0Ay0tcILk+bu7XjvED7D83Px
 SNwQSG0pzH3fL+Eip9Qy1I6GhQo/caPzqp73EXj4aNUERfJG1diyv3m1pDS7kRHFqCGw
 WoGm1kkRwEa01A0oCO3wL8PSaz0Aq+J3FHAHHC61UXi5wfEfPw+GXIC2JJOtCopO7s1e
 PmKuQ+P4Cmm626ijr9LFVi8y+l9yCYgeSHHmouSq3/Mi3wUFTnVPqmBAWf9GzJoUvW7m
 bK7Ie1wHD6olaOQS8PSLo4kqGSfIDzcjHFCkg+Ywm2yqzrR0HZhYulGY7szzP9muv2L3
 FSmw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8lD2NorDw2+Qc0cW3iEbKp0fsETt84jgYl7o9hxFLgoVrcraG1Mk8yuLWL5JckoWF6IDUFL4+UYF33@nongnu.org
X-Gm-Message-State: AOJu0YySYvst6YaShlpxi0gyv5MtrfyCgbZKoWf/bW8rApb2Hc5fxLqr
 1uTCUt2ojOcWzT9Pvd4jDb0FgUf/f5zOixtsr887JgYJPDe612NRHe1V
X-Gm-Gg: AeBDietWHUEaqsuagFK5zrt/Fc2H5XrdHwIGw9cAyXMhwsGqAY6B0Pii3ZNZSmUK9DF
 gPYW6jEE76FRo5NqYA6hcZkVlNqXCcUuUoeLmtVDgo8oF2FBm0lXGb9G9/oZaVhpQbdcJ1xkwCQ
 wfrupWhLNL0Ic5OoYV5T8hiHzC3RMUs1x2hVC7Dg2oXQOayX1y6Bbiy77bcXN+bLAwmV0wCGFYk
 Dg29mtQPwwxMc+FSQRrFXzkGmE6l1wHV+emMVSeWT2vr5uz9JmTc4GKHNtfviXJoyr+Xvu4/is3
 iKG7O3qSj1gSxfnvFbYosPGpXtcyA+eDz4Yq2QScxSzz9n6lID/W2NAdTibj+nu7vA1H27vSExP
 FNorJUQ1EEtJRdzo81AiZiAKnvBNrNaVsD7PBCEmjbTDK8fWosab4qiKLd1AJKrCQxpK3bURMnS
 fVrZBSNsWs8lgk2avnHC7hNALlEQc0daHSWCUXO4A0H4bAVKSvl5tIjkK25rlWegcu8ki73cM=
X-Received: by 2002:a5d:4111:0:b0:43f:e43a:f4a6 with SMTP id
 ffacd0b85a97d-43fe43af4ebmr13631375f8f.6.1776702941085; 
 Mon, 20 Apr 2026 09:35:41 -0700 (PDT)
Received: from osama.. ([2a02:908:1b6:8980:1552:6880:e516:62d2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4ffa8sm29782470f8f.35.2026.04.20.09.35.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 09:35:40 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Anthony Krowiak <akrowiak@linux.ibm.com>,
 qemu-devel@nongnu.org (open list:All patches CC here)
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] hw/hyperv: remove duplicate include
Date: Mon, 20 Apr 2026 18:34:53 +0200
Message-ID: <20260420163452.327350-2-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=osama.abdelkader@gmail.com; helo=mail-wr1-x435.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

exec/target_page.h is included twice

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 hw/hyperv/hyperv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/hyperv/hyperv.c b/hw/hyperv/hyperv.c
index a42c2850e3..ffd79fdbf7 100644
--- a/hw/hyperv/hyperv.c
+++ b/hw/hyperv/hyperv.c
@@ -26,7 +26,6 @@
 #include "hw/hyperv/hyperv.h"
 #include "qom/object.h"
 #include "target/i386/kvm/hyperv-proto.h"
-#include "exec/target_page.h"
 
 struct SynICState {
     DeviceState parent_obj;
-- 
2.43.0


