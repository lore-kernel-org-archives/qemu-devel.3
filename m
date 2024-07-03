Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 979CCC2BD09
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 21:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP77a-0000or-JG; Wed, 03 Jul 2024 17:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sP77Z-0000nI-Fs
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 17:02:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sP77Y-0001DU-26
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 17:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720040551;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PagiVVcxaoz6SG+vMEHIcFhw1tdKzH4mYLKugaIWlWs=;
 b=P9CyutWBqrM/GjgHpLEtKRsjvFQbA8O4EXpoo14n1o/7UiEexM8O/oGlKSP8dpu7O2+7KP
 3YkUCrDtxAQo+KziIoS+VcVr4qWOyQjmYn0XQH33AKZdLPTf3ipY3X76QN2MvB+qN41KF+
 3yDntDshhMzJyiF6ucwytWXuGFbAsHg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-7-Cx_fKnGuPXGPL6BUgfI3Gg-1; Wed,
 03 Jul 2024 17:02:23 -0400
X-MC-Unique: Cx_fKnGuPXGPL6BUgfI3Gg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 383D419560B2; Wed,  3 Jul 2024 21:02:21 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.34.31])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B81251955E8F; Wed,  3 Jul 2024 21:02:14 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Hanna Reitz <hreitz@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Jiri Pirko <jiri@resnulli.us>,
 Harmonie Snow <harmonie@gmail.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 4/8] docs/sphinx: add CSS styling for qmp-example directive
Date: Wed,  3 Jul 2024 17:01:39 -0400
Message-ID: <20240703210144.339530-5-jsnow@redhat.com>
In-Reply-To: <20240703210144.339530-1-jsnow@redhat.com>
References: <20240703210144.339530-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Harmonie Snow <harmonie@gmail.com>

Add CSS styling for qmp-example directives to increase readability and
consistently style all example blocks.

Signed-off-by: Harmonie Snow <harmonie@gmail.com>
Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx-static/theme_overrides.css | 49 ++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/docs/sphinx-static/theme_overrides.css b/docs/sphinx-static/theme_overrides.css
index c70ef951286..965ecac54fd 100644
--- a/docs/sphinx-static/theme_overrides.css
+++ b/docs/sphinx-static/theme_overrides.css
@@ -87,6 +87,55 @@ div[class^="highlight"] pre {
     padding-bottom: 1px;
 }
 
+/* qmp-example directive styling */
+
+.rst-content .admonition-example {
+    /* do not apply the standard admonition background */
+    background-color: transparent;
+    border: solid #ffd2ed 1px;
+}
+
+.rst-content .admonition-example > .admonition-title:before {
+    content: "▷";
+}
+
+.rst-content .admonition-example > .admonition-title {
+    background-color: #5980a6;
+}
+
+.rst-content .admonition-example > div[class^="highlight"] {
+    /* make code boxes take up the full width of the admonition w/o margin */
+    margin-left: -12px;
+    margin-right: -12px;
+
+    border-top: 1px solid #ffd2ed;
+    border-bottom: 1px solid #ffd2ed;
+    border-left: 0px;
+    border-right: 0px;
+}
+
+.rst-content .admonition-example > div[class^="highlight"]:nth-child(2) {
+    /* If a code box is the second element in an example admonition,
+     * it is the first child after the title. let it sit flush against
+     * the title. */
+    margin-top: -12px;
+    border-top: 0px;
+}
+
+.rst-content .admonition-example > div[class^="highlight"]:last-child {
+    /* If a code box is the final element in an example admonition, don't
+     * render margin below it; let it sit flush with the end of the
+     * admonition box */
+    margin-bottom: -12px;
+    border-bottom: 0px;
+}
+
+.rst-content .admonition-example .highlight {
+    background-color: #fffafd;
+}
+
+/* end qmp-example styling */
+
 @media screen {
 
     /* content column
-- 
2.45.0


