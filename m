Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8709ED185F1
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:12:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdpnW-00081O-TT; Thu, 08 Jan 2026 08:11:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdpnU-0007s0-JU
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:11:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdpnS-00083K-7r
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:11:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767877885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=69DigzWj4ZfxAoDrRrcKXKL2TbKieDPgsraALABmsSU=;
 b=aVkG+XdzGvT57u/gQpqFsnUum0R4w9nAXspra7LS5Eezu8V90IXK+vHpiI6nWtvUgNsOKz
 2DPeBnRNvJooVxkTQ6tI1SGXIXM0wEO/26inudXamZnDX7G8v5GF3Y/jLRkzMXJdTaPkb0
 TXIzEsAqnBETq1wOmM62uxNKmC0rQWM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-a6ph6lbcPnW6LtUal3GIeA-1; Thu, 08 Jan 2026 08:11:24 -0500
X-MC-Unique: a6ph6lbcPnW6LtUal3GIeA-1
X-Mimecast-MFC-AGG-ID: a6ph6lbcPnW6LtUal3GIeA_1767877883
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477cf2230c8so30185845e9.0
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 05:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767877882; x=1768482682; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=69DigzWj4ZfxAoDrRrcKXKL2TbKieDPgsraALABmsSU=;
 b=fDYK9afxtQT3zvg6EjY6irOKWKCaWUPnYr501QguAF15G7lXjlMISCdAprVnzTHqgY
 ls9DwloQ0k2KgKUHxXkEXFvi53V14HkLqJv7Q9CYJBIwJAZgsF8ywVAtXwdpnytdd93/
 LHVHVOrkIo1iD30UeCl2AjNj+f/q4ypLgQ63Fd5zDm5MuppiNXHARf0j0jyzVZHHfxiP
 qweQ8S9wCzYa6zLObSEI6IOrUW7Tge/tito/ZOjpwrLXYuSS9h9euFLTKb8N9/NxkLyK
 6A0Wk+iBplWJyA7OCv99rBgy6iYJaDT5U81NUd6MRezZae4VBBkCKzjGLR7qRCqlYUVF
 /dUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767877882; x=1768482682;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=69DigzWj4ZfxAoDrRrcKXKL2TbKieDPgsraALABmsSU=;
 b=lunQ+h95d7Be7NtmjWIle26aqn18llgTpaXjSCRjirjPxS3qCcXGguj6aeWmcURhsp
 fUklzGu0rGkbYSHxl9mwL30TmYVkthjKNw5VOkkt41qO+oMBH1yqlXnPVdC175IPr58h
 QKTkIID+n3QQqKM1cQdzaHtP+1bXcJz0QrU9H5OgXiCEbcl+2ncAitaMD572dbMAMHYt
 /lsbo9GvJoFDZNgs0qjvVB6a1w473yTmBtKKDoTF8+jhfGu4EvZOJVskcBpxlmc5sV3a
 07CCF9+bjIKBBabnw8WpCwVGNmEqbG8nnu/hHpBr31srR8LbS1DawAtzN1ALqlj8OWFs
 saZg==
X-Gm-Message-State: AOJu0YxThJZtiEBVdKlYReBU0CN+Zzl0CYCPBG9hoThvVAwVMq8JLvpe
 fs2LBXfVZ+XvhL4tWznjojPKITsqxFHwcjz8szZNx+iBIFkzz4BAmdOeRP/ItQTiWjHSDW21b95
 8E5H6EBTDMWNScbzEI/OoO92hCGnbCvMDD/4Fu9e4TLLKx5/LFQx4dVbvJtxv+eCwuH6i0ivf6Y
 4VxmKqFq9sEWBaP8FhxR7tQlQVtojQJ3Lbegux/vhu
