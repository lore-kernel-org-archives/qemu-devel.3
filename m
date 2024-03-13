Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98282C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 04:46:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkGRD-0007zZ-Rr; Wed, 13 Mar 2024 00:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rkGQw-0007vD-W5
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 00:41:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rkGQt-0001sf-QJ
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 00:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710304899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CCH8WZGnetuLi/Vjg7rgK5VnHrrnv6sYVRCoQHjt66c=;
 b=CuAHQO9DPtV1PFGY2XsLnU0wpq5iw6jAQ8yITTjF5vv4vvioKdrJP4SnMs6/V1GGtctSot
 VCaQ7WAsE0b1YkwY+Zus+xYFw+UF1FMqJ0SbrpFtMh29GSgq9oaKVn0LGhmQbfKUxMBsxJ
 8uQ15yYjH2n8sy8RNo/Z54lZjXiIDaI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-smsHN-FMMhydcYG1RCVh0A-1; Wed,
 13 Mar 2024 00:41:33 -0400
X-MC-Unique: smsHN-FMMhydcYG1RCVh0A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3340729AB3F6;
 Wed, 13 Mar 2024 04:41:33 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.16.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA47610E4B;
 Wed, 13 Mar 2024 04:41:32 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v4 13/23] qapi/schema: fix QAPISchemaArrayType.check's call to
 resolve_type
Date: Wed, 13 Mar 2024 00:41:17 -0400
Message-ID: <20240313044127.49089-14-jsnow@redhat.com>
In-Reply-To: <20240313044127.49089-1-jsnow@redhat.com>
References: <20240313044127.49089-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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

Adjust the expression at the callsite to work around mypy's weak type
introspection that believes this expression can resolve to
QAPISourceInfo; it cannot.

(Fundamentally: self.info only resolves to false in a boolean expression
when it is None; therefore this expression may only ever produce
Optional[str]. mypy does not know that 'info', when it is a
QAPISourceInfo object, cannot ever be false.)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/schema.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 58ec3a7c41c..22e065fc13d 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -395,7 +395,7 @@ def check(self, schema):
         super().check(schema)
         self.element_type = schema.resolve_type(
             self._element_type_name, self.info,
-            self.info and self.info.defn_meta)
+            self.info.defn_meta if self.info else None)
         assert not isinstance(self.element_type, QAPISchemaArrayType)
 
     def set_module(self, schema):
-- 
2.44.0


