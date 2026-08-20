Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DC6AC5DF85
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:55:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx60H-0002Od-Fy; Thu, 20 Aug 2026 12:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx60F-0002As-5b
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:52:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx60D-0005oo-Dg
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XtsaqgiyMjWc11nXZ/58/F9qHxa9T6D5V0veqe5qfXY=;
 b=DQYyLKsF+eoln3IUUdNBgO6UWowm0e5TN5rbJl4D2xmF4sqhMEGIDTpveVgU7F5Lbsm/cu
 oAbXiGCNqx/HlSpNZkby3MDYusoX8uljnAaZfK+cUzDWtED18x7Tt6fZ50cvXka/UYRzo6
 SQwlgXUZI8lvs0dc/LJlRGFBhzVNN2U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-DAzygxfWMFiNkUNhXx8dLQ-1; Thu, 20 Aug 2026 12:52:21 -0400
X-MC-Unique: DAzygxfWMFiNkUNhXx8dLQ-1
X-Mimecast-MFC-AGG-ID: DAzygxfWMFiNkUNhXx8dLQ_1787244740
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47f83416551so83669f8f.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244740; x=1787849540; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=XtsaqgiyMjWc11nXZ/58/F9qHxa9T6D5V0veqe5qfXY=;
 b=r/+qk0pBhL+Zjqc3vypnWIP9uC/kCSprsz40dFfTVT92faan+DkIDMMvW7jB0m7kCw
 FuFyH0fTy/5E6MgOT2B+2A+XjNp/RgGKorUffKU3hsgkEgK/eo0AfpQETgteyPsY86tq
 IIMREW2uOu97KT/16XbwwMfg29xcz4WJkck84zy0a4WSaLGUVfG5xeW9F1AulopYMdCx
 fYN54esA6RcuoxGHLXb6FkX+EIb6LZ9K4sygonXLRv7CPBDkjSd/11IoSREsLc0h6ocF
 NYLvKeTwXSIY63JQbnykXLJo+9mC8dNlIzmpBWRC97uhavSt9YIyc/vMAvERN6vUkaey
 +/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244740; x=1787849540;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XtsaqgiyMjWc11nXZ/58/F9qHxa9T6D5V0veqe5qfXY=;
 b=netTT9jc+9LMeGazY8+ZN/vA7WeSdQReSwimuSDT4++R1bbuZGCcLbw84huHs1wbCt
 OCrYTYqeukaVJViZOL/2BFYnBg7QQNmFkGC5ENd0AgVKCe/1XZ0zXwa7oTY6vdwSNlSC
 TH1KpF95haNcP7Ud0RJrl6/HfqLZ2E7AEVdebQPvBgCKhnfdWHYa00Cerdw/sP159zW4
 lBvUqygw2dS6ZAIk5bFwEXLzlHkLwRCn7p7LztyPc64KrG+hjwQcsL+RJezLTxU0Tm9i
 tatSZMuUxLTKETbbnV9RoegL+pfmajp+7KUhB+sLplanF73GvfeXv5w9kre/8yjjtof7
 KNww==
X-Gm-Message-State: AOJu0Yx1BvL0eb0/rbn5UlQj1s5k1g+MyHsLHCQTmfxXLuZDw56SKoa2
 GnL0+nVhC37Fo7LoxFeyqRFDpMCz1dl2YBI2hQ0gXuVQFFzKkdhfy1qoBKKICg3OmyUK3whmA8n
 qQXpdgoa8bansFnxY2xe8FmwMNftGWbmA+Zkv1cf2Hb0WUi3PvFPqa3YTIzr+FYIiTmbPBxIuLQ
 DKlTV56hJQqZAUG4DMV0sCbSqRMQgLUMXDm6JFrp76
X-Gm-Gg: AR+sD11vaIlyQEfRZJPAfFCpjc8kQLcI1dCDHUMjYKJm5mNCLwwxZRrByZVwpyCU1oo
 Fta6tbiZXur0XQhFq6m7Qeah3CChG/oiPELzs/r9sHVhXoD8K1CG+mKhFCgdctDWAOpTaVoAfvM
 8EdAF2tIdpgADRQS69rpUYDXM9+hAa3xN2EPFPXRjXBnH3Ii/WbCdnkhl4uwxoH5hC/M8LskLKu
 hJex4cDX1Yw/7nupQdsGdV6lD8K3IZdO6dspNvBH5wVHyRGzUR7QOnnW15AijX6RSb8g4KEzxGZ
 TIeYpLYL8Bmk00vwvuxfpCq/yqwpG2Zo/p1c5yZqMOgpuUJWuJjmXMisQT7Rs8ZsbfbK8ul/bsB
 p/dmqh+WA9UIqOKJIA3jL4oMRVveoO+lmdPZnmYzktRbHHZQ0+dCbeLX+rE8nYzyYV1DiPFz5W0
 U6SGY=
X-Received: by 2002:a05:600c:34c6:b0:495:779a:ed33 with SMTP id
 5b1f17b1804b1-499b8325a6dmr4613775e9.7.1787244740368; 
 Thu, 20 Aug 2026 09:52:20 -0700 (PDT)
X-Received: by 2002:a05:600c:34c6:b0:495:779a:ed33 with SMTP id
 5b1f17b1804b1-499b8325a6dmr4612655e9.7.1787244739865; 
 Thu, 20 Aug 2026 09:52:19 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9e78496sm167766805e9.2.2026.08.20.09.52.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:52:19 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 50/53] scripts: remove now dead parts of rustc_args.py
Date: Thu, 20 Aug 2026 18:49:53 +0200
Message-ID: <20260820164957.1895963-51-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

The logic to parse the [lints] section has been integrated
into Meson and can be removed.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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


