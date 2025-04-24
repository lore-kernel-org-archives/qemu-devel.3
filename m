Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5BBBC369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:59:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ks7-00080O-IG; Wed, 23 Apr 2025 20:55:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqX-00015n-Tj
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:46 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kqL-0004lU-RB
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:53:35 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-736c1cf75e4so320582b3a.2
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745456012; x=1746060812; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7RZ/Hau3mC5xnOAVQuPQInWzHanN+gAbUrq5Du1Mv5w=;
 b=qnjKFN0hWhyVWymNTQqFYCiRUhEAvDMaBYHUk0AjDHZTnEDy/PMLVfPv+kvwnxy1DE
 C8kGhX9cfJFY3RaVkokp+4eqtQoD+e4HApu9hKRMM0h/CeR/9dHKBjhNaWog3JTYJoKN
 bi0EG3RUIH3cQHG1x5ToE35ZGY4c4tFnBOfggPlsHaoakVLSyBzHLxY3BQhID3ni4CC4
 9liQrbvKM8gKiyl8+mqNtb/SQgOIm9js4CU6lSE9X/tZLj18BAWQJBQ5ot8LjKQ7KtH0
 2KqcEtxSTg0klAZcBgRA3M/mjppdXBhsmLxu1WE7fwnf8TJ8/XDZ0D4napfY+EjX11gf
 QSgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745456012; x=1746060812;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7RZ/Hau3mC5xnOAVQuPQInWzHanN+gAbUrq5Du1Mv5w=;
 b=tqCm4v1nffzxdWkmCotIrAcvmvowWaZ4LpadBJ+Kg4UlhSnDnpEl0/wrMtcYV5PQlo
 1AgvLWXVMrvnS3R5eNYyIZbP1Ho3wdeAIoMpdKGKU8wXJbw5UDfxtz/T9H1jNI21M0T1
 PxxeYVaghamYt2cHw6nCEbEoWfVBvoBZf/AmbAHGCrcAh9R3G6bDkcPknSYEnQ3QPSNr
 nkuUjUvkh7fvM0NZ/K+JS17fTF4DUAv4uMutQJv2uAHeXKNja+xnPnmSU/nXUlRS2rhC
 jqp40zqxUib4fvrW+w393EzLXOfhqTpVGOKhlhGkL5LJz7cSX4KjTH8L8ZLfJz0DoUU9
 0HJg==
X-Gm-Message-State: AOJu0Yy74BMmyiliWLGpO+HxXlfOJqxLeTeHlPVVoqKfDZYVRLXjlsD9
 Cjk3byKC+emmeC0pENOjcPl3l3HmxUCOqoXtJgNKc4G0ktDilaFshSy8L7VxB+uOUzQEAUFcLFX
 J
X-Gm-Gg: ASbGnct70+ESZg/k+ES5nU+7FoMN92qU9uZmk8/JpUv5TEEGUlNgEM32uwbJvwWVwuP
 7tL2nak3xZWOCI782PmcsdKJ7ok6DBwNpjH8DiMhWA3jilyJbYQ3g+IENHdUcskivgFlWfdlyQI
 a/X6ELWpLq3baX4md+1UB3LXcwktKwMxKnI6EnJkCkmq6oNj9Az4fhpVzdpYQQGQX5mKHHNbwIo
 m9orUCAuIE6CO6bYya4KlaGzqZrYYgFDZuP/24BflSqk18Q3urPNH1lmWWxGp/cBlcruZKSzpKo
 aU1/Po7ztdHx17/ZoLKRm6z0hEXv0UyQsAluIeIpejMwuIPxR6+JVzm9w/7GBG/r8PsdVuZ0PhU
 =
X-Google-Smtp-Source: AGHT+IEBiSG3YBY5yc2g5/HlXDBWWuwR/qQaUOAQCHNAqUSBS3lZMxhpCXJi+kf9VnSh4sD+S+wvdQ==
X-Received: by 2002:a05:6a00:2e14:b0:739:56c2:b661 with SMTP id
 d2e1a72fcca58-73e2463345cmr944867b3a.12.1745456012118; 
 Wed, 23 Apr 2025 17:53:32 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a6a971sm209353b3a.103.2025.04.23.17.53.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:53:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 077/148] target/hppa: Restrict SoftMMU mmu_index() to TCG
Date: Wed, 23 Apr 2025 17:48:22 -0700
Message-ID: <20250424004934.598783-78-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250401080938.32278-7-philmd@linaro.org>
---
 target/hppa/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
index 2a85495d02..09a6aaa3dd 100644
--- a/target/hppa/cpu.c
+++ b/target/hppa/cpu.c
@@ -256,6 +256,7 @@ static const TCGCPUOps hppa_tcg_ops = {
     .translate_code = hppa_translate_code,
     .synchronize_from_tb = hppa_cpu_synchronize_from_tb,
     .restore_state_to_opc = hppa_restore_state_to_opc,
+    .mmu_index = hppa_cpu_mmu_index,
 
 #ifndef CONFIG_USER_ONLY
     .tlb_fill_align = hppa_cpu_tlb_fill_align,
@@ -281,7 +282,6 @@ static void hppa_cpu_class_init(ObjectClass *oc, void *data)
                                        &acc->parent_phases);
 
     cc->class_by_name = hppa_cpu_class_by_name;
-    cc->mmu_index = hppa_cpu_mmu_index;
     cc->dump_state = hppa_cpu_dump_state;
     cc->set_pc = hppa_cpu_set_pc;
     cc->get_pc = hppa_cpu_get_pc;
-- 
2.43.0


