Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD9FCA5FD2
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 15:14:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCISh-0000qI-6x; Thu, 01 Oct 2026 11:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCISf-0000q3-OL
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 11:12:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xCISe-0000uX-Bc
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 11:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790867559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sypz/BgWChTRSIxZdQNXlaZ+pSkAaVAKoHDa+kh8fWk=;
 b=DPAQqnjYVAdZjkl4T6vu3z1efKEsJStTxmqxa66/q+LQuVXI7fx9brAJUEU5CqBPq5tXuN
 4xn4As7zM2lIrzvCFyQMoFbttqnV4UUBZGNACHeW7HMC5zSyeA1naXk+aNBT8GJ07LkWwj
 uRlMUg1jfoiYQIfYkxIiGtb3OaZ/YIs=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-665-zG2bluv8NTqSV-b6MvbiEw-1; Thu,
 01 Oct 2026 11:12:38 -0400
X-MC-Unique: zG2bluv8NTqSV-b6MvbiEw-1
X-Mimecast-MFC-AGG-ID: zG2bluv8NTqSV-b6MvbiEw_1790867557
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E36A1955F7B
 for <qemu-devel@nongnu.org>; Thu,  1 Oct 2026 15:12:37 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4C67D1956042; Thu,  1 Oct 2026 15:12:36 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 05/20] trace: block use of "long int" for dtrace
Date: Thu,  1 Oct 2026 16:12:13 +0100
Message-ID: <20261001151228.3373747-6-berrange@redhat.com>
In-Reply-To: <20261001151228.3373747-1-berrange@redhat.com>
References: <20261001151228.3373747-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

dtrace (or at least systemtap's fake "dtrace" binary) complains about a
syntax error due to use of "long int", as it wants a bare "long" type
Enforce this when parsing the trace-events files.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/tracetool/__init__.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/tracetool/__init__.py b/scripts/tracetool/__init__.py
index 61ba6f1ba8c..6ed7cdd6ce4 100644
--- a/scripts/tracetool/__init__.py
+++ b/scripts/tracetool/__init__.py
@@ -177,6 +177,11 @@ def out(*lines, **kwargs):
 
 def validate_type(name):
     bits = name.split(" ")
+
+    if "long" in bits and "int" in bits:
+        raise ValueError("Invalid use of 'int' typename in %s, "
+                         "use 'long' alone" % name)
+
     for bit in bits:
         bit = re.sub(r"\*", "", bit)
         if bit == "":
-- 
2.55.0


