Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07618C3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 10:58:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDBa-0007EA-1R; Tue, 23 Jul 2024 06:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDBZ-000793-85
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:56:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDBX-0001dN-DZ
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EH7iZz7W3GpWmzCfYcERS56IxpqGZ9YSdfDypAnOEA4=;
 b=D9j5OSNI0ISnUerZj/8BSLe/TAV9X3DBkQV3r6O/UQf4v4p02xLClPjDa8ykjCOgvIGIOr
 gw89QJUR5gd2/Hc1vozQjrC4BHbVT+LO7AlOqY8dAIKk/vMwapoK0IfePRK3WcLIosC4GS
 m9uaAu5gN3/J6SLxw7a3W7FOY8jWmhw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-D2PsyTSQPW60N7kFZnADlw-1; Tue, 23 Jul 2024 06:55:57 -0400
X-MC-Unique: D2PsyTSQPW60N7kFZnADlw-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a7a822ee907so49682866b.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732155; x=1722336955;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EH7iZz7W3GpWmzCfYcERS56IxpqGZ9YSdfDypAnOEA4=;
 b=U7BlELdAEHh35bOW5NHN4juq6EpHGNnFgPyoXvbY5ECRLGo0T3WCYgZRjSSQEPd2ZM
 58kjaTdn7TzoDD2HynQogbPzcwZg4Oy4tHaHtjv6+86PlcwaQdY6PSs8Ylvxf8T+iiPp
 NkHZ3Cg9XenCoGVUCkU9FIgrUTSDldDJdRBUKNQGT8nVra81toYGH24NILgNXktb6eCe
 7zFHUV7v1ZBdZIdBvPfwl1FFE0Go44k39zcZSWFlbGQhrIT+oGsPbiCkTScrW/IBfPed
 m0nv9rhFr4NkMiUfNy3d4grB97HmdwwD9FmhQ8ngitipJYG+ijSJljrpDHNxcef87dAX
 0qYg==
X-Gm-Message-State: AOJu0YwIhQ4julKcn3tfVf3zv5XXtUaKveMZIlIZ9w5jgkrzEZxfogK9
 Nu4zuMM2jYDZWCTn6boj8QkV0qJZzPGhwWSqDk8Mtyff/GNl4nMGhmS0W00YglXr3NH5PauhtcG
 HQkTssABblgxQxoPwgn2UxB4SDqGWZnhD8CUPSqxW3tFJX0JbClYRRzO4+pik+tvyA9gm88e52r
 K7RCE5cQDd/cBrk1Cze+mWZCW3ZIdVuw==
X-Received: by 2002:a17:906:6a2a:b0:a77:cf9d:f498 with SMTP id
 a640c23a62f3a-a7a4c034e10mr616138366b.40.1721732155631; 
 Tue, 23 Jul 2024 03:55:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElq73L5/g3H/MTcz1j7Pp0I7Y1Z4gghK+5DeH3+uYuyC0JGBC91N4G0sz73VHT8MYfkzHYww==
X-Received: by 2002:a17:906:6a2a:b0:a77:cf9d:f498 with SMTP id
 a640c23a62f3a-a7a4c034e10mr616134466b.40.1721732154920; 
 Tue, 23 Jul 2024 03:55:54 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7aa5b165c9sm3089366b.210.2024.07.23.03.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:55:54 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:55:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PULL v2 08/61] hw/cxl/events: discard all event records during
 sanitation
Message-ID: <7d65874ba0ea8cdb2a5ac51c397d721d7d49d828.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Per CXL r3.1 Section 8.2.9.9.5.1: Sanitize (Opcode 4400h), the
sanitize command should delete all event logs. Introduce
cxl_discard_all_event_logs() and call
this in __do_sanitization().

Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Link: https://lore.kernel.org/r/20231222090051.3265307-5-42.hyeyoo@gmail.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Message-Id: <20240705120643.959422-4-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/cxl/cxl_device.h |  1 +
 hw/cxl/cxl-events.c         | 13 +++++++++++++
 hw/cxl/cxl-mailbox-utils.c  |  1 +
 3 files changed, 15 insertions(+)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 42a622197e..0509d961c3 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -562,6 +562,7 @@ CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
                                  size_t *len);
 CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds,
                                    CXLClearEventPayload *pl);
+void cxl_discard_all_event_records(CXLDeviceState *cxlds);
 
 void cxl_event_irq_assert(CXLType3Dev *ct3d);
 
diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
index d397718b1b..12dee2e467 100644
--- a/hw/cxl/cxl-events.c
+++ b/hw/cxl/cxl-events.c
@@ -139,6 +139,19 @@ bool cxl_event_insert(CXLDeviceState *cxlds, CXLEventLogType log_type,
     return cxl_event_count(log) == 1;
 }
 
+void cxl_discard_all_event_records(CXLDeviceState *cxlds)
+{
+    CXLEventLogType log_type;
+    CXLEventLog *log;
+
+    for (log_type = 0; log_type < CXL_EVENT_TYPE_MAX; log_type++) {
+        log = &cxlds->event_logs[log_type];
+        while (!cxl_event_empty(log)) {
+            cxl_event_delete_head(cxlds, log_type, log);
+        }
+    }
+}
+
 CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPayload *pl,
                                  uint8_t log_type, int max_recs,
                                  size_t *len)
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 522d9aa589..3c9600c39c 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -949,6 +949,7 @@ static void __do_sanitization(CXLType3Dev *ct3d)
             memset(lsa, 0, memory_region_size(mr));
         }
     }
+    cxl_discard_all_event_records(&ct3d->cxl_dstate);
 }
 
 /*
-- 
MST


