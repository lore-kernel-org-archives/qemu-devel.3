Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DE72CCD184
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 08:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v62s2-0006pH-FO; Tue, 07 Oct 2025 04:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v62s1-0006oU-6y
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:16:29 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v62ry-00020l-LG
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 04:16:28 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46e491a5b96so33838015e9.2
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 01:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759824984; x=1760429784; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cD5B6th7c1TeoiHWNXDK88lPUBnBW5SZJ2RDNW2CK3g=;
 b=lzUJaSQFJWo/39OG3STAFtqkcUsLdemPLj1VCXQg98LoHbGOC/vc83EjwA/2WFSxiV
 eRCbPm0KTyqHIFwdkGANqNfPMkVKbyyE4VrTlx8vI9x7wXJbPXkdVJuODLFeHaBUmzsQ
 5kZhORFq7vYn2cSMrOLM4TCEw/vgzRBr5/JRsevdORNORsD3fsWxskURZfVhXg65NoHG
 wPNIK67wyPp3cXOtFFCRYHIAgNpvF/gZF8ZAzoJt27pJlfwdhPgCVS46kOyoiQx+tBYH
 IO07hMUCW8MATLKPX/uc6v4ALol7kYRA8hnSH2YypWfty+RCNVBfBpFSuUpOvu3pc5XQ
 J+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759824984; x=1760429784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cD5B6th7c1TeoiHWNXDK88lPUBnBW5SZJ2RDNW2CK3g=;
 b=s2B8Imt8Ow+teCvGXw+g/N25CwiQahBJx9NFPwF2lU2PAxXgJJNPsRIxnvzpRBwg3g
 6bMH7qMCwEInIuTpfZhk1LtGu2/dOLS/1Ytictyyjv01/OagaBd9jN4hBvJFeu4Bm5S8
 dy6et60gPifAb1a+hZon5290hcV7ApHnLIJAAmQ/voSqQzMNySlB9V4GWjOXqEp2tmuI
 GhFa3pDh6Rog6bNnGWKQJ3dTHa2rMWJtu8xmUB0VMVOxcLmJDLGhGBkKAS+Q1sEsGj49
 mYvFY8PK06DlMv9K2uxDvVmENI0b+KL5cyPc/X/tVnlsHPxYaLH26g3dL87ww6foTySL
 JYcg==
X-Gm-Message-State: AOJu0YxBKfbBfjqeclHX37maZq/0ghkcn0wqOeNyqrtK4/+30AJ9zcmu
 rsDWik8iCli9viJWJUn1yodojbKIRhwwlAszApf4CBSBB9/W8jLRBw1F8zcUNvRv8p8PgB6wHjN
 oeUYwr38dGg==
X-Gm-Gg: ASbGnct4zjPSVj8jP6JMUj575o/HoOCxUWtw1JQ0t2Msvc6x5pBzRx7/wKiS9Sd6tnB
 t2oONBUYJzyEUlloPEEj/GoDf5rOF8VJmSPr9lJ2ccXIncUGErAP0I7rKCBctfvSXwCzkftscUN
 S3cYsAyyYEpE3xqNAP2bm84fjz/8Itk7cf/CVZnNYSAfbVK7gpkAWi1GhzIJtx36uAbskhoW7RR
 JhUc7Et7ywn7MRfYLTL11toGcYpP9/X3p4mwmsRujDJ/TCQK0j3sQVDMk/NUa4/cOlFn877g64g
 ThZZ59ByJqK2eg/ph15aocnmhE13gNWrKrNCT9AR4zCnGmfNdN+HZHQ57XmlfM4DRULxqQ/pg1M
 8EHqsHdg5k8D635/ALORkUCg/Q2OKvWIN2PgS1pQ5SsW7tD51cmLReVmgSFDkByda2gK8mYtsPz
 sCx9Hv6vsIHBaZv/0Y9HcrHl0l
X-Google-Smtp-Source: AGHT+IHqJitJWd85EjVa6wBFl1HVhO0dJ2xXoZpIa4bEQDcdZ0MzcJ4BX+zr8XLtbIecHxBNFaDD4g==
X-Received: by 2002:a05:600c:c4a8:b0:45c:b53f:ad9 with SMTP id
 5b1f17b1804b1-46e71151aedmr107360115e9.33.1759824984354; 
 Tue, 07 Oct 2025 01:16:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fa2cfa2dcsm13204885e9.0.2025.10.07.01.16.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 07 Oct 2025 01:16:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Weiwei Li <liwei1518@gmail.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-s390x@nongnu.org,
 Song Gao <gaosong@loongson.cn>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, kvm@vger.kernel.org,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Huacai Chen <chenhuacai@kernel.org>,
 qemu-riscv@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 1/3] accel/kvm: Do not expect more then KVM_PUT_FULL_STATE
Date: Tue,  7 Oct 2025 10:16:14 +0200
Message-ID: <20251007081616.68442-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251007081616.68442-1-philmd@linaro.org>
References: <20251007081616.68442-1-philmd@linaro.org>
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

KVM_PUT_FULL_STATE is the higher level defined so far in
"system/kvm.h"; do not check for more.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/loongarch/kvm/kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/kvm/kvm.c b/target/loongarch/kvm/kvm.c
index e5ea2dba9da..45292edcb1c 100644
--- a/target/loongarch/kvm/kvm.c
+++ b/target/loongarch/kvm/kvm.c
@@ -397,7 +397,7 @@ static int kvm_loongarch_put_csr(CPUState *cs, int level)
                            &env->CSR_RVACFG);
 
     /* CPUID is constant after poweron, it should be set only once */
-    if (level >= KVM_PUT_FULL_STATE) {
+    if (level == KVM_PUT_FULL_STATE) {
         ret |= kvm_set_one_reg(cs, KVM_IOC_CSRID(LOONGARCH_CSR_CPUID),
                            &env->CSR_CPUID);
     }
@@ -801,7 +801,7 @@ int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
         once = 1;
     }
 
-    if (level >= KVM_PUT_FULL_STATE) {
+    if (level == KVM_PUT_FULL_STATE) {
         /*
          * only KVM_PUT_FULL_STATE is required, kvm kernel will clear
          * guest_addr for KVM_PUT_RESET_STATE
-- 
2.51.0


