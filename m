Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5E7D185EF
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:15:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdpqx-00075Y-OI; Thu, 08 Jan 2026 08:15:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdpqw-00072J-NJ
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:15:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vdpqv-00006c-1c
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:15:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767878100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t7/bFsf7uC3NxvIbhvNhn1ylFATifpubihNQAOi2f9w=;
 b=K0BEIYoimU6ZsSSSb4ZQNO/1PaB+GdHM/47SraeX2uZJPmxCugPKy2YhElseKSK1SFm98m
 0OY8HiqTn2ha2ulimDlLz/e8DcM8cHppdnx8CPO6OWayKJH1Lo5vxHyKdPHMUlDBdWin9M
 UqfC3+PDgSBu7kyOfpaFX1Revpvu5zE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596--kVPs7BnOcm4CTtO5geRuA-1; Thu,
 08 Jan 2026 08:14:59 -0500
X-MC-Unique: -kVPs7BnOcm4CTtO5geRuA-1
X-Mimecast-MFC-AGG-ID: -kVPs7BnOcm4CTtO5geRuA_1767878098
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6317819560A5; Thu,  8 Jan 2026 13:14:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D52018007D2; Thu,  8 Jan 2026 13:14:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7B0C221E61A9; Thu, 08 Jan 2026 14:14:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: devel@lists.libvirt.org,
	berrange@redhat.com,
	eblake@redhat.com
Subject: [PATCH 1/1] hw/core: Deprecate query-kvm
Date: Thu,  8 Jan 2026 14:14:55 +0100
Message-ID: <20260108131455.2240598-2-armbru@redhat.com>
In-Reply-To: <20260108131455.2240598-1-armbru@redhat.com>
References: <20260108131455.2240598-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

query-accelerators covers all accelerators, and should be used
instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/about/deprecated.rst | 4 ++++
 qapi/accelerator.json     | 8 +++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index b53d885533..49c2dfce53 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -142,6 +142,10 @@ Use ``job-dismiss`` instead.
 
 Use ``job-finalize`` instead.
 
+``query-kvm`` (since 11.0)
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
2.52.0


