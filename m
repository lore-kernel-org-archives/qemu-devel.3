Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA732CD5BD0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 09:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRo36-0007MH-JA; Tue, 26 May 2026 05:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRo34-0007Li-BG
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:26:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRo32-00075S-3W
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:26:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779787563;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gULj+k4BCCh2uG0UeEN9zuYScGXHWT7MpOumSH23u6Y=;
 b=M6gzWZbKADOtz3ts2lSMBMu6XtUZO3iYk8WNP1fDbJ7URwlyoWblicRTBoSYvutc9Jk/s/
 d7Ut1+xFITej3gFoAOOBvKA+co9MLRoEYbwyPsiwW+6OmJk6ESHDEb7zWnmBsyRHiyzCA4
 9BpfhihvgzZxpXY98HXdw+UQ/VdOceg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-258-92Ev3DWEMXW0WI54AjkRdw-1; Tue, 26 May 2026 05:26:01 -0400
X-MC-Unique: 92Ev3DWEMXW0WI54AjkRdw-1
X-Mimecast-MFC-AGG-ID: 92Ev3DWEMXW0WI54AjkRdw_1779787560
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45ea38c03a1so4313239f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 02:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779787560; x=1780392360; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gULj+k4BCCh2uG0UeEN9zuYScGXHWT7MpOumSH23u6Y=;
 b=iX4XUtVlJUQiNJLgFzSOoAjRTA2eOwpzKaIHYcbxIw4Jr4SaXFPlp9nxWY0x+uxGPN
 AlFf8Dm1WM2ovEb/5BMnMwV6zVzGhH53taUkd5dX1exOSbybtPz9wTjmFA/jIFaAOXBg
 0kUAjOoEPzk45yOI39n84L3ua5V9S25zjRXmtDqcVdipuO7+EDGLg/EV9UtLixM6CCmB
 9zC9N09oNPq2FK5/6u4fZekg+9SKoUKAA2Lmd5X5EHapKSnKcZORLnxvRg+xcxQ/numK
 OcDEJsWZNiLEn/keyYylUXYWndTrGYOYVw1SAg+uIykre4ktW2abTklJF5ccQ9LkD165
 bv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779787560; x=1780392360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=gULj+k4BCCh2uG0UeEN9zuYScGXHWT7MpOumSH23u6Y=;
 b=HuMZBKQcQTZDgeXShGlNCKVLWGMDdsS9agMKwwYkery32ZzklpGmrWMS07vmlFSD2V
 L0mpoRbkBS/Ge9kMNbxnqEl+Y8mdoW9EDcjIJ/I1wr/QGuj4HNzhvf8L5joabJ2TzVlp
 zWkVVcC9NjghiSU2hXxQ14zOGm8vR0ASP0/ue+wvUMVh7EE27ymc9pILEknLRYVB7qr7
 cpWgms734vGIFGdEpNNCEyzaiyD9SOK/+DlcpiSNo8D5Y2MX8oaLTwydD1zjaCGMMB6n
 EM3RQ1QouuCAM5464OM3Ra3yE3hqR7aB10bErWUXRsOkSXhcZwwX+h5A/frVubnrA3s6
 /C4Q==
X-Gm-Message-State: AOJu0YzNe0igtP8+eO0hFliSUXD0BAHBGDKwv9xkNlpZ/t1A6YedEWpn
 E0arKpKJQqk0CIusifhYMJ7ill6ds64NLJsX6xwnbiDNALpVUAf4DU4OgxnfryIQ51xef4ZOD41
 K/uBXFmGv3vBiYoowsJUflK7HgclXzPWmf5iMgvgEb4i9NbzBapWrmL9KZ4CtsUu3tvpqmb3Wml
 KR7S5KT0HoDYke8jJDjjbLI/Nqh59gkCWb3JDgzBeQ
X-Gm-Gg: Acq92OFBx+p6kE1Qbg1wSrb/SJ7ab7zHMTeROoclQWs2UbshhtPSxY7F2C4cJbkHhGY
 2blXYhiBFRC+fqI0YLexqv7R2Xii+cGLzLD7PafiTdKXIDojQvl+mzLX3FbRe249E3vY0Y97t+b
 tKTqSroZ6fPDzDtJE7GLyfSrABkV8ymeexSuo0yIywnMpf7w5AOh0S5gmcSS0mXSzg8xKBxmW5L
 lKifSV144uxMKguKOmY7D7+l4kkGWDIvkFbJYblHuOCH5Ite+QWKcjpKMHqUPTcP+4kCVA9FfGk
 rGt2VZD26BhdI5jDQ+SJyug7juLk7AAwRJxu7nFczGY4ulT4LlxIRM2uN9pjFCF+RMANDADw7hm
 333415ppMFVhN1uLsYBmYVC+zdoqMKcSJGfBoPWh+Ood12odtDIO9fOoArS4vvBcMGKAeeymgVT
 z5/xHm0r6h9nv15ZmyH9ynPF8EGAvB4iqJBYDzrg==
X-Received: by 2002:a05:6000:1a85:b0:43d:762e:76ba with SMTP id
 ffacd0b85a97d-45eb367fb35mr29644110f8f.17.1779787560250; 
 Tue, 26 May 2026 02:26:00 -0700 (PDT)
