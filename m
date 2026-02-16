Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFC7E7BD95
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:20:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwcp-00075u-Qb; Mon, 16 Feb 2026 06:18:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwaa-0005Au-4a
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:16:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwaW-0007O6-Au
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:16:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240581;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8Pvu9sPNY0tMfaU2ZV+9MViXpKMjnpndfyaKXMmfEhY=;
 b=W5f+pcsWTAC9x/OnF3J8qbL1OWGhHug8X2CRPLeKU0JIImtG90qrgS+47Ovbk590QEq/jz
 UlaQGAdIrMEZEkKWrGT9idaOKmKUToQGL+UMELaAsjZsEA5Q/Gs/Bdaq3Xpy34h3EnmbST
 6JbrjUVYAkDlD8KG/JhlbfegaK5CRfw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-630-pnl55yZ8MWulEYuE4IEaVw-1; Mon,
 16 Feb 2026 06:16:17 -0500
X-MC-Unique: pnl55yZ8MWulEYuE4IEaVw-1
X-Mimecast-MFC-AGG-ID: pnl55yZ8MWulEYuE4IEaVw_1771240575
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96E5F1954B07; Mon, 16 Feb 2026 11:16:15 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5616C18003F5; Mon, 16 Feb 2026 11:16:14 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:02 +0100
Subject: [PATCH 13/85] scripts/modinfo: use f-strings
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-13-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2413;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6PlmzXnbqXoosgARgagqlx0sP0Vfwn0BB6rG0yq1OTU=;
 b=kA0DAAoB2ujhCXWWnOUByyZiAGmS/E7IT+AiivzWxJ5/k1ojjI9agX6/OR2qrMSpBZDldvWi3
 4kCMwQAAQoAHRYhBIepvZM/h8YG0nb2Ldro4Ql1lpzlBQJpkvxOAAoJENro4Ql1lpzlbPkP/1Le
 IV2RB2XQ8S8T0Z4eOD28taggz8eeNA7/y0AoE8PoySxW+NL1t/nn6oMwr/HW8XQ2uxApoygq0Qt
 Rwfq5Y2PZW7xG+6ZI8Ew4E7VWJNOpA1Om9S0NYBs0zqfKsmbr55fqf9EWSalRp+70Sja/0XLXTn
 pXzTqD59f/g5DZXxznz7lXzw1zChWlRf/GVsbON0Rp7vLChbgEVif6AV7W/4iKXPLPG/Cq7ByOb
 3VwJr0R4WL9Kolo0uhor7cYIriaAnR62zpKWhfJUjHvg/DAxTJrEWCNViTk4dLIZHLFDeamalBC
 Z5x2zY7mpGYctwoMSMMAnqDhnD1NhjTq5BZjGIcqFfGO9qabBMuq011pEg5s0RLxa61DGsdU5yj
 +3XQeicR/pRb0DgLc7vq/rJqrhrPZ5syyn4Sq9j9s0Yr6LRkIsVBwq3HXrJiWq7cqGVp1EZMuy3
 +TjrY52v+WPMTtt+ORH6unmPf7/XMf3Fk360BRir0a7EeZTTxewCMwd49Oz1X8TVBwOADdHbezj
 c6QNcZRZo4VZwuRpmk9bpzqF/y+n1a2rbD4yI8ip5OylF3rhh/onLkmYe47H1OOqmuu/T/WejCU
 T9vMXDdrJ2BBiDvcfn5VMEO35Po+EeyrF+8ZkhfQjfGpWacfTihO57UMXBFaxlN43nvFxGmVEEp
 /Dr6e
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 scripts/modinfo-generate.py | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/scripts/modinfo-generate.py b/scripts/modinfo-generate.py
index 63093a0f820..8011c842caf 100644
--- a/scripts/modinfo-generate.py
+++ b/scripts/modinfo-generate.py
@@ -9,7 +9,7 @@ def print_array(name: str, values: list[str]) -> None:
     if len(values) == 0:
         return
     list = ", ".join(values)
-    print("    .%s = ((const char*[]){ %s, NULL })," % (name, list))
+    print(f"    .{name} = ((const char*[]){{ {list}, NULL }}),")
 
 def parse_line(line: str) -> tuple[str, str]:
     kind = ""
@@ -53,17 +53,16 @@ def generate(name: str, lines: list[str], enabled: set[str]) -> Optional[set[str
                 # don't add a module which dependency is not enabled
                 # in kconfig
                 if data.strip() not in enabled:
-                    print("    /* module {} isn't enabled in Kconfig. */"
-                          .format(data.strip()))
+                    print(f"    /* module {data.strip()} isn't enabled in Kconfig. */")
                     print("/* },{ */")
                     return None
             else:
                 print("unknown:", kind)
                 exit(1)
 
-    print("    .name = \"%s\"," % name)
+    print(f'    .name = "{name}",')
     if arch != "":
-        print("    .arch = %s," % arch)
+        print(f"    .arch = {arch},")
     print_array("objs", objs)
     print_array("deps", deps)
     print_array("opts", opts)
@@ -100,7 +99,7 @@ def main(args: list[str]) -> None:
     for modinfo in args[2:]:
         with open(modinfo) as f:
             lines = f.readlines()
-        print("    /* %s */" % modinfo)
+        print(f"    /* {modinfo} */")
         (basename, _) = os.path.splitext(modinfo)
         moddeps = generate(basename, lines, enabled)
         if moddeps is not None:
@@ -110,8 +109,7 @@ def main(args: list[str]) -> None:
 
     error = False
     for dep in deps.difference(modules):
-        print("Dependency {} cannot be satisfied".format(dep),
-              file=sys.stderr)
+        print(f"Dependency {dep} cannot be satisfied", file=sys.stderr)
         error = True
 
     if error:

-- 
2.53.0


