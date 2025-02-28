Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E23BC19776
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 10:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnxcG-0003nr-Nm; Fri, 28 Feb 2025 05:29:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tnxbQ-0002Fl-FO
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tnxbI-0002xE-8D
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 05:28:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740738487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C+vs0hUE4G8QfmkjwpQAttK38VFjsZM5dFpO3uphePk=;
 b=YMYpc+w5rE1XT/R2PuhON9z+5TPqa7IXDT0rqj9dA/+4MttDKrf/2FxkM6aumOL5Te1eEB
 vzNcuHEkIHlSRepoo0tjS1NYdXbDaPMkTUojR2jb3wihInHVUIzn9Ewm9niuSOHhXtP2AB
 TtCoNbOv2UtkZwU59MxPBmvq+Y5UlhI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-381-IgZOjTuxNw6T5E_0RMKJkw-1; Fri,
 28 Feb 2025 05:28:03 -0500
X-MC-Unique: IgZOjTuxNw6T5E_0RMKJkw-1
X-Mimecast-MFC-AGG-ID: IgZOjTuxNw6T5E_0RMKJkw_1740738482
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 461A51800876; Fri, 28 Feb 2025 10:28:02 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.45])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2B862180035F; Fri, 28 Feb 2025 10:27:57 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc@nongnu.org
Subject: [PATCH v2 4/7] tests/functional: reduce tuxrun maxmem to work on
 32-bit hosts
Date: Fri, 28 Feb 2025 10:27:35 +0000
Message-ID: <20250228102738.3064045-5-berrange@redhat.com>
In-Reply-To: <20250228102738.3064045-1-berrange@redhat.com>
References: <20250228102738.3064045-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

maxmem=4G is too large to address on 32-bit hosts, so reduce it
to 2G since the tuxrun tests don't actually need such an elevated
memory limit.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/functional/test_ppc64_tuxrun.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/functional/test_ppc64_tuxrun.py b/tests/functional/test_ppc64_tuxrun.py
index 05c6162b5e..e8f79c676e 100755
--- a/tests/functional/test_ppc64_tuxrun.py
+++ b/tests/functional/test_ppc64_tuxrun.py
@@ -64,7 +64,7 @@ def ppc64_common_tuxrun(self, kernel_asset, rootfs_asset, prefix):
                          ',"index":1,"id":"pci.1"}')
         self.vm.add_args('-device', '{"driver":"spapr-vscsi","id":"scsi1"'
                          ',"reg":12288}')
-        self.vm.add_args('-m', '2G,slots=32,maxmem=4G',
+        self.vm.add_args('-m', '1G,slots=32,maxmem=2G',
                          '-object', 'memory-backend-ram,id=ram1,size=1G',
                          '-device', 'pc-dimm,id=dimm1,memdev=ram1')
 
-- 
2.48.1


