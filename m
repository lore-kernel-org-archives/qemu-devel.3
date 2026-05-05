Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 954DECD3427
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKMMO-0004cJ-8T; Tue, 05 May 2026 16:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMMF-0004Tm-1A
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:27:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMMD-0002dv-B0
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:27:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778012824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CDXCmWEy4iWodcXndDcYHwui/w6yNztg5xPG4/rtdEc=;
 b=glUcmV+1IkcfukaLnhLRMJUQpZ4X9pz/TKQ0m2oejQRrD6HZBTaohA3KJNoxA8Z4QRuCdE
 JaolpArOyg41ZpF86NHuEFApgVrvhk4ZexRks4VTCWWndgSPQoLJQIifHoujMoS43WyGG3
 dx83eIcHWt52rhmI+t5Lzh1By5PiuYI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246--_gS0p7_N6mk1aQL9ndlXA-1; Tue, 05 May 2026 16:27:03 -0400
X-MC-Unique: -_gS0p7_N6mk1aQL9ndlXA-1
X-Mimecast-MFC-AGG-ID: -_gS0p7_N6mk1aQL9ndlXA_1778012823
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8ba8a1f3dd7so40932406d6.3
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 13:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778012822; x=1778617622; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CDXCmWEy4iWodcXndDcYHwui/w6yNztg5xPG4/rtdEc=;
 b=PWr/ixnc+2BMM/9nwYoIAGBWKy9JVsJTH7lvJ9b/n4rK6l6EL9aV0K+T9RyztXRfqZ
 h6yR4Lohmr8TcV+wC5AnNHEo/reMAw3TQhg36h6CJpI/KmwBom7U57OAnstwSMEpsAQu
 G+LbKuFXgKBEVAkE0QpMiV5LvllSq3svskVCre/kqXDiQRAdKOgP8km4Rx3IlyTpc53N
 ovw24bUO8YCni793xx0Kt8LJMWFVffZVPbkIXuUrXfTvIsXrTgDedwwukgLf8XfaK7Kx
 lKCQDMBB3WXUZm8SGGXN3tvvt+ntW9hrAXgRlsxumpbO08R+nDfSLec1FkcWQzpMhskt
 NnHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778012822; x=1778617622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CDXCmWEy4iWodcXndDcYHwui/w6yNztg5xPG4/rtdEc=;
 b=pkyiKdW97IEQd14/6FonzKZjMVVoxbIXPl2no6YIslCaGcQEtawIYdBs9v0JBpR0ds
 lhu0+eW3wRJz7b1JvwKAmYBUpNlYhWqU7c8gJJ36z8LxcKqrJ6dM540l0pH0RWsD2o5g
 YQxRiLJknZLJyqGd0y32Xg7zII00qYafpnon1cxScap1QjsaGcuTD4GEaTN+LAHESBHd
 evuLOWY+7WIB4mhyy+tOo80DMy8QzbSvudl5W8Img/BwW3hko+qL7M3nQQYnjWolpvbD
 YXn4KFxNzg6Mb98jrZk+ZIsc7eVP2CZqN7szKb9chhOPuS/AI1ywQgKa2Ju0mZdtfdAS
 xjaw==
X-Gm-Message-State: AOJu0YwH2lgQl/+NvaMHF82XjIzYUNnC1OshTuHghNj2olpx9U6Z+zcq
 KQ/JeCv9w0DwPEtqS0jmHj0QkTPory1T46H5wdPDt+LWGFa3zzzvFJ0kalph483MEtzYer1OjF5
 mLtNqDIefSqE0F04AZgqk6AUyZIbnashBa5vWtEbyN0eMCNX/C0WZ1qV1VaW22y28mj0zADQAtk
 FI1vbCebwRdgtRXHreqpYmU3d/6y9orE4Il5f7sg==
