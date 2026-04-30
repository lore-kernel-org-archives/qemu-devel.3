Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D9EFF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:39:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINr9-00052V-1y; Thu, 30 Apr 2026 05:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINqs-0004in-LU
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:38:34 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINqi-0002TA-VA
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:38:33 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-43cf7683a28so464007f8f.2
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777541896; x=1778146696; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MdlueKTPTxRLKeni3j1LW0jwcf31UmunOv+FakAqBh4=;
 b=MAlDIKzm+UGnD+6jtuc1qHMUJ+GaTEdXsHxI1vhizN0GLMS+nTW7q2VNrUHR10/gTS
 cGFpfeT60pg27qWaiIYHqu/KZxnrCG2SJqv0bqLy2SldAigoRuT4USTjr7SD4Xf3n7e6
 3K1BJMxwTkr0fPojslmoP7Qf2R1LSqcVzOBlehlMzmLEg6CbW/jY0GbGHF6ryMhlEtjV
 sCkQkBNx79emD261DXiT4Izu6DFnEOSWVkg6dweGRyGXAvXhJGLEkQjP+CLVyYslmXJV
 jc0ggq6DeNgRmcQIC478kID6tenRa+IfyC/0P+d4Rz+uVHLd5+eeUp+5MM4eWvGoHFew
 AyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777541896; x=1778146696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MdlueKTPTxRLKeni3j1LW0jwcf31UmunOv+FakAqBh4=;
 b=KTC2hdXK0UtP6ILCCNn8GxHR2jDFfKIoIvypAzdDTTbxO/Ll9nlYPy3zwO34nOkC7f
 5M5jPFFGeSw5L72g0FGzHMbtyEVulUIjm2kpYnLXUpHjcioVagpvIK0zhcWZA2Wc1NdO
 hJfnMECCFFRYSLwufQhFxmx+Czu5ApVN5K8uJ4HpN1JgvwOvTFHkSEt/YEuO1axXjz+s
 VCtwUxVN7yZH5eouwMcyZTVT+b53LlKxWtv4LNDlcALz9tcMCtsWVVCyb795IK3tsRdO
 LPzasqOjrGo9Rlz2WxVkFWwDCvY6ucaRcD9RVZ1/+w6a9Ou5A69lqJcp5JTKI51odsUX
 I7Fw==
X-Gm-Message-State: AOJu0Yx/XiHcVamfZPPqUR1RdpfJPrSzZHq0HoiLLQQDwp9XwTpFDRMb
 snwpKkJMivJ1dYpSrgpscqlUiRDZ92r4/GPJWm9M6YkmpF2bGCS61IIjN3Kttzf9Np8YBWExjDg
 QRdQ3
X-Gm-Gg: AeBDieuUqHZcMEaaWguBhV1ELlxPoF2HBAh1inweaMuI5nb9zpQnHko0EA/l/wMlB6v
 63caRB865pBu4paQPRGcZ5csPrTlHseRULlAe1iLfncAT+E0/m///5g3DpqC882an7J2TR7PTV9
 ek+/OIXJsT94bOuFxp7RKR6uD6hWI+vQaJPZcUDhj0Yl66Q6+wy/DH747YxIJX99f9fxzyz7+nX
 9/m2sUj2vNiPFqGwwmPgx8iXBjDy6Y06th0xZFz53fzRLKqg0EWXt7PviSy8DEORfXXqcAwdYqj
 ka6mtwvXlmAhMAAjsRh8p8H6H088pYQZg4Hlwlu3Vp+f8U94HhrybghEv/U8OBMHK1l0yJ/fgVG
 VASdzBaO7jBdpdnjCXSr9rgw0EHKqniKtdBknA/cAhMNbytedFldmxLojUaSoPjuPePhAHWfbus
 vxN0uiwD+CHmvFM4JKVqa4L5vZlxPusn/oZTTwSTG/9FE7fs0Sw/JevrtxgowZ0XrySBzO1g2+Q
 wTpNl65AqAOFRUjopT1Aj5Y4nC9uaB9KmhmInJp/w==
X-Received: by 2002:a05:6000:184d:b0:43d:7946:badc with SMTP id
 ffacd0b85a97d-4493ec61dfemr3691019f8f.26.1777541895825; 
 Thu, 30 Apr 2026 02:38:15 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b421721fsm10816795f8f.15.2026.04.30.02.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:38:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 03/25] target/alpha: Make get_phys_page_debug handle
 non-page-aligned addrs
Date: Thu, 30 Apr 2026 10:37:48 +0100
Message-ID: <20260430093810.2762539-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430093810.2762539-1-peter.maydell@linaro.org>
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Currently our implementations of SysemuCPUOps::get_phys_page_debug
and SysemuCPUOps::get_phys_page_attrs_debug are a mix of "accepts a
non-page-aligned virtual address and returns the corresponding
non-page-aligned physical address" and "only returns a page-aligned
physical address".  This is awkward for callsites, which in practice
all want the physical address for an arbitrary virtual address and
have to work around the possibility of getting a page-aligned
address, and it doesn't account for protection being possibly on a
sub-page-sized granularity.  We want to standardize on the
implementation having to handle non-page-aligned addresses.

For alpha, the get_physical_address() function accepts arbitrary
input addresses but may return an output rounded down to a page
boundary, so in alpha_cpu_get_phys_page_debug() we OR the within-page
offset into it before returning it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260417173105.1648172-3-peter.maydell@linaro.org
---
 target/alpha/helper.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index 179dc2dc7a..af6d7847d5 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -301,6 +301,7 @@ hwaddr alpha_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
     int prot, fail;
 
     fail = get_physical_address(cpu_env(cs), addr, 0, 0, &phys, &prot);
+    phys |= addr & ~TARGET_PAGE_MASK;
     return (fail >= 0 ? -1 : phys);
 }
 
-- 
2.43.0


