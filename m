Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6BEEC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 07:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCwhR-0004MJ-Th; Fri, 31 May 2024 03:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sCwhP-0004Lb-Cp
 for qemu-devel@nongnu.org; Fri, 31 May 2024 03:29:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sCwhN-0003YB-Ty
 for qemu-devel@nongnu.org; Fri, 31 May 2024 03:29:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717140552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NUbGXMH/05NqmsodcOwFuyOD95dFMv4taoskzEr1lZU=;
 b=Qbuvk8CSNe6rwBOZyW+vdAqSOlU4KS1fmexnL06U4s3kUOaap5FlT5ZoYDs0gNXrUyiAhZ
 8encbQSIvCbe6cv6YoBUQchROx+/0web28Ga6WA54aJG4+apMrFwY8OqyNYJQtZAdjVRxc
 quWJZtMLUPf7a//NGax/n8rjIJD8AYg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-gsR16aUzNvaSHJ4Q163UBw-1; Fri, 31 May 2024 03:29:10 -0400
X-MC-Unique: gsR16aUzNvaSHJ4Q163UBw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 455CE101A525
 for <qemu-devel@nongnu.org>; Fri, 31 May 2024 07:29:10 +0000 (UTC)
Received: from maggie.brq.redhat.com (unknown [10.43.3.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79593491034;
 Fri, 31 May 2024 07:29:09 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Cc: david@redhat.com,
	imammedo@redhat.com
Subject: [PATCH v2 2/4] osdep: Make qemu_madvise() return ENOSYS on
 unsupported OSes
Date: Fri, 31 May 2024 09:28:58 +0200
Message-ID: <4dc484ae240edf8df0de14edefc3c3a717a1c781.1717140354.git.mprivozn@redhat.com>
In-Reply-To: <cover.1717140354.git.mprivozn@redhat.com>
References: <cover.1717140354.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Not every OS is capable of madvise() or posix_madvise() even. In
that case, errno should be set to ENOSYS as it reflects the cause
better. This also mimic what madvise()/posix_madvise() would
return if kernel lacks corresponding syscall (e.g. due to
configuration).

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 util/osdep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/osdep.c b/util/osdep.c
index e42f4e8121..5d23bbfbec 100644
--- a/util/osdep.c
+++ b/util/osdep.c
@@ -64,7 +64,7 @@ int qemu_madvise(void *addr, size_t len, int advice)
     }
     return 0;
 #else
-    errno = EINVAL;
+    errno = ENOSYS;
     return -1;
 #endif
 }
-- 
2.44.1


