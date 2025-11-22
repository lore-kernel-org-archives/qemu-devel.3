Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB42CCFC515
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 02:04:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcjh-0000am-Lw; Fri, 21 Nov 2025 20:48:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vMbTT-0006eE-Hg
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:27:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vMbTJ-0003f4-6t
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:27:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763771228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ucm9Frb4EPj7cNAABkDFctVqJ/YbMHaGhW3ZAw/4A04=;
 b=gaJL/Q1tBCFWRAlQPaYvBb8s+6l9DwkpnAw7Yg1QpvmLBqQWqXIzF6iBjz0Bg7xJ4x21Gj
 v2j1KeDvKzEeGteDj8homL/7OGQxXa8WQ42SUlDWjF/OgJo9S4S8OiH4XJ+rCX4kB3NdEM
 dTiz2TRhzqDuowfjJ5eJdQyv1s9n8oA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-Jtcs0RKQMnuSRmfEgUwfDA-1; Fri, 21 Nov 2025 19:27:06 -0500
X-MC-Unique: Jtcs0RKQMnuSRmfEgUwfDA-1
X-Mimecast-MFC-AGG-ID: Jtcs0RKQMnuSRmfEgUwfDA_1763771226
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4ee25cd2da3so50624131cf.2
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 16:27:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763771226; x=1764376026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ucm9Frb4EPj7cNAABkDFctVqJ/YbMHaGhW3ZAw/4A04=;
 b=XdKP9EREcfvxBrGyTTyJLDFiTg5UsswB3NWCLL7S3paWxFU6tLQqW0Bc15r1jKnhmF
 xDVKYWxGQ/r+beuDrZ4Fkm7XDocYKUH5U/q1QCG6/TwAbT1YMgS9btdznErbmUMd3dXe
 9dkY28m4M4pq8imL5UXmDvYH/7R/v0IeO6H9fNmCXa/v+TmNtI3Mma+wYQBsd7TTLg0C
 +SwQh658x2jQZQZYXFCLuLFFpxWuWTfjPs/c5VnY1DHK70C8c4WLuYd7KiTLPhSkrC3z
 dFGFcLPcgrQnB0AhJFJ2QV63ieF/uD9yKRcC9ln5JminFY8kYFLOCNpXj3Xmmzu/tWCb
 nfYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763771226; x=1764376026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ucm9Frb4EPj7cNAABkDFctVqJ/YbMHaGhW3ZAw/4A04=;
 b=dmlFT6P7AiIcgBOLPseE9Xes7Kc+DT/naB0rUr7la65g/GudreaoMV48b59Isk6ynF
 tKUxKFIraHXqzbwagNBEHpzaOuk9rA5fiN+LHdk6nEdzfp+HDaM8wvM8HmunsGUx5vDd
 rpy61cIq3x2W8r1LB46iw8pNKtqQT/712sa8MdKGqfDIiywnxtCFtUXCXGV00c2Roitk
 RwKGd2lgnTce1ksGGWniWJPUj+9H2ezV/G98l9ttmdGjx+KFpz9GloYOL+nBtcvZb2Gl
 0VU4rRlUpdCkPtyF+ADtsSqcebqZZSEyP4571U2DP0PzTpuYHaqVc02NgTleZ0JLVGrC
 3jNg==
X-Gm-Message-State: AOJu0YyjNXqaAfc/pV8bd5wICWPf2Ujc+ALSIOftK7eK/ZW4FHT8JSKu
 /st2Tus38DOV+kKhuOwO8i4qM4u0NvrokrUictYBYMIviAJhLIfFZZzgybsbDU47jGCbIFP4OPr
 /hmMbPrIbR9ciZpzJV7C4t7LVcblT3/TeuFkh0fB19TvZbvYVsGJd2snuE1HQx//6yZTZ6zATol
 iOGcBobYaus3QInqCRNksOgWPV1hHn+8cS4bRZ3g==
