Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E2CFC3601B
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 21:06:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u05Hk-0007Eq-RA; Wed, 02 Apr 2025 17:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05H3-0006K7-Vy
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:05:30 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u05H1-0006Tn-Tj
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 17:05:25 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cef035a3bso1238235e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 14:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743627922; x=1744232722; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dMYvscB5HdbYJzOG5uobNA5wu3GjfAzBEwea0+muU7s=;
 b=vPi/itTU9Cywiabi1zwPxRHXHOpLfizln6uVjAAu01m/hM0dzoeUWtvlPbd8jcaQ5I
 ExEE2CF9SxE8kIjyl8bJ2ZPYrN8AhdGJ+1CK27B8ORfhtUjOzREXEIm4l5RrgjkCFJDc
 96XSy3qQU9o9JU/55oj0g9jYL5Mz1Or4sda6HGlM8U5qP2ysUJWv8u8CwBmr+h/N0y1R
 7Q2lGEpKC2yInukCDBaYfXywvgn1wpsdnfCxCFPyaFQ/gJts/1P7Ix3Zka/ThVysZjqz
 gBW8p2Jlzp3x0y5kn/Olfs/zZrcihhT3Jw2algrtZtvgltCqkuMlBMx/NOBK0aIL93VA
 1CZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743627922; x=1744232722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dMYvscB5HdbYJzOG5uobNA5wu3GjfAzBEwea0+muU7s=;
 b=JcmO3S547yq71qbW0XM0ewr+25APUcRlEVtYSHRIwn0aMgWuw9H25W7+3fQlkYYhuC
 5wP/geUr+3iZ8MKiRwQp78gjEBb63Gv0KDf9ORoftgjDkuPSjUR+lbR6gvX+UtWW+XVt
 gIvVEJMPqKYgin5Pn7psOrmYT//1Hpj9egJfvnh3LQIZOrYDAna31vQqysCtjaEMv3pE
 qg14h0cRUyMyjm/GI7LocKS2FJR0KspBwTmxE67pN3PvJwyH9C2tHNbJzIHsmoNiLaYo
 QFtz4GFe0NhmpAxq2IFtDQLXAShEMKVLnpTbVxeCljX/l7l2zO44lsiAJ9whyk0Q7rEP
 zH6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2Mr9vbiXa4AFuzIWeDpVAnIqPoYPYHCUjaxAx5lr+A3AX+UM3Malq7MwogGnyaOtciHyh+/I+OR6C@nongnu.org
X-Gm-Message-State: AOJu0YxMrbGHm2OW+4Q4V/R4oix3NF8ukDbm9s6CyYKfIBdAvUaseh1g
 yVkD2nend2jppCeouoMOMeNJDoX9FzGQPyqmMtnQcKeYsLRh6362kkkNzEdGVhY=
X-Gm-Gg: ASbGnctYMIjHX1FERuIvHyVxVhpkV1m0ZOCfjClRPhjnB6l5Ab2Mrgaqe+DaWiqKtbp
 ah/oKzsvawIxoYRjmmpp2d6CDE+eXfB5iuSGFqd8PlzJNrKw5i+RaDvochk1FCmovOclMjmXBJt
 Lq3ocFsV1Ojh7mJVmCny89FFS1TWItbG/2wM1+1p0TYIdDIWK1Q/hIIQxl3xnGmX78Ll2TfgCgV
 ZG2cex8VWdzzh30SzPwNyUh8NpVyRc0BGnmQTDxVYsQnJwwv3bPg52qE7rLvrdAnCdnrzcnWCRX
 VatuylgMO84H1XDO8hckiamifhq8iO/RURnIQ1UEaqc30FR2CVHQtz2cVqBz2Xz8ZMfMo2Uhv4w
 PTn6Pn5UaOtFf+lMiyIU=
X-Google-Smtp-Source: AGHT+IFr8reAQhJB6rVoMZC+D0c2zVdaHUqqskFaVjxICGPEdApkP+Xu5D/UtDufaYdsFvms4AfV8g==
X-Received: by 2002:a5d:64e5:0:b0:39c:1257:c7a3 with SMTP id
 ffacd0b85a97d-39c2f96d90dmr90984f8f.59.1743627922379; 
 Wed, 02 Apr 2025 14:05:22 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec1795243sm1917945e9.32.2025.04.02.14.05.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 02 Apr 2025 14:05:21 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PATCH-for-10.1 23/43] target/sparc: Restrict SoftMMU mmu_index() to
 TCG
Date: Wed,  2 Apr 2025 23:03:08 +0200
Message-ID: <20250402210328.52897-24-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250402210328.52897-1-philmd@linaro.org>
References: <20250402210328.52897-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/sparc/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 1bf00407af7..072d5da5736 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -1005,6 +1005,7 @@ static const TCGCPUOps sparc_tcg_ops = {
     .translate_code = sparc_translate_code,
     .synchronize_from_tb = sparc_cpu_synchronize_from_tb,
     .restore_state_to_opc = sparc_restore_state_to_opc,
+    .mmu_index = sparc_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill = sparc_cpu_tlb_fill,
@@ -1033,7 +1034,6 @@ static void sparc_cpu_class_init(ObjectClass *oc, void *data)
 
     cc->class_by_name = sparc_cpu_class_by_name;
     cc->parse_features = sparc_cpu_parse_features;
-    cc->mmu_index = sparc_cpu_mmu_index;
     cc->dump_state = sparc_cpu_dump_state;
 #if !defined(TARGET_SPARC64) && !defined(CONFIG_USER_ONLY)
     cc->memory_rw_debug = sparc_cpu_memory_rw_debug;
-- 
2.47.1


