Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2CC2C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZ11-0002Et-PF; Tue, 15 Jul 2025 02:19:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubYxH-0007ti-Bz
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:16:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubYxF-0006Q1-0y
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:15:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752560152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uh429H/7Fd0JqSjaTv4ix/gvZDdMnAIxIzaDOJCmbvQ=;
 b=hwURKt0FtSPmbu7RHJs/flD5bH+Ixxk1Zell+3gCkeq5ZDImCQGDUBYSYa4VFXB018VyU5
 XCJEov77vAdAmbRL7gI1g4qIiNCN30UmUZfIB5AtjCxdegEaA8gnSvTa++Wtv9srizHbzf
 axYsX7WB7ezImckWC96zcCZlRhgk/LE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-212-nplSoFjsPUijz8H--n0QPA-1; Tue, 15 Jul 2025 02:15:50 -0400
X-MC-Unique: nplSoFjsPUijz8H--n0QPA-1
X-Mimecast-MFC-AGG-ID: nplSoFjsPUijz8H--n0QPA_1752560149
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4e9252ba0so2978672f8f.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752560149; x=1753164949;
 h=content-transfer-encoding:content-disposition:mime-version
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uh429H/7Fd0JqSjaTv4ix/gvZDdMnAIxIzaDOJCmbvQ=;
 b=XdSzoMc+4zu5naTXNS2DT6aCHBavNRvOGTM/WkDys2FSJ15Uwni8SeSL8+ymD8J/IQ
 /9rWJg+j0sS+LVY0upvCQsR8TAeB/zNwuOtQxuSr/sW0333kJ+KLswy0Co+FZ9et8krB
 nxuhbft1qLRL8CmcmC1oS/Kf4lk9GEredqUrCk+i9Ya9QbN2eiSQF/afgoOcPYijdASw
 XS1Yp+H74yHd2HPASwq0PPXP0hRR07+kr58N0v8K10tIRfCw26yn8UrvsQ4wTYThFCTO
 f0UXSzTYz6h4QVkWb4qKxStZsB0+ar4xUeulb/305PDA31kj4ymczBr+E6fuFOIam/sN
 E9Og==
X-Gm-Message-State: AOJu0YxrwdJ0Swkzy9kT5BPb68Ecz2VJ1AV8+8xfX7F9wCt1hOWLjaXm
 Buoy8lUZB+cJEoOg5hD32/3j3l9E2I50Pb8r1BI+Sw3NPLEcN78cwCwIRT8wvsyoisiQZlIei9G
 78Z4T79eUbbmAp8QARfirG/p8ZwcxB71T4pZrZI9SWf+zUVVqCyr8khN9dGdG/LtxbDgWM+eNff
 DdAQmLtOqKRwqI60x1rOv20rmpXWPnUV2ngQ==
X-Gm-Gg: ASbGncvtNLav70m5ruV3Jy7m3dv1cB74tvEOXwDRylkjU+aWkxS64HeIrxJoFmA0aak
 ZnMy2gOad+CRZZ8H6ubyp4BnIDOuzdjGtau2cOeaiUHzJpxhnk/vrFNXOTzUWj5JFrYz2Yks58N
 tQ5ovA8vlo4WlSqpuZy6Fp/sTMFmzaPqZyumL+sG6ruF7/34a7e4q1q7T8X0FofnlsKQF5YuMgu
 XCOvWuphrYI7f35+nlMjzUlho2RB1q/OdN99xsy6TYGbpUMLEXEjraS4TIJW2oCbwnB7uHiJHc2
 JJk/9dVywS5BcGsV3li86wmUU7TLsreW
X-Received: by 2002:a05:6000:43d5:b0:3a5:2ec5:35a3 with SMTP id
 ffacd0b85a97d-3b5f18e82d8mr9966104f8f.45.1752560149036; 
 Mon, 14 Jul 2025 23:15:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT7GVM6dTzSOuN6/p9UJaJmmDrydVcqite4GPEEar6R+66sVnawTLQMMxaVABg+N3sQ/W1vA==
X-Received: by 2002:a05:6000:43d5:b0:3a5:2ec5:35a3 with SMTP id
 ffacd0b85a97d-3b5f18e82d8mr9966084f8f.45.1752560148565; 
 Mon, 14 Jul 2025 23:15:48 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e269a0sm14045211f8f.86.2025.07.14.23.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 23:15:48 -0700 (PDT)
Date: Tue, 15 Jul 2025 02:15:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org
Subject: [PATCH v2] rust: bindings: allow any number of params
Message-ID: <e41344bd22248b0883752ef7a7c459090a3d9cfc.1752560127.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

We are going to be adding more parameters, and this makes
rust unhappy:
    Functions with lots of parameters are considered bad style and reduce
    readability (“what does the 5th parameter mean?”). Consider grouping
    some parameters into a new type.

Specifically:

error: this function has too many arguments (8/7)
    --> /builds/mstredhat/qemu/build/rust/qemu-api/rust-qemu-api-tests.p/structured/bindings.inc.rs:3840:5
     |
3840 | /     pub fn new_bitfield_1(
3841 | |         secure: std::os::raw::c_uint,
3842 | |         space: std::os::raw::c_uint,
3843 | |         user: std::os::raw::c_uint,
...    |
3848 | |         address_type: std::os::raw::c_uint,
3849 | |     ) -> __BindgenBitfieldUnit<[u8; 4usize]> {
     | |____________________________________________^
     |
     = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#too_many_arguments
     = note: `-D clippy::too-many-arguments` implied by `-D warnings`
     = help: to override `-D warnings` add `#[allow(clippy::too_many_arguments)]`

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 rust/qemu-api/src/bindings.rs | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/rust/qemu-api/src/bindings.rs b/rust/qemu-api/src/bindings.rs
index 057de4b646..c4f1f755ce 100644
--- a/rust/qemu-api/src/bindings.rs
+++ b/rust/qemu-api/src/bindings.rs
@@ -13,7 +13,8 @@
     clippy::missing_const_for_fn,
     clippy::ptr_offset_with_cast,
     clippy::useless_transmute,
-    clippy::missing_safety_doc
+    clippy::missing_safety_doc,
+    clippy::too_many_arguments
 )]
 
 //! `bindgen`-generated declarations.
-- 
MST


