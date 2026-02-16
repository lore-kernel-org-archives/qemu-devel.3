Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1F7EE7BD9D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:25:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwfS-0007Bw-Bj; Mon, 16 Feb 2026 06:21:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwbK-0005ag-Mm
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwb7-0007dA-Sb
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oCvtiKHuMNHGGGyZh38jZ7AWFLiBWPGcC09Xtri+dZc=;
 b=RfxemQF2HB9Nm071CjbiZIfS8yl4/s2w78fZkZuDAUM3RYEawaGjHfZJ/LKBfvpAapRCaR
 VHQWoDSph4iLUwZTUwg5a4p0QAiEdxmnBNu8cnGNeBZAgKqcnXdIF94jjzwp1mNveL51Q3
 ZMKpiaV4LRosixwvGZ0eGOr2zoXnEhI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-1xnOWLLlOmOPIbnDMqituA-1; Mon,
 16 Feb 2026 06:16:58 -0500
X-MC-Unique: 1xnOWLLlOmOPIbnDMqituA-1
X-Mimecast-MFC-AGG-ID: 1xnOWLLlOmOPIbnDMqituA_1771240616
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 404DD1956053; Mon, 16 Feb 2026 11:16:56 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1D5241800464; Mon, 16 Feb 2026 11:16:54 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:17 +0100
Subject: [PATCH 28/85] module: remove audio module support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-28-e676662e4514@redhat.com>
References: <20260216-audio-v1-0-e676662e4514@redhat.com>
In-Reply-To: <20260216-audio-v1-0-e676662e4514@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Thomas Huth <huth@tuxfamily.org>, Alexandre Ratchov <alex@caoua.org>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Laurent Vivier <laurent@vivier.eu>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1350;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=xo7WcFF7K5qpRxKZuwsYck3lIjO818VAyiQpuJT+ksg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxPYH2LVSDfFtszpts1e0wJZTFXoNQ0TAXdp
 myy7dZCIGeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8TwAKCRDa6OEJdZac
 5agPEACSNMLPLuFrMBRyR/zdSmNr/TBTd/1Jl8hYbgWfANPkOxiQPXmB37YPucBLD783m1lv20N
 DL/3NHPix53uFQLMjHwryeBx0XgO7WldwB4ahMC8SZGSSZIKux4O85n9z79Wfsen42YYXkBbMhu
 4d8D3+e+JSQFLHEGQTyg14XXinI8439zrXjRljPMNGkh5oTpn76PoiimcFG8jEdq1lH15dBHcCk
 cKBjdQpM8jHNe8WEgGfymOtRLDRYCe/7G6g60ZYi77dypboiwtalzovZoy2xgANPA9CXifx5J4r
 BfGEON09lm4fzfaAL+iW7flLp7j1+cZQv9D3E+9elhPXJ3fh/G+FET99L44hw26utxLjfA9QjjS
 wl8e+hASIXD8KDqGnJMERRN7ne/UqZi9ecdk6vNhb8NFwRx2KdEvc6BZPc1EkNXM4ocADW+P7dT
 jSHaIsYq2KbYjDCAcR02YibaWq/+pvob8Ro/775np9fx9eJs10ep7hNevS6ReZPFNTQ5bJokpUm
 ArkLfyQ4xI8mWePWJrt4A4JaN5mJPXe9sP8tU/c/K2p73omKwJJuYfJ9wtHfgRlYRCJ6b1QYpzY
 pNdYtEaXmoXblGuWapn/LP9cS0U/0pPUJuFZrmUYQDRG9Os6ezuUHai7XoXi0t+HniqhbGYeQCD
 NRqdyBHUBs/8vuw==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

It relies on dynamic object loading support instead.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 include/qemu/module.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/qemu/module.h b/include/qemu/module.h
index c37ce74b16f..9885ac9afb3 100644
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
2.53.0


