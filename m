Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A01C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 21:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAbLf-0000rm-9N; Thu, 01 May 2025 17:21:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLQ-0000lJ-5g
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:26 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uAbLO-0001Rw-IL
 for qemu-devel@nongnu.org; Thu, 01 May 2025 17:21:23 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-afc857702d1so1489555a12.3
 for <qemu-devel@nongnu.org>; Thu, 01 May 2025 14:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746134481; x=1746739281; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q8/gUh8ns0OI2KXninhYbAotAkB5LmkpT0e10M7S7xU=;
 b=j5b+3fwd04ZHbMTDfk3PN043Sy5sg2QsmP8B8Ut01UTXJOjj4nTIohVhKhaqBVCTXV
 sCy91v347pSmFV8p5B4VcCad+IrR8PYKTG0yX6ncGyHIfm2lF78gizTLJqornb0mq793
 QasifpzfRk0ZQ6DJBeIpLrndyJGmKVo+fR78b6gMAMAPFSGmJUK7ap5s2KR0mM3GSm0b
 QYScUR7KB46g3m5n/YXJQGzzDiOmn4Ng0ZiGj9o+En07SjJfCdzmRQ5+BobtZ8L+pBuC
 CAFAZboASXth+3TQrxzUfrSVHFHVLFbh4vQ7RFfH1rpec+07PxIfkj23zhustn6qXhsg
 nFPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746134481; x=1746739281;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q8/gUh8ns0OI2KXninhYbAotAkB5LmkpT0e10M7S7xU=;
 b=Cr1XcR1sLjakX28qWMIqt8dwMf1nhL8RTv749GPX6FDp5unNYuw+BVVZG6fvI9meh2
 Vm+pvZjR/m5D9qy3PLwi5/M64MqT4F66+k4u88Y8GNx9WT5RGRXUkr4LjvmAhTAUe93F
 1eprCFF20fxPxjQCe9k//Jxa8MiKOqxBvpw/NlGW2/isOm3hgo48LSQAtm6CifhA8xUD
 oDn3z4vb4nBRJCMqN/x7BhgrK03lGfVT536TxWhxOmDyJltyAP0OOZKbz0QMRJyVUjwJ
 KN7iiZq0KOW9jqsGWUd2b6ab3+SarxwkKSnnZhAhlCNphbxFRNHytaWFu817ShaXnvgM
 2CMQ==
X-Gm-Message-State: AOJu0YyIEaHxoD00Ois7VsDMzA2dhR0tTpakk6pdFoDuk3hZeNpeG/Fi
 MQVem64OkE3CprWSeHunaJyYMTZZNQNYCvxKnPG0BRNMM6iZxc7avVFg263waKxE+aGfYHxthII
 q
X-Gm-Gg: ASbGncuV8cnalNNi0H6tYD7TCzcT9f8XqU+2z7UEfsy3owa5gcPHOVgm5QGOm1wSOFY
 2M7cLcOVc/VhZtRWQ7YBQT8OqfDxGCPVa2yzfUKU8RYOZjlt8hoLU/n2iBX4TNYIrHBMy++PRxD
 t0Z93CongBf5hsQ8R4stqduZ1ihwShDpCwg3rQ4O1hIJ8xNx4n2IsWrcMR55vfGZ+irY37BD5wA
 brMnsBHYy1gyZ+HJPLVA/A8Hgw5K/y3+og7whewcPRCI4X9KgBtKeWEZFkE5L97H8qRCXpPjVnH
 TYszC8fOtscKpnvDT2ytLjsJG6FwwLojJMAWOKdOwRIMgqUmLFNPTO8nUtpC0cYKGp3QImFadZQ
 =
X-Google-Smtp-Source: AGHT+IFFSRRRp9YOiVdtJA9S8k8T64pH04xqkieXgILhhGjBcammyjlwsBFiBRd1ZqVlDpzgVgf2CQ==
X-Received: by 2002:a17:90b:4e8e:b0:2ff:53ad:a0ec with SMTP id
 98e67ed59e1d1-30a4e5d58e3mr802224a91.21.1746134481210; 
 Thu, 01 May 2025 14:21:21 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a476267e0sm1384573a91.39.2025.05.01.14.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 14:21:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 08/59] accel/tcg: Simplify CPU_TLB_DYN_MAX_BITS
Date: Thu,  1 May 2025 14:20:22 -0700
Message-ID: <20250501212113.2961531-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250501212113.2961531-1-richard.henderson@linaro.org>
References: <20250501212113.2961531-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x532.google.com
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

Stop taking TARGET_VIRT_ADDR_SPACE_BITS into account.

Since we currently bound CPU_TLB_DYN_MAX_BITS to 22,
the new bound with a 4k page size is 20, which isn't
so different.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/tlb-bounds.h | 21 +--------------------
 1 file changed, 1 insertion(+), 20 deletions(-)

diff --git a/accel/tcg/tlb-bounds.h b/accel/tcg/tlb-bounds.h
index efd34d4793..f83d9ac9ee 100644
--- a/accel/tcg/tlb-bounds.h
+++ b/accel/tcg/tlb-bounds.h
@@ -7,26 +7,7 @@
 #define ACCEL_TCG_TLB_BOUNDS_H
 
 #define CPU_TLB_DYN_MIN_BITS 6
+#define CPU_TLB_DYN_MAX_BITS (32 - TARGET_PAGE_BITS)
 #define CPU_TLB_DYN_DEFAULT_BITS 8
 
-# if HOST_LONG_BITS == 32
-/* Make sure we do not require a double-word shift for the TLB load */
-#  define CPU_TLB_DYN_MAX_BITS (32 - TARGET_PAGE_BITS)
-# else /* HOST_LONG_BITS == 64 */
-/*
- * Assuming TARGET_PAGE_BITS==12, with 2**22 entries we can cover 2**(22+12) ==
- * 2**34 == 16G of address space. This is roughly what one would expect a
- * TLB to cover in a modern (as of 2018) x86_64 CPU. For instance, Intel
- * Skylake's Level-2 STLB has 16 1G entries.
- * Also, make sure we do not size the TLB past the guest's address space.
- */
-#  ifdef TARGET_PAGE_BITS_VARY
-#   define CPU_TLB_DYN_MAX_BITS                                  \
-    MIN(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
-#  else
-#   define CPU_TLB_DYN_MAX_BITS                                  \
-    MIN_CONST(22, TARGET_VIRT_ADDR_SPACE_BITS - TARGET_PAGE_BITS)
-#  endif
-# endif
-
 #endif /* ACCEL_TCG_TLB_BOUNDS_H */
-- 
2.43.0


