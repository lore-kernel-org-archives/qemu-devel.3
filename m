Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CCB2CA0FFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:23:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNHh-00013D-D1; Sat, 30 Aug 2025 11:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryjC-0001Lg-2q
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:01:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uryj6-000058-CU
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 09:01:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756472467;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wib+D8WRzWnAj9UyAq3qZPgY0vk6Olt8tQ4PW4MKmdU=;
 b=JywMhLbJb84Ulz1WUb2gQEnGFdGZ7QHVuQPjqk2biWPJkXdIX8C14lUBc4CDHk38ZTiocV
 8ZOkUIkNJcNB/dIghKovaEDhO8CH1Tj0JHbe3pfa9KAB1IlKcw74/bb9NGBylypDi72dty
 pKw608rXSSC2XVoYUyirGLO36jgyJqY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-cvI3qvKbN_WrtczRO3PBWQ-1; Fri, 29 Aug 2025 09:01:05 -0400
X-MC-Unique: cvI3qvKbN_WrtczRO3PBWQ-1
X-Mimecast-MFC-AGG-ID: cvI3qvKbN_WrtczRO3PBWQ_1756472464
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45a1b0b46bbso11364025e9.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 06:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756472463; x=1757077263;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wib+D8WRzWnAj9UyAq3qZPgY0vk6Olt8tQ4PW4MKmdU=;
 b=TVtECzLm0+qHPIT8BPczXmfDg7PJCC23WQIirHeeyMFMJV8Gt85etP/HqCf+OKFWW4
 TKF5BZrsib5Jfc3A/oKYO5iuA0wd5Yj+tFg89KirNhbTSdosQfpumKrQxnwzZOLozmU+
 uG0B7kdpMIchS2yvHxjv5BILA6m17ucHnnTnigQoCz1kjazGIUfXB6H06RpCutwBI+HY
 7tOWuwyu493+jciDJfVImIt5ux+ezOChgIS1UZyZopnoUicNUewAPuvuu58D8Y9dInYf
 aLyJm0VTzBfkz88EiHwCrfoxJpSLNQKFrH7+9ZEDCVMSNoMU+e6wIwKrVCkEyCETRGae
 Ljmw==
X-Gm-Message-State: AOJu0Yyy5tbcMXBNIl7R3uqmdB8mAMi+aGqde/TsmObFHM6VG+XXP3V/
 l97aMIZDSg1xMoNAuSMosdg7O/y7ZNhcJKAIANT2ri6aBWIizmN7JkGN/eeHdK5EXB38In1PNy/
 VGRw7t1LK4Qlr2dWL4qwYgZOJSXwXCE4uEpfdwWltRCcuMe1wjhlu4aLWb9zdNl49xWafOz5plT
 mBQIlmj4D3TwYmFlt9rH1lgltwRNwunL/0H2xAp6lz
X-Gm-Gg: ASbGnctj9OsWqYb5brh7SGmlS87+ZyixJ7E2rcpaG7w5eVw1KMndy+OSw833x/7bnHV
 stVI4juV82G6bUrognsgnz961uXl1eExVOmnCITogvVkGjHbdjzLAI3GBHJDew7JA/NEL1CSb4t
 bGZLjboS0DO4mRQzJb68RsM7XmwZ5vM4nyiyZslVAKuPU1RCxjuNH07frHpes5jS8eq5YjynajV
 H8KT59Dtjb0+h4TUqSIvdRNMbPI1dFk26l8fWdxMXAK3V4mdDbb/TQUEYWFIzqkcy01Y9JlIzy/
 zvTDosxxO9AVfaFiNc0pIzZhb3Ma/nkDWYIoJAyVRAQUNcJUnuYPhXKDL7eKj3KnoV1rNvoCbt1
 6jiYSz7+UhOi5rUo0Vr/+uBJouMaQZG42GRkiJeWy3oQ=
X-Received: by 2002:a05:600c:1d26:b0:45b:7c20:5709 with SMTP id
 5b1f17b1804b1-45b7c205c14mr51130295e9.12.1756472462128; 
 Fri, 29 Aug 2025 06:01:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzpbmdD6NQq2vTFnKGN/6cnfNrrjKpUuP6QPaxbVk3vlZCOKff2eDDKni4SzcCXYOaw4fUvw==
X-Received: by 2002:a05:600c:1d26:b0:45b:7c20:5709 with SMTP id
 5b1f17b1804b1-45b7c205c14mr51129975e9.12.1756472461632; 
 Fri, 29 Aug 2025 06:01:01 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b7e50e30asm39297335e9.24.2025.08.29.06.01.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 06:01:00 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
	Peter Xu <peterx@redhat.com>
Subject: [PULL 25/28] hpet: move out main counter read into a separate block
Date: Fri, 29 Aug 2025 14:59:32 +0200
Message-ID: <20250829125935.1526984-26-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829125935.1526984-1-pbonzini@redhat.com>
References: <20250829125935.1526984-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Igor Mammedov <imammedo@redhat.com>

Follow up patche will switch main counter read to
lock-less mode. As preparation for that move relevant
branch into a separate top level block to make followup
patch cleaner/simplier by reducing contextual noise
when lock-less read is introduced.

no functional changes.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20250814160600.2327672-5-imammedo@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/timer/hpet.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index ab5aa59ae4e..c776afc0f2d 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -431,6 +431,16 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
     addr &= ~4;
 
     QEMU_LOCK_GUARD(&s->lock);
+    if (addr == HPET_COUNTER) {
+        if (hpet_enabled(s)) {
+            cur_tick = hpet_get_ticks(s);
+        } else {
+            cur_tick = s->hpet_counter;
+        }
+        trace_hpet_ram_read_reading_counter(addr & 4, cur_tick);
+        return cur_tick >> shift;
+    }
+
     /*address range of all global regs*/
     if (addr <= 0xff) {
         switch (addr) {
@@ -438,14 +448,6 @@ static uint64_t hpet_ram_read(void *opaque, hwaddr addr,
             return s->capability >> shift;
         case HPET_CFG:
             return s->config >> shift;
-        case HPET_COUNTER:
-            if (hpet_enabled(s)) {
-                cur_tick = hpet_get_ticks(s);
-            } else {
-                cur_tick = s->hpet_counter;
-            }
-            trace_hpet_ram_read_reading_counter(addr & 4, cur_tick);
-            return cur_tick >> shift;
         case HPET_STATUS:
             return s->isr >> shift;
         default:
-- 
2.51.0


