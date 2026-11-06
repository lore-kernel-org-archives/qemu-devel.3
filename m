Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E48B9606A330
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 11:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VNoULCnU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPHkc-0004xy-QG; Fri, 06 Nov 2026 06:04:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xPHkb-0004wJ-44
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 06:04:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xPHkW-0007iV-U1
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 06:04:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793963088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=n+fyfEzaJevmxFeo2QubggaEwte59a5FdRAy2cDkcT8=;
 b=VNoULCnUnrMhmisylxOtdv3AvevsS1ScWyhWOiKb8MhaqPKHW7QUvH8vXfFY3PfOVM76GI
 xL1ot/WZ/1FtFZc7L5ebNQ0uAeKLQ/fwWoQGb6by49kT1PmrjpfKaAeLWuI0Gs7IJCQ1hD
 9Sto1N1TtWp3jc5GOKzu3nDbo74JWzY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-176-c9l29rPJPumpSWnwsubnYw-1; Fri,
 06 Nov 2026 06:04:44 -0500
X-MC-Unique: c9l29rPJPumpSWnwsubnYw-1
X-Mimecast-MFC-AGG-ID: c9l29rPJPumpSWnwsubnYw_1793963083
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B42518002C6; Fri,  6 Nov 2026 11:04:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D6491955F73; Fri,  6 Nov 2026 11:04:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B07D521E6A04; Fri, 06 Nov 2026 12:04:40 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, milesg@linux.ibm.com, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, mark.caveayland@nutanix.com
Subject: [PATCH 0/8] hw/gpio/pca955x: Improvements around props "pin" and "led"
Date: Fri,  6 Nov 2026 12:04:32 +0100
Message-ID: <20261106110440.3552588-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Marc-André converted properties "pin" and "led" to QAPI enums in his
"qom/qdev: associate properties with QAPI schema types".  I dropped
this part from v8, which has since been merged in commit c5fee4d93fd.
I'm now bringing it back, reworked.

PATCH 1-5 convert these properties to class properties.  See commit
7674a1880890 (qom: deprecate use of instance level properties) for
why.

PATCH 6 is Marc-André's "[PATCH v7 48/65] hw/gpio/pca955x: use QAPI
enums for led and pin properties" with the following tweaks:

* I don't change their @type in output of qom-list,
  qom-list-properties, qom-list-get, because that what the merged
  version of his series did.

* I replaced identical QAPI enums Pca9552PinState and Pca9554PinState
  by a single enum GpioPinState.

PATCH 7+8 replace Marc-André's "[PATCH v7 50/65] hw/gpio/pca955x:
convert pin/led property to QAPI-aware enum".  Marc-André's used
object_property_add_qapi_enum() (which has since been folded into
object_property_add_enum()), but to be able to use it, he had to bake
the index into getter and the setter functions.  He generated them
with the preprocessor.  My version sticks to
object_class_property_add(), so we can pass the index to getter and
setter via parameter @opaque.  Getter and setter remain slightly more
complex, but don't turn into macros (decorated with backslashes) for
sixteenfold duplication.

Perhaps object_class_property_add_enum() should support passing an
opaque value to getter and setter.

Based-on: <20261105080310.1656968-1-armbru@redhat.com>

Marc-André Lureau (1):
  hw/gpio/pca955x: use QAPI enums for led and pin properties

Markus Armbruster (7):
  hw/gpio/pca9552: Convert pin and led properties to class properties
  hw/gpio/pca9554: Move most code from .h to .c
  hw/gpio/pca9554: Simplify QOM type creation
  hw/gpio/pca9554: New abstract base "pca9554-base"
  hw/gpio/pca9554: Convert pin properties to class properties
  hw/gpio/pca955x: Improve @qapi-type reported by qom-list etc.
  hw/gpio/pca955x: Simplify pin and led getters and setters

 qapi/machine.json         |  29 ++++++++
 include/hw/gpio/pca9554.h |  26 +------
 hw/gpio/pca9552.c         | 149 +++++++++++++------------------------
 hw/gpio/pca9554.c         | 151 +++++++++++++++++++-------------------
 4 files changed, 160 insertions(+), 195 deletions(-)

-- 
2.55.0


