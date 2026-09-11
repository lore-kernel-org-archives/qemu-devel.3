Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAFCC88E58
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 14:44:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x52Tp-0002G9-CV; Fri, 11 Sep 2026 10:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52Nq-0002tC-Fs
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:37:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x52Nl-0008E9-EJ
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 10:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789137447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qMFoXRSqJagVBm5GVPbfKFycLqDC+N9k5/iDYiZvJ88=;
 b=FqiVXZgho17a4oMNGvRMZC2oZxm+jGJaS4lC122E2W7WMskkdzpy0VvnNql0YZy63/MVP9
 BLRob9LSfUWHOWnXk4sgNLMFldlKmH3YySur2Il/t8u0EHT0I1BMogS4I3mK8+BqTFICR0
 mS+u88QxsiqHvouaQN3nJQKpDY7EGAE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-232-8svhV57tPAqXhzJY7uftTA-1; Fri,
 11 Sep 2026 10:37:23 -0400
X-MC-Unique: 8svhV57tPAqXhzJY7uftTA-1
X-Mimecast-MFC-AGG-ID: 8svhV57tPAqXhzJY7uftTA_1789137442
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 18A691955BFC; Fri, 11 Sep 2026 14:37:22 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2E31F300022B; Fri, 11 Sep 2026 14:37:20 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 23/28] hw/uefi: mark the EFI vars service as secure
Date: Fri, 11 Sep 2026 15:36:22 +0100
Message-ID: <20260911143627.2743803-24-berrange@redhat.com>
In-Reply-To: <20260911143627.2743803-1-berrange@redhat.com>
References: <20260911143627.2743803-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

This is used to persist EFI variables when NVRAM is not available
or undesirable.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 hw/uefi/var-service-sysbus.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/uefi/var-service-sysbus.c b/hw/uefi/var-service-sysbus.c
index 97a96cae6a..6bec14733b 100644
--- a/hw/uefi/var-service-sysbus.c
+++ b/hw/uefi/var-service-sysbus.c
@@ -84,6 +84,7 @@ static const TypeInfo uefi_vars_sysbus_info = {
     .instance_size = sizeof(uefi_vars_sysbus_state),
     .instance_init = uefi_vars_sysbus_init,
     .class_init    = uefi_vars_sysbus_class_init,
+    .secure        = true,
 };
 module_obj(TYPE_UEFI_VARS_SYSBUS);
 
@@ -113,6 +114,7 @@ static const TypeInfo uefi_vars_x64_info = {
     .name          = TYPE_UEFI_VARS_X64,
     .parent        = TYPE_UEFI_VARS_SYSBUS,
     .class_init    = uefi_vars_x64_class_init,
+    .secure        = true,
 };
 module_obj(TYPE_UEFI_VARS_X64);
 
-- 
2.55.0


