Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CD7CAC5B9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 15:52:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3G9k-0001Z8-Nn; Mon, 29 Sep 2025 11:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3G9C-000133-9J
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:50:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v3G8s-0000cG-Ph
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 11:50:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759161019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5FZwR772WilyPlQiqTOSUvFpm4aGMNEEmbioRqmBBig=;
 b=SPVQn6RzMZSvdMU0AhGKMzJDcNTquJFUT7tLoOz1SLjuoi1COvARfx05WTAz6FUDWpMMwU
 nrOgLzpPkrSx6edZGhwpQG8l51Y9T+2QgFg2QIFbSD3LaxK4NExmiQc6SuoSygAv1V2i88
 4Ou0yo5UT2w+qfH4AK2Pk8LDA+6f3zU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-T8Vw2gNyNd6TfCVBWp0WdQ-1; Mon, 29 Sep 2025 11:50:16 -0400
X-MC-Unique: T8Vw2gNyNd6TfCVBWp0WdQ-1
X-Mimecast-MFC-AGG-ID: T8Vw2gNyNd6TfCVBWp0WdQ_1759161015
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b3fd9c9df9eso125210966b.0
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 08:50:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759161015; x=1759765815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5FZwR772WilyPlQiqTOSUvFpm4aGMNEEmbioRqmBBig=;
 b=W+GbD2iyaOUM17vQE8RYSmDgGEdiRqB7NL41m8mUSXdwnjOpFb5ZlpNhVWqhB7tbsZ
 npieNjzAj+82YTx5hWEZFGSbiHQzmZwurQD3Ak1wwSS8j9wFwZ2OtsU/KjG+yYk7qxgb
 eK+QL42q8Q4uhXHJy4yXNnXWsIAfxvyNo8XAt/twPViTnwhSXs+J3LQGUoxN8s0HW+W6
 LrkJ/J/WdSN9Fr81GlGWruHcU5V1446F1TiYfuoyVcWComUfSKCE93tBbLlH6xpeXLy7
 EEEyX3Hy2RjmZDyDj+u/JuYjSbxtcpL+fwPupyYkHico3ttlaANAJbne6wd4GD+DdIKH
 0ytg==
X-Gm-Message-State: AOJu0YxizTS9xboIdh1SCxIbD8eQSlmmce+BYXDgCEtNWtFABsr9n5wX
 hRnwErRZ8V6InzvGJXu8hBNovOEoyZaHXOlcFKEkrZboXiZULTFHebj479Luo6Etd3Zx145GUt/
 StC6ukhgr4tZKyx9BrbsRul2n4gebPrBp1JYHqrz+QvnCIiMe+xfg3edJ5pSX/E3jhdwyvNAEKs
 cZs6uu/Lg7CBNLG/kzwl858hdEmQt5XjpNwWal4Sz/
X-Gm-Gg: ASbGncv4WDFa87LnAmwceYzVGS1eo0qRU9vRcJz6RUiKOfT9Pdwxm9+HAQQRQGuOkhd
 RhlWEkf8BZ1kIP1lWX2aYkP7WXruPkp0/tNkRGT106soK1trsoumAsNXo4Ng7kb4xMXZhbe/+LM
 X8PmKorPY2yKZrjifaF0zv29HAvNb+3PeC5wfp5LCWIqE8P8eEErLY6pfuTj2kP5dbgDx2wDFgq
 eKf3UZVE3CnDJl3BW6fbQo0Np9P91z6q13jLPajNKYZ+IWZ5lKlt1j5+XUETs4nX4s3t6OHG5nO
 +I5VSMK89wg3pMFhZoqOhmKvP5eBQi/nrO3n+i5EGb10khMIxNw0hhSCj5eXIe0lYShcgas6kEq
 IILa8zSFsYyukp+VNbcW9IAJS2uV5tzGmRfOlARuDm/OO5A==
X-Received: by 2002:a17:907:c25:b0:b3f:5a00:161d with SMTP id
 a640c23a62f3a-b413562219emr116127666b.1.1759161015061; 
 Mon, 29 Sep 2025 08:50:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2Yvz6WdNce+2qmtF9I5Jdxk3mEcihUcc0DS+9V5GDIEPvrmsRxsIEiF5wXKY9ZVr9ZfOcdg==
X-Received: by 2002:a17:907:c25:b0:b3f:5a00:161d with SMTP id
 a640c23a62f3a-b413562219emr116124066b.1.1759161014597; 
 Mon, 29 Sep 2025 08:50:14 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3b74cb1e9asm454771566b.98.2025.09.29.08.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Sep 2025 08:50:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Tanish Desai <tanishdesai37@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-rust@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 13/16] log: change qemu_loglevel to unsigned
Date: Mon, 29 Sep 2025 17:49:35 +0200
Message-ID: <20250929154938.594389-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929154938.594389-1-pbonzini@redhat.com>
References: <20250929154938.594389-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Bindgen makes the LOG_* constants unsigned, even if they are defined as
(1 << 15):

   pub const LOG_TRACE: u32 = 32768;

Make them unsigned in C as well through the BIT() macro, and also change
the type of the variable that they are used with.

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/log-for-trace.h |  4 ++--
 include/qemu/log.h           | 44 ++++++++++++++++++------------------
 util/log.c                   |  2 +-
 rust/util/src/log.rs         |  2 +-
 4 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/include/qemu/log-for-trace.h b/include/qemu/log-for-trace.h
