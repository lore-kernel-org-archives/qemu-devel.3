Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2C1C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 10:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEo8k-0008Ke-BP; Wed, 05 Jun 2024 06:45:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sEo8i-0008KL-Po
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 06:45:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mprivozn@redhat.com>)
 id 1sEo8h-0007Vj-5p
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 06:45:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717584306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uaIwU4JQWNP4grebF1X7VJNsVyzz/dsz0IKLLBSLuyM=;
 b=UuV3XYpbLPfYl7Uzjd2jMIqFoRenzohzOJuh6vgodn5GXQoid6qxW8qCc00+TprB6QtxIn
 ilV4zeXvb0ygnk1sryJlzpNr3ekhqF/gNxTFxHaAn6mzpz5jygk+knAmbdWKtzxrCERzPc
 cdEN3shf5kFncYGj3E1vz57+3rQr0Ew=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-CP-rx-ivNUm-Kbs2tWafgw-1; Wed,
 05 Jun 2024 06:45:04 -0400
X-MC-Unique: CP-rx-ivNUm-Kbs2tWafgw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87F9C195609E
 for <qemu-devel@nongnu.org>; Wed,  5 Jun 2024 10:45:03 +0000 (UTC)
Received: from maggie.brq.redhat.com (unknown [10.43.3.102])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6888B19560A2
 for <qemu-devel@nongnu.org>; Wed,  5 Jun 2024 10:45:02 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 1/5] meson: Don't even detect posix_madvise() on Darwin
Date: Wed,  5 Jun 2024 12:44:54 +0200
Message-ID: <00f71753bdeb8c0f049fda05fb63b84bb5502fb3.1717584048.git.mprivozn@redhat.com>
In-Reply-To: <cover.1717584048.git.mprivozn@redhat.com>
References: <cover.1717584048.git.mprivozn@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mprivozn@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Darwin, posix_madvise() has the same return semantics as plain
madvise() [1]. That's not really what our usage expects.
Fortunately, madvise() is available and preferred anyways so we
may stop detecting posix_madvise() on Darwin.

1: https://opensource.apple.com/source/xnu/xnu-7195.81.3/bsd/man/man2/madvise.2.auto.html

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 meson.build | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/meson.build b/meson.build
index 6386607144..49962cce88 100644
--- a/meson.build
+++ b/meson.build
@@ -2552,10 +2552,16 @@ config_host_data.set('CONFIG_OPEN_BY_HANDLE', cc.links(gnu_source_prefix + '''
   #else
   int main(void) { struct file_handle fh; return open_by_handle_at(0, &fh, 0); }
   #endif'''))
-config_host_data.set('CONFIG_POSIX_MADVISE', cc.links(gnu_source_prefix + '''
-  #include <sys/mman.h>
-  #include <stddef.h>
-  int main(void) { return posix_madvise(NULL, 0, POSIX_MADV_DONTNEED); }'''))
+
+# On Darwin posix_madvise() has the same return semantics as plain madvise(),
+# i.e. errno is set and -1 is returned. That's not really how POSIX defines the
+# function. On the flip side, it has madvise() which is preferred anyways.
+if host_os != 'darwin'
+  config_host_data.set('CONFIG_POSIX_MADVISE', cc.links(gnu_source_prefix + '''
+    #include <sys/mman.h>
+    #include <stddef.h>
+    int main(void) { return posix_madvise(NULL, 0, POSIX_MADV_DONTNEED); }'''))
+endif
 
 config_host_data.set('CONFIG_PTHREAD_SETNAME_NP_W_TID', cc.links(gnu_source_prefix + '''
   #include <pthread.h>
-- 
2.44.1


