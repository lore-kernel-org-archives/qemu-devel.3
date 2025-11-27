Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90B7D111A8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObvy-0005hv-9s; Thu, 27 Nov 2025 08:21:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObvU-0005MT-9P
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:20:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObvQ-000241-OW
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:20:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LYg5lNnE8rdhG0r9RcJgUpFFZd7vvBdLGPpZf4aLMBU=;
 b=GbYTn2JGCsEdlzt+OdISvtRFsX14efs4z3g3BTv5APCF1e2bg/i6k7bSGxEszgxnw9T8p6
 OpVICyoLD0ATrrZkcTsWoy2ReFTekHh+dRl6an72RGHi1ZKovvbhhUu15tawJRiJerIutT
 qrtPCJJID8Ic/rXDpFJR/wSRz38WKGw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-9CGedM83MyKZpxv8stZGHg-1; Thu, 27 Nov 2025 08:20:42 -0500
X-MC-Unique: 9CGedM83MyKZpxv8stZGHg-1
X-Mimecast-MFC-AGG-ID: 9CGedM83MyKZpxv8stZGHg_1764249641
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b735efd650fso98395566b.0
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249640; x=1764854440; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LYg5lNnE8rdhG0r9RcJgUpFFZd7vvBdLGPpZf4aLMBU=;
 b=MpDhZLfAlB1b5/n37BNvcul7QBDVKIMOfQrnlHWcmEkZxRGDFkRbeLp7BKVt7QyH9G
 9UWf26JlXqqLKqySEhgcuT25dVQ4vNkt67P9QfBwHM/AUYCwk0FXbe+MXlDkM3hWIhzX
 H1UQJx3iaV1jCdsNQMwdeI9QwU257A3jjh8HAAcjCa9LZVu8eicFAniW/3Lsj149Yeu5
 Vq0eMBuzMxC0fM5kcLatoYypXq9tyqBgTVtnWEbZ8yqGNdVXBA4IISGZUFM1rPVDSnDU
 7j4xTPH8/yqA3pFECeRuueUNjT5P+Y0s0XWbtKqiriuEv6MWftZXr6mP4mu+jUKKkk27
 xduw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249640; x=1764854440;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LYg5lNnE8rdhG0r9RcJgUpFFZd7vvBdLGPpZf4aLMBU=;
 b=tG/mDp045qpiZMoZZ2/fk0VzebWR55kNIOrp1F/grAkyjGxKWXSicKP4anPwcVAPlA
 /2bloX8IrOlgwP6/klVggQER6B0tztyFysf3TLMnuzDsizJyWJtJxwm5Dx2p8Y98DooZ
 0xj8RuPM8eS44vzVmAE8zdl+Z3ZqGatQ3c6LuRwmHs6Wya6Iq8aVEei9V8iIboYJ+jOe
 qzKBTh9xHubW6BJhpWIJuaL1tbKkPuJ3EIfjD+p3JZzEcz18ZRN3njojEYjTCVn7/f0B
 fU8uFWsDEtwT6cnJaNELXZCjykWS/5IUZBYUqMge4opiE57bHXJJPSVcnPRdYLVMb9dn
 sadw==
X-Gm-Message-State: AOJu0YxsXV2RAIPBbjA8uQYj3ehb4XgcYiugsMLZVo729yAYMLE+D6Jw
 BKAfLnVTN2Fl2t5lTKB6zdD3EBU+iAyf+ShiSEe11u6TCXyMR/Jlg4bhYVioMP0RxRPXm178Puc
 Hhg6lzDRqIYaqs+q/8k9M/0nwNlcfSDdv8tIxhpX5D1K/qh0VteBoRxDdnzBFC1Y3IdGFWAcf1j
 ponNBqTTEakmiOmKGHdN+ht5bFfdtu1zaprzaGg8CU
