Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA63FE77182
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 16:28:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLPYy-0000sB-JW; Wed, 11 Dec 2024 11:27:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPYq-0000B0-6a
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:27:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tLPYo-0000EO-28
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 11:27:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733934457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C3gKLyE/tjMRxcMCdanJmcUrY5p/mjIojvO+9H4ft54=;
 b=P44DolZAZXaTq7JAQKYdnBJMOVUZLFFloGbi7ZfEUVMjm/mwcN1mrqSOl9mIzwV5TQj8It
 eFj/Myi5letSW0YIKg1z/6g2YqZpwVz+Mx7hFVIQ/RxOAl1Pvs1RirFIlW0YT61t/nfLgM
 NNSkw2/z7l0LsZAEKcm5IxcJ006EACw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-jtX8riAZOqGy9IQH4Dgv6w-1; Wed, 11 Dec 2024 11:27:35 -0500
X-MC-Unique: jtX8riAZOqGy9IQH4Dgv6w-1
X-Mimecast-MFC-AGG-ID: jtX8riAZOqGy9IQH4Dgv6w
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385df115288so2971991f8f.2
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 08:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733934454; x=1734539254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C3gKLyE/tjMRxcMCdanJmcUrY5p/mjIojvO+9H4ft54=;
 b=pC6oy+1OOYlohFrfG5xDFUR7aDMIaUG72yZx+jlHuooOrSBqnQDdDbund2W5jSeUIu
 t8wqEpgYqa5sLczXKEvIUz7ahoCU3DgnrCY2eevZuxFjLA+QWAxoYIm3S4cZuKxI9xk0
 NHnT8fHCqZ5xYnkXkJQ49INYieZF8Bptz4YhjLQQu+GgmCk/hqqNQWS0rxN5sCnCVBRy
 VmgX/l15aQDXwiy6rWdaK8ZM4g/3WyFM99puX4LGML/FubUPrlHDNBHlMjgOPdz97A8t
 24CGwK7OGBe0oSZLg+IlGQEmzMNli3dpGReI2Y0WpmNax2O2lCbV1XS2yj/se5qw2cBo
 8V1w==
X-Gm-Message-State: AOJu0YyNvRwW6UafDR/wFsZ9m2GPdjCJXv5jNFKbAewMQ/C/lRSePa4O
 KxSxsCy1PHalb6pm4AU7tHqTPURiXTFz6ZbZM+Enl4/+MU6GH2LqRqdPaw/Kwfkhyut2wq6gGHh
 jBUiRiPH1Gbx+L/GNXbxU20A0QuaLyAjkIPxo17l44XB24lihPjbqRWjoPNgPB5frDbC/BhtGbN
 ZPMpIpXvxcQjkjNVbmprR188BbeVThP3ftQqMj
X-Gm-Gg: ASbGnctx0jjp1O5+3YkLQmcyFKl2lDj7mAAoXQteXX3ItnWlj/jL2LaZPe3eolM4Av3
 NOKgnXy/xRO6GTVf/6IFc1Q+EFak0/+sbbTaOt0QajZUH9PKA3zyPlBf/Lw2ucH4/TAu2D7eeGF
 6n8CslEOwHB5OoIv8ctbwDo0xmvWVPpcivdGdw3FUg6zwAPjDWm3fDkfvvAdZHDjGCor9wzp3wX
 PbYTsy2kKN7XX6V9UU1i3UbwrDK+t6sebtXcgbgP8fAj7i3mgoC6ppG
X-Received: by 2002:a5d:6da4:0:b0:385:e0ea:d4ef with SMTP id
 ffacd0b85a97d-3864cea1edcmr2490334f8f.58.1733934454217; 
 Wed, 11 Dec 2024 08:27:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFGXbScukZBJmV0tcqFwx+LRTdB21ClwwYtGiCA0uqYHHQLS1ae7QzI3Fac+y6iFlaeThMs2A==
X-Received: by 2002:a5d:6da4:0:b0:385:e0ea:d4ef with SMTP id
 ffacd0b85a97d-3864cea1edcmr2490309f8f.58.1733934453815; 
 Wed, 11 Dec 2024 08:27:33 -0800 (PST)
Received: from [192.168.10.3] ([151.81.118.45])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-387824a3e38sm1614427f8f.23.2024.12.11.08.27.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 08:27:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/49] rust: build: restrict --cfg generation to only required
 symbols
