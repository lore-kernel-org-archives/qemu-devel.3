Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05CE4C3ABAC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 01:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBl1B-0004MK-2p; Sun, 04 May 2025 21:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0o-0003wn-3v
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:58 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBl0h-0002YD-HJ
 for qemu-devel@nongnu.org; Sun, 04 May 2025 21:52:52 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-afc857702d1so3830270a12.3
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 18:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746409965; x=1747014765; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fgL5ekQCPVNJfHfcPabdFrIvM+ux1exN882JD3eB0JI=;
 b=bnqyxp3wEtOgDUusYNCiTdzoCYjycYr1bFf/6yMGcuiZ9n9/0WugTr3jjtxOO6wFLR
 8bAFOX83IM1qAgZBIxrGwcY1Omp6ItizTMXfK3O3nOrlk1tY4jeH7C/DMVQDkaXnZ9DZ
 2wM5kdXxk9KL73jISojxBMrGF6D7djnsGaGf1CQGg/ZiprPM7m+b51cnMog3lcAPiyG0
 turKaRkAJh0BLTT4P1lhb6/knmjbRXd6agMJ1aiku1uAN28Qt/mtja2Um4CM37fUlx2+
 jPDzqab3VzSC1UFpPP1DaeQVmj+QhnNVBMAz9uFCVtlnSwb0nkqAfvyv+nMbtyM1Z4c8
 E8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746409965; x=1747014765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fgL5ekQCPVNJfHfcPabdFrIvM+ux1exN882JD3eB0JI=;
 b=dWWe9YwlTFV6d17yCBk6wazbvCcOPDXpZk1vYjUJkWL5n8pdvupwqm6naEiEMW5wde
 3a/BkYV0aGxoAL58vfHnsgF7UZoL3N7kZbxa8cJOV21ptRhfEpHlPreK3wfBCVeiHiCy
 +usUyTEt5fuqZCjDKQwgE76p79PkOEXQr9VWdzF7S9YAkxyF0Znupa945cMTcBJoUKHN
 o3g0er4LtTagb6w2E9kkxi8/bM3XXSRjI4wTN/py+lEi8mcBanzf1/3WQYLe0NFSAZbN
 ZfZHxdWGrJbRp7kv2HcPc3qZF9gFnmyt4Y/OKAdk27GyZbk6vCAlJfhL2QTQym+Vp9nP
 c94w==
X-Gm-Message-State: AOJu0YwRhdL3HSuTdpq8raqvhftPUzTIz0k5GmV7rv+KG5hm7iDyyoYT
 dX5Cu6ZRDrLE2ONFpkvERdNjrmvyjneM2f/3JqVvf5Jt9tuhcedMzlhzDi50vQ9WftunMIsHf4m
 kDQo=
X-Gm-Gg: ASbGncs6x2ERUUzzYIjk6zn+nNXXAQ/Q12lWWSg33iWch3f+85C+5E5f+CyctgenWA/
 Xk5qnD8FHPNgX5O8EU3vf9IZ/WR7LpOOfb+T7075jGsnLvThJARkyhiS4Q9RQmrCZZ4RaMkj84+
 DIdriwZ/APQdO6jt2KYREuP59hBg4yrcWKS1JyykovdSinvtTM17wO0Ghcwrs/p+cuPWxYXCuaO
 ByGjQXZ3Y+X/7Ydn32zZtQ0WBPqy7W3MxUDTgTjMLMDtMPxQ5zFdhzTGuxjmy6wu8oS4fbRty3J
 C5CQ+c/xPad00a2bm2oy0yW5ElBvOZkoRyLZNiEo
X-Google-Smtp-Source: AGHT+IEdEQhyDtvpOmBsbLxVZ35ACEJ8Qp3GYlqIZlG1XakJNo2D3KbXjIylsJzSXoYN2mahc1rK+Q==
X-Received: by 2002:a05:6a21:31c7:b0:1f5:889c:3cbd with SMTP id
 adf61e73a8af0-20e078fc982mr11730268637.35.1746409965255; 
 Sun, 04 May 2025 18:52:45 -0700 (PDT)
Received: from pc.. ([38.41.223.211]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b1fb3920074sm4462101a12.11.2025.05.04.18.52.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 May 2025 18:52:44 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 richard.henderson@linaro.org, alex.bennee@linaro.org, kvm@vger.kernel.org,
 Peter Maydell <peter.maydell@linaro.org>, anjo@rev.ng,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 19/48] target/arm/debug_helper: remove target_ulong
Date: Sun,  4 May 2025 18:51:54 -0700
Message-ID: <20250505015223.3895275-20-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
References: <20250505015223.3895275-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x535.google.com
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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 target/arm/debug_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/debug_helper.c b/target/arm/debug_helper.c
index 357bc2141ae..50ef5618f51 100644
--- a/target/arm/debug_helper.c
+++ b/target/arm/debug_helper.c
@@ -381,7 +381,7 @@ bool arm_debug_check_breakpoint(CPUState *cs)
 {
     ARMCPU *cpu = ARM_CPU(cs);
     CPUARMState *env = &cpu->env;
-    target_ulong pc;
+    vaddr pc;
     int n;
 
     /*
-- 
2.47.2


