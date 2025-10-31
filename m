Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEC71CCFA02
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 18:42:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEtx8-0004wL-BI; Fri, 31 Oct 2025 14:34:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtx6-0004vT-3k
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:20 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vEtwb-0006H5-70
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 14:34:17 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-429c19b5de4so855097f8f.3
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 11:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761935622; x=1762540422; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=0H/Qs0aq5jkMkZf4wHt7jLxhKz1DXfAE2FEms7PGAtg=;
 b=ZAxFFXfsMcz2LBDGT8SDqSfkWh5yXi46d7XGQwCWjbGgfo/wKH732EEPt0kUAgbWZl
 5QJu7DP4Uu1dONlVL3oe6RbRlCD0acV8Onh4I8CSKh6eOko3wMwaz9FG52UVLCT1HeMd
 +dTCVjDwPJhrtbxIpflYyYV5+R0y8X4yn+sZQokJjPfwBeyLHXiEa0LRnoSqaBJkIq8e
 YNT+8Y6c2mqrhLBghYOXbVB5N1j00HdBZYNAuAud+U6NAVs+sGltDcQgXYu/Fdrpt2tO
 c5OfCsDXb8PuOEc13rGoW+1+KVn/xCHhBJtCYO/kk/Bt69txevZ94pHtqMZdYA0HStGK
 w+RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761935622; x=1762540422;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0H/Qs0aq5jkMkZf4wHt7jLxhKz1DXfAE2FEms7PGAtg=;
 b=edLu4V7W/T6TGx8tCdGdogzdjuv/auOdx9ksqyapElW36NRODkDlG1pUyksD4/zlJR
 t0uDEuX8EizNIS+5fNvKdxwos9VCBWmLGHaTeqIvVDTCh19Q2hcCiMC1idIFOmUYVPtc
 cMWDxmULPkq+bDFXlN9kIgrBow2vSOe75VA+PItFVwtA58A9Bou4A63SNML91Afhs0WP
 tXK08AB+CT2wJWHA71ctHgTm4KAS0I/DZ+ErLsAwqFRfV+0yeDNoqlLdmu9khDsbNooK
 9NalXNzhy7jEzwXmq2+oQm7LoRDE3xexPN6CbAZw3YsJyzvGLr0CysmvpwaHH9bwozaw
 N6wA==
X-Gm-Message-State: AOJu0YzBLxg4reykhFK/VpFYlwc3zSCO5O/nGfPU8nC1UGLR1gEURx8S
 TQrLhdXSsoqGQ9q8MLUnTynRXRfD0ZPxRi8ji2m+EQIHAGGqHt8fH8qb+/wGsoKLbydJrKyp6wh
 PvROT
X-Gm-Gg: ASbGncuM9Wqq4jvlzHnYefUj7EvfVTIsKqMX0WyclTbIDIoYOGktlOdP++iU3a20GKE
 MyolYivwaE6DhFKnpvEUOpA72mOfhRBHDx6CkQPNgQIWHe+Ti+xWYTjzueUK2qiDIm0s1hmeaO/
 EP8P4US4Vnc/RCVi1zUCGS2zXT92+/0Y4TVh1dl+uMly5834RWdsYsYjsOXlyxmms3u4HTIxG7c
 J5Yb6hnOjThL41PNVq7bP1oMZDkMjuSHAcr4uYjGkfvKoVy0r5sXmkIjDHap25FMgXhsMRUGEx+
 6IGuIQvzaBveNuMZfugg6g7bqZGyaY1Z0y79CRmbf4Lk95TPOFeQVZNVyH9Qtv3ehVkscQFEzVL
 VIllpe8YDsckHb+LkuHh9nWxWlACle2ySjmcLwQi3tHC8XgReMO60UQvYblF4PiIGhlNmxQTKdo
 Kab+b9rKBGHgkVQiDH
X-Google-Smtp-Source: AGHT+IF67bW1b8DCVK0JHjNT79W6Uw/Ls0Duh7QiNJ3XLp3IXOUw8bGsTZ2KhZQKeGZo/+Yio55vtg==
X-Received: by 2002:a05:6000:1846:b0:3f9:bc33:2fab with SMTP id
 ffacd0b85a97d-429bd6c18a5mr4401201f8f.60.1761935621646; 
 Fri, 31 Oct 2025 11:33:41 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c114c944sm4859142f8f.20.2025.10.31.11.33.40
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 11:33:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/38] accel/hvf: Guard hv_vcpu_run() between
 cpu_exec_start/end() calls
Date: Fri, 31 Oct 2025 18:33:02 +0000
Message-ID: <20251031183310.3778349-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031183310.3778349-1-peter.maydell@linaro.org>
References: <20251031183310.3778349-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Similarly to 1d78a3c3ab8 for KVM, wrap hv_vcpu_run() with
cpu_exec_start/end(), so that the accelerator can perform
pending operations while all vCPUs are quiescent. See also
explanation in commit c265e976f46 ("cpus-common: lock-free
fast path for cpu_exec_start/end").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c  | 2 ++
 target/i386/hvf/hvf.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 79861dcacf9..c882f4c89cf 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -2026,7 +2026,9 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
         }
 
         bql_unlock();
+        cpu_exec_start(cpu);
         r = hv_vcpu_run(cpu->accel->fd);
+        cpu_exec_end(cpu);
         bql_lock();
         switch (r) {
         case HV_SUCCESS:
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 28d98659ec2..16febbac48f 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -992,9 +992,13 @@ int hvf_arch_vcpu_exec(CPUState *cpu)
             return EXCP_HLT;
         }
 
+        cpu_exec_start(cpu);
+
         hv_return_t r = hv_vcpu_run_until(cpu->accel->fd, HV_DEADLINE_FOREVER);
         assert_hvf_ok(r);
 
+        cpu_exec_end(cpu);
+
         ret = hvf_handle_vmexit(cpu);
     } while (ret == 0);
 
-- 
2.43.0


