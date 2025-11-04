Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C7E0CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 13:23:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGGyi-0000D7-3s; Tue, 04 Nov 2025 08:21:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vGGyd-0000Bc-M7
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 08:21:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vGGya-0001Jf-M2
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 08:21:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762262490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UAjG9UNM1vmprJ5mYPe9mBwIiCwja2sU/uXZicUIoaw=;
 b=cR8Sws0lfS2G1Ynd5zfdSN8+qUmwIn3dqZNp5wBAn2lFOhpo7xKz6vcGoXcFu8mo4AlY3Z
 xgWqNHitCWyzm0hIUxL+QxqcpOUchEj0JSd+ke3X0IJNCTv57qspykJta9e2m45g2/yPF5
 sK6xWfRQxm3UlrzVMsOdE69YUCa5wkQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-539-xo747yoCNP2bu1YQTXzgSA-1; Tue,
 04 Nov 2025 08:21:29 -0500
X-MC-Unique: xo747yoCNP2bu1YQTXzgSA-1
X-Mimecast-MFC-AGG-ID: xo747yoCNP2bu1YQTXzgSA_1762262488
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 765001808981; Tue,  4 Nov 2025 13:21:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1299618004D8; Tue,  4 Nov 2025 13:21:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 644B021E6925; Tue, 04 Nov 2025 14:21:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 02/12] meson: Add missing backends.py to qapi_gen_depends
Date: Tue,  4 Nov 2025 14:21:15 +0100
Message-ID: <20251104132125.4134730-3-armbru@redhat.com>
In-Reply-To: <20251104132125.4134730-1-armbru@redhat.com>
References: <20251104132125.4134730-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Fixes: dde279925c97 (qapi: pluggable backend code generators)
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20251029120024.1426996-1-armbru@redhat.com>
---
 meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/meson.build b/meson.build
index df876c72f0..f3108f1c2a 100644
--- a/meson.build
+++ b/meson.build
@@ -3561,11 +3561,13 @@ hxtool = find_program('scripts/hxtool')
 shaderinclude = find_program('scripts/shaderinclude.py')
 qapi_gen = find_program('scripts/qapi-gen.py')
 qapi_gen_depends = [ meson.current_source_dir() / 'scripts/qapi/__init__.py',
+                     meson.current_source_dir() / 'scripts/qapi/backend.py',
                      meson.current_source_dir() / 'scripts/qapi/commands.py',
                      meson.current_source_dir() / 'scripts/qapi/common.py',
                      meson.current_source_dir() / 'scripts/qapi/error.py',
                      meson.current_source_dir() / 'scripts/qapi/events.py',
                      meson.current_source_dir() / 'scripts/qapi/expr.py',
+                     meson.current_source_dir() / 'scripts/qapi/features.py',
                      meson.current_source_dir() / 'scripts/qapi/gen.py',
                      meson.current_source_dir() / 'scripts/qapi/introspect.py',
                      meson.current_source_dir() / 'scripts/qapi/main.py',
@@ -3573,7 +3575,6 @@ qapi_gen_depends = [ meson.current_source_dir() / 'scripts/qapi/__init__.py',
                      meson.current_source_dir() / 'scripts/qapi/schema.py',
                      meson.current_source_dir() / 'scripts/qapi/source.py',
                      meson.current_source_dir() / 'scripts/qapi/types.py',
-                     meson.current_source_dir() / 'scripts/qapi/features.py',
                      meson.current_source_dir() / 'scripts/qapi/visit.py',
                      meson.current_source_dir() / 'scripts/qapi-gen.py'
 ]
-- 
2.49.0


