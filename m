Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D094C02199
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 18:28:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg6bS-0001hT-Vb; Thu, 06 Feb 2025 13:27:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6bQ-0001ZO-L8
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:27:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tg6bP-0001En-2O
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 13:27:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738866470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k5Ryak/eSgMhX/XO70jUySJ3C1G++x3e5P9ppqfL1HQ=;
 b=h3W2IZVt8K0dF83hGvMX6G1JDSRrC3VDgS69rIrMAMbUtiXYmTqP68Mf0aKpxn0eTFq8dR
 i+FpONCx+H6qQd/PJ+mCSO6KDfN0Q/ao5KfwRIJcYWJHkENJxbokmRmJ/2dLlKRmlvGB81
 YRT2SSNIyxw+Msw62ipjqQdEbZpEcfQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-5kymxGJ8PLiJpiGPPyymAg-1; Thu, 06 Feb 2025 13:27:48 -0500
X-MC-Unique: 5kymxGJ8PLiJpiGPPyymAg-1
X-Mimecast-MFC-AGG-ID: 5kymxGJ8PLiJpiGPPyymAg
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-436723bf7ffso10548345e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 10:27:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738866466; x=1739471266;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k5Ryak/eSgMhX/XO70jUySJ3C1G++x3e5P9ppqfL1HQ=;
 b=oDv86KV7eJVpT3D5bMf0L8FcHNKdibGnmhnh7hKilDAjsXr/WNaX7worg4uiZ7+77C
 DTVTl79hffebJ1fDnIMY/XpGxLeeRokiANBArdkQ6ryaAFtvu1YCB18juoJJoCAe9iHK
 Y7SyslG36qU55eKJkRMGaPZUBitws2upDF75QyW3PCiMOr6blT6f+5Tr+D4HJPlxCRzU
 jTl6jCIUy7tJq+8VY3sFuX+IwGYZOJwY4GNQiLM2tyypyfCuPf5qAk+g417Zq2tYqf94
 xfqHHpwNJXU9/wP/BF+7i6rIj/HWNdaN5fSarGmlbTe7UgZ3xkGM6rSeONxsya/IRvJd
 aWNA==
X-Gm-Message-State: AOJu0Yzev58qSA3+hEkVy9Lo+8JMYpflUPmtglfwMJkHuXbUw6Ma1iP4
 KaMx07iR/HZV50F4wEaS7hyvWE8Sz1OR7lOnbgg2K6TbRxcOXuTJxxtp/vPPNXILZZfQkWtdibp
 TTJQcFtTE5VpL78sG8nCMgwyzBdXVDMavTxZCoh3eSl9yw1Jt7eGMNGA0aLCzJe7whKs7DpHpHh
 0UQz0A9Hk4QEDq1+Kz9M84qVMeVxojxLN283ihn4k=
X-Gm-Gg: ASbGncsyRxT9TZxCqmLJc80Pe4g82Ru2l/3Rp6lH3nRekuj2hg97mDxdETZgA0Nxqpo
 w5RowY3CUfejNltGo5aS6p2MER0hhL2ITqy05ov00ActU5Eq+mg1uNHc9qwc66z2JQhr8CRYnbK
 0iqVe8KLq/Pn9/1de2k4DBWR/J9SbeIiNN/B/dbCRXR07HuQjA5maoH1d77YZFq1JPtUi6tUZPp
 DHlVmkdKGi4LQ3lzdbz8wM/e+R45jRG2AD6VkprytBxXh52eAoeCYLod2bjXgNvEx3ivjQAnQts
 u5zwp6k=
X-Received: by 2002:a5d:6d8a:0:b0:38d:b8a2:1944 with SMTP id
 ffacd0b85a97d-38dc90e9bfdmr43116f8f.26.1738866466502; 
 Thu, 06 Feb 2025 10:27:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoqrvrbB0emFX+8ybIiU0I5dG34YbXmKCjBqqxUxEnpbLwlNXexzje15bm8p7HzINjrpHw7A==
X-Received: by 2002:a5d:6d8a:0:b0:38d:b8a2:1944 with SMTP id
 ffacd0b85a97d-38dc90e9bfdmr43099f8f.26.1738866466082; 
 Thu, 06 Feb 2025 10:27:46 -0800 (PST)
Received: from [192.168.1.84] ([93.56.163.127])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc565d62dsm1009650f8f.93.2025.02.06.10.27.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 10:27:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: alistair.francis@wdc.com
Subject: [PATCH 15/22] target/riscv: th: make CSR insertion test a bit more
 intuitive
Date: Thu,  6 Feb 2025 19:27:03 +0100
Message-ID: <20250206182711.2420505-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250206182711.2420505-1-pbonzini@redhat.com>
References: <20250206182711.2420505-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In preparation for generalizing the custom CSR functionality,
make the test return bool instead of int.  Make the insertion_test
optional, too.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/riscv/th_csr.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/target/riscv/th_csr.c b/target/riscv/th_csr.c
index 6c970d4e813..990453e080e 100644
--- a/target/riscv/th_csr.c
+++ b/target/riscv/th_csr.c
@@ -42,13 +42,9 @@ static RISCVException smode(CPURISCVState *env, int csrno)
     return RISCV_EXCP_ILLEGAL_INST;
 }
 
-static int test_thead_mvendorid(RISCVCPU *cpu)
+static bool test_thead_mvendorid(RISCVCPU *cpu)
 {
-    if (cpu->cfg.mvendorid != THEAD_VENDOR_ID) {
-        return -1;
-    }
-
-    return 0;
+    return cpu->cfg.mvendorid == THEAD_VENDOR_ID;
 }
 
 static RISCVException read_th_sxstatus(CPURISCVState *env, int csrno,
@@ -66,13 +62,12 @@ static riscv_csr th_csr_list[] = {
         .csr_ops = { "th.sxstatus", smode, read_th_sxstatus }
     }
 };
-
 void th_register_custom_csrs(RISCVCPU *cpu)
 {
     for (size_t i = 0; i < ARRAY_SIZE(th_csr_list); i++) {
         int csrno = th_csr_list[i].csrno;
         riscv_csr_operations *csr_ops = &th_csr_list[i].csr_ops;
-        if (!th_csr_list[i].insertion_test(cpu)) {
+        if (!th_csr_list[i].insertion_test || th_csr_list[i].insertion_test(cpu)) {
             riscv_set_csr_ops(csrno, csr_ops);
         }
     }
-- 
2.48.1


