Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2098EE7BD95
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:19:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrwdW-0000GO-QR; Mon, 16 Feb 2026 06:19:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwaj-0005Hs-Tx
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:17:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vrwad-0007RW-Gb
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 06:16:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771240590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KCugop36CLelcrOMKIrKRT8HBbv47hNoq//wkZ62yVs=;
 b=Ca+erjM2yp/PiFS1jEuPyWh/BVf/FN4SSJ8HNfho1ZukNCvE+RMK7s4Mfa1gkZsNKlB8J5
 jFLWuUlZW1o9hXxUG3t0pGowrA4fmUrlp+Do5YEhzG2G4oQQ01HnjzzM0j1dwXEYlErWT0
 6Gr2ArKuuB5CzZZYfk6sYevHSlM16Ik=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-112-mWSuph5cO9-5d6ohy55CpQ-1; Mon,
 16 Feb 2026 06:16:25 -0500
X-MC-Unique: mWSuph5cO9-5d6ohy55CpQ-1
X-Mimecast-MFC-AGG-ID: mWSuph5cO9-5d6ohy55CpQ_1771240583
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AE85B1800365; Mon, 16 Feb 2026 11:16:23 +0000 (UTC)
Received: from localhost (unknown [10.45.242.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1262A30001B9; Mon, 16 Feb 2026 11:16:22 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 16 Feb 2026 12:15:05 +0100
Subject: [PATCH 16/85] scripts/modinfo: add --skip-missing-deps
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260216-audio-v1-16-e676662e4514@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5639;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=ygcT/EP4LKFFbInc5HK8ho4Iw+AmP0MuGXSJiZYYmoc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpkvxOHXNZrYPKLzyeQ8z6X6VU5BDpOUyVsw41/
 lYzr9uHeLKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaZL8TgAKCRDa6OEJdZac
 5fOoEACgLqwVa2Yp4SD81nT3uP6DNRwMv/bm+MDEtr03Tx3ZpY+cbGI9AqrnKs+PZXvncHYc/2X
 xNBAGp0uSQjaqqtYp5aG2QySNKk4rzm2woekbwTAyxZqqGd4uyVoA9hy7nhdbhqd0KlDojH5nEZ
 3XlgBUTReQXcu2FS9gfwWuyl3KAMl2yBNvbMPjy5wpKDTe1qXdeKMEz1awemtRfR6ZL9xQlllSm
 HvpJVmhoxBrAmyCt/6ai4HAKMsev/TLAdahGsDnUgWssGt+ClYyUU2emrZjJIBPwVIKYOgG/yiH
 bvhaTZSK9eNORZ4SdBrxQEG4b0kna1P3qBUXb7B81fJl+5CsfgloftTDPC7+eLYPyIlWdHchKpt
 z1UyQMNMbzXorpK/UJWzVs5hFX+lKBrnWAX0Myi2L95391uDWc8/FMTE7/QNgYvInnZU3KkJjy+
 k6vRD+Uii4YLWW1dgD0nwxilI+B6+1/H2sC3GsDHHZWUYyb2vlQZg2ToxoprAn/+2zeeq9GcTnV
 lNi+UPlD4IXv+bKk/Qb7D5PpKiSOvphPjkez9Yd4VQl7BNJ8dTJOeIv/cxJHBaZKjXmw40rEvOn
 OH9eWKy2JU7tMetm4ZjB4L5S/FflfJblgGv0s9b5o/ttsF8nw39j6x4AuFoDFz31CUZviLJAzw+
 JHQyglWo+elR1bg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
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

Add --skip-missing-deps flag that prints warnings for missing
dependencies but continues without exiting with error code 1.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Acked-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
---
 scripts/modinfo-generate.py | 94 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 71 insertions(+), 23 deletions(-)

diff --git a/scripts/modinfo-generate.py b/scripts/modinfo-generate.py
index e7d35242414..e231c129196 100644
--- a/scripts/modinfo-generate.py
+++ b/scripts/modinfo-generate.py
@@ -34,7 +34,8 @@ def parse_line(line: str) -> tuple[str, str]:
             continue
     return (kind, data)
 
-def generate(name: str, lines: list[str], enabled: set[str]) -> Optional[set[str]]:
+def parse_modinfo(name: str, lines: list[str], enabled: set[str]) -> Optional[dict]:
+    """Parse a modinfo file and return module metadata, or None if disabled."""
     arch = ""
     objs = []
     deps = []
@@ -54,21 +55,39 @@ def generate(name: str, lines: list[str], enabled: set[str]) -> Optional[set[str
                 # don't add a module which dependency is not enabled
                 # in kconfig
                 if data.strip() not in enabled:
-                    print(f"    /* module {data.strip()} isn't enabled in Kconfig. */")
-                    print("/* },{ */")
                     return None
             else:
                 print("unknown:", kind)
                 exit(1)
 
-    print(f'    .name = "{name}",')
-    if arch != "":
-        print(f"    .arch = {arch},")
-    print_array("objs", objs)
-    print_array("deps", deps)
-    print_array("opts", opts)
+    return {
+        'name': name,
+        'arch': arch,
+        'objs': objs,
+        'deps': deps,
+        'opts': opts,
+        'dep_names': {dep.strip('" ') for dep in deps}
+    }
+
+def generate(modinfo: str, mod: Optional[dict],
+             skip_reason: Optional[str]) -> None:
+    """Generate C code for a module."""
+    print(f"    /* {modinfo} */")
+    if mod is None:
+        if skip_reason == "missing_deps":
+            print("    /* module has missing dependencies. */")
+        else:
+            print("    /* module isn't enabled in Kconfig. */")
+        print("/* },{ */")
+        return
+
+    print(f'    .name = "{mod["name"]}",')
+    if mod['arch'] != "":
+        print(f"    .arch = {mod['arch']},")
+    print_array("objs", mod['objs'])
+    print_array("deps", mod['deps'])
+    print_array("opts", mod['opts'])
     print("},{")
-    return {dep.strip('" ') for dep in deps}
 
 def print_pre() -> None:
     print("/* generated by scripts/modinfo-generate.py */")
@@ -86,6 +105,8 @@ def main() -> None:
     )
     parser.add_argument('--devices',
                         help='path to config-device.mak')
+    parser.add_argument('--skip-missing-deps', action='store_true',
+                        help='warn if a dependency is missing and continue')
     parser.add_argument('modinfo', nargs='+',
                         help='modinfo files to process')
     args = parser.parse_args()
@@ -99,27 +120,54 @@ def main() -> None:
                 if config[1].rstrip() == 'y':
                     enabled.add(config[0][7:])  # remove CONFIG_
 
-    deps = set()
-    modules = set()
-    print_pre()
+    # all_modules: modinfo path -> (basename, parsed module or None, skip_reason)
+    all_modules = {}
     for modinfo in args.modinfo:
         with open(modinfo) as f:
             lines = f.readlines()
-        print(f"    /* {modinfo} */")
         (basename, _) = os.path.splitext(modinfo)
-        moddeps = generate(basename, lines, enabled)
-        if moddeps is not None:
-            modules.add(basename)
-            deps.update(moddeps)
-    print_post()
+        mod = parse_modinfo(basename, lines, enabled)
+        skip_reason = "kconfig" if mod is None else None
+        all_modules[modinfo] = (basename, mod, skip_reason)
+
+    # Collect all available module names
+    available = {basename for basename, mod, _ in all_modules.values()
+                 if mod is not None}
 
-    error = False
-    for dep in deps.difference(modules):
+    # Collect all dependencies
+    all_deps = set()
+    for basename, mod, _ in all_modules.values():
+        if mod is not None:
+            all_deps.update(mod['dep_names'])
+
+    # Check for missing dependencies
+    missing = all_deps.difference(available)
+    for dep in missing:
         print(f"Dependency {dep} cannot be satisfied", file=sys.stderr)
-        error = True
 
-    if error:
+    if missing and not args.skip_missing_deps:
         exit(1)
 
+    # When skipping missing deps, iteratively remove modules with
+    # unsatisfiable dependencies
+    if args.skip_missing_deps and missing:
+        changed = True
+        while changed:
+            changed = False
+            for modinfo, (basename, mod, skip_reason) in list(all_modules.items()):
+                if mod is None:
+                    continue
+                if not mod['dep_names'].issubset(available):
+                    available.discard(basename)
+                    all_modules[modinfo] = (basename, None, "missing_deps")
+                    changed = True
+
+    # generate output
+    print_pre()
+    for modinfo in args.modinfo:
+        (basename, mod, skip_reason) = all_modules[modinfo]
+        generate(modinfo, mod, skip_reason)
+    print_post()
+
 if __name__ == "__main__":
     main()

-- 
2.53.0


