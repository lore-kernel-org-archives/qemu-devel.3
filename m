Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59E80C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 18:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKLZq-0002fA-4p; Wed, 28 May 2025 14:32:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKLZV-0002ME-TW
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:32:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uKLZR-00072M-EK
 for qemu-devel@nongnu.org; Wed, 28 May 2025 14:32:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748457122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FTS2Y+wU+Xs4KfeT9aobMkZD6kSP2Ljeaav42ei1A4w=;
 b=DhTvNVlKqLHbNkQDT5Jjc6EOlEvHC2eJP037gxhBy8tvwAz95Cy2c6mbUE4o+Pr5GoYiXc
 fjRlqUrEXA8S7VH11GFxmkSPUYH4ASYhxd25oSFotYF1+4EULvDq89iPoqrr3hzfWz27lj
 636WPKvDrJdCBvEMnGe2tXuU/J5pT9U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-614-7rlswJc2M1KROQyxyw1rMQ-1; Wed,
 28 May 2025 14:32:00 -0400
X-MC-Unique: 7rlswJc2M1KROQyxyw1rMQ-1
X-Mimecast-MFC-AGG-ID: 7rlswJc2M1KROQyxyw1rMQ_1748457119
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73ECE180048E; Wed, 28 May 2025 18:31:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.38])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 282AA1956096; Wed, 28 May 2025 18:31:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BD41921E65FE; Wed, 28 May 2025 20:31:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 12/13] qapi: make all generated files common
Date: Wed, 28 May 2025 20:31:50 +0200
Message-ID: <20250528183151.2839034-13-armbru@redhat.com>
In-Reply-To: <20250528183151.2839034-1-armbru@redhat.com>
References: <20250528183151.2839034-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

Monolithic files (qapi_nonmodule_outputs) can now be compiled just
once, so we can remove qapi_util_outputs logic.
This removes the need for any specific_ss file.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-ID: <20250522190542.588267-13-pierrick.bouvier@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/meson.build | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/qapi/meson.build b/qapi/meson.build
index 7582c2b5bc..3b035aea33 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -85,8 +85,7 @@ qapi_nonmodule_outputs = [
   'qapi-emit-events.c', 'qapi-emit-events.h',
 ]
 
-# First build all sources
-qapi_util_outputs = [
+qapi_outputs = qapi_nonmodule_outputs + [
   'qapi-builtin-types.c', 'qapi-builtin-visit.c',
   'qapi-builtin-types.h', 'qapi-builtin-visit.h',
 ]
@@ -109,20 +108,17 @@ foreach module : qapi_all_modules
       'qapi-commands-@0@.trace-events'.format(module),
     ]
   endif
-  qapi_util_outputs += qapi_module_outputs
+  qapi_outputs += qapi_module_outputs
 endforeach
 
 qapi_files = custom_target('shared QAPI source files',
-  output: qapi_util_outputs + qapi_nonmodule_outputs,
+  output: qapi_outputs,
   input: [ files('qapi-schema.json') ],
   command: [ qapi_gen, '-o', 'qapi', '-b', '@INPUT0@' ],
   depend_files: [ qapi_inputs, qapi_gen_depends ])
 
-# Now go through all the outputs and add them to the right sourceset.
-# These loops must be synchronized with the output of the above custom target.
-
 i = 0
-foreach output : qapi_util_outputs
+foreach output : qapi_outputs
   if output.endswith('.h')
     genh += qapi_files[i]
   endif
@@ -132,14 +128,3 @@ foreach output : qapi_util_outputs
   util_ss.add(qapi_files[i])
   i = i + 1
 endforeach
-
-foreach output : qapi_nonmodule_outputs
-  if output.endswith('.h')
-    genh += qapi_files[i]
-  endif
-  if output.endswith('.trace-events')
-    qapi_trace_events += qapi_files[i]
-  endif
-  specific_ss.add(when: 'CONFIG_SYSTEM_ONLY', if_true: qapi_files[i])
-  i = i + 1
-endforeach
-- 
2.48.1


