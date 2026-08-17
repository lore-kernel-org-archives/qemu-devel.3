Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B107AC5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:47:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvxgT-0004BZ-S9; Mon, 17 Aug 2026 09:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wvxfE-0003Tn-Er
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 09:46:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wvxfC-00022W-Mt
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 09:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786974366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S0/SPF9YVM1+aKxMo/MiINOygMrDYOZPpqRvT/7vA34=;
 b=dk63CA6WL3okGNRwgmATiS9Nonap6HxZfwFfRFv0ziaPWw96LSui7tpWNb8Pm6INoqyc5K
 LJ1IBLeBJllwq08kKxCBUkFtJ/2+fA3RWCwmaYBqCXCK2PkvpHhnpX15Eb1wgjR1zyP0sF
 PpLU0bMkh0QOz/aKU0AzUFmuyiR0XyA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-zhAaBRY2Opa6ZbE-bUWalA-1; Mon, 17 Aug 2026 09:46:04 -0400
X-MC-Unique: zhAaBRY2Opa6ZbE-bUWalA-1
X-Mimecast-MFC-AGG-ID: zhAaBRY2Opa6ZbE-bUWalA_1786974364
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47f81362fb1so2138145f8f.1
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 06:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786974363; x=1787579163; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S0/SPF9YVM1+aKxMo/MiINOygMrDYOZPpqRvT/7vA34=;
 b=ZyXkK617ux/GEEJY13DsYRjGCg8ZVsOsQz1VMU36t7oUETYDXY38fs4aTzqkgQBxiO
 skMR+b2tEnIyTj0O8evF2TB6ZrYaRIkMvuI3S5WZvV7wOj3MK7bpr1eTzAHDfI31vimm
 c4FffXAt6WKqtxmG5Yqbmop2kLdIsLvhzN6X3Jelfqbfj8sNKVW8S1FTLoYD2QLm90pQ
 h2I7tISJMOLJSDwEXnIu1J60lf4O62H3NMxHDAr+Bhu6fjGJxRtUGE2fI3pLje/SSfJo
 Eqsz0Wk5Wcel6J/OjNXNlOUWg72lSgJP8y1GGTZV6RD2Q6lfxPvlHeEQJlYU2wrxZiXw
 Howg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786974363; x=1787579163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=S0/SPF9YVM1+aKxMo/MiINOygMrDYOZPpqRvT/7vA34=;
 b=FZn9V6P6qD0UR1h6FINKOc2CxlpfaizM0vG25YrwIg4SbD1RnU82ZFRdYuzdXwjjlC
 l1vLnXwgVjb+J6MG/e84V1aKG05BBlAcEa9jOWGm195Rr7iuJZerIkbS+nnqCcX3DaiX
 5DTdH1gt/lv+G8LSfW6u/FbHHEUQ58oSs3KEGxxeW8qNATJd4ozysgR0DO4jSH55LDjv
 8rXbY3iq+AQeXmG8UAPk6XmTaFcaLMcj6jAGrjJ4Bt7u+4EJsY4KYhlyVdm1AEV+oDsa
 4lcqGU6JNc7Inyc0x6WlQpJgTWy9OW3Ec5Od/cSdtieKcXZHdHO3tKrrnvbi6MS0STkJ
 nbrw==
X-Gm-Message-State: AOJu0YzSKbqKn3+dhqeebtmw6u6PjEa4ej38PfeSCa/gnnmRZM7jO9S9
 CKXLIYnMJFfe+9ACWaHMJ0pEHyox+EZGFs/xT50iEs7hKjF3zuUNAzI8nRJmlmgWsYyIqAvR2ZV
 v4eR53FY6LrVE6MMkXX252p7OLr01ADmCDIjtM2pxgyZBlIOwi/ZEzR/AlmXAo0b7iTK4OrxKjH
 JBKAZ9pO2wknn/zCBaMghBwOvr32dtpxXhuDnDpXz9
X-Gm-Gg: AR+sD12EmjzI3N04gjTuTSN60yKmCS5w98YthIeThwZaW+8sdMC7BFoNPrkWSBfKYmK
 ZXYtczZ3+H2HIOXYtwGnohSl6eXUUhaiMgQVfBOzruN4jx0+TMho7Y5sFNz90rBOiRmfuf5Bkbr
 VcxTQmvRkV9ZIABIZwD+7n+ZlY2jiJgUhyF6UrS1DQCDCzSoqYpT4XL/6I9lWMIE3pMLhO3Ksba
 tS7cNxdyf2MK4vMPZ3WkhIZqHEMj/cCfp8IM7VWg9GjsXpYdyf/oZDhzeMYNufqklNuUAFyVowk
 /TrRLz5Lz1BuxDLYW++MAxHzAzG7x59eMeZMkrWESLShN4A+R6C5W5Cm3bS+QqnUHzkFWWn0Z8Q
 g7bXG9z7wTMSGtnRFqmz9ZgqKK2RVaJAO8pfnXS0JQ1IruwvRRiVatlDCv1tQxLdiTeOSdsc+6R
 BEnaA=
X-Received: by 2002:a5d:68c7:0:b0:481:4dcd:aefa with SMTP id
 ffacd0b85a97d-482a905d20emr359022f8f.6.1786974363601; 
 Mon, 17 Aug 2026 06:46:03 -0700 (PDT)
X-Received: by 2002:a5d:68c7:0:b0:481:4dcd:aefa with SMTP id
 ffacd0b85a97d-482a905d20emr358961f8f.6.1786974363111; 
 Mon, 17 Aug 2026 06:46:03 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5b81715sm4182051f8f.35.2026.08.17.06.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 06:45:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 8/9] scripts: remove now dead parts of rustc_args.py
Date: Mon, 17 Aug 2026 15:45:36 +0200
Message-ID: <20260817134538.924615-9-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817134538.924615-1-pbonzini@redhat.com>
References: <20260817134538.924615-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

The logic to parse the [lints] section has been integrated
into Meson and can be removed.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                |  1 -
 scripts/rust/rustc_args.py | 80 +-------------------------------------
 2 files changed, 1 insertion(+), 80 deletions(-)

diff --git a/meson.build b/meson.build
index 3c6a82ab440..6dcfdceb507 100644
--- a/meson.build
+++ b/meson.build
@@ -130,7 +130,6 @@ endif
 
 if have_rust
   rustc_args = [find_program('scripts/rust/rustc_args.py'),
-    '--rustc-version', rustc.version(),
     '--workspace', meson.project_source_root()]
 
   rustfmt = find_program('rustfmt', required: false)
diff --git a/scripts/rust/rustc_args.py b/scripts/rust/rustc_args.py
index 8098053720a..107b944c161 100644
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
 def generate_cfg_flags(header: str, cargo_toml: CargoTOML) -> Iterable[str]:
     """Converts defines from config[..].h headers to rustc --cfg flags."""
 
@@ -154,60 +119,17 @@ def main() -> None:
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
     args = parser.parse_args()
     if args.verbose:
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
         for tok in generate_cfg_flags(header, cargo_toml):
             print(tok)
-- 
2.55.0


