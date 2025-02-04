Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B9CC0218F
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 08:07:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfDxl-0006Ib-Ki; Tue, 04 Feb 2025 03:07:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfDxg-0006H3-1c
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 03:07:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1tfDxb-0004vy-Cp
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 03:07:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738656426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PdxzpSa87W9UtXnyQHMoQoe0VEItXQ7TrfsxIVmLbmo=;
 b=XyiYODm/LcYbiAHkAHaN4Kx87Rext2cmu1863Pq3IPvjj9erosaytkmvhZynPyGek0S4P/
 3aB4AWHDs5S4ZEuMsuv1totriDkPdI+0hmPaC/NgYa1CSOJIxk187eqwSMpQYh9TUpFvKA
 w4rNiyVaipHvA1eYIUpqJ0ndVWaC4Ho=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-638-Slx99tVxNAifY_tJ7WLRjA-1; Tue,
 04 Feb 2025 03:07:02 -0500
X-MC-Unique: Slx99tVxNAifY_tJ7WLRjA-1
X-Mimecast-MFC-AGG-ID: Slx99tVxNAifY_tJ7WLRjA
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D780D19560A1; Tue,  4 Feb 2025 08:07:00 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.15])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3146B195608E; Tue,  4 Feb 2025 08:06:58 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PATCH v2 3/3] hw/ppc: Deprecate 405 CPUs
Date: Tue,  4 Feb 2025 09:06:49 +0100
Message-ID: <20250204080649.836155-4-clg@redhat.com>
In-Reply-To: <20250204080649.836155-1-clg@redhat.com>
References: <20250204080649.836155-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The ref405ep machine is scheduled for removal in QEMU 10.0. Keep the
405 CPU implementation for a while because it is theoretically
possible to model the power management (OCC) co-processor found on the
IBM POWER [8-11] processors.

Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 docs/about/deprecated.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index db9edfc24a0c..89b01779df04 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -225,6 +225,15 @@ in the QEMU object model anymore. ``Sun-UltraSparc-IIIi+`` and
 but for consistency these will get removed in a future release, too.
 Use ``Sun-UltraSparc-IIIi-plus`` and ``Sun-UltraSparc-IV-plus`` instead.
 
+PPC 405 CPUs (since 10.0)
+'''''''''''''''''''''''''
+
+The PPC 405 CPU has no known users and the ``ref405ep`` machine was
+removed in QEMU 10.0. Since the IBM POWER [8-11] processors uses an
+embedded 405 for power management (OCC) and other internal tasks, it
+is theoretically possible to use QEMU to model them. Let's keep the
+CPU implementation for a while before removing all support.
+
 System emulator machines
 ------------------------
 
-- 
2.48.1


