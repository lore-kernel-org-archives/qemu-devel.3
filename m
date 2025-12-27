Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9E2E8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:26:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQQr-0005NE-3X; Sat, 27 Dec 2025 04:17:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQq-0005ME-D1
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQo-0003JI-Gy
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827069;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BcYiSMPHRhr9NPTHybSXLlaJL+NoJQyoxLhUprtUz0k=;
 b=RlcVOtRruyuO9h7fzSb8w6OXfQgBN0iz8MlYJTgw3pSxKdDGfWtIWlLHgmWP3TUqQk4kAx
 5ndCHTft4DmV60v7YRPmcXfvDinnh+LSeFua+sxfEqTBAeIVBuyDqXIeTMkXB/L21WmZgX
 UZHVgqlBc18qkvEO+1znCvnXejGunOE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-nCbtgSXXO2yxqCbDMdlp8g-1; Sat, 27 Dec 2025 04:17:48 -0500
X-MC-Unique: nCbtgSXXO2yxqCbDMdlp8g-1
X-Mimecast-MFC-AGG-ID: nCbtgSXXO2yxqCbDMdlp8g_1766827067
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4779b3749a8so54867785e9.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827066; x=1767431866; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BcYiSMPHRhr9NPTHybSXLlaJL+NoJQyoxLhUprtUz0k=;
 b=DSBru235IAE0E5F5je+x1y9V+N6nSH5RtqhIwshWjZPyFW24tTXReJfxANCqL0Z3pe
 lMUtAqb+wdMCTjzqAL2jYuiEKI1TtJznjWBOiAxVOBitfYwWRzuYNONdvYszxnXKMag+
 hl1WaAysRxi4LKddMyEj4vwy4/uix9flVVSRbvnQO5ezksvujBO+s77moblIwjJ+3C76
 lcl7LzFom8wDF7jd03wWQYGtsGay/xoftG9DlsgenOpkiFierZY1mLX6H2Mv41q1uvE+
 aq/WFZS12hPQmnvtmGAOI61QZVpHSPjk9WIxvPNvdRzHzOkyzDARfz5i32hk+1bqic7F
 K7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827066; x=1767431866;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BcYiSMPHRhr9NPTHybSXLlaJL+NoJQyoxLhUprtUz0k=;
 b=pFejA4MOTPFfV19Xkf7jIabw+FaZFDrs0m1/43gzZ72aEQ+nM/+vnRtqBgixI/4F5a
 PYfynNK8s9ryarmSQDfSxfjG1e8ae5L9l2e4jzrlUxGeYZHKVSH4n48G+/DOmMDzl5yA
 N5Naay1pgSHjkTxS8Hi0MMNSSqccNdOpY0EpYkax7/ynO+ldGp6KFNp8jAhtqciW0k9f
 nC1dxPt/vKHj+8za8lilk/a5peHMngMgtB1dUssle0LU6DWnE8kz7gddDOwv3KxVenk+
 al542Jj1kwqU+qylwGqkWM02n/+5wU+QOoxUF3FJumiSTcZYuJsSXYvpi5J4OqBQq2TM
 IrfQ==
X-Gm-Message-State: AOJu0Yx7cE2Da3QJqUCJBgQ6PTXS7PTdOy2YlSTBt9JcAOl/b/qAiKuQ
 6BoF3OrozrlemC7stUEIbAR1V4mYaERD3v22Uxy/fVnseGH3kgSVj9ajRPECt6RrBisxzdDxkZi
 mR6pnkvoOgYPz8PABXxgtMv9+8SLrVX0fSYr8SDFF1o6MBuRpBmUh5pp5a3+TGT4Srseqxx9uwE
 UJ8Ru/3tINulDFzPtR2VdJ00Jw4VrvkkBxNd+MvH9C
X-Gm-Gg: AY/fxX6YtUOMRkfLdMI5klNwZGObWyKLgmLTCmvpL3SdyQHITwHTm949X7tpqYrrSFF
 k1Xkzmv9OYWgHpgKdEi31RNnv/OloOrO+rhnI+jaq1g3Njyi8c8CyTRwQZM7aZB4YKrPkRmiT9X
 ssdst/E+drbtneoc1FyIwZOfKrGoKU2rQQK1n07Cn7nIwbmgQjdDwAzpMejJEqC+7pbY431MB+1
 rgNYsmv7YHBtXbiC1v81oqwT5c45pa5aH0bvF2gch2F/OPMBA0+e/SbdyJ7z3g4MSDeyQKph6Do
 SZM+Mp+VnVDIg6RAw11BoDwv1qhj+d0LONgTbvr3Rhk1sB7n4SWQjn1NBBfG4gqFZS+34ORJWcS
 RLjl7nzLtixlDqH8f/W4Zm7TTc/hh5rIjf27mc6rUWSPAQTpCHy9QIEQjl1iX/wYY74FPPHvBiG
 rO7HBjIQKC7X0egiU=
