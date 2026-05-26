Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D75FFCD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 09:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRo32-0007LI-Hs; Tue, 26 May 2026 05:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRo31-0007KX-29
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:26:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wRo2y-00071F-6l
 for qemu-devel@nongnu.org; Tue, 26 May 2026 05:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779787559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BJdd8Uk7qdZMe9AyVwH8JOZ00EnKc7MDR2nSV5VJWtk=;
 b=RTdsulMST5Oz8AyK8StUKS6f2sJxyYA1+86yvc+ZHw3vaLRQnVvuNFHpBmNyKIAUaGi0Kg
 7zIy7pesgDNNt3670EDUgChF+30+VvSae7ilL28WH2kLkcGYrsXslwAsqPae9kngJ/2pLH
 L2851C24Czp0v91IJM6s0HSitqau/J0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-vEvNHPt6PdKcxoRI47T4BA-1; Tue, 26 May 2026 05:25:57 -0400
X-MC-Unique: vEvNHPt6PdKcxoRI47T4BA-1
X-Mimecast-MFC-AGG-ID: vEvNHPt6PdKcxoRI47T4BA_1779787556
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-49047e9ca88so31178625e9.3
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 02:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779787556; x=1780392356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=BJdd8Uk7qdZMe9AyVwH8JOZ00EnKc7MDR2nSV5VJWtk=;
 b=g+e2mopeIkb1ScHDLL+xCDVawYF/llLCLXcOytfp9JRSfGeyq6SUyI6FFPvAnghDcU
 JIVnulWFjpwHcTcaIbnHVTh7gga1/eYkDA7MhyOBHQPUC+/k6itze3O2WOP9b+8JJX8f
 qLcaHm5uwIhXldMWryFsiGpw2E5aPvicyUEEMnGVb8pZpJXqCqXYDNT6JmR2iw+mPkai
 K6IKDo0EJaSPvmqpz0G6Z8rGlOXLZ6MFcWIPmIldytefLvBkx6T6o+4fuhR/XURUWeSw
 O8SkJGX6NqzOEkqtgcNmlUPEVcHsX2cdPqO9YKEO5/SMxgIM2Fbf2zRekICSPpXnaF1j
 cueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779787556; x=1780392356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=BJdd8Uk7qdZMe9AyVwH8JOZ00EnKc7MDR2nSV5VJWtk=;
 b=l3veJiuNe+mUjKHwNWm218L2VOZowNjzYK7LKrxDLEGF9cDZ6S4WIk8lo9fadxbNm0
 PaYbB9kvZRSFtLV4yIEepM5sX8qnr+4XbYc2tB2t/HCqWGk50vEwo+sXoOtetP4u7NNB
 XtwVMTiX01zUCpofPc1Be62/3lgSnIdj19XDWkZfPpsDEhyhw4bcbrn/hPBSQMP5IIRX
 ejIOW6B4b16HsEygqP+4SWrI2rhdomlbhUxSTz4qWhaGFD/FLqLkyasFLnh884IF3QBU
 8cGfCkL8DrgSFj0SFUf3UHnzR0bxLRZJjpWTo3Bu8IqZONcXId/Kcvo1NVNwQ3ZGTcxt
 Lo0g==
X-Gm-Message-State: AOJu0Ywz0W86qip9Qn9UPnDrOyUmSHL1+9BgkzC/VVH8dmTcDZbX3/lS
 36RfyBw3Ru2mBE1yq4WqOIItEX4HjS5o731ZnXmaN5kaDxlBATgqgrnMutiv8v0JZuUmbEMvXsj
 f165BEkHbJvbTDWAZSfFM19tine7feRMAuUli7olN4tvKk+t0d+MXJTNfKS+PTnUmZwXBDdfmpT
 1/6zu49nVqhdgKcRQ2W1XL2xhj4n/+Y0QXC71oRQAn
