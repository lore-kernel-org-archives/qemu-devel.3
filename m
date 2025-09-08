Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3698CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 10:55:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvZSn-0006Eu-Mg; Mon, 08 Sep 2025 06:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZSm-0006ES-Bg
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:51:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uvZSX-00064T-UY
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 06:51:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757328650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=x8J5nz//wlgFUmx4FDWwiWgjAg5MJc4GfME3KmaGZBI=;
 b=Mv0ePGI6NZCJ3HgSGkAXBN657s5nZUFlHL63TsMJfn8WFms4W7nNagscK6V9yv5NS1tgUc
 j5aa7YM7Bo8LqGIvL+wdfXVXWsma22mr+/bHcp4JtSQZhThdURSHpcHLMKOAWI8ay6P1hd
 oEHr/Vb06Ldd05GQU1s2HQnnTKxFuWc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-PJW_L1JXPpGMnUwOxp78Og-1; Mon, 08 Sep 2025 06:50:49 -0400
X-MC-Unique: PJW_L1JXPpGMnUwOxp78Og-1
X-Mimecast-MFC-AGG-ID: PJW_L1JXPpGMnUwOxp78Og_1757328648
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45de13167aaso12910225e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 03:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757328647; x=1757933447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x8J5nz//wlgFUmx4FDWwiWgjAg5MJc4GfME3KmaGZBI=;
 b=czyiEbMDQG8BmIplABrqTp1lzTTT01ZDLcgeQet6VkvjLidA+KS9yHoSkWk2ANS7Tf
 kTYvLB85iNGsO5r/ergW5ocTP0OCYgPsukd/Z9IwCLHg/xa3H7eTiq3QWeMrsxK//sON
 6LWCVoDU3Ks9uR5SFeUSlL6GJcrVKLIgrUDtzTYGzjYU9Q2iAIggbUYsovVgFttGvG6M
 gGEKO4A2EbFLjLxgFWrmxaY+A4hKGC3jh46Mj/gI76x0RKDrLTl5Z7CQpR5fd2k4ZxWF
 oTfDtUPAOOUwnXVEiqMPNj5kTcy3C68cuRBl2+yRxNAKUVZjAHOFcAivlFvq9SexRrPY
 NCdg==
X-Gm-Message-State: AOJu0Yyk0O190Qd7sL3YLUt4oPpmfPS5k+uqffl/AvYC4h4ECX5/O7Um
 gOCOkX/X0GTj3RbmQB6qQcz9ZfI/ntQxx7f/2hpIz15MT2xEyKCTe+xZkuPyWLgFjOmOegs/8RY
 kue+SqSTl6gRSz/PyjMMbDGSo8vjJsMnN4lKUXSANKoqWLKNVgT8aJHHnAAgwZLEIFEpEZKqV8H
 27N4b2mRG+5VPHICo9D+Tv1y/EHoz8o5pURz/47Wby
X-Gm-Gg: ASbGncsNbLy+0vuZSABK+rVklt9n4Q9VxeWZ/7GpD7k29h1bNDZD0f7YonCIcG1KTFj
 cFO91UdpvG57K3vSZWLhqsXzRHy3ES4WqtCH5e45JXKQ18Yi0hp5qNFUnMIY/y4+V7aMJdYADO6
 Fpjk/HV7sEdSTigzmHFh94pp6314FtBzGEGQMNQRs1HKiCXxHxrZh4sAmnD14ejWSc0fuK0B2LM
 s/8CIueDl3+0fyQgPnUs28balQDukE37hxelgnOS/Iysa7M3t+jEZdpAn//ajRwTNz5semucjlv
 urKV2OZh3E3FIr5RuMQL0BXZtSGZ+OuzeAJN7m7QmfTxYbxRlt13Ep49tyVsIxrQ81yfFjC1+Fm
 xT7Tr1NCqkShAcg2Jke8ZrZboE8/aQmo6+4wEXjLcjuw=
X-Received: by 2002:a05:600c:5299:b0:45d:dd47:b45f with SMTP id
 5b1f17b1804b1-45dddef7fdamr57438565e9.31.1757328647208; 
 Mon, 08 Sep 2025 03:50:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCDsgxXqY38iNcr5eqr1kmwv/MrVEkZ6i5JAyzdu/o037nJZJoqP3apuIC8R+14a8em3HbfQ==
X-Received: by 2002:a05:600c:5299:b0:45d:dd47:b45f with SMTP id
 5b1f17b1804b1-45dddef7fdamr57438325e9.31.1757328646733; 
 Mon, 08 Sep 2025 03:50:46 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45dd064003dsm87549055e9.6.2025.09.08.03.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 03:50:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 17/33] rust: make build.rs generic over various ./rust/projects
Date: Mon,  8 Sep 2025 12:49:49 +0200
Message-ID: <20250908105005.2119297-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250908105005.2119297-1-pbonzini@redhat.com>
References: <20250908105005.2119297-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Guess the name of the subdir from the manifest directory, instead of
hard-coding it. In the following commits, other crates can then link to
this file, instead of maintaining their own copy.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Link: https://lore.kernel.org/r/20250827104147.717203-5-marcandre.lureau@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/build.rs | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/rust/qemu-api/build.rs b/rust/qemu-api/build.rs
index 29d09456257..5654d1d5624 100644
--- a/rust/qemu-api/build.rs
+++ b/rust/qemu-api/build.rs
@@ -9,12 +9,14 @@
 use std::{env, fs::remove_file, io::Result, path::Path};
 
 fn main() -> Result<()> {
+    let manifest_dir = env!("CARGO_MANIFEST_DIR");
     let file = if let Ok(root) = env::var("MESON_BUILD_ROOT") {
-        format!("{root}/rust/qemu-api/bindings.inc.rs")
+        let sub = get_rust_subdir(manifest_dir).unwrap();
+        format!("{root}/{sub}/bindings.inc.rs")
     } else {
         // Placing bindings.inc.rs in the source directory is supported
         // but not documented or encouraged.
-        format!("{}/src/bindings.inc.rs", env!("CARGO_MANIFEST_DIR"))
+        format!("{manifest_dir}/src/bindings.inc.rs")
     };
 
     let file = Path::new(&file);
@@ -41,3 +43,7 @@ fn main() -> Result<()> {
     println!("cargo:rerun-if-changed=build.rs");
     Ok(())
 }
+
+fn get_rust_subdir(path: &str) -> Option<&str> {
+    path.find("/rust").map(|index| &path[index + 1..])
+}
-- 
2.51.0


