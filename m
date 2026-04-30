Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCBDFF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:45:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINrK-0005Wi-Ef; Thu, 30 Apr 2026 05:39:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINrF-0005Ki-7D
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:38:57 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wINr0-0002oU-5x
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:38:56 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-445795cf6f1so438263f8f.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777541920; x=1778146720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vtdY7obMueMpd5fltY9RwFbeo9ZZ7O0JQvizv+LAkKE=;
 b=fLe45RvtvmVkEnlIjl7r+jNg8ytO+U08qtOi+TJgGs6zpKonyCIMZTR5FfHmEEdn9z
 O7BHJCiW7QJqB8otZDcDj/0LyNwd2DnhMwtGSxbHs2L0xTc+dEj2MEGh8khJinRi9+c6
 QK+lZPnxgpkHsFkTD64av5J/gwTFgm7JRldhD3Ks1zz2a2hRELuCZ0feCLB/UFwskPlD
 rsnuIsoAZRdoWx61z58flUJSp72HGjlTiI4BZmMwN/PtnB1i6jn4ILkh8xdBfvt7/ujs
 zFLmEvtD5so8K9IW2ZgdmYXGqu3kSQb4UcFsQzAWYzjMckrH16zflNx9WMFXcPh3HdSD
 RO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777541920; x=1778146720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vtdY7obMueMpd5fltY9RwFbeo9ZZ7O0JQvizv+LAkKE=;
 b=IPcfI0CqEgRPhcx/GrUrlDU8mI3nUmMu235PvVu4eBaq6Z/a/bw5it0tt83wwhYNO7
 Fe1b5ee0yzvN8PfChClBH8tTOMTi2zNJwQm9Jns59fWKg0TrCKGwxXQbwQssJ3se9kkW
 Rwm6dqsqqEYkH6XNWM7Mvb/JHN0GZAgLxCd6qPpsTrb9LStgQ5uEfmxtGG4ZJBeADKU0
 cuuUGm/jbvNGcusLvPMIfarrhBqMNbJg9kvvzeXQDWx31ZfJ4TtIfWvOczvNTSQbLQfa
 MjhOMdXrz+6QKqy3wMOsXV9xEeTxMetTvUtPvekyrzPgNTwrjdr1rRAKG1rWKyykrJ89
 nESw==
X-Gm-Message-State: AOJu0YxFU8aVCFyrGci+pgN8CAyBjIVyeCIQ0DIGlbdA0xYsDTm9W3ek
 vosZdBxm5VvVNq5Tybl8ZAI9YZXBMOOYV/miRZYZePC7jCIidiXCpm5JEKGul43tR6KDG4tpw3V
 zY7r9
X-Gm-Gg: AeBDietLu7gqyTuhk+Du47jJh22LJUK3Ai6cSKJtaTkbtIh6aEhdOvvKhq59pcOuMv9
 qgddoDpr9IipaHTRSqT4dmKuGEQgNRHXEsPDH8Z1Sfj5luJ3faE0L7cfVRiQvgikvFwZzSNYpZN
 whxzhOaKsvA1N9sg6C5vCkAe/cTR3Eqdl44TQrmSkT3YOB1kmCldKkSY2YiR3fFXxE9BvxWauY7
 OVZtJRS/Tp4GdHB/4X7Ku1Z7DBveVQeJVOGIuCL6W73HeUtyrMrNnVB+7ERUMx0uz3O29E4ZVTE
 vOjkfh++/dA4lVgmBRQuHEsxVT41jPJMjOKUcR5SRJFF9U1BuCwQP2YxO2SSXDWtlvInKE2KHVb
 JpAX37QNROAEfnhCbG4BNVVQ4AyeENcctALFAp8OHJbUm4hNVL1yMCltY2z9YyXTE6TwHgy3jvY
 HwVUH6qqmuI9jCsOYJcrl6XJo3RwmaH7ate/mEjZV7SJK0yk2bfEAp4TdjLc1ifv3h3CBb+WVEw
 yqZNEk8Aqvi0bQfYEPax3vSlTDiO+6vbQYw4a/S6PlW0mI/esNM
X-Received: by 2002:a05:6000:2f8a:b0:43d:7828:1f81 with SMTP id
 ffacd0b85a97d-449400c5308mr3332206f8f.41.1777541920392; 
 Thu, 30 Apr 2026 02:38:40 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b421721fsm10816795f8f.15.2026.04.30.02.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:38:39 -0700 (PDT)
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
Subject: [PATCH v2 22/25] target/xtensa/xtensa-semi: Use
 cpu_translate_for_debug()
Date: Thu, 30 Apr 2026 10:38:07 +0100
Message-ID: <20260430093810.2762539-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430093810.2762539-1-peter.maydell@linaro.org>
References: <20260430093810.2762539-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42a.google.com
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

We want to remove the cpu_get_phys_addr_debug() function; update the
xtensa semihosting code to use cpu_translate_for_debug() instead.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/xtensa/xtensa-semi.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/xtensa/xtensa-semi.c b/target/xtensa/xtensa-semi.c
index 9a6a9c8b4e..3340bd1d41 100644
--- a/target/xtensa/xtensa-semi.c
+++ b/target/xtensa/xtensa-semi.c
@@ -215,15 +215,20 @@ void HELPER(simcall)(CPUXtensaState *env)
             uint32_t len_done = 0;
 
             while (len > 0) {
-                hwaddr paddr = cpu_get_phys_addr_debug(cs, vaddr);
+                TranslateForDebugResult tres;
                 uint32_t page_left =
                     TARGET_PAGE_SIZE - (vaddr & (TARGET_PAGE_SIZE - 1));
                 uint32_t io_sz = page_left < len ? page_left : len;
                 hwaddr sz = io_sz;
-                void *buf = address_space_map(as, paddr, &sz, !is_write, attrs);
+                void *buf = NULL;
                 uint32_t io_done;
                 bool error = false;
 
+                if (cpu_translate_for_debug(cs, vaddr, &tres)) {
+                    buf = address_space_map(as, tres.physaddr, &sz,
+                                            !is_write, attrs);
+                }
+
                 if (buf) {
                     vaddr += io_sz;
                     len -= io_sz;
-- 
2.43.0


