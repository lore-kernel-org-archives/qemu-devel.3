Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB9F0CCFA02
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtxG-0004xv-HL; Fri, 31 Oct 2025 14:34:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtxB-0004wr-Jo
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:25 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwb-0006Gu-Lf
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:24 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-429b895458cso1590736f8f.1
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935620; x=1762540420; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WX7Ee6VPJvKSDjRLMyJTsu752I/A2CwZTQzBhElT1bU=;
 b=j4ntgdcTEeyTzeHk5NPES8BvAfscBvlP/3XR52OYLbNo6sTKlIdTM6W2MxuDL/By63
 QfkCpQtn0VqRvI8yuPPaFb8TYfmjw4D3icUPlB8r4hyy7CXa7RC+WMZfMXD39sfLNJx8
 HrO/7YSjpWyZXo44jsUUTX4VyHmKmoWW6sROLQur3A6Vex39pAUgcqYHX/EjHnbVwyCr
 fRt93XY4HZF/fFa9G1WcM9sHk/JS710TWIqWhh0y8lDms/MIOiA9ir3hupObrz9w479w
 2WvWP8tJQzgQEYtxsngmZyjLrpCtQw0y/jIoLTG55uH84xKiZDcSnJOvIGZ0l4rQYo8w
 stJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935620; x=1762540420;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WX7Ee6VPJvKSDjRLMyJTsu752I/A2CwZTQzBhElT1bU=;
 b=ecf03oVbeo7wSg/J+ch6OKf/NS9mEW0HX8WYIS3+PQXJjeiHLJgtlnCmDGNONGJ3wJ
 aulLhSp6Z0NpQQ0Udg+uslsDD0j7v+twCqKRYO0fEyph2ZF9p6ySi4O/0D6kGKKThWNZ
 m4xf8umIKfp6FDEduSsZpMtSKRCmwsS3zz/oTMraO3cMRSRtuZddOHvrVjgW937vvv3A
 jLaDs+uaN9lqDsomgmhFNoL7wQyZqMf5tu8W43Xl4U0TCO5tgMtyZHUR05Ci6sK91cdc
 CizD4DtqO+qfVWKAiQSgkFRlFXau8lU8owelId74+wOx8UdS50gX2u8qgAVVkQVhVX99
 95iA==
X-Gm-Message-State: AOJu0YwSS6mtp0O9b5n+ZnlvwNIKXNfB4F+LoaDqRJ+hut/vSTv8ojCm
 vZb4rX+E0qFg3G4l3c0O3XL+9KDDPMRnInEXr9nleciJ1pj8cxup8Hk+N87v28xc5Cpp6MZvLxQ
 iGps9
X-Gm-Gg: ASbGncto3NvEzg1UAWfeiEMOl3Z1Nl3M5s7pvUmZym6hBiOCrGmCFRK40QqfILwjf/l
 ZzwpcO+kPFoZdlnkWMdA+geU/U2wwb1008a9fRm5rGUSJ6GwG6vB42kVVRiobvayguUTJi60gM/
 jTEEKgfxxE1THuEucqJrUx9hdb03iPuMOnYAnBHsNl6I/Ibh3C+SHTQG7TvwfnRJoEOGgqP0Ezf
 nEvRl/6VGgIsML4SWSxbdRCkoeU1N7O56Cn14bnf+405oj5YWMBSTlc1ZwkUr+OTRvoGANfYGwk
 H3EpVdbDjRTMfoo4m3AxOKLCQ97YiGPIrUUPn91/Sq7ZXKU+PtgjlTj0KUhkCkUO44qi8dWDRgS
 QZOQSNkkH1yIWro3yGjRrY6myxFvtbajV1EVPdjcqavOiqpLCcW1G11H8e7GPZUu14GlIIh76GX
 C/ZZslGg==
X-Google-Smtp-Source: AGHT+IFOfLoNcAYo6sIha9Tq7MqiVZpKk/HuXCQpAm1QYCLq2/b7USmq9AG9HqBGu2EWUn2H4r6nyw==
X-Received: by 2002:a05:6000:2382:b0:427:6c7:66f8 with SMTP id
 ffacd0b85a97d-429bd6a7d6fmr4454319f8f.52.1761935619692; 
 Fri, 31 Oct 2025 11:33:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 28/38] target/arm/hvf: Keep calling hv_vcpu_run() in loop
Date: Fri, 31 Oct 2025 18:33:00 +0000
Message-ID: <20251031183310.3778349-29-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Mads Ynddal <mads@ynddal.dk>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 27c600148f9..79861dcacf9 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2013,30 +2013,32 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
     int ret;
     hv_return_t r;
 
-    if (!(cpu->singlestep_enabled & SSTEP_NOIRQ) &&
-        hvf_inject_interrupts(cpu)) {
-        return EXCP_INTERRUPT;
-    }
-
     if (cpu->halted) {
         return EXCP_HLT;
     }
 
     flush_cpu_state(cpu);
 
-    bql_unlock();
-    r = hv_vcpu_run(cpu->accel->fd);
-    bql_lock();
-    switch (r) {
-    case HV_SUCCESS:
-        ret = hvf_handle_vmexit(cpu, cpu->accel->exit);
-        break;
-    case HV_ILLEGAL_GUEST_STATE:
-        trace_hvf_illegal_guest_state();
-        /* fall through */
-    default:
-        g_assert_not_reached();
-    }
+    do {
+        if (!(cpu->singlestep_enabled & SSTEP_NOIRQ) &&
+            hvf_inject_interrupts(cpu)) {
+            return EXCP_INTERRUPT;
+        }
+
+        bql_unlock();
+        r = hv_vcpu_run(cpu->accel->fd);
+        bql_lock();
+        switch (r) {
+        case HV_SUCCESS:
+            ret = hvf_handle_vmexit(cpu, cpu->accel->exit);
+            break;
+        case HV_ILLEGAL_GUEST_STATE:
+            trace_hvf_illegal_guest_state();
+            /* fall through */
+        default:
+            g_assert_not_reached();
+        }
+    } while (ret == 0);
 
     return ret;
 }
-- 
2.43.0