Date: Wed, 11 Dec 2024 17:26:35 +0100
Message-ID: <20241211162720.320070-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241211162720.320070-1-pbonzini@redhat.com>
References: <20241211162720.320070-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Parse the Cargo.toml file, looking for the unexpected_cfgs
configuration.  When generating --cfg options from the
config-host.h file, only use those that are included in the
configuration.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/meson.build  |  2 +-
 scripts/rust/rustc_args.py | 61 ++++++++++++++++++++++++++++----------
 2 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/rust/qemu-api/meson.build b/rust/qemu-api/meson.build
index 5df6b35bf88..2ff6d2ce3d0 100644
--- a/rust/qemu-api/meson.build
+++ b/rust/qemu-api/meson.build
@@ -1,5 +1,5 @@
 _qemu_api_cfg = run_command(rustc_args,
-  '--config-headers', config_host_h,
+  '--config-headers', config_host_h, files('Cargo.toml'),
   capture: true, check: true).stdout().strip().split()
 
 # _qemu_api_cfg += ['--cfg', 'feature="allocator"']
diff --git a/scripts/rust/rustc_args.py b/scripts/rust/rustc_args.py
index e4cc9720e16..942dd2b2bab 100644
--- a/scripts/rust/rustc_args.py
+++ b/scripts/rust/rustc_args.py
@@ -26,30 +26,51 @@
 
 import argparse
 import logging
+from pathlib import Path
+from typing import Any, Iterable, Mapping, Optional, Set
 
-from typing import List
+try:
+    import tomllib
+except ImportError:
+    import tomli as tomllib
 
 
-def generate_cfg_flags(header: str) -> List[str]:
+class CargoTOML:
+    tomldata: Mapping[Any, Any]
+    check_cfg: Set[str]
+
+    def __init__(self, path: str):
+        with open(path, 'rb') as f:
+            self.tomldata = tomllib.load(f)
+
+        self.check_cfg = set(self.find_check_cfg())
+
+    def find_check_cfg(self) -> Iterable[str]:
+        toml_lints = self.lints
+        rust_lints = toml_lints.get("rust", {})
+        cfg_lint = rust_lints.get("unexpected_cfgs", {})
+        return cfg_lint.get("check-cfg", [])
+
+    @property
+    def lints(self) -> Mapping[Any, Any]:
+        return self.get_table("lints")
+
+    def get_table(self, key: str) -> Mapping[Any, Any]:
+        table = self.tomldata.get(key, {})
+
+        return table
+
+
+def generate_cfg_flags(header: str, cargo_toml: CargoTOML) -> Iterable[str]:
     """Converts defines from config[..].h headers to rustc --cfg flags."""
 
-    def cfg_name(name: str) -> str:
-        """Filter function for C #defines"""
-        if (
-            name.startswith("CONFIG_")
-            or name.startswith("TARGET_")
-            or name.startswith("HAVE_")
-        ):
-            return name
-        return ""
-
     with open(header, encoding="utf-8") as cfg:
         config = [l.split()[1:] for l in cfg if l.startswith("#define")]
 
     cfg_list = []
     for cfg in config:
-        name = cfg_name(cfg[0])
-        if not name:
+        name = cfg[0]
+        if f'cfg({name})' not in cargo_toml.check_cfg:
             continue
         if len(cfg) >= 2 and cfg[1] != "1":
             continue
@@ -59,7 +80,6 @@ def cfg_name(name: str) -> str:
 
 
 def main() -> None:
-    # pylint: disable=missing-function-docstring
     parser = argparse.ArgumentParser()
     parser.add_argument("-v", "--verbose", action="store_true")
     parser.add_argument(
@@ -71,12 +91,21 @@ def main() -> None:
         required=False,
         default=[],
     )
+    parser.add_argument(
+        metavar="TOML_FILE",
+        action="store",
+        dest="cargo_toml",
+        help="path to Cargo.toml file",
+    )
     args = parser.parse_args()
     if args.verbose:
         logging.basicConfig(level=logging.DEBUG)
     logging.debug("args: %s", args)
+
+    cargo_toml = CargoTOML(args.cargo_toml)
+
     for header in args.config_headers:
-        for tok in generate_cfg_flags(header):
+        for tok in generate_cfg_flags(header, cargo_toml):
             print(tok)
 
 
-- 
2.47.1