X-Gm-Gg: ASbGncsA+8N2OZwt38OggWDnVBHy/5tQ+Q4VJqQRMETesYS17vq6PyQ2vlsoaDYrZKd
 8w+nykGsN57UmDc1it87XtxtZU+s2ltP/wBWSIB1r+DPElrdIzhYu1mQSwJtQSw2LgX0xNPQbag
 JjXiPHEi6H9m0ydEt1cvkJAN1n5jhFm5opb3ixBvEDiCpl4aT2JzMSf9UATXJCPyy0WBX9ed6nW
 cjm/v4sYVRRL9WD/sVeCPgNrHjPZLXNcY5UHss/1KOu4Kw0NJXwPgYoFEHmj38fWwxlS4A+ZLJz
 wmwGPuQgJObqF80JhwDhiS3YrT6HGITCxz4qAVAVxZFzZ+ZBAC21f99s4hYh7Fn+hJDcWg38a+u
 h
X-Received: by 2002:ac8:5905:0:b0:4ee:1b37:c9e9 with SMTP id
 d75a77b69052e-4ee58818828mr75181921cf.5.1763771225672; 
 Fri, 21 Nov 2025 16:27:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8gSWGGAKJX3onm9hzxFU6L8pmTUbEDKEYpmu9D3XvC6KTbEGWFAt1q4+DA2DP9iImfr2I1A==
X-Received: by 2002:ac8:5905:0:b0:4ee:1b37:c9e9 with SMTP id
 d75a77b69052e-4ee58818828mr75181581cf.5.1763771225193; 
 Fri, 21 Nov 2025 16:27:05 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ee48e8df63sm43870291cf.30.2025.11.21.16.27.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 16:27:04 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Markus Armbruster <armbru@redhat.com>
Subject: [PULL 5/9] migration/postcopy-ram: Improve error reporting after
 loadvm failure
Date: Fri, 21 Nov 2025 19:26:51 -0500
Message-ID: <20251122002656.687350-6-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251122002656.687350-1-peterx@redhat.com>
References: <20251122002656.687350-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

From: Markus Armbruster <armbru@redhat.com>

One of two error messages show __func__.  Drop it; it doesn't help
users, and developers can grep for the message.  This also permits
de-duplicating the code to prepend to the error message.

Both error messages show a numeric error code.  I doubt that's
helpful, but I'm leaving it alone.

Use error_append_hint() for explaining that some dirty bitmaps may be
lost.  Polish the prose.

Don't faff around with g_clear_pointer(), it's not worth its keep
here.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Link: https://lore.kernel.org/r/20251115083500.2753895-4-armbru@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/postcopy-ram.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 3f98dcb6fd..7c9fe61041 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -2146,25 +2146,24 @@ static void *postcopy_listen_thread(void *opaque)
     if (load_res < 0) {
         qemu_file_set_error(f, load_res);
         dirty_bitmap_mig_cancel_incoming();
+        error_prepend(&local_err,
+                      "loadvm failed during postcopy: %d: ", load_res);
         if (postcopy_state_get() == POSTCOPY_INCOMING_RUNNING &&
             !migrate_postcopy_ram() && migrate_dirty_bitmaps())
         {
-            error_report("%s: loadvm failed during postcopy: %d: %s. All states "
-                         "are migrated except dirty bitmaps. Some dirty "
-                         "bitmaps may be lost, and present migrated dirty "
-                         "bitmaps are correctly migrated and valid.",
-                         __func__, load_res, error_get_pretty(local_err));
-            g_clear_pointer(&local_err, error_free);
+            error_append_hint(&local_err,
+                              "All state is migrated except dirty bitmaps."
+                              " Some dirty bitmaps may be lost, but any"
+                              " migrated dirty bitmaps are valid.");
+            error_report_err(local_err);
         } else {
             /*
              * Something went fatally wrong and we have a bad state, QEMU will
              * exit depending on if postcopy-exit-on-error is true, but the
              * migration cannot be recovered.
              */
-            error_prepend(&local_err,
-                          "loadvm failed during postcopy: %d: ", load_res);
             migrate_set_error(migr, local_err);
-            g_clear_pointer(&local_err, error_report_err);
+            error_report_err(local_err);
             migrate_set_state(&mis->state, mis->state, MIGRATION_STATUS_FAILED);
             goto out;
         }
-- 
2.50.1


