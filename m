Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62096CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 08:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4EuH-0006wC-GI; Thu, 02 Oct 2025 04:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Eu5-0006rJ-Ee
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:43:09 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4Etn-0000ul-7R
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 04:43:09 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-46e33b260b9so7339755e9.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 01:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759394563; x=1759999363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/V6bK/dS4q8NfIVc1IYGAX2Y2n9tYdVPl2PhRG623tw=;
 b=TZ3mWS8Ss5SVxkpLnNN2TjDkuoJfBYj+ANI8kZWnUU17aQJ3K8TNkC5iM3UlhFipTh
 2KTi6TL18cDUjr5UK5AslOj0KniTklpK7bKgXSsteELoBFlqSWObq71EvVByrlT5/87F
 CaZ22b7DZG3L9arNYO7Bvq5hW+8hqDlhxmsrLDkK1hkfPRJKU22ZFx07Xqm2NcG3wQn6
 QdCeqgElu2ZAtZMAmB8Po7SD0MvvKvEwLgqWSWhxhlerwdzZ+Zjl/ga+b23irdcfwbI9
 wb/S2YgQY5oymWL+gDWDPgLqbGdcEKuZwky51dBwA1udCWC9m9ZsE1v2UHPPHIIjRoxc
 Etlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759394563; x=1759999363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/V6bK/dS4q8NfIVc1IYGAX2Y2n9tYdVPl2PhRG623tw=;
 b=KrwJZePWfzAmOu1WcRVVREAPi4qt1nz0d0dIDdM+FCEsajGFPtv2aizswu9Ky7tzSI
 KmRTHfaPWV/9WHruURLrPRFOGTPYOVTWr8eOdmkl6DNFgN3lVa9FEea6G2vxz47h/Yum
 G5uDp9gge0Xr9vI08kmNeVP5rqJMiBtLV65CGxoE0I/kXtW2yMGKfsbAl76SbaOlykds
 dPY7SLE6QXwmZ6jEeElmh35ECQPiNCnlQOC/qeYKCNxgaIggdBopCyKQQGQDnTRzvlK2
 eFfJyRlBapLbhLVxwSy3P6qG4np1nabhP8xZ6DUhtGpMnv39kvcBKEFXjisijlrK8eyE
 bPdQ==
X-Gm-Message-State: AOJu0YwtFQ0O2SQC/Ndig9tN1HFLMwV50X6tiOpmt2bJu/lremowd9po
 tQ9gYBoeUUOuHxtW1lu6AjaIcpMcZzgRCAynIGIxv12XA+X9OebK1vCi3ag7O9+Uccy6RAnrBFp
 8kZ23f26Mgg==
X-Gm-Gg: ASbGncvm2sAmKRAotRvwJxVuta93nJrBSjsg1KnpB27QKAzM97afnP2exoeLDMHdeuM
 FFl3ndhCpy9IMY2uddOHC++TDUioJ/tPBEy+EYCr3mpzcLLS2lEDzCtdilqFo/ESMPUxlU9HmSr
 jTXdWEUuW7+K++3cKPAZf1ZT4Fy9sQjiHekrZ6l79mYALUfRRgMk89PRR+T8M/E43cWjDyu7swD
 040aGb7j08QLxD8Xv3gsjgzNNO+j+r8eVIWlEfHEdNn4H2tWJd8YMSJjFUpMM+DdrUfwlARbk2H
 F4FkhxI8plNeFXPKtiLaYG0wi46RHpcl/ah2GZVPUCG77Cv6iOu6XaNI7mJsmqgQnTLK8oPoAeT
 fgPhpYLSy9gqThzVrnAUOgvL83LV8Z9h0cqWPCbvghelj4G7jDF0KWgq8PrvxnH02zB2faU/zHR
 EW97ZXMba1m5BpTOWk5QhPY9WBKbSLxw==
X-Google-Smtp-Source: AGHT+IFyxE2f+paPHZWS7atlHQE5YorXbC8H3ZNAWMF66wQjW+bist3zGSpvkgOszGdSmrRhuBdazg==
X-Received: by 2002:a05:600c:1d15:b0:46e:46c7:b79a with SMTP id
 5b1f17b1804b1-46e6125d269mr48068925e9.2.1759394563460; 
 Thu, 02 Oct 2025 01:42:43 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e6b23d4c5sm17135895e9.17.2025.10.02.01.42.42
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 02 Oct 2025 01:42:42 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH v4 08/17] target/s390x/mmu: Replace [cpu_physical_memory ->
 address_space]_rw()
Date: Thu,  2 Oct 2025 10:41:53 +0200
Message-ID: <20251002084203.63899-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251002084203.63899-1-philmd@linaro.org>
References: <20251002084203.63899-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

When cpu_address_space_init() isn't called during vCPU creation,
its single address space is the global &address_space_memory.

As s390x boards don't call cpu_address_space_init(), cpu->as
points to &address_space_memory.

We can then replace cpu_physical_memory_rw() by the semantically
equivalent address_space_rw() call.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/s390x/mmu_helper.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 00946e9c0fe..7bcf1810bca 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -23,6 +23,7 @@
 #include "kvm/kvm_s390x.h"
 #include "system/kvm.h"
 #include "system/tcg.h"
+#include "system/memory.h"
 #include "exec/page-protection.h"
 #include "exec/target_page.h"
 #include "hw/hw.h"
@@ -542,11 +543,13 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
     if (ret) {
         trigger_access_exception(&cpu->env, ret, tec);
     } else if (hostbuf != NULL) {
+        AddressSpace *as = CPU(cpu)->as;
+
         /* Copy data by stepping through the area page by page */
         for (i = 0; i < nr_pages; i++) {
             currlen = MIN(len, TARGET_PAGE_SIZE - (laddr % TARGET_PAGE_SIZE));
-            cpu_physical_memory_rw(pages[i] | (laddr & ~TARGET_PAGE_MASK),
-                                   hostbuf, currlen, is_write);
+            address_space_rw(as, pages[i] | (laddr & ~TARGET_PAGE_MASK),
+                             MEMTXATTRS_UNSPECIFIED, hostbuf, currlen, is_write);
             laddr += currlen;
             hostbuf += currlen;
             len -= currlen;
-- 
2.51.0


