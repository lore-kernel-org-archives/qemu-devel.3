Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2F9BCAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:06:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v292U-0006NC-Oj; Fri, 26 Sep 2025 10:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v292S-0006MD-0m
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:03:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v292L-0004ip-UG
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758895380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5k008Bl84c113iX9fUzuJAHFMGIOYAiB2ad/D2iyokU=;
 b=DJs80cI5gAVFILM85sKY/R4X4cqOKYKoURNfTVAEcH2g16qYeu8j7VUWEypk/bQtjsV6SJ
 SpuTKGO2DVgXE4q23e5LkCamrk6mdYiJgmu4Emo0wt6md3QOuXmtanWR1i42TngvecID+8
 I3AaMTTIL1uIRsdvuDPGh6U2JeeDNYI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-ULFrEky9OgWVmEbFcQA3JA-1; Fri,
 26 Sep 2025 10:02:56 -0400
X-MC-Unique: ULFrEky9OgWVmEbFcQA3JA-1
X-Mimecast-MFC-AGG-ID: ULFrEky9OgWVmEbFcQA3JA_1758895375
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 514DE1955D69; Fri, 26 Sep 2025 14:02:55 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.175])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 24CB51956095; Fri, 26 Sep 2025 14:02:50 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 12/32] docs: expand security docs with info about security
 status
Date: Fri, 26 Sep 2025 15:01:23 +0100
Message-ID: <20250926140144.1998694-13-berrange@redhat.com>
In-Reply-To: <20250926140144.1998694-1-berrange@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The description of virtualization vs non-virtualization use
cases is a crude approximation of the security characteristics
of QEMU devices.

Document how QEMU can be probed to obtain information on the
security status of type classes, and how policies can be set
to inform or control their usage.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/system/security.rst | 43 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/docs/system/security.rst b/docs/system/security.rst
index f2092c8768..cda4bae6db 100644
--- a/docs/system/security.rst
+++ b/docs/system/security.rst
@@ -49,6 +49,49 @@ Bugs affecting the non-virtualization use case are not considered security
 bugs at this time.  Users with non-virtualization use cases must not rely on
 QEMU to provide guest isolation or any security guarantees.
 
+Security status reporting
+'''''''''''''''''''''''''
+
+QEMU is progressively working to annotate object types to explicitly state
+whether they are considered to provide a security boundary or not.
+
+It is possible to control or identify the usage of types that do not offer
+an explicit security boundary using the ``insecure-types`` parameter to the
+``-compat`` argument, which accepts three values:
+
+ * accept: usage of any type will be permitted. This is the current
+   and historical default behaviour
+ * warn: usage of types not explicitly declared secure will result
+   in a warning message, but still be permitted.
+ * reject: usage of types not explicitly declared secure will result
+   in an error message, and will not be permitted.
+
+The compatibility policy will be honoured both at initial startup of
+QEMU and during any runtime alterations made with monitor commands.
+
+The status of any type class can be queried at runtime using the
+``qom-list-types`` command, whose returned information will flag any
+types declared as secure. The ``query-machines`` command will also
+reflect this same information for machine types.
+
+Machine type, accelerator and device security status can be queried
+using ``-machine help``, ``-accel help`` and ``-device help`` command
+line options respectively.
+
+The setting of the ``.secure`` field at the time a type class is
+declared in the code will determine whether bugs are eligible to
+be considered as security bugs:
+
+ * Explicitly declared ``.secure = true``: security bug process
+   applies, eligible for CVE assignment
+ * Explicitly declared ``.secure = false``: security bug process
+   does not apply, ineligible for CVE assignment
+ * No declaration of ``.secure`` property: follow the security
+   bug process initially. The virtualization vs non-virtualization
+   use case classification will be evaluated during bug triage
+   to determine whether to continue the security bug process,
+   or switch to the regular bug process.
+
 Architecture
 ------------
 
-- 
2.50.1


