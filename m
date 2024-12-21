Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE5AE7718B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Dec 2024 19:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tP53n-0002Rg-3F; Sat, 21 Dec 2024 14:22:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tP53l-0002RI-PY
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 14:22:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tP53k-0000Ms-B8
 for qemu-devel@nongnu.org; Sat, 21 Dec 2024 14:22:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734808963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u6rrgRHxwZkzjvI/Y0EExDevggaj96UfW/Jubye9t9k=;
 b=CoqbjmIDn0Ccu32sxJItjdt2YH6aF8tad1unJP7GNtaUTAUnImnXBNGEPq15vCejQtclEF
 yu+cE4vMfUknhIwf95RwQrVTKFMoM3oaRVWLOkxNyg1wbdxcuIvP8DmtbkiHRa/SwJZz2y
 v+FgIK0wfxqqq/OaETKBhNSaXhTWcUY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-OChuXYVpOYu11dhIyosEpA-1; Sat, 21 Dec 2024 14:22:41 -0500
X-MC-Unique: OChuXYVpOYu11dhIyosEpA-1
X-Mimecast-MFC-AGG-ID: OChuXYVpOYu11dhIyosEpA
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4361f371908so22496825e9.0
 for <qemu-devel@nongnu.org>; Sat, 21 Dec 2024 11:22:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734808960; x=1735413760;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u6rrgRHxwZkzjvI/Y0EExDevggaj96UfW/Jubye9t9k=;
 b=YMB9G/sZnGgjqqF3kwQwTGEgpXFTsIWbk+jOyZ6P+/CP6M7DKs2gdXGL1+L6seH5RL
 h7bW/KFtNYAabfjsey4kwSj4+cOEyaJvBP5sVjDia8E0oCM/H/lNwzn0AmVBgIqdBrsY
 9X0+Ia82/Wl8roZg24KN82GzcS49njUVjJXO/cSjK7LK4DbE1nAru/v6VXvIT2rVs389
 uSnHiztGMi3JIkZ2uWTdqTc/KG4TzuCZWbE1kbte3hZOFVKF6TspBGaQt3Rmx5DfJtWO
 HSKfAv5zEIq7zjV1IjtwCsiu6jkCLWIMq0RHgWvjkDHAmsYZGI9aEW/3Jx1O8T3Om5tJ
 cuCw==
X-Gm-Message-State: AOJu0YyZgxPBVGFXt/o4WfG4vZ9lmZHy+eHCBWuiO53BqaMi30bCaJYE
 CXlzDJGwJEFwCwMV7f4zG6ksmh/1ZGWGkUhYuwJFPwcw2bYMZroTuHcTY8vz+w0vSyRvMCLdd2B
 yANMz6pxunKPs2uDaAH8J+L2jqWsCdWteZHNwjALRb7v3zMOxsbAlSI6W++w1q/CwW2e+u3MIfz
 zqTJdEuVsBqgHxk71Rc8F2maMfc72IENtq
X-Gm-Gg: ASbGncuiDWvLPJvVW89lrLj8OrhJfgPqO+VoUHosgKdqrJe7RCA12OSVj3S3qjFsHsC
 JUBJyuZUAfg489KWpJuPhMUFSFZhRfYvLLzNdbVTtE6i4eFOiUoTrsddHmVCNi3OzrOxI4n+dQF
 fx7v/i8EIlhgFPxVZRSXXtRTCeocop/WmiQyELVQYLaJXCOtmcDCkYVcGprTyxDwShaNl8xplB1
 lNB0BsxtUY0myI/9WKRK2iqeDJKDqyM59OlHTxNdzZiSw7vYmGG3cEMp51TaZQ4dazAyRft11IU
 Uv9+qFxpXqspfpBpjbdQ9T2Vt7pKiM4spwhMIiE=
X-Received: by 2002:a05:6000:1fab:b0:385:e30a:394e with SMTP id
 ffacd0b85a97d-38a221e2066mr7861463f8f.3.1734808960365; 
 Sat, 21 Dec 2024 11:22:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEmSpL9UWbBBDCBUCB8hkorKZlp78VrUrwmqJfQKpsOAOh28AyZLh5KVQatADM8CjDNaqq1Tw==
X-Received: by 2002:a05:6000:1fab:b0:385:e30a:394e with SMTP id
 ffacd0b85a97d-38a221e2066mr7861449f8f.3.1734808959976; 
 Sat, 21 Dec 2024 11:22:39 -0800 (PST)
Received: from localhost
 (p200300cbc7137800820d0e9f08ce52bd.dip0.t-ipconnect.de.
 [2003:cb:c713:7800:820d:e9f:8ce:52bd])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4364b0566f1sm108795275e9.2.2024.12.21.11.22.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Dec 2024 11:22:38 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL v2 10/15] s390x/s390-skeys: prepare for memory devices
Date: Sat, 21 Dec 2024 20:22:04 +0100
Message-ID: <20241221192209.3979595-11-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241221192209.3979595-1-david@redhat.com>
References: <20241221192209.3979595-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.177,
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

With memory devices, we will have storage keys for memory that
exceeds the initial ram size.

The TODO already states that current handling is subopimal,
but we won't worry about improving that (TCG-only) thing for now.

Message-ID: <20241219144115.2820241-10-david@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-skeys.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 6d0a47ed73..6ea4d8c20e 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -11,7 +11,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/units.h"
-#include "hw/boards.h"
+#include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/qdev-properties.h"
 #include "hw/s390x/storage-keys.h"
 #include "qapi/error.h"
@@ -251,9 +251,9 @@ static bool qemu_s390_enable_skeys(S390SKeysState *ss)
      *    g_once_init_enter() is good enough.
      */
     if (g_once_init_enter(&initialized)) {
-        MachineState *machine = MACHINE(qdev_get_machine());
+        S390CcwMachineState *s390ms = S390_CCW_MACHINE(qdev_get_machine());
 
-        skeys->key_count = machine->ram_size / TARGET_PAGE_SIZE;
+        skeys->key_count = s390_get_memory_limit(s390ms) / TARGET_PAGE_SIZE;
         skeys->keydata = g_malloc0(skeys->key_count);
         g_once_init_leave(&initialized, 1);
     }
-- 
2.47.1


