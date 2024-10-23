Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79EE0CF5389
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 13:20:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3bFy-0007av-IX; Wed, 23 Oct 2024 09:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3bFm-0007Se-NV
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:18:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t3bFk-0002HV-Nm
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 09:18:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729689500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ls0Cupa2zkUdIvrUHHxruSg8WKF/uDeEseqz/Io4VRo=;
 b=eGO0pXWk6nkgDEKOkOsIfDKccCNftw+1Fe1CsJdGo3lwtOAwsUlRdwPMAY4sRLOdoSR7Rx
 P95vJyZBADugNjTbsmJkSgf4yZJwV2Mj/bZH6752CjpBWI2XuCh4a62+w74G+1d/Z5KMFF
 xlYV7fs4J3UGqdIfWkUR39hDVPIMAic=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-kjgRgOECMzWrLwi8uSXPBg-1; Wed,
 23 Oct 2024 09:18:16 -0400
X-MC-Unique: kjgRgOECMzWrLwi8uSXPBg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5BC241955DA6; Wed, 23 Oct 2024 13:18:11 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.43])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 477B219560AE; Wed, 23 Oct 2024 13:18:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Marc Hartmayer <mhartmay@linux.ibm.com>
Subject: [PULL 22/23] pc-bios/s390-ccw: Introduce `EXTRA_LDFLAGS`
Date: Wed, 23 Oct 2024 15:17:09 +0200
Message-ID: <20241023131710.906748-23-thuth@redhat.com>
In-Reply-To: <20241023131710.906748-1-thuth@redhat.com>
References: <20241023131710.906748-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.263,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Marc Hartmayer <mhartmay@linux.ibm.com>

Some packaging tools want to override `LDFLAGS` when building QEMU, this will
result in a build error as most likely no `-nostdlib` flag is passed. Introduce
`EXTRA_LDFLAGS` so that the packager can override `LDFLAGS` without breaking the
build.

Signed-off-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Message-ID: <20241001153618.17791-4-mhartmay@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
[thuth: Drop the hunk to netbook.mak which is not necessary anymore]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/pc-bios/s390-ccw/Makefile b/pc-bios/s390-ccw/Makefile
index 38254e22df..dc69dd484f 100644
--- a/pc-bios/s390-ccw/Makefile
+++ b/pc-bios/s390-ccw/Makefile
@@ -4,6 +4,7 @@ all: build-all
 
 include config-host.mak
 CFLAGS = -O2 -g -I $(SRC_PATH)/../../include/hw/s390x/ipl
+LDFLAGS ?=
 MAKEFLAGS += -rR
 
 GIT_SUBMODULES = roms/SLOF
@@ -46,7 +47,7 @@ EXTRA_CFLAGS += -fwrapv -fno-strict-aliasing -fno-asynchronous-unwind-tables
 EXTRA_CFLAGS += -msoft-float
 EXTRA_CFLAGS += -std=gnu99
 EXTRA_CFLAGS += $(LIBC_INC) $(LIBNET_INC)
-LDFLAGS += -Wl,-pie -nostdlib -z noexecstack -z text
+EXTRA_LDFLAGS += -Wl,-pie -nostdlib -z noexecstack -z text
 
 cc-test = $(CC) -Werror $1 -c -o /dev/null -xc /dev/null >/dev/null 2>/dev/null
 cc-option = if $(call cc-test, $1); then \
@@ -111,7 +112,7 @@ libnet.a: $(LIBNETOBJS)
 build-all: s390-ccw.img
 
 s390-ccw.elf: $(OBJECTS) libnet.a libc.a
-	$(call quiet-command,$(CC) $(LDFLAGS) -o $@ $^,Linking)
+	$(call quiet-command,$(CC) $(EXTRA_LDFLAGS) $(LDFLAGS) -o $@ $^,Linking)
 
 s390-ccw.img: s390-ccw.elf
 	$(call quiet-command,$(STRIP) --strip-unneeded $< -o $@,Stripping $< into)
-- 
2.47.0


