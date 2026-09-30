Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33FFFCA5FB1
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 10:41:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBrkB-0004UI-TC; Wed, 30 Sep 2026 06:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBris-0001SQ-Jv
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xBrij-0006nd-BD
 for qemu-devel@nongnu.org; Wed, 30 Sep 2026 06:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790764768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p/TlFqEoCtPQEyGkaeWkFAOeHqNWgzSGmyLmcClA1l8=;
 b=YEbzlWZEnQC1zFkKmXBWm7DnwMt3XUvDIAspsETA2wWLqsqd4WuBHrhfXjC4W6lvKa8YIv
 q6z8PBRcsf5QcI+Cr+SfnXzBYgfJBMAaULsf7aKz0t9zYXBeM0qw58BBES1JkLa3i9Pdk0
 SgSEZ2q6BZDra84Wg/yUpNkGxC9w98w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-422-7koBn3AZOKi7kPHeZS8Z7w-1; Wed,
 30 Sep 2026 06:39:27 -0400
X-MC-Unique: 7koBn3AZOKi7kPHeZS8Z7w-1
X-Mimecast-MFC-AGG-ID: 7koBn3AZOKi7kPHeZS8Z7w_1790764766
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D15A1964CFD; Wed, 30 Sep 2026 10:39:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1C0FB76C; Wed, 30 Sep 2026 10:39:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B1CDA21E663A; Wed, 30 Sep 2026 12:39:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 069/105] qapi: convert simple enum intros for machine.json
Date: Wed, 30 Sep 2026 12:38:34 +0200
Message-ID: <20260930103910.3934848-70-armbru@redhat.com>
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

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260909041640.69080-10-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/machine.json | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 2ed8273b99..52a688cfbe 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -15,12 +15,11 @@
 
 ##
 # @SysEmuTarget:
-#
-# The comprehensive enumeration of QEMU system emulation ("softmmu")
-# targets.  Run "./configure --help" in the project root directory,
-# and look for the \*-softmmu targets near the "--target-list" option.
-# The individual target constants are not documented here, for the
-# time being.
+#     The comprehensive enumeration of QEMU system emulation
+#     ("softmmu") targets.  Run "./configure --help" in the project
+#     root directory, and look for the \*-softmmu targets near the
+#     "--target-list" option.  The individual target constants are not
+#     documented here, for the time being.
 #
 # @rx: since 5.0
 #
@@ -388,9 +387,8 @@
 
 ##
 # @LostTickPolicy:
-#
-# Policy for handling lost ticks in timer devices.  Ticks end up
-# getting lost when, for example, the guest is paused.
+#     Policy for handling lost ticks in timer devices.  Ticks end up
+#     getting lost when, for example, the guest is paused.
 #
 # @discard: throw away the missed ticks and continue with future
 #     injection normally.  The guest OS will see the timer jump ahead
@@ -1960,9 +1958,8 @@
 
 ##
 # @CpuModelCompareResult:
-#
-# An enumeration of CPU model comparison results.  The result is
-# usually calculated using e.g. CPU features or CPU generations.
+#     An enumeration of CPU model comparison results.  The result is
+#     usually calculated using e.g. CPU features or CPU generations.
 #
 # @incompatible: If model A is incompatible to model B, model A is not
 #     guaranteed to run where model B runs and the other way around.
-- 
2.55.0


