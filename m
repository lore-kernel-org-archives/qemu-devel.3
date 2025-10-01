Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C823CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 17:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4146-00031H-SM; Wed, 01 Oct 2025 13:56:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v413p-0002Za-2D
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:56:20 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v413G-00015W-Se
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 13:56:16 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3f44000626bso48862f8f.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 10:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759341334; x=1759946134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pMnn9QxqznMIk/8u6GQ47WHewwt0Ozp5spYHpTtSw08=;
 b=S/ee7Dn/1G7RyHgqCNjKEzt15NsC6aoQ0m7aJN3sRtWh+S5vye4ra0drGrdXfDTIx8
 XB8Lub6yoDtUII2c0xgECa0/TrQhlUZoUeGrQmFB1c0dfRC+qZ/q2GNSN6sF1haekTuJ
 f3v24mUDrhyDPOkKISL2WbXd7YoWVtVQcMzfXwHMX8lIytdsQYi3uQ9CERXiivr6GrN9
 G/Dyr9783j2JRukiqpDWZqCEFVGux6d3dG1VRvbb1rNJq2dvGEIZd3DdEaT4lk7xkd5u
 DnlPk6WtEsbSetgX79dI3BOfHx0SJdxNBMdqtlwyTbLQDeS0H/hs3EhWkoEwFxY4h6oe
 mKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759341334; x=1759946134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pMnn9QxqznMIk/8u6GQ47WHewwt0Ozp5spYHpTtSw08=;
 b=rudYxr/we/ko8ITG6oq+AlVhQbI7vo1iGu2T8t+e20MkSI4ypUIelRXTrzZLY7ghzV
 vSwpSsu5bgsoVNuwGrvV9GvlweDk9f+97Vlf3NZpBEP7oUImI3341g3nuBrXiHCyJoef
 Mv7ADrhs/vXG0g3pCYumH5BpJyPTmchmSP2zAMfvFNZ6tpNtVHaK3FqwiQP/MD7w5LhA
 lAwtm4WtGWyBWebL1U3eM/5UYbtYdfECT6pHBidiNMt32z/dN94fSkPm1dBlnmawtRss
 HyozhuC4HKlJi4ya0QFDkdaO5SqAF0tDOXTHSDfooQqtZQF4Abln5s3Sh1ITI7bJPGiI
 XZwQ==
X-Gm-Message-State: AOJu0YwNnXcykTlPUFQ26qX6c+A4XvLKsYpQuQiTY5B+E1i67sf9mYhU
 Sj8w03qdUEMPKkgkrIhrwXluIaMlWGWgADomYzDaciDMV9TEKYNKYDqcFxTfjk/eg2+n1lhL3F/
 Vs5ESmSsKUQ==
X-Gm-Gg: ASbGnct8GDt3hgQFT6Gr1nJLEMA1v+WdRBs+LB9YYI3k0f8m0AUOL9WAH2hbKxWeQFU
 g6xyJNvdiSOpMVEZYsyRc+F3C8tEexP44hMA5+ninwp3V3PAM+Nl7UiIXiePTGuxNQcn2PBo6Oi
 5F+ifsRDtAvjwW57Ibttei70nY9GhYZw8wbWxZl08vskKI0GwT/1oZFKpKvlXJJ4wXlru5W6XpN
 l5wL8/L4qSiUQLtvtnm3aFROrq0Crnia2QppeTs2sMJ9/3g9UeDoNMraKbcHNLR4QjtgeISH0yy
 fNYd7bNKYcqTWXBi6hRiTOYrnR6q5M9OJiIGlkMA6Gwuh+XAvZ9OpBOfV81OrHJw7xwMJDMpIhZ
 UzG3o0+dB/lrCXPuW7ATNNa2piYMCTX+bWWCbbgEt8S75QI08zS9sRcL5pFd5pHWsw9Jjw4rm09
 0Un2aL4T59YUo7Q5KIEbo9GsLIiuUY5AstI5ol
X-Google-Smtp-Source: AGHT+IH3Aw7dJFcRGHrlqU+4GY94BK4VCgtQs9LFky54IFrpPglI/IatQU7AKf0gdO60PkhxhKtrWw==
X-Received: by 2002:a05:6000:2901:b0:3ec:d740:a71b with SMTP id
 ffacd0b85a97d-4255780c039mr3284668f8f.31.1759341334253; 
 Wed, 01 Oct 2025 10:55:34 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f0846sm79742f8f.45.2025.10.01.10.55.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 10:55:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>, qemu-ppc@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Jason Herne <jjherne@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 kvm@vger.kernel.org, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Farman <farman@linux.ibm.com>,
 qemu-arm@nongnu.org, qemu-s390x@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH v2 08/18] system/physmem: Un-inline
 cpu_physical_memory_is_clean()
Date: Wed,  1 Oct 2025 19:54:37 +0200
Message-ID: <20251001175448.18933-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001175448.18933-1-philmd@linaro.org>
References: <20251001175448.18933-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Avoid maintaining large functions in header, rely on the
linker to optimize at linking time.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/system/ram_addr.h | 9 +--------
 system/physmem.c          | 9 +++++++++
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index f8a307d1a3d..cdf25c315be 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -183,14 +183,7 @@ static inline bool cpu_physical_memory_all_dirty(ram_addr_t start,
 
 bool cpu_physical_memory_get_dirty_flag(ram_addr_t addr, unsigned client);
 
-static inline bool cpu_physical_memory_is_clean(ram_addr_t addr)
-{
-    bool vga = cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_VGA);
-    bool code = cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_CODE);
-    bool migration =
-        cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_MIGRATION);
-    return !(vga && code && migration);
-}
+bool cpu_physical_memory_is_clean(ram_addr_t addr);
 
 static inline uint8_t cpu_physical_memory_range_includes_clean(ram_addr_t start,
                                                                ram_addr_t length,
diff --git a/system/physmem.c b/system/physmem.c
index a8d201d7048..fb6a7378ff7 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -945,6 +945,15 @@ bool cpu_physical_memory_get_dirty_flag(ram_addr_t addr, unsigned client)
     return physical_memory_get_dirty(addr, 1, client);
 }
 
+bool cpu_physical_memory_is_clean(ram_addr_t addr)
+{
+    bool vga = cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_VGA);
+    bool code = cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_CODE);
+    bool migration =
+        cpu_physical_memory_get_dirty_flag(addr, DIRTY_MEMORY_MIGRATION);
+    return !(vga && code && migration);
+}
+
 /* Note: start and end must be within the same ram block.  */
 bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
                                               ram_addr_t length,
-- 
2.51.0


