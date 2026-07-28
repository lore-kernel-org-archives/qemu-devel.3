Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36AA9C54F55
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wok7E-0002gI-LA; Tue, 28 Jul 2026 11:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wok7C-0002f6-Uu
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:53:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wok7A-0005eG-QO
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785253988;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9yDobXnYDvJMRh3IPnfoTjQ6eQkvxTiCfvj1rQ0oHcs=;
 b=PLj6HRas0IX54Sj8YtKUv3GV1YByN/wkqzYP5qnBzAUzuqcsW7H1JERrphEjDnoG4xswSE
 8I9dmZ1xhs3PhYnUeIsRe7DeFXIMKQ32kBD30sZ/EFCHLCf+z6r8bKWirudk+VQFZUZGfq
 vRzhpdST8fGjTAYfRwqVdyLvnuBemGc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-WNCtDoSCNgWIXu4pULzWQw-1; Tue, 28 Jul 2026 11:53:06 -0400
X-MC-Unique: WNCtDoSCNgWIXu4pULzWQw-1
X-Mimecast-MFC-AGG-ID: WNCtDoSCNgWIXu4pULzWQw_1785253986
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-5283df62d68so101101cf.0
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785253986; x=1785858786; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9yDobXnYDvJMRh3IPnfoTjQ6eQkvxTiCfvj1rQ0oHcs=;
 b=m/Do4qV9s6H8Q+MLyVTndb8WMIaV+csMGBZQ8qLCf/B81AI4HX+uQ49KsrkDFsod5e
 /1FIrIhKSaBP04kXzDdTyqVzn2iatzazEy19CRdE9KkBk7XhXP0vM9G6KpEe6gPiSTvi
 0UIZxb5nvJBgD9BUGcbJgh4v4VuZgebh6//GhGl1cPHhqSnlITqk+/emyUvp5+g/hDAq
 fg4sD9xJnmzu6GlvJcBFfQU7UczT7Ju8Kd7mo6EQYNksfzw8uXhLb6zo1GB1z9nqOpds
 skfcW7kjjn/kTrwknw4Qr5VUpLSARYPiDo93f+VV0UwTNce7UwGLeUBFqX3Fz8m8mV5S
 t4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785253986; x=1785858786;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9yDobXnYDvJMRh3IPnfoTjQ6eQkvxTiCfvj1rQ0oHcs=;
 b=A/veZVNZIw1N9Pu3BP/D6SVDEDgrbbPlt/f8d+J4jQqgKVa5yg+DQEx3sGsLTJDEJk
 bbNzUmrLNd/q7x1oAdj8BJNd7aYj2tlRt91SFr/fHAMzzc7avcZT//MZy5zx02uVwrHB
 ALv3CzYhFMTw4EVaF+1hQWbaF2pPpGWfqCYKxEK6LiuZX6iHlE36aqZJ9sIwSt+OloCI
 oGD7uROtG+jV19nuYTLY5RU/kG532iSHAs0V3AxOKeYwjrlg83w0z0m7Oqm8SLaB9VGD
 mADWkB0pG+5rDSSP6p8kEHjOM3INjHRQycDieFPA/r0UWY4wN+TJYhmk3UCGCnDdJkeL
 Gb/A==
X-Gm-Message-State: AOJu0Ywkhrujnj3ICVg5LNDJCP5zpUgLYP2btDM0pUNeY68J0/FQFc/V
 xG7TK8pLXqLB5h+IahQX0fUyhAn+nvBGS2Fd+oHsF1Sv3ooCKWpBqjSD4wQFLQpw1P0B7dzzPwj
 sHW4QZm0tDkKeErz+wyUngDlYMHhRlqDCpH+813qt5otTRagv8OpTymiUQXswGdRvBMqx0haqj1
 yD7s8P2ZDE5pgrwYcmxSrRY6fGGQKV54hb1zpk8A==
X-Gm-Gg: AR+sD12QEjgFZpCMEPvIufXXioySiz4mFtcy0EEabv6DuaR0jyVRVwwv6MBjPVgPjME
 ubEDR4Ku0AZIla9IZXpmi3YL3Fzc7B+VWX0oZe4/dUMg/eXpgl85h+1kdja24QI90tXydFIoLAF
 eoxgHhmtA8UD0LC+3SjDvFeFJc0e5KOw8l29fka3ddohjD+1//pN6O8X2NS0lOWrxJ1f7FxLcOt
 xHocLfOGG31nfuh3xB90jV9YvLFqm9H5I9a/tf76P1MQo3jgoDrVAtQku1tAb0EYOqVSqasrcm+
 6EHO00L5RlrGK2+vH0niKpCipiE1SML0ZybCL4ecXIOTGoeV3AHmSISCPcWNHLeZug==
X-Received: by 2002:a05:622a:1f8b:b0:516:dbf6:f8e7 with SMTP id
 d75a77b69052e-529d6f9cd07mr28864681cf.17.1785253986156; 
 Tue, 28 Jul 2026 08:53:06 -0700 (PDT)
X-Received: by 2002:a05:622a:1f8b:b0:516:dbf6:f8e7 with SMTP id
 d75a77b69052e-529d6f9cd07mr28864151cf.17.1785253985502; 
 Tue, 28 Jul 2026 08:53:05 -0700 (PDT)
Received: from x1.com ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-529e2dd54dbsm492481cf.23.2026.07.28.08.53.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:53:04 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Feifan Qian <bea1e@proton.me>
Subject: [PATCH 4/5] migration: Fix rare hang of migration_channel_read_peek()
Date: Tue, 28 Jul 2026 11:52:46 -0400
Message-ID: <20260728155247.1894355-5-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260728155247.1894355-1-peterx@redhat.com>
References: <20260728155247.1894355-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

In an unlikely case, when a migration stream is attached to the destination
QEMU and only send <4 bytes to the channel as magic, it's possible that
migration_channel_read_peek() may spin forever without yielding in the main
thread causing two unwanted consequences:

- CPU will spin 100% waiting for the rest bytes until it reaches 4
- (more importantly..) Main thread is stuck during this process as the qio
  operation won't really yield the coroutine

Fix it by consuming the bytes that arrived.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3889
Cc: Daniel P. Berrangé <berrange@redhat.com>
Reported-by: Feifan Qian <bea1e@proton.me>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/channel.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/migration/channel.c b/migration/channel.c
index 1e2935f926..28fe1d2906 100644
--- a/migration/channel.c
+++ b/migration/channel.c
@@ -294,11 +294,31 @@ int migration_channel_read_peek(QIOChannel *ioc,
             return -1;
         }
 
-        if (len == buflen) {
+        if (len == iov.iov_len) {
             break;
-        }
+        } else if (len == 0) {
+            qio_channel_wait_cond(ioc, G_IO_IN);
+        } else {
+            ssize_t received = len;
 
-        qio_channel_wait_cond(ioc, G_IO_IN);
+            /*
+             * Partially arrived, read out to make qio_channel_wait_cond()
+             * won't return immediately, causing an unwanted spin on this
+             * CPU.
+             */
+            iov.iov_len = len;
+            len = qio_channel_readv_full(ioc, &iov, 1, NULL, NULL, 0, errp);
+            /*
+             * QIO_CHANNEL_ERR_BLOCK also shouldn't happen, due to the
+             * prior peek just happened.  We should be pretty sure we will
+             * read what we peeked, or the channel was broken.
+             */
+            if (len != received) {
+                return -1;
+            }
+            iov.iov_base += received;
+            iov.iov_len = buflen - received;
+        }
     }
 
     return 0;
-- 
2.54.0


