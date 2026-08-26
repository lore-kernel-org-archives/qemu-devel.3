Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66DB2C61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 19:41:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzJUR-0006k2-7r; Wed, 26 Aug 2026 15:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wzJUP-0006he-Uo
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 15:40:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wzJUN-0006A5-Ud
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 15:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787773247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YyMOc6fNO8ZdqDV2gIzSN+VkTBXIJrB1icvyY+sOx3Y=;
 b=aTYmIKj/STew8Hm6IF45FGV5TWAOrujPR3VOX62mPxZRUYep0vCc2ZyywX7SgIxFdHDsPk
 Qo8YMf7WkFsIfNSb0H+ZwyX9lfcwfPkl7bNbtspsKs82Q7qY6MD63qtt7pK2RcK6DrzD7U
 /HYMVAH8UodZaUF7G2jyhJvjl0QC15E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-686-h9nhMAl7Pb-spv-dC6Xvtg-1; Wed,
 26 Aug 2026 15:40:42 -0400
X-MC-Unique: h9nhMAl7Pb-spv-dC6Xvtg-1
X-Mimecast-MFC-AGG-ID: h9nhMAl7Pb-spv-dC6Xvtg_1787773237
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E7E4A19540EF; Wed, 26 Aug 2026 19:40:36 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.99])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 059591800577; Wed, 26 Aug 2026 19:40:28 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 John Snow <jsnow@redhat.com>, linux-cxl@vger.kernel.org,
 Markus Armbruster <armbru@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>, qemu-trivial@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Jiri Pirko <jiri@resnulli.us>,
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, linux-edac@vger.kernel.org,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Jonathan Cameron <jic23@kernel.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Lukas Straub <lukasstraub2@web.de>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v3 11/43] qapi: convert trivial intro sections for authz.json
Date: Wed, 26 Aug 2026 15:38:08 -0400
Message-ID: <20260826193840.2152000-12-jsnow@redhat.com>
In-Reply-To: <20260826193840.2152000-1-jsnow@redhat.com>
References: <20260826193840.2152000-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/authz.json | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/qapi/authz.json b/qapi/authz.json
index bc1123cc053..b76c39c53af 100644
--- a/qapi/authz.json
+++ b/qapi/authz.json
@@ -9,8 +9,7 @@
 
 ##
 # @QAuthZListPolicy:
-#
-# The authorization policy result
+#     The authorization policy result
 #
 # @deny: deny access
 #
@@ -24,8 +23,7 @@
 
 ##
 # @QAuthZListFormat:
-#
-# The authorization policy match format
+#     The authorization policy match format
 #
 # @exact: an exact string match
 #
@@ -39,8 +37,7 @@
 
 ##
 # @QAuthZListRule:
-#
-# A single authorization rule.
+#     A single authorization rule.
 #
 # @match: a string or glob to match against a user identity
 #
@@ -57,8 +54,7 @@
 
 ##
 # @AuthZListProperties:
-#
-# Properties for authz-list objects.
+#     Properties for authz-list objects.
 #
 # @policy: Default policy to apply when no rule matches (default:
 #     deny)
@@ -73,8 +69,7 @@
 
 ##
 # @AuthZListFileProperties:
-#
-# Properties for authz-listfile objects.
+#     Properties for authz-listfile objects.
 #
 # @filename: File name to load the configuration from.  The file must
 #     contain valid JSON for `AuthZListProperties`.
@@ -93,8 +88,7 @@
 
 ##
 # @AuthZPAMProperties:
-#
-# Properties for authz-pam objects.
+#     Properties for authz-pam objects.
 #
 # @service: PAM service name to use for authorization
 #
@@ -105,8 +99,7 @@
 
 ##
 # @AuthZSimpleProperties:
-#
-# Properties for authz-simple objects.
+#     Properties for authz-simple objects.
 #
 # @identity: Identifies the allowed user.  Its format depends on the
 #     network service that authorization object is associated with.
-- 
2.55.0


