Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2D3D59D99
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Dec 2025 07:51:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vV3M6-0000lF-KQ; Mon, 15 Dec 2025 02:50:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vV3Lb-0000bt-Is
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:50:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vV3La-0000mU-3F
 for qemu-devel@nongnu.org; Mon, 15 Dec 2025 02:50:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765785021;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DPzOYGOdSS2nqdUVmE3Appt8FioAsNxMPjypO5wkIkE=;
 b=FyrEag3K3VF4p1wAuyPulpAdgG8pa4nL68QeIJzPfyrXj9e+wuyetKY9dvEn3MPkeZ9nyp
 4E4gHbgCt1pQrL4cvkVzfR7a4ZdGTmSnto5X473UM1D8Us48xioTSNS1e4A+Pqn2ki+rtV
 leXril7HOBKM4Lmy4tJt2u4Dz6ggu6U=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140--hFRVLgJMPm3PP2Q3GUCdw-1; Mon, 15 Dec 2025 02:50:19 -0500
X-MC-Unique: -hFRVLgJMPm3PP2Q3GUCdw-1
X-Mimecast-MFC-AGG-ID: -hFRVLgJMPm3PP2Q3GUCdw_1765785018
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-430fcb6b2ebso414461f8f.2
 for <qemu-devel@nongnu.org>; Sun, 14 Dec 2025 23:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765785016; x=1766389816; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DPzOYGOdSS2nqdUVmE3Appt8FioAsNxMPjypO5wkIkE=;
 b=YMs/Fg4jUGRm87fgou4XR/Bhrrleyr1EP8Xv3B2BcnY4oXeLfgNSpFpk/OHr9wHz6q
 SQ4BHFNujcWzeyFquq+xc54K7IlN2qqwfDvucnm+Os7n+D+WKeQB8kw/wGd2qu/IGyDI
 /hEsPNTzUNCf75sLMCBH5xihMnHF1OXN+L+DB7DiqlQ2H+i+tHLdeOnuSslotreFjno2
 kLNHTP3LpVD5JF0VMljsDo2rHBH9NkL+W3Um2ZCE6ze5fPWftbLT8wEMWv2rayVIqRN3
 wsbOpDlxkTrFVSRC+x2w5rUZEGKvxv80WqQquADqMZKl+Nlh0rywPYb7fS4xMgm0CDX4
 HSBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765785016; x=1766389816;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DPzOYGOdSS2nqdUVmE3Appt8FioAsNxMPjypO5wkIkE=;
 b=h0g/gP05axahD3W825pT6fz5iVavfEoLtrZWkGSp1y2OsJHeEo9y/Qly50PZkAULDE
 WALsdT4gONdMAxRB1nUSzeu+qjCvuf7jmH61LYdQuBspjC/n3TcYiMKEGXA/0MBZVg47
 W8vd2o1J1crBhdRegxmWbguVEEmPuGnNVvunAPyowcbQrd5Jcljw0MLW5ZEp0zc/tp0K
 RUBzqbGrMfD+W1XtH3a+/5J/+d/WrIhhOW/MsuSkDCfEfx8PdkW5fGnnJfhjFAuSJNNx
 KER3DbDQw7Ov2c6iLr76FV+k+9L1WmouOFlv17WgGenj1KoipdeakRW2ZShn1ZgjGfv5
 ciiw==
X-Gm-Message-State: AOJu0Ywl3F5Qq1AyQiNwBBpYbZKgFuQt0mpOBTuCqOCd2R7Q+s5Eqy3i
 s19h2wt7/gJXLDB/47AnSo0xmdEEk+pTpvat+jl/FlJY5LLetK/QsaGQ0VTr7LspyHZVlb1rqqV
 Iywk4KfdrU/+UbiO6F2g/b4OPPpvc06SBa0k+JY+KmdAXkBaUEc2ysd9CnFci/3gWx/fv6hUUz+
 67AWx0r9QxW1NXgne0GfQtJRsCAqGqaNqXufDEARam
