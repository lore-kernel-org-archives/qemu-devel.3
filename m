Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70C4CAC5B0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Oct 2025 07:16:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4wTt-0007tS-Rk; Sat, 04 Oct 2025 03:15:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wTr-0007aL-8u
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:14:59 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v4wTl-00054U-60
 for qemu-devel@nongnu.org; Sat, 04 Oct 2025 03:14:59 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-46e48d6b95fso26497515e9.3
 for <qemu-devel@nongnu.org>; Sat, 04 Oct 2025 00:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759562090; x=1760166890; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y6YiFGrhElgy17XNOLMTwiIQ0FhusxVUdPgYaZsMQdY=;
 b=wFcgpqM1yObCn3TKe2janXRVcelHMB065naLV5TOKAwdu8ye0xtylb36wMauW3F5VZ
 N9/+NNQapjjJoYbbyOsYiaeL8WqBiBPj2bSO/sa/NB+sFxeRb523rsuKm3dtij8AxAG7
 wZUNbAAJ0+FeDRj0QXj9oum2387fz2zrUZYCNEaj5eiwhPchUIxBrxNapUgTKKuE3SOf
 7a1eZzpyJCAm+eoMl91UcsdXjfCBxAPJ8QNbIzxpB2vMzUX/10jLp/kC5SDJaZJg4aGT
 dqLzYVvCBayNJhnP3ExwR8SZ3tvoWCiKoJnuT8WXkgaEPVht9RSoeJkhINqiSJJNL3aT
 HyBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759562090; x=1760166890;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y6YiFGrhElgy17XNOLMTwiIQ0FhusxVUdPgYaZsMQdY=;
 b=ZV3quPSRFFN89HJxuN1XGt/DlGOMP6Sfh5WEjQpU1horgMybCsNeE0j9SpZ3DogiMj
 pz08Z1V91jsgcOP+L0pQMjFc70GaHFp6/FfvtFw6K+qP9oFs5FIqry3eIKp8X4y+XT8F
 fAjT0N8cS1lgap5vYcZkrh0U/Oh4gQH6OYxOtJNuDI9ldmf1C2gsSn1sHrr8FnXCyRJ8
 X9iQfmetGBRehNHXmTKQ+91euJN8YQO7e33U1/TeYExRSWXLVcQgkCegPPkdmgv8jIaZ
 zkTsnOMBRBrROXM4MAoeZEpb1n31zQ6O/Y/qaeVEjCeVqOlpNkRaQhp7H2A6WVAPaSIS
 ysTg==
X-Gm-Message-State: AOJu0Yw4haeewvWgbuTbp+Kgv08vXfTr9YxpPLGcGFeyfz8LYV4USBA0
 W7XLJSOG89etE6I4jC2tsQdimWZXPb5KruNovvmcoykojeIeo/8+Yl97TlWA3mZQy03wpI75R77
 8AIjuzDWPqQ==
X-Gm-Gg: ASbGncvGdbxaGJGX7+dp/Ft0dVIqiA3NVdz6HB+U61V2dqGBM0ZIYK8BYlWfv/+YZ9W
 1hQFvi8ieXCFWKO6eSNcsYGvGWGn1HXu/Hah2qflvVPRBmXPtOv6FeikN2V7FUIimKHElDt9yve
 7t4SB5o/MKgTqfxUno+u8yOv7kEw+aOF8oUI7mOBU79v6CbK4KWh7D1t2LUIO2v6DasPQsJFLtZ
 ChkkoeXSvGVFFLM2fWU3M46uh2XfTXbXq+OPLeYecD2S+g7Jc2OmKqehHJMaB5wLDZlwn8PTKUh
 HVF+GZxR2vB2xabmysVj8Dk1Q1aG7GhXSDeoAmQe2dZ/nui4wHR4g9/DRGKohFWNTmA+2vAlxR3
 G9mGvdhd/06M0hXImjfqoZFLjWUCHZPaNnvoKINemYjONjqPuBZ3ABUqKLNzUCjQs8+8QUR89pT
 iJ0XE+xY4qXXLSjcja17PsJka7
