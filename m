Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3949C5DF8A
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:56:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5zj-0000fZ-N5; Thu, 20 Aug 2026 12:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zi-0000fE-PA
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zh-0005lc-6H
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r0ygABJTpsHOhl9gB0pPnn5YiHCVRoF4PezK5Ys2JEE=;
 b=IdI2vwY2VCDk7Gz66rfi41QKdP2BlVDSsDwYsahheGkMRgcHkbOYTRNCptAEM3BpvchGqg
 9Ju+YcoEKImwepJcPJMrPveA/D3kOJUjy/IdPUUPz5audjp77OxLVhsin7rqMaqqOWr52L
 hZkZJyW0Os5Pl2LCZIhL/mSJjApAfi4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-mN7u_u8wNrW0DpuSrE_c5g-1; Thu, 20 Aug 2026 12:51:55 -0400
X-MC-Unique: mN7u_u8wNrW0DpuSrE_c5g-1
X-Mimecast-MFC-AGG-ID: mN7u_u8wNrW0DpuSrE_c5g_1787244714
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f8398ed9fso104185f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244714; x=1787849514; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=r0ygABJTpsHOhl9gB0pPnn5YiHCVRoF4PezK5Ys2JEE=;
 b=Bl+mw3fFrxzABySUfgssNtYRXfkwsG4145j4H1X7974wAf9KEsLMYUVt2YhxJa5h8q
 F5iaBRfQCZrMpDVov0LrBYw/m5IkZy/MPmb4Cwig0kn0nblFvF73mAc8Ek73eEJ4ZAC5
 yCu+Mro1C6LWIYW/5SsW2yxW0UwJY+gk/eNfwGXCl0lSJ/508OECH2NxPWTMzJMEVKCG
 f6bdv6Op511BooOcGd7DGYxdyWVSDXI6c2OX84WepumUKaOf4FGwXgUK2OkPGucIpToO
 DUposR4ioDTJIjSB83ypXify9OrKelPhGw0xnoFv1jCxiIE2SofoT01p9/y4BvGF1qDE
 kWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244714; x=1787849514;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=r0ygABJTpsHOhl9gB0pPnn5YiHCVRoF4PezK5Ys2JEE=;
 b=kCjxz4mXprjzUxJdtZDleiZN5PIDHPR63zA8lnKGACnVIgEtrUaQYDCC3yeZDXhkG8
 N094nvTUQnOCFy0Kc06wAGtFNgiGJkXeMX90jZQuNVlIUetGrUTGZWcKGRO0EZSAXRqe
 if9tB0SwAPVOKQLNrAMWr3kvD7tiMRTcIfC1qdG/763YUxbEpLHS9fHxdPqYZkChu8p2
 DDix7AXiMg8XQzthH0F+6GEWqThF++6IYNWoUOEzTnysuVI33spJC5Dj4R26ORpedQhu
 UlJprChHsjX9+WP9OJq/CFvd5vu2w86bIW4Bxc5n4Q3djaDCybgwRE7TcEze3wo64dIm
 HPrg==
X-Gm-Message-State: AFuF++ltlTkRWJuXRXAijam0ddlwgfGZVQsf7QVDYsfiXzPS+ICkmTIY
 TECgEPf5tmwuS9fhi9krxZsNnNDP4cksbRMR0DobcT+t4ElKf+0DODymHe1DLgjnGtQE0PcJ9F4
 MM9SfwC9xcjJTeVWea/1NIlYkY554v6BaRCY8rBCcOzf2ERn1yJt39x/00XLViXq97VZi5My499
 zPNAjfGDtJp2Yg14p4PeqYfl3hhta3shZvLDnPbY0S
X-Gm-Gg: AR+sD10DGpaXlgMKm/PKpbglcKu5wsBhQLrtJFqvSn8w5kJxX89oIAKg6oBd91BHCTT
 p7WSUSPnwSxUxndBwPYWusDzdVWKRbzf2FN+FKzHxta0vtbirtrk8RDtSR3q2G6mBORrmxiVVaa
 V+JczInShfnwZBvFB2k3Q4pXOzzwfIgAYzzeVWHBIVNyEgL4StwMhnTdp+7Xlfp8ALhLuBuXhcO
 KunW0QQFq3P1otmCxO3v7b4+FUXvhoPa0OMLq11r8E3012SBK+LMHEiICM7/DLtoiEb+q/OoKVt
 E6du3l57uGvT6+AqxMYsr/sH9qis9Udkqn+rNGvxhoZO6RDsQ0S3Ean4c5ew0YNp0WFNKGWCYRm
 Zmo0Nkr3F4FHQ37DmfPWIt+i5V69D5LRHNQzDk19S80PW77lo9g81sglzsGycumoryGfEpMOO6G
 uxlII=
