Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803D3E8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:18:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQQi-0004x5-96; Sat, 27 Dec 2025 04:17:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQg-0004vt-TD
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQQe-00032Y-9m
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:17:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827059;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5xP6RbDJdxuVF1c+h4BfUbKLKE7O4fF3Vh5w0OqHTD4=;
 b=SHsLEeeinrHkk7bQMqNMpkMF15Th+Yd9bCSGDrRY3IvnC/PiDCQroQvTkZcsxm4dASyHhs
 hYW9vo5MbW30O2wv80/vU/T10jlWSuserOA1p8LXRe/PIH2wjRoiRakYGBxwCVozlM2K9M
 ZLZt3TUsdCw2sfTehhhyWOzPh/xeDEU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-oRe9ZkfpPpSmtjOgZBnf1A-1; Sat, 27 Dec 2025 04:17:36 -0500
X-MC-Unique: oRe9ZkfpPpSmtjOgZBnf1A-1
X-Mimecast-MFC-AGG-ID: oRe9ZkfpPpSmtjOgZBnf1A_1766827056
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4779b3749a8so54867355e9.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827054; x=1767431854; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5xP6RbDJdxuVF1c+h4BfUbKLKE7O4fF3Vh5w0OqHTD4=;
 b=LLrW52SEvVC710rz0V1wqRTAM40bq+yIm+dkyR7ubr1J7zN4RV9rHzTUxPRnl8bl1j
 zXqxdcCrq6QhlVL5PRDtSeqr5XPBMAkzjara5eRMX+u1PlXU/9XYlA6mJqtVcOdn4fKL
 tFeCaAoDUA4TeHSL1ZdF59F1GcFE8I0gEN/eJEofX+VVct6Ah1dXNFW2U5z8B1X7x/44
 ataPdlIVUUJXGZC6fXF59myxqGOIe6PcgMogYjSh3wQa1eNC00obMhF3FUzw3rIB28iW
 xNvBq9uD77z8iK/VfcT7+En6vBPQm6nJDdXmRftYSjhzrkeLOOmS9TU58B/bLCdk6R2n
 sHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827054; x=1767431854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5xP6RbDJdxuVF1c+h4BfUbKLKE7O4fF3Vh5w0OqHTD4=;
 b=nDNxUiyXDWBsv2XaPyuHAnVaaPdcsGlmohlkcWb31hcy8/YT8e51MuscCbmwMXRpZf
 tmF4HGwPKmnkY9LvJmHQ4U5mcyr/Cejrs6C1IQDCQxnPkUSv5iZEQhoMjllFvZfDZZ/n
 epSYk2nce3lUnJqC5DQ+axzfHdeCTwiWKSr7kwGxVyoMIyLHFWcF0hO6wRUNFQ8yIffd
 qVQz/mij5Kia/kQKrKjATL3YaXxiLx77ABAJnhGXoKCtaGVjdVCaSPZ0xd6OMggd2Fnm
 GhHJ2o8z6wc7yQ7RCDksuPf3WCjZKqmiSJT1DIWTgL9KZNsBy1BO6BiW8qfdJkuQK2b7
 IY0Q==
X-Gm-Message-State: AOJu0YyURvjfA9Vc1J/uDShXfVaXocFQYBeGmu/elGRRlCGbIRZdhOLf
 lS0zgs9Plv/S2Yc7cxMBySqBB088OXDGWNwaDzKQ04j29DTjP5S/6DVgPCFaYSP0pDBM6dTF1hz
 vj3rmMAmHHs8KrZMqCrMOcnGP+rdDWcOo3hE46larzMc2lHBMmKXaj4exyXOcWJ5tpJ7z7P+iLT
 wA/AUnzZ20omdFNYGBu0Z9SVNlBvS+4pQ0eo1bO6sc
X-Gm-Gg: AY/fxX6UGduvbTF+fatZkwYTN2G4ythFY/m5gmh3/yRdpUQBgeP8JI4yECCPExZFYYo
 G2tbY3guK/pfIzYl7gHV0KczffABBN4wIFgysPwFV2AGj+Jh1gMlwWGOhc1eyCwWGHShRqQJsLG
 W9MBC+9gRpjPNtpoi46Ef8u5UfA6Bwhk5nUltsCVzm2k13DhJKIUtro/S/thdzZXao26ZnsS8qV
 2PKVRyPhmocjvKiN/yDdZn6j0aB6wLVs6OFXHkAod3HAkGTBe5H82yiHDuoaECxeUj+JKeiIHEJ
 /gpw1/osWcmC3ZrVBuSZc7a+Hn2gluNU6Z/lJmgdepDKFuEf1KG9DzG1L8JdDzGcKmMyaJ2K2Dt
 nsuIFc2EjFtzPGsC1HbUf/j/edxKm885Ri9HLFtPzHvrwmSVVvhosPg4yF0aE1DPWECUL14ViAf
 0BfgYDkM8+IH0pm88=
