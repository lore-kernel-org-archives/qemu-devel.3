Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD3BC3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 16:10:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx6qW-0006qt-VT; Tue, 25 Mar 2025 12:09:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1tx6oN-0004X1-Bg
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 12:07:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1tx6oJ-0007Rb-5a
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 12:07:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742918845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7g6V5yw9DWfXsXW3/hYJlzhy4WFzBO20U7FvoBzK+Rc=;
 b=BkWDj2i5kv7ZiWHo7dOoyupYnaMw6Tc3n4vuPMPD5Nd1Zj4SAQrscmB9QfZPRAUMOJdkI1
 zyhBFGvyq+ZjcJWVVt9lFvdJlT27TruZzFQa5JpMn2ta9lSRQIsSwHfciSZcyqray8gB2C
 XQVpTda3WmezzLXygcQ5sd7XLnkrKRw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-3SfynMNKN3mGWBdBDP1JTw-1; Tue, 25 Mar 2025 12:07:23 -0400
X-MC-Unique: 3SfynMNKN3mGWBdBDP1JTw-1
X-Mimecast-MFC-AGG-ID: 3SfynMNKN3mGWBdBDP1JTw_1742918842
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-39abdadb0f0so1325316f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 09:07:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742918842; x=1743523642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7g6V5yw9DWfXsXW3/hYJlzhy4WFzBO20U7FvoBzK+Rc=;
 b=utVUIvztj19zI/OI3XHmq+bzmE5j6+4pnfdrXtDxiW9wpVru49aLqbhujRQxvk5CWY
 O/4Ng/hPTtqOSW7WKP2iWjPfxASH0SNG9K7sRqoOG1SOzSvcHYBaY8U23OXNhRW+ubuG
 c5ky8l+/8v0pcDwcjT9rQFFRGZqUMk9/7yY5246dhTFkkPVn9xGcAqGBxcWFBlWAthq3
 trB4XuD4qaHSBBW5xFm68Q6xUUYOPzK5LY/Yiue7lFgHWv0UnmX69jMCDXhXM4NunIed
 ddMKvINY/IAxxlyEU9UarCiG/NfIb10U82ASMqkasEwyhmmvOGNESTDe39cbFo7I0JLC
 cmMg==
X-Gm-Message-State: AOJu0YzJrMm1SCzIwB8isVAg+5wGnNNPnLPzG78OOVTeF+iWcPGbuHoM
 jqmfmMLHpVHKKzT1Z7CVRwJ47EGmkpVWEe6F+p4BFvGGBnFyqtO4dUtYbkVvWfLBQAF5+gRCuAD
 km7FR18AT9JTC8HysWkFHKnz+GkSem3MqGIp62fKSsNcLQAH4DFsJ
X-Gm-Gg: ASbGncva2ZjZjGSdr84LFxxzCBtDphpEOgbccTthDmK401NvIRcigf5zHwhGtR1kT9r
 GxXFIlTeMt1UkHUUwkQsd+e2iH4WX21SEIfnJmg8AqlxlJzpOKg+4yrw0Fhz+XnxFxry622dgeJ
 EDcd2AB6S8PT43SH9F2As5g5NGktjwpGUROgUuJ2sdVJnpUdOPRqKktLaFZ5Sf1olnkIevFEPd5
 mwoZL/LyeUB361XuZGGT1+fyDcTL0/tb/utcVd0HSGbKrd0ZLpIAzc4x6zw21x192lLQwUsgK78
 vbtD8x1lWGefQ4V0H5hwv+Ia5GBHfGhemx+c5i/rjmHSgOUck3CouP+ERylyCCCQ1banMb80Qw=
 =
X-Received: by 2002:a05:6000:42c2:b0:39a:c9d9:877b with SMTP id
 ffacd0b85a97d-39ac9d98801mr1864169f8f.27.1742918842232; 
 Tue, 25 Mar 2025 09:07:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9izasiYkaOt4rgszJi1eDiuvT5QFDDqoPJQ4t6Flwi/8c2lCe5/t07j/+AdM0gjEpwIXKEA==
X-Received: by 2002:a05:6000:42c2:b0:39a:c9d9:877b with SMTP id
 ffacd0b85a97d-39ac9d98801mr1864122f8f.27.1742918841656; 
 Tue, 25 Mar 2025 09:07:21 -0700 (PDT)
Received: from localhost
 (p200300cfd74f9db6ee8035b86ef736e5.dip0.t-ipconnect.de.
 [2003:cf:d74f:9db6:ee80:35b8:6ef7:36e5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9b26a6sm13908244f8f.44.2025.03.25.09.07.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 09:07:20 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 09/15] fuse: Introduce fuse_{inc,dec}_in_flight()
Date: Tue, 25 Mar 2025 17:06:49 +0100
Message-ID: <20250325160655.119407-8-hreitz@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250325160529.117543-1-hreitz@redhat.com>
References: <20250325160529.117543-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

This is how vduse-blk.c does it, and it does seem better to have
dedicated functions for it.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 block/export/fuse.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/block/export/fuse.c b/block/export/fuse.c
index bd98809d71..e50dd91d3e 100644
--- a/block/export/fuse.c
+++ b/block/export/fuse.c
@@ -78,6 +78,25 @@ static void read_from_fuse_export(void *opaque);
 static bool is_regular_file(const char *path, Error **errp);
 
 
+static void fuse_inc_in_flight(FuseExport *exp)
+{
+    if (qatomic_fetch_inc(&exp->in_flight) == 0) {
+        /* Prevent export from being deleted */
+        blk_exp_ref(&exp->common);
+    }
+}
+
+static void fuse_dec_in_flight(FuseExport *exp)
+{
+    if (qatomic_fetch_dec(&exp->in_flight) == 1) {
+        /* Wake AIO_WAIT_WHILE() */
+        aio_wait_kick();
+
+        /* Now the export can be deleted */
+        blk_exp_unref(&exp->common);
+    }
+}
+
 static void fuse_attach_handlers(FuseExport *exp)
 {
     aio_set_fd_handler(exp->common.ctx,
@@ -297,9 +316,7 @@ static void read_from_fuse_export(void *opaque)
     FuseExport *exp = opaque;
     int ret;
 
-    blk_exp_ref(&exp->common);
-
-    qatomic_inc(&exp->in_flight);
+    fuse_inc_in_flight(exp);
 
     do {
         ret = fuse_session_receive_buf(exp->fuse_session, &exp->fuse_buf);
@@ -317,11 +334,7 @@ static void read_from_fuse_export(void *opaque)
     fuse_session_process_buf(exp->fuse_session, &exp->fuse_buf);
 
 out:
-    if (qatomic_fetch_dec(&exp->in_flight) == 1) {
-        aio_wait_kick(); /* wake AIO_WAIT_WHILE() */
-    }
-
-    blk_exp_unref(&exp->common);
+    fuse_dec_in_flight(exp);
 }
 
 static void fuse_export_shutdown(BlockExport *blk_exp)
-- 
2.48.1


