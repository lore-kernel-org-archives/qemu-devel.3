Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3101FC46CD2
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 21:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUw1U-0002Ff-Vp; Tue, 30 Jan 2024 16:52:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rUw1D-0002AF-Py
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 16:51:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1rUw1C-0005nB-D8
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 16:51:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706651505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n1LYsq3H4/MW9xzqn1KNXRss1M84Sf8g1SFg0cOkjFA=;
 b=Yx70bVzY8pIQxOPl3CZ9xHji9WjFD2NLLHuJFbjCBMeVMDYbzKgrPXP4oSCPlNGPdoZ/bF
 moOmqLN7raEjmqCSwp3tRXps6Cm9/TSpG9fTOu7Iz6hJgJfhTGw13qRKomAIGGLWrl418v
 FW0VdDBnKSjEC0w5IIeFPXU7yvS7Olg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-626-e4xT4UOsNVGiOaTAoZL8pg-1; Tue,
 30 Jan 2024 16:51:42 -0500
X-MC-Unique: e4xT4UOsNVGiOaTAoZL8pg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9C9C28EC10A;
 Tue, 30 Jan 2024 21:51:41 +0000 (UTC)
Received: from localhost (unknown [10.39.192.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0FF1E40C9444;
 Tue, 30 Jan 2024 21:51:40 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aarushi Mehta <mehta.aaru20@gmail.com>, Fam Zheng <fam@euphon.net>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 qemu-block@nongnu.org, Julia Suvorova <jusual@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Hanna Reitz <hreitz@redhat.com>,
 "Richard W.M. Jones" <rjones@redhat.com>
Subject: [PULL 2/5] block/blkio: Make s->mem_region_alignment be 64 bits
Date: Tue, 30 Jan 2024 16:51:31 -0500
Message-ID: <20240130215134.346557-3-stefanha@redhat.com>
In-Reply-To: <20240130215134.346557-1-stefanha@redhat.com>
References: <20240130215134.346557-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: "Richard W.M. Jones" <rjones@redhat.com>

With GCC 14 the code failed to compile on i686 (and was wrong for any
version of GCC):

../block/blkio.c: In function ‘blkio_file_open’:
../block/blkio.c:857:28: error: passing argument 3 of ‘blkio_get_uint64’ from incompatible pointer type [-Wincompatible-pointer-types]
  857 |                            &s->mem_region_alignment);
      |                            ^~~~~~~~~~~~~~~~~~~~~~~~
      |                            |
      |                            size_t * {aka unsigned int *}
In file included from ../block/blkio.c:12:
/usr/include/blkio.h:49:67: note: expected ‘uint64_t *’ {aka ‘long long unsigned int *’} but argument is of type ‘size_t *’ {aka ‘unsigned int *’}
   49 | int blkio_get_uint64(struct blkio *b, const char *name, uint64_t *value);
      |                                                         ~~~~~~~~~~^~~~~

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
Message-id: 20240130122006.2977938-1-rjones@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/blkio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blkio.c b/block/blkio.c
index 0a0a6c0f5f..bc2f21784c 100644
--- a/block/blkio.c
+++ b/block/blkio.c
@@ -68,7 +68,7 @@ typedef struct {
     CoQueue bounce_available;
 
     /* The value of the "mem-region-alignment" property */
-    size_t mem_region_alignment;
+    uint64_t mem_region_alignment;
 
     /* Can we skip adding/deleting blkio_mem_regions? */
     bool needs_mem_regions;
-- 
2.43.0


