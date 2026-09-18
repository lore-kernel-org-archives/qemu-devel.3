Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79675C982DA
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2026 11:41:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7WwY-0000QQ-FC; Fri, 18 Sep 2026 07:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7WwW-0000QE-Lh
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 07:39:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7WwU-0001cg-WB
 for qemu-devel@nongnu.org; Fri, 18 Sep 2026 07:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789731586;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NYiDFxM5DTkwPjVQc++Tthuv6NIMIlEmS75dFNyYj4E=;
 b=S0BbpeCtFfChgzhjxaQe79qMregGtf1EhagSrJwGH0EwFc+s44rHFHNSWS5PbjOg/XUTGp
 nIfBgZCmcRp1EiqGP+tJjJCob4fffQMzSkx0SorM0TfQKChw5aU0su4uUBdqP8RUn07KZI
 zV+J1d9JTom8ckT/K9Nigg8BBmNouDc=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-a25Db9JFOuSMaY-f_MBNdw-1; Fri, 18 Sep 2026 07:39:43 -0400
X-MC-Unique: a25Db9JFOuSMaY-f_MBNdw-1
X-Mimecast-MFC-AGG-ID: a25Db9JFOuSMaY-f_MBNdw_1789731583
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52fb8f67601so6848921cf.3
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2026 04:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789731583; x=1790336383; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=NYiDFxM5DTkwPjVQc++Tthuv6NIMIlEmS75dFNyYj4E=;
 b=ncJnPb6dHdK2BOmsq67+wF6usuG6FysXLqymo8RoXHI+jVc/kQe0OA9egzCdbSeS6B
 s9tP0khedsTW8zyFaQWDkCITxZoDG9SLUhHLMYPZXTSmq8SDC0ZprfYn0tjLOAs3f/SC
 IiVS29YGL1/09ZsY5ARVhLWy+7kriPAQGLSWeUexsLXKBG7qnRxVmXUHJ4npxLkl9/0z
 PED3qPrh5S/AueWAKKBLcw1Jy+VlLz67iM2eu8KDexGMRUWWDG2hLSJwQNEJn6t4tr50
 CO2JD1SISB1CAwO1NpQ5typPqTpCqC0qR/lHk10wdbhCd/O6kKCK0TPkZUxfo/A3lI1d
 vidQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789731583; x=1790336383;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=NYiDFxM5DTkwPjVQc++Tthuv6NIMIlEmS75dFNyYj4E=;
 b=c/f73lwuCBd0Vg47XT8IYpD2LvN7ClrLmNoY4yprhFyJrjKKTcmQrm2XRtJx5aYwAH
 GIG+8NWJCf161+SKv+wtQQvEk8ZvgyaG0yAQ+zBS2cqn+IcQZbbejwKnzQXvIrH3+NGR
 l0FrUMfsJHgaU1eVeM5GlevCRlZuITN5M/4LBobIDpCR9RsCk02BIUla47fzDz+MkW4r
 1orUkShWBW4WiyQJEuwM/v6vv7poEhJBaJE6QuOL3wcNwzWkqGK9sMIVEiD9DXkJkeVD
 nTod6VMF4Ho0+mzsERR/YgBvTQmwhV5c2G5Ihx+aYRbcw9TqifwY33szRpWqd9NkyeuT
 9ylA==
X-Gm-Message-State: AFuF++ku+x4IlL+rXZfhbj/vOl6JSjJmZSoW+6J2XmigACbyU9kBr6FZ
 isdUwUHfpFocttxGEL3SQLeHAJQqX4OKTLP54Z0KBkhL4DsqbgWkj9W1icXg30MzGt2KEYKvGoH
 KGJgZPrgp7IY4vjqoxp6pPSukj3FAkdQPw5nEBXT7D2JQI9j9j/M1tQp6b4AOw5L/JiI+w1TNUH
 d+YW8woc6iDjdByyffLycXtcSeNnWegyb4LfWRDx9R
X-Gm-Gg: AYBFou17p9A22R83/HLAravQGaH1cwd+FGjQwlrpFZph/F8kaEDqbseeuF3LVgq/yVd
 YxyyW3RZ75WHlKJShsNrNTzSpaxdjR6sNZT17pgGxaRxcqB5aAOZACmXLBGmK6Hy5Hus8JY/7kT
 dha4qf8WbQYSpeqxQaBxKnLgHIdwC9h+ZnXWaTBnwO5vR8OJOViO+aOfeEGEOVc6FOxDYUBpok+
 r+OJZcJkNQqPMpdg6u8+YkvUrVS4NPRDlshfVsRlLgEeZMthporCYSm33pmznMMg6U6mMURRz0f
 GbhaPXkKY7mwAi2KQ76yUXx7uNvyLOJIKHdpD8zsyMml541uJ/ZfLSO4CKOYcFjUGMr7LAhy/RK
 lfgte/6cNrqqAtvkYzIdzJFkaBMZPwypLy2QlX7i5ESm01wohYbYg3HjVBWA=
X-Received: by 2002:ac8:7d47:0:b0:532:9ade:b6d3 with SMTP id
 d75a77b69052e-5329e59c03emr30340761cf.79.1789731582975; 
 Fri, 18 Sep 2026 04:39:42 -0700 (PDT)
X-Received: by 2002:ac8:7d47:0:b0:532:9ade:b6d3 with SMTP id
 d75a77b69052e-5329e59c03emr30340301cf.79.1789731582325; 
 Fri, 18 Sep 2026 04:39:42 -0700 (PDT)
Received: from localhost
 (bras-vprn-aurron9134w-lp130-03-174-91-117-74.dsl.bell.ca. [174.91.117.74])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-532aac41140sm1770451cf.5.2026.09.18.04.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 04:39:41 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>
Subject: [PULL 01/11] system: Define ram_addr_t to be always uint64_t
Date: Fri, 18 Sep 2026 07:39:16 -0400
Message-ID: <20260918113926.831204-2-peterx@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918113926.831204-1-peterx@redhat.com>
References: <20260918113926.831204-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Link: https://lore.kernel.org/r/20260818172012.3052821-2-peterx@redhat.com
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: "Philippe Mathieu-Daudé" <philmd@mailo.com>
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
2.55.0


