Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72468C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 18:33:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKLZk-0002a3-5Y; Wed, 28 May 2025 14:32:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKLZV-0002MF-Ua
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:32:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKLZL-000721-NL
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748457120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jbbKO/8e9ELPl17p7WOwGUUuLPNMmBDMz+pvKTsft84=;
 b=Er/qDjLRT0D2iqa0+NLOEATYxacjYm2Y2RdlstHBV8FYRLlg9VGUu1wgwQVm5epcWhNebh
 JPj3jmn1ZhAXA5Tw3NWpoa4PhkM2faitZCqNRDB090HMRDZUCMds4Mc8lLcpHsXS4ns01P
 4Fr88INo4JhxFC81LQaMjLPg6zafVME=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-489-KJDIAnvGOA-KrxDndgeuVQ-1; Wed,
 28 May 2025 14:31:59 -0400
X-MC-Unique: KJDIAnvGOA-KrxDndgeuVQ-1
X-Mimecast-MFC-AGG-ID: KJDIAnvGOA-KrxDndgeuVQ_1748457118
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 468CA19560BC; Wed, 28 May 2025 18:31:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EDC1919560AA; Wed, 28 May 2025 18:31:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B966B21E65FD; Wed, 28 May 2025 20:31:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 11/13] qapi: remove qapi_specific_outputs from meson.build
Date: Wed, 28 May 2025 20:31:49 +0200
Message-ID: <20250528183151.2839034-12-armbru@redhat.com>
In-Reply-To: <20250528183151.2839034-1-armbru@redhat.com>
References: <20250528183151.2839034-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

There is no more QAPI files that need to be compiled per target, so we
can remove this. qapi_specific_outputs is now empty, so we can remove
the associated logic in meson.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250522190542.588267-12-pierrick.bouvier@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/meson.build | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/qapi/meson.build b/qapi/meson.build
index e038b636c9..7582c2b5bc 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -92,7 +92,6 @@ qapi_util_outputs = [
 ]
 
 qapi_inputs = []
-qapi_specific_outputs = []
 foreach module : qapi_all_modules
   qapi_inputs += [ files(module + '.json') ]
   qapi_module_outputs = [
@@ -110,15 +109,11 @@ foreach module : qapi_all_modules
       'qapi-commands-@0@.trace-events'.format(module),
     ]
   endif
-  if module.endswith('-target')
-    qapi_specific_outputs += qapi_module_outputs
-  else
-    qapi_util_outputs += qapi_module_outputs
-  endif
+  qapi_util_outputs += qapi_module_outputs
 endforeach
 
 qapi_files = custom_target('shared QAPI source files',
-  output: qapi_util_outputs + qapi_specific_outputs + qapi_nonmodule_outputs,
+  output: qapi_util_outputs + qapi_nonmodule_outputs,
   input: [ files('qapi-schema.json') ],
   command: [ qapi_gen, '-o', 'qapi', '-b', '@INPUT0@' ],
   depend_files: [ qapi_inputs, qapi_gen_depends ])
@@ -138,7 +133,7 @@ foreach output : qapi_util_outputs
   i = i + 1
 endforeach
 
-foreach output : qapi_specific_outputs + qapi_nonmodule_outputs
+foreach output : qapi_nonmodule_outputs
   if output.endswith('.h')
     genh += qapi_files[i]
   endif
-- 
2.48.1


