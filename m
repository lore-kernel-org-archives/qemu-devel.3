Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0867C1B0FF
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnekP-000735-Hc; Thu, 27 Feb 2025 09:20:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekK-0006ya-UU
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekH-0003hW-SD
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jtNzr8uYuWTsnD/A8rhDCCpOJ/XgomM+/PA3Y3Q8jKo=;
 b=JgO3DgRpxNo5V0ebeXinozC/Z+J7Dx+mSdAuKT8TfdYBEiaXodXBgZhoULOdRr2ImgDrYd
 jHNPZGD4GLeX5R59jEKU4OMz2CK0/qWIc6EHUn/e3mLSr9w8aLTISI29h1BoBg1gORMrgI
 sbqYHgnikP6MyxC0kCKE6eGxKvtunac=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-425-wmXwe4eWMwq9AtxxpKWsdg-1; Thu, 27 Feb 2025 09:20:10 -0500
X-MC-Unique: wmXwe4eWMwq9AtxxpKWsdg-1
X-Mimecast-MFC-AGG-ID: wmXwe4eWMwq9AtxxpKWsdg_1740666009
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-ab68fbe53a4so151877666b.2
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:20:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666008; x=1741270808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jtNzr8uYuWTsnD/A8rhDCCpOJ/XgomM+/PA3Y3Q8jKo=;
 b=SX1QOI/XBUiO39tofkVtVJaRZXbzDrWuzo65iMeaPbOXQBxm282WmjAp74yV1usCzK
 ro+DN4lIM2bW3YDxADyGzf1tk2XHFA9MkPZyOXOzFNzgbw2lJsIFjWprQEbCI4MYKWyD
 oIi2se4LmM5YWzNlH6AOLN6mknLo4HqN5XrSUG/zjaKUx+5ccWw1MDYLBTINDX4OqIL6
 TUHpDY+NLgI5/2zfCEH7TvyoityuK5IUloD3ONHrk1i9LJr9LkKWloX+XiJfVyrJlWLI
 I1JLz7KEEeDsEmRhIl4tON+iHyNZ0lE01BfnBmZtmK4dOyEWsypUgZdORABE3ud0Cf5/
 4Jkw==
X-Gm-Message-State: AOJu0YzRP/aQsbTGm6juE1e7TH31SdAhz2fnnSQ2yu6dx97gHzfvxUC+
 ZlDybhyLQM8QsXMgll9G0gTjy9F26G6UjTAgCjLd0E4Vqa/h2p/Fi9KtPutNQsyyH0Vq64bqyIf
 bjm1Nh6/eHk0FBZSBlzVLbUF10dyizyusl2QKvdW2nCQTECooqtOvKnBAAWHD3Pry4fgF5GlsBt
 LMxJkhMgIKMJX/CIFHDKDvIbrGPglCg47Sq7XLzOI=
X-Gm-Gg: ASbGncsk2lu3vLEUeE6lSTPd2sgH+AuYleSdsBdtrkFyvdcPJHh4ZmzraCBDhM4VQoJ
 19wk0RSw/ZQ+dyxHKkgLqCf0Fo57z/YFP2OdKWyuLShGslQ5vwemVx3zmqc7djmvB/P2u6Hzqm1
 d7idR9VQwu8hZoyEadMVfTp9frkW+4YjEC18kKLG934lC5101E9PfU8SY6JazjELjhDuYw6cnMw
 eGf0lSrT96PdH9bIVNHZDXn2obwDK5lSr788fikSywm8ykYs/uZkO4hWItyRmYDBO15xYIyiOt8
 yDOecIRL+D9fKjffBFxo
X-Received: by 2002:a17:907:96a1:b0:aa6:8d51:8fdb with SMTP id
 a640c23a62f3a-abed0ce9953mr1269801466b.19.1740666008604; 
 Thu, 27 Feb 2025 06:20:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGPEeMfrnDw4VgOT3FXH1Rjs0vLsCS7hIAjBNG2UWO4gshvoAkn/3UmynDGL+MSsArUqsIQZg==
X-Received: by 2002:a17:907:96a1:b0:aa6:8d51:8fdb with SMTP id
 a640c23a62f3a-abed0ce9953mr1269799266b.19.1740666008132; 
 Thu, 27 Feb 2025 06:20:08 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c7c18a3sm127464566b.185.2025.02.27.06.20.07
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:20:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/34] rust: tests: do not import bindings::*
Date: Thu, 27 Feb 2025 15:19:24 +0100
Message-ID: <20250227141952.811410-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227141952.811410-1-pbonzini@redhat.com>
References: <20250227141952.811410-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
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

Similar to the devices, spell the exact set of C functions that are
called directly.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/tests/tests.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/qemu-api/tests/tests.rs b/rust/qemu-api/tests/tests.rs
index 92dbfb8a0c8..03569e4a44c 100644
--- a/rust/qemu-api/tests/tests.rs
+++ b/rust/qemu-api/tests/tests.rs
@@ -8,13 +8,14 @@
 };
 
 use qemu_api::{
-    bindings::*,
+    bindings::{module_call_init, module_init_type, object_new, object_unref, qdev_prop_bool},
     c_str,
     cell::{self, BqlCell},
     declare_properties, define_property,
     prelude::*,
     qdev::{DeviceClass, DeviceImpl, DeviceState, Property, ResettablePhasesImpl},
     qom::{ClassInitImpl, ObjectImpl, ParentField},
+    sysbus::SysBusDevice,
     vmstate::VMStateDescription,
     zeroable::Zeroable,
 };
-- 
2.48.1


