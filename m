Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C097C67861
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 16:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruEMO-0001oX-Ad; Tue, 09 Apr 2024 12:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1ruEMD-0001mS-DS
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:30:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1ruEMA-0005iG-4h
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 12:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712680197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nVB2Xy3b3M2XySmg3X05h6P0VJP9tjhRzj4PvS3NiNc=;
 b=bSC48OKVen1r9OUvv4ybdVCxbGwxV4EwE3EA+JC/NOSeieqXG0mmq7cNCNymEKnmVnLx4l
 zzq2TKHMboSINKU4+pjwXWmHg4r+TNVu3GLHLFZdOtlpY3HUKEU2VnW71eqRT2pN84z7Yz
 xPa8vhOiChoplv0Pag1KH3HpkN8Avv8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-fr4qDwzGNiyLDyvL0wTH2w-1; Tue, 09 Apr 2024 12:29:54 -0400
X-MC-Unique: fr4qDwzGNiyLDyvL0wTH2w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 044F980B517;
 Tue,  9 Apr 2024 16:29:54 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.204])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 994271C06666;
 Tue,  9 Apr 2024 16:29:53 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id BB2E01801AA4; Tue,  9 Apr 2024 18:29:42 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 3/4] edk2/seabios: use common extra version
Date: Tue,  9 Apr 2024 18:29:33 +0200
Message-ID: <20240409162942.454419-4-kraxel@redhat.com>
In-Reply-To: <20240409162942.454419-1-kraxel@redhat.com>
References: <20240409162942.454419-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.701,
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

Bring a bit more consistency into the naming.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20240327102448.61877-4-kraxel@redhat.com>
---
 roms/Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/roms/Makefile b/roms/Makefile
index 783a5cab4f4c..dfed2b216a1e 100644
--- a/roms/Makefile
+++ b/roms/Makefile
@@ -41,8 +41,8 @@ x86_64_cross_prefix := $(call find-cross-prefix,x86_64)
 riscv32_cross_prefix := $(call find-cross-prefix,riscv32)
 riscv64_cross_prefix := $(call find-cross-prefix,riscv64)
 
-# tag our seabios builds
-SEABIOS_EXTRAVERSION="-prebuilt.qemu.org"
+# tag our firmware builds
+FIRMWARE_EXTRAVERSION = -prebuilt.qemu.org
 
 #
 # EfiRom utility is shipped with edk2 / tianocore, in BaseTools/
@@ -93,12 +93,12 @@ build-seabios-config-%: config.%
 	mkdir -p seabios/builds/$*
 	cp $< seabios/builds/$*/.config
 	$(MAKE) -C seabios \
-		EXTRAVERSION=$(SEABIOS_EXTRAVERSION) \
+		EXTRAVERSION=$(FIRMWARE_EXTRAVERSION) \
 		CROSS_PREFIX=$(x86_64_cross_prefix) \
 		KCONFIG_CONFIG=$(CURDIR)/seabios/builds/$*/.config \
 		OUT=$(CURDIR)/seabios/builds/$*/ oldnoconfig
 	$(MAKE) -C seabios \
-		EXTRAVERSION=$(SEABIOS_EXTRAVERSION) \
+		EXTRAVERSION=$(FIRMWARE_EXTRAVERSION) \
 		CROSS_PREFIX=$(x86_64_cross_prefix) \
 		KCONFIG_CONFIG=$(CURDIR)/seabios/builds/$*/.config \
 		OUT=$(CURDIR)/seabios/builds/$*/ all
@@ -159,7 +159,7 @@ edk2-version: edk2
 
 efi: edk2-version
 	$(PYTHON) edk2-build.py --config edk2-build.config \
-		--version-override "$(EDK2_STABLE)-for-qemu" \
+		--version-override "$(EDK2_STABLE)$(FIRMWARE_EXTRAVERSION)" \
 		--release-date "$(EDK2_DATE)" \
 		--silent --no-logs
 	rm -f ../pc-bios/edk2-*.fd.bz2
-- 
2.44.0


