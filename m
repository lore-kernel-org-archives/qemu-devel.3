Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDF5DC61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 19:43:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzJWg-0005au-3z; Wed, 26 Aug 2026 15:43:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wzJWd-0005IU-RD
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 15:43:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wzJWb-0006ax-4Y
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 15:43:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787773384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cMeGh8F13Z46uyER7y88/d0ISiPeR9CDwXqnRAPj7ik=;
 b=SGY+bnoeggiFhn/8Us2MKRqipsDoTMdBrN0z8G3Fb9wLNRIYnzxiI4uPeQSfq9ilLcRyK4
 eK+DXYAK5lfYsGTKyZAIeXnHbMW8GxTtxw02EqZskcKJV0Fc1hBJ1vY71MxW0Tgm4qprdR
 wIv5hyJIgsKl+iyIhI9E+9fzgtlepyw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-RGEfCt-ZN6WwwuYaFA6nYg-1; Wed,
 26 Aug 2026 15:43:01 -0400
X-MC-Unique: RGEfCt-ZN6WwwuYaFA6nYg-1
X-Mimecast-MFC-AGG-ID: RGEfCt-ZN6WwwuYaFA6nYg_1787773377
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 06932195396C; Wed, 26 Aug 2026 19:42:57 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.99])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4EFA61800577; Wed, 26 Aug 2026 19:42:49 +0000 (UTC)
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
Subject: [PATCH v3 28/43] qapi: convert trivial intro sections for
 misc-i386.json
Date: Wed, 26 Aug 2026 15:38:25 -0400
Message-ID: <20260826193840.2152000-29-jsnow@redhat.com>
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
 qapi/misc-i386.json | 52 ++++++++++++++++-----------------------------
 1 file changed, 18 insertions(+), 34 deletions(-)

diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index 05a94d6c416..78ec9aec647 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -25,8 +25,7 @@
 
 ##
 # @SevState:
-#
-# An enumeration of SEV state information used during `query-sev`.
+#     An enumeration of SEV state information used during `query-sev`.
 #
 # @uninit: The guest is uninitialized.
 #
@@ -52,8 +51,7 @@
 
 ##
 # @SevGuestType:
-#
-# An enumeration indicating the type of SEV guest being run.
+#     An enumeration indicating the type of SEV guest being run.
 #
 # @sev: The guest is a legacy SEV or SEV-ES guest.
 #
@@ -66,8 +64,7 @@
 
 ##
 # @SevGuestInfo:
-#
-# Information specific to legacy SEV/SEV-ES guests.
+#     Information specific to legacy SEV/SEV-ES guests.
 #
 # @policy: SEV policy value
 #
@@ -81,8 +78,7 @@
 
 ##
 # @SevSnpGuestInfo:
-#
-# Information specific to SEV-SNP guests.
+#     Information specific to SEV-SNP guests.
 #
 # @snp-policy: SEV-SNP policy value
 #
@@ -93,8 +89,7 @@
 
 ##
 # @SevInfo:
-#
-# Information about Secure Encrypted Virtualization (SEV) support
+#     Information about Secure Encrypted Virtualization (SEV) support
 #
 # @enabled: true if SEV is active
 #
@@ -144,8 +139,7 @@
 
 ##
 # @SevLaunchMeasureInfo:
-#
-# SEV Guest Launch measurement information
+#     SEV Guest Launch measurement information
 #
 # @data: the measurement value encoded in base64
 #
@@ -180,9 +174,8 @@
 
 ##
 # @SevCapability:
-#
-# The struct describes capability for a Secure Encrypted
-# Virtualization feature.
+#     The struct describes capability for a Secure Encrypted
+#     Virtualization feature.
 #
 # @pdh: Platform Diffie-Hellman key (base64 encoded)
 #
@@ -252,9 +245,8 @@
 
 ##
 # @SevAttestationReport:
-#
-# The struct describes attestation report for a Secure Encrypted
-# Virtualization feature.
+#     The struct describes attestation report for a Secure Encrypted
+#     Virtualization feature.
 #
 # @data: guest attestation report (base64 encoded)
 #
@@ -294,8 +286,7 @@
 
 ##
 # @SgxEpcSection:
-#
-# Information about intel SGX EPC section
+#     Information about intel SGX EPC section
 #
 # @node: the numa node
 #
@@ -309,8 +300,7 @@
 
 ##
 # @SgxInfo:
-#
-# Information about intel Safe Guard eXtension (SGX) support
+#     Information about intel Safe Guard eXtension (SGX) support
 #
 # @sgx: true if SGX is supported
 #
@@ -333,8 +323,7 @@
 
 ##
 # @query-sgx:
-#
-# Return information about configured SGX capabilities of guest
+#     Return information about configured SGX capabilities of guest
 #
 # Since: 6.2
 #
@@ -350,8 +339,7 @@
 
 ##
 # @query-sgx-capabilities:
-#
-# Return information about SGX capabilities of host
+#     Return information about SGX capabilities of host
 #
 # Since: 6.2
 #
@@ -367,8 +355,7 @@
 
 ##
 # @EvtchnPortType:
-#
-# An enumeration of Xen event channel port types.
+#     An enumeration of Xen event channel port types.
 #
 # @closed: The port is unused.
 #
@@ -389,8 +376,7 @@
 
 ##
 # @EvtchnInfo:
-#
-# Information about a Xen event channel port
+#     Information about a Xen event channel port
 #
 # @port: the port number
 #
@@ -419,8 +405,7 @@
 
 ##
 # @xen-event-list:
-#
-# Query the Xen event channels opened by the guest.
+#     Query the Xen event channels opened by the guest.
 #
 # Returns: list of open event channel ports.
 #
@@ -456,8 +441,7 @@
 
 ##
 # @xen-event-inject:
-#
-# Inject a Xen event channel port (interrupt) to the guest.
+#     Inject a Xen event channel port (interrupt) to the guest.
 #
 # @port: The port number
 #
-- 
2.55.0


