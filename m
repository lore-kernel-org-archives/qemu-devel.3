Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85CC3C27C52
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 07:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEOl4-0001T9-UG; Tue, 04 Jun 2024 03:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sEOl3-0001Ih-Df
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:39:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1sEOl1-0006Oy-LO
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 03:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717486738;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5d5y2FC6cxEygSgk8M5FRyNF5zASCRyu9uDVXcrDPpE=;
 b=V6zJ+5oFLHvqD11c57htm9uSi+a7o6MAcg1JXH3CfPsFZbfn9oTiH7mTo1pt2Vqt5KQPoR
 pQDsfmsVkRp5ijAet4uuWpt9PIrWJ19YKZ0zuFmQN3Q4VVDLXEEtieTOB4vGDWlylFSkVs
 0EQWvtEtndh7y6UXQTKXbSypi2LXCYY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-nBttRGmdPT2XDNfdHyNUqg-1; Tue, 04 Jun 2024 03:38:54 -0400
X-MC-Unique: nBttRGmdPT2XDNfdHyNUqg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 74C7980027F;
 Tue,  4 Jun 2024 07:38:54 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.72.112.238])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 94AA9492BD4;
 Tue,  4 Jun 2024 07:38:52 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Jason Wang <jasowang@redhat.com>
Subject: [PULL 18/20] ebpf: Add a separate target for skeleton
Date: Tue,  4 Jun 2024 15:37:53 +0800
Message-ID: <20240604073755.1859-19-jasowang@redhat.com>
In-Reply-To: <20240604073755.1859-1-jasowang@redhat.com>
References: <20240604073755.1859-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Akihiko Odaki <akihiko.odaki@daynix.com>

This generalizes the rule to generate the skeleton and allows to add
another.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 tools/ebpf/Makefile.ebpf | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/tools/ebpf/Makefile.ebpf b/tools/ebpf/Makefile.ebpf
index 3391e7ce08..572ca5987a 100755
--- a/tools/ebpf/Makefile.ebpf
+++ b/tools/ebpf/Makefile.ebpf
@@ -1,23 +1,24 @@
-OBJS = rss.bpf.o
+SKELETONS = rss.bpf.skeleton.h
 
 LLVM_STRIP ?= llvm-strip
 CLANG ?= clang
 INC_FLAGS = `$(CLANG) -print-file-name=include`
 EXTRA_CFLAGS ?= -O2 -g -target bpf
 
-all: $(OBJS)
+all: $(SKELETONS)
 
 .PHONY: clean
 
 clean:
-	rm -f $(OBJS)
-	rm -f rss.bpf.skeleton.h
+	rm -f $(SKELETONS) $(SKELETONS:%.skeleton.h=%.o)
 
-$(OBJS):  %.o:%.c
+%.o: %.c
 	$(CLANG) $(INC_FLAGS) \
                 -D__KERNEL__ -D__ASM_SYSREG_H \
                 -I../include $(LINUXINCLUDE) \
                 $(EXTRA_CFLAGS) -c $< -o $@
 	$(LLVM_STRIP) -g $@
-	bpftool gen skeleton rss.bpf.o > rss.bpf.skeleton.h
-	cp rss.bpf.skeleton.h ../../ebpf/
+
+%.skeleton.h: %.o
+	bpftool gen skeleton $< > $@
+	cp $@ ../../ebpf/
-- 
2.42.0


