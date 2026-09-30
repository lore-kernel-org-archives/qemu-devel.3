Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83393CA5FBA
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:46:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrkF-0004o7-9n; Wed, 30 Sep 2026 06:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrj3-0001ek-Or
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrip-0006rz-P7
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1w4wl/1fCoKW/JXigr8gZ6cmSHzWurrPzTncBqQd6GE=;
 b=K0148GLnkau029UrJWqIodQexQ+7MwCNCIs9ILtg4Oy5Ab/u9Uhm2k7CtLQ922AFV52hrC
 /iqirl5XZeJ1B2md2j/GRaHoFF/1VliXKbgWuEe611HCdg5I8owD0X0p1yeEF1QkQEEixi
 98eTPZrGFpNCLvEVsODYVGeTVOWtXkk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-INDqwX8QMT20oxPPzzBKoA-1; Wed,
 30 Sep 2026 06:39:31 -0400
X-MC-Unique: INDqwX8QMT20oxPPzzBKoA-1
X-Mimecast-MFC-AGG-ID: INDqwX8QMT20oxPPzzBKoA_1790764770
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6879819539A6; Wed, 30 Sep 2026 10:39:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 262A076F; Wed, 30 Sep 2026 10:39:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3C41A21E64BA; Wed, 30 Sep 2026 12:39:12 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 100/105] qapi: convert/split intros for misc-i386.json commands
Date: Wed, 30 Sep 2026 12:39:05 +0200
Message-ID: <20260930103910.3934848-101-armbru@redhat.com>
In-Reply-To: <20260930103910.3934848-1-armbru@redhat.com>
References: <20260930103910.3934848-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

From: John Snow <jsnow@redhat.com>

Convert or split apart the existing intro for commands in
misc-i386.json into introduction and details sections. The
introduction is indented, remaining plaintext/details paragraphs are
not.

For commands that have automatically generated documentation inserted
at parse time, these new split points serve as the new insertion
point. This affects the rendered documentation for `query-sev` in
particular, whose "Returns:" documentation is pushed upwards.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260928192557.509157-6-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/misc-i386.json | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/qapi/misc-i386.json b/qapi/misc-i386.json
index 78ec9aec64..6e0ab46b8e 100644
--- a/qapi/misc-i386.json
+++ b/qapi/misc-i386.json
@@ -5,10 +5,9 @@
 
 ##
 # @rtc-reset-reinjection:
-#
-# Reset the RTC interrupt reinjection backlog.  Can be used if another
-# mechanism to synchronize guest time is in effect, for example QEMU
-# guest agent's `guest-set-time` command.
+#     Reset the RTC interrupt reinjection backlog.  Can be used if
+#     another mechanism to synchronize guest time is in effect, for
+#     example QEMU guest agent's `guest-set-time` command.
 #
 # Use of this command is only applicable for x86 machines with an RTC,
 # and on other machines will silently return without performing any
@@ -119,8 +118,7 @@
 
 ##
 # @query-sev:
-#
-# Return information about SEV/SEV-ES/SEV-SNP.
+#     Return information about SEV/SEV-ES/SEV-SNP.
 #
 # If unavailable due to an incompatible configuration the returned
 # @enabled field is set to 'false' and the state of all other fields
@@ -149,8 +147,7 @@
 
 ##
 # @query-sev-launch-measure:
-#
-# Query the SEV/SEV-ES guest launch information.
+#     Query the SEV/SEV-ES guest launch information.
 #
 # This is only valid on x86 machines configured with KVM and the
 # 'sev-guest' confidential virtualization object.  The launch
@@ -199,8 +196,7 @@
 
 ##
 # @query-sev-capabilities:
-#
-# Get SEV capabilities.
+#     Get SEV capabilities.
 #
 # This is only supported on AMD X86 platforms with KVM enabled.
 #
@@ -220,8 +216,7 @@
 
 ##
 # @sev-inject-launch-secret:
-#
-# Inject a secret blob into a SEV/SEV-ES guest's memory.
+#     Inject a secret blob into a SEV/SEV-ES guest's memory.
 #
 # This is only valid on x86 machines configured with KVM and the
 # 'sev-guest' confidential virtualization object.  SEV-SNP guests do
@@ -257,8 +252,7 @@
 
 ##
 # @query-sev-attestation-report:
-#
-# Get the SEV attestation report.
+#     Get the SEV attestation report.
 #
 # This is only valid on x86 machines configured with KVM and the
 # 'sev-guest' confidential virtualization object.  The attestation
-- 
2.55.0


