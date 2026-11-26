Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09DE606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fv9vlJLS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWWIz-0008Mz-DK; Thu, 26 Nov 2026 05:02:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWWIX-00087z-VQ
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 05:01:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWWIV-0006gS-Cw
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 05:01:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795687305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Mnm9T/zEm0iir37/YCGp69BBGTlSTjr86ajA1Xx+e6s=;
 b=fv9vlJLSxXgwyxvPOdjG364V1BKf7XfpPVIPbRkr0huwQ2/Dgqi6mFgDKw5xbyhRi14mPS
 CS1m8CS05sj7Qdn2X6/CmzhdzP1OQAJ+z4S1OiKqm2E0aPgNiesGffVwKmaVuwlDbA9eQR
 SoLtbNQSGHR6xCiwBt7jn7gXv2l178M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-38lMm_8YOiG4J4r64Qz8Ig-1; Thu,
 26 Nov 2026 10:01:43 +0000
X-MC-Unique: 38lMm_8YOiG4J4r64Qz8Ig-1
X-Mimecast-MFC-AGG-ID: 38lMm_8YOiG4J4r64Qz8Ig_1795687302
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C154195606E; Thu, 26 Nov 2026 10:01:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32AA5410; Thu, 26 Nov 2026 10:01:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BBAB421E692D; Thu, 26 Nov 2026 11:01:39 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 jsnow@redhat.com, crosa@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org
Subject: [PATCH 01/16] util: Move QMP command query-command-line-options back
 to util/
Date: Thu, 26 Nov 2026 11:01:24 +0100
Message-ID: <20261126100139.3557890-2-armbru@redhat.com>
In-Reply-To: <20261126100139.3557890-1-armbru@redhat.com>
References: <20261126100139.3557890-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Commit 3df4c28860e1 (util/qemu-config: Extract QMP commands to
qemu-config-qmp.c) extracted it from util/qemu-config.c so we don't
link it into user emulation binaries.  Good.  It also moved it from
util/ to monitor/.  Not good; it's not about the monitor.  Move it
back.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 monitor/qemu-config-qmp.c => util/qemu-config-qmp-cmds.c | 0
 monitor/meson.build                                      | 1 -
 util/meson.build                                         | 3 ++-
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename monitor/qemu-config-qmp.c => util/qemu-config-qmp-cmds.c (100%)

diff --git a/monitor/qemu-config-qmp.c b/util/qemu-config-qmp-cmds.c
similarity index 100%
rename from monitor/qemu-config-qmp.c
rename to util/qemu-config-qmp-cmds.c
diff --git a/monitor/meson.build b/monitor/meson.build
index f67e0291a42..ea3600d78cf 100644
--- a/monitor/meson.build
+++ b/monitor/meson.build
@@ -2,7 +2,6 @@ qmp_ss.add(files('monitor.c', 'qmp.c', 'qmp-cmds-control.c'))
 
 system_ss.add(files(
   'fds.c',
-  'qemu-config-qmp.c',
   'qmp-cmds.c',
 ))
 
diff --git a/util/meson.build b/util/meson.build
index fa174c07a57..e02b3a16221 100644
--- a/util/meson.build
+++ b/util/meson.build
@@ -42,7 +42,8 @@ util_ss.add(files('cacheflush.c'))
 util_ss.add(files('error.c', 'error-report.c'))
 util_ss.add(files('qemu-print.c'))
 util_ss.add(files('id.c'))
-util_ss.add(files('qemu-config.c', 'notify.c'))
+util_ss.add(files('qemu-config.c', 'qemu-config-qmp-cmds.c'))
+util_ss.add(files('notify.c'))
 util_ss.add(files('qemu-option.c', 'qemu-progress.c'))
 util_ss.add(files('keyval.c'))
 util_ss.add(files('crc32.c'))
-- 
2.55.0


