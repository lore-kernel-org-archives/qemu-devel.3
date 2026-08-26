Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74ED9C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 19:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzJV2-00084a-D7; Wed, 26 Aug 2026 15:41:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wzJV1-00081H-BL
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 15:41:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wzJUz-0006H6-RA
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 15:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787773285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=53kJeaXAGXWbWgaUWrPPbMnvvgjeb4ogml1Llx3Dmyw=;
 b=Fd1LtF/IGEEiSoAxkkMeVsUtr9q9aWQ6xdIbYVPtJq/rfTga7wRfu16RczYCDNykKUTcJb
 OCNZgMDgOh8A0o3aoKLaAkUkhFnXHoqKdx2LPuZXtcCbWw2xHjahMtt0IdYHcfBJQDxhL4
 XkaJLQd9Pe7LHtcouChFK0x+bl9tSgI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-156-QxcOtTN2MnO5K11xoKHofQ-1; Wed,
 26 Aug 2026 15:41:21 -0400
X-MC-Unique: QxcOtTN2MnO5K11xoKHofQ-1
X-Mimecast-MFC-AGG-ID: QxcOtTN2MnO5K11xoKHofQ_1787773277
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C1670191FCFE; Wed, 26 Aug 2026 19:41:17 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.99])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 00ECB1800577; Wed, 26 Aug 2026 19:41:09 +0000 (UTC)
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
Subject: [PATCH v3 16/43] qapi: convert trivial intro sections for tpm.json
Date: Wed, 26 Aug 2026 15:38:13 -0400
Message-ID: <20260826193840.2152000-17-jsnow@redhat.com>
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
 qapi/tpm.json | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/qapi/tpm.json b/qapi/tpm.json
index 3f2850a5733..6d94be656ae 100644
--- a/qapi/tpm.json
+++ b/qapi/tpm.json
@@ -10,8 +10,7 @@
 
 ##
 # @TpmModel:
-#
-# An enumeration of TPM models
+#     An enumeration of TPM models
 #
 # @tpm-tis: TPM TIS model
 #
@@ -26,8 +25,7 @@
 
 ##
 # @query-tpm-models:
-#
-# Return a list of supported TPM models
+#     Return a list of supported TPM models
 #
 # Since: 1.5
 #
@@ -41,8 +39,7 @@
 
 ##
 # @TpmType:
-#
-# An enumeration of TPM types
+#     An enumeration of TPM types
 #
 # @passthrough: TPM passthrough type
 #
@@ -55,8 +52,7 @@
 
 ##
 # @query-tpm-types:
-#
-# Return a list of supported TPM types
+#     Return a list of supported TPM types
 #
 # Since: 1.5
 #
@@ -70,8 +66,7 @@
 
 ##
 # @TPMPassthroughOptions:
-#
-# Information about the TPM passthrough type
+#     Information about the TPM passthrough type
 #
 # @path: string describing the path used for accessing the TPM device
 #
@@ -87,8 +82,7 @@
 
 ##
 # @TPMEmulatorOptions:
-#
-# Information about the TPM emulator type
+#     Information about the TPM emulator type
 #
 # @chardev: Name of a unix socket chardev
 #
@@ -121,9 +115,8 @@
 
 ##
 # @TpmTypeOptions:
-#
-# A union referencing different TPM backend types' configuration
-# options
+#     A union referencing different TPM backend types' configuration
+#     options
 #
 # @type:
 #     - 'passthrough' The configuration options for the TPM
@@ -142,8 +135,7 @@
 
 ##
 # @TPMInfo:
-#
-# Information about the TPM
+#     Information about the TPM
 #
 # @id: The Id of the TPM
 #
@@ -161,8 +153,7 @@
 
 ##
 # @query-tpm:
-#
-# Return information about the TPM device
+#     Return information about the TPM device
 #
 # Since: 1.5
 #
-- 
2.55.0