X-Gm-Gg: Acq92OFjIOC+XhGf2dyy5y0xU9I0k5HDqdbQKpqmVZ4hC1raR/MTGSgDNzQ9DjjBfzi
 U4y1X/vX+G3U7ZotCmh2DaZCVBxPsmMxf1ikdDq5m+FxETm01lDnIHQ/Ah1BRVE4w6GysQ3GMRi
 /h8hvt8lFbfjrrYbAMPih4nWgGk0vaUJ/aIqV8wueCYfHb34XSbPalUEKPB6LaIOh1XknYOZMns
 xlHOfa35EXheX6DCgZkNkLkzMcewFLM1LXSPlyWiy2kuDYiMCGcRkijp91DzyZD2xp5qNS3zQBv
 u4Bvia6VUrv2Yh95a+AfydfChHVX+tm/LG8ERmvUQlImBR5kmlsyrPHn0d6XSrp/tDnK/MaiYIL
 PIU+5qSmgTKlXTPbrfChO+2dtXSl//98BZuHM5HKxTjSi7t+zekMVLsCpVSPTZ6pvI/uSCl+6Ef
 Cc8XWiMdiooNxWkJB775AEO2SME8c=
X-Received: by 2002:a05:600c:8b08:b0:490:601f:d785 with SMTP id
 5b1f17b1804b1-490601fd90amr159406225e9.2.1779787555980; 
 Tue, 26 May 2026 02:25:55 -0700 (PDT)
X-Received: by 2002:a05:600c:8b08:b0:490:601f:d785 with SMTP id
 5b1f17b1804b1-490601fd90amr159405525e9.2.1779787555335; 
 Tue, 26 May 2026 02:25:55 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.251.208])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49049973b71sm90641285e9.29.2026.05.26.02.25.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 02:25:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/6] rust: remove unnecessary wrap files
Date: Tue, 26 May 2026 11:25:43 +0200
Message-ID: <20260526092546.149241-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526092546.149241-1-pbonzini@redhat.com>
References: <20260526092546.149241-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Meson can also figure out what the content of the wrap file would
be, at least if there is no diff file.  So delete the now-unnecessary
wrap configurations.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 subprojects/anyhow-1-rs.wrap                | 10 ----------
 subprojects/arbitrary-int-1-rs.wrap         |  9 ---------
 subprojects/attrs-0.2-rs.wrap               |  9 ---------
 subprojects/bilge-0.2-rs.wrap               |  9 ---------
 subprojects/bilge-impl-0.2-rs.wrap          | 10 ----------
 subprojects/either-1-rs.wrap                |  9 ---------
 subprojects/foreign-0.3-rs.wrap             |  9 ---------
 subprojects/glib-sys-0.21-rs.wrap           |  9 ---------
 subprojects/itertools-0.11-rs.wrap          |  9 ---------
 subprojects/libc-0.2-rs.wrap                |  7 -------
 subprojects/probe-0.5-rs.wrap               |  9 ---------
 subprojects/proc-macro-error-1-rs.wrap      | 10 ----------
 subprojects/proc-macro-error-attr-1-rs.wrap | 10 ----------
 subprojects/proc-macro2-1-rs.wrap           | 10 ----------
 subprojects/quote-1-rs.wrap                 |  9 ---------
 subprojects/syn-2-rs.wrap                   |  9 ---------
 subprojects/unicode-ident-1-rs.wrap         |  9 ---------
 17 files changed, 156 deletions(-)
 delete mode 100644 subprojects/anyhow-1-rs.wrap
 delete mode 100644 subprojects/arbitrary-int-1-rs.wrap
 delete mode 100644 subprojects/attrs-0.2-rs.wrap
 delete mode 100644 subprojects/bilge-0.2-rs.wrap
 delete mode 100644 subprojects/bilge-impl-0.2-rs.wrap
 delete mode 100644 subprojects/either-1-rs.wrap
 delete mode 100644 subprojects/foreign-0.3-rs.wrap
 delete mode 100644 subprojects/glib-sys-0.21-rs.wrap
 delete mode 100644 subprojects/itertools-0.11-rs.wrap
 delete mode 100644 subprojects/libc-0.2-rs.wrap
 delete mode 100644 subprojects/probe-0.5-rs.wrap
 delete mode 100644 subprojects/proc-macro-error-1-rs.wrap
 delete mode 100644 subprojects/proc-macro-error-attr-1-rs.wrap
 delete mode 100644 subprojects/proc-macro2-1-rs.wrap
 delete mode 100644 subprojects/quote-1-rs.wrap
 delete mode 100644 subprojects/syn-2-rs.wrap
 delete mode 100644 subprojects/unicode-ident-1-rs.wrap

