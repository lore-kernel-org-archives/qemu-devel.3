Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B9E3C43602
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 21:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weJfN-000728-9m; Mon, 29 Jun 2026 17:37:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1weJfL-00071K-LT
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 17:37:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1weJfK-000482-9s
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 17:37:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782769037;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FmJmZJX+vd5TrBzCGdcUZ5w6AiCIiW7TcrUt2vu1t/U=;
 b=EVagQ4fa0zSk5gXpzKjvLyI6HOiNtVm6lja28/kh+P2EGOBe2S9Wwc9Fw1LKNnly1xA/vl
 URDLc+jS15agXwU7qqOd6itbZV3v+30I2AkNONkAysHdB9dm5v4Irl9517vFG/tqXIh5Ap
 ZsVAuLmmI/eQuNuVWhyv40C6pfa2A+g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-gCet8Bj7NpOLwA6SDlKkTg-1; Mon,
 29 Jun 2026 17:37:14 -0400
X-MC-Unique: gCet8Bj7NpOLwA6SDlKkTg-1
X-Mimecast-MFC-AGG-ID: gCet8Bj7NpOLwA6SDlKkTg_1782769032
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7D05819775F4; Mon, 29 Jun 2026 21:37:12 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.171])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5D00819560AD; Mon, 29 Jun 2026 21:37:06 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 linux-edac@vger.kernel.org, Markus Armbruster <armbru@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Alex Williamson <alex@shazbot.org>, Paolo Bonzini <pbonzini@redhat.com>,
 zhenwei pi <zhenwei.pi@linux.dev>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Lukas Straub <lukasstraub2@web.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 07/14] qapi: convert intro sections for trace.json
Date: Mon, 29 Jun 2026 17:36:17 -0400
Message-ID: <20260629213624.936258-8-jsnow@redhat.com>
In-Reply-To: <20260629213624.936258-1-jsnow@redhat.com>
References: <20260629213624.936258-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/trace.json | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/qapi/trace.json b/qapi/trace.json
index de369dae6b5..29c76256055 100644
--- a/qapi/trace.json
+++ b/qapi/trace.json
@@ -14,8 +14,7 @@
 
 ##
 # @TraceEventState:
-#
-# State of a tracing event.
+#     State of a tracing event.
 #
 # @unavailable: The event is statically disabled.
 #
@@ -30,8 +29,7 @@
 
 ##
 # @TraceEventInfo:
-#
-# Information of a tracing event.
+#     Information of a tracing event.
 #
 # @name: Event name.
 #
@@ -44,8 +42,7 @@
 
 ##
 # @trace-event-get-state:
-#
-# Query the state of events.
+#     Query the state of events.
 #
 # @name: Event name pattern (case-sensitive glob).
 #
@@ -65,8 +62,7 @@
 
 ##
 # @trace-event-set-state:
-#
-# Set the dynamic tracing state of events.
+#     Set the dynamic tracing state of events.
 #
 # @name: Event name pattern (case-sensitive glob).
 #
-- 
2.54.0


