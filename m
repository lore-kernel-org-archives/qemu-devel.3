Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E676DC25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEW9j-0006g4-PH; Tue, 04 Jun 2024 11:32:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEW9i-0006f7-1P
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:32:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEW9g-0001IO-Gy
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717515175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o7tJ3bO80lxZEewEVW7HLEMavqplS8Nmt28huutAp+I=;
 b=XuCudweGB4WE30ePzAXCMJrAbNjAQCGRE8Vi/wEniuRnXT+f/wahuNuCB2BWPC/tl/uvbn
 EFjgSmi//abmljfJlcZ/YnbOjUEpv2lyG+/fA12opaxuOGl8aZq5EMAT7PHS4Bg6KZm5cr
 pgg2DLG0VlGQYlXhWIX46QyefX7ZvkI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-zmBY7pfqOZ2cBayljcoVew-1; Tue, 04 Jun 2024 11:32:49 -0400
X-MC-Unique: zmBY7pfqOZ2cBayljcoVew-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 09104185A78E;
 Tue,  4 Jun 2024 15:32:49 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.39.194.137])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 380BE492BCE;
 Tue,  4 Jun 2024 15:32:48 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 04/14] qapi: add a 'command-features' pragma
Date: Tue,  4 Jun 2024 16:32:32 +0100
Message-ID: <20240604153242.251334-5-berrange@redhat.com>
In-Reply-To: <20240604153242.251334-1-berrange@redhat.com>
References: <20240604153242.251334-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The 'command-features' pragma allows for defining additional
special features that are unique to a particular QAPI schema
instance and its implementation.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/qapi/parser.py | 2 ++
 scripts/qapi/source.py | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 7b13a583ac..36a9046243 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -243,6 +243,8 @@ def check_list_str(name: str, value: object) -> List[str]:
             pragma.documentation_exceptions = check_list_str(name, value)
         elif name == 'member-name-exceptions':
             pragma.member_name_exceptions = check_list_str(name, value)
+        elif name == 'command-features':
+            pragma.command_features = check_list_str(name, value)
         else:
             raise QAPISemError(info, "unknown pragma '%s'" % name)
 
diff --git a/scripts/qapi/source.py b/scripts/qapi/source.py
index 7b379fdc92..07c2958ac4 100644
--- a/scripts/qapi/source.py
+++ b/scripts/qapi/source.py
@@ -28,6 +28,8 @@ def __init__(self) -> None:
         self.documentation_exceptions: List[str] = []
         # Types whose member names may violate case conventions
         self.member_name_exceptions: List[str] = []
+        # Arbitrary extra features recorded against commands
+        self.command_features: List[str] = []
 
 
 class QAPISourceInfo:
-- 
2.45.1


