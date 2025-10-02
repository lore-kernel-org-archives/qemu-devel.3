Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A64D6CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 08:45:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Eul-0007JX-Sx; Thu, 02 Oct 2025 04:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Eud-0007G6-EE
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:43:43 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4EuJ-0000yw-8Y
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:43:41 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-46e3ea0445fso3918025e9.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 01:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759394592; x=1759999392; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=32KTyTEIv4S+xafyswExVd2MIXheWFL9qAvbf+ZRZFI=;
 b=N4vLp1jgJQnysNWp4hvGNLttNpS/WSQET3UdlcXyy04EMyAUqMZ6jQwEeyolWQeKOW
 sWw/nBmC8XvVfvxTA74WPJn6YtZ6BU/BfffOsqFGOGHQXmHAbYz9GEgd1wBCbENtOwql
 k0C1RHQQmL5Iubsq5UU+Xm80+rjymxBoAEYeEuDGhxBMgDi0hjQeRTePm7yIb6uAxwrh
 ttxv57U5uuBr8nFm6jZzgvLaZKMDwlygs/dE20xI4G6jhkfk2fc+K4cQexukQI2T6LyP
 TFF9s4ZD68tDpAhFhmLhyOLtlp4XnUjqmP2tmbNFWo0h2aGTkPeXL2dbgiAqE8InhIEu
 lWmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759394592; x=1759999392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=32KTyTEIv4S+xafyswExVd2MIXheWFL9qAvbf+ZRZFI=;
 b=qfis2Nz2XJjQXmR+l9KGGPyLBFewU67eBZJExNbeV7UQFvcn3jUVUxCpZU5WUEBJXe
 Ef6LwTdHgJwfpeBCqOiIFmH35RHO51H/csyOXRSRCC9ve8o0IraSQBIWGxJcVzTRksD4
 EyOe01uI9P82MGetcsRJDkuzBF7dRKDZ/FbY1VHOtYMUBKtZ2cw5JzG3mirASbMX/rIq
 8+m68oOSyIgN/HlJFCCZTvLEGevYr9+c+bP4qGnsOyu2+8PkuqWhEdxoDNICSoFSjTIA
 Qr8tq6ZhUM0NKVENuD2FsKdCK1dUHTsc9sKW6SFYeq+MaOmIdjmuHZVXAX0/I2315wmT
 p0xg==
X-Gm-Message-State: AOJu0Yzr8tjfFJumbSx9RX8jjwYxEYx53kQ7ys9V6jXgD7TZJzVlfhZR
 ENgcjd4jlBheU78jX8Q1Jo4yuTH1YexOXhr8vS3N8qDmLzrtyaag8Lqb7qExflXg+3fZ/Vbx5bn
 I7S3M91hbIw==
X-Gm-Gg: ASbGncuOLCK482REdK2mDXkW3dZh0dT+ao+Iaye4IN3Wydnkn7divXqJdLfFui1aimj
 lEIofoDMl5maDhCS407tCxRgUZdnx5In4q+iLqtRt851pOZ8ap7f3HfvR0EoyRvOjkeD922VtT5
 y4uK9ndWnhUUIHRGx4TfApjJAc40f2cG1tRxz69hKg4i+SuVqzA8me2Eek39jGskJKlnTOk2ZNQ
 RsXFqnlxB1A8a8IGRD62pMGRu1f3yD4WHvW2NeqoC0KhPbrUK127YwEuWarbE6/2C4cD7/IMzvj
 D/ZGZ7uwUrmn2/KEYlSMRtdab1rgaxOCRNw8pJ18PwakJVqFj9Nt0Z7RyecgkYaR1NIS19/w1NO
 Jiah6ty+H+EcdBhqRJDmUCBi4L9YCC4O4qJUC95wKX3g1yk2OfPEAGe670bwDsL21a/QhuuP/sj
 T0gcJ+2DNALErf/5Aa8tyIqg0ChVwnCA==
X-Google-Smtp-Source: AGHT+IEZQOIEqlGUv6pO69td5pzAzxUa79bMkjYW9qkw21+3BvVHY7MhQ8EnUXVp5wD/RikWOGCbpQ==
X-Received: by 2002:a05:600c:8b37:b0:46e:4329:a4d1 with SMTP id
 5b1f17b1804b1-46e61202280mr56814795e9.4.1759394592450; 
 Thu, 02 Oct 2025 01:43:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e61a0204fsm73877065e9.14.2025.10.02.01.43.11
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Oct 2025 01:43:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 14/17] system/physmem: Avoid cpu_physical_memory_rw when
 is_write is constant
Date: Thu,  2 Oct 2025 10:41:59 +0200
Message-ID: <20251002084203.63899-15-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002084203.63899-1-philmd@linaro.org>
References: <20251002084203.63899-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Following the mechanical changes of commit adeefe01671 ("Avoid
cpu_physical_memory_rw() with a constant is_write argument"),
replace:

 - cpu_physical_memory_rw(, is_write=false) -> address_space_read()
 - cpu_physical_memory_rw(, is_write=true)  -> address_space_write()

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 scripts/coccinelle/exec_rw_const.cocci | 12 ------------
 system/physmem.c                       |  6 ++++--
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/scripts/coccinelle/exec_rw_const.cocci b/scripts/coccinelle/exec_rw_const.cocci
index 1a202969519..35ab79e6d74 100644
--- a/scripts/coccinelle/exec_rw_const.cocci
+++ b/scripts/coccinelle/exec_rw_const.cocci
@@ -62,18 +62,6 @@ symbol true, false;
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
diff --git a/system/physmem.c b/system/physmem.c
index d5d320c8070..23932b63d77 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3190,12 +3190,14 @@ void cpu_physical_memory_rw(hwaddr addr, void *buf,
 
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


