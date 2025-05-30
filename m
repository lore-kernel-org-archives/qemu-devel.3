Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E104AC54F30
	for <qemu-devel@archiver.kernel.org>; Fri, 30 May 2025 07:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKtxj-0003vu-BJ; Fri, 30 May 2025 03:15:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwo-0002Ma-G5
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uKtwm-0006z3-U4
 for qemu-devel@nongnu.org; Fri, 30 May 2025 03:14:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748589272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+bI37MK43PqC5txAueHtinB9JgRxEIxzc6ZfMdO0uzg=;
 b=Rys7O56CrmKzCqXO456d0zj2Qb4IRVy+DMMpoQf+DioWkpzfs28fkQnVzO5lGkERnZnU+y
 QnSPIBOClgaOkvh6n3q5tJzCTC4g12vPxrwi8MSZ5/tinySod67M6N7IFNayl9ElZaeKWu
 g1uLsloUAKZtZVKR915ZXp8qLT/KOfg=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-LRVL265RN2W5t4Zrw_iDeg-1; Fri, 30 May 2025 03:14:31 -0400
X-MC-Unique: LRVL265RN2W5t4Zrw_iDeg-1
X-Mimecast-MFC-AGG-ID: LRVL265RN2W5t4Zrw_iDeg_1748589270
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-6023b016d4fso1647406a12.3
 for <qemu-devel@nongnu.org>; Fri, 30 May 2025 00:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748589269; x=1749194069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+bI37MK43PqC5txAueHtinB9JgRxEIxzc6ZfMdO0uzg=;
 b=POIofgCZPuVi6tAAMurEG4eMEjlHnyokdDCEMAG+RqKerkUZisj3wFfQ3rxnvvorHq
 53/XMrYMyTpnVdK4p6EpQPOuMVFSRax3cK/VAbBJNlbwyqLYocoJKPZedR3K0gb02lWD
 WZb4nPPNl9JwUjqDIvatZ2F1bFvHcBj90ldKhUoXNhxXummMRQ+0XppmDndMYKbMOlMH
 0V/XG38f2DXIt01Iwk9l2E11uLJ2GJc95Nhk7tkHbCZdA+FSq+LHXHG63gynsBwBK1da
 xia+oDOJdXplUOkVk6eRF3golZeVUQ0w7F6WaU40Q9mwzdBxOOb6Kc3uNeBpgh+PwvCL
 a10Q==
X-Gm-Message-State: AOJu0YyXIzYFOgDwd7wVzNyrEM9X/R4xC46htTflZHE63aTGS9OwW9Bw
 EMi61P0PiO/zXQt4ZbaPTouXAqAiAJ/4SO4QBkQ8xDPEuzlPM/mLvIVk8IUTx1fhkQC5sh/PSiy
 BZGtEyxDLPfbkwfv2AT+8QAjMmpJfywuVJQLbnL2lUwkRROsLV0ImW2Z+T8a71TGeC07K61W5Vb
 LrztuKpEF8pPOpLlImCcTe7t9IA3Yg734Q/WrEb9C5
X-Gm-Gg: ASbGncsqk4OIQuu9erJh7+jjulaGlkROV0E3GbTH88MIz7H4QKDo1HoKp2XfCOZ+RCW
 O35v5sWIJsg25oi8PcMffBxDiWvsUjbjFMtYZxXvcVLl9roipYmkim7HJD4TbF1Aeg/aj09HZ/g
 EW+PsC4EK2sao/VAVtkC2oBgH0Ub3x2w+rrgBOdzm9qeoV6PoiToM6XM263+/9yQ/0jK4cCj/UK
 5/gZhVGgLWysd458hUIJJmqED338UuKp2gyQ28UVsGij9jnC6ogM3I+rsVk9z6sIBL0zCNK5XRS
 T8DcWcFZFZsNcA==
X-Received: by 2002:a05:6402:2685:b0:5e0:82a0:50dd with SMTP id
 4fb4d7f45d1cf-6056eaff78amr1944032a12.27.1748589268893; 
 Fri, 30 May 2025 00:14:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFc1MiWCJM3rtF4SA+zUtOIwADOzGHi0byP7w3XKVcQ8jnwSaCZWqNdlXYc3gAeuK5uoS4Ywg==
X-Received: by 2002:a05:6402:2685:b0:5e0:82a0:50dd with SMTP id
 4fb4d7f45d1cf-6056eaff78amr1944013a12.27.1748589268520; 
 Fri, 30 May 2025 00:14:28 -0700 (PDT)
Received: from [192.168.122.1] ([151.49.64.79])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60566c2a33csm1188126a12.3.2025.05.30.00.14.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 May 2025 00:14:27 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Xiaoyao Li <xiaoyao.li@intel.com>,
	Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 39/77] i386/tdx: Enable user exit on KVM_HC_MAP_GPA_RANGE
Date: Fri, 30 May 2025 09:12:09 +0200
Message-ID: <20250530071250.2050910-40-pbonzini@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530071250.2050910-1-pbonzini@redhat.com>
References: <20250530071250.2050910-1-pbonzini@redhat.com>
MIME-Version: 1.0
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

KVM translates TDG.VP.VMCALL<MapGPA> to KVM_HC_MAP_GPA_RANGE, and QEMU
needs to enable user exit on KVM_HC_MAP_GPA_RANGE in order to handle the
memory conversion requested by TD guest.

Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250508150002.689633-28-xiaoyao.li@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/tdx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/i386/kvm/tdx.c b/target/i386/kvm/tdx.c
index 287bf7147e1..971f4becfa4 100644
--- a/target/i386/kvm/tdx.c
+++ b/target/i386/kvm/tdx.c
@@ -19,6 +19,8 @@
 #include "system/system.h"
 #include "system/ramblock.h"
 
+#include <linux/kvm_para.h>
+
 #include "hw/i386/e820_memory_layout.h"
 #include "hw/i386/tdvf.h"
 #include "hw/i386/x86.h"
@@ -376,6 +378,11 @@ static int tdx_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
         }
     }
 
+    /* TDX relies on KVM_HC_MAP_GPA_RANGE to handle TDG.VP.VMCALL<MapGPA> */
+    if (!kvm_enable_hypercall(BIT_ULL(KVM_HC_MAP_GPA_RANGE))) {
+        return -EOPNOTSUPP;
+    }
+
     qemu_add_machine_init_done_notifier(&tdx_machine_done_notify);
 
     tdx_guest = tdx;
-- 
2.49.0


