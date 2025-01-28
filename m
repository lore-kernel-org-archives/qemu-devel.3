Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA573C0218D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 14:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcmTf-0007kh-HX; Tue, 28 Jan 2025 09:22:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcmTc-0007jf-VI
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:22:04 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tcmTa-0002JG-N8
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 09:22:04 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-436ce2ab251so37750095e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 06:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738074119; x=1738678919; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kO0uRE/b6a4B7/JlExmMlApMO3OGmNzh+eMs/4hpwh4=;
 b=q7YwtX2ev05otBtPPal4VgwXNkUdUzIcKGUN0z8E4z4izdflPyA4XNYwRd0MRtmBbD
 2QUrmzA4Y15K97GXt6AiRj2Hz6acI9aWQYsaZg+LS1vbrFv+v6hqzEekjbDwEXCYq9WV
 TbPhm92DzwPaAysLlwe/I6JFfGAOZ9VhWXzKNpdvvnBbfbCqo+kao74dggbmufamN60e
 llz8hCbVxipkFHu5FsWBvGeUhFQx0NYU90M4F73N4RhxuTwtpc1cTfTVFLzb0TQXxk+D
 QWoBGMefaaWkMYyCfvXIBplfC3rFBd6hLyjWI3rDOWJILetpZpUA7zhmuAyHZhoXj3fv
 8yxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738074119; x=1738678919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kO0uRE/b6a4B7/JlExmMlApMO3OGmNzh+eMs/4hpwh4=;
 b=lTFHvF7jjIpl3MIDVuQqkZRaIVGCIKC70H1u/wRUVx8QfwkQyylrZHhNWEkhU1KYPn
 w6CLrfcyn6s/ot6z4TIK3ixziCw9/C3nInA2EszGD0a/4yVf2t5slggkGPq+H473FO0D
 FQgNRPmW5mP+0GdjhnmZHvbzyDA04yuUzC/2Y4HcjUfPwbgGX8O/BKIdDhChQ0P8kIYM
 xWqf5rjuCU+LppkdpmDaZw3g20MPJI/DPlMPDSoqgS9IShau2h1Rm1o8LT8ONzieg9TN
 t6lBi+qD8hd7DfptSj5D+JuaxiW/Ui0P56aYg/Iq1cVJJTzBnVWOeL0I8Yb+MMQel+hb
 G/sw==
X-Gm-Message-State: AOJu0YxALG2WWmRogHh2iTv0Y2EC0fOiRxL4WHRAlmrB9CgdLMcFM0Xq
 0cD69Zqc/c9+bpTxyozmketcpGo7bBI0XfURP/bGJpf3PE0qCV/mETeYowKmTJnIYoq8Ik8KqmJ
 bkus=
X-Gm-Gg: ASbGncvuI0jFWQZWtuf/HY20A/2SQpZPhrw2nU7lQGJhsv4ALwO9A87ASjQatJxJClC
 l8ivtDBtBHis3nKz5M4Bj6TwsCAyzV9TRYF4BjyuXTNMTmVZSCaeDFXKXLfTys1/sCj4QX+0rzT
 vBwksLn8gwqZQjQtS1d+EMRp5LqtFCXC2nn/qWv7daWLPuBiQfFZcRkWcLCtcy5B/AHvrsbJl2F
 tH2uSqMFT7M+u4WGQfpx+MUd8M0m/xLdIbBZM8d5pMVGxLjFFKEV+I3KbyxqPjNLf54gOvFRL4H
 GO3b42rMujgaP6dLvRJtI/jhAo/bxADMiTPsPjRrn8rASkdzxlNUjnPVhxdUIiFhTrKD0nA5YBF
 N
X-Google-Smtp-Source: AGHT+IG02KmwhuUT6IfvBlK1pHwLP8uF0g7mnNTy6Q9yhDmta3+GBFm8pcBIROf6lvdBXsr32dkLzA==
X-Received: by 2002:a05:600c:4e89:b0:434:f739:7ce3 with SMTP id
 5b1f17b1804b1-438913cb518mr403560625e9.8.1738074119339; 
 Tue, 28 Jan 2025 06:21:59 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd47f0fdsm174363075e9.5.2025.01.28.06.21.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 28 Jan 2025 06:21:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, kvm@vger.kernel.org,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [RFC PATCH 1/9] accel/tcg: Simplify use of &first_cpu in
 rr_cpu_thread_fn()
Date: Tue, 28 Jan 2025 15:21:44 +0100
Message-ID: <20250128142152.9889-2-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250128142152.9889-1-philmd@linaro.org>
References: <20250128142152.9889-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Let vCPUs wait for themselves being ready first, then other ones.
This allows the first thread to starts without the global vcpu
queue (thus &first_cpu) being populated.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tcg-accel-ops-rr.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index 028b385af9a..5ad3d617bce 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -197,20 +197,21 @@ static void *rr_cpu_thread_fn(void *arg)
     qemu_guest_random_seed_thread_part2(cpu->random_seed);
 
     /* wait for initial kick-off after machine start */
-    while (first_cpu->stopped) {
-        qemu_cond_wait_bql(first_cpu->halt_cond);
+    while (cpu->stopped) {
+        CPUState *iter_cpu;
+
+        qemu_cond_wait_bql(cpu->halt_cond);
 
         /* process any pending work */
-        CPU_FOREACH(cpu) {
-            current_cpu = cpu;
-            qemu_wait_io_event_common(cpu);
+        CPU_FOREACH(iter_cpu) {
+            current_cpu = iter_cpu;
+            qemu_wait_io_event_common(iter_cpu);
         }
     }
 
+    g_assert(first_cpu);
     rr_start_kick_timer();
 
-    cpu = first_cpu;
-
     /* process any pending work */
     cpu->exit_request = 1;
 
-- 
2.47.1


