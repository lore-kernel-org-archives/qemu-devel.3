Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5E5C61DD3
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 20:24:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x18Xk-0003fi-QS; Mon, 31 Aug 2026 16:23:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x18XD-0002kx-VC
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 16:23:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1x18XB-00080P-QX
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 16:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788207792;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=53kJeaXAGXWbWgaUWrPPbMnvvgjeb4ogml1Llx3Dmyw=;
 b=R2XQRq92p1y6TqlwTRdnNaDpOYNAyxKlkTqE3Z+814WvxuANXX9UDxZNFbSrzY2Cojjnop
 br63qjjv4VVKxd/j9fUi25bBvG+55Kq5EGLZqZBeFGyyHorPTuyGIJn1th1GQ8DXL3Z7ac
 LciqP7lGdOM6E8L/k4+nW1k3udPwXUc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-DTlpBjCDMkiOuYikMIMyJg-1; Mon,
 31 Aug 2026 16:23:09 -0400
X-MC-Unique: DTlpBjCDMkiOuYikMIMyJg-1
X-Mimecast-MFC-AGG-ID: DTlpBjCDMkiOuYikMIMyJg_1788207787
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4AE9218D7268; Mon, 31 Aug 2026 20:22:43 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.63])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BB1E61800577; Mon, 31 Aug 2026 20:22:34 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 zhenwei pi <zhenwei.pi@linux.dev>, Jonathan Cameron <jic23@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Jiri Pirko <jiri@resnulli.us>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 qemu-block@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, linux-cxl@vger.kernel.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Alex Williamson <alex@shazbot.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 linux-edac@vger.kernel.org, Michael Tokarev <mjt@tls.msk.ru>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 Eric Blake <eblake@redhat.com>, Peter Xu <peterx@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, qemu-trivial@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v4 16/43] qapi: convert trivial intro sections for tpm.json
Date: Mon, 31 Aug 2026 16:19:18 -0400
Message-ID: <20260831201945.287730-17-jsnow@redhat.com>
In-Reply-To: <20260831201945.287730-1-jsnow@redhat.com>
References: <20260831201945.287730-1-jsnow@redhat.com>
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


