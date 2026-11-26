Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C90D606A326
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LVMuNjUl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWWIg-0008CN-H1; Thu, 26 Nov 2026 05:01:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWWIZ-000883-IQ
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 05:01:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWWIX-0006gn-MB
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 05:01:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795687307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TzyxYu8uVV1fpCrdtPKqxBSDBIi7L38YQ2ichJzx/20=;
 b=LVMuNjUlcJh77N1KapdepEflCod2dwQBiCcUesShb2NegREuhDigaM7gHudQ5YuFvjq0ut
 P8kECl1bKAAgkShhFZUUPz5F5tAiautqZF2eyFrBbwk+7kjFo4c5JrjLIxBZTMOoGKmqUf
 moInoKrHie39wnz+T15OlOmG9THKrAM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-185-c0AyTD32Od-7ooBTUTWw5g-1; Thu,
 26 Nov 2026 10:01:43 +0000
X-MC-Unique: c0AyTD32Od-7ooBTUTWw5g-1
X-Mimecast-MFC-AGG-ID: c0AyTD32Od-7ooBTUTWw5g_1795687302
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8ED5018004BB; Thu, 26 Nov 2026 10:01:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 365361956086; Thu, 26 Nov 2026 10:01:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BFBE321E6880; Thu, 26 Nov 2026 11:01:39 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 jsnow@redhat.com, crosa@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org
Subject: [PATCH 02/16] util: Wean query-command-line-options off
 ObjectProperty member @type
Date: Thu, 26 Nov 2026 11:01:25 +0100
Message-ID: <20261126100139.3557890-3-armbru@redhat.com>
In-Reply-To: <20261126100139.3557890-1-armbru@redhat.com>
References: <20261126100139.3557890-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ObjectProperty member @type comes from object_property_try_add() /
object_class_property_add() parameter @type.  The former's function
comment calls it "pretty loosely defined".  This lack of discipline
has turned out to be problematic.  I'm replacing it step by step.

query-command-line-options derives CommandLineParameterInfo member
@type from it for class properties of machine types.  Derive from
@qapi_type instead, which is rigorously defined.

The type of qemu-system-ppc64 machine parameter
"cap-hpt-max-page-size" changes from "number" to "size", because @type
is "int", whereas @qapi_type is &size_type_info.  Small improvement.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 util/qemu-config-qmp-cmds.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/util/qemu-config-qmp-cmds.c b/util/qemu-config-qmp-cmds.c
index a680c9feca5..e0038628f97 100644
--- a/util/qemu-config-qmp-cmds.c
+++ b/util/qemu-config-qmp-cmds.c
@@ -98,16 +98,17 @@ static CommandLineParameterInfoList *get_drive_infolist(void)
 
 static CommandLineParameterInfo *objprop_to_cmdline_prop(ObjectProperty *prop)
 {
+    const QAPITypeInfo *qt = prop->qapi_type;
     CommandLineParameterInfo *info;
 
     info = g_malloc0(sizeof(*info));
     info->name = g_strdup(prop->name);
 
-    if (g_str_equal(prop->type, "bool") || g_str_equal(prop->type, "OnOffAuto")) {
+    if (g_str_equal(qt->name, "bool") || g_str_equal(qt->name, "OnOffAuto")) {
         info->type = COMMAND_LINE_PARAMETER_TYPE_BOOLEAN;
-    } else if (g_str_equal(prop->type, "int")) {
+    } else if (g_str_equal(qt->name, "int")) {
         info->type = COMMAND_LINE_PARAMETER_TYPE_NUMBER;
-    } else if (g_str_equal(prop->type, "size")) {
+    } else if (g_str_equal(qt->name, "size")) {
         info->type = COMMAND_LINE_PARAMETER_TYPE_SIZE;
     } else {
         info->type = COMMAND_LINE_PARAMETER_TYPE_STRING;
-- 
2.55.0


