Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646A8D64074
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 18:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9TJI-000224-6z; Fri, 08 Nov 2024 13:02:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9TJE-0001wS-RI
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 13:02:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t9TJB-0001xJ-65
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 13:02:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731088928;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yguWnQXG15f2x+f4QNRnXEOFJJORIkMpafNaeGv6vH0=;
 b=CqECri+hqeXvWkaICgd2V3sFrPZ2pxuon8uqa78nHxw4EM/UUIRKuVEQS1sRWLLTa0n61O
 rzAQt1HpD+D0HzqjumIalHo7LQOKABiBjpLvcxtEm6q42GWeqHU0RgcS0bf5mqBaZRcsnr
 +aLsoQtFCU6bF5HwXZZPIb2kWLx8Bo0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-QdOMtPJ3NEuQr7td3br4jQ-1; Fri, 08 Nov 2024 13:02:07 -0500
X-MC-Unique: QdOMtPJ3NEuQr7td3br4jQ-1
X-Mimecast-MFC-AGG-ID: QdOMtPJ3NEuQr7td3br4jQ
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43159603c92so16424105e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 10:02:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731088926; x=1731693726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yguWnQXG15f2x+f4QNRnXEOFJJORIkMpafNaeGv6vH0=;
 b=VC5Gahk84xYvcrUiB85QXD/GxPoOrzRvkxgR4IrIhoSlZASQ1/Ly/e5t2cHzYw9dRE
 G9rpYuaCascW6ncsUht7mwQcBQhD/tTEsEDDfaFYgDTg/7aoguJ00FQSfYe6ePTzTmIv
 2ojeszryw4Ngh6cPcOQXtpKQ8fD9/vOfKUN0czVDtbBR2kW2Vne3tkfghLCiRqeamo2V
 gmEAWFkN1e/jqA4o4A5fMg6aC4UXSSgj9qBG+yMLH2srWayly1PWim+HT6YNaEAuLOwk
 rJXy5LSa7jkB3lAz+SFFk2aeVLigsviI0IOv7hMmaEXbkq5aL2LhK4EW6H2k2KtNJsdj
 Z+UA==
X-Gm-Message-State: AOJu0YwH2KDldrQdErDzmczj3Qg48gFq0sY0L0A8h8jPF4j2bCG28P45
 tDn0aiIRFNbf5KQvy1XVqoGowtghidOlafZQLlmwSrQmaIESHWCq/qnfebghSx0cr/kvovvTrz1
 V8aJxuBAatulOr2ynJDtTR07jxtKAeORs+qXMpMe2vcKW3YiPRHnzaZL5O77atjmOtRXzaB+ZZw
 2FBJEjmDdnh2lpT4VU3hcoP2DsYGosQePFW2TW1+E=
X-Received: by 2002:a05:6000:1869:b0:381:f0ce:d09e with SMTP id
 ffacd0b85a97d-381f18635f4mr3179841f8f.7.1731088925924; 
 Fri, 08 Nov 2024 10:02:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHI1VHnlt4sb0wupEKO0ihKDfs7+WzKbqgIge8H1VNg5+78Gte/1/HoI29L4264/OuICIyW1A==
X-Received: by 2002:a05:6000:1869:b0:381:f0ce:d09e with SMTP id
 ffacd0b85a97d-381f18635f4mr3179788f8f.7.1731088925418; 
 Fri, 08 Nov 2024 10:02:05 -0800 (PST)
Received: from [192.168.10.47] ([151.49.84.243])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381ed99a34bsm5458399f8f.54.2024.11.08.10.02.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 10:02:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: manos.pitsidianakis@linaro.org, kwolf@redhat.com, junjie.mao@hotmail.com,
 zhao1.liu@intel.com, qemu-rust@nondevel.org
Subject: [RFC PATCH 09/11] rust: build: add "make clippy", "make rustfmt"
Date: Fri,  8 Nov 2024 19:01:37 +0100
Message-ID: <20241108180139.117112-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241108180139.117112-1-pbonzini@redhat.com>
References: <20241108180139.117112-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Abstract common invocations of "cargo", that do not require copying
the generated bindgen file or setting up MESON_BUILD_ROOT.

In the future these could also do completely without cargo and invoke
the underlying programs directly.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/meson.build       | 14 ++++++++++++++
 rust/qemu-api/build.rs |  8 ++++++--
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/rust/meson.build b/rust/meson.build
index def77389cdd..6fa0fd54527 100644
--- a/rust/meson.build
+++ b/rust/meson.build
@@ -2,3 +2,17 @@ subdir('qemu-api-macros')
 subdir('qemu-api')
 
 subdir('hw')
+
+cargo = find_program('cargo')
+
+run_target('clippy',
+  command: [config_host['MESON'], 'devenv',
+            '--workdir', '@CURRENT_SOURCE_DIR@',
+            cargo, 'clippy', '--tests'],
+  depends: bindings_rs)
+
+run_target('rustfmt',
+  command: [config_host['MESON'], 'devenv',
+            '--workdir', '@CURRENT_SOURCE_DIR@',
+            cargo, 'fmt'],
+  depends: bindings_rs)
diff --git a/rust/qemu-api/build.rs b/rust/qemu-api/build.rs
index e4eab718553..d7b6d76828b 100644
--- a/rust/qemu-api/build.rs
+++ b/rust/qemu-api/build.rs
@@ -15,8 +15,12 @@ fn main() {
     let file = format!("{}/bindings.rs.inc", path);
     if !Path::new(&file).exists() {
         panic!(concat!(
-            "No generated C bindings found! If you want to run `cargo`, start a subshell\n",
-            "with `meson devenv`, or point MESON_BUILD_ROOT to the top of the build tree."
+            "\n",
+            "    No generated C bindings found! To run clippy or rustfmt, you can use\n",
+            "    `make clippy` or `make rustfmt`.\n",
+            "\n",
+            "    For other uses of `cargo`, start a subshell with `meson devenv`, or\n",
+            "    point MESON_BUILD_ROOT to the top of the build tree."
         ));
     }
 
-- 
2.47.0


