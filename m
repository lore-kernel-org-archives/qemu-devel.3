Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC263C3601E
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 12:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0fwj-000620-Gu; Fri, 04 Apr 2025 08:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u0fwK-0005qm-Sa
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:14:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1u0fwH-0005qg-Ib
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 08:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743768865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iNjWoivzUTHy9W+FeBB1QQ6/pfeYGmq23CdVrIdqrY4=;
 b=W4rdk3cCJXygS9ITtH7JVwbxGm9Nnnzp4stLj6GL/ChrFR4oO2/x7arHBRsneousBXEEaF
 /0vSC4GWu0zQV5W0cJMaXYl/q3YN8Fce1kspycCam1X6bVTv1TDpawZ1n8KG4/zX2ChbCD
 cPbhRS8ykOcUL9UdWH+3Zgdn+K1bSEM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-z5X0B3EhOLSmGwvk6heRvw-1; Fri,
 04 Apr 2025 08:14:19 -0400
X-MC-Unique: z5X0B3EhOLSmGwvk6heRvw-1
X-Mimecast-MFC-AGG-ID: z5X0B3EhOLSmGwvk6heRvw_1743768858
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A8DFA19560BB; Fri,  4 Apr 2025 12:14:17 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BAF07191F254; Fri,  4 Apr 2025 12:14:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6922B21E66E4; Fri, 04 Apr 2025 14:14:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, kkostiuk@redhat.com, kwolf@redhat.com,
 jsnow@redhat.com, peter.maydell@linaro.org, eblake@redhat.com,
 jiri@resnulli.us, qemu-block@nongnu.org
Subject: [PATCH 02/11] qapi/rocker: Tidy up query-rocker-of-dpa-flows example
Date: Fri,  4 Apr 2025 14:14:04 +0200
Message-ID: <20250404121413.1743790-3-armbru@redhat.com>
In-Reply-To: <20250404121413.1743790-1-armbru@redhat.com>
References: <20250404121413.1743790-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.028,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The command can return any number of RockerOfDpaFlow objects.  The
example shows it returning exactly two, with the second objecy's
members elided.  Tweak it so it elides elements after the first
instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/rocker.json | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qapi/rocker.json b/qapi/rocker.json
index 51aa5b4930..0c7ef1f77c 100644
--- a/qapi/rocker.json
+++ b/qapi/rocker.json
@@ -254,7 +254,7 @@
 #                       "action": {"goto-tbl": 10},
 #                       "mask": {"in-pport": 4294901760}
 #                      },
-#                      {...},
+#                      ...
 #        ]}
 ##
 { 'command': 'query-rocker-of-dpa-flows',
-- 
2.48.1


