Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3183C5AD49
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:17:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtyF-000523-Ov; Fri, 30 May 2025 03:16:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxG-0003Ki-VD
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtxF-00071f-BX
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:15:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iKROBqFzDqb8Z3AvlDVZqDNrOLnDrsPoxhuWJmG10r4=;
 b=chdLzyW4m0v6rSgLrhEQ8t6KurFiv/VkHMSha3JarvDgHUTHQm715bh2nwzlq7zuFXOV9J
 eWA/+Re6xWc6K7/qVX7sEa4zVoP3OqtkUeD5dmxaYm3XZOYl14h+aGCotMBPFxzIt+PSv3
 h6l38CNFAEHC+GBeUAQXaM7yXulhJXI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-QWD_DiBCPtq4VW0jEu948Q-1; Fri, 30 May 2025 03:14:59 -0400
X-MC-Unique: QWD_DiBCPtq4VW0jEu948Q-1
X-Mimecast-MFC-AGG-ID: QWD_DiBCPtq4VW0jEu948Q_1748589298
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-6021b8b2ab1so1623329a12.2
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:14:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589297; x=1749194097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iKROBqFzDqb8Z3AvlDVZqDNrOLnDrsPoxhuWJmG10r4=;
 b=YsDDf5e3etlUSO6jxoF5xlDh6xfK+ORquoHRzZOgFfGrNUOXAENZhXx2s+eQzITP8O
 uujZkwYK6J4jHCXS7w15pQZmzmxhWsWiqlhkEPK7tj7d2WBXoIQdpfO51yxLSdrMEXgK
 PnwEvS7Ct7Et/yAH8PksoX0ZonJn/hv6oeYMBjv8EXPlzZ2KdLWpKxMyotIl3M0eLCzd
 RGd8kNr5Koncaqb6BjTKwwd3yhqW4Qg5aAqpjbUYvZSgFv7selPcYeIzbqZqsJNo77mM
 7IWggQTZwI9n4Tascf34Vk6sb2ZQ7Yf547ST+Bmmf+Fi2TIkAG8GnZ4NcDq77DbzRzqz
 7euQ==
X-Gm-Message-State: AOJu0Ywag/jAPFjC1phPKxIfHTjTy7hnmqhjToh9Dv56Dnpxi0wtdUMN
 pZa2gUH3IMQ8NZP1S++NIrukN36BEH8eqdrL86GhdzDGkuvpXKT9zqj6HWx/2z39i7lp8FQ3FPJ
 7yC2iRtMybtAKoXxt3MbASsZm8utarzlVC4eDevEjUVWeCJLAcYe+/Qhe/sE7q9f2SNHT1GYbK8
 kNdkBoLCXW3h70trr4BSBJ3pAi/XKGWFh2TU5tAjtN
X-Gm-Gg: ASbGnctYwOVmuqJ1YTn632XkyKHu1wEsSf7pRXCZA4pAG01hb90+7KiSmBVBwEFZ5BP
 abWWCDyK44Y2G+ocH2HZMospPvjbCR6D7DQAwZBXst+Ua/grLVqG8exNP6XvazrAv/QHajnq3Ov
 WJ9IIkYdJBctKpeuuZgSKohf/Z8BP96YACikuZSk4qrTTLHrtYSh5vIatngPiV/9e9mouemGP4x
 MS3h5jxlzwhkw2BlZ0JnLfS9m4woP5hYvy79GYYw5I8sXr+8BuziPaVp8ZsncSr2Jsy9TNi0uSX
 tuvPLPwA/g6TFEvSagt+wWIG
X-Received: by 2002:a05:6402:2353:b0:5f8:504a:88d5 with SMTP id
 4fb4d7f45d1cf-6056db0ec69mr1978497a12.7.1748589297156; 
 Fri, 30 May 2025 00:14:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYOgHaMtG6sO+2ua4J7orUgKtsF2mPnRId40CUtBT2VYdcXkGsAF7+e9NN87RzVrBuK3B2JQ==
X-Received: by 2002:a05:6402:2353:b0:5f8:504a:88d5 with SMTP id
 4fb4d7f45d1cf-6056db0ec69mr1978470a12.7.1748589296734; 
 Fri, 30 May 2025 00:14:56 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60566c5a758sm1191241a12.19.2025.05.30.00.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:14:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 50/77] i386/tdx: Set and check kernel_irqchip mode for TDX
Date: Fri, 30 May 2025 09:12:20 +0200
Message-ID: <20250530071250.2050910-51-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.902,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Xiaoyao Li <xiaoyao.li@intel.com>

KVM mandates kernel_irqchip to be split mode.

Set it to split mode automatically when users don't provide an explicit
value, otherwise check it to be the split mode.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-39-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 32c3f3795d0..68ed3b9f987 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -16,6 +16,7 @@
 #include "qapi/error.h"
 #include "qom/object_interfaces.h"
 #include "crypto/hash.h"
+#include "system/kvm_int.h"
 #include "system/runstate.h"
 #include "system/system.h"
 #include "system/ramblock.h"
@@ -388,6 +389,13 @@ static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         return -EINVAL;
     }
 
+    if (kvm_state->kernel_irqchip_split == ON_OFF_AUTO_AUTO) {
+        kvm_state->kernel_irqchip_split = ON_OFF_AUTO_ON;
+    } else if (kvm_state->kernel_irqchip_split != ON_OFF_AUTO_ON) {
+        error_setg(errp, "TDX VM requires kernel_irqchip to be split");
+        return -EINVAL;
+    }
+
     if (!tdx_caps) {
         r = get_tdx_capabilities(errp);
         if (r) {
-- 
2.49.0