X-Gm-Gg: AeBDievf035ibKTiuB/eaX1vmebAiYTyiYYA9hXoVj0yjcdbq9vf/o/iGpEBgCn1SAo
 eKG7DnVG/GFx09XfO81kFwvV9yCwGmeaK5NRioKLcJqNrFW6mrRtow9qRkYrSFB4Ka1rTH5hYtj
 lUd5PqAoeOEZwplP2NgZ7Q7y01dU3emhsWYeKcCgUktefiQOlUabHXv0IcTNeRuiSyyEwpLyiSO
 CJ4ZdC5JTmHji/TBlECEMIlnnvj8nTTKgE68Cvn0+1R9+U/TMxcnyVkQAJkhs7sTawg+aOUvXmt
 Hwq5ShlOSwrtHloMhxCWLNBUiJN+7zdlWYIJJbBJ8t/zXSbLBkhPTiROddGJk8ZQf3CVqePqoH0
 8fKkzTBh41h17vC01kW8LrCZFwh4z93772uHIxTDONrHM0cQ8Yr2GUcU=
X-Received: by 2002:a05:6214:dc9:b0:8ac:7d13:d18a with SMTP id
 6a1803df08f44-8bc452702b1mr4197916d6.39.1778012822278; 
 Tue, 05 May 2026 13:27:02 -0700 (PDT)
X-Received: by 2002:a05:6214:dc9:b0:8ac:7d13:d18a with SMTP id
 6a1803df08f44-8bc452702b1mr4197126d6.39.1778012821547; 
 Tue, 05 May 2026 13:27:01 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53c6b8123sm155283806d6.35.2026.05.05.13.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 13:27:01 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 15/23] migration: Remember total dirty bytes in mig_stats
Date: Tue,  5 May 2026 16:26:32 -0400
Message-ID: <20260505202640.1011006-16-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505202640.1011006-1-peterx@redhat.com>
References: <20260505202640.1011006-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Introduce this new counter to remember the total dirty bytes for the whole
system.  It will be used for query-migrate command to fetch system-wise
remaining data.

A prior attempt was made to not use this counter but query directly from
all the modules in a QMP handler, but it exposed some complexity not only
on migration state machine race conditions (where the query may be invoked
anytime of the state machine), or on locking implications (where some of
the query hooks may take BQL, which is illegal at least in a QMP handler).
For more information, see:

https://lore.kernel.org/r/aeZMtxqrKWAMKzdN@x1.local

This oneliner will resolve everything, except that it is not as accurate.
The hope is it is a worthwhile trade-off solution, after knowing above
challenges.

Now, there is one more reason we should make each invocation of
save_live_iterate() to be lightweight, because this counter will only get
updated once for each loop over all save_live_iterate() hooks when present.
But that's always the goal.

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/r/20260421202110.306051-14-peterx@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration-stats.h | 7 +++++++
 migration/savevm.c          | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/migration/migration-stats.h b/migration/migration-stats.h
index 1775b916df..9f9a8eb9eb 100644
--- a/migration/migration-stats.h
+++ b/migration/migration-stats.h
@@ -36,6 +36,13 @@ typedef struct {
      * best-effort estimation on expected downtime.
      */
     uint64_t dirty_bytes_last_sync;
+    /*
+     * Number of bytes that were reported dirty now.  This is an estimate
+     * value and will be updated every time migration thread queries from
+     * modules in an iteration loop.  It is used to provide best-effort
+     * estimation on total remaining data.
+     */
+    uint64_t dirty_bytes_total;
     /*
      * Number of pages dirtied per second.
      */
diff --git a/migration/savevm.c b/migration/savevm.c
index 39430470aa..d1dd696c17 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1815,6 +1815,13 @@ void qemu_savevm_query_pending(MigPendingData *pending, bool exact)
     pending->total_bytes = pending->precopy_bytes +
         pending->stopcopy_bytes + pending->postcopy_bytes;
 
+    /*
+     * Update system remaining dirty bytes whenever QEMU queries.  It will
+     * make the value to be not as accurate, but should still be pretty
+     * close to reality when this got invoked frequently while iterating.
+     */
+    mig_stats.dirty_bytes_total = pending->total_bytes;
+
     trace_qemu_savevm_query_pending(exact, pending->precopy_bytes,
                                     pending->stopcopy_bytes,
                                     pending->postcopy_bytes,
-- 
2.53.0