X-Received: by 2002:a05:600c:350b:b0:471:1774:3003 with SMTP id
 5b1f17b1804b1-47d1958ef07mr248776275e9.29.1766827066321; 
 Sat, 27 Dec 2025 01:17:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxcCvVmVgGt9VmZPiK/W01YxArFV57JKA7voZorMIDY+l6m815+h1YITbidc/sUZwGKmKN/Q==
X-Received: by 2002:a05:600c:350b:b0:471:1774:3003 with SMTP id
 5b1f17b1804b1-47d1958ef07mr248775995e9.29.1766827065826; 
 Sat, 27 Dec 2025 01:17:45 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d193cba81sm426726835e9.10.2025.12.27.01.17.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:17:45 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 044/153] qom: add more to the prelude
Date: Sat, 27 Dec 2025 10:14:31 +0100
Message-ID: <20251227091622.20725-45-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/src/device.rs | 2 +-
 rust/hw/core/src/qdev.rs         | 2 +-
 rust/hw/core/src/sysbus.rs       | 2 +-
 rust/hw/core/tests/tests.rs      | 2 +-
 rust/hw/timer/hpet/src/device.rs | 2 +-
 rust/qom/src/prelude.rs          | 4 ++++
 6 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/rust/hw/char/pl011/src/device.rs b/rust/hw/char/pl011/src/device.rs
index 0b1bb2d5a3b..9f5c4a34df0 100644
--- a/rust/hw/char/pl011/src/device.rs
+++ b/rust/hw/char/pl011/src/device.rs
@@ -9,7 +9,7 @@
 use common::prelude::*;
 use hwcore::{prelude::*, ClockEvent, IRQState};
 use migration::{self, prelude::*};
-use qom::{prelude::*, ObjectImpl, Owned, ParentField, ParentInit};
+use qom::prelude::*;
 use system::prelude::*;
 use util::prelude::*;
 
diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
index c2ca17f6ce0..87232becbad 100644
--- a/rust/hw/core/src/qdev.rs
+++ b/rust/hw/core/src/qdev.rs
@@ -12,7 +12,7 @@
 use chardev::Chardev;
 use common::{callbacks::FnCall, Opaque};
 use migration::{impl_vmstate_c_struct, VMStateDescription};
-use qom::{prelude::*, ObjectClass, ObjectImpl, Owned, ParentInit};
+use qom::{prelude::*, ObjectClass};
 use util::{Error, Result};
 
 pub use crate::bindings::{ClockEvent, DeviceClass, Property, ResetType};
diff --git a/rust/hw/core/src/sysbus.rs b/rust/hw/core/src/sysbus.rs
index ec620639be5..071fccff1e6 100644
--- a/rust/hw/core/src/sysbus.rs
+++ b/rust/hw/core/src/sysbus.rs
@@ -8,7 +8,7 @@
 
 pub use bindings::SysBusDeviceClass;
 use common::Opaque;
-use qom::{prelude::*, Owned};
+use qom::prelude::*;
 use system::MemoryRegion;
 use util::{Error, Result};
 
diff --git a/rust/hw/core/tests/tests.rs b/rust/hw/core/tests/tests.rs
index e60c9d018f5..115dd7a860d 100644
--- a/rust/hw/core/tests/tests.rs
+++ b/rust/hw/core/tests/tests.rs
@@ -7,7 +7,7 @@
 use bql::prelude::*;
 use hwcore::prelude::*;
 use migration::prelude::*;
-use qom::{prelude::*, ObjectImpl, ParentField};
+use qom::prelude::*;
 use util::bindings::{module_call_init, module_init_type};
 
 // Test that macros can compile.
diff --git a/rust/hw/timer/hpet/src/device.rs b/rust/hw/timer/hpet/src/device.rs
index c5cdb87b073..c82b27ddf15 100644
--- a/rust/hw/timer/hpet/src/device.rs
+++ b/rust/hw/timer/hpet/src/device.rs
@@ -14,7 +14,7 @@
 use common::prelude::*;
 use hwcore::prelude::*;
 use migration::{self, prelude::*};
-use qom::{prelude::*, ObjectImpl, ParentField, ParentInit};
+use qom::prelude::*;
 use system::{
     bindings::{address_space_memory, address_space_stl_le},
     MEMTXATTRS_UNSPECIFIED,
diff --git a/rust/qom/src/prelude.rs b/rust/qom/src/prelude.rs
index 00a60959771..6a1ecaef2a7 100644
--- a/rust/qom/src/prelude.rs
+++ b/rust/qom/src/prelude.rs
@@ -6,7 +6,11 @@
 pub use crate::qom::ObjectCast;
 pub use crate::qom::ObjectClassMethods;
 pub use crate::qom::ObjectDeref;
+pub use crate::qom::ObjectImpl;
 pub use crate::qom::ObjectMethods;
 pub use crate::qom::ObjectType;
+pub use crate::qom::Owned;
+pub use crate::qom::ParentField;
+pub use crate::qom::ParentInit;
 
 pub use crate::qom_isa;
-- 
2.52.0


