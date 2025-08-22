Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6622ACA0EED
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Aug 2025 12:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1upQsJ-0005AU-Ij; Fri, 22 Aug 2025 08:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1upQrr-0004vh-2c
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:27:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1upQrl-0002Qy-It
 for qemu-devel@nongnu.org; Fri, 22 Aug 2025 08:27:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755865650;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hTzFYTlTuCIe98kYUF7OLCMB0bq8BQte/mSsm0luUmY=;
 b=KWPoCv9Wo2m+f659QlrKHtYgu8m1pUA5HcheU8E90mKJua8VVNYGw23AyVlPYWjOMc+8uP
 NriXQwA34nY0McwlPkZGwVW7KnNU+X7UVkrMy6NDvPVefV+84hVMT0K6ITMn3QigTi9jcw
 pxygUKECrMBWAzZvhKAuWjhIyaRSQnE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-UNIrPAtiMayqegaumqMWxQ-1; Fri, 22 Aug 2025 08:27:29 -0400
X-MC-Unique: UNIrPAtiMayqegaumqMWxQ-1
X-Mimecast-MFC-AGG-ID: UNIrPAtiMayqegaumqMWxQ_1755865648
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3b9e743736dso1153964f8f.3
 for <qemu-devel@nongnu.org>; Fri, 22 Aug 2025 05:27:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755865647; x=1756470447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hTzFYTlTuCIe98kYUF7OLCMB0bq8BQte/mSsm0luUmY=;
 b=EvZ0POtiK/ZD7o6D5N1HOCzQhSjibnB3BMhKOVlFxMzB24dQIvAuUzVrF6siM0MwWi
 IlFPb0Aer4l7MxS9Nriahm+kBBdi47I9aoFUCjRIw+mWAdFx/Dra+TqPfJcFCJnx9MXR
 HFdAo1QFMoAlxvq7a+h0dC5wo94CGFl4KU8WWtGgaH4PjxTEJUf38ZeMV1iYV5O9GfW8
 Prfm4HX6IJmzGQpHFKnaSVp5XO6FFIZEVYhf+IXNexkXREExH/HzmClByz5J4UCtomOm
 TRZ9Zsi8kAmnR06rjl8JC/XDbA7UkgNe+2mJB+HaVo8vceYqdumlxpKRdjfpLtB1uT+0
 +TRA==
X-Gm-Message-State: AOJu0YyNG26zsnRVm8yab8C87sMltXX6iDbuS0zPsXHnytQ2KD5tIXQ7
 Ew0vymZRnnWqmq6HLKW9uQVo1AQKpFYnhV5n/YPqfRgzAV0B99k9ZaB3A7R9isWrC+lRuZVqEK8
 i5HgUtr3YWuj1ADTW71a6p4G9KJeLTuCoKQfycDRjwOL0IW1AVXnifvkInvWa67ztOF4dQ9vX2s
 TsxmW/91WaZdiWAdl6ppT6rBqKI0nqSUm9xb02H/d4
X-Gm-Gg: ASbGnctCAN1YWSoeA925NDJ3t5YtV2Znz5azhqrm6ZfcCefHdfnnwuzIhX4q+b7nKNe
 q/Bg49lRXG0wTJUsvJl5XCaFIZTaih//BYVAMDOQsLxzF3Bl1RMLILLdk6JmCWuEeJg9xI6v1ra
 KNCEuGtwJ7OpTFnquFTE0wXipcWbKeedjXXZxgz8tSNS+cDXepd/Rzggvx1K+txNmKJd/Ny1thn
 EED137jYfeuoDPaFrj/af4Qdrr28qJ5UOWGSLkmjmhvSXyVzhZZ68/D+gVjQ0Nlu9mdd1k6ixTb
 M6ixn8t+8Z6JFBg10m7W4TndgxqhvLuklmHK4h+t/RlbtjPjBVH6ZS/O1tZ8x4fq/etZw4Fhuo7
 +TK2Grx+aVzwCodQ/IsmbHBB8U/CLEOE09M4s1I3lyw==
X-Received: by 2002:a05:6000:238a:b0:3b7:940e:6520 with SMTP id
 ffacd0b85a97d-3c5daefc7ccmr1999622f8f.18.1755865647445; 
 Fri, 22 Aug 2025 05:27:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHqEzFZGYw9kdPw23DUwJ6TL+j8Pl/O0Sxdmk/VdCqonQLsS8to6Qm+4AFMcXLFNt/bbuXIg==
X-Received: by 2002:a05:6000:238a:b0:3b7:940e:6520 with SMTP id
 ffacd0b85a97d-3c5daefc7ccmr1999596f8f.18.1755865646932; 
 Fri, 22 Aug 2025 05:27:26 -0700 (PDT)
Received: from [192.168.10.3] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c3e673ab01sm8671773f8f.18.2025.08.22.05.27.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 05:27:23 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: tanishdesai37@gmail.com, stefanha@redhat.com, berrange@redhat.com,
 mads@ynddal.dk
Subject: [PATCH 11/14] log: change qemu_loglevel to unsigned
Date: Fri, 22 Aug 2025 14:26:52 +0200
Message-ID: <20250822122655.1353197-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250822122655.1353197-1-pbonzini@redhat.com>
References: <20250822122655.1353197-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Make them unsigned in C as well, and also change the type of the variable
that they are used with.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/qemu/log-for-trace.h |  4 ++--
 include/qemu/log.h           | 44 ++++++++++++++++++------------------
 util/log.c                   |  2 +-
 rust/qemu-api/src/log.rs     |  2 +-
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
 
diff --git a/rust/qemu-api/src/log.rs b/rust/qemu-api/src/log.rs
index a441b8c1f2e..fe43e30104c 100644
--- a/rust/qemu-api/src/log.rs
+++ b/rust/qemu-api/src/log.rs
@@ -140,7 +140,7 @@ macro_rules! log_mask_ln {
         let _: Log = $mask;
 
         if unsafe {
-            (::qemu_api::bindings::qemu_loglevel & ($mask as std::os::raw::c_int)) != 0
+            (::qemu_api::bindings::qemu_loglevel & ($mask as std::os::raw::c_uint)) != 0
         } {
             _ = ::qemu_api::log::LogGuard::log_fmt(
                 format_args!("{}\n", format_args!($fmt $($args)*)));
-- 
2.50.1


