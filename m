Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F1ACAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 14:16:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6UwJ-0002RO-Vk; Wed, 08 Oct 2025 10:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6UwB-0002HI-F2
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 10:14:39 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v6Uw2-0004Ul-52
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 10:14:39 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e6c8bc46eso48702495e9.3
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 07:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759932862; x=1760537662; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4yM+pXDT0hqzaeBLR0C86iQaEkYCbGu0SVKquEIwttY=;
 b=Zqan3CsnrtIZU0VONmg9W6llCqXzbvEbfDQI4GmYn059YZ8MJ9pRyvyb1Cem+/bgib
 5+ZPOm5z+4T4nRY7nLOKfSeP+k4KWTb8Q5MT6YN8sQmbHKMgGUDSWxBgDoh0Pwa3iKsO
 g7X/4+PYwZhB6nBf+88M2POd2Cca/LM9WaTH2/MDwW5eLA5GejTVyAPV/SXFcT46OZhB
 kStvQqvC/pJ1wyqz7TjIsUHXLfNV3pTrENpm62P8U6H+cZLQc1/l/qPH/6bPOH0Qqj2C
 l+jsj/Qn3ryqcex7MZB1TLsIYzXzp+UIM4bFcxDDFhU3Fbg5jC8+JXr4wmyegP4uBDdA
 1yVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759932862; x=1760537662;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4yM+pXDT0hqzaeBLR0C86iQaEkYCbGu0SVKquEIwttY=;
 b=t8o6cgdicDaUMjlgRGbYKC+aFlX3EmrkT18IqKQIK1Ctc9sWJKPV0KcdTdCmTEqDs3
 jnAl7SAc7TUCfORF1oQDHxnQBnaFizeuUdA4RR9AJrqDABSxH50oPWA/LTd/TMUMgW/G
 NKaxKmU7lYReR5GigfU6Gjw7cEGJY9K8TECUcAroslj1x1GP80njqb688YiI9LgZJzmA
 BZpXiLK4SSudL37Y+m83sv95PFq68HsT5H0CXZnNiRZmBimy+9gKbSMBMw18g1soDESe
 NAMUsaHrLSY9hcFhDCN1L8VPWY5xmPDShuKMRpjlQDVJQozPt5o4Qj0bQsyV5YM3ItA2
 ePOQ==
X-Gm-Message-State: AOJu0YyJn7Ks3osAg/oBgtcpH61BmfbqPPT9AmDJbLt3MJMkml+QZ/Wc
 dWg+c3VyVTWJPKTfPR+EBSC+ABl0hcFvPOOKR9AdKmqyql5k/5mBgr+d4hwKmkSfAStn9MtK+ww
 j1cdETkF/jg==
X-Gm-Gg: ASbGncvhv/52JD1FI7ybVjtFlqAnhtTq7IjYnOKrz+uU5B8gMHmFr2AHNm4axnLy+EH
 hhRaGCEclOrjUH1XkNDtOLMmvBkhk38EsMO/V1j+VTpz30YuWG0WmHi+IKT7L1xOC+fK6KlOHcM
 /ePZxmv0oOk+w5YUcV6USinHovUTb1HpciG+JPUt22e3C9nZ6e/WFGJ+TYjfythw/4+x9LlOz1w
 2aXa3mDUJ/GeOmj/xAf4LnGvtfiDVgZK6xgDhmR17+jHqoheD8W3wBfo/UIEgpmZLlQIxf2cOA1
 4mzBkhw/uUNaa3hnVQUE6/ge7QprzonNwLLH/ceg170rkwp/Ez+J9n6fQtFI8FmRY3q3J8JOyHK
 bWtJDgQqmOODZ8eEtKXougqfnR0dabdPb1NTHg2A2wMmXGdU5XQLBSwKOVPaF5/LJUwXxJOjG+z
 SqrCpHeWTzppGZHjadnmz312F3
X-Google-Smtp-Source: AGHT+IFI0ssxCRpnhXfm92OZl54QVm/v6Fat/+Oj+c2gMyyGj+NlbIUTLjia7iKLWTsCb6LoPL0aCA==
X-Received: by 2002:a05:600c:3b08:b0:46e:53cb:9e7f with SMTP id
 5b1f17b1804b1-46fa9af830fmr27402115e9.18.1759932862063; 
 Wed, 08 Oct 2025 07:14:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46faf185c7esm1309775e9.19.2025.10.08.07.14.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 08 Oct 2025 07:14:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-s390x@nongnu.org,
 Ilya Leoshkevich <iii@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/2] target/s390x/mmu_helper: Do not ignore
 address_space_rw() errors
Date: Wed,  8 Oct 2025 16:14:09 +0200
Message-ID: <20251008141410.99865-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251008141410.99865-1-philmd@linaro.org>
References: <20251008141410.99865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

If a address_space_rw() call ever fails, break the loop and
return the PGM_ADDRESSING error (after triggerring an access
exception).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/s390x/mmu_helper.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 22d3d4a97df..3b1e75f7833 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -546,9 +546,15 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
 
         /* Copy data by stepping through the area page by page */
         for (i = 0; i < nr_pages; i++) {
+            MemTxResult res;
+
             currlen = MIN(len, TARGET_PAGE_SIZE - (laddr % TARGET_PAGE_SIZE));
-            address_space_rw(as, pages[i] | (laddr & ~TARGET_PAGE_MASK),
-                             attrs, hostbuf, currlen, is_write);
+            res = address_space_rw(as, pages[i] | (laddr & ~TARGET_PAGE_MASK),
+                                   attrs, hostbuf, currlen, is_write);
+            if (res != MEMTX_OK) {
+                ret = PGM_ADDRESSING;
+                break;
+            }
             laddr += currlen;
             hostbuf += currlen;
             len -= currlen;
-- 
2.51.0


