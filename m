Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1ECFC54764
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 16:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcpQz-0007fU-IV; Wed, 21 Feb 2024 11:27:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcpQx-0007di-5I
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 11:26:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rcpQq-0008ID-Dh
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 11:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708532811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wt6FO/BOJi8+tOHcjCIUSz3bCg3PpFu/35Ra4LjGzGg=;
 b=C7M1LVzd4TwpS5tZHHi+MdDEjiWdqCoO/mPH8DjoL0iURb8eTdp744DEUMaxmrqEjY77/R
 qQQuv/bN3tQi/hSv5Th/MEwqyrRFRyv7zD3gskti/7HGmdLQBUMenYhnIgyq2wKn28/wej
 VGNbWu/0WU4VFz6PXyfEGGJEcUFEQXM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-0OdJL2h_OeGEQATgiojoYA-1; Wed,
 21 Feb 2024 11:26:46 -0500
X-MC-Unique: 0OdJL2h_OeGEQATgiojoYA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 404B63869150;
 Wed, 21 Feb 2024 16:26:46 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7552120169D6;
 Wed, 21 Feb 2024 16:26:44 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-ppc@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 3/3] meson: Enable -Wvla
Date: Wed, 21 Feb 2024 17:26:36 +0100
Message-ID: <20240221162636.173136-4-thuth@redhat.com>
In-Reply-To: <20240221162636.173136-1-thuth@redhat.com>
References: <20240221162636.173136-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

From: Peter Maydell <peter.maydell@linaro.org>

QEMU has historically used variable length arrays only very rarely.
Variable length arrays are a potential security issue where an
on-stack dynamic allocation isn't correctly size-checked, especially
when the size comes from the guest.  (An example problem of this kind
from the past is CVE-2021-3527).  Forbidding them entirely is a
defensive measure against further bugs of this kind.

Enable -Wvla to prevent any new uses from sneaking into the codebase.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20240125173211.1786196-3-peter.maydell@linaro.org>
[thuth: rebased to current master branch]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 meson.build | 1 +
 1 file changed, 1 insertion(+)

diff --git a/meson.build b/meson.build
index c1dc83e4c0..0ef1654e86 100644
--- a/meson.build
+++ b/meson.build
@@ -592,6 +592,7 @@ warn_flags = [
   '-Wstrict-prototypes',
   '-Wtype-limits',
   '-Wundef',
+  '-Wvla',
   '-Wwrite-strings',
 
   # Then disable some undesirable warnings
-- 
2.43.2


