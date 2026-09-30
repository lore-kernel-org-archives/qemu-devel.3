Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66E28CA5FBA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrkE-0004km-RO; Wed, 30 Sep 2026 06:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBriu-0001VP-2T
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrij-0006o4-Up
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764769;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MbUWg551alio43fvOCVjI035oYb2mkT3olCelknZbQI=;
 b=T79wRqyJvx2uKLejs/Qu3KPeutTKJdAkk9EJkgy1DWnehBF1fYauBbAcr+DOTEkYA9qKVd
 rIYf/CRjWXr9H5ShRDI9EbaxhFx9PqIXMktR15ZNHGTM8KxpHPNqHB/3PYYh6pC7VCnLH7
 7JU7kLwZiBRc0WUUunN8HqCAtWJwCGA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-isbr65-kNtqSm-P0S9qf1A-1; Wed,
 30 Sep 2026 06:39:25 -0400
X-MC-Unique: isbr65-kNtqSm-P0S9qf1A-1
X-Mimecast-MFC-AGG-ID: isbr65-kNtqSm-P0S9qf1A_1790764764
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B16201955E86; Wed, 30 Sep 2026 10:39:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 71CC0768; Wed, 30 Sep 2026 10:39:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A09A221E662A; Wed, 30 Sep 2026 12:39:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 065/105] qapi: convert simple enum intros for cypto.json
Date: Wed, 30 Sep 2026 12:38:30 +0200
Message-ID: <20260930103910.3934848-66-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: John Snow <jsnow@redhat.com>

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260909041640.69080-6-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/crypto.json | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/qapi/crypto.json b/qapi/crypto.json
index f8ff87ec0e..7b4c80edae 100644
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


