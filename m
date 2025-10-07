Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012F7CAC5B8
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 02:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5xAF-0007fU-74; Mon, 06 Oct 2025 22:10:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v5xAD-0007f6-UC
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 22:10:53 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v5xAC-0007Y6-4E
 for qemu-devel@nongnu.org; Mon, 06 Oct 2025 22:10:53 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e34052bb7so61671205e9.2
 for <qemu-devel@nongnu.org>; Mon, 06 Oct 2025 19:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759803049; x=1760407849; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ySfAAbFKY8KttDoTTOQWnSi2YyRSn4yibwJ8KUTlcLY=;
 b=uauACX/et+TwltQoh084m5RKhLSlozEn44LDcHejVY0m2xGRLeUYTQH6O8f736GWr1
 HzgXmxrhfByLHsdKcwZf8b4Ur/pEqnSvazJIcgP7gICKyvn7O/4lP0JEKEEeWGk5hgNA
 zblps6vSMa7dm2zjktEMVD0gMF/1eVnzNNJas6o5iuIDs9T1KTvpYR6q+GZlBfOzRaem
 92tNt4+qKI8FNjUZYdWypYql49zG2ILoevqUhGu9kJh5E7Bn1v2MkIgEFs3sl9B8cAM+
 439192ubU+x2SV2eJfP/1azAcxsrZhyagpfSSGGAgKr39+n1F0kCzCZSkUDvmRBOaXjP
 sBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759803049; x=1760407849;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ySfAAbFKY8KttDoTTOQWnSi2YyRSn4yibwJ8KUTlcLY=;
 b=Y1oUxTEua9EnL4+y2L9ux1nB1HJRn/HM2fQV9fB+J1ZfIO9JKq7Z4QsjwlRhPM3qDC
 utHNtQEaHlZmWnfj+nldn+0brxatp3zAJUGlzCDbf5RHDDXzk4jyOzu6P01EyQIr3nii
 RQ4IUQOrGo5tyTPspWvczPQ8iOvN1G4bKknD4LalHOXqhj7MRRwe9rJHmyhAEbUyRzDo
 YDhquRaK+D5h3eOa/PJI7M4d9xraNzmSZG6HvGRTDOIrN7E6oogh9XOUlb/mAO/7h5lp
 xvry9VArJSu6J4PY5OqGQ30EoI3my0+2OIxXXT45eGT2GHeFY3aF384/gxfw0Wudam6y
 oIgQ==
X-Gm-Message-State: AOJu0YyxiM0Kze2so/dM6kX8hf3XOBnQgPJ3zd/tD156lUeqa+iiM0Zm
 tY0bd/kr23JmjpU1ZZMOG+VqXXuUT+eC6JHLdnJlyY6kYKdMP2y981teG/UBnGjen0+roBbUWcg
 z6wWNKfIX1A==
X-Gm-Gg: ASbGncuP2OQ4OBXH2Jff8b9Z3j/WF+meLirHQ9+fQ1dhMO2w7DrDjKuxG0upG6M+TlE
 D51/9hqZwcmh23vvUCEMuCmWf4KXsgd5Fmzy42NG9ChvYsqGp6oaTPLT5IpHgx2+sSa+b4TsIBQ
 1Lcbm4Ht0IHaTjacYW9Ln723CkGoJbxh/AOtpfEasLsQKGhqaiPsdgQP0BWXPK2HZR9bL4KDbgv
 /YkRWaMEd1l2NFkxYByGT31f9OZ12uNjB04UfgGKw8ZiE7iNg4avifNl/kL2ZK5dtJX3VG9hzvT
 wXCVUHDWnWXaqiaeehJXQpDMKYZSoTjs5wFaa7XFrsXeLFWkLIMGz/H9Pb+FvDvfbI84lcUFQq3
 RVlj9qumV/PY20K8b/7+siwIDcT3SHt5idWUTxzxfxmMe7Jge0j3H92dcDIbAfPoO4zDekrOgUc
 KrDTzdDUgIrXhFCnHOFhJ/tQl2
X-Google-Smtp-Source: AGHT+IFddA9y2GEPChlLuftqzm+w+xnA3L3HyOHCmaudZqOajmX7O52I37+S1Nfio3xx7270mfbEAQ==
X-Received: by 2002:a05:600c:1f8d:b0:46e:1fb7:a1b3 with SMTP id
 5b1f17b1804b1-46e711457f8mr102680495e9.23.1759803049589; 
 Mon, 06 Oct 2025 19:10:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa2da873csm7475475e9.3.2025.10.06.19.10.47
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 06 Oct 2025 19:10:48 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/s390x/mmu_helper: Do not ignore address_space_rw()
 errors
Date: Tue,  7 Oct 2025 04:10:46 +0200
Message-ID: <20251007021046.27470-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Break the loop and return an error if address_space_rw() ever failed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Based-on: <20251007014958.19086-1-philmd@linaro.org>
---
 target/s390x/mmu_helper.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 7bcf1810bca..643141e7847 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -544,12 +544,18 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
         trigger_access_exception(&cpu->env, ret, tec);
     } else if (hostbuf != NULL) {
         AddressSpace *as = CPU(cpu)->as;
+        MemTxResult res;
 
         /* Copy data by stepping through the area page by page */
         for (i = 0; i < nr_pages; i++) {
             currlen = MIN(len, TARGET_PAGE_SIZE - (laddr % TARGET_PAGE_SIZE));
-            address_space_rw(as, pages[i] | (laddr & ~TARGET_PAGE_MASK),
-                             MEMTXATTRS_UNSPECIFIED, hostbuf, currlen, is_write);
+            res = address_space_rw(as, pages[i] | (laddr & ~TARGET_PAGE_MASK),
+                                   MEMTXATTRS_UNSPECIFIED, hostbuf, currlen,
+                                   is_write);
+            if (res != MEMTX_OK) {
+                ret = 1;
+                break;
+            }
             laddr += currlen;
             hostbuf += currlen;
             len -= currlen;
-- 
2.51.0


