Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1288CE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Dec 2024 20:10:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tQB9t-0002li-Bh; Tue, 24 Dec 2024 15:05:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9j-0002jU-Ir
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:30 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tQB9h-0002Us-Of
 for qemu-devel@nongnu.org; Tue, 24 Dec 2024 15:05:27 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-21680814d42so52211635ad.2
 for <qemu-devel@nongnu.org>; Tue, 24 Dec 2024 12:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735070724; x=1735675524; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZG6ae1a+VQYDF+HP8pwyU2WyU4xA7uudCLK9pyvDcw4=;
 b=YP/8EBKQCBeA+I5TNXMTHmBe8XG4ifwGnXK3FuD5QELLegUs0iC/r8911ZJVIQ/yWp
 rO9LNdSuKLNVpKt16KxOLeYV5ht4Wsnh3TpV4auhHwRLE9V3/7PRi+PDllGlnih59dMi
 1Sy/VrhK2vUwb4jR8c2/RA+UK20N+pO6BWcVBAe7YcXhDlMdFy/TyyHSbVQDYiyP8Sah
 lMpQ4i3xMdJ+L6uDQjI4mNMf3fLGgGtZQZ3SxOKkvAPr8sMs3xsnkaIFG77uhh8flpK5
 I41mHnqSLLeBU7+OYYKZLbe4dnU3U1a9Kx4GCwoaDJoX8xVG4h3mo1U7x7ApTvU6Mw+/
 kkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735070724; x=1735675524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZG6ae1a+VQYDF+HP8pwyU2WyU4xA7uudCLK9pyvDcw4=;
 b=iiNq6fyfsnpjgHPSmkAzkP3MHnKEzxTwfLx9gktE11gAj4g6IWHOZpGLCggMySyJB+
 Qy32Z8jV/lAsiPwNfkvqmgmfgPydpug66+etxjj8+yehH8gnv78yuc1PDXWwyEnYzAtd
 1E/Ul+smEh9ed7T/qHoRw5Zl5fQlpNk3i2DJAy3gfLqgGygSX57FEcrrr6MmrJqL4XE6
 Q/R4ZIWEO+d6HDCoPrhCbsww6+qRvOTUM5mNRDyzp45DzXJUIabpilp/BNtW+q7hlr4U
 v3bZg7Qn9PB1b0pT0fJxaufXVQS7AzXYxCMosUKNCBqUafD0nX0ZSMRcprq3lu89ibd+
 sx+g==
X-Gm-Message-State: AOJu0YzSqtwRyUKPcXPqUu5dhOsoMOdxMY5P9dFkVyB0HMYwLWlg53sR
 Ki1e2Dbv6pFU/2W3dzolu7CYWORAGcK4FtLUeSJb9QCrVvamoJjzMPch14u8EVei78annICC5xJ
 759k=
X-Gm-Gg: ASbGncvUdkWr0xkH3K3W8Duetq602cKkm59hDgzPhKnjFJ/al8gsXx1b5EjoZfBfPwn
 U6O9cEZsjFDb8gDre6kQ3QXvAoau+U85VU22taJozRxvCpOBtRG3SmmCwZRxBwutVLYX78SW/MH
 KTDUslClD/v0utfEL7K0UVCtQkEAzfNV6WSjS/OyaBQIaX4tpWYprRRZdTSDYGQmthZYEGrena+
 WRXIdyyc8gGRggA3VrlKS0o+rOPXJfI5bHim17/e6srle7OV5AU0LgngSaDMOLWUE7pYsLsijc7
 mljd73JeW10UF+riw6dq490Vjg==
X-Google-Smtp-Source: AGHT+IFdNm+EyAWGLjV3/jJAWhfmIhhQ8Z+LaOj59eyJnoiNa9sy9eSt2bkPNUgu7rxrcl0m+D9BYQ==
X-Received: by 2002:a05:6a00:1942:b0:725:cfa3:bc6b with SMTP id
 d2e1a72fcca58-72abde404b0mr26512426b3a.3.1735070724395; 
 Tue, 24 Dec 2024 12:05:24 -0800 (PST)
Received: from stoup.. (syn-156-019-246-023.biz.spectrum.com. [156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72aad8fb895sm10027159b3a.162.2024.12.24.12.05.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Dec 2024 12:05:24 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 02/72] plugins: optimize cpu_index code generation
Date: Tue, 24 Dec 2024 12:04:11 -0800
Message-ID: <20241224200521.310066-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241224200521.310066-1-richard.henderson@linaro.org>
References: <20241224200521.310066-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

When running with a single vcpu, we can return a constant instead of a
load when accessing cpu_index.
A side effect is that all tcg operations using it are optimized, most
notably scoreboard access.
When running a simple loop in user-mode, the speedup is around 20%.

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241128213843.1023080-1-pierrick.bouvier@linaro.org>
---
 accel/tcg/plugin-gen.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/accel/tcg/plugin-gen.c b/accel/tcg/plugin-gen.c
index 1ef075552c..7e5f040bf7 100644
--- a/accel/tcg/plugin-gen.c
+++ b/accel/tcg/plugin-gen.c
@@ -102,6 +102,15 @@ static void gen_disable_mem_helper(void)
 
 static TCGv_i32 gen_cpu_index(void)
 {
+    /*
+     * Optimize when we run with a single vcpu. All values using cpu_index,
+     * including scoreboard index, will be optimized out.
+     * User-mode calls tb_flush when setting this flag. In system-mode, all
+     * vcpus are created before generating code.
+     */
+    if (!tcg_cflags_has(current_cpu, CF_PARALLEL)) {
+        return tcg_constant_i32(current_cpu->cpu_index);
+    }
     TCGv_i32 cpu_index = tcg_temp_ebb_new_i32();
     tcg_gen_ld_i32(cpu_index, tcg_env,
                    -offsetof(ArchCPU, env) + offsetof(CPUState, cpu_index));
-- 
2.43.0


