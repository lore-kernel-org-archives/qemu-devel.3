Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52E33C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 20:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk8Xb-0001rp-DN; Tue, 12 Mar 2024 16:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rk8XE-0001py-O4
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:15:42 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rk8X0-0001OY-1i
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 16:15:27 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-413e613316cso2475315e9.1
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 13:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710274524; x=1710879324; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eKgsu7QFjVLGSprUDHjOGJwaVzxS/YEnXMOQmjF1L3E=;
 b=NciexrSEsXlrPIvX0KYN7uoJn5DN5ULnl+I9bFF69sGluT8jLXfPlSfhMX/w4PBh8p
 5j97wiUlpoBSHTXKFJMCdYJ9TZ6I7u1N5/YrDu6SZGG76r4nDc9RPout611EEazyerTE
 et5xeT2m4BOUXHJXRRm4bn7SP5ld9lsUVTZ2h7xkg6nMgi49rCX/bK84UrpYmLoTGHT1
 QzC96OoMPT+vNl14kI0yguHf08A/lxoYDbjtr61or3v/tu3QKR58Ks73ztWoQiYclabe
 jSSYKHN6mcp6GLb8sJTcj002V9kjmn+PwpI9IBGPhEo8qhcc4Fb26Lpq93hJ3hPK9en3
 hAeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710274524; x=1710879324;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eKgsu7QFjVLGSprUDHjOGJwaVzxS/YEnXMOQmjF1L3E=;
 b=kzUA7YdvX0Mh3VFLtGqlQaVPiFPX7KYC4fVVHOBv2kyH2wXd1JyKmPiXBb0ecT5u7R
 sCuMPkLzopx0sOTAb24EFMDslCCxQwpYJEbDDZyA9OdSD9j6BBpqK7j/d2YA/2dAlZnF
 qTnm/G5fWKWtqfb7/JdsEOU+SvKplN7MN2Xl8iKyE+PlrpF73kJoi2i5NEFCjruz+HIW
 OV4qpKaWYSIKmFJ5Q8ca4rMwx5SIL5KyMCK+mPpmQToL6tKf2a/GpYa9Xs+rIIFcjsom
 PWGg2MAiN+QYaEmjFkt0pwXy0Q0TLOBXoGb9UQrUgAZwbG7nmWzUl6CqY+ywvonDjMIJ
 TYBg==
X-Gm-Message-State: AOJu0Yx3vfY3L22NjcoggHF8MDcFyNseZ5KrOSh0jBHTcZfCHQdAaJ8D
 rTvQ3n+pk/bIpw3GbC3bN0GuOl2Uv1KtsLOJBI2vzWEPnoCZ/EBYNw8+dOwFJfhFn2czjdVs/ZK
 rf28=
X-Google-Smtp-Source: AGHT+IHdaZ/7Q+qy9t7JqlHrJ8kcRM9zyWRvVUW0w7bJGO8b/Zf4WhzZHumAZ069WeyJwkFIa+Teow==
X-Received: by 2002:adf:e445:0:b0:33e:7cc6:9936 with SMTP id
 t5-20020adfe445000000b0033e7cc69936mr305337wrm.21.1710274523950; 
 Tue, 12 Mar 2024 13:15:23 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.206.139])
 by smtp.gmail.com with ESMTPSA id
 q18-20020adf9dd2000000b0033e90e98886sm7230234wre.71.2024.03.12.13.15.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 12 Mar 2024 13:15:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 v2 3/3] physmem: Fix migration dirty bitmap coherency
 with TCG memory access
Date: Tue, 12 Mar 2024 21:14:58 +0100
Message-ID: <20240312201458.79532-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240312201458.79532-1-philmd@linaro.org>
References: <20240312201458.79532-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

The fastpath in cpu_physical_memory_sync_dirty_bitmap() to test large
aligned ranges forgot to bring the TCG TLB up to date after clearing
some of the dirty memory bitmap bits. This can result in stores though
the TCG TLB not setting the dirty memory bitmap and ultimately causes
memory corruption / lost updates during migration from a TCG host.

Fix this by calling cpu_physical_memory_dirty_bits_cleared() when
dirty bits have been cleared.

Fixes: aa8dc044772 ("migration: synchronize memory bitmap 64bits at a time")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Tested-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20240219061731.232570-1-npiggin@gmail.com>
[PMD: Split patch in 2: part 2/2, slightly adapt description]
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/exec/ram_addr.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
index b060ea9176..de45ba7bc9 100644
--- a/include/exec/ram_addr.h
+++ b/include/exec/ram_addr.h
@@ -513,6 +513,9 @@ uint64_t cpu_physical_memory_sync_dirty_bitmap(RAMBlock *rb,
                 idx++;
             }
         }
+        if (num_dirty) {
+            cpu_physical_memory_dirty_bits_cleared(start, length);
+        }
 
         if (rb->clear_bmap) {
             /*
-- 
2.41.0


