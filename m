Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E85D9D111A8
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 11:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ21N-0001o7-8I; Mon, 01 Dec 2025 06:24:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ21L-0001cE-8A
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:24:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vQ21J-0006cJ-Os
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 06:24:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764588281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WIKo7w2GHW/q7SLrcO5Qg01VSqMPQaJgBVlfEQ4RmBw=;
 b=U0I7ij/QKMiEwM1Hcb2BgQe+lnXAZZtnLD/rGj3HoTWAaZZbjqIpmoFqLZL7PLfor7exJG
 bgEw+/4t34UKx7X22EwPDwNDKaFn9VzQtaVMhgkNTUOVwsmEd3pFPTYKOAobXMdgvjG3CT
 5VtBbcOZariqTUHWpoZ08ITNUtovKWY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-bsKchikzO8-3YHuEF1qI6A-1; Mon,
 01 Dec 2025 06:24:37 -0500
X-MC-Unique: bsKchikzO8-3YHuEF1qI6A-1
X-Mimecast-MFC-AGG-ID: bsKchikzO8-3YHuEF1qI6A_1764588276
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 364201955E7F; Mon,  1 Dec 2025 11:24:36 +0000 (UTC)
Received: from localhost (unknown [10.45.242.40])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F281E195608E; Mon,  1 Dec 2025 11:24:33 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Alexandre Ratchov <alex@caoua.org>, dirty.ice.hu@gmail.com,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [RFC 12/24] module: remove audio module support
Date: Mon,  1 Dec 2025 15:22:53 +0400
Message-ID: <20251201112309.4163921-13-marcandre.lureau@redhat.com>
In-Reply-To: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
References: <20251201112309.4163921-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

It relies on dynamic object loading support instead.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qemu/module.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/qemu/module.h b/include/qemu/module.h
index c37ce74b16..9885ac9afb 100644
--- a/include/qemu/module.h
+++ b/include/qemu/module.h
@@ -63,7 +63,6 @@ typedef enum {
 #define migration_init(function) module_init(function, MODULE_INIT_MIGRATION)
 #define block_module_load(lib, errp) module_load("block-", lib, errp)
 #define ui_module_load(lib, errp) module_load("ui-", lib, errp)
-#define audio_module_load(lib, errp) module_load("audio-", lib, errp)
 
 void register_module_init(void (*fn)(void), module_init_type type);
 void register_dso_module_init(void (*fn)(void), module_init_type type);
@@ -78,7 +77,7 @@ void module_call_init(module_init_type type);
  * - get_relocated_path(CONFIG_QEMU_MODDIR);
  * - /var/run/qemu/${version_dir}
  *
- * prefix:         a subsystem prefix, or the empty string ("audio-", ..., "")
+ * prefix:         a subsystem prefix, or the empty string ("ui-", ..., "")
  * name:           name of the module
  * errp:           error to set in case the module is found, but load failed.
  *
-- 
2.51.1


