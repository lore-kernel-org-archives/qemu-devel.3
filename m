Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B88DC79FAD
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 04:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x49kJ-0004Zi-D8; Wed, 09 Sep 2026 00:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x49kH-0004Yf-Ba
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 00:17:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x49kF-0006En-Lw
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 00:17:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788927431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GJv7qyWi217tPFTj0YVcoCML2GVR1dwSHdfok6KPC5Q=;
 b=bASEni/dCjrnXyWbAP6wubd2MGaqHqR22n+eoJU4om4zVNkqL0cvH9Zl87RJVvdyZBe4/4
 8NG8SBA8HltJ5PMYP9d06e8gnFlS3hv5P3HcZUKNN/SRS4a7y1FToe+NLf/ZiGAZe40N14
 cs/t1Va35/6zBgY0n+lCvatvxziEpZI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-275-XM9bn1eIO6eZXovImfyStg-1; Wed,
 09 Sep 2026 00:17:06 -0400
X-MC-Unique: XM9bn1eIO6eZXovImfyStg-1
X-Mimecast-MFC-AGG-ID: XM9bn1eIO6eZXovImfyStg_1788927425
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2FC4D1955D81; Wed,  9 Sep 2026 04:17:05 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.38])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A159E18004D4; Wed,  9 Sep 2026 04:17:02 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jonathan Cameron <jic23@kernel.org>, Lukas Straub <lukasstraub2@web.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Hanna Reitz <hreitz@redhat.com>,
 linux-cxl@vger.kernel.org, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 05/10] qapi: convert simple enum intros for cypto.json
Date: Wed,  9 Sep 2026 00:16:35 -0400
Message-ID: <20260909041640.69080-6-jsnow@redhat.com>
In-Reply-To: <20260909041640.69080-1-jsnow@redhat.com>
References: <20260909041640.69080-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
 qapi/crypto.json | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/qapi/crypto.json b/qapi/crypto.json
index 5e395bc10c7..f85d1cebed3 100644
--- a/qapi/crypto.json
+++ b/qapi/crypto.json
@@ -10,10 +10,10 @@
 
 ##
 # @QCryptoTLSCredsEndpoint:
-#
-# The type of network endpoint that will be using the credentials.
-# Most types of credential require different setup / structures
-# depending on whether they will be used in a server versus a client.
+#     The type of network endpoint that will be using the credentials.
+#     Most types of credential require different setup / structures
+#     depending on whether they will be used in a server versus a
+#     client.
 #
 # @client: the network endpoint is acting as the client
 #
@@ -126,11 +126,11 @@
 
 ##
 # @QCryptoIVGenAlgo:
-#
-# The supported algorithms for generating initialization vectors for
-# full disk encryption.  The 'plain' generator should not be used for
-# disks with sector numbers larger than 2^32, except where
-# compatibility with pre-existing Linux dm-crypt volumes is required.
+#     The supported algorithms for generating initialization vectors
+#     for full disk encryption.  The 'plain' generator should not be
+#     used for disks with sector numbers larger than 2^32, except
+#     where compatibility with pre-existing Linux dm-crypt volumes is
+#     required.
 #
 # @plain: 64-bit sector number truncated to 32-bits
 #
-- 
2.55.0


