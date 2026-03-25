Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ABCE109C033
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:46:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5RM1-0004ot-2l; Wed, 25 Mar 2026 12:45:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RLz-0004oi-6Q
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w5RLx-0004c6-Ij
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 12:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774457108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OA7u7CvoBnwrQ6q5MqnN52xv+zOMgAaqhpZaN1iL2Hw=;
 b=eqikfsGsHwMVZGUXH2Mkx27DchBt0bZKOqdpQ7rTIdZkgV8hvL1wOoRtUMPdzjg1WCpKEf
 VPXRNboigGPyqK++DiK7iRQ4x9SlNh3IgaZRypNFo5s9COQDw1Da/0e1SeOsQloAZQZQHm
 9FH6ONf2gt3ImCjJoJGYS5S2ee01iws=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-REHUgEpTO1e8ELUAuNIOYQ-1; Wed, 25 Mar 2026 12:45:07 -0400
X-MC-Unique: REHUgEpTO1e8ELUAuNIOYQ-1
X-Mimecast-MFC-AGG-ID: REHUgEpTO1e8ELUAuNIOYQ_1774457106
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43b7ec737c1so2649410f8f.1
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 09:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1774457105; x=1775061905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OA7u7CvoBnwrQ6q5MqnN52xv+zOMgAaqhpZaN1iL2Hw=;
 b=rm8zVNfVtyEuMsXInMfi1jGGd2LtOkLxipiEZpbad/HNp2R84lmQDIE6GnPea+tulf
 lfXw2IBds/EoGaz+JhRvFbE2QjfFQ1XO97KB6HiDYtiKDHucgX50OPPmIVJvblvc2aQn
 kMyLpj1RoWow7nONkIxgiCbVZv8yu1fdBLLgXT2u98J5YgJ2ECLvmCZINV4ZB7Q4DpkN
 dYVzUljKns1HOONPjPXH4+5HcexaaMG+9aHiDEhRO74W9z1OlECfZ1poeAGqwXbugfa/
 QN2wGyKdIiSSomF/2ilWP4GOtIVcq1WXF2L+g3hkXQz6XMCf4DVFh3g9CoZXPKQsI68E
 wmsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774457105; x=1775061905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OA7u7CvoBnwrQ6q5MqnN52xv+zOMgAaqhpZaN1iL2Hw=;
 b=faQB2LT8nAFTRh2re/CdBZa1PY8YvkJokaCD8GQHR/cOJ2lMaarfiLeVfVJeYhzBsV
 boF+te8gjWQ2CAKXAOKfNk/XBDHpA5QOq+eqLJhdafV1K54otPUHugx6Ei0iQXLhYIkp
 uneleEbznWCtY5Q6fR0Loc6JPRqkx6esykVLqV+g83xhZqie5gbmd9kPJRDunBcj/6fl
 Py3mmxp+8+fa7jrSATaIMi4yFlEGDRUKeoMNc7yB5SP67rjP03WF+zJ17Kx49IpMBS2H
 PfJYowfL87xebkAwLhSSlS+djSQk9XMOK2Zyfq+64LUdhuPBu82pi9rw6dCUma+H854j
 VXZQ==
X-Gm-Message-State: AOJu0YxInfl4ZfJlIxSLWoh5wRQ4QWUlu0+mqXFGiN5WEsboCp7HT1XM
 Q0CjnvJrgGDk+y777y0WZmVL9qVAhFUib/GH18ewOOfifJQRGez26++izLFCI7k4CmuF4A5qbeE
 HxUKzBNsR7tLCTigV+/Jj6PWQSf3OVUQpFHTrimqQeRC0Slr5dlRncE8Pj8N/WLvAsuiA+p6ahN
 6SqEEVeWeQcxuCGZO+/P+z5ZGi7EkX57Ypz6uNYrSk
