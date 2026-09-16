Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9BBBC982C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 21:38:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6xJN-0000mp-2z; Wed, 16 Sep 2026 17:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x6xIr-0000jG-Rg
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 17:36:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x6xIp-0007bt-CP
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 17:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789594586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QVF/WI5ZN7Ecy+zjQHuQdDRGoeotivOxx+UE2s9/b34=;
 b=fw9/hozGgCr3onIUMl7BNuv5yJIB2mDOASLdWNFAzdMZy5chS1UIK9wiOotKmxFbukvSLp
 qQy+3wk/i8cc+56uj8elGimUScQncBRg1JkFr6Qc+maXzO4f9oENSVRxACMg879fmfWbf9
 OF7zLWj7C/blyJs5wgtTYS7zyqOb8m4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-P8lR6wjTMbCVWlKoq9sNFQ-1; Wed, 16 Sep 2026 17:36:25 -0400
X-MC-Unique: P8lR6wjTMbCVWlKoq9sNFQ-1
X-Mimecast-MFC-AGG-ID: P8lR6wjTMbCVWlKoq9sNFQ_1789594585
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-934963b2bc0so24535085a.3
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 14:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789594585; x=1790199385; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QVF/WI5ZN7Ecy+zjQHuQdDRGoeotivOxx+UE2s9/b34=;
 b=NHHlPzIUVrSTtrjmsReSOLRDsimPkzws2XIM46/4hg9D2jdFUsSvcFvzzbZY8jhqOI
 mvJsyUggvH28CborIwADETSmo0nAtXRFBzJHx7frLKhYC5ZL/jqBQxUHn5jAhSurfJvA
 6eH409W6JFs7r73lDYrtewYDX0d2xYwnNa0oc4MEVvGYoaYBaHZBTbz7oLNXoqDUQDtl
 Vc5/riwrMW/M/tHnk7IpZXMYR0Kvd6QVjrCi8ggcfw1RKbfCwj8hRjnM8Sra21Q/ZByn
 PBy93l8H/gkZn+IjOl/LPNOe32Htrwkaa4RtvJDH3+NdViyvLxGChPc7FZPeErR1KliG
 TwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789594585; x=1790199385;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=QVF/WI5ZN7Ecy+zjQHuQdDRGoeotivOxx+UE2s9/b34=;
 b=Qbmph73gajKzM5Ia8/qFrT941x39fgnyLb5pce7qHg/koWs7INy2CYWNYQiE1xx0jw
 9hpto0dxIeXRw0mD1dsaA4OHntY2A3RRmnqRTBZ878O8fS05arftPfMxQ5aGmalvOszF
 0Z03EqiiWMQ0hQ6q5xIOedVo4KOFcXui91n27uMqxhpLJSYJsMHk7lcsWk7HJnNByiIa
 y8AzrSbgYuHjCadAArUm7LAAHnwAff6M2lMqbx/jWf4NvsdoHqRsPj69Vj/0PC6ffGQh
 IpX/J7axxYPM2cY4cx+lbngRHqm+GPilLR1QLwKNLU7Q8q8JiZWbbebjNI6O78Hi29yZ
 yoFw==
X-Gm-Message-State: AFuF++mqTRRHAoe0rsAi9UO1i8ayaAeRupx3RO96ZBb6ZJLKo7KvGR5H
 lfUoYVJy2m29wiHZWlA1LRqPbM45SYs+qyZFAGkxhuAKVRX5C30yg0twGQ1bb8BHcIGclfGLHdU
 DibUoswvllwhmQLT6EKOImS713AuMssjeN93bsz0WWwWTbS2F79NIHPcPSHOnsf8RaJ28QCaoTy
 8ua13fbHGyaNONP0gwmmzJmhBGzpkKBEWc5wjD7u4a
