Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3A2CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 19:53:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wT3FK-0001KC-4x; Fri, 29 May 2026 15:51:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wT3F7-000124-Ci
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:51:42 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wT3F4-00057G-B9
 for qemu-devel@nongnu.org; Fri, 29 May 2026 15:51:41 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49042aeeb75so97412875e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 12:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780084293; x=1780689093; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=riKUeVRs9ub8yVsjePlaRkCop7k1tSoe41wdpPTuHRg=;
 b=J8YiUfeS+csfozfvOt/kjA7E6JThQhNB4u+OO9yaruoDI14f2aaH4GCwiXNSppSN1F
 0f1fsihc8+cIADYtg4fTDCB2UNkvpVowcbUd5+TjRzBWmpU3xrbqp03VyeIR4zGi7uXj
 UIsfnIfL17627BlhruzUggQWJfykt461yBNpO8Yc88jweg5azLeFDX1KNp+oyb40YNi1
 T/q6K49bZei+rpZ1lejIPi3g989BOYWRW16MOGVLN91lj90VuVSO/+jpqFJxLUJ8UMyl
 Ihb5aIzxq5p8GVYavdgmL4ORmRdIVg/xuSK3CLG69MKKfI7082X95UT8LeLpmMvze8rC
 0tFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780084293; x=1780689093;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=riKUeVRs9ub8yVsjePlaRkCop7k1tSoe41wdpPTuHRg=;
 b=O6gSBL14bjI0tmLaGRAvKUyNUC4OWsRtcxm8uiDkz3Arc226QgeM4kbLn76N4FI+jF
 tk9JUmiSW+qCol/+06n4UaPI74FZjnshjgcDE5aVSjHyVn602N8ZFDVMTdncofrDCU8K
 Orw0pJl900sVQimUzjh/N+QRcTe7uLTBC5gAu99oDNGxcGjSB6c9KxDMnluGnb/pCKzj
 Wrw+KhHPPS8QwjKYqeXM+ri1kvvZyEdlxufxJRL7+oaKV4l8t+KIBUmOgyavzcpbdrS8
 0lEsclyUj+nTgzTMQtgNA3SVYUhzeOK3n8hh/TKj+zd8xSjKvDfSa09xxUt0zjXDVHW+
 wwOQ==
X-Gm-Message-State: AOJu0YyeKF1YQVKLnnknMH9udTGsbTCvVZ7gVLb42z6QhTJDmXVOXKhn
 U+5DMESzkCVxWmK3unlT2ktyZEARt0i8RTDaCLUXB5tKyNF4/COWBYHXcKmZn8Pg9eA++KHI2Zt
 c7/FJ8d62ng==
X-Gm-Gg: Acq92OHFOjWdMrEXI0+777TQd6478s4zO4E1iT30naUNSebGej2egy2oSSk2yVBAPxF
 5NND0EC5qIs2SvyZLb7nizEJTuI4FfoE3CVRO1lA76rA+fLjrXkuq8Dke/nHCLEkfkfM96YgE5H
 qN3eOKKoKcQRr9gKU1PEWsh1QF3hpCphMnyCORfbMkB9QbrdbaHQqE33W96zQx964fI/m+NmZ5r
 9u+pCBsUoIlooZRhX6nTVxv288WcFeSvgPyPA9IbBuTRN1oLaVQXX2Blj9gcpd1w9AZYfaXDxtb
 0b/YaPSizjzpGH+w+h9pg2l2zw1bpkxDeRL7+I2GkwUKHUcrEazFALPL4DxNaLC3jPMI+WVlFrO
 DEUsR8VDcU6ncLCnu7iRL5Fufz7dc8tkkNBGKsWT3Xde5IaFAdJet1x8+3eH4hhGBUBgMnnohHu
 o1F6SeK9No4bqctOi1KdrFcNbvhhRy9yYlMHts0/T+L9wbf/CqxHxOglDrH1OW8YZ5cQ==
X-Received: by 2002:a05:600c:4fc4:b0:490:6889:202 with SMTP id
 5b1f17b1804b1-490a29639e6mr15945915e9.29.1780084293478; 
 Fri, 29 May 2026 12:51:33 -0700 (PDT)
Received: from m15.home (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef34a065esm6076264f8f.5.2026.05.29.12.51.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 29 May 2026 12:51:32 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Weiwei Li <liwei1518@gmail.com>, Glenn Miles <milesg@linux.ibm.com>,
 kvm@vger.kernel.org, qemu-s390x@nongnu.org,
 Chao Liu <chao.liu.zevorn@gmail.com>, David Hildenbrand <david@kernel.org>,
 Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Song Gao <gaosong@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Anton Johansson <anjo@rev.ng>, Claudio Fontana <cfontana@suse.de>,
 Eric Farman <farman@linux.ibm.com>, Alexander Graf <agraf@csgraf.de>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Cornelia Huck <cohuck@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Reinoud Zandijk <reinoud@netbsd.org>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 13/17] accel/tcg: Convert AccelCPUClass -> new
 TCGCPUOps::cpu_realize
Date: Fri, 29 May 2026 21:49:35 +0200
Message-ID: <20260529194940.97143-14-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529194940.97143-1-philmd@linaro.org>
References: <20260529194940.97143-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Introduce a TCGCPUOps::cpu_realize hook and call it at
the end of tcg_exec_realizefn().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
---
 include/accel/tcg/cpu-ops.h | 1 +
 accel/tcg/cpu-exec.c        | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
index d7d329e419d..5eba6949ba1 100644
--- a/include/accel/tcg/cpu-ops.h
+++ b/include/accel/tcg/cpu-ops.h
@@ -49,6 +49,7 @@ struct TCGCPUOps {
      */
     void (*initialize)(void);
     void (*cpu_instance_init)(CPUState *cpu);
+    bool (*cpu_realize)(CPUState *cpu, Error **errp);
     /**
      * @translate_code: Translate guest instructions to TCGOps
      * @cpu: cpu context
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index ef44c12b601..1efa3bbe53d 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -1056,11 +1056,11 @@ void tcg_cpu_instance_init(CPUState *cpu)
 
 bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
 {
+    const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
     static bool tcg_target_initialized;
 
     if (!tcg_target_initialized) {
         /* Check mandatory TCGCPUOps handlers */
-        const TCGCPUOps *tcg_ops = cpu->cc->tcg_ops;
 #ifndef CONFIG_USER_ONLY
         assert(tcg_ops->cpu_exec_halt);
         assert(tcg_ops->cpu_exec_interrupt);
@@ -1081,6 +1081,10 @@ bool tcg_exec_realizefn(CPUState *cpu, Error **errp)
 #endif /* !CONFIG_USER_ONLY */
     /* qemu_plugin_vcpu_init_hook delayed until cpu_index assigned. */
 
+    if (tcg_ops->cpu_realize && !tcg_ops->cpu_realize(cpu, errp)) {
+        return false;
+    }
+
     return true;
 }
 
-- 
2.53.0