X-Gm-Gg: ATEYQzz4kcUr3aS7P8dVps9N1NsTxj0XdF96eAFZbsD7atHFDmeq+pGfLahhkQja5fr
 axHSQeLjN6kEFE0oy1AiW4jSi4Y19B1PVMhfc8O4E9madJRpQDE3+2IuAPK532ZGzdkzwtQU4GJ
 PslZF3HaKSSvxPgWsQUpgFdQuk3WDtPqLMQomBzaiCwTUmF4CJ4T2x9wd9q3zhVCjDBhfFHo/8Z
 5OzVda/29zBwmzsySt0nbKCQDFX3kVDh2SgkakJbQQqByt2e9iq8uv0YsgV2sl4jmpEY9V+Efu8
 pXdQTk5yhzClHjTCOeVFyxUV1r/vPkBuM+qOFg3vB5aKl6v2CuUuowtEdXXHapQyErcLfnrAY8+
 l+ZVmIQtPIhQaF2KOPtGMRnHZp1yQVlfIrusmjl8WqWB0IRdlF5L1XlNURFzFq8Ba+PwF9Rbs5J
 ageUoiw6095y1kNnSIvQOCpi7u
X-Received: by 2002:a05:6000:2084:b0:439:d74f:2109 with SMTP id
 ffacd0b85a97d-43b88a39c6fmr6336209f8f.49.1774457105125; 
 Wed, 25 Mar 2026 09:45:05 -0700 (PDT)
X-Received: by 2002:a05:6000:2084:b0:439:d74f:2109 with SMTP id
 ffacd0b85a97d-43b88a39c6fmr6336133f8f.49.1774457104364; 
 Wed, 25 Mar 2026 09:45:04 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919cf2b2sm1028522f8f.18.2026.03.25.09.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 09:45:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 05/19] whpx: i386: enable exceptions VM exit only when needed
Date: Wed, 25 Mar 2026 17:44:39 +0100
Message-ID: <20260325164453.72127-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325164453.72127-1-pbonzini@redhat.com>
References: <20260325164453.72127-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

The exceptions VM exit was enabled with an empty bitmask
even when not used.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260324151323.74473-3-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 015c0f1dc99..8f1835ee95c 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -903,13 +903,31 @@ static void whpx_init_emu(void)
 HRESULT whpx_set_exception_exit_bitmap(UINT64 exceptions)
 {
     struct whpx_state *whpx = &whpx_global;
-    WHV_PARTITION_PROPERTY prop = { 0, };
+    WHV_PARTITION_PROPERTY prop;
     HRESULT hr;
 
     if (exceptions == whpx->exception_exit_bitmap) {
         return S_OK;
     }
 
+    /* Register for MSR and CPUID exits */
+    memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
+    prop.ExtendedVmExits.X64MsrExit = 1;
+    if (exceptions != 0) {
+        prop.ExtendedVmExits.ExceptionExit = 1;
+    }
+
+    hr = whp_dispatch.WHvSetPartitionProperty(
+            whpx->partition,
+            WHvPartitionPropertyCodeExtendedVmExits,
+            &prop,
+            sizeof(WHV_PARTITION_PROPERTY));
+    if (FAILED(hr)) {
+        error_report("WHPX: Failed to enable extended VM exits, hr=%08lx", hr);
+        return hr;
+    }
+
+    memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
     prop.ExceptionExitBitmap = exceptions;
 
     hr = whp_dispatch.WHvSetPartitionProperty(
@@ -2167,7 +2185,6 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
     /* Register for MSR and CPUID exits */
     memset(&prop, 0, sizeof(WHV_PARTITION_PROPERTY));
     prop.ExtendedVmExits.X64MsrExit = 1;
-    prop.ExtendedVmExits.ExceptionExit = 1;
 
     hr = whp_dispatch.WHvSetPartitionProperty(
             whpx->partition,
@@ -2175,7 +2192,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
             &prop,
             sizeof(WHV_PARTITION_PROPERTY));
     if (FAILED(hr)) {
-        error_report("WHPX: Failed to enable MSR & CPUIDexit, hr=%08lx", hr);
+        error_report("WHPX: Failed to enable extended VM exits, hr=%08lx", hr);
         ret = -EINVAL;
         goto error;
     }
-- 
2.53.0


