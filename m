Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75526CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1mC-00019T-PK; Mon, 03 Nov 2025 16:07:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1m9-00018q-QU
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lp-0005TY-TX
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762204040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qZP2PnPKVBWQomBr97OAT4HbbncDAsu0HYbYYz3qNmQ=;
 b=IphOitoehr2SUJ2pPN34b0euONQwCA0tx0akUDmepyYmTdIpzXyUJDj/Qa+Bn89o9RWIbJ
 W/N4u8g85Rc1ooUQZxF1Tdd+4HbHwqdCRfsA9pkECjqQYx6dCa09Cm+/lZiQSiY0XT/BZ7
 Af07+em/aQwQgnCudWTCvXOyNIwFk5Q=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-uuMiFDS6M5Cph9MyWT0EgA-1; Mon, 03 Nov 2025 16:07:18 -0500
X-MC-Unique: uuMiFDS6M5Cph9MyWT0EgA-1
X-Mimecast-MFC-AGG-ID: uuMiFDS6M5Cph9MyWT0EgA_1762204036
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4e8984d8833so130677351cf.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762204036; x=1762808836; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qZP2PnPKVBWQomBr97OAT4HbbncDAsu0HYbYYz3qNmQ=;
 b=rDbKAeADPFNM7ZCeM3ZN/n73XqALGE9oCg2x9W4K+XI6YgZ+0aAugXvvHMx26pOsyb
 dk5jpjceieTNkoUvfsx6wkK0+S1loA90JwHUPDlwLAfwclwYNcsUI0RSYJ1DKS3sFD+g
 g/GnZ5vUBfU9iI2a5A6D3W55QKQuBWKxVQ36/eTMGPefED0lM/jUBfZmpl6at//6frGj
 JVBMreAYnhoynbSEm1s9xKiU3UsPrmo3jAFQtyeGqfZ2nwWUXb/pp8B+aYbpnqG7L3qj
 YKvmYeuL4+3UdLqlxtlbbn60aWUrWJMDaHeUWb9kk98tTuE5CWBY7PXhqduwqH2QrBf9
 aimw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762204036; x=1762808836;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qZP2PnPKVBWQomBr97OAT4HbbncDAsu0HYbYYz3qNmQ=;
 b=owTo+MxkcMMQ854LwHISCvcZ3JOIGZvxs9VaPUYPs/aqXCDMLsb9n8QntqtnSH35H4
 BUxGriYXKtFHRsDS6ItxwCKgFmteIi7ALA5enXLSQWVkbyEO4k92gj+MvQcsWLfhVEEe
 Xv9Ob5oMF9Jh5rx8Kg+TJ3EuRyf+6QK7b9xlZDeLc/wq36aswGFnYNc5jx1XQciYuHeB
 MuZiwy/eRv19gvTNGITll/TDsG6jvP4egMAQjN3kawnN0DAFcct6MiGX4mnsszyjx0b0
 HByHu47xa8pTMv3bKLzMRTDCxdxCl1eFlVcc9TZzzw1V2J6o6V/uTWYCtMWEQan0te3T
 /BYQ==
X-Gm-Message-State: AOJu0Yz9/HQt7/7cPIaLmJFl5t8o2iUwwW7n8f1GYdUEdf4CTwx8esmc
 ZrQA+F5u84+RLfV/y7KmygklTw2CUc41l3aX/pu9RKm/Q/yuTXnxJVdyD0iiI7h4/gSAhgVMaVZ
 FIvmxJwrjh3U3CgQeNQtK1beAcT/8R7j6SI7N1IwpkVD5Wnx98ZQU+YFDqUmwyZOXUH47yEByxG
 RAtDThDIQhN2DVj1K3iZny2HESAp98kPjZZZQNjw==
X-Gm-Gg: ASbGnctsiij8yyx3oTQ02lg67UDUXeB4zhsYMQsCdfOOhAal8xXSRwIScpDxcZmjCo7
 QI5gIBxUY0XDXzBZQ7Dg5C6KYfX8mpM/WHnsTuDpY5pcEfRfgCEDa/cZg75joMGl8aWmGXN/aRd
 grNBzrHCQprNADVwhF8M2yV6b0W4hEVuIOI0XeK8rPDozUXLVM1RxRCgj8UNnCRkFNXEWmOmhi4
 uyJ3D8ia3E36PNCdCpGlHzYINUY/RFZSzgL1ItLOxqKJqsLVUyi8psrc/VVyK18bpdF1gCSntnk
 dx1LhFYrTOvwKguixPJuC2Sx0xB5ATzIWys5EwmcHD+pTW6AlC5hmVZddwv7fSjy
X-Received: by 2002:ac8:57c3:0:b0:4eb:a07a:5fce with SMTP id
 d75a77b69052e-4ed30d4d0b2mr187804651cf.17.1762204035986; 
 Mon, 03 Nov 2025 13:07:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFQSKS8RAzFsVO9bB3rFwZ0J+dWetBAgREtqNgyzX5gGBz4WEK5QDDmjHqOInVVmXdGY7cx3w==
X-Received: by 2002:ac8:57c3:0:b0:4eb:a07a:5fce with SMTP id
 d75a77b69052e-4ed30d4d0b2mr187804011cf.17.1762204035350; 
 Mon, 03 Nov 2025 13:07:15 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:07:14 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 34/36] migration: Respect exit-on-error when migration fails
 before resuming
Date: Mon,  3 Nov 2025 16:06:23 -0500
Message-ID: <20251103210625.3689448-35-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103210625.3689448-1-peterx@redhat.com>
References: <20251103210625.3689448-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

From: Juraj Marcin <jmarcin@redhat.com>

When exit-on-error was added to migration, it wasn't added to postcopy.
Even though postcopy migration will usually pause and not fail, in cases
it does unrecoverably fail before destination side has been started,
exit-on-error will allow management to query the error.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/r/20251103183301.3840862-7-jmarcin@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 48cbb46c27..91431f02a4 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -2080,11 +2080,16 @@ bool postcopy_is_paused(MigrationStatus status)
 
 static void postcopy_listen_thread_bh(void *opaque)
 {
+    MigrationState *s = migrate_get_current();
     MigrationIncomingState *mis = migration_incoming_get_current();
 
     migration_incoming_state_destroy();
 
-    if (mis->state == MIGRATION_STATUS_FAILED) {
+    if (mis->state == MIGRATION_STATUS_FAILED && mis->exit_on_error) {
+        WITH_QEMU_LOCK_GUARD(&s->error_mutex) {
+            error_report_err(s->error);
+            s->error = NULL;
+        }
         /*
          * If something went wrong then we have a bad state so exit;
          * we only could have gotten here if something failed before
-- 
2.50.1


