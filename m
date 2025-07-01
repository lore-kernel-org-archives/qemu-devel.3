Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D53C8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:11:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSa-0005gL-F3; Tue, 01 Jul 2025 13:07:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSX-0005dX-J8
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:53 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSV-0003bf-Rs
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:53 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a5257748e1so2351973f8f.2
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389670; x=1751994470; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=AzcsRGchl752kffQ5Y7VHDcNl2gOJzVVBkDGDtDpFlc=;
 b=oK9tCB9Teu3ZpFpDL/qJvij2dGAXxqehR3fLM9wLiCcKgVcpv9Et1Q4YkKJ7uf/u7A
 bEYWIVb+4yHOh5Nm98WVo1tgKG2idGVfe/0nXKeLpPVzrYkqfoIun4kcM3JyYMVrdMR0
 ef+7UZs0yN6Z1pqg+pynrQ5i4MGzQqGkNO8+iSuiEQbMIKT6YDENcPpC60A7JnUl/UJ1
 YhIJ/LpNeFWYD47Dxr1glcM9kE9R5+88WBUYSykLhtKBvIhdni/GMNzLi4yQcxJANeXc
 t3eAqY0rN9Fha+FG82Rs7c5AEgu9QSmOfakqyYaGGMhucKtMP4aMg4xS+OSE99rxNexc
 clJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389670; x=1751994470;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AzcsRGchl752kffQ5Y7VHDcNl2gOJzVVBkDGDtDpFlc=;
 b=vmllf7ejh18y9Lm6EQkeekc4GtUZPDHHU3Y/YTMbgFSZfZVcqUWjQhO9/4ZPZynOru
 261uF6PM/WB80NPGelXYOvhcbpv0MqYgVAnA4HF9aGAsYpUzl0kKzFR7FjVFEjlYpKmF
 yzMIUbQ9UgLjtZAz8c+8FsZ6yQA8ud8lbM//75wZ8zsEyf/eM2aelWFSs/lTAJrSX93T
 eO+zJbisxqO5RYIjXBBVAhPOiExSh6xJz4JXFR3+b603VVN9OHJSaB0VjZyF7S+vgq4a
 29mH1E53pF47NNVmrqZHAJyXAEDqxccwiMtDh8k6jJhA6p4dOdjgcsqJNLm1NudctZLk
 OlBA==
X-Gm-Message-State: AOJu0YxPnKxlWF6VTmNOBysG5DXubf1iOiyBukDQWjIZziIhkHHWh2rB
 N0DaU4WSR+V1KsQvq2XJxBoQL8flrcamYbqOH6tVlhnxUlW4qjsR53O9vUk0OkLslsGvIAfhTAl
 DFiY3
X-Gm-Gg: ASbGncv6XXq66YjlAZLNEq10G5yBedGCrLS2p5fGBBc1ml6zMkfzrABsZuaVkDAyoDz
 a6ka8vrSzrDQlsEy1+jggpBFCGdyATopE5vKEgZ5LbkKEZzPx8Z1R4mE3ILIV1j0dQsb8N02h7u
 1EFtEMz2lEZKV2q9IyP9q3XOOY9oMk+RnXA+UJ8iCLD8MB3Ub/ZSez1nqvjCY2afetunikMJoRg
 b7hGTFLjgTglTAzBbbkhJVfcfTHDaxCNNfezqhviePbHXDtIO4ZveNhU7xa3NqWQW+A4AszWkbA
 ZM6EEbXazHZiATgINXgRBQCi1+CTQn5QGGcJNXhyF+LHKY1rGRZnnxUXJeQSeqKdI7ez
X-Google-Smtp-Source: AGHT+IHQtkRRRCB/uVDHo2GlbxTSd+JlM4ZSyjRA1JQ2FnITyZCmr1JUldG9cM/2DliwOown+KLNVg==
X-Received: by 2002:a05:6000:4404:b0:3a4:f66a:9d31 with SMTP id
 ffacd0b85a97d-3a8fdb2a034mr11222132f8f.16.1751389669593; 
 Tue, 01 Jul 2025 10:07:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:07:49 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/43] target/arm/hvf: Directly re-lock BQL after hv_vcpu_run()
Date: Tue,  1 Jul 2025 18:07:03 +0100
Message-ID: <20250701170720.4072660-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

Keep bql_unlock() / bql_lock() close.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Acked-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Message-id: 20250623121845.7214-6-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/hvf/hvf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
index 5c95ccc5b8d..3c234f7b112 100644
--- a/target/arm/hvf/hvf.c
+++ b/target/arm/hvf/hvf.c
@@ -1915,7 +1915,9 @@ int hvf_vcpu_exec(CPUState *cpu)
     flush_cpu_state(cpu);
 
     bql_unlock();
-    assert_hvf_ok(hv_vcpu_run(cpu->accel->fd));
+    r = hv_vcpu_run(cpu->accel->fd);
+    bql_lock();
+    assert_hvf_ok(r);
 
     /* handle VMEXIT */
     uint64_t exit_reason = hvf_exit->reason;
@@ -1923,7 +1925,6 @@ int hvf_vcpu_exec(CPUState *cpu)
     uint32_t ec = syn_get_ec(syndrome);
 
     ret = 0;
-    bql_lock();
     switch (exit_reason) {
     case HV_EXIT_REASON_EXCEPTION:
         /* This is the main one, handle below. */
-- 
2.43.0


