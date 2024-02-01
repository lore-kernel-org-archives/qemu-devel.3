Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BC6DC48292
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 22:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVfm0-0006Cd-LN; Thu, 01 Feb 2024 17:43:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rVflu-00069R-7o
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 17:43:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rVflp-0006aj-E4
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 17:42:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706827376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Laxz//13Fow5ms+2ff1VxYJP+RtEZ6U88gSorUMTHSE=;
 b=cQF1GwqRqvisMrAzNNiSzuMqE0z3xHBw3u/EBrReKJBHEyAiruFFMezWKaKAgTPFaFftv4
 v/K/AkApcshW3rBuLewUJRxmlYT/z+R+hLBK63HxcwoemsHefLuG5DWVMn0kqEIxz30QZR
 bDM9a8/PfxDPlzToUHJiNq8rqYWR0fw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-WjCoRC78MR2O1IYj4309Lg-1; Thu, 01 Feb 2024 17:42:53 -0500
X-MC-Unique: WjCoRC78MR2O1IYj4309Lg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF2578352A3;
 Thu,  1 Feb 2024 22:42:52 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.18.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 83E982166B33;
 Thu,  1 Feb 2024 22:42:52 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v3 09/20] qapi/schema: assert resolve_type has 'info' and
 'what' args on error
Date: Thu,  1 Feb 2024 17:42:35 -0500
Message-ID: <20240201224246.39480-10-jsnow@redhat.com>
In-Reply-To: <20240201224246.39480-1-jsnow@redhat.com>
References: <20240201224246.39480-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

resolve_type() is generally used to resolve configuration-provided type
names into type objects, and generally requires valid 'info' and 'what'
parameters.

In some cases, such as with QAPISchemaArrayType.check(), resolve_type
may be used to resolve built-in types and as such will not have an
'info' argument, but also must not fail in this scenario.

Use an assertion to sate mypy that we will indeed have 'info' and 'what'
parameters for the error pathway in resolve_type.

Note: there are only three callsites to resolve_type at present where
"info" is perceived to be possibly None:

    1) QAPISchemaArrayType.check()
    2) QAPISchemaObjectTypeMember.check()
    3) QAPISchemaEvent.check()

    Of those three, only the first actually ever passes None; the other two
    are limited by their base class initializers which accept info=None, but
    neither subclass actually use a None value in practice, currently.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/schema.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index e617abb03af..573be7275a6 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -1004,6 +1004,7 @@ def lookup_type(self, name):
     def resolve_type(self, name, info, what):
         typ = self.lookup_type(name)
         if not typ:
+            assert info and what  # built-in types must not fail lookup
             if callable(what):
                 what = what(info)
             raise QAPISemError(
-- 
2.43.0


