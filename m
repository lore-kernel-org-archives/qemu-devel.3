Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4B78C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 10:26:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpQUG-0007OK-4R; Wed, 27 Mar 2024 06:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rpQT7-0007CM-Nt
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 06:25:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1rpQT5-0007DA-6B
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 06:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711535113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jHbVlOjBtqx0P1bEevoloJAWLqcu0B7esEb/byrU0Mk=;
 b=PBLUxeClIiAl+gx9I/AbAOOHe4pjzEzmPUpxcRpiV3UM8SiDCt7cJmZQEd0xwADNJT4F3v
 dOv+J+h5XgIS5GIS4uVucRn+AU6mtVZPl6EKjhIEs5tYXmTNi6PE2dZ0+RUXnVKA9hHvQ/
 O1tbBk3JCi3VQN2lp2YAegNn5DOGvmg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-tXhGZapNNxqfQZyDkkjQlg-1; Wed, 27 Mar 2024 06:25:10 -0400
X-MC-Unique: tXhGZapNNxqfQZyDkkjQlg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B55248164E1;
 Wed, 27 Mar 2024 10:25:09 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.194.77])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 597323C54;
 Wed, 27 Mar 2024 10:25:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 450CE18009DD; Wed, 27 Mar 2024 11:24:48 +0100 (CET)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 1/3] edk2: get version + date from git submodule
Date: Wed, 27 Mar 2024 11:24:45 +0100
Message-ID: <20240327102448.61877-2-kraxel@redhat.com>
In-Reply-To: <20240327102448.61877-1-kraxel@redhat.com>
References: <20240327102448.61877-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Turned out hard-coding version and date in the Makefile wasn't a bright
idea.  Updating it on edk2 updates is easily forgotten.  Fetch the info
from git instead.  Store in edk2-version, so this can be committed to
the repo and is present in tarballs too.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 roms/Makefile | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/roms/Makefile b/roms/Makefile
index edc234a0e886..783a5cab4f4c 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -52,6 +52,8 @@ SEABIOS_EXTRAVERSION="-prebuilt.qemu.org"
 #
 EDK2_EFIROM = edk2/BaseTools/Source/C/bin/EfiRom
 
+-include edk2-version
+
 default help:
 	@echo "nothing is build by default"
 	@echo "available build targets:"
@@ -147,10 +149,19 @@ skiboot:
 	$(MAKE) -C skiboot CROSS=$(powerpc64_cross_prefix)
 	cp skiboot/skiboot.lid ../pc-bios/skiboot.lid
 
-efi:
+edk2-version: edk2
+	if test -e edk2/.git; then \
+		echo "EDK2_STABLE = $$(cd edk2; git describe --tags --match 'edk2-stable*')" > $@; \
+		echo "EDK2_DATE = $$(cd edk2; git log -1 --pretty='format:%cd' --date='format:%m/%d/%Y')" >> $@; \
+	else \
+		touch $@; \
+	fi
+
+efi: edk2-version
 	$(PYTHON) edk2-build.py --config edk2-build.config \
-		--version-override "edk2-stable202302-for-qemu" \
-		--release-date "03/01/2023"
+		--version-override "$(EDK2_STABLE)-for-qemu" \
+		--release-date "$(EDK2_DATE)" \
+		--silent --no-logs
 	rm -f ../pc-bios/edk2-*.fd.bz2
 	bzip2 --verbose ../pc-bios/edk2-*.fd
 
-- 
2.44.0