X-Received: by 2002:a05:600c:19c6:b0:477:7b9a:bb0a with SMTP id
 5b1f17b1804b1-47d4cb41658mr52598825e9.21.1766827054119; 
 Sat, 27 Dec 2025 01:17:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYvmmj3BK11NvnSycBHmzd+Lmg1JzeV29inqTR3Znqp/L8j2XTZWBpKwB0CBu7B+CzDdG22Q==
X-Received: by 2002:a05:600c:19c6:b0:477:7b9a:bb0a with SMTP id
 5b1f17b1804b1-47d4cb41658mr52598515e9.21.1766827053669; 
 Sat, 27 Dec 2025 01:17:33 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea82fa1sm48076085f8f.23.2025.12.27.01.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:17:31 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 036/153] rust: move strict lints handling to meson.build
Date: Sat, 27 Dec 2025 10:14:23 +0100
Message-ID: <20251227091622.20725-37-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Simplify rustc_args.py, and align its code with what Meson's own Cargo.toml
translator does in v1.10.

Bump unknown_lints to "forbid", so that it will certainly override Cargo.toml's
"allow" level.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 meson.build                |  7 +++----
 scripts/rust/rustc_args.py | 21 +++------------------
 2 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/meson.build b/meson.build
index 270181038bf..e6a11cefdb7 100644
--- a/meson.build
+++ b/meson.build
@@ -128,14 +128,13 @@ if have_rust
   rustc_args = [find_program('scripts/rust/rustc_args.py'),
     '--rustc-version', rustc.version(),
     '--workspace', meson.project_source_root() / 'rust']
-  if get_option('strict_rust_lints')
-    rustc_args += ['--strict-lints']
-  endif
-
   rustfmt = find_program('rustfmt', required: false)
 
   rustc_lint_args = run_command(rustc_args, '--lints',
      capture: true, check: true).stdout().strip().splitlines()
+  if get_option('strict_rust_lints')
+    rustc_lint_args += ['-Dwarnings', '-Funknown_lints']
+  endif
 
   # Apart from procedural macros, our Rust executables will often link
   # with C code, so include all the libraries that C code needs.  This
diff --git a/scripts/rust/rustc_args.py b/scripts/rust/rustc_args.py
index 63b0748e0d3..8098053720a 100644
--- a/scripts/rust/rustc_args.py
+++ b/scripts/rust/rustc_args.py
@@ -35,8 +35,6 @@
 except ImportError:
     import tomli as tomllib
 
-STRICT_LINTS = {"unknown_lints", "warnings"}
-
 
 class CargoTOML:
     tomldata: Mapping[Any, Any]
@@ -82,7 +80,7 @@ class LintFlag:
     priority: int
 
 
-def generate_lint_flags(cargo_toml: CargoTOML, strict_lints: bool) -> Iterable[str]:
+def generate_lint_flags(cargo_toml: CargoTOML) -> Iterable[str]:
     """Converts Cargo.toml lints to rustc -A/-D/-F/-W flags."""
 
     toml_lints = cargo_toml.lints
@@ -103,13 +101,7 @@ def generate_lint_flags(cargo_toml: CargoTOML, strict_lints: bool) -> Iterable[s
                 flag = "-F"
             else:
                 raise Exception(f"invalid level {level} for {prefix}{lint}")
-
-            if not (strict_lints and lint in STRICT_LINTS):
-                lint_list.append(LintFlag(flags=[flag, prefix + lint], priority=priority))
-
-    if strict_lints:
-        for lint in STRICT_LINTS:
-            lint_list.append(LintFlag(flags=["-D", lint], priority=1000000))
+            lint_list.append(LintFlag(flags=[flag, prefix + lint], priority=priority))
 
     lint_list.sort(key=lambda x: x.priority)
     for lint in lint_list:
@@ -187,13 +179,6 @@ def main() -> None:
         required=False,
         default="1.0.0",
     )
-    parser.add_argument(
-        "--strict-lints",
-        action="store_true",
-        dest="strict_lints",
-        help="apply stricter checks (for nightly Rust)",
-        default=False,
-    )
     args = parser.parse_args()
     if args.verbose:
         logging.basicConfig(level=logging.DEBUG)
@@ -207,7 +192,7 @@ def main() -> None:
         cargo_toml = CargoTOML(args.cargo_toml, None)
 
     if args.lints:
-        for tok in generate_lint_flags(cargo_toml, args.strict_lints):
+        for tok in generate_lint_flags(cargo_toml):
             print(tok)
 
     if rustc_version >= (1, 80):
-- 
2.52.0


