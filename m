Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A34CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 21:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEwUN-0000mo-NJ; Fri, 31 Oct 2025 17:16:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEwUE-0000dY-2u
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 17:16:44 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEwU5-00021N-DX
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 17:16:41 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47721743fd0so14762425e9.2
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 14:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761945385; x=1762550185; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=+En8j9Horx8F5fWG7/X0L43+mjYCkQcMJZrOiGxXBhw=;
 b=iYvpJ2FFwkS3el5hIx0bnA981081bl9Gc6453CXET7qjWQqyREh/oXcoez16ZPqLln
 6O4ZRlQc+lTCVFkWHJk7lDpU5GG0RACqa/A/QPLfzmyuLlkRSMf4OL2dLYpBPFHRxB+s
 TOEA2Nv/g39MSjdpOtzFAan3nXjGaUmlbMZQsz3R1subTJ81hDgMGp6PM5tMzaP5pou6
 TKwoyxHz0abxchaDhPqRojdhsOs5yxZGUvKv4wQME1Iq6AnEbXKwSdJPCjTMzeOYBRuY
 sSZyx9sKSjrlU1oWczae/zzcOzQ5/0ivyKXhiJApThEkDnb0r6XzCp4fTqvTaafjHfWQ
 ndTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761945385; x=1762550185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+En8j9Horx8F5fWG7/X0L43+mjYCkQcMJZrOiGxXBhw=;
 b=kwv/1S+GCNMeNMXcAc46YfcLnyubU+IZJ69x3Jx6Joh5LOPMCrhT5hOS2EH3t4Dd81
 SV6dAliFgy+BuDSExrLu1TNnXE5MR4SCM4jszkwufSxozCUX1Aq0BSBDLqtN2w78wt8q
 tQ5ytm0gxFMl7COc6GQPE1RlY3Dsx04xZdQTPSBCbU/r1c7KVNu9V2q6FoYL0bXUnJ7g
 N8u5fPTwbDE6YRi+U4GOCUWMEtvhJCsfEigJJV+Cb/VNG08JtoN2y0jEdotqsZBkiQk7
 ngREv0FuXbZTF5hLMu5xOXIHg8Lg8IgM9za7Gn3A+BM/Xs7KyR0RgRhwhI9dKTW+TirT
 nnlw==
X-Gm-Message-State: AOJu0YwOfzogKFXVRrQ5YUk5bdb6EmgXLosFg3pUeWUXKElBgLCZ3kuL
 UUy/Po/KlQLh7DP3YcvbBOqhJEnDJXKy4GGgOmEnaEWA4yk4BmQK7Qza+Sw5Ph+1cE3wFokvYf0
 TDb77WjujOA==
X-Gm-Gg: ASbGncvVpd04YYF+0dZTNuIPEtocBXfHzjmsUHEq285eOlXnyTe9FiE23jJmPlKFLeZ
 C03YnFU2XD79C9cwO9706ZBhnaJ5ahIP4vQrXsSCokMYk9s29EuA0f8AcNQTy0vHQyrHYiRtUO8
 wsaO2p49c9FKq0nKO7f/DQgQMbu09DdnmnN3bqekYxAzZCKPP7ehjM+7ek3u92NqhCWvyMZNfSC
 GDScpcTesGI7e79QWCJwDfM66fHm+rh62KaEQ842wbPLUrkc9jFp+/8ZQvMr3a3ipPmLRchAWWX
 XBeFS/ep/IFq/jkI/6bxx0wrTmqPQUoO6+KX7FWYXRBuPZN2Mu1c6jXOZ32k6FAuOsKURrFe1wb
 WQlifcWbJDF+p1zg3RP9xyg92Pb3wc6Y+2PN4oLliEX+nflm/IyVFTeXe/+7KVGB8yqNe5SsJBm
 WZTiyv9HutE4pAOwU7oS96lfOHLJHTbLl3O8mwO2mksQUA+viQvK079A==
X-Google-Smtp-Source: AGHT+IF6C744bMV6wY/qkJsFvYPFAPbUT3styMIMthZDESQgt7s2+Qht/r3mGe8m2GnUatrfZd8Uqg==
X-Received: by 2002:a05:600c:c4a7:b0:475:de81:563a with SMTP id
 5b1f17b1804b1-477308b22a2mr48047455e9.33.1761945384845; 
 Fri, 31 Oct 2025 14:16:24 -0700 (PDT)
Received: from pc56.home (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429c6ac1645sm685947f8f.12.2025.10.31.14.16.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Oct 2025 14:16:24 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 2/9] accel/hvf: Make async_safe_run_on_cpu() safe
Date: Fri, 31 Oct 2025 22:15:11 +0100
Message-ID: <20251031211518.38503-3-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031211518.38503-1-philmd@linaro.org>
References: <20251031211518.38503-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Wrap hv_vcpu_run() calls with cpu_exec_start/end() in order to
have the main loop perform more exclusive sections while all
vCPUs are quiescent.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20250925025520.71805-4-philmd@linaro.org>
---
 target/arm/hvf/hvf.c  | 2 ++
 target/i386/hvf/hvf.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 0658a99a2d1..1e50632557e 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1803,7 +1803,9 @@ int hvf_vcpu_exec(CPUState *cpu)
     flush_cpu_state(cpu);
 
     bql_unlock();
+    cpu_exec_start(cpu);
     r = hv_vcpu_run(cpu->accel->fd);
+    cpu_exec_end(cpu);
     bql_lock();
     switch (r) {
     case HV_SUCCESS:
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 33f723a76a7..8cd1a800e0a 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -749,8 +749,10 @@ int hvf_vcpu_exec(CPUState *cpu)
             return EXCP_HLT;
         }
 
+        cpu_exec_start(cpu);
         hv_return_t r = hv_vcpu_run_until(cpu->accel->fd, HV_DEADLINE_FOREVER);
         assert_hvf_ok(r);
+        cpu_exec_end(cpu);
 
         /* handle VMEXIT */
         uint64_t exit_reason = rvmcs(cpu->accel->fd, VMCS_EXIT_REASON);
-- 
2.51.0


