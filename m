Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51C66D65C56
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 14:34:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVsaM-0001mJ-0o; Wed, 17 Dec 2025 09:33:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVsZa-0001Zx-4N
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:32:18 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vVsZX-00073w-EE
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 09:32:13 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47795f6f5c0so37708025e9.1
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 06:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765981928; x=1766586728; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XUlJJIjbDM2EiiD+qKMGI+yB0A491EkhhPxVSB2GOUQ=;
 b=cdz/JGkV7QX2BMX2n47OwCzpmXVH+BQQPpHMSUX5+p87LEhHM2ZdYYc0D9BsyidC09
 xD8svLMUk4l+MtsNj2PEJW5d5FFEhAXreBTuABJV2naOlfGWmCsvDQUhoDtZfgxbRBlX
 GRqX0wg0cso3Pr3SwPqvtcG71RzJUm9aGsCEx1kIvMki7yoZPtWAzefVYppr9AVAwPtX
 P+3XM8vYPxOjKKqcLw6rZvyKdEwywuKZ6SwHZFPvGaDNZfKjcyU498blH9a+vc5MQ+fy
 91vRBTPB0l5vOp7zbfV9/WUJdv1qcCPLJlPp4IC+NSPnwTfTIOV9US08Tl3t4H1jTr6z
 hSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765981928; x=1766586728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XUlJJIjbDM2EiiD+qKMGI+yB0A491EkhhPxVSB2GOUQ=;
 b=cf1qjnBrTbSmZyZUdyo9LQGg/1HtMqgpvj48fRBcjFSmr9roZNGrWQpmgyfJinhgPV
 oOetodNApriTsdSTc01DxJHDvieMBNV3c+G21kBZgrlaf57hn1aPKY1VqKrkA2j0xDTt
 t5qvkO/Dm62QTjGvux7rtqWH7J12iQwx5tCNFyl/c9AInKwb0JDN5cDzWYhrF1w0vydm
 4+sWWsfmZgIuKZNT7nYbPDdcsai/TjfTA3rIJDxDfCG0C16Ug+N6mTG8hFZTSNYqfivN
 0XpFUg3/22BwkewwJfjYpruXPBDB10pT3W4RUU6VQf6MI9IfFVOs5xaP+v/4EtxH6VGZ
 gWAQ==
X-Gm-Message-State: AOJu0YwyH7k+16yj3KJZcLmycCjWVI8u/nDF0gLPkjOYaOmMwFZbAhUi
 Bj4jkdWWH9AjudTQKq+Up0Tcb0vIld/P7Ftm5EkdbfE4msQs+BWFIYulUNfiXsFDLVBYn59Ggbh
 fT/86bHHLUQ==
X-Gm-Gg: AY/fxX41AL+bp9Sv/dZvFD3im3wPJlQGQ7/FJY/Xisqg54yvI3lp+Iv73UEzNxvhHrm
 lCfYejI9NaXABL884bdDdi3RYAAmhqFha/BSd6Mo8btEtT96ArsJ1Nyu6QOxvwCfJgERnsJ4p6J
 rBmwVn+2kBK/Tzktg5JDoaFuvtybEhWJxCZxyawQR6WZ+7dIBBHhwxkZgoZ921i5zP2pIQBsaKF
 RqIlvbh3Grc4twimzOkpLlUBvnhrL5NG4mktaWfGYx3NJC+6Zry/xP/tLhU16Esn8bZuB0A9bZT
 J/h1mUjMeCiw4qEZFyIyezEqd/Wn7qSk62q36gVPKcCppkQ0GyQAawKXxylhJX/PSKVLV0pkHUn
 W0Ei54IwcyfjEuC3Vnue/cZJ22gLoZ6P2DiRnSvi+6D1Mnc3t2aevNP1q7685CbMVuWqY/e7ZSG
 IqxLO1h4RojRfdftZsyCsj7D16ANkUmb02dYHf2GbO2r5WDvFLhYm5Ud+p1uzm
X-Google-Smtp-Source: AGHT+IGX4yLhEa44exEf/Rh/CWISlnBAjJ9PAnCC0J8qGzSzYorg7KAW+nrmR2GBZzPYfw+iesWwjw==
X-Received: by 2002:a05:600c:3f08:b0:477:9c73:2680 with SMTP id
 5b1f17b1804b1-47bdd99afdcmr20270145e9.23.1765981928310; 
 Wed, 17 Dec 2025 06:32:08 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4310ade81absm4996784f8f.21.2025.12.17.06.32.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Dec 2025 06:32:07 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@kernel.org>, Peter Xu <peterx@redhat.com>
Subject: [PATCH 02/14] target/sparc: Update MMU page table using stl_phys()
Date: Wed, 17 Dec 2025 15:31:38 +0100
Message-ID: <20251217143150.94463-3-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217143150.94463-1-philmd@linaro.org>
References: <20251217143150.94463-1-philmd@linaro.org>
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

stl_phys_notdirty() is supposed to do an optimized CODE
path store. Here we update the page table via the DATA
path, so can use the normal stl_phys() helper.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/sparc/mmu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 217580a4d8c..46bf500ea83 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -189,7 +189,7 @@ static int get_physical_address(CPUSPARCState *env, CPUTLBEntryFull *full,
         if (is_dirty) {
             pde |= PG_MODIFIED_MASK;
         }
-        stl_phys_notdirty(cs->as, pde_ptr, pde);
+        stl_phys(cs->as, pde_ptr, pde);
     }
 
     /* the page can be put in the TLB */
-- 
2.52.0


