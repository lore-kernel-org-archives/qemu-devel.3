Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD8E606A31B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=B8gj1if8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJZFM-0007VR-Hq; Wed, 21 Oct 2026 12:33:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1xJZFG-0007Te-Rr
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:32:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1xJZFC-0006VA-Pw
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 12:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792600370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OtTEJg5RIHFFJ9ZZ5a0yaGlFu79+ZaA7uoWE9DGvTDw=;
 b=B8gj1if88AGPE/t8FxyEiCrUH0UePUWfqwvmoTcU52Wag7l7mPfM4uF76BWLgseXHv4/Sb
 gI+bqPbDuNLEN92MidtL8agZzaxMj0kdc/9Wj/8fbGAv7nGDw+UJjPVd0EFtM3A3TK8J56
 NuUh00J4JE++09mEHDv0uuPphMGwRDo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-EyfYKAXeOG636wyFjUSQHQ-1; Wed,
 21 Oct 2026 12:32:46 -0400
X-MC-Unique: EyfYKAXeOG636wyFjUSQHQ-1
X-Mimecast-MFC-AGG-ID: EyfYKAXeOG636wyFjUSQHQ_1792600365
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7FFC71955F1B; Wed, 21 Oct 2026 16:32:45 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.54])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3A4EC5BC; Wed, 21 Oct 2026 16:32:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 2F82F1827597; Wed, 21 Oct 2026 18:32:40 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Zhao Liu <zhao1.liu@intel.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Luigi Leonardi <leonardi@redhat.com>
Subject: [PULL 09/10] docs/system/igvm: document MADT,
 COMMAND_LINE and DEVICE_TREE directives
Date: Wed, 21 Oct 2026 18:32:37 +0200
Message-ID: <20261021163239.1131460-10-kraxel@redhat.com>
In-Reply-To: <20261021163239.1131460-1-kraxel@redhat.com>
References: <20261021163239.1131460-1-kraxel@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Luigi Leonardi <leonardi@redhat.com>

The MADT and DEVICE_TREE directives were added without updating the
list of supported directives. Document them, together with the
COMMAND_LINE directive added in the previous patch.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20261019-igvm_command_line-v3-2-29aeacbd6cd7@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 docs/system/igvm.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/docs/system/igvm.rst b/docs/system/igvm.rst
index 9db8ae43d21d..da1e965f545f 100644
--- a/docs/system/igvm.rst
+++ b/docs/system/igvm.rst
@@ -72,6 +72,14 @@ SEV-ES, SEV-SNP and non-confidential platforms.
    * - IGVM_VHT_ENVIRONMENT_INFO_PARAMETER
      - The ``memory_is_shared`` parameter is set to 1 in the guest parameter
        page.
+   * - IGVM_VHT_MADT
+     - The parameter area is populated with the ACPI MADT generated by QEMU.
+   * - IGVM_VHT_COMMAND_LINE
+     - The parameter area is populated with the ``cmdline`` property of the
+       ``igvm-cfg`` object, or an empty string if it is not set.
+   * - IGVM_VHT_DEVICE_TREE
+     - The parameter area is populated with the device tree generated by QEMU.
+       Only available when QEMU is built with FDT support.
 
 .. list-table:: Additional SEV, SEV-ES & SEV_SNP Supported Directives
    :widths: 25 75
-- 
2.56.0


