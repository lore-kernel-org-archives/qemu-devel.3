Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07278E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 01:18:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLuGG-00060T-AQ; Thu, 12 Dec 2024 20:14:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuGB-0005tm-UR
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:14:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuGA-0000ed-2w
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:14:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734052462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UzHNygLXVObLJFRUedomApYOH0eIg84xgMKEVnWctDs=;
 b=R4cjiueGa071Ph3pOjSx17iZXzlP7K+bRQZudfZytttKiHG1o2Lq9prbunXWi+sCPM5ZC2
 tGsYOzW4aZeHtdoaXZKynkmeRCM8i55prAaHLSeL0Z+sFs2S+pA2u3LsbkgcTlimGRet/G
 npxejiNNLDFAPc3dOepX+P0qIWBTyzM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-495-hhjiugPQN0WED5UGZNSoyw-1; Thu,
 12 Dec 2024 20:14:20 -0500
X-MC-Unique: hhjiugPQN0WED5UGZNSoyw-1
X-Mimecast-MFC-AGG-ID: hhjiugPQN0WED5UGZNSoyw
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 808181955F43; Fri, 13 Dec 2024 01:14:19 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.22])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D4030195609D; Fri, 13 Dec 2024 01:14:15 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 16/35] docs/qapi-domain: add "Returns:" field lists
Date: Thu, 12 Dec 2024 20:12:45 -0500
Message-ID: <20241213011307.2942030-17-jsnow@redhat.com>
In-Reply-To: <20241213011307.2942030-1-jsnow@redhat.com>
References: <20241213011307.2942030-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add "Returns:" field list syntax to QAPI Commands.

Like "Arguments:" and "Errors:", the type name isn't currently processed
for cross-referencing, but this will be addressed in a forthcoming
commit.

This patch adds "errors" as a GroupedField, which means that multiple
return values can be annotated - this is only done because Sphinx does
not seemingly (Maybe I missed it?) support mandatory type arguments to
Ungrouped fields. Because we want to cross-reference this type
information later, we want to make the type argument mandatory. As a
result, you can technically add multiple :return: fields, though I'm not
aware of any circumstance in which you'd need or want
to. Recommendation: "Don't do that, then."

Since this field describes an action/event instead of describing a list
of nouns (arguments, features, errors), I added both the imperative and
indicative forms (:return: and :returns:) to allow doc writers to use
whichever mood "feels right" in the source document. The rendered output
will always use the "Returns:" label, however.

I'm sure you'll let me know how you feel about that. O:-)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi-domain.py | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index 4bfc82aafdf..c8c8ffc0dce 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -268,6 +268,13 @@ class QAPICommand(QAPIObject):
                 names=("error", "errors"),
                 has_arg=False,
             ),
+            # :returns TypeName: descr
+            GroupedField(
+                "returnvalue",
+                label=_("Returns"),
+                names=("return", "returns"),
+                can_collapse=True,
+            ),
         ]
     )
 
-- 
2.47.0


