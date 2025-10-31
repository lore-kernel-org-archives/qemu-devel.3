Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EE0CCF9FA
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 09:49:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vElkD-0000Zb-PU; Fri, 31 Oct 2025 05:48:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vEljz-0000UF-Vi
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:48:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vEljo-0006hi-9O
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761904081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dmjVjw7yjlI2RnvRZfFoT4laT3ZIt0Twi6/RqZgefVg=;
 b=eyGQRNxgLgI5o2/nlWXOG2MuETEezRnCP7y+5y7yl4LjQ/vilC4NADG6ONzOr0vJLdU2zd
 KSPPwJpiWB7FHustiW2PKD2Cj40pYetvwayV24v7NFDiH2UZFkaINGkzh9iuq8wrUFjh3f
 gU3oWJwLJG0YE9TevnXQYW8SnO/o5mI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-siy1EFpmOcqJ90kT5gu4AQ-1; Fri,
 31 Oct 2025 05:47:58 -0400
X-MC-Unique: siy1EFpmOcqJ90kT5gu4AQ-1
X-Mimecast-MFC-AGG-ID: siy1EFpmOcqJ90kT5gu4AQ_1761904077
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A47119541B5; Fri, 31 Oct 2025 09:47:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3013180058D; Fri, 31 Oct 2025 09:47:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4A3AA21E6779; Fri, 31 Oct 2025 10:47:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, vsementsov@yandex-team.ru,
 thuth@redhat.com, berrange@redhat.com, philmd@linaro.org,
 kchamart@redhat.com, mst@redhat.com, sgarzare@redhat.com
Subject: [PATCH 8/8] docs/interop: Add test to keep vhost-user.json sane
Date: Fri, 31 Oct 2025 10:47:51 +0100
Message-ID: <20251031094751.2817932-9-armbru@redhat.com>
In-Reply-To: <20251031094751.2817932-1-armbru@redhat.com>
References: <20251031094751.2817932-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

We did this for firmware.json in commit d4181658dfb (docs: add test
for firmware.json QAPI).

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/meson.build | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/docs/meson.build b/docs/meson.build
index 3676f81c4d..7e54b01e6a 100644
--- a/docs/meson.build
+++ b/docs/meson.build
@@ -99,7 +99,12 @@ if build_docs
   alias_target('man', sphinxmans)
 endif
 
-test('QAPI firmware.json regression tests', qapi_gen,
-     args: ['-o', meson.current_build_dir() / 'qapi',
+test('QAPI firmware.json regression test', qapi_gen,
+     args: ['-o', meson.current_build_dir() / 'qapi-firmware',
             meson.current_source_dir() / 'interop/firmware.json'],
      suite: ['qapi-schema', 'qapi-interop'])
+
+test('QAPI vhost-user.json regression test', qapi_gen,
+     args: ['-o', meson.current_build_dir() / 'qapi-vhost-user',
+            meson.current_source_dir() / 'interop/vhost-user.json'],
+     suite: ['qapi-schema', 'qapi-interop'])
-- 
2.49.0