X-Received: by 2002:a05:6000:1445:b0:482:aa2a:52f7 with SMTP id
 ffacd0b85a97d-482c0b62085mr12676f8f.6.1787244714066; 
 Thu, 20 Aug 2026 09:51:54 -0700 (PDT)
X-Received: by 2002:a05:6000:1445:b0:482:aa2a:52f7 with SMTP id
 ffacd0b85a97d-482c0b62085mr12573f8f.6.1787244713570; 
 Thu, 20 Aug 2026 09:51:53 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14b8038sm12739589f8f.20.2026.08.20.09.51.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:51:52 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 41/53] python, meson: update meson required for Rust to 1.12.0
Date: Thu, 20 Aug 2026 18:49:44 +0200
Message-ID: <20260820164957.1895963-42-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Meson 1.11.0 brings support for parsing Cargo.toml inside QEMU's source
tree, and Meson 1.12.0 brings support for cross-compilation of Cargo
subprojects.

Together, these two features allow QEMU to remove hundreds of lines of
manual compilation scripts.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure                                   |   4 ++--
 python/scripts/vendor.py                    |   4 ++--
 python/wheels/meson-1.11.1-py3-none-any.whl | Bin 1078534 -> 0 bytes
 python/wheels/meson-1.12.0-py3-none-any.whl | Bin 0 -> 1106208 bytes
 pythondeps.toml                             |   4 ++--
 5 files changed, 6 insertions(+), 6 deletions(-)
 delete mode 100644 python/wheels/meson-1.11.1-py3-none-any.whl
 create mode 100644 python/wheels/meson-1.12.0-py3-none-any.whl

diff --git a/configure b/configure
index 6ddfe4b5342..7f637c018c3 100755
--- a/configure
+++ b/configure
@@ -1166,12 +1166,12 @@ fi
 # detect rust triple
 
 meson_version=$($meson --version)
-if test "$rust" != disabled && ! version_ge "$meson_version" 1.10.0; then
+if test "$rust" != disabled && ! version_ge "$meson_version" 1.12.0; then
   if test "$rust" = enabled; then
     $mkvenv ensuregroup --dir "${source_path}/python/wheels" \
          ${source_path}/pythondeps.toml meson-rust || exit 1
   else
-    echo "Rust needs Meson 1.10.0, disabling" 2>&1
+    echo "Rust needs Meson 1.12.0, disabling" 2>&1
     rust=disabled
   fi
 fi
diff --git a/python/scripts/vendor.py b/python/scripts/vendor.py
index 1bb59d863af..9b4c763f9ec 100755
--- a/python/scripts/vendor.py
+++ b/python/scripts/vendor.py
@@ -41,8 +41,8 @@ def main() -> int:
     parser.parse_args()
 
     packages = {
-        "meson==1.11.1":
-        "9b3a023657e393dbc5335b95c561337d49b7a458f5541e47ec44f2cc566e0d80",
+        "meson==1.12.0":
+        "71f133147fa0fcfe8f4df49fa1045771064947834538409e5d97b3613aac8b4e",
         "qemu.qmp==0.0.6":
         "5d7c5af0e9de427696e3bf72e333965c3a697929f77f6b7ddc30c989fc7b539b",
         "pycotap==1.3.1":
diff --git a/pythondeps.toml b/pythondeps.toml
index bef88d49a6e..061f0cff0c4 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -19,12 +19,12 @@
 
 [meson]
 # The install key should match the version in python/wheels/
-meson = { accepted = ">=1.5.0", installed = "1.11.1", canary = "meson" }
+meson = { accepted = ">=1.5.0", installed = "1.12.0", canary = "meson" }
 pycotap = { accepted = ">=1.1.0", installed = "1.3.1" }
 
 [meson-rust]
 # The install key should match the version in python/wheels/
-meson = { accepted = ">=1.11.0", installed = "1.11.1", canary = "meson" }
+meson = { accepted = ">=1.12.0", installed = "1.12.0", canary = "meson" }
 
 [docs]
 # Please keep the installed versions in sync with docs/requirements.txt
-- 
2.55.0


