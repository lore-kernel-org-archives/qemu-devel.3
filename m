Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDF6FC4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 07:49:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWti8-0003Js-TS; Mon, 05 Feb 2024 02:48:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWthN-00033J-RI
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 02:47:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rWthG-00064F-4b
 for qemu-devel@nongnu.org; Mon, 05 Feb 2024 02:47:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707119237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DI3xOKCAdTmIsVMcuw8btdqgochVN7h42E80Oq59w5c=;
 b=FQUaGcKc0kdbQJrbOtZE+Fh7Wk5JFBXaYu2j1fUMI3jAlJQYiAobIZ7xblkotLyRmAVQA0
 rC2tsX0TZIAqrXtpgRvhwNpAf11bCj6NSscD+S+YvPChT3g0RlXAEl19F7U7pF4SvqfF2N
 ZE1oRMyQ8IfKFH8MU5GLtIFgtsGgFcU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-YbyUk7NeNQGyVzFlJlyRJw-1; Mon,
 05 Feb 2024 02:47:12 -0500
X-MC-Unique: YbyUk7NeNQGyVzFlJlyRJw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1974E1C54465;
 Mon,  5 Feb 2024 07:47:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E82903C2E;
 Mon,  5 Feb 2024 07:47:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4C57721E60DC; Mon,  5 Feb 2024 08:47:09 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: arei.gonglei@huawei.com, armbru@redhat.com, berrange@redhat.com,
 eblake@redhat.com, eduardo@habkost.net, fan.ni@samsung.com,
 farosas@suse.de, hreitz@redhat.com, jasowang@redhat.com, jiri@resnulli.us,
 jonathan.cameron@huawei.com, kkostiuk@redhat.com, kraxel@redhat.com,
 kwolf@redhat.com, lukasstraub2@web.de, marcandre.lureau@redhat.com,
 marcel.apfelbaum@gmail.com, michael.roth@amd.com, mst@redhat.com,
 pbonzini@redhat.com, peter.maydell@linaro.org, peterx@redhat.com,
 philmd@linaro.org, pizhenwei@bytedance.com, qemu-block@nongnu.org,
 stefanb@linux.ibm.com, wangyanan55@huawei.com
Subject: [PATCH 05/15] sphinx/qapidoc: Drop code to generate doc for simple
 union tag
Date: Mon,  5 Feb 2024 08:46:59 +0100
Message-ID: <20240205074709.3613229-6-armbru@redhat.com>
In-Reply-To: <20240205074709.3613229-1-armbru@redhat.com>
References: <20240205074709.3613229-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.361,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

QAPISchemaGenRSTVisitor._nodes_for_members() has a special case to
auto-generate documentation for a union tag member of implicit (enum)
type that lacks documentation.

This was useful for simple unions, where the tag member's type was
implicitly.  The only implicit enum type left today is 'QType'.  Not
worth a special case.  Drop.  No change to generated documentation.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapidoc.py | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 658c288f8f..05b809af27 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -168,12 +168,6 @@ def _nodes_for_members(self, doc, what, base=None, variants=None):
             # TODO drop fallbacks when undocumented members are outlawed
             if section.text:
                 defn = section.text
-            elif (variants and variants.tag_member == section.member
-                  and not section.member.type.doc_type()):
-                values = section.member.type.member_names()
-                defn = [nodes.Text('One of ')]
-                defn.extend(intersperse([nodes.literal('', v) for v in values],
-                                        nodes.Text(', ')))
             else:
                 defn = [nodes.Text('Not documented')]
 
-- 
2.43.0


