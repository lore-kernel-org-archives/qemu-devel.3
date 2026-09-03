Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C16C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 10:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x24nh-0002Yh-3z; Thu, 03 Sep 2026 06:36:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x24nf-0002YX-S9
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:36:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x24ne-0005YE-EB
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 06:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788431765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oPy1ksp6gtD+A3ruB6FcDpFfwWSnhJP9CWRyvWvFk3Q=;
 b=EUA9f7diekeYg3O2MtIxGu0EQXjb6gl9+3TfReQhMEAVBKoVIWWRBEuj6l0LspPEM5xoa0
 UgV3fvS+I+uNSIMCPXFfFl+68tthR/+U1dTSgLDGJhlXls1bM7FxGWf8Ny/Hl7uxmEiTPT
 0TMDWL4iIi+9P3BiMswUSBVx9eVKCTk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-V95pGhkdPHaOEgXUJh_Fig-1; Thu,
 03 Sep 2026 06:36:01 -0400
X-MC-Unique: V95pGhkdPHaOEgXUJh_Fig-1
X-Mimecast-MFC-AGG-ID: V95pGhkdPHaOEgXUJh_Fig_1788431760
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 439F4195608E; Thu,  3 Sep 2026 10:36:00 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id AB41C18005B8; Thu,  3 Sep 2026 10:35:58 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 4/4] meson: warn on GCC < 12.0 due to lack of
 -ftrivial-auto-var-init=zero
Date: Thu,  3 Sep 2026 11:35:48 +0100
Message-ID: <20260903103548.2142568-5-berrange@redhat.com>
In-Reply-To: <20260903103548.2142568-1-berrange@redhat.com>
References: <20260903103548.2142568-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The security policy for assigning CVEs has an assumption that all
stack variables are zero initialized. Our CLang min version gives
us -ftrivial-auto-var-init=zero, but that is only available in GCC
12 onwards.

Our min GCC is 10.4 but only NetBSD has such an old version.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 meson.build | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/meson.build b/meson.build
index 5315420a41..eeca8d074a 100644
--- a/meson.build
+++ b/meson.build
@@ -327,6 +327,12 @@ endif
 foreach lang : all_languages
   compiler = meson.get_compiler(lang)
   if compiler.get_id() == 'gcc' and compiler.version().version_compare('>=10.4')
+      if not compiler.version().version_compare('>=12.0')
+          warning('GCC < 12.0 does not support -ftrivial-auto-var-init=zero.')
+          warning('This compiler will not satisfy the QEMU security policy ')
+          warning('for assigning CVE which is predicated on zero-initialization ')
+          warning('of  stack variables. Update to GCC 12.0 or use CLang >= 17.0 ')
+      endif
     # ok
   elif compiler.get_id() == 'clang' and compiler.compiles('''
       #ifdef __apple_build_version__
-- 
2.55.0