diff --git a/subprojects/anyhow-1-rs.wrap b/subprojects/anyhow-1-rs.wrap
deleted file mode 100644
index 132c70c467e..00000000000
--- a/subprojects/anyhow-1-rs.wrap
+++ /dev/null
@@ -1,10 +0,0 @@
-[wrap-file]
-directory = anyhow-1.0.98
-source_url = https://crates.io/api/v1/crates/anyhow/1.0.98/download
-source_filename = anyhow-1.0.98.tar.gz
-source_hash = e16d2d3311acee920a9eb8d33b8cbc1787ce4a264e85f964c2404b969bdcd487
-method = cargo
-patch_directory = anyhow-1-rs
-
-# bump this version number on every change to meson.build or the patches:
-# v2
diff --git a/subprojects/arbitrary-int-1-rs.wrap b/subprojects/arbitrary-int-1-rs.wrap
deleted file mode 100644
index 5cf4b11e4a3..00000000000
--- a/subprojects/arbitrary-int-1-rs.wrap
+++ /dev/null
@@ -1,9 +0,0 @@
-[wrap-file]
-directory = arbitrary-int-1.2.7
-source_url = https://crates.io/api/v1/crates/arbitrary-int/1.2.7/download
-source_filename = arbitrary-int-1.2.7.tar.gz
-source_hash = c84fc003e338a6f69fbd4f7fe9f92b535ff13e9af8997f3b14b6ddff8b1df46d
-method = cargo
-
-# bump this version number on every change to meson.build or the patches:
-# v2
diff --git a/subprojects/attrs-0.2-rs.wrap b/subprojects/attrs-0.2-rs.wrap
deleted file mode 100644
index dcdddf005f6..00000000000
--- a/subprojects/attrs-0.2-rs.wrap
+++ /dev/null
@@ -1,9 +0,0 @@
-[wrap-file]
-directory = attrs-0.2.9
-source_url = https://crates.io/api/v1/crates/attrs/0.2.9/download
-source_filename = attrs-0.2.9.tar.gz
-source_hash = 2a207d40f43de65285f3de0509bb6cb16bc46098864fce957122bbacce327e5f
-method = cargo
-
-# bump this version number on every change to meson.build or the patches:
-# v2
diff --git a/subprojects/bilge-0.2-rs.wrap b/subprojects/bilge-0.2-rs.wrap
deleted file mode 100644
index cff10f6710d..00000000000
--- a/subprojects/bilge-0.2-rs.wrap
+++ /dev/null
@@ -1,9 +0,0 @@
-[wrap-file]
-directory = bilge-0.2.0
-source_url = https://crates.io/api/v1/crates/bilge/0.2.0/download
-source_filename = bilge-0.2.0.tar.gz
-source_hash = dc707ed8ebf81de5cd6c7f48f54b4c8621760926cdf35a57000747c512e67b57
-method = cargo
-
-# bump this version number on every change to meson.build or the patches:
-# v2
diff --git a/subprojects/bilge-impl-0.2-rs.wrap b/subprojects/bilge-impl-0.2-rs.wrap
deleted file mode 100644
index e423b6cec66..00000000000
--- a/subprojects/bilge-impl-0.2-rs.wrap
+++ /dev/null
@@ -1,10 +0,0 @@
-[wrap-file]
-directory = bilge-impl-0.2.0
-source_url = https://crates.io/api/v1/crates/bilge-impl/0.2.0/download
-source_filename = bilge-impl-0.2.0.tar.gz
-source_hash = feb11e002038ad243af39c2068c8a72bcf147acf05025dcdb916fcc000adb2d8
-method = cargo
-patch_directory = bilge-impl-0.2-rs
-
-# bump this version number on every change to meson.build or the patches:
-# v3
diff --git a/subprojects/either-1-rs.wrap b/subprojects/either-1-rs.wrap
deleted file mode 100644
index d2808d3d7fb..00000000000
--- a/subprojects/either-1-rs.wrap
+++ /dev/null
@@ -1,9 +0,0 @@
-[wrap-file]
-directory = either-1.12.0
-source_url = https://crates.io/api/v1/crates/either/1.12.0/download
-source_filename = either-1.12.0.tar.gz
-source_hash = 3dca9240753cf90908d7e4aac30f630662b02aebaa1b58a3cadabdb23385b58b
-method = cargo
-
-# bump this version number on every change to meson.build or the patches:
-# v3
diff --git a/subprojects/foreign-0.3-rs.wrap b/subprojects/foreign-0.3-rs.wrap
deleted file mode 100644
index e4aa7f11fc0..00000000000
--- a/subprojects/foreign-0.3-rs.wrap
+++ /dev/null
@@ -1,9 +0,0 @@
-[wrap-file]
-directory = foreign-0.3.1
-source_url = https://crates.io/api/v1/crates/foreign/0.3.1/download
-source_filename = foreign-0.3.1.tar.gz
-source_hash = 17ca1b5be8c9d320daf386f1809c7acc0cb09accbae795c2001953fa50585846
-method = cargo
-
-# bump this version number on every change to meson.build or the patches:
-# v2
diff --git a/subprojects/glib-sys-0.21-rs.wrap b/subprojects/glib-sys-0.21-rs.wrap
deleted file mode 100644
index 4723f7f63be..00000000000
--- a/subprojects/glib-sys-0.21-rs.wrap
+++ /dev/null
@@ -1,9 +0,0 @@
-[wrap-file]
-directory = glib-sys-0.21.2
-source_url = https://crates.io/api/v1/crates/glib-sys/0.21.2/download
-source_filename = glib-sys-0.21.2.tar.gz
-source_hash = d09d3d0fddf7239521674e57b0465dfbd844632fec54f059f7f56112e3f927e1
-method = cargo
-
-# bump this version number on every change to meson.build or the patches:
-# v2
diff --git a/subprojects/itertools-0.11-rs.wrap b/subprojects/itertools-0.11-rs.wrap
deleted file mode 100644
index fc63e2f57d9..00000000000
--- a/subprojects/itertools-0.11-rs.wrap
+++ /dev/null
@@ -1,9 +0,0 @@
-[wrap-file]
-directory = itertools-0.11.0
-source_url = https://crates.io/api/v1/crates/itertools/0.11.0/download
-source_filename = itertools-0.11.0.tar.gz
-source_hash = b1c173a5686ce8bfa551b3563d0c2170bf24ca44da99c7ca4bfdab5418c3fe57
-method = cargo
-
-# bump this version number on every change to meson.build or the patches:
-# v3
diff --git a/subprojects/libc-0.2-rs.wrap b/subprojects/libc-0.2-rs.wrap
deleted file mode 100644
index 488330178ed..00000000000
--- a/subprojects/libc-0.2-rs.wrap
+++ /dev/null
@@ -1,7 +0,0 @@
-[wrap-file]
-directory = libc-0.2.162
-source_url = https://crates.io/api/v1/crates/libc/0.2.162/download
-source_filename = libc-0.2.162.tar.gz
-source_hash = 18d287de67fe55fd7e1581fe933d965a5a9477b38e949cfa9f8574ef01506398
-method = cargo
-patch_directory = libc-0.2-rs
diff --git a/subprojects/probe-0.5-rs.wrap b/subprojects/probe-0.5-rs.wrap
deleted file mode 100644
index 035da86c46a..00000000000
--- a/subprojects/probe-0.5-rs.wrap
+++ /dev/null
@@ -1,9 +0,0 @@
-[wrap-file]
-directory = probe-0.5.2
-source_url = https://crates.io/api/v1/crates/probe/0.5.2/download
-source_filename = probe-0.5.2.tar.gz
-source_hash = 136558b6e1ebaecc92755d0ffaf9421f519531bed30cc2ad23b22cb00965cc5e
-method = cargo
-
-# bump this version number on every change to meson.build or the patches:
-# v1
diff --git a/subprojects/proc-macro-error-1-rs.wrap b/subprojects/proc-macro-error-1-rs.wrap
deleted file mode 100644
index e57921bfadc..00000000000
--- a/subprojects/proc-macro-error-1-rs.wrap
+++ /dev/null
@@ -1,10 +0,0 @@
-[wrap-file]
-directory = proc-macro-error-1.0.4
-source_url = https://crates.io/api/v1/crates/proc-macro-error/1.0.4/download
-source_filename = proc-macro-error-1.0.4.tar.gz
-source_hash = da25490ff9892aab3fcf7c36f08cfb902dd3e71ca0f9f9517bea02a73a5ce38c
-method = cargo
-patch_directory = proc-macro-error-1-rs
-
-# bump this version number on every change to meson.build or the patches:
-# v3
diff --git a/subprojects/proc-macro-error-attr-1-rs.wrap b/subprojects/proc-macro-error-attr-1-rs.wrap
deleted file mode 100644
index 02d18f3393d..00000000000
--- a/subprojects/proc-macro-error-attr-1-rs.wrap
+++ /dev/null
@@ -1,10 +0,0 @@
-[wrap-file]
-directory = proc-macro-error-attr-1.0.4
-source_url = https://crates.io/api/v1/crates/proc-macro-error-attr/1.0.4/download
-source_filename = proc-macro-error-attr-1.0.4.tar.gz
-source_hash = a1be40180e52ecc98ad80b184934baf3d0d29f979574e439af5a55274b35f869
-method = cargo
-patch_directory = proc-macro-error-attr-1-rs
-
-# bump this version number on every change to meson.build or the patches:
-# v3
diff --git a/subprojects/proc-macro2-1-rs.wrap b/subprojects/proc-macro2-1-rs.wrap
deleted file mode 100644
index 676d1a3a8ca..00000000000
--- a/subprojects/proc-macro2-1-rs.wrap
+++ /dev/null
@@ -1,10 +0,0 @@
-[wrap-file]
-directory = proc-macro2-1.0.95
-source_url = https://crates.io/api/v1/crates/proc-macro2/1.0.95/download
-source_filename = proc-macro2-1.0.95.0.tar.gz
-source_hash = 02b3e5e68a3a1a02aad3ec490a98007cbc13c37cbe84a3cd7b8e406d76e7f778
-method = cargo
-patch_directory = proc-macro2-1-rs
-
-# bump this version number on every change to meson.build or the patches:
-# v3
diff --git a/subprojects/quote-1-rs.wrap b/subprojects/quote-1-rs.wrap
deleted file mode 100644
index 80d5ea84f54..00000000000
--- a/subprojects/quote-1-rs.wrap
+++ /dev/null
@@ -1,9 +0,0 @@
-[wrap-file]
-directory = quote-1.0.36
-source_url = https://crates.io/api/v1/crates/quote/1.0.36/download
-source_filename = quote-1.0.36.0.tar.gz
-source_hash = 0fa76aaf39101c457836aec0ce2316dbdc3ab723cdda1c6bd4e6ad4208acaca7
-method = cargo
-
-# bump this version number on every change to meson.build or the patches:
-# v3
diff --git a/subprojects/syn-2-rs.wrap b/subprojects/syn-2-rs.wrap
deleted file mode 100644
index 8ec7fd00528..00000000000
--- a/subprojects/syn-2-rs.wrap
+++ /dev/null
@@ -1,9 +0,0 @@
-[wrap-file]
-directory = syn-2.0.104
-source_url = https://crates.io/api/v1/crates/syn/2.0.104/download
-source_filename = syn-2.0.104.0.tar.gz
-source_hash = 17b6f705963418cdb9927482fa304bc562ece2fdd4f616084c50b7023b435a40
-method = cargo
-
-# bump this version number on every change to meson.build or the patches:
-# v3
diff --git a/subprojects/unicode-ident-1-rs.wrap b/subprojects/unicode-ident-1-rs.wrap
deleted file mode 100644
index 0495b3912f1..00000000000
--- a/subprojects/unicode-ident-1-rs.wrap
+++ /dev/null
@@ -1,9 +0,0 @@
-[wrap-file]
-directory = unicode-ident-1.0.12
-source_url = https://crates.io/api/v1/crates/unicode-ident/1.0.12/download
-source_filename = unicode-ident-1.0.12.tar.gz
-source_hash = 3354b9ac3fae1ff6755cb6db53683adb661634f67557942dea4facebec0fee4b
-method = cargo
-
-# bump this version number on every change to meson.build or the patches:
-# v3
-- 
2.54.0