index d47c9cd4462..f3a8791f1d4 100644
--- a/include/qemu/log-for-trace.h
+++ b/include/qemu/log-for-trace.h
@@ -19,9 +19,9 @@
 #define QEMU_LOG_FOR_TRACE_H
 
 /* Private global variable, don't use */
-extern int qemu_loglevel;
+extern unsigned qemu_loglevel;
 
-#define LOG_TRACE          (1 << 15)
+#define LOG_TRACE          (1u << 15)
 
 /* Returns true if a bit is set in the current loglevel mask */
 static inline bool qemu_loglevel_mask(int mask)
diff --git a/include/qemu/log.h b/include/qemu/log.h
index aae72985f0d..7effba4da4c 100644
--- a/include/qemu/log.h
+++ b/include/qemu/log.h
@@ -14,30 +14,30 @@ bool qemu_log_enabled(void);
 /* Returns true if qemu_log() will write somewhere other than stderr. */
 bool qemu_log_separate(void);
 
-#define CPU_LOG_TB_OUT_ASM (1 << 0)
-#define CPU_LOG_TB_IN_ASM  (1 << 1)
-#define CPU_LOG_TB_OP      (1 << 2)
-#define CPU_LOG_TB_OP_OPT  (1 << 3)
-#define CPU_LOG_INT        (1 << 4)
-#define CPU_LOG_EXEC       (1 << 5)
-#define CPU_LOG_PCALL      (1 << 6)
-#define CPU_LOG_TB_CPU     (1 << 8)
-#define CPU_LOG_RESET      (1 << 9)
-#define LOG_UNIMP          (1 << 10)
-#define LOG_GUEST_ERROR    (1 << 11)
-#define CPU_LOG_MMU        (1 << 12)
-#define CPU_LOG_TB_NOCHAIN (1 << 13)
-#define CPU_LOG_PAGE       (1 << 14)
+#define CPU_LOG_TB_OUT_ASM (1u << 0)
+#define CPU_LOG_TB_IN_ASM  (1u << 1)
+#define CPU_LOG_TB_OP      (1u << 2)
+#define CPU_LOG_TB_OP_OPT  (1u << 3)
+#define CPU_LOG_INT        (1u << 4)
+#define CPU_LOG_EXEC       (1u << 5)
+#define CPU_LOG_PCALL      (1u << 6)
+#define CPU_LOG_TB_CPU     (1u << 8)
+#define CPU_LOG_RESET      (1u << 9)
+#define LOG_UNIMP          (1u << 10)
+#define LOG_GUEST_ERROR    (1u << 11)
+#define CPU_LOG_MMU        (1u << 12)
+#define CPU_LOG_TB_NOCHAIN (1u << 13)
+#define CPU_LOG_PAGE       (1u << 14)
 /* LOG_TRACE (1 << 15) is defined in log-for-trace.h */
-#define CPU_LOG_TB_OP_IND  (1 << 16)
-#define CPU_LOG_TB_FPU     (1 << 17)
-#define CPU_LOG_PLUGIN     (1 << 18)
+#define CPU_LOG_TB_OP_IND  (1u << 16)
+#define CPU_LOG_TB_FPU     (1u << 17)
+#define CPU_LOG_PLUGIN     (1u << 18)
 /* LOG_STRACE is used for user-mode strace logging. */
-#define LOG_STRACE         (1 << 19)
-#define LOG_PER_THREAD     (1 << 20)
-#define CPU_LOG_TB_VPU     (1 << 21)
-#define LOG_TB_OP_PLUGIN   (1 << 22)
-#define LOG_INVALID_MEM    (1 << 23)
+#define LOG_STRACE         (1u << 19)
+#define LOG_PER_THREAD     (1u << 20)
+#define CPU_LOG_TB_VPU     (1u << 21)
+#define LOG_TB_OP_PLUGIN   (1u << 22)
+#define LOG_INVALID_MEM    (1u << 23)
 
 /* Lock/unlock output. */
 
diff --git a/util/log.c b/util/log.c
index abdcb6b3111..41f78ce86b2 100644
--- a/util/log.c
+++ b/util/log.c
@@ -44,7 +44,7 @@ static FILE *global_file;
 static __thread FILE *thread_file;
 static __thread Notifier qemu_log_thread_cleanup_notifier;
 
-int qemu_loglevel;
+unsigned qemu_loglevel;
 static bool log_per_thread;
 static GArray *debug_regions;
 
diff --git a/rust/util/src/log.rs b/rust/util/src/log.rs
index af9a3e91234..0a4bc4249a1 100644
--- a/rust/util/src/log.rs
+++ b/rust/util/src/log.rs
@@ -142,7 +142,7 @@ macro_rules! log_mask_ln {
         let _: $crate::log::Log = $mask;
 
         if unsafe {
-            ($crate::bindings::qemu_loglevel & ($mask as std::os::raw::c_int)) != 0
+            ($crate::bindings::qemu_loglevel & ($mask as std::os::raw::c_uint)) != 0
         } {
             _ = $crate::log::LogGuard::log_fmt(
                 format_args!("{}\n", format_args!($fmt $($args)*)));
-- 
2.51.0