X-Google-Smtp-Source: AGHT+IGtaUShI4l+Ij8v8HCtivZk5RTFF01tI9PrW6gqtiqtEmsXajGi3MraVvkgXq8rEpgKMYGMfg==
X-Received: by 2002:a05:600c:474c:b0:46e:49fd:5e30 with SMTP id
 5b1f17b1804b1-46e711022dcmr40054715e9.6.1759562089568; 
 Sat, 04 Oct 2025 00:14:49 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f027csm11118176f8f.40.2025.10.04.00.14.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 04 Oct 2025 00:14:49 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 21/41] system/physmem: Remove legacy cpu_physical_memory_rw()
Date: Sat,  4 Oct 2025 09:12:47 +0200
Message-ID: <20251004071307.37521-22-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251004071307.37521-1-philmd@linaro.org>
References: <20251004071307.37521-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

The legacy cpu_physical_memory_rw() method is no more used,
remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20251002084203.63899-16-philmd@linaro.org>
---
 docs/devel/loads-stores.rst            |  4 +---
 scripts/coccinelle/exec_rw_const.cocci | 10 ----------
 include/exec/cpu-common.h              |  2 --
 system/physmem.c                       |  7 -------
 4 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
index f9b565da57a..c906c6509ee 100644
--- a/docs/devel/loads-stores.rst
+++ b/docs/devel/loads-stores.rst
@@ -460,10 +460,8 @@ For new code they are better avoided:
 
 ``cpu_physical_memory_write``
 
-``cpu_physical_memory_rw``
-
 Regexes for git grep:
- - ``\<cpu_physical_memory_\(read\|write\|rw\)\>``
+ - ``\<cpu_physical_memory_\(read\|write\)\>``
 
 ``cpu_memory_rw_debug``
 ~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/scripts/coccinelle/exec_rw_const.cocci b/scripts/coccinelle/exec_rw_const.cocci
index 35ab79e6d74..4c02c94e04e 100644
--- a/scripts/coccinelle/exec_rw_const.cocci
+++ b/scripts/coccinelle/exec_rw_const.cocci
@@ -21,13 +21,6 @@ expression E1, E2, E3, E4, E5;
 + address_space_rw(E1, E2, E3, E4, E5, true)
 |
 
-- cpu_physical_memory_rw(E1, E2, E3, 0)
-+ cpu_physical_memory_rw(E1, E2, E3, false)
-|
-- cpu_physical_memory_rw(E1, E2, E3, 1)
-+ cpu_physical_memory_rw(E1, E2, E3, true)
-|
-
 - cpu_physical_memory_map(E1, E2, 0)
 + cpu_physical_memory_map(E1, E2, false)
 |
@@ -81,9 +74,6 @@ type T;
 + address_space_write_rom(E1, E2, E3, E4, E5)
 |
 
-- cpu_physical_memory_rw(E1, (T *)(E2), E3, E4)
-+ cpu_physical_memory_rw(E1, E2, E3, E4)
-|
 - cpu_physical_memory_read(E1, (T *)(E2), E3)
 + cpu_physical_memory_read(E1, E2, E3)
 |
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 6e8cb530f6e..910e1c2afb9 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -131,8 +131,6 @@ void cpu_address_space_init(CPUState *cpu, int asidx,
  */
 void cpu_address_space_destroy(CPUState *cpu, int asidx);
 
-void cpu_physical_memory_rw(hwaddr addr, void *buf,
-                            hwaddr len, bool is_write);
 void cpu_physical_memory_read(hwaddr addr, void *buf, hwaddr len);
 void cpu_physical_memory_write(hwaddr addr, const void *buf, hwaddr len);
 void *cpu_physical_memory_map(hwaddr addr,
diff --git a/system/physmem.c b/system/physmem.c
index 23932b63d77..0ff7349fbbf 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3181,13 +3181,6 @@ MemTxResult address_space_set(AddressSpace *as, hwaddr addr,
     return error;
 }
 
-void cpu_physical_memory_rw(hwaddr addr, void *buf,
-                            hwaddr len, bool is_write)
-{
-    address_space_rw(&address_space_memory, addr, MEMTXATTRS_UNSPECIFIED,
-                     buf, len, is_write);
-}
-
 void cpu_physical_memory_read(hwaddr addr, void *buf, hwaddr len)
 {
     address_space_read(&address_space_memory, addr,
-- 
2.51.0


