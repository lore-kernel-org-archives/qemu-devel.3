Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC11C5DF94
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 12:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyToJ-0002k5-Pm; Mon, 24 Aug 2026 08:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wyToF-0002jg-6f
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:29:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wyToD-00085q-2X
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 08:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787574587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=3VS2pApWnBkJEsMscWMtxcLwcpoqnmQb83+v0SFbax4=;
 b=i9fIM4XcZQqoDCLQF7aExJ8qAkY9hy94SZLkIMpz54M4rUiY2YmNaQ11vxXPri4y8QgByY
 h+UvSULfkWnIC4rfy7SNtWRC+jcj5P8IobwZXm/GRKw7oi+ie0ZdyLeUFhF73XDMXw/27G
 XP+6vf44PHWJozrNODc409HM8imJKn8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-ksab-2LVNs2c0czJsmj7zQ-1; Mon,
 24 Aug 2026 08:29:45 -0400
X-MC-Unique: ksab-2LVNs2c0czJsmj7zQ-1
X-Mimecast-MFC-AGG-ID: ksab-2LVNs2c0czJsmj7zQ_1787574585
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F042A1830768; Mon, 24 Aug 2026 12:29:44 +0000 (UTC)
Received: from berrange.fritz.box (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9A4C018001CF; Mon, 24 Aug 2026 12:29:43 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH] system: improve -mon deprecation warning
Date: Mon, 24 Aug 2026 13:29:42 +0100
Message-ID: <20260824122942.85863-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

Expand the text a bit to make the new syntax more explicit and point
users to the man page for further info.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 system/vl.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/system/vl.c b/system/vl.c
index 061cbdf860..d5b5392569 100644
--- a/system/vl.c
+++ b/system/vl.c
@@ -3239,8 +3239,11 @@ void qemu_init(int argc, char **argv)
                 default_monitor = 0;
                 break;
             case QEMU_OPTION_mon:
-                warn_report_once("'-mon' is deprecated, use '-object' with "
-                                 "'monitor-hmp' or 'monitor-qmp' types instead");
+                warn_report_once("'-mon' is deprecated. Switch to either "
+                                 "'-object monitor-hmp,id=ID,chardev=CHR-ID' "
+                                 "or '-object monitor-qmp,id=qmpNN,chardev=CHR-ID' "
+                                 "instead. See '-object' docs in 'qemu(1)' for further "
+                                 "configuration guidance.");
                 if (!qemu_opts_parse_noisily(qemu_find_opts("mon"), optarg,
                                              true)) {
                     exit(1);
-- 
2.55.0


