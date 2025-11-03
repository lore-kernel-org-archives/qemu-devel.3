Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B76CCFA06
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 08:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vFprw-0000zF-4R; Mon, 03 Nov 2025 03:24:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vFprc-0000wM-2K
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 03:24:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vFprF-0006kF-4s
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 03:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762158246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UMmubR2JKEroEu+eneu4FesjsA/osmrUP43LccngfzA=;
 b=B5mQLkMIPaptUvbjO/0iEoE3BuAq0wERQX9wJMWTdcdZ0CCGmFRSE1Gy8iRDDNASuj8aZt
 6EvbqVn/VTas9WIFaT2iKDb2U0rrPk60U2vFMnieJtXi5ffOPcPoPWgQ0rtxiDIWnGpDuQ
 kkE7FSNGLH6MFxy1nCMEYEDzpWj00Dc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-b7FbG1vcNVuCeY23nhi6IQ-1; Mon,
 03 Nov 2025 03:24:02 -0500
X-MC-Unique: b7FbG1vcNVuCeY23nhi6IQ-1
X-Mimecast-MFC-AGG-ID: b7FbG1vcNVuCeY23nhi6IQ_1762158241
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7E461954230; Mon,  3 Nov 2025 08:24:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5D7941955BE3; Mon,  3 Nov 2025 08:24:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1C38F21E677A; Mon, 03 Nov 2025 09:23:55 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, eblake@redhat.com, vsementsov@yandex-team.ru,
 thuth@redhat.com, berrange@redhat.com, philmd@linaro.org,
 kchamart@redhat.com, mst@redhat.com, sgarzare@redhat.com
Subject: [PATCH v2 9/9] docs/interop: Add test to keep vhost-user.json sane
Date: Mon,  3 Nov 2025 09:23:54 +0100
Message-ID: <20251103082354.3273027-10-armbru@redhat.com>
In-Reply-To: <20251103082354.3273027-1-armbru@redhat.com>
References: <20251103082354.3273027-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
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


