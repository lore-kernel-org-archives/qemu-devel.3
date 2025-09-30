Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBFACAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 04:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3Rli-0002UT-Pa; Tue, 30 Sep 2025 00:15:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Rlb-0002OG-7e
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:15:08 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3RlV-00019J-Hr
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 00:15:05 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46b303f7469so36841705e9.1
 for <qemu-devel@nongnu.org>; Mon, 29 Sep 2025 21:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759205699; x=1759810499; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FwO23E8zQD3tYxR1qcdfXict3HnZqpkDFtM6ocAlj5I=;
 b=h8gBZDxnUYiT/ROMNxMXngUfW8Jv+1yHdkP0EtHkVyti2akvvfSt2UtZeHEaaEKR2C
 QZWMcK3m7sXEIGAqvWHZoJg4Oz2OM5G1bvo4ioW+ZrSi+DO4IzHKXkkaiFHmlIW3ipHZ
 1NdoA579aD0Akon1A9UWJEJ4PcJweMKvaV9j8AVsMgXn8IWcM9uW2mlCbjshO/8cycbi
 XZD6mjRKgK3IoOqSPIHajbu4NiVErjcp8g2g6pcmhJKht2VRgfpVOea/+kwgPNrMjZes
 UsBVkFQosSdgE/zMjPfxfZIerI1DpXMTZcCtUylc/EMWkT5Igp8RNTnE+/fwCsUlnxrF
 U6cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759205699; x=1759810499;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FwO23E8zQD3tYxR1qcdfXict3HnZqpkDFtM6ocAlj5I=;
 b=aDnW4dlDuGgUz9fI2OURiqg1PAHhZGavF7EA6smn6L97HKbPQi+BFASGXKAnvz3rtY
 wyQ8RWYMGo3t+0C4qDtyqiJ5/UJV3/k055QUCd1d+BO1SS/7dXAqHNjijI5s47WpUfoR
 7HnfYzymSIifQj88kMdVODuFGL9ROcYuVt6Y0B0zj6SG4L14ol6XyZ5r+utsEWHiNrNr
 r7MaO/ziPOOlS20cM8MTNsWz7dttxGtd/zN8dS/FWA+BBBby+ppmVhVViLCYnAcxM59J
 DQ2FI+qwIdOSbkJG79tuYm0M+B8GVaebp2JHcTyEVqsoU+u9IFA4kCllEznVKV2zjch0
 gZYw==
X-Gm-Message-State: AOJu0YwoYpqAbCNAGy9C6OhpPc4Vsz6CjkcADtp2A5kHi2Qzb7XGzZsn
 zUP2xXwFe5HJCCOYLgMk20Y51x3yfpORuzwxeOW2qV7qbX82kW4C+kIyYaWpqL26h0Ppimm+9NK
 YgNjlajqJcg==
X-Gm-Gg: ASbGncsrD076SQsFK+E0FEwM8mPxIZVTmreMh5Qr0EkntoROnZ1X/YPqZiqOZ5+khAG
 6xUmHKAQlqaWazrA2kqrpViYda/nbjqsTnxd6yhRshfzcZkqOA6fx7Sq6XmDbzsFK8PvHxTqy4b
 wGds0JKWAKlNZb1xDP3057kL8wwB0e1V7YjvPd7nmGn1B3zIH5vzL4GqIlYGok4Aion+Ex4aTqR
 2mox3IYywf8p7Rcm8PsZXnIqx4oIhdgg0AdyGpcO3qkCqFi1PfmJo1nQJwuQM8tYgP0lDJ+1Hto
 kEBRP1vegTzG6eaWoH7y3+W+uB9kV6j6nmcvTi0RFmMbha1GoBmfjckIMwXVkR/f/nhmgoas1sb
 RI+aPcnpZuT+hKMCrj0pEiTiR1w7AT95/lTHLIl+xxPXPy8E5PLsayYRc9USlDM7Y6zBiL4JYTQ
 0bHX/dqcqmQzR+A6E45wtgFVRX20RPHIzt3LgghK0uOw==
X-Google-Smtp-Source: AGHT+IHQUeMIWrPOvhxUlcXifIoWvE3/8AU9Ob5ucePyts2g6/ZGYEFjge5tsRgBwyw13Vrh3DLZdg==
X-Received: by 2002:a05:6000:430d:b0:3ed:a43d:e8c4 with SMTP id
 ffacd0b85a97d-40e458a9856mr16110543f8f.6.1759205698778; 
 Mon, 29 Sep 2025 21:14:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb72fbb27sm20526091f8f.4.2025.09.29.21.14.56
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 29 Sep 2025 21:14:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Herne <jjherne@linux.ibm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Stefano Garzarella <sgarzare@redhat.com>, xen-devel@lists.xenproject.org,
 Paolo Bonzini <pbonzini@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 Eric Farman <farman@linux.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Reinoud Zandijk <reinoud@netbsd.org>, Zhao Liu <zhao1.liu@intel.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 15/17] system/physmem: Inline cpu_physical_memory_rw() and
 remove it