X-Gm-Gg: AY/fxX6M5V/A2v7uomLEbfPv8A2Fs9jZiBot3VTdFiAENUfpMe66cdggEwURpi8qoA7
 lMKxPkIiYZ1bbaUAiG1zkbBL/ow2cxfYm4AsYtwt2QKKmvpVY9kZWfQYYvNi9ko8CIv1RjpA8OP
 y65G8bPw2ZKTc3GgiUasimgZlKHu9/0KGjBAtUdH+xeOE2cRq+o7HpP1DzPcwHrjhcPkQJbsvEu
 ZKyarFiDcidlRNRUQ1oijc4qDO/eMmfV1ZCZ5AgdKedyW06I1HKWpK0rBIh+iZQvIpABNMQc9M7
 ZV4Gch+dMeG93kdvYnDG4gwHyOzRqTpXBPPTe92WXGypH4PZ2NELlsDW6Y4l+VwOunwsLp/MKkE
 +YavDWw2uoHYZjWGM/8Q6kGj3e0NJGOXD9Sk/YfK7YgmIEd43k5v7w69IbY7i7qlz/YD8gJ3eK2
 JBTt6OnrynZ3WdVQA=
X-Received: by 2002:a5d:5f91:0:b0:431:53:1f49 with SMTP id
 ffacd0b85a97d-431005325c2mr859102f8f.41.1765785016244; 
 Sun, 14 Dec 2025 23:50:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVf+fWNJzbUzqsCwn5/tL5jAU1Nzlfoy2ugnNqNplrJxc7rJ26wxp+hA28DEWucIkVMS2sQQ==
X-Received: by 2002:a5d:5f91:0:b0:431:53:1f49 with SMTP id
 ffacd0b85a97d-431005325c2mr859076f8f.41.1765785015766; 
 Sun, 14 Dec 2025 23:50:15 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-430f268d459sm12450206f8f.32.2025.12.14.23.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Dec 2025 23:50:14 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	marcandre.lureau@redhat.com
Subject: [PATCH 05/11] rust: only link the Rust part of the code into devices
Date: Mon, 15 Dec 2025 08:49:54 +0100
Message-ID: <20251215075000.335043-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215075000.335043-1-pbonzini@redhat.com>
References: <20251215075000.335043-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Do not include libqemuutil in the device crates for the same
reason as in the previous commit.  Static libraries like qemuutil
are sensitive to their position on the command line and rustc does not
always get it right.

If rustc places the library too early on the command line, the stubs
are included in the final link product, which results in duplicate
symbols.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/char/pl011/meson.build | 18 ++++++++++--------
 rust/hw/timer/hpet/meson.build | 18 +++++++++---------
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/rust/hw/char/pl011/meson.build b/rust/hw/char/pl011/meson.build
index 33b91f21911..9c0e8290e9a 100644
--- a/rust/hw/char/pl011/meson.build
+++ b/rust/hw/char/pl011/meson.build
@@ -28,20 +28,22 @@ _libpl011_rs = static_library(
   ),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
+  link_with: [
+    _util_rs,
+    _migration_rs,
+    _bql_rs,
+    _qom_rs,
+    _chardev_rs,
+    _system_rs,
+    _hwcore_rs,
+    _trace_rs
+  ],
   dependencies: [
     bilge_rs,
     bilge_impl_rs,
     bits_rs,
     common_rs,
     glib_sys_rs,
-    util_rs,
-    migration_rs,
-    bql_rs,
-    qom_rs,
-    chardev_rs,
-    system_rs,
-    hwcore_rs,
-    trace_rs
   ],
 )
 
diff --git a/rust/hw/timer/hpet/meson.build b/rust/hw/timer/hpet/meson.build
index 9a3dd62caa3..3bb7ce2a6ca 100644
--- a/rust/hw/timer/hpet/meson.build
+++ b/rust/hw/timer/hpet/meson.build
@@ -3,16 +3,16 @@ _libhpet_rs = static_library(
   files('src/lib.rs'),
   override_options: ['rust_std=2021', 'build.rust_std=2021'],
   rust_abi: 'rust',
-  dependencies: [
-    common_rs,
-    util_rs,
-    migration_rs,
-    bql_rs,
-    qom_rs,
-    system_rs,
-    hwcore_rs,
-    trace_rs,
+  link_with: [
+    _util_rs,
+    _migration_rs,
+    _bql_rs,
+    _qom_rs,
+    _system_rs,
+    _hwcore_rs,
+    _trace_rs,
   ],
+  dependencies: [common_rs],
 )
 
 rust_devices_ss.add(when: 'CONFIG_X_HPET_RUST', if_true: [declare_dependency(
-- 
2.52.0


