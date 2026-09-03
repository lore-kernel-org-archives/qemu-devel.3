Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D45BCC624DE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 20:01:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Dbt-0002Io-BV; Thu, 03 Sep 2026 16:00:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x2Dbr-0002EF-AC
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 16:00:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x2Dbp-0002Pe-Hj
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 16:00:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788465629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MRm71Dz4WThbafrqk1d9xVo/yDE++jOp4zvjHc7rvNQ=;
 b=P6m75YsmQwUO+Q+f6zgAFLaGxoX9ggepdAAWfYJ6WFk+F1N/79RFUlN5ec/8zLjsWU9D5U
 dGBr3ll5Wq/yphqiTnQR1HUYLhHKRn6vpHT/PuwXuFHWehOiI85XN+9dggbLx1CDF9aREx
 WBbOOh3emtgVrxoyBH7BB7CZ+lWPf2A=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-N7ZKlEIIP96HEZA5pOOdHQ-1; Thu,
 03 Sep 2026 16:00:22 -0400
X-MC-Unique: N7ZKlEIIP96HEZA5pOOdHQ-1
X-Mimecast-MFC-AGG-ID: N7ZKlEIIP96HEZA5pOOdHQ_1788465621
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4211C1802543; Thu,  3 Sep 2026 20:00:21 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.104])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C8401955F70; Thu,  3 Sep 2026 20:00:17 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Hanna Reitz <hreitz@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 2/5] qapi: convert simple event intros for net.json
Date: Thu,  3 Sep 2026 16:00:05 -0400
Message-ID: <20260903200008.729791-3-jsnow@redhat.com>
In-Reply-To: <20260903200008.729791-1-jsnow@redhat.com>
References: <20260903200008.729791-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 qapi/net.json | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/qapi/net.json b/qapi/net.json
index 4ea4bd1bc72..7aabd8b9260 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -1135,11 +1135,10 @@
 
 ##
 # @FAILOVER_NEGOTIATED:
-#
-# Emitted when VIRTIO_NET_F_STANDBY was enabled during feature
-# negotiation.  Failover primary devices which were hidden (not
-# hotplugged when requested) before will now be hotplugged by the
-# virtio-net standby device.
+#     Emitted when VIRTIO_NET_F_STANDBY was enabled during feature
+#     negotiation.  Failover primary devices which were hidden (not
+#     hotplugged when requested) before will now be hotplugged by the
+#     virtio-net standby device.
 #
 # @device-id: QEMU device id of the unplugged device
 #
-- 
2.55.0


