Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 782FAC3ABB2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 18:33:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKLZi-0002Uu-LU; Wed, 28 May 2025 14:32:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKLZR-0002Lf-KV
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:32:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKLZL-00071s-FI
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748457120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y/JPc+SMqWfHQfEedKNgRf90s6Jp5Q2UIwoAvRmyfBo=;
 b=FVCTaNzFIHIG6dkwjfNyFdcEViEEmDNvoRvLBQr1WKqIK4evU0U4j4d+z0ZSgqm28y0yEB
 3uPP9PYlsbAEjOvpEYTP8bDm5hHmQuYJjikX3gcr9xbrZ6vkaPz7vtbLhpMIoXOdLj2436
 bBW6NfVPI0+spPp+InSqBT0yd58EzxQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-NqFAKtWLO_u3Bbzv5sy8jw-1; Wed,
 28 May 2025 14:31:55 -0400
X-MC-Unique: NqFAKtWLO_u3Bbzv5sy8jw-1
X-Mimecast-MFC-AGG-ID: NqFAKtWLO_u3Bbzv5sy8jw_1748457114
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0B4A1800447; Wed, 28 May 2025 18:31:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5CC1F180047F; Wed, 28 May 2025 18:31:54 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 93A4E21E668A; Wed, 28 May 2025 20:31:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 02/13] qapi: expand docs for SEV commands
Date: Wed, 28 May 2025 20:31:40 +0200
Message-ID: <20250528183151.2839034-3-armbru@redhat.com>
In-Reply-To: <20250528183151.2839034-1-armbru@redhat.com>
References: <20250528183151.2839034-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Daniel P. Berrangé <berrange@redhat.com>

This gives some more context about the behaviour of the commands in
unsupported guest configuration or platform scenarios.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250522190542.588267-3-pierrick.bouvier@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Tweak query-sev doc, turn error descriptions into Errors sections,
delate a stray #, normalize whitespace, wrap lines]
---
 qapi/misc-target.json | 50 +++++++++++++++++++++++++++++++++++++------
 1 file changed, 43 insertions(+), 7 deletions(-)

diff --git a/qapi/misc-target.json b/qapi/misc-target.json
index c5f9f6be7e..e19a12e88a 100644
--- a/qapi/misc-target.json
+++ b/qapi/misc-target.json
@@ -110,7 +110,11 @@
 ##
 # @query-sev:
 #
-# Returns information about SEV
+# Returns information about SEV/SEV-ES/SEV-SNP.
+#
+# If unavailable due to an incompatible configuration the returned
+# @enabled field is set to 'false' and the state of all other fields
+# is unspecified.
 #
 # Returns: @SevInfo
 #
@@ -141,10 +145,19 @@
 ##
 # @query-sev-launch-measure:
 #
-# Query the SEV guest launch information.
+# Query the SEV/SEV-ES guest launch information.
+#
+# This is only valid on x86 machines configured with KVM and the
+# 'sev-guest' confidential virtualization object.  The launch
+# measurement for SEV-SNP guests is only available within the guest.
 #
 # Returns: The @SevLaunchMeasureInfo for the guest
 #
+# Errors:
+#     - If the launch measurement is unavailable, either due to an
+#       invalid guest configuration or if the guest has not reached
+#       the required SEV state, GenericError
+#
 # Since: 2.12
 #
 # .. qmp-example::
@@ -185,11 +198,15 @@
 ##
 # @query-sev-capabilities:
 #
-# This command is used to get the SEV capabilities, and is supported
-# on AMD X86 platforms only.
+# Get SEV capabilities.
+#
+# This is only supported on AMD X86 platforms with KVM enabled.
 #
 # Returns: SevCapability objects.
 #
+# Errors:
+#     - If SEV is not available on the platform, GenericError
+#
 # Since: 2.12
 #
 # .. qmp-example::
@@ -205,7 +222,12 @@
 ##
 # @sev-inject-launch-secret:
 #
-# This command injects a secret blob into memory of SEV guest.
+# This command injects a secret blob into memory of a SEV/SEV-ES
+# guest.
+#
+# This is only valid on x86 machines configured with KVM and the
+# 'sev-guest' confidential virtualization object.  SEV-SNP guests do
+# not support launch secret injection.
 #
 # @packet-header: the launch secret packet header encoded in base64
 #
@@ -213,6 +235,11 @@
 #
 # @gpa: the guest physical address where secret will be injected.
 #
+# Errors:
+#     - If launch secret injection is not possible, either due to
+#       an invalid guest configuration, or if the guest has not
+#       reached the required SEV state, GenericError
+#
 # Since: 6.0
 ##
 { 'command': 'sev-inject-launch-secret',
@@ -236,14 +263,23 @@
 ##
 # @query-sev-attestation-report:
 #
-# This command is used to get the SEV attestation report, and is
-# supported on AMD X86 platforms only.
+# This command is used to get the SEV attestation report.
+#
+# This is only valid on x86 machines configured with KVM and the
+# 'sev-guest' confidential virtualization object.  The attestation
+# report for SEV-SNP guests is only available within the guest.
 #
 # @mnonce: a random 16 bytes value encoded in base64 (it will be
 #     included in report)
 #
 # Returns: SevAttestationReport objects.
 #
+# Errors:
+#     - This will return an error if the attestation report is
+#       unavailable, either due to an invalid guest configuration
+#       or if the guest has not reached the required SEV state,
+#       GenericError
+#
 # Since: 6.1
 #
 # .. qmp-example::
-- 
2.48.1