X-Gm-Gg: ASbGncuBoBekgO29Q9E31xJlvW7rexk9obGIJSojSx7/1MpASa7Lbi19zuAZvnAF43a
 jb/sAwxCJJ6GzpvgNbpuMR21s1A6UbzOnd45Gk6cH/vpvKF8o+NySMZIsJnNFbguhZXVWB66rL/
 gnhIV7sKgjq7sT69glpFA8JzCnoEwRdu60TQI6Zq4WRqV9T+bldFgmW0ZXQAvM+prqsoqU5/nLV
 CVz6QccBJzJu+gyQ2REIua+C0TW0LWp25YM/uXHpTMvn3xbQc3ZZk9W/MGQOaf2b17MD4czWeUI
 2cxiA8Q08FGh77RqR6PJYYUo/LvMKYRrNAAMOqmCYNOlJJvOkyhWACFgFHeITk5F3jKyv6Asm/n
 XqENv37CQPjGqOZEkAyk3cNMz8WqAYtkM3BXdqn43DYtwTGT+qIX5pwS3kYfvr1ZeBrH8x57nYD
 Sf0QZJiYFq+Gpdyws=
X-Received: by 2002:a17:907:3f9c:b0:b73:7f1c:b8d8 with SMTP id
 a640c23a62f3a-b767129709dmr2419811166b.0.1764249640040; 
 Thu, 27 Nov 2025 05:20:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdU8wOIJQbd2oYcYyBfq7uZVilQhWmJGvPR4ghgRuCUqWn8gCp1QyRanWVKr5t1pCEGhNRVA==
X-Received: by 2002:a17:907:3f9c:b0:b73:7f1c:b8d8 with SMTP id
 a640c23a62f3a-b767129709dmr2419806566b.0.1764249639532; 
 Thu, 27 Nov 2025 05:20:39 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b76f5a48c7bsm160575166b.64.2025.11.27.05.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:20:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 1/9] rust: remove leftover bindings/
Date: Thu, 27 Nov 2025 14:20:28 +0100
Message-ID: <20251127132036.84384-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251127132036.84384-1-pbonzini@redhat.com>
References: <20251127132036.84384-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 rust/bindings/src/lib.rs | 64 ----------------------------------------
 1 file changed, 64 deletions(-)
 delete mode 100644 rust/bindings/src/lib.rs

diff --git a/rust/bindings/src/lib.rs b/rust/bindings/src/lib.rs
deleted file mode 100644
index 4c9bb794f79..00000000000
--- a/rust/bindings/src/lib.rs
+++ /dev/null
@@ -1,64 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-#![allow(
-    dead_code,
-    improper_ctypes_definitions,
-    improper_ctypes,
-    non_camel_case_types,
-    non_snake_case,
-    non_upper_case_globals,
-    unsafe_op_in_unsafe_fn,
-    clippy::pedantic,
-    clippy::restriction,
-    clippy::style,
-    clippy::missing_const_for_fn,
-    clippy::ptr_offset_with_cast,
-    clippy::useless_transmute,
-    clippy::missing_safety_doc
-)]
-
-//! `bindgen`-generated declarations.
-
-#[cfg(MESON)]
-include!("bindings.inc.rs");
-
-#[cfg(not(MESON))]
-include!(concat!(env!("OUT_DIR"), "/bindings.inc.rs"));
-
-// SAFETY: these are implemented in C; the bindings need to assert that the
-// BQL is taken, either directly or via `BqlCell` and `BqlRefCell`.
-// When bindings for character devices are introduced, this can be
-// moved to the Opaque<> wrapper in src/chardev.rs.
-unsafe impl Send for CharFrontend {}
-unsafe impl Sync for CharFrontend {}
-
-// SAFETY: this is a pure data struct
-unsafe impl Send for CoalescedMemoryRange {}
-unsafe impl Sync for CoalescedMemoryRange {}
-
-// SAFETY: these are constants and vtables; the Send and Sync requirements
-// are deferred to the unsafe callbacks that they contain
-unsafe impl Send for MemoryRegionOps {}
-unsafe impl Sync for MemoryRegionOps {}
-
-unsafe impl Send for Property {}
-unsafe impl Sync for Property {}
-
-unsafe impl Send for TypeInfo {}
-unsafe impl Sync for TypeInfo {}
-
-unsafe impl Send for VMStateDescription {}
-unsafe impl Sync for VMStateDescription {}
-
-unsafe impl Send for VMStateField {}
-unsafe impl Sync for VMStateField {}
-
-unsafe impl Send for VMStateInfo {}
-unsafe impl Sync for VMStateInfo {}
-
-// bindgen does not derive Default here
-#[allow(clippy::derivable_impls)]
-impl Default for VMStateFlags {
-    fn default() -> Self {
-        Self(0)
-    }
-}
-- 
2.51.1


