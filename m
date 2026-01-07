Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F40ECFD649
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 15:36:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdVYo-000496-FP; Wed, 07 Jan 2026 10:34:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdVYm-00048i-R1
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 10:34:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vdVYl-0002uc-4I
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 10:34:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767800094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FWjmSeuGtijsUlq+7BHHZwxqyMiDo98CWBgkgLTD07Q=;
 b=PxWSytL88crEYevqEazkejg7Uu/WKqEgSSTMf4w7o3ufLIgUMpNjtgRpBUMIVya3o9NbM6
 P41/wxsyH6YV2QNM27wefBR0wGIFCfiNVy0TWUIWim7ZC7K1TZE1HYXUasJeyC6vrMbaOU
 F57iVur/ErArbdTD/zBiIgCJnpgLHqI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-271-pJXgXGsEMvqGYthsJEFcUw-1; Wed,
 07 Jan 2026 10:34:51 -0500
X-MC-Unique: pJXgXGsEMvqGYthsJEFcUw-1
X-Mimecast-MFC-AGG-ID: pJXgXGsEMvqGYthsJEFcUw_1767800090
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AFB7F1954B0C; Wed,  7 Jan 2026 15:34:50 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.169])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B2A2B180066A; Wed,  7 Jan 2026 15:34:49 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 zoudongjie@huawei.com
Subject: [PATCH 3/3] io: fix cleanup for websock I/O source data on
 cancellation
Date: Wed,  7 Jan 2026 15:34:42 +0000
Message-ID: <20260107153442.1832957-4-berrange@redhat.com>
In-Reply-To: <20260107153442.1832957-1-berrange@redhat.com>
References: <20260107153442.1832957-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The websock code will create a GSource for tracking completion of the
handshake process, passing a QIOTask which is freed by the callback
when it completes, which means when a source is cancelled, nothing is
free'ing the task.

Switch to provide a data free callback to the GSource, which ensures
the QIOTask is always freed even when the main event callback never
fires.

Fixes: https://gitlab.com/qemu-project/qemu/-/issues/3114
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 io/channel-websock.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index b4f96a0af4..6d92be4fa1 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -545,7 +545,6 @@ static gboolean qio_channel_websock_handshake_send(QIOChannel *ioc,
         trace_qio_channel_websock_handshake_fail(ioc, error_get_pretty(err));
         qio_task_set_error(task, err);
         qio_task_complete(task);
-        qio_task_free(task);
         wioc->hs_io_tag = 0;
         return FALSE;
     }
@@ -562,7 +561,6 @@ static gboolean qio_channel_websock_handshake_send(QIOChannel *ioc,
             trace_qio_channel_websock_handshake_complete(ioc);
             qio_task_complete(task);
         }
-        qio_task_free(task);
         wioc->hs_io_tag = 0;
         return FALSE;
     }
@@ -590,7 +588,6 @@ static gboolean qio_channel_websock_handshake_io(QIOChannel *ioc,
         trace_qio_channel_websock_handshake_fail(ioc, error_get_pretty(err));
         qio_task_set_error(task, err);
         qio_task_complete(task);
-        qio_task_free(task);
         wioc->hs_io_tag = 0;
         return FALSE;
     }
@@ -918,7 +915,7 @@ void qio_channel_websock_handshake(QIOChannelWebsock *ioc,
         G_IO_IN,
         qio_channel_websock_handshake_io,
         task,
-        NULL);
+        (GDestroyNotify)qio_task_free);
 }
 
 
-- 
2.52.0


