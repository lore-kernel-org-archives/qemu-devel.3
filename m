Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0DBCC61DD3
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 19:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1UOz-00064k-Vb; Tue, 01 Sep 2026 15:44:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x1UOx-00064I-TF
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 15:44:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x1UOw-0002KZ-Ka
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 15:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788291850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EhEPoJOfAPJl4Q3bWi/DoXMalBBiohSqVhqdrnGXTGk=;
 b=UR0um90npOtowoAtUkXK1UHAA7aNd/zM1aK8crgw5N5e+22ygo6Pvqpcfd3QEam9hQZ47/
 hxaXmoqzEEmOAYzttKkn77Ov3WKj42fhYDaIOQp/eQPKudAQvFrsB11DgWyYlcNJ6RoeM4
 HuUHi8wEa/Dw6eqiBR6ZayIupGmJHj0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-005aYDdtPKyfxZWVS1Ysrg-1; Tue,
 01 Sept 2026 15:44:06 -0400
X-MC-Unique: 005aYDdtPKyfxZWVS1Ysrg-1
X-Mimecast-MFC-AGG-ID: 005aYDdtPKyfxZWVS1Ysrg_1788291845
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4514B1844069; Tue,  1 Sep 2026 19:44:05 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.192])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1C92B18005B8; Tue,  1 Sep 2026 19:44:00 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, linux-cxl@vger.kernel.org,
 Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Peter Xu <peterx@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 07/12] qapi: convert simple command intros for block.json
Date: Tue,  1 Sep 2026 15:43:19 -0400
Message-ID: <20260901194324.458482-8-jsnow@redhat.com>
In-Reply-To: <20260901194324.458482-1-jsnow@redhat.com>
References: <20260901194324.458482-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/block.json | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qapi/block.json b/qapi/block.json
index 189f2e28204..9569afc6e0f 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -261,10 +261,10 @@
 
 ##
 # @blockdev-insert-medium:
-#
-# Inserts a medium (a block driver state tree) into a block device.
-# That block device's tray must currently be open (unless there is no
-# attached guest device) and there must be no medium inserted already.
+#     Inserts a medium (a block driver state tree) into a block
+#     device.  That block device's tray must currently be open (unless
+#     there is no attached guest device) and there must be no medium
+#     inserted already.
 #
 # @id: The name or QOM path of the guest device
 #
-- 
2.55.0


