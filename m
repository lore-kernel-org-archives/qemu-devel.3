Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2FCCAC5AE
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Sep 2025 02:56:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1c98-0001yM-Rt; Wed, 24 Sep 2025 22:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1c96-0001y5-0w
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 22:55:48 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v1c93-0002Xm-KR
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 22:55:47 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3f0ae439bc3so178643f8f.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 19:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758768941; x=1759373741; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dyY/0JMwlhFdHMWPEQckqPFnacgRGiLG+fvLLRk2tvo=;
 b=ny7dJPgPDGt6nB1aGPok4ozX90UjJ2hi/M3dlhtjT5DE/IHzCyQiJwSDOt+NmSBuba
 uHdWFBmroqj9rlFLF9rNv1zGMTsn3JLP9w0RJxk/XEutQDQI5O1kM9JzAUzQ9rJolMiw
 qo+16f+T3VQ0la30URLPbIvNhgIpjkDkXtdJ6Nt6qdkXHt0wlSmP7vFdXntMDcxdiwoV
 rfvKB93xP2MZGvRycNv4Yo9kDwOw5e4/3PKqThZ/6KBNdPGjJXlrQuQ8bVnfJDSfrlLp
 QMW/Es0WtHo06Db60FK+6zMGkUvMZrbq5lBh2GVBMgVYmDfF0tyjUNu5TruL9ukCeFqm
 LaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758768941; x=1759373741;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dyY/0JMwlhFdHMWPEQckqPFnacgRGiLG+fvLLRk2tvo=;
 b=YhvDpek6ex7glKx7uNf1KnEQK5ExAGukHuuCvkXk/I1o1GmzqMJ34LTISHL+RUWWo0
 zwbYbAgOkK/l/QGU5wKyAuMqUiMei6siBU2yi65AI7j04GoLRClVCankocJyLZVY5fS9
 277amsdTWe3PPfUL3hmFj4j2u1Yb/lUDG43hTtva6RyL2apM48oLl68DMUZnuQjOLEE0
 ALXS+Gr+U4qc2eWtBSh+c36Xd8lqUe6ImOUlOEhgvVOIeWhSgMfesBoHTblcpu8avJqy
 S+BpuMP9A4ZCoKBy/ZsBbtUj2xWb1+Tz9bH5PuTadX6KwH0YAogZHaGWH2jsX749pnPU
 bl8w==
X-Gm-Message-State: AOJu0Yyi1kS+dfbAXzIpBZxNxKYn0ryV8RDxNTJLyu/70EEXpEZyrmg5
 bklN9Ptq8XDBSgaHylI8QVeBA1Ts6z9FweKjpiXTdQ98pgRamhGKwVDdVAXJzw8uHSmk1+nco2e
 nMLhRcXBVPg==
X-Gm-Gg: ASbGncuqiLYyNZcKxuHFDfKET69NUyPRkJTFnyHa8b2sQcYWfo3aFnAkFrbEap8fuPU
 NwyWJxBv8GlxWb2V8pOgj0CQay/LrKF1mRp3fwq6553IsLc/w/6YFrDy6EnRblSAIXkQKl1PNdc
 VTAxtmKTcjnGOoLzgEK2G2VD6s7nYW10QEZPqzruIIYyhXla0jql0Cr5FmVGwVQiUEX1zc5S+T7
 6/2QHKk9ULX5bSXFcw1h/BN8ylh5ocz24iRlI8eMguA/61re+7AoLWO6uVXvU2TOTFozYaPCxgi
 vxildQqn7oXFamN4vgwa8gO+aB/bTAD91sYwQdB9kKL8A0yB3AVTvldqOBx/Pa6307ZZZRSKWab
 9V6QWwGI5xwyOiZYVqhQ1Bcq7ldK1R96UTDSfMk5bbUp1UKrJ9fTzGRiO+d3nW1t3lLLvl1sWJp
 rq51BXwSs=
X-Google-Smtp-Source: AGHT+IHtWu06zmRy5/nYPLdqSOFdRIyiwVELk28bvhojUK1W2UNKS10OKZZCuheCHeiGLdWsMgNVig==
X-Received: by 2002:a05:6000:1861:b0:3ce:f0a5:d594 with SMTP id
 ffacd0b85a97d-40e458a9804mr1679320f8f.13.1758768940576; 
 Wed, 24 Sep 2025 19:55:40 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fb72fb21esm962957f8f.7.2025.09.24.19.55.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 Sep 2025 19:55:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mads Ynddal <mads@ynddal.dk>, Alexander Graf <agraf@csgraf.de>,
 Cameron Esfahani <dirty@apple.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Collingbourne <pcc@google.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>, Sergio Lopez <slp@redhat.com>
Subject: [PATCH 3/4] accel/hvf: Make async_safe_run_on_cpu() safe
Date: Thu, 25 Sep 2025 04:55:18 +0200
Message-ID: <20250925025520.71805-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925025520.71805-1-philmd@linaro.org>
References: <20250925025520.71805-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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
---
Could be related to the dubious thread_kicked access and pselect() in
hvf_wait_for_ipi() (commit 219c101fa7f "arm/hvf: Add a WFI handler").

Cc: Peter Collingbourne <pcc@google.com>
Cc: Alexander Graf <agraf@csgraf.de>
Cc: Roman Bolshakov <r.bolshakov@yadro.com>
Cc: Sergio Lopez <slp@redhat.com>
---
 target/arm/hvf/hvf.c  | 2 ++
 target/i386/hvf/hvf.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index b77db99079e..377eb4bbc6b 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1927,7 +1927,9 @@ int hvf_vcpu_exec(CPUState *cpu)
     flush_cpu_state(cpu);
 
     bql_unlock();
+    cpu_exec_start(cpu);
     r = hv_vcpu_run(cpu->accel->fd);
+    cpu_exec_end(cpu);
     bql_lock();
     switch (r) {
     case HV_SUCCESS:
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 8445cadecec..913ad47f3d8 100644
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


