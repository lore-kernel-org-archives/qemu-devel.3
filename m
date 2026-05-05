Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6563CD342F
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 11:51:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKEIa-0000JH-TE; Tue, 05 May 2026 07:50:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKEIY-0000HF-GH
 for qemu-devel@nongnu.org; Tue, 05 May 2026 07:50:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wKEIV-0001Ve-MR
 for qemu-devel@nongnu.org; Tue, 05 May 2026 07:50:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777981841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SvAbOhcz+g8BifOLMt0mxeaHpQAEBZipKDjwlRTHOpE=;
 b=XL4/FJTx0iQLT07cWCHYyAeu7N5yPQo6hl/6WmfXY/QGaDjo97teF2Ax73Jx6NxpbHgUQx
 zhrT9vRiLbhMo/u6efuXLo2xNnG5f0TgFKli+/qKrCBOX+/KzJtjx9fiIcikDL833XFyp9
 aEILUoHCRO8Sop2O5yzDgjEy9Rw600M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-Xd3rwezbO3Sdqpi_9wLotg-1; Tue,
 05 May 2026 07:50:40 -0400
X-MC-Unique: Xd3rwezbO3Sdqpi_9wLotg-1
X-Mimecast-MFC-AGG-ID: Xd3rwezbO3Sdqpi_9wLotg_1777981839
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B93EE195609E; Tue,  5 May 2026 11:50:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5500F30001A1; Tue,  5 May 2026 11:50:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C2D8821E6A02; Tue, 05 May 2026 13:50:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 1/5] hw/core: Deprecate query-kvm
Date: Tue,  5 May 2026 13:50:32 +0200
Message-ID: <20260505115036.1170186-2-armbru@redhat.com>
In-Reply-To: <20260505115036.1170186-1-armbru@redhat.com>
References: <20260505115036.1170186-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

query-accelerators covers all accelerators, and should be used
instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20260108131455.2240598-2-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[Rebased, missing section title markup fixed]
---
 docs/about/deprecated.rst | 5 +++++
 qapi/accelerator.json     | 8 +++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 10de10dc23..5551bd12ad 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -149,6 +149,11 @@ Use ``job-dismiss`` instead.
 
 Use ``job-finalize`` instead.
 
+``query-kvm`` (since 11.0)
+''''''''''''''''''''''''''
+
+Use ``query-accelerators`` instead.
+
 Human Machine Protocol (HMP) commands
 -------------------------------------
 
diff --git a/qapi/accelerator.json b/qapi/accelerator.json
index 0cf5e0f9d9..b59df37866 100644
--- a/qapi/accelerator.json
+++ b/qapi/accelerator.json
@@ -29,6 +29,11 @@
 #
 # Return information about KVM acceleration
 #
+# Features:
+#
+# @deprecated: This command is deprecated.  Use `query-accelerators`
+#     instead.
+#
 # Since: 0.14
 #
 # .. qmp-example::
@@ -36,7 +41,8 @@
 #     -> { "execute": "query-kvm" }
 #     <- { "return": { "enabled": true, "present": true } }
 ##
-{ 'command': 'query-kvm', 'returns': 'KvmInfo' }
+{ 'command': 'query-kvm', 'returns': 'KvmInfo',
+  'features': [ 'deprecated' ] }
 
 ##
 # @x-accel-stats:
-- 
2.54.0


