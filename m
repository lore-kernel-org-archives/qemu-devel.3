Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09208CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 08:28:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3s8L-000211-GW; Wed, 01 Oct 2025 04:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s8J-0001yU-Ih
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:24:19 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3s7O-0006Nx-Hs
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 04:24:18 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-46e2c3b6d4cso52358115e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 01:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759306992; x=1759911792; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=afB/RZFwe4kGQ4M+qs4tNxazcsoE4PwZzYwGLFafQyg=;
 b=uRPnTkwt3y+sdFVZaeJGUT0ny23Qns45h3bhriQdA41HsadBItKgL0uWnIGo3jZ4Er
 6DVDSwvXBYqGp+zIK0DPI+8Db36Onvb9HJOn4rdNRabPvhcJCrxm+iEsjf8A8D4J+NGW
 z05zq/SzUEWeKI0HwcSg0P6bSSSnMn7seLNnqyJp6O0/a/VLH4C1DEsYqlh8itIr9rTf
 ppDidu8oTqSrdD4Fauk9LZK223GYJlQSQkYqHpO6KEhoqJGKmk41gXK/i+QguoFi2Nn0
 f+z6XAwHmqYozK5D7pFu/kWAH2/jFV5f/7jbNGwaQ2BYPx0+yETSk3Xcl9ADr60jMqhO
 weIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759306992; x=1759911792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=afB/RZFwe4kGQ4M+qs4tNxazcsoE4PwZzYwGLFafQyg=;
 b=HxDhbKMQrlsipLgMPRwYeyWZC/k4899dvt7pQN37/aBX2GPOBDU3Res8V5oCFn8Sf9
 YRQggFP4l3R4qjlxLVXPU6UmHfk5YgX6YLW2YdrEJpgfZsabjeQq3SRkOsfGKAP9Gt8M
 r5oqt9nVKxuNesJfKysbQrmM53TMRt7VwVdExmD2WasEGSqvMFtGkIXWuxUAvSq6U/u5
 j3KlSCl30GnlxBej1aQ8l0O8LOPNSYhLdHqnlRHASfO2KdIYQn2rSEfQ+I7HNeXiWknq
 u27L7Y/lj00qiQSH7834bzQKdi12QeJwwqSFfCq+26Q5qibKmUtVBvPIC+ItePe/+FoX
 94RA==
X-Gm-Message-State: AOJu0YwaqTW9NEkbVWCpiXbfSaZkvjPbonEYzy1AYCJEjZxBmg3y+kFe
 eI0aFEYbskmcfk207RHHIUpfj+r+SutgjqRja2WT8nkvpGNY/u+8xqgORk8yjSl8kkbP9H29tgL
 T3TDaqhXnhw==
X-Gm-Gg: ASbGncvXxLaHpdhcUsnnWbFXtq8FuyVRXHZLX8/g4r5ov262WYKY532OowYxa/MywfI
 Z0MbHCZ6+i/QELa6IGd/CXi9Lbnbxn0eOoQmAvDavk6tlMFWmNXBAkOmFrAw02X3nM7EDoHkziw
 otC/0rvxk7+VlK6ZTaz+5b6aG28q+zB6W8AJKTB4DrbXqlTrtiKqN0nQJ6RPBf2zgp9W/0M8TKq
 m4oHR8xTp0qZkj3+AqFzSsbblVi5e4WaxLPhgw29Rn2cAHNV59Oz2ggBs9NwvO/qVFXZ9XI+scL
 jgeS9CviOD3m70i2r/erHnROze1NTBccLGiDRQDP35eNAiHmvuDExObC4aJsSMROcyGBLSu9XoC
 CW79u8Zf0Sms3tLCVX/Sj+/Q2EADD30NgHsApGyGrqcOlPrUILErHPELj8mHw9xOnTzlzy2kZ9l
 X1VYu7O2Qbw+u0EEZN+vtgmh2+qwscOQI=
X-Google-Smtp-Source: AGHT+IES+dNLrdEB70zhgtK1c4BlsMZT242yR2FvRNkFzHhBxS3IH+lOXPsvtn3VywwmBpBB1wjvcw==
X-Received: by 2002:a05:600c:8114:b0:46d:ba6d:65bb with SMTP id
 5b1f17b1804b1-46e612dadeamr20526405e9.31.1759306992259; 
 Wed, 01 Oct 2025 01:23:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e6199fc34sm31625915e9.8.2025.10.01.01.23.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 01:23:11 -0700 (PDT)
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
Subject: [PATCH 19/25] system/physmem: Rename @start argument of
 physmem_dirty_bits_cleared()
Date: Wed,  1 Oct 2025 10:21:19 +0200
Message-ID: <20251001082127.65741-20-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251001082127.65741-1-philmd@linaro.org>
References: <20251001082127.65741-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Here as cpu_physical_memory_dirty_bits_cleared() operates on
a range, rename @start as @addr.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/ram_addr.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/system/ram_addr.h b/include/system/ram_addr.h
index 4c227fee412..e65f479e266 100644
--- a/include/system/ram_addr.h
+++ b/include/system/ram_addr.h
@@ -166,13 +166,12 @@ uint64_t cpu_physical_memory_set_dirty_lebitmap(unsigned long *bitmap,
                                                 ram_addr_t pages);
 #endif /* not _WIN32 */
 
-static inline void cpu_physical_memory_dirty_bits_cleared(ram_addr_t start,
+static inline void cpu_physical_memory_dirty_bits_cleared(ram_addr_t addr,
                                                           ram_addr_t length)
 {
     if (tcg_enabled()) {
-        tlb_reset_dirty_range_all(start, length);
+        tlb_reset_dirty_range_all(addr, length);
     }
-
 }
 bool cpu_physical_memory_test_and_clear_dirty(ram_addr_t start,
                                               ram_addr_t length,
-- 
2.51.0


