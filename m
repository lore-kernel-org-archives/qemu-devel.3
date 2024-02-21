Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD44CC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 16:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcpQq-0007XT-Vf; Wed, 21 Feb 2024 11:26:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcpQp-0007W0-CF
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 11:26:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcpQn-0008Em-35
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 11:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708532808;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CXDKVpwJAYA4YVPBkA8OYk6BlM/3pdgrzFZ7ieOCgNQ=;
 b=ZtiEDVtqfUrb9zn9PNODDgO9+DZN59BO4KQCnkyH1tSn5M7JWIxvjABFJ62+cYx8Jr+bB8
 rQFR/FwSc7gB7Pwbe8vkjDmLShc+oKPSfjjTD2u4/pW9ECgK9wOSBVtGiMaMeK+lr6NPn8
 zps8amItxFMEgckewp9vWs/k011DXl4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-339-1eJx4iy-Py6T3ZXP3xtEJA-1; Wed,
 21 Feb 2024 11:26:42 -0500
X-MC-Unique: 1eJx4iy-Py6T3ZXP3xtEJA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD27F3869152;
 Wed, 21 Feb 2024 16:26:41 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0B958201154D;
 Wed, 21 Feb 2024 16:26:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 1/3] target/ppc/kvm: Replace variable length array in
 kvmppc_save_htab()
Date: Wed, 21 Feb 2024 17:26:34 +0100
Message-ID: <20240221162636.173136-2-thuth@redhat.com>
In-Reply-To: <20240221162636.173136-1-thuth@redhat.com>
References: <20240221162636.173136-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

To be able to compile QEMU with -Wvla (to prevent potential security
issues), we need to get rid of the variable length array in the
kvmppc_save_htab() function. Replace it with a heap allocation instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 target/ppc/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 26fa9d0575..e7e39c3091 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2688,7 +2688,7 @@ int kvmppc_get_htab_fd(bool write, uint64_t index, Error **errp)
 int kvmppc_save_htab(QEMUFile *f, int fd, size_t bufsize, int64_t max_ns)
 {
     int64_t starttime = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
-    uint8_t buf[bufsize];
+    g_autofree uint8_t *buf = g_malloc(bufsize);
     ssize_t rc;
 
     do {
-- 
2.43.2