X-Received: by 2002:a05:6000:1a85:b0:43d:762e:76ba with SMTP id
 ffacd0b85a97d-45eb367fb35mr29644053f8f.17.1779787559707; 
 Tue, 26 May 2026 02:25:59 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6c9f598sm34664694f8f.6.2026.05.26.02.25.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 02:25:57 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/6] scripts: remove now dead parts of rustc_args.py
Date: Tue, 26 May 2026 11:25:45 +0200
Message-ID: <20260526092546.149241-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526092546.149241-1-pbonzini@redhat.com>
References: <20260526092546.149241-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The logic to parse the [lints] section has been integrated
into Meson and can be removed.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                |  1 -
 scripts/rust/rustc_args.py | 80 +-------------------------------------
 2 files changed, 1 insertion(+), 80 deletions(-)

diff --git a/meson.build b/meson.build
index 17c8751f92d..999350a8b50 100644
--- a/meson.build
+++ b/meson.build
@@ -129,7 +129,6 @@ endif
 
 if have_rust
   rustc_args = [find_program('scripts/rust/rustc_args.py'),
-    '--rustc-version', rustc.version(),
     '--workspace', meson.project_source_root()]
 
   rustfmt = find_program('rustfmt', required: false)
diff --git a/scripts/rust/rustc_args.py b/scripts/rust/rustc_args.py
index 6a156b9608e..7229676bcc8 100644
--- a/scripts/rust/rustc_args.py
+++ b/scripts/rust/rustc_args.py
@@ -25,10 +25,9 @@
 """
 
 import argparse
-from dataclasses import dataclass
 import logging
 from pathlib import Path
-from typing import Any, Iterable, List, Mapping, Optional, Set
+from typing import Any, Iterable, Mapping, Optional, Set
 
 try:
     import tomllib
@@ -74,40 +73,6 @@ def get_table(self, key: str, can_be_workspace: bool = False) -> Mapping[Any, An
         return table
 
 
-@dataclass
-class LintFlag:
-    flags: List[str]
-    priority: int
-
-
-def generate_lint_flags(cargo_toml: CargoTOML) -> Iterable[str]:
-    """Converts Cargo.toml lints to rustc -A/-D/-F/-W flags."""
-
-    toml_lints = cargo_toml.lints
-
-    lint_list = []
-    for k, v in toml_lints.items():
-        prefix = "" if k == "rust" else k + "::"
-        for lint, data in v.items():
-            level = data if isinstance(data, str) else data["level"]
-            priority = 0 if isinstance(data, str) else data.get("priority", 0)
-            if level == "deny":
-                flag = "-D"
-            elif level == "allow":
-                flag = "-A"
-            elif level == "warn":
-                flag = "-W"
-            elif level == "forbid":
-                flag = "-F"
-            else:
-                raise Exception(f"invalid level {level} for {prefix}{lint}")
-            lint_list.append(LintFlag(flags=[flag, prefix + lint], priority=priority))
-
-    lint_list.sort(key=lambda x: x.priority)
-    for lint in lint_list:
-        yield from lint.flags
-
-
 def generate_cfg_flags(header: str, cargo_toml: Optional[CargoTOML]) -> Iterable[str]:
     """Converts defines from config[..].h headers to rustc --cfg flags."""
 
@@ -155,31 +120,6 @@ def main() -> None:
         required=False,
         default=None,
     )
-    parser.add_argument(
-        "--features",
-        action="store_true",
-        dest="features",
-        help="generate --check-cfg arguments for features",
-        required=False,
-        default=None,
-    )
-    parser.add_argument(
-        "--lints",
-        action="store_true",
-        dest="lints",
-        help="generate arguments from [lints] table",
-        required=False,
-        default=None,
-    )
-    parser.add_argument(
-        "--rustc-version",
-        metavar="VERSION",
-        dest="rustc_version",
-        action="store",
-        help="version of rustc",
-        required=False,
-        default="1.0.0",
-    )
     parser.add_argument(
         "--no-strict-cfg",
         help="only generate expected cfg",
@@ -192,30 +132,12 @@ def main() -> None:
         logging.basicConfig(level=logging.DEBUG)
     logging.debug("args: %s", args)
 
-    rustc_version = tuple((int(x) for x in args.rustc_version.split('.')[0:2]))
     if args.workspace:
         workspace_cargo_toml = Path(args.workspace, "Cargo.toml").resolve()
         cargo_toml = CargoTOML(args.cargo_toml, str(workspace_cargo_toml))
     else:
         cargo_toml = CargoTOML(args.cargo_toml, None)
 
-    if args.lints:
-        for tok in generate_lint_flags(cargo_toml):
-            print(tok)
-
-    if rustc_version >= (1, 80):
-        if args.lints:
-            print("--check-cfg")
-            print("cfg(test)")
-            for cfg in sorted(cargo_toml.check_cfg):
-                print("--check-cfg")
-                print(cfg)
-        if args.features:
-            for feature in cargo_toml.get_table("features"):
-                if feature != "default":
-                    print("--check-cfg")
-                    print(f'cfg(feature,values("{feature}"))')
-
     for header in args.config_headers:
         for tok in generate_cfg_flags(header, cargo_toml if args.strict_cfg else None):
             print(tok)
-- 
2.54.0


