Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D53FACA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 16:36:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEUbQ-0002yw-1z; Wed, 07 Oct 2026 12:34:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUb5-0002sZ-0p
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUb2-0006Ih-5g
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791390863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z5TmTWYaEAxO8RddK29Y/zCrtQvO2NeS+XCaG4IMK/4=;
 b=BCzlrRU0KfZQaB1jkdmP32jckXA2uho6BKtetdsoFBp8/uVWDiXdejS0RIMlnoTq12pYeM
 w0wHzk3RNJ6InOo5QXJnVf1Y5V9nnZ02pJXVFnUeBiyXu0GynvBgApseFgaOeW8ZBu6dpH
 cfJaUhnlui2r6jQbVaU74mQ5OKH9ZZc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-377-9lj-0pZGOiu2Ud4EEo1l5A-1; Wed,
 07 Oct 2026 12:34:21 -0400
X-MC-Unique: 9lj-0pZGOiu2Ud4EEo1l5A-1
X-Mimecast-MFC-AGG-ID: 9lj-0pZGOiu2Ud4EEo1l5A_1791390860
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C66C01933B48; Wed,  7 Oct 2026 16:34:20 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 64B7E1956087; Wed,  7 Oct 2026 16:34:19 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 04/21] block: allocate aligned write buffer for 'truncate -m
 full'
Date: Wed,  7 Oct 2026 18:32:45 +0200
Message-ID: <20261007163302.332250-5-kwolf@redhat.com>
In-Reply-To: <20261007163302.332250-1-kwolf@redhat.com>
References: <20261007163302.332250-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

In case we're truncating an image opened with O_DIRECT, we might get
-EINVAL on write with unaligned buffer.  In particular, when running
iotests/298 with '-nocache' we get:

qemu-io: Failed to resize underlying file: Could not write zeros for
preallocation: Invalid argument

Let's just allocate the buffer using qemu_blockalign0() instead.

Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Reviewed-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20260923162224.34946-1-andrey.drobyshev@virtuozzo.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 9aad156aad4..39d6a34456c 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2366,7 +2366,7 @@ static int handle_aiocb_truncate(void *opaque)
     RawPosixAIOData *aiocb = opaque;
     int result = 0;
     int64_t current_length = 0;
-    char *buf = NULL;
+    QEMU_AUTO_VFREE char *buf = NULL;
     struct stat st;
     int fd = aiocb->aio_fildes;
     int64_t offset = aiocb->aio_offset;
@@ -2433,7 +2433,7 @@ static int handle_aiocb_truncate(void *opaque)
             goto out;
         }
 
-        buf = g_malloc0(65536);
+        buf = qemu_blockalign0(aiocb->bs, 65536);
 
         seek_result = lseek(fd, current_length, SEEK_SET);
         if (seek_result < 0) {
@@ -2492,7 +2492,6 @@ out:
         }
     }
 
-    g_free(buf);
     return result;
 }
 
-- 
2.56.0


