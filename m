Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 161CEC98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 20:58:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x97Yg-0000kQ-S5; Tue, 22 Sep 2026 16:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x97Xd-0000LE-N0
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:56:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x97Xb-000475-Ij
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 16:56:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790110598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SVKoXCiUlqOAS/0KYnSHA7TIvXWU/E1ZDQu+rckw7oo=;
 b=JEglS6ovB+EyWXBXXfcqlgs3IJveBGVB8J7SoTtCP6gvRGz1/cipzKwvkcGyoQw7fIgC3+
 Bpx831pYf/22omRYCSEvk1Ej4xhWjqkgg/KUrAHAz5L4viYPAOG5xEaTjOfaANOs9odqvv
 iQSgGHp5t9GhUjxMzwC5d76LC1y4LZk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-U2zqS24VMxqYKiZdIqknXA-1; Tue,
 22 Sep 2026 16:56:34 -0400
X-MC-Unique: U2zqS24VMxqYKiZdIqknXA-1
X-Mimecast-MFC-AGG-ID: U2zqS24VMxqYKiZdIqknXA_1790110593
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DCB35195DE4F; Tue, 22 Sep 2026 20:56:32 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.125])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 94CE01956086; Tue, 22 Sep 2026 20:56:29 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, Eric Blake <eblake@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 5/8] qapi: split intros at natural cutoff points for
 qga/qapi-schema.json
Date: Tue, 22 Sep 2026 16:56:02 -0400
Message-ID: <20260922205605.501602-6-jsnow@redhat.com>
In-Reply-To: <20260922205605.501602-1-jsnow@redhat.com>
References: <20260922205605.501602-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Note that these intro conversions introduce a new intro/details split
point. This new split point may or may not change the rendered output
depending on if any documentation is auto-generated and inserted for
this definition.

This has tangible effects on how @guest-fsfreeze-status documentation
is rendered, while the other two appear unchanged.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qga/qapi-schema.json | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index b592b14a011..19b0958b84e 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -401,8 +401,7 @@
 
 ##
 # @guest-fsfreeze-status:
-#
-# Get guest fsfreeze state.
+#     Get guest fsfreeze state.
 #
 # .. note:: This may fail to properly report the current state as a
 #    result of some other guest processes having issued an fs
@@ -925,9 +924,8 @@
 
 ##
 # @GuestNVMeSmart:
-#
-# NVMe smart information, based on NVMe specification, section
-# <SMART / Health Information (Log Identifier 02h)>
+#     NVMe smart information, based on NVMe specification, section
+#     <SMART / Health Information (Log Identifier 02h)>
 #
 # TODO: document members briefly
 #
@@ -1816,8 +1814,7 @@
 
 ##
 # @guest-get-load:
-#
-# Retrieve CPU process load information
+#     Retrieve CPU process load information
 #
 # .. note:: Windows does not have load average API, so QGA emulates it
 #    by calculating the average CPU usage in the last 1, 5, 15 minutes
-- 
2.55.0


