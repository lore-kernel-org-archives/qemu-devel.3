Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E26BCAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 11:28:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzZFt-00019z-Dy; Fri, 19 Sep 2025 07:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzZFe-00018F-B5
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:26:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uzZFV-00015y-3X
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 07:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758281154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nM1ctd6h2YEGewXFHto7qlkYZ0HE0gxY9P8cXkdZY54=;
 b=KZ8rWaLtRj7eUlT0g8YLXpzetBedcj8WOiWorwBG5LE2rhqOETdEdYEYIzlYDBnJIJAdLM
 kOxQ2WHbvQ+oW7xSkeH5WEyPa66oCJSklUrukGjAnmUH9HcqiHX8WfWt4k5D8G0DsbuVa+
 bzvSa5icrnh84qbS05dN6/ADAJlrNB4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-v_s98JX_OnCMaMyu9QuEkw-1; Fri,
 19 Sep 2025 07:25:49 -0400
X-MC-Unique: v_s98JX_OnCMaMyu9QuEkw-1
X-Mimecast-MFC-AGG-ID: v_s98JX_OnCMaMyu9QuEkw_1758281148
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C8D2E195608B; Fri, 19 Sep 2025 11:25:47 +0000 (UTC)
Received: from avogadro.redhat.com (unknown [10.44.33.250])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 477E430002C5; Fri, 19 Sep 2025 11:25:43 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tanish Desai <tanishdesai37@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>
Subject: [PATCH 01/16] tracetool: fix usage of try_import()
Date: Fri, 19 Sep 2025 13:25:21 +0200
Message-ID: <20250919112536.141782-2-pbonzini@redhat.com>
In-Reply-To: <20250919112536.141782-1-pbonzini@redhat.com>
References: <20250919112536.141782-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

try_import returns a tuple of a boolean and the requested module or attribute.
exists() functions return tracetool.try_import("tracetool.format." + name)[1]
but they should return the boolean value instead.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/tracetool/backend/__init__.py | 2 +-
 scripts/tracetool/format/__init__.py  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/tracetool/backend/__init__.py b/scripts/tracetool/backend/__init__.py
index 7bfcc86cc53..6c6344deddb 100644
--- a/scripts/tracetool/backend/__init__.py
+++ b/scripts/tracetool/backend/__init__.py
@@ -94,7 +94,7 @@ def exists(name):
     if name == "nop":
         return True
     name = name.replace("-", "_")
-    return tracetool.try_import("tracetool.backend." + name)[1]
+    return tracetool.try_import("tracetool.backend." + name)[0]
 
 
 class Wrapper:
diff --git a/scripts/tracetool/format/__init__.py b/scripts/tracetool/format/__init__.py
index 2dc46f3dd93..042fe7d103c 100644
--- a/scripts/tracetool/format/__init__.py
+++ b/scripts/tracetool/format/__init__.py
@@ -70,7 +70,7 @@ def exists(name):
     if len(name) == 0:
         return False
     name = name.replace("-", "_")
-    return tracetool.try_import("tracetool.format." + name)[1]
+    return tracetool.try_import("tracetool.format." + name)[0]
 
 
 def generate(events, format, backend, group):
-- 
2.51.0



