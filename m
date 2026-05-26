Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94722CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 17:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRw1j-0002Hp-Fc; Tue, 26 May 2026 13:57:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRw1e-0002AS-Js
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:57:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRw1c-00085M-ST
 for qemu-devel@nongnu.org; Tue, 26 May 2026 13:57:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779818228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wd46RPv1cpVjcJdKvZTejd8Ngdtpj1qfzxjn3ahDdkA=;
 b=C7w8YuuyDxu8LbJ9Jk4dzwjt5kkwia5MoBAFBAFOq19DTL8ykXxfrIVTEuflvypi62Soqw
 aNOOMywFwKALv5EUaJLw9y/FoG8QnaDxhIcEUPlCGJhED5gBBn23V8pH5MXqVAzqY/7+Dz
 GAHMsto5j9QbAbe9Kui2ElZtGNWf7HM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-rBakSNYtOI6saAAE1_0lkw-1; Tue, 26 May 2026 13:57:06 -0400
X-MC-Unique: rBakSNYtOI6saAAE1_0lkw-1
X-Mimecast-MFC-AGG-ID: rBakSNYtOI6saAAE1_0lkw_1779818225
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48fe40b61a3so70758055e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 10:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779818225; x=1780423025; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wd46RPv1cpVjcJdKvZTejd8Ngdtpj1qfzxjn3ahDdkA=;
 b=Nw/oCQjH8nEknobK1xOVpUo1TXhH4f8t6dBnP2LarimGQS/6Il6KwFN0uCcqq1s7u/
 3kEHGmyp7ehzDfnH2aQMPFQsilBHghi+JRR1mOq0rJKSAyE0EnBY38jxcLsIThD9vz0h
 xNUyMLN28VWRvqrLc5wmcbYqhIihu5Lx4AFpSAOavKPdwWTq7588GpnuuW6kuzfh3Pgs
 oHq5oeh1OAgP0KK+E35aunZEAI0iYwU2nOWQ9r1COnFMv0E49cbrCX0EqBStKDdMF+qF
 TL4EKRYyEpygeTRF+yS/sQizM/p/gZUAShZK8ieYNFiY7Y4tBgxks5wUQh1qxy+BScrT
 FlCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779818225; x=1780423025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Wd46RPv1cpVjcJdKvZTejd8Ngdtpj1qfzxjn3ahDdkA=;
 b=hbbMwGTUYAGE/64Xr7vPlVaY210ruAClBSOCBHV3kKYyu3N/9F4b0VofDbSzwGZ5jG
 Ynb97a+Oig6u1wpDQPLDiURjvB+TAGJLR9UbDJ9eGhSt7Wllvby1gAxZeP+4M6h1/f0r
 qbPY9GsvcN9r2LxOnvXoKFIY2YwUHCXv0mTQQWxc3nRLDKrw3r+dYKOuhiz8nDA9lcxR
 pe7N2OXzz2/vZ6T+ayesAd4B2UvPtOLWHr3zXNJdRF6KYNS61q7HwQ1fDt7RE+TLkkX3
 NMsVJrek5tKtGcHD2g0Nxa/xjuRMfNm9zx+eVKXntF6HBQwlOa/W+BA+2MHFJ4lhLOD3
 3AEQ==
X-Gm-Message-State: AOJu0YyBxSzykV2bvweUhHa6/cn9kzSB08x4fTT4SngcGSKtxxKKsvZx
 nSmcYrzUgU14D/Qat8fFzd7cVsZJ0L0mYCJTsK914Li99wU79ejHiAa92V/nj8NO/NwrkdWynT1
 tKNtzWMSjs4Lm/6muuBo4ZhlIp5oxXBYAfwgbkn/BVSRXBrcUkK+lxGyC770kXDJpG2I39LSrVt
 /JJVldarR7TOImJW+T11WWH3IJIbkxo2KzIIaFxgbF
X-Gm-Gg: Acq92OGkyNz/CTgWVUEWkyjeNusB64Ka4KQX5gA6XkjTwIPnZE1e+rM5Xqktb0HcDvs
 1ZQNvTBJLGuVGg48dpq7edYmkdCYTl7hZ2wkzrDWYDroZ+qWBbUqC8RHwYd3AxmTZNUsLAAXNqn
 PTw74cBPH3QguCElM2P3JE7z8PjRoWjn64lW/ihcq8fspBgUINmQLrGeCmqSAVRMlmT5ib3GqpV
 4Ezr/KQGbHrbfKh0nDaISZtgFbKMTOizytqucA13J4tj0n0vQWMohs75Sp3y3LY471GPZjN8FO6
 KEr/RBZ+Fa88KWnH0kN6DnvU2CnM8Asr+WDiKj41T/I8Q+BMVgup8d505TQZLkIiRL5r+24fshH
 NcXeiqznYekA6yA7WguJm5Q+RhwXqAOQDb8z8+Gr4TN7xJSKKzP0bKWYR5XKYYnl++HQRHOHZ6o
 gEUBcdzW/+S/qLlYIe7rcfJOxeVlY=
X-Received: by 2002:a05:600d:6414:20b0:490:4b89:5359 with SMTP id
 5b1f17b1804b1-4904b895514mr211213435e9.1.1779818225520; 
 Tue, 26 May 2026 10:57:05 -0700 (PDT)
X-Received: by 2002:a05:600d:6414:20b0:490:4b89:5359 with SMTP id
 5b1f17b1804b1-4904b895514mr211213235e9.1.1779818225105; 
 Tue, 26 May 2026 10:57:05 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d6ebf0sm38630648f8f.34.2026.05.26.10.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 10:57:04 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	armbru@redhat.com,
	marcandre.lureau@redhat.com
Subject: [PATCH v3 16/19] scripts/rustc_args: add --no-strict-cfg
Date: Tue, 26 May 2026 19:56:15 +0200
Message-ID: <20260526175618.227743-17-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526175618.227743-1-pbonzini@redhat.com>
References: <20260526175618.227743-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
2.54.0


