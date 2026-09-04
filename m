Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61998C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 16:08:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2WSS-00057n-6f; Fri, 04 Sep 2026 12:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x2WRq-0004Eh-1R
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 12:07:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x2WRo-0006i2-89
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 12:07:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788538042;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FljOUZcrDxLcSEtdGZg2L7bnzs/rlfsiHLxsLO2MQAk=;
 b=jAl5kdoaUB0wBen+fe2YWpi5XgFZ/WNNB2cUUojSBeuRXQNSX6+Anw7ns0DGsiVgHLzAqH
 zMe0sC8KkyODO/1Fh0G0cfUihq+DNDomJ7DkIVsyiZDkw3JhIo6ImXQXhCZtu7v/6CvSCy
 nRmvLZnXsJMZS71mpA6rI/kDnZ7i8gI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-437-Wp5P18CRPfyUUSV6BZpvcQ-1; Fri,
 04 Sep 2026 12:07:19 -0400
X-MC-Unique: Wp5P18CRPfyUUSV6BZpvcQ-1
X-Mimecast-MFC-AGG-ID: Wp5P18CRPfyUUSV6BZpvcQ_1788538038
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9AD4D1888F2E; Fri,  4 Sep 2026 16:07:18 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E9A693001D37; Fri,  4 Sep 2026 16:07:16 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, devel@lists.libvirt.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PULL v2 13/13] docs/system/security: exclude uninitialized stack
 variables as bugs
Date: Fri,  4 Sep 2026 17:06:43 +0100
Message-ID: <20260904160643.353833-14-berrange@redhat.com>
In-Reply-To: <20260904160643.353833-1-berrange@redhat.com>
References: <20260904160643.353833-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The -ftrivial-auto-var-init=zero usage guarantees implicit zero
initializers for all stack variables. Thus most bug reports relying
on undefined behaviour from lack of variable initialization will
not be security issues, or even bugs.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/system/security.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/docs/system/security.rst b/docs/system/security.rst
index af626a4230..8c42d1a6d8 100644
--- a/docs/system/security.rst
+++ b/docs/system/security.rst
@@ -143,6 +143,16 @@ an issue as a normal bug.
   which case plain manipulation of the stream is not considered as
   an attack vector.
 
+* **uninitialized stack variables**. If the bug scenario relies on
+  undefined behaviour from stack variables that lack explicit
+  initialization, it will not usually be considered a security flaw.
+  The build system adds '-ftrivial-auto-var-init=zero', which is
+  available in both the supported compilers (GCC and CLang) and
+  ensures all stack variables have implicit zero-initializers.
+  This eliminates undefined behaviour and usually gives the
+  correct desired initialization value, eliminating most of the
+  bug scenarios wrt uninitialized stack variables.
+
 * **low severity impact**. As a catch all rule, issues which
   are judged to have a "low" severity impact on the system will
   usually not justify handling as security bugs, nor assignment
-- 
2.55.0