Date: Tue, 30 Sep 2025 06:13:23 +0200
Message-ID: <20250930041326.6448-16-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930041326.6448-1-philmd@linaro.org>
References: <20250930041326.6448-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

After inlining the legacy cpu_physical_memory_rw() in the 2 functions
using it (cpu_physical_memory_read and cpu_physical_memory_write), we
removed all its use: remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 docs/devel/loads-stores.rst            |  4 +---
 scripts/coccinelle/exec_rw_const.cocci | 22 ----------------------
 include/exec/cpu-common.h              |  2 --
 system/physmem.c                       | 13 ++++---------
 4 files changed, 5 insertions(+), 36 deletions(-)

diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index f9b565da57a..c906c6509ee 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -460,10 +460,8 @@ For new code they are better avoided:
 
 ``cpu_physical_memory_write``
 
-``cpu_physical_memory_rw``
-
 Regexes for git grep:
- - ``\<cpu_physical_memory_\(read\|write\|rw\)\>``
+ - ``\<cpu_physical_memory_\(read\|write\)\>``
 
 ``cpu_memory_rw_debug``
 ~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/scripts/coccinelle/exec_rw_const.cocci b/scripts/coccinelle/exec_rw_const.cocci
index 1a202969519..4c02c94e04e 100644
--- a/scripts/coccinelle/exec_rw_const.cocci
+++ b/scripts/coccinelle/exec_rw_const.cocci
@@ -21,13 +21,6 @@ expression E1, E2, E3, E4, E5;
 + address_space_rw(E1, E2, E3, E4, E5, true)
 |
 
-- cpu_physical_memory_rw(E1, E2, E3, 0)
-+ cpu_physical_memory_rw(E1, E2, E3, false)
-|
-- cpu_physical_memory_rw(E1, E2, E3, 1)
-+ cpu_physical_memory_rw(E1, E2, E3, true)
-|
-
 - cpu_physical_memory_map(E1, E2, 0)
 + cpu_physical_memory_map(E1, E2, false)
 |
@@ -62,18 +55,6 @@ symbol true, false;
 + address_space_write(E1, E2, E3, E4, E5)
 )
 
-// Avoid uses of cpu_physical_memory_rw() with a constant is_write argument.
-@@
-expression E1, E2, E3;
-@@
-(
-- cpu_physical_memory_rw(E1, E2, E3, false)
-+ cpu_physical_memory_read(E1, E2, E3)
-|
-- cpu_physical_memory_rw(E1, E2, E3, true)
-+ cpu_physical_memory_write(E1, E2, E3)
-)
-
 // Remove useless cast
 @@
 expression E1, E2, E3, E4, E5, E6;
@@ -93,9 +74,6 @@ type T;
 + address_space_write_rom(E1, E2, E3, E4, E5)
 |
 
-- cpu_physical_memory_rw(E1, (T *)(E2), E3, E4)
-+ cpu_physical_memory_rw(E1, E2, E3, E4)
-|
 - cpu_physical_memory_read(E1, (T *)(E2), E3)
 + cpu_physical_memory_read(E1, E2, E3)
 |
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 6e8cb530f6e..910e1c2afb9 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -131,8 +131,6 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
  */
 void cpu_address_space_destroy(CPUState *cpu, int asidx);
 
-void cpu_physical_memory_rw(hwaddr addr, void *buf,
-                            hwaddr len, bool is_write);
 void cpu_physical_memory_read(hwaddr addr, void *buf, hwaddr len);
 void cpu_physical_memory_write(hwaddr addr, const void *buf, hwaddr len);
 void *cpu_physical_memory_map(hwaddr addr,
diff --git a/system/physmem.c b/system/physmem.c
index 6d6bc449376..a654b2af2a3 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3181,21 +3181,16 @@ MemTxResult address_space_set(AddressSpace *as, hwaddr addr,
     return error;
 }
 
-void cpu_physical_memory_rw(hwaddr addr, void *buf,
-                            hwaddr len, bool is_write)
-{
-    address_space_rw(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
-                     buf, len, is_write);
-}
-
 void cpu_physical_memory_read(hwaddr addr, void *buf, hwaddr len)
 {
-    cpu_physical_memory_rw(addr, buf, len, false);
+    address_space_read(&address_space_memory, addr,
+                       MEMTXATTRS_UNSPECIFIED, buf, len);
 }
 
 void cpu_physical_memory_write(hwaddr addr, const void *buf, hwaddr len)
 {
-    cpu_physical_memory_rw(addr, (void *)buf, len, true);
+    address_space_write(&address_space_memory, addr,
+                        MEMTXATTRS_UNSPECIFIED, buf, len);
 }
 
 /* used for ROM loading : can write in RAM and ROM */
-- 
2.51.0


