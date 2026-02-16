Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3159E7BD8B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 10:45:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrw50-0002jF-Oa; Mon, 16 Feb 2026 05:43:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrw4b-00021c-Q0
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:43:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrw4a-000147-DJ
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 05:43:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771238601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0sXKT0Ld03CnuopYV5pr+w/M7OpGtHl5MthM69rARkU=;
 b=azvmIdg98hQx9AFDpxnd/6V+yQrF31ls3aJYI0TdHKRCKehscxoJE6qvFiJIK8G8rdfoJd
 xjO51C35UNvhfRm8ERDsq3nMO2IH9zr4CTEw9Ixk0fkDXewTTunRZWPbNEj7sdgUkeg1C8
 EZjF/0i8qRFjzmiC/lwYK8fKgiZ4VRQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-qER9Aa4pPmSzQzXWbW_Iaw-1; Mon,
 16 Feb 2026 05:43:17 -0500
X-MC-Unique: qER9Aa4pPmSzQzXWbW_Iaw-1
X-Mimecast-MFC-AGG-ID: qER9Aa4pPmSzQzXWbW_Iaw_1771238596
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B17A195FDF6; Mon, 16 Feb 2026 10:43:14 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4023E1800465; Mon, 16 Feb 2026 10:43:11 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 11:42:24 +0100
Subject: [PATCH 12/85] scripts/modinfo: use in instead of find()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-12-edcb25699381@redhat.com>
References: <20260216-audio-v1-0-edcb25699381@redhat.com>
In-Reply-To: <20260216-audio-v1-0-edcb25699381@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=797;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=BYuBcm8yqbptW3ccw20FEhHC025s0WWuO9BYWxMZccM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvST3Q1U4UhC5ljqDoV4BUHuxftiH4BiWxvmM
 RMXRvlyRMOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL0kwAKCRDa6OEJdZac
 5V//D/9U3ZRL6zYB3Vm9Wsj9Zx4QyX0qIuMwj/YBypcdiqC1t4+ED/6zlWEBxRMv2/c31RjgR2f
 BoxbQ9BrW8CzQDoZZ8a/ua7I4R2dHFGHqmEQBKZLlcvrWwaQcbnvPV+/g2ioMRLZmzU40mSRnbv
 0Jq0ANA4uwJQIlt2z+3I9uQdZKBlA4CE6mwSN5t+XZ3xifsV3OVdUcSOQWPuGSmBnm4EI+1QUha
 gf/lkIF9Ljs6J1q2PpLQVGfIswop2RjvebKPgaDcNZ+VX06qNFNtxVpFibguAIB3F+TlpzsUf6S
 /iBEwqe8h1Vax0fAsbUezDRHvTJcKrfY37oEtkmiQ6Xusz12muvZFSfdtGCkrRQ/anz2mf4YKZC
 kHYDPKzwJA+BOlphPsvDyZcoVfGVnXXeVf/WvWFGi0sXTBhzw19t7yv5zUYBQxBP2sXzl9fJRtd
 uwROqHgsODkNsB3jal41cx16wcKZnzX6ax4yogEOId2ZmcLAR8eid6uxJ789epi4HyGDcR56mRr
 ScguXIGN00Jk7GYyOxCESGxrohlCzskg3xjXMKGkfsIDeTn7mGdiU3tKddCSL8WxQeyYIw9aZJj
 Wrxa3fRYdxoZXpAHL/q7DgL585f64zO6EF8D1QItlcqp4NF42EX2qFIKXbd/JKS+Tqe2e/Znmu4
 tbUYqcM0ZV/gi3w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Minor style improvement

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 scripts/modinfo-generate.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/modinfo-generate.py b/scripts/modinfo-generate.py
index 83ffa4a7c52..63093a0f820 100644
--- a/scripts/modinfo-generate.py
+++ b/scripts/modinfo-generate.py
@@ -39,7 +39,7 @@ def generate(name: str, lines: list[str], enabled: set[str]) -> Optional[set[str
     deps = []
     opts = []
     for line in lines:
-        if line.find("MODINFO_START") != -1:
+        if "MODINFO_START" in line:
             (kind, data) = parse_line(line)
             if kind == 'obj':
                 objs.append(data)

-- 
2.53.0


