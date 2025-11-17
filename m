Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6DCCE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 07:44:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKttn-0003fM-8d; Mon, 17 Nov 2025 02:43:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vKttG-0003TF-2t
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 02:43:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vKttD-0005y8-Vi
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 02:43:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763365386;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=th72CWf8N6hC8gTVKCWu4vw/HAFw3p4qEKKo2Ddh4jA=;
 b=NGYbvWhCsAI9L0jKQ6SaEmwKycpNYcKkH/ZNTAyk8ncx1nwKGMIdDp2tZtasr3whzvLMS/
 ZcfALIF1OENnc+7kABmo5uCpV5VnHzEV8nydXRN99S1a/Vk3WOHSEjTCXe1O0IVMSiWVbj
 ryPz14mpDVdOVecgn9m9y5DJixuMlPk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-FDt-3vyEOaWL4jX7bb5Avw-1; Mon, 17 Nov 2025 02:43:02 -0500
X-MC-Unique: FDt-3vyEOaWL4jX7bb5Avw-1
X-Mimecast-MFC-AGG-ID: FDt-3vyEOaWL4jX7bb5Avw_1763365381
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477632ef599so23480845e9.1
 for <qemu-devel@nongnu.org>; Sun, 16 Nov 2025 23:43:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763365380; x=1763970180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=th72CWf8N6hC8gTVKCWu4vw/HAFw3p4qEKKo2Ddh4jA=;
 b=pYsJ0ddx2CSBD7vaBSBhi2HGRC89OVoNdOSxY/4LbQFg9yhEidYLvQzEGWK5X0KMFm
 jteEP7N6Ic6MV8NBkTsclubvKLxu4gmYIH/XboTkmVToV8vWGHkTSTz9vK4p0QTZQ/KA
 emGLhM3ykhoGtZCMDJSp95ZJHnoZSzqZ5gSvBiW186NfrAC7dCrTobLZ4vHjPPGwbtJi
 B9ZOqXaOYRrVRtN+Fgopwedzl8/Ak13YU6ZbjvmPLMgjhZDNkso0LNOawzuyUvT2R3rv
 r0IHXeNGDeOt4bmfYIYfp2jYSmhV41trhLtK6S/8vjvlNEzMtLiO5hn2KNQq/h8EsUV/
 ltoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763365380; x=1763970180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=th72CWf8N6hC8gTVKCWu4vw/HAFw3p4qEKKo2Ddh4jA=;
 b=Kyauu49LMQFBgT7lJIGDOlYw325O2XQfZSG7G9Kwhm/X9Cm7jCfQwT3KQYtzTSahvy
 1MHTTUfs83ksGjEB37vPIXFzaBrajAoqUYZ2lDSa+WJRaXYUr0qp2omsmsC2E0j7unFK
 858J4Cy7wVxOddHYy2wlItBvCMsCOffIqivhUrZoYhf9G6FVm+7YKrAqFBTZZW883krN
 /dbUVdq2U+H+05W5kpuL9pQ5GJHVL4qo09SQhRNCxyxPE+1OYzAGiuGcw/Kpua27Z/qS
 pIn/eilueile3KlGtNY4Zok0uFFtpMklwp+A7FzHdE22fzLhmIXjlgyv65Sp+7qpQpyw
 uaRA==
X-Gm-Message-State: AOJu0YwRG6Z/JELyG2wSN95V74ShA9sY0LfeS4T/tBZ4Rm7oOEygZZ4V
 8Os8MVL3+JK4iMObZamz13ARxLurv4Ug1KO2PGqEfrOTBjXG9DVK9QIbK1cJf/sIdo0caVxRvbI
 VGHfgvEgzMX+vadMvKcFcxKU9I2sC86CMKGNH+2SqBMHrQV4vuH58U43TtD6mc1Mxz0trsYUfQP
 5knHPZpaiR8vzgZLOgwBf8Ic7yYRmgmPq2AvRhcXGC
X-Gm-Gg: ASbGncsY3My1+E6hh8afC3IO2STl4tQIt7A6gkiC8IZSYrpEDOCQQGIOUTyXNC6rAt4
 p5r5Izz9Hmt9bFZa94Dcfo8370nnkaAa+NiF8anwONrLAQQcA8ckA5ValkzVFC6TTgXnUEsugew
 rDBNDkVXgbVWRXX8IXZO00DWqqlzcrLVpFc84wTtKhYQWvo17Z6gaot7kg7zAQyhWcqVEM1Zso5
 Js0Z1XUnqWTECnwyMczZiu+32QNcu0iSAnj3CSNRNUmJV+Z3mDmlgU8S71Lv1mJS29KkRAl1WMi
 D4z/VY/YAZai24nVMrwaTgKNvjL6SMtcUNSMgOQ6Iw+luSVJPdDLzYTpeIFI0hNAyEfll32O/7h
 EAUehNBg86z6iF95aB+bSRCKsObAdpiKEBNvJUONGdbd+G8LdpsBVQOwzD5c0LPgEYBOTc31GI7
 nwGUlW
X-Received: by 2002:a05:600c:1547:b0:45d:5c71:769d with SMTP id
 5b1f17b1804b1-4778fd89eafmr113038945e9.8.1763365380368; 
 Sun, 16 Nov 2025 23:43:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpIl9xgDLkE383VAJ9ZhNOQsCX3Cwn09ubA5rCFcrH2yDYcieS1UXdz18gOFmU8/QqqozFiw==
X-Received: by 2002:a05:600c:1547:b0:45d:5c71:769d with SMTP id
 5b1f17b1804b1-4778fd89eafmr113038675e9.8.1763365379878; 
 Sun, 16 Nov 2025 23:42:59 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4779a2892c8sm118404145e9.1.2025.11.16.23.42.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Nov 2025 23:42:58 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 8/8] qom: add more to the prelude
Date: Mon, 17 Nov 2025 08:42:38 +0100
Message-ID: <20251117074239.190424-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117074239.190424-1-pbonzini@redhat.com>
References: <20251117074239.190424-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 4e983da28b7..32370319871 100644
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
index 68165e89295..c7acf214559 100644
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
2.51.1


