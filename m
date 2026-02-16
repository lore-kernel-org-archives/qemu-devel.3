Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E98E7BD8F
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:18:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwcS-0006fb-5u; Mon, 16 Feb 2026 06:18:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwaY-00055r-GO
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:16:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwaS-0007NQ-Dq
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:16:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0sXKT0Ld03CnuopYV5pr+w/M7OpGtHl5MthM69rARkU=;
 b=I/XAuKkyYx5R8VHSZT3UiHlIA+5BQXa28m+Flo7YLfuyvDy2nfgXiBIdwvib7QwTiz6dx6
 XtWtJX/PhX/dlCdnBIQjiaTA7geQ9Z86JYYSjrCqK8CqYHU/6GGA15iKcFHmNhiRWOe5He
 mk1RYTS9Rk22X6ZJm9CF9Z1dwNqxdKw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-Ag8LUNY3MRi3FEsv_GoZjQ-1; Mon,
 16 Feb 2026 06:16:14 -0500
X-MC-Unique: Ag8LUNY3MRi3FEsv_GoZjQ-1
X-Mimecast-MFC-AGG-ID: Ag8LUNY3MRi3FEsv_GoZjQ_1771240572
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85F45195605B; Mon, 16 Feb 2026 11:16:12 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D1D1F19560A2; Mon, 16 Feb 2026 11:16:11 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:01 +0100
Subject: [PATCH 12/85] scripts/modinfo: use in instead of find()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-12-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=797;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=BYuBcm8yqbptW3ccw20FEhHC025s0WWuO9BYWxMZccM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxOW3fW0h8Qt2SJjOnGcrsWj4HJDx1rnrYGo
 CMA4rZskXyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8TgAKCRDa6OEJdZac
 5YDSEACWwGiKgwI19n8KTNKWNjJ4hSu0kE/dNUnCsDfkJn+XQRJ1dWSkV8w8+ymtR+s15fYYl6b
 j/XDxRIPTq+uJxar1XZL2L2pJR2tF1X5FYbm1SxbrzfNGXaVzm3nHRPtzP26KN5R9JB09Eqfk4Z
 5nXXy3Zt/KX9NTXlyNi3oZDPvrpl3/SZSuCq5Yj764GnPnu242dYBXhmErSzu6DmVz/cPT6DP4O
 zAgSC65Y7AM8doHcrkBAQhoglAqEOMJNcIBbjGhfiA5YGvsDaCEQNjrxkhKNJ2LGIgoA4lWzRgV
 3HVH4Mjh345Ytqc+XfOBBd9UZ3UvnGWQ4LBgv1Ahhp+1AKPMMhRBoJthdeMGKCFGxCNqHpL6nAm
 TzNsElkyWUjgOWEm+W6ezr0rcHro1vq+aNSZkoFzzFizcXlfycZJWUuKjGBBJASDnawq5C84WeL
 BDmUs+oZlK0hcyjhlHiaNsoyKY+mLKhjhXAvpfsFhTYKl0taBUX3DBSsVPYroenfjHKiq9gaT0Y
 iofUwdg/BQW3IlxO4PRg/tqgXVEYRaScre6OMO5fYUlRKwIorVdk6/QPZOFwLY6+yRfdPoFayzn
 8vTMi11TVf4TE7zAFUtmw2YiKCgaJtHRo1O8MHwoP4wZJWjnQWnvhXnLG9wYz7NUnyg8Gcjkgvs
 8G+lsOdxbu5Ox+A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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


