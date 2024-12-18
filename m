Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DFEE77188
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 10:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNrhy-0000ni-1M; Wed, 18 Dec 2024 05:55:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tNrhq-0000mc-C0
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:55:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dhildenb@redhat.com>)
 id 1tNrhn-0006tQ-IP
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 05:55:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734519302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oIdN8k8UxbFd6pPRixbwE/O/YwzOJXLRbaptlMiUIjU=;
 b=NbyIgxAVjLEF/wQ4Zz9LDxOqnGPTJu3Z4ucqzWsokVcXuPLr1cAHzjXMMGu7poGOZ6c21w
 ux4Ni+7wO+zuGCtrsNg3W9V6F5CKRmnB8hiaSK5NsSWlXb54ktwV5SEn9KWh4J/Yr7XjMN
 WIB0FMvTxh08J/kw8WMmaE3+VWgZv7E=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-d7gGxEt9M_e9Uyu4uj30mw-1; Wed, 18 Dec 2024 05:53:32 -0500
X-MC-Unique: d7gGxEt9M_e9Uyu4uj30mw-1
X-Mimecast-MFC-AGG-ID: d7gGxEt9M_e9Uyu4uj30mw
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-385e1339790so3726881f8f.2
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 02:53:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734519211; x=1735124011;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oIdN8k8UxbFd6pPRixbwE/O/YwzOJXLRbaptlMiUIjU=;
 b=V/alYQzWgbMKD3NLVFQ6SPyCsZylCLGVTEcs1tO1m1UPWfobisOVapl0FhM0TXrbJu
 guk/Nc07nXB+kbA/5iaDP7cNMrbkYX+1yKMiMX7MyChTQ/qnow40F/4LEPfz+Q7/tqEq
 V5RC9xmvbaupnBGbohZRBEDdHeoxRjXAd1Sx0pH1Ni8ck5BosjYQojHYGgQRHfkBnGv2
 5/y1pn5uYUoybtexW+K/dsL0uAkMiUgs92O/eoyQUXIRAmyL9NdKgVz9+H1ScPcvWYcc
 +Oe9tUVCr8P/iBQmAp9ZUTsEddpzKqA/cN85ojjBpLTIu38P+XnwS5on42DT75mdph15
 4SDg==
X-Gm-Message-State: AOJu0YweWY/BzElI5CGxJ+bF6aQZa4mpI5vwHmY7z65T7j6iZ0wVFH00
 qz+zyi9EfAXWaIUWojfrG1iXi7LwMnSkPmoZZpJCYK6ENKinzW+H/kwLOATLcjfCoj8VgBCWNdx
 9ebXBMhuJtSoZcsBn6Cn0pLrU2Bp8J7klaln6kJaWpFWsYBLuq68/XRhTYlx5I4o2yU2SZlqtCe
 fo5IaaN3qQsp2vU7p/C29eNF4BeFcTwyfkeBI=
X-Gm-Gg: ASbGncvPfRiW2kwtPvW7ZTq0w6xNf8OymhNpkR97s1v7ohbrMBWoxosGt662OabFuWl
 u9Tpm4kgJTWydSfJPnr/NiJCEzsktgPjsYE2m+dc1dG2+gBMpFbBqV5dg5iAcKWblnIfluZNncD
 hQMdpJ9KAvEk6AVP/9CuY8IMhtBQUcgq3M4xg+HSB95WAfS9ACeLo50CHnH3RfS+yNacYB/FMNU
 yQxEFnNGhIaGUFrUR4lYbuq/X0tPRLsE68mjsjLtvlTJbqtmYP7GXTtLyRinfiSfe3WORriTaW0
 z48XnjraOVcD3MJM2GS6oCnQdAjxbkFd6PUQ/YVxBQ==
X-Received: by 2002:a5d:64a1:0:b0:385:faad:bfb8 with SMTP id
 ffacd0b85a97d-388e4db3356mr1872856f8f.41.1734519211406; 
 Wed, 18 Dec 2024 02:53:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG1dSZfRX78xrsNdb851rzl34E5+6rxY+MGtW07yZ+u01+FUx2aLwMvlk6ZmJHgVIANK8v3Fw==
X-Received: by 2002:a5d:64a1:0:b0:385:faad:bfb8 with SMTP id
 ffacd0b85a97d-388e4db3356mr1872813f8f.41.1734519210871; 
 Wed, 18 Dec 2024 02:53:30 -0800 (PST)
Received: from localhost
 (p200300cbc73f8300a5d5c21badd3cf50.dip0.t-ipconnect.de.
 [2003:cb:c73f:8300:a5d5:c21b:add3:cf50])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-388c806b84esm13652312f8f.108.2024.12.18.02.53.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 02:53:30 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 10/15] s390x/s390-skeys: prepare for memory devices
Date: Wed, 18 Dec 2024 11:52:58 +0100
Message-ID: <20241218105303.1966303-11-david@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218105303.1966303-1-david@redhat.com>
References: <20241218105303.1966303-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=dhildenb@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

Message-ID: <20241008105455.2302628-10-david@redhat.com>
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


