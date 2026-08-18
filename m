Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3021C5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:22:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwNUe-0002Sh-Cs; Tue, 18 Aug 2026 13:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwNUV-0002P2-QG
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:20:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wwNUQ-0001k0-95
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 13:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787073631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V1lqsZijpj4+1+v/8PbsOFnNL29XGby9Y+jD1irfQ7E=;
 b=POK7Tu+6PwBfZbj6C2dBB+kHRT/1cN+EFD7/NGZI3QrfpVPZYC7uV+EsdbJq4MDfpE8dSK
 DJw1LeM8j2ZEOE3VU+WE3GmkHxvnYHQptlbh0F8Y4gKqlpmov1gp0vqGZS/tfTNYOUA7N2
 Dn32S6PgyAjsJfwUAVuHU8jz6V+3z3o=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-yEq9k64PP1SFR_tVdJnNWQ-1; Tue, 18 Aug 2026 13:20:25 -0400
X-MC-Unique: yEq9k64PP1SFR_tVdJnNWQ-1
X-Mimecast-MFC-AGG-ID: yEq9k64PP1SFR_tVdJnNWQ_1787073624
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8f08560ea44so2057546d6.1
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 10:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787073624; x=1787678424; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=V1lqsZijpj4+1+v/8PbsOFnNL29XGby9Y+jD1irfQ7E=;
 b=Y+ysEdqb48WLRdioDfq+yVPrPh8ss8/3rxhajpYWLFb7N9i9sAC0PPTsqUsO2Hm5nW
 Xb3w2ebKXO11XCE061Qrd/QoSYQeeUnqNOzVqyu5t0aAEYf9ggSh2R0ukwKWTtlkZPdf
 MK6oS93iSU0Smo/KLiugF/rhKEMEzxf9ZVESLyElBcI99VT5HrcoSyPxpRe9wya3es3k
 YxG1P/lBW6t3Yhq2OpDmLlHTGkWscoc17CMhGZ+aBgcJvl8SCzmWdkssRX86tGMsf0Em
 XxfxNTR+qCGaxzc5afptE9uuFVXtB7GHwYoDuMp4NoZ5gHgYLndlih2vtN4skZivzraB
 ViqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787073624; x=1787678424;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V1lqsZijpj4+1+v/8PbsOFnNL29XGby9Y+jD1irfQ7E=;
 b=pyP3K+1OIISI1dyg+di/SXasrw0nhRMSddHSqVQ034h7Qju4VIEuJF/PGq8ZhgNWu5
 NJrRvR3WtR9ls97ejSxZsmLl2jJtl+Im0sTixPRsE3r2vMmGLzM9Jx/3eeOSlG26W4V9
 aK+ECElrTTr8B2pKoTP11lm60ibuDyeHnc/Lgyna7glo0ZXrDbOCygqRhiaH9/D3uwUo
 adessX+EZ3cV9IG8XdUak7Wlij4LmFODBP8b4QPQdjWm2IDUxfbzqxUy2rgpvReDmz9+
 Wx4+zC0NTvG2m/K6fPwOezJiSJMs7iBAAnhvPlBDFAgpZ0cM3s+MyAjKHrQxYChL5yxO
 50Vw==
X-Gm-Message-State: AOJu0YyIbWLQ1IEHVebmFuN0/5Q2J4yET5IEvYCU60vXCLBREC5iCV//
 XRlfN7maFqDXUqLrlnRIYfkiH4jZH9iJg5D2MqvladpIfY0OlZFKpa/Y1M3iZT0EvoH24KkovI+
 47T4VcUwJ8vBS/dT0ey36yscS9ZikCClv2EDcvRaGKO+O/bYt1Bzw+20AoqCOf3RTiI/ubvMkNx
 KP+FdQkh0tlgchVpy6kHU/P9lwR7j7NTWHQsEeSw==
X-Gm-Gg: AR+sD11jp4NUT7rAVtfUNT8WincckepEUZCkA3kfh85slB5W+DJHVuZqpDew7Me416B
 D05sv8RTlV3j91BRi6wVyoeHrnLiFjVvhYsvmXK24dCtDyAxseyOiA2043gRRpeG9mrac9PBmzJ
 M4jREhvsIyaCC1UmhI0mUKBxvNlWnzoKkZGlT4DHlUncwpGYj5pi3qNaQF4oBShFnuMRBgTVEVD
 89YbS9E7UTuT6t1/2UKNhbvEd7MMBaVbs5Rwl+HJJ66k+RysfIAI8xfhRlQcTDYBTfu2gwHdkY5
 tfF9c4h9p13gCMbtO83e5FZOHQdRwZf1mb64GJbUXqBJnALQQdlY8YNy6MRn8tkVWdHAZt39wdk
 KD3UaXTNgNASWQETGH833u5rYKRmq5OMqJxcltl7KjnHdSsD0NlyNcEqH
X-Received: by 2002:a05:6214:540d:b0:8f1:505c:1d3b with SMTP id
 6a1803df08f44-90a91dba173mr415307426d6.26.1787073624183; 
 Tue, 18 Aug 2026 10:20:24 -0700 (PDT)
X-Received: by 2002:a05:6214:540d:b0:8f1:505c:1d3b with SMTP id
 6a1803df08f44-90a91dba173mr415306616d6.26.1787073623574; 
 Tue, 18 Aug 2026 10:20:23 -0700 (PDT)
Received: from x1.com
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90c4584418bsm36560896d6.17.2026.08.18.10.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 10:20:22 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v2 1/9] system: Define ram_addr_t to be always uint64_t
Date: Tue, 18 Aug 2026 13:20:04 -0400
Message-ID: <20260818172012.3052821-2-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260818172012.3052821-1-peterx@redhat.com>
References: <20260818172012.3052821-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

QEMU's 32bit host support was deprecated since 10.0 and removed in
11.0 (commit 372ec46b9f), at least system emulation part (cf634dfcd8fc
revived tools).  Now it's safe to move ram_addr_t completely over to
uint64_t.

It should be almost the same as uintptr_t as before for !Xen, except that
on some systems (like MacOS) uintptr_t and uint64_t can be typed slightly
differently, causing unnecessary compiler warnings when use them in a
mixture way.

Hopefully, this change also makes it clear that ram_addr_t is never used as
a host pointer in any form, but only an internal QEMU integer based address
space for allocating ramblocks.

[1] https://lore.kernel.org/r/d7b2fbf6-f9fa-4b39-8f40-95b7d5d0d8fb@oss.qualcomm.com

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@mailo.com>
Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/system/ram_addr.h | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index 129f6b8757..044c0b52cc 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -14,16 +14,14 @@
 #ifndef RAM_ADDR_H
 #define RAM_ADDR_H
 
-/* address in the RAM (different from a physical address) */
-#if defined(CONFIG_XEN_BACKEND)
+/*
+ * QEMU's internal RAM address space for ramblock allocations (different
+ * from guest physical address).
+ */
 typedef uint64_t ram_addr_t;
-#  define RAM_ADDR_MAX UINT64_MAX
-#  define RAM_ADDR_FMT "%" PRIx64
-#else
-typedef uintptr_t ram_addr_t;
-#  define RAM_ADDR_MAX UINTPTR_MAX
-#  define RAM_ADDR_FMT "%" PRIxPTR
-#endif
+
+#define RAM_ADDR_MAX UINT64_MAX
+#define RAM_ADDR_FMT "%" PRIx64
 
 #define DIRTY_MEMORY_VGA       0
 #define DIRTY_MEMORY_CODE      1
-- 
2.54.0


