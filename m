Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149FCCA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:32:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNOb-0003zJ-IL; Sat, 30 Aug 2025 11:21:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us14i-0001nh-El
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 11:31:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1us14c-0000V4-4V
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 11:31:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756481488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EsZtj6B4xNxRbWQ2j10KIrPfvYq1rdhUBi92bjvMMmM=;
 b=M54fA2GZmlWqH1cGEh/IydbM6QeXHH8Ny/cmEWFj0WS2O6uf7BhBxzxGQYn2W8BwNCInL0
 UEYUnErihKCfavZrKGv39EXw3huC3CxmIZHv87tCvw4JEA/CG1dno64R5ERUjHF+025wCl
 7mi7o50xCWADHRalOUGckFvDUkQR8P8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-CSDzsGIjMRG3MmLPlKuLpw-1; Fri, 29 Aug 2025 11:31:26 -0400
X-MC-Unique: CSDzsGIjMRG3MmLPlKuLpw-1
X-Mimecast-MFC-AGG-ID: CSDzsGIjMRG3MmLPlKuLpw_1756481484
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-45b71fe31ffso12933055e9.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 08:31:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756481484; x=1757086284;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EsZtj6B4xNxRbWQ2j10KIrPfvYq1rdhUBi92bjvMMmM=;
 b=fAEnEO8pxj6cLbc8npRRDn74e3B6TpSQhgeqPtL9qUm0g4KYKDaT3/tynP51EVBbY4
 ppGbtPrfr31CorjbCR8MJjJJlK/GTGEBtpbvUV8w14RcGhqXJ29hNKcKMZM7KteXIIek
 dX5u95prMSIoCx5vIgDU2JtN124EoIzEGm23+V/g4miGfdh3P4MH7Wj32sUNpYwUgrat
 hf16j0S8ZaeVcEZ39cxCo+RPeXf1HbIFhrmLHZTnDBRAoSNDzWPWJzuA2xIgLtW35Arw
 ExQ2vD7sQtuv6rQPn+zFfReQ25Q5cqKrTIoUjc65apC4cSHLL/XT4MyM0ixTUcVK+gkd
 6wew==
X-Gm-Message-State: AOJu0YyrcIEIaOpAmu7rZLw8bW7SXQ4WOA7Q+3VPz0bjtckaCAGSlV8c
 nGjr/N8TC9EneN+2nQPlo9v7uaYSn2YSRGP2fT1+QBRMamXE1PyglY3VfLS+SuMRMlMUFG2lpdl
 ny7JpTQTneOZOb792S5oAImQeiZKBesQjKNGPH23l9UNF9GHouLcgBm0FbNWygs+aSIB5CzNT+4
 y8FWGl5AWMmsPEFm3u8GaZw7tP0RvHHiW6dDiUXODo
X-Gm-Gg: ASbGncsnH/NH246W+Eb3EqoFSyn74quQVroXWSvtK7fsOC1vD8XRWdobAJ8Yi14cptD
 rTKD4oG1OsjCaRw4+dEXlTZ8gBxHJy6BJctNTslt8lnhJIMjWYXYSA9QcIgQUvtLIbYVh+C5HV4
 JwrOfjNdX80oOqaXS2SEKYob59CPgxAARYJhM/cnLzVprtJz3EWI3ebwPQLJ8gMvwLpUqT7EKml
 UH9YixhcPeJU+a99JRUcyAaOSQf1CbEDm+luFSupT+o3A8ApgPeGi+A0UP/12MXd5r6CLAd19Kz
 nJpPVW141H6jAJlFtV2Plqnl7dOkyOSnTMxj6Pse1D/fljoNyVmyM+YCcF6V+lTeSv1Iz4xu3FK
 8nHbW1277znltjdJVcqywCVlZ0APbLhcNNJpVktb+Llo=
X-Received: by 2002:a05:600c:3b8b:b0:45b:7951:92a2 with SMTP id
 5b1f17b1804b1-45b795195c9mr54607835e9.18.1756481483626; 
 Fri, 29 Aug 2025 08:31:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH45wRzNb7t0IxQi75lcnXmWWtTjS7Pv6ApygqocKPXnWv0MkgD33L8EbCi5JtzBKvDyJaTUw==
X-Received: by 2002:a05:600c:3b8b:b0:45b:7951:92a2 with SMTP id
 5b1f17b1804b1-45b795195c9mr54607495e9.18.1756481483080; 
 Fri, 29 Aug 2025 08:31:23 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3d0c344f6casm2718163f8f.36.2025.08.29.08.31.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 08:31:20 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com,
	richard.henderson@linaro.org,
	imammedo@redhat.com
Subject: [PATCH 07/18] cpu-common: use atomic access for interrupt_request
Date: Fri, 29 Aug 2025 17:31:04 +0200
Message-ID: <20250829153115.1590048-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250829152909.1589668-1-pbonzini@redhat.com>
References: <20250829152909.1589668-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Writes to interrupt_request used non-atomic accesses, but there are a
few cases where the access was not protected by the BQL.  Now that
there is a full set of helpers, it's easier to guarantee that
interrupt_request accesses are fully atomic, so just drop the
requirement instead of fixing them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/core/cpu.h |  1 -
 hw/core/cpu-common.c  | 12 +-----------
 system/cpus.c         |  3 +--
 3 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index b01a0cffd64..23bd02277f4 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -495,7 +495,6 @@ struct CPUState {
     bool exit_request;
     int exclusive_context_count;
     uint32_t cflags_next_tb;
-    /* updates protected by BQL */
     uint32_t interrupt_request;
     int singlestep_enabled;
     int64_t icount_budget;
diff --git a/hw/core/cpu-common.c b/hw/core/cpu-common.c
index 39e674aca21..9ea1f3764a8 100644
--- a/hw/core/cpu-common.c
+++ b/hw/core/cpu-common.c
@@ -67,19 +67,9 @@ CPUState *cpu_create(const char *typename)
     return cpu;
 }
 
-/* Resetting the IRQ comes from across the code base so we take the
- * BQL here if we need to.  cpu_interrupt assumes it is held.*/
 void cpu_reset_interrupt(CPUState *cpu, int mask)
 {
-    bool need_lock = !bql_locked();
-
-    if (need_lock) {
-        bql_lock();
-    }
-    cpu->interrupt_request &= ~mask;
-    if (need_lock) {
-        bql_unlock();
-    }
+    qatomic_and(&cpu->interrupt_request, ~mask);
 }
 
 void cpu_exit(CPUState *cpu)
diff --git a/system/cpus.c b/system/cpus.c
index 437848b5eb4..9bfbe2b0607 100644
--- a/system/cpus.c
+++ b/system/cpus.c
@@ -257,8 +257,7 @@ int64_t cpus_get_elapsed_ticks(void)
 void cpu_set_interrupt(CPUState *cpu, int mask)
 {
     /* Pairs with cpu_test_interrupt(). */
-    qatomic_store_release(&cpu->interrupt_request,
-        cpu->interrupt_request | mask);
+    qatomic_or(&cpu->interrupt_request, mask);
 }
 
 void generic_handle_interrupt(CPUState *cpu, int mask)
-- 
2.51.0


