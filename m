Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47889C5B552
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Jun 2025 16:19:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOfDS-0000HV-J8; Mon, 09 Jun 2025 12:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOfDQ-0000Em-Ou
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:19:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uOfDP-0004VO-1t
 for qemu-devel@nongnu.org; Mon, 09 Jun 2025 12:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749485954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1A0fDBuQYTqmVarAzgYqBRrK/hWUHvpepmptSmGtWkw=;
 b=gQ24j8dPjQ+o8Wu2g36WpLVJEXIxJ+47FPdXjIp58rpECorqF21x+p52GCP5q5Gh1EXwQj
 0ykLr/fOCly8T8lc4pZT5ZC1YK5mfGSGEczTMkJj2jJaY6aImtfT+ekRSNvGoiHit1HClq
 Db98qLzYyJHE3CW9dof0Ex2kub1wYSA=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-FXd27-CgNzuq5zHHzD7Dlw-1; Mon, 09 Jun 2025 12:19:12 -0400
X-MC-Unique: FXd27-CgNzuq5zHHzD7Dlw-1
X-Mimecast-MFC-AGG-ID: FXd27-CgNzuq5zHHzD7Dlw_1749485952
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-6fab979413fso93703016d6.2
 for <qemu-devel@nongnu.org>; Mon, 09 Jun 2025 09:19:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749485952; x=1750090752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1A0fDBuQYTqmVarAzgYqBRrK/hWUHvpepmptSmGtWkw=;
 b=jadkWs++V0798wPVcsxQpNo+LRtGFBPIgrA8y7tVukvzKsUultt8qTlfECVkopeBMG
 MEkjaZ38GSYLz9GdMdLaJoNyQFPaxg+XCqk0AqeQ3p1rwCtPn0fHLuXdA6c0etxlH9jE
 fV+/ohSCCRzFPq7n7yJiq8aYDhKcqdc0HA6zZK1RJQRbHgpeTMzCZWRoTKrljl6di50M
 xkIjk2QJVttMc5zC3Ge0PxXpQNDkvJoJhf5+vI+jno5ZUhIAIOnP8JYPygliXpLEk5Bk
 qNWUr5NPBICgHJLDaD2oIQzq6TPmK9a5FDTBwFNZKpfMibgniCYkRfum+F3ZQ/XmkFuB
 WRVQ==
X-Gm-Message-State: AOJu0Yz4JUiEs2eSR0z/STRKLI5WBhUJWfTOQZf7hL/wM25wYG6Vx3Ao
 3Cox2wqpvOElbbIPGHFM3ki6k62ZU5/WnU0c/XEkVb1NBnqeJYp56pq/D1YhyUXqzX4lznhvvZn
 2pcPqSKhBPtjU+fxICQ0D5osVLX37zHXPzuL5nHIYYDSBgg39s5Q7Cczd5b4NZ9GK6PFxj18QDG
 G65QMyskvtD6nEFFd09IsaquBOTTp1+qAaicF1Nw==
X-Gm-Gg: ASbGnctMVdiSJCLCzBRLiyQZT1/aaOXn/x9A81ssVtKZPDZHYDzUFe+jSLN17n84CLM
 7GqDw5WjtnoXBl4RcyIOmPT6PogNJpiiBC66yO0fRh/4muiXxg8eY3sybNErh5GarqwwE0y/TT7
 MriECX5SOF3poTO0nBPjKpb40jFXceZiKcWbIxYvhJMMdc93M9NEx0eJ7RHiUgODk+NB1MdPUq3
 L/xybA8oj/ia2J6jzQuXQMiv4RrvlNKq/FT57fm3689q081eDmLopge/Swk6WWqSL20aHYw9EFB
 I/M4sVrRyZmZ+Q==
X-Received: by 2002:ad4:5ec8:0:b0:6fa:c512:c401 with SMTP id
 6a1803df08f44-6fb08f8e1e8mr255297036d6.37.1749485951746; 
 Mon, 09 Jun 2025 09:19:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGriEh2EYiJScSOlXvurREi+eVsRbz+hZ0TRwyl7GH4ptlWVx+ibukSColv2nP0/p4AbwU32Q==
X-Received: by 2002:ad4:5ec8:0:b0:6fa:c512:c401 with SMTP id
 6a1803df08f44-6fb08f8e1e8mr255296406d6.37.1749485951176; 
 Mon, 09 Jun 2025 09:19:11 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09ab95c1sm53420546d6.15.2025.06.09.09.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 09:19:10 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, peterx@redhat.com,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 09/11] migration/ram: Add tracepoints for
 ram_save_complete()
Date: Mon,  9 Jun 2025 12:18:53 -0400
Message-ID: <20250609161855.6603-10-peterx@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609161855.6603-1-peterx@redhat.com>
References: <20250609161855.6603-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Take notes on start/end state of dirty pages for the whole system.

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c        | 5 +++++
 migration/trace-events | 1 +
 2 files changed, 6 insertions(+)

diff --git a/migration/ram.c b/migration/ram.c
index c66ad3cf8b..a1d0e8ada2 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3289,6 +3289,8 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
     RAMState *rs = *temp;
     int ret = 0;
 
+    trace_ram_save_complete(rs->migration_dirty_pages, 0);
+
     rs->last_stage = !migration_in_colo_state();
 
     WITH_RCU_READ_LOCK_GUARD() {
@@ -3352,6 +3354,9 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
     }
 
     qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
+
+    trace_ram_save_complete(rs->migration_dirty_pages, 1);
+
     return qemu_fflush(f);
 }
 
diff --git a/migration/trace-events b/migration/trace-events
index c506e11a2e..dcd8fe9a0c 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -105,6 +105,7 @@ ram_load_postcopy_loop(int channel, uint64_t addr, int flags) "chan=%d addr=0x%"
 ram_postcopy_send_discard_bitmap(void) ""
 ram_save_page(const char *rbname, uint64_t offset, void *host) "%s: offset: 0x%" PRIx64 " host: %p"
 ram_save_queue_pages(const char *rbname, size_t start, size_t len) "%s: start: 0x%zx len: 0x%zx"
+ram_save_complete(uint64_t dirty_pages, int done) "dirty=%" PRIu64 ", done=%d"
 ram_dirty_bitmap_request(char *str) "%s"
 ram_dirty_bitmap_reload_begin(char *str) "%s"
 ram_dirty_bitmap_reload_complete(char *str) "%s"
-- 
2.49.0