X-Gm-Gg: AYBFou0chFd9gpKUekLl+WRxDyOqQn5WY1jJcMq3vIt25kEWnHJM+f0suZOCWFZDNZK
 kwc2eEgXlp4iWh9o1NPx3gN6R0JoeeBRAe3YK/G3IncvLgDX2rY5MKrOiPfwZKOK0ragXRxRdTI
 TNCohtNrSZSpYv+2Hxcyn+/53mV7beX/h5Xs8sCX/avzNN7/7F7MhgRZ4g5HPe2Lczigh4DDqwt
 X+HKR+Onwc7b3yNSMMovUoV8jiNd9JVjeVMoL4xquaBTX+AepZ8UvQ+Fz/kPlrRGdImMnwnWrTj
 5y4a/Dtgu57RRn4igKxsxL/N7bRTE3x+Gox6S9TNMPVoHAIhps7obea0h82GR1GBg5tO4ie1vEH
 knh1vlTNiEYsQic12DcenCbgQIe1PWfK3pvYv7DWojtbaX3AgQqpraPprYsU=
X-Received: by 2002:a05:622a:4d4a:b0:530:178a:9dc5 with SMTP id
 d75a77b69052e-5327ee3fd52mr101384161cf.19.1789594584903; 
 Wed, 16 Sep 2026 14:36:24 -0700 (PDT)
X-Received: by 2002:a05:622a:4d4a:b0:530:178a:9dc5 with SMTP id
 d75a77b69052e-5327ee3fd52mr101383311cf.19.1789594584332; 
 Wed, 16 Sep 2026 14:36:24 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53261fd7e5bsm31559541cf.7.2026.09.16.14.36.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 14:36:23 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Akash Kulhalli <akulhall@redhat.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 7/7] migration: Postpone the outgoing preempt channel for
 preempt_pre_7_2
Date: Wed, 16 Sep 2026 17:35:58 -0400
Message-ID: <20260916213558.587304-8-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916213558.587304-1-peterx@redhat.com>
References: <20260916213558.587304-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is the corresponding outgoing fix for the same problem mentioned in
the previous patch.

The idea is simple: either migration to an old QEMU or when TLS is enabled,
we rely on correct ordering of channels to make it work: first main, then
multifd, finally preempt.

This patch re-orders multifd and postcopy preempt channel on outgoing side,
but only for the old machine types where preempt_pre_7_2 set, to make it
follow the right orders to create the channels.

Keep the resume path alone because the resume path never involve multifd
channels, even if multifd is enabled.  For that, fun fact: when multifd is
enabled with postcopy preempt, network interruption will break all multifd
channels, but they're never re-connected, until they got recycled at the
end of postcopy migration.  OTOH, multifd_recv_all_channels_created()
reports true even after postcopy network down, as multifd_recv_state->count
is never decremented.

Fixes: e27418861288 ("migration: enable multifd and postcopy together")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 4cc4077a76..f8d664808f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3733,6 +3733,20 @@ static void *migration_thread(void *opaque)
         goto out;
     }
 
+    /*
+     * Only for old 7.1/7.2 machine types running on new binaries (that
+     * supports multifd+postcopy+preempt).  Makes sure to initiate the
+     * connect() after multifd channels because the old (broken) binaries
+     * assumes the order of channels, which we cannot fix anymore.
+     *
+     * multifd_send_setup() will make sure all multifd channels will be
+     * connected first, then initiate preempt channel here guarantees the
+     * ordering to those old binaries.
+     */
+    if (migrate_postcopy_preempt() && s->preempt_pre_7_2) {
+        postcopy_preempt_setup(s);
+    }
+
     bql_lock();
     qemu_savevm_state_header(s->to_dst_file);
     bql_unlock();
@@ -4013,16 +4027,16 @@ void migration_start_outgoing(MigrationState *s)
         open_return_path_on_source(s);
     }
 
-    /*
-     * This needs to be done before resuming a postcopy.  Note: for newer
-     * QEMUs we will delay the channel creation until postcopy_start(), to
-     * avoid disorder of channel creations.
-     */
-    if (migrate_postcopy_preempt() && s->preempt_pre_7_2) {
-        postcopy_preempt_setup(s);
-    }
-
     if (resume) {
+        /*
+         * This needs to be done before resuming a postcopy.  Note: for newer
+         * QEMUs we will delay the channel creation until postcopy_start(), to
+         * avoid disorder of channel creations.
+         */
+        if (migrate_postcopy_preempt() && s->preempt_pre_7_2) {
+            postcopy_preempt_setup(s);
+        }
+
         /* Wakeup the main migration thread to do the recovery */
         migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP,
                           MIGRATION_STATUS_POSTCOPY_RECOVER);
-- 
2.55.0


