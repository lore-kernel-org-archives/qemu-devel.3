Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BFCCAC5B9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Sep 2025 08:27:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3VeC-0000cg-Vn; Tue, 30 Sep 2025 04:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3VdR-000076-RJ
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:23:01 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3Vco-0000yw-Ch
 for qemu-devel@nongnu.org; Tue, 30 Sep 2025 04:22:57 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e384dfde0so57976775e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Sep 2025 01:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759220533; x=1759825333; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8QFdShgwZbpOIuoiHkRuMdwMlUbV145lKXZsf/3KvUE=;
 b=KL2S8kndGIgQTOco881r+5ctKw4UzzpSRf466OdXFG0KeTDESLbAMRlWB9VwnMCebS
 3Vo37FM49hfpE84QJfl2hjGdUH7cQcnB8VlUytsT/nnVkIpWK2WONF0jhQ/ZQw+eJtIg
 To1dBsaM8WspYBruBVF6kgWYBzXgn4K9dmMTz50pAzMkDriicg/7U4N8IX6kPL4mkxEJ
 HbkQa284seyGNLkq6R9XbXU98z2Ae+xedssm9Z3lga1OvvLaidmDqoI6rAUkpB4GBsI3
 MmQ7sGHNmXv1lnCSGZGW6nfCPe7gCPqRaaCtw4sze7GGxnAviBYBaKCiWW+f1dq2m4Kv
 djJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759220533; x=1759825333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8QFdShgwZbpOIuoiHkRuMdwMlUbV145lKXZsf/3KvUE=;
 b=r2bdIxc8Ajtyc0oAXQ6tV17oMiBsi0e0nkcwFTeD3O77KAqVxBndfW/QssssnO+ulG
 fEj0pV1lgY8FfWWWYd8Q0qlIku5FrRGuMPKYeyek5DqsD+wkNmyQ0PLpsr5/9Mft+5ut
 mZp4Idv6bODEjAPfZeTXWgW2Gq+rjIamd8UX2oK8BSRGYxdVOH79BX147ncb9ogVdq3k
 bJt4rViu0ThR74RN5SbKs4kg3CkSSVClrk7qF2Ys/llRvcBcEXxQjqu7+jQvsHJOyUDW
 oVbtXwS2ETtn7IbUcUf9znAZnqWf4cg71QtrY9v00eRPDyZFzN178UyNYwbr9ffhb+UY
 OaEQ==
X-Gm-Message-State: AOJu0Yxct9oE099brZvn7/LN/VegsmJ+6D7KVoBFoBo1U8LHgeBEs/Gh
 adJPcHTBXbhu2PeTu9wAhFTzw9OPtb0aU8Ff41TrcQOyTWcGjXgn/8RzpyUclkHVKMZklC+aaoX
 0iz+LA3gpFw==
X-Gm-Gg: ASbGncvOP+8Mr7WwHuZ/0mjyKsu4xvEkhC9a8y5gnQrcv13Jh96Npsiu5YGvIbBxPE8
 i2r0oa3TBhT/1hf1nXTbjVW6cAbCSLoCSOAngQCxmhTwYq1l23jRthZjqS8Vfhz7RkpCevjZvVM
 3SAn8eyo6PTzcgt1aa9Rqzp//w0ZSxyRv24igNplO7+UbLlUF+rRvCiTdI9E1Zq0shzsXDe2kuH
 rCejahDHFEV6imBnYeluMpyUKvGmB0xUuUazB5SbYp0YeBoNNiI2ORaIfqR9uz9HKRCkNTizP02
 Omtm2VLvnYv5iskS+DR97/ghPQWgEBhKIX0B6JPGqtXyRfZKWltWZ03UJaraGC4YUQ2O+gixi/g
 dBrHqCSmiTy8wOCCVwEaamvobOyfsv+fFvWnQ62MD0Tc27lEQ+xngsYJOumLXkZDTTMkkcUTFAW
 65Rr6AO0F/dT0P0wQSTAlVuVsL3mMk6N4WWnYpfCd1FA==
X-Google-Smtp-Source: AGHT+IGBMYpWSXfOX3el6uig3+R7ujcKxPeYiLaNhqcFnuUIbzB/w07fZP+NVrmJYAyBxxupmR40fA==
X-Received: by 2002:a05:600c:1d14:b0:46e:432f:32ab with SMTP id
 5b1f17b1804b1-46e432f395cmr126597005e9.33.1759220532938; 
 Tue, 30 Sep 2025 01:22:12 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5c4dd9e4sm7814745e9.10.2025.09.30.01.22.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 30 Sep 2025 01:22:12 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org, Stefano Garzarella <sgarzare@redhat.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, qemu-s390x@nongnu.org,
 Paul Durrant <paul@xen.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Anthony PERARD <anthony@xenproject.org>,
 Jason Herne <jjherne@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v3 08/18] hw/s390x/sclp: Replace [cpu_physical_memory ->
 address_space]_r/w()
Date: Tue, 30 Sep 2025 10:21:15 +0200
Message-ID: <20250930082126.28618-9-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930082126.28618-1-philmd@linaro.org>
References: <20250930082126.28618-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

cpu_physical_memory_read() and cpu_physical_memory_write() are
legacy (see commit b7ecba0f6f6), replace by address_space_read()
and address_space_write().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 hw/s390x/sclp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/sclp.c b/hw/s390x/sclp.c
index f507b36cd91..152c773d1b4 100644
--- a/hw/s390x/sclp.c
+++ b/hw/s390x/sclp.c
@@ -319,7 +319,8 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
     }
 
     /* the header contains the actual length of the sccb */
-    cpu_physical_memory_read(sccb, &header, sizeof(SCCBHeader));
+    address_space_read(as, sccb, MEMTXATTRS_UNSPECIFIED,
+                       &header, sizeof(SCCBHeader));
 
     /* Valid sccb sizes */
     if (be16_to_cpu(header.length) < sizeof(SCCBHeader)) {
@@ -332,7 +333,8 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
      * the host has checked the values
      */
     work_sccb = g_malloc0(be16_to_cpu(header.length));
-    cpu_physical_memory_read(sccb, work_sccb, be16_to_cpu(header.length));
+    address_space_read(as, sccb, MEMTXATTRS_UNSPECIFIED,
+                       work_sccb, be16_to_cpu(header.length));
 
     if (!sclp_command_code_valid(code)) {
         work_sccb->h.response_code = cpu_to_be16(SCLP_RC_INVALID_SCLP_COMMAND);
@@ -346,8 +348,8 @@ int sclp_service_call(S390CPU *cpu, uint64_t sccb, uint32_t code)
 
     sclp_c->execute(sclp, work_sccb, code);
 out_write:
-    cpu_physical_memory_write(sccb, work_sccb,
-                              be16_to_cpu(work_sccb->h.length));
+    address_space_write(as, sccb, MEMTXATTRS_UNSPECIFIED,
+                        work_sccb, be16_to_cpu(header.length));
 
     sclp_c->service_interrupt(sclp, sccb);
 
-- 
2.51.0


