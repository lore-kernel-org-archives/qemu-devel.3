Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79039C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 13:11:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trzJz-0006A6-PO; Tue, 11 Mar 2025 09:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzEx-0005yo-TL; Tue, 11 Mar 2025 09:01:48 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trzEw-0000LW-6c; Tue, 11 Mar 2025 09:01:47 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2feb96064e4so10452685a91.1; 
 Tue, 11 Mar 2025 06:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741698104; x=1742302904; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ilno9T+zEsi8ai9jccA8FciMmreT00QeJlMccgO6CII=;
 b=eC1sNM8M2L7mnzvbf7oFH8kDhaP8kFy61ubLRZqrUTfyKZxAHJjbO/F5KDWTfWZl/n
 wuqli2wMNm20qXUJi5twIhYUVQqIz9GamMMTFEkwylRkvfUfrN0bnUyOzWhv1E7LSQTb
 BYlkGTb0L0uuvxS63HSDMO5vdxDeKdFhhDa9RPmnAH3OyEHc7HLySvjdiCbfKo3ZyxvD
 ffCokiVsV7N5fQHlYIVsAgJ36YacwpBjjFccKVaauVygpV8KwwoNpkS29ROBQyXVRKod
 tI4q5klWWK3m4rvtzsZ/wpnUHmmNU8CFlcULYrBQlW8HrpUTbDn/2ViXzJhXMXDQVJ3b
 ZCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741698104; x=1742302904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ilno9T+zEsi8ai9jccA8FciMmreT00QeJlMccgO6CII=;
 b=WdQCkac2XWbaEcloklwZAttmRBTvJ1eC6JB6tXHCHbctRxligDSHAt8OayDh377NE9
 bdaEJuEIp8Q14L9Gu/ubeua9leJuwqRpWGqJuccXLwQFvKfPL2FYOP6s2ZmiTosq3jSH
 GgfGz5E6kDYE6SVxe3FLQEvv371BO7QCkN5/g2ilVQwiAU3cSG6vlVIN6I3UjV1uQuh4
 Fd80X2WL6cwknAwwNpV47viNtuhv4liAYpbrO5NRDvKPmwEqteuOIWYiSm5IvYqEub2I
 i4DR0CAxjCiotnjZ3xEREmfGNBEHDvs2FaO/JpVU28nRLkYipe3hgjT06jIMIvtNj38J
 fBPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWr0Z75IlGlOOIQRdJfSCGS6oiQOAbcYzOQ0GsGdFfVJ3cjPajvFukRGFYAHE0YPlwL89TfB/O3Ig==@nongnu.org
X-Gm-Message-State: AOJu0YxbeOIvMPWdMwUa9svc3RUDnTiJGpxf57wPlrNWuWdMdQ+4yhHV
 a7h35CI6KLwbSIRFEoiZSABu06sz8Z3heMYcgpKIgfgHPFu8rBV1/Y5S1w==
X-Gm-Gg: ASbGncuRq8R83hTEZaOXR1nJYKvsWNrc1xXZC961dPWzs2tknTjJtLbprhU4sb2DHvT
 qT4EnpEFvnKb6mQkQbH2YDBHBAXwlP/rXYDBb8yLqk8vqDKsIc0HkRD+BNshviXbl1mLk75bn9l
 Y6KfSCRAmBOJ8DBpPrstqzFkL4j6JtDuV5s6Ai/JaHh0AYc5u7DzpP9ClUg1iIEK+RTFG4cgDiH
 b7FZcNPY0tFKF7n7lRTwTGTjS+bTC0f4SioV5a3WG+6PKA9M29ROSKbfnBY3rK2mx1PrGGGwADP
 r6aNOvlBmt+cGE884pW922VNgIqDXB9g9WvJzfEP2HUbXqkU5owaRcYtVQBjOA==
X-Google-Smtp-Source: AGHT+IHMU9Ha3HMA9N1E6G3VfYwY0OTrH/wycKuKcP6q00DRV4soyT0f4SifW/kAixS1ZMl6KA+VAQ==
X-Received: by 2002:a17:90b:1d0a:b0:2ea:83a0:47a5 with SMTP id
 98e67ed59e1d1-2ff7ce457acmr25997767a91.4.1741698104252; 
 Tue, 11 Mar 2025 06:01:44 -0700 (PDT)
Received: from wheely.local0.net ([118.208.151.101])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e773dddsm11822318a91.12.2025.03.11.06.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Mar 2025 06:01:43 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
	qemu-ppc@nongnu.org
Subject: [PULL 65/72] target/ppc: Avoid warning message for zero process table
 entries
Date: Tue, 11 Mar 2025 22:57:59 +1000
Message-ID: <20250311125815.903177-66-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250311125815.903177-1-npiggin@gmail.com>
References: <20250311125815.903177-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

A translation that encounters a process table entry that is zero is
something that Linux does to cause certain kernel NULL pointer
dereferences to fault. It is not itself a programming error, so avoid
the guest error log.

Message-ID: <20241219034035.1826173-5-npiggin@gmail.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/mmu-radix64.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
index 1d3d9e1be7..461eda4a3d 100644
--- a/target/ppc/mmu-radix64.c
+++ b/target/ppc/mmu-radix64.c
@@ -571,6 +571,20 @@ static int ppc_radix64_process_scoped_xlate(PowerPCCPU *cpu,
         prtbe0 = ldq_phys(cs->as, h_raddr);
     }
 
+    /*
+     * Some Linux uses a zero process table entry in PID!=0 for kernel context
+     * without userspace in order to fault on NULL dereference, because using
+     * PIDR=0 for the kernel causes the Q0 page table to be used to translate
+     * Q3 as well. Check for that case here to avoid the invalid configuration
+     * message.
+     */
+    if (unlikely(!prtbe0)) {
+        if (guest_visible) {
+            ppc_radix64_raise_si(cpu, access_type, eaddr, DSISR_R_BADCONFIG);
+        }
+        return 1;
+    }
+
     /* Walk Radix Tree from Process Table Entry to Convert EA to RA */
     *g_page_size = PRTBE_R_GET_RTS(prtbe0);
     base_addr = prtbe0 & PRTBE_R_RPDB;
-- 
2.47.1


