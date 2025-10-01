Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4548DCCA474
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:25:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3s8B-0001ly-4B; Wed, 01 Oct 2025 04:24:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s7Q-00015E-W9
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:23:25 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s6m-0005zc-VX
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:23:24 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3ee130237a8so5038791f8f.0
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 01:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759306959; x=1759911759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IX+0YqpET4g31NDLY5+FZNI7uU5E3uyAuFWScssj2Zc=;
 b=C2sKA/PXhcE68K5CudvT79+XAwKqPesiWIpeRKMXhtHa36TEOduKJJnSqzlUWuv8zE
 EaJ2ThZfhOHjOtD5KBG+gD5ksEFZOR33DcGEO8CYqcsMyIw0CEH9XkAQuYdWvuFScoDx
 nEN7AXW73JrxLxUO8Jno0mk/279gRbRpXCbxsGlI5GIiJY8YgyzPLBkqHUqxhja4Cwrb
 YTj0PJq604ouWGEP6ObYZzt/DXOjjcXFasGKSZ11ljuLuWRnBqdONYJepFW8T5Y3QaFP
 nUieoCMB/HuFSHVjvEEI0GE1t6Dn7h40qOJbEogM9S9GhEowJYyXesDgBjM1JOJufL51
 0Gpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759306959; x=1759911759;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IX+0YqpET4g31NDLY5+FZNI7uU5E3uyAuFWScssj2Zc=;
 b=WK/HZNaCwTBp8yCSrrm/JO0wI3COGvHUlYgQwsIVYMlRFk/I1yig+nnmuubcZ3oeSh
 O+keubvckSbO59Vqika70JOOqSOQHa1SO2OMuvuE0gY6IWZIp7SN+CImnLsl8r4hywXN
 g6djHgGwP5HYTt+jnHtQcaOVmKozHXxoI/vFnuJ8knketBcjog88u8xKvTpOsWFN0yiO
 Xv4SNam0IdHNlB74LbQS+L6fC38+jA1J+ldw2LOCqPUIZ1jQQXjf7cWiFAzBM117dc4K
 6VtY9VkKnRX4kQ1E240drFbBICvu9MIQRfPm9att1nosqehRJ65/NexyBkPyXAEs//YM
 HDdQ==
X-Gm-Message-State: AOJu0Yz39tEB92mfvVILpxtcW41FyE7C+6V5X/8u+3S8joqwbAYr41Q3
 24n56helcaFPyHT+jjxpDEe4QBLtt6BDXeNRkvJtLDNiHZUA65Ka4/H4WJKQb2K/CesM8V+zp6x
 DCieSmF2PPg==
X-Gm-Gg: ASbGncuJeHbsEpGC2d5yuXUd52xw8IaIkk94psZXqLjW+O919KoJFsFDKpTNyY1TliU
 DsI+nMxo+mp1U4pSPuZhwr2lBVZ/Uvmm0yF5NwduFGsOYMNtMecettGryJ9E/Y+gg/cAxmwGgFs
 r1Jg4neeFR9LL4GPIC+kut85V7mF2Wa21Iqq4zQnwuVqHvfaX7fS3OEwJq+AILnbnsaqTX2HfJd
 Tl6jNUUHoJz5aqaOHB/p1NqVfDWupC/rzCAOF6JHve6CxTjFLTE2DvBCSrrliC/pKt/Lu3RYDLA
 psgZ3OeLSLfn0TmKUrvRVLXqDz+aWS5mmf8lHFhiIdRhJYiJDhglRNzcxGARGK26d2Jog/q1k66
 TnMpuCKfCHKXc8exhl/bNP58y2ukmUT7vnApmwOKdnh6kwP5G+9wFp8r5c+aNATUCqMgAtqmP8l
 LhJheZOKj43F+CBFYcOtsZGStBYDieH7U=
X-Google-Smtp-Source: AGHT+IE/8bf21R3sZXOBj/IBWXVsuZtflY0OYXywlOPEETSJRqRNNcj4CdTyXwOOx1Abubt3QQ+Txg==
X-Received: by 2002:a05:6000:220b:b0:3fd:2dee:4e3d with SMTP id
 ffacd0b85a97d-42557818464mr1936382f8f.46.1759306959396; 
 Wed, 01 Oct 2025 01:22:39 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb985e080sm25891823f8f.24.2025.10.01.01.22.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 01:22:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, qemu-arm@nongnu.org,
 Jagannathan Raman <jag.raman@oracle.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-s390x@nongnu.org,
 Peter Xu <peterx@redhat.com>
Subject: [PATCH 13/25] system/physmem: Rename @start argument of
 physical_memory_range*()
Date: Wed,  1 Oct 2025 10:21:13 +0200
Message-ID: <20251001082127.65741-14-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001082127.65741-1-philmd@linaro.org>
References: <20251001082127.65741-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Generally we want to clarify terminology and avoid confusions,
prefering @start with (exclusive) @end, and base @addr with
@length (for inclusive range).

Here as cpu_physical_memory_range_includes_clean() operates
on a range, rename @start as @addr.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/ram_addr.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index 7a9e8f86be0..e06cc4d0c52 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -185,22 +185,22 @@ bool cpu_physical_memory_get_dirty_flag(ram_addr_t addr, unsigned client);
 
 bool cpu_physical_memory_is_clean(ram_addr_t addr);
 
-static inline uint8_t cpu_physical_memory_range_includes_clean(ram_addr_t start,
+static inline uint8_t cpu_physical_memory_range_includes_clean(ram_addr_t addr,
                                                                ram_addr_t length,
                                                                uint8_t mask)
 {
     uint8_t ret = 0;
 
     if (mask & (1 << DIRTY_MEMORY_VGA) &&
-        !cpu_physical_memory_all_dirty(start, length, DIRTY_MEMORY_VGA)) {
+        !cpu_physical_memory_all_dirty(addr, length, DIRTY_MEMORY_VGA)) {
         ret |= (1 << DIRTY_MEMORY_VGA);
     }
     if (mask & (1 << DIRTY_MEMORY_CODE) &&
-        !cpu_physical_memory_all_dirty(start, length, DIRTY_MEMORY_CODE)) {
+        !cpu_physical_memory_all_dirty(addr, length, DIRTY_MEMORY_CODE)) {
         ret |= (1 << DIRTY_MEMORY_CODE);
     }
     if (mask & (1 << DIRTY_MEMORY_MIGRATION) &&
-        !cpu_physical_memory_all_dirty(start, length, DIRTY_MEMORY_MIGRATION)) {
+        !cpu_physical_memory_all_dirty(addr, length, DIRTY_MEMORY_MIGRATION)) {
         ret |= (1 << DIRTY_MEMORY_MIGRATION);
     }
     return ret;
-- 
2.51.0