X-Gm-Gg: AY/fxX4Gi1ZEZzXI3H+/xK3AavQ4ZVAUXKhmGmFyxd3gyers1brsiIDBATp6kNZc29/
 NFX+Zt7ov81yJqzdL/fo/FPvJZHwS/vyNSZI3SC4Eg2FjWX7tw6t1YbEKXIlNwqAna5xARGYLrx
 xYVze6aP+wTBzTrxZ1KWnG1j+OmSb6B18ePQoEMm7rtN9Vux3jtKpX368qyizbzZcV+vbe9fZBy
 biZoRZ0IzgcuZyyUyME/fzd99obzlZNJoU6iSFZvp5mXTZIfH9/KsRfQ7uJFeLprW8cLmH83JlX
 LabInvu5Y5JS6/K5a/+RM74TyZ8bkFLRlhywYt/ZxugmxqfPrAATFzIeShPZ32GinuhGqwbQaQa
 xfp0YaM9jjLkNmRscdfxAORE9g6rDHH3fhxVA9tCv+zj6QJtfnRPZVsj09CKxOIU1S/Q6P20Nuz
 2mlK6Fw01opKH1Cg==
X-Received: by 2002:a05:600c:630f:b0:47d:5d27:2a7f with SMTP id
 5b1f17b1804b1-47d84b38534mr67895515e9.26.1767877882416; 
 Thu, 08 Jan 2026 05:11:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZRkwS4JBE3z+OEyFzuopJCLYfolNYNYO+oOKcKdPqfFgMR4KlXOfmyc7/a34yqGzdx8kYEA==
X-Received: by 2002:a05:600c:630f:b0:47d:5d27:2a7f with SMTP id
 5b1f17b1804b1-47d84b38534mr67895205e9.26.1767877881966; 
 Thu, 08 Jan 2026 05:11:21 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f410c6csm163484795e9.1.2026.01.08.05.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 05:11:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org
Subject: [PATCH v2 13/16] scripts/rustc_args: add --no-strict-cfg
Date: Thu,  8 Jan 2026 14:10:40 +0100
Message-ID: <20260108131043.490084-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108131043.490084-1-pbonzini@redhat.com>
References: <20260108131043.490084-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Allow to generate all --cfg flags, regardless of Cargo.toml content.
We can't easily list and include all the features used by QAPI types.
Access via #[cfg()] then requires #![allow(unexpected_cfgs)].

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/rust/rustc_args.py | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/scripts/rust/rustc_args.py b/scripts/rust/rustc_args.py
index 8098053720a..6a156b9608e 100644
--- a/scripts/rust/rustc_args.py
+++ b/scripts/rust/rustc_args.py
@@ -108,7 +108,7 @@ def generate_lint_flags(cargo_toml: CargoTOML) -> Iterable[str]:
         yield from lint.flags
 
 
-def generate_cfg_flags(header: str, cargo_toml: CargoTOML) -> Iterable[str]:
+def generate_cfg_flags(header: str, cargo_toml: Optional[CargoTOML]) -> Iterable[str]:
     """Converts defines from config[..].h headers to rustc --cfg flags."""
 
     with open(header, encoding="utf-8") as cfg:
@@ -117,8 +117,9 @@ def generate_cfg_flags(header: str, cargo_toml: CargoTOML) -> Iterable[str]:
     cfg_list = []
     for cfg in config:
         name = cfg[0]
-        if f'cfg({name})' not in cargo_toml.check_cfg:
-            continue
+        if cargo_toml:
+            if f'cfg({name})' not in cargo_toml.check_cfg:
+                continue
         if len(cfg) >= 2 and cfg[1] != "1":
             continue
         cfg_list.append("--cfg")
@@ -179,6 +180,13 @@ def main() -> None:
         required=False,
         default="1.0.0",
     )
+    parser.add_argument(
+        "--no-strict-cfg",
+        help="only generate expected cfg",
+        action="store_false",
+        dest="strict_cfg",
+        default=True,
+    )
     args = parser.parse_args()
     if args.verbose:
         logging.basicConfig(level=logging.DEBUG)
@@ -209,7 +217,7 @@ def main() -> None:
                     print(f'cfg(feature,values("{feature}"))')
 
     for header in args.config_headers:
-        for tok in generate_cfg_flags(header, cargo_toml):
+        for tok in generate_cfg_flags(header, cargo_toml if args.strict_cfg else None):
             print(tok)
 
 
-- 
2.52.0


