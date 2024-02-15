Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CDCDC48BF0
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:59:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag0d-0002la-Dl; Thu, 15 Feb 2024 12:58:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag0a-0002Ul-8J
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:58:52 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag0X-0001cJ-BN
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:58:51 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-41205e19660so8277415e9.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708019927; x=1708624727; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dqF/h4b+bAkBGCkEQ2mmapUdtDBHzstE/FcKUqg3JE0=;
 b=VWB0F8qP7WsXDHhyNPZLICbOchqETj//++eQAdxI4EGlOhonU4Uq2PQDBzYBIm+xJZ
 PXbg7gO7VV6QtxRlAQ9WfG3/myANVVhyDurwo56v2AUYl43YfgZJFyPCn640Gqbkc/9H
 Mg4uLWI6lA34ElGdKIhYgAK0IZeSqqbjLzjWDbzgcSab3XXnpRtH9ZFtON/NuXpRItMh
 wOtL1RpfA23hoXNcuKTgyIaRl2DpeJCNQTkuaXbxrVEDqLLHiZWE93ygevYKNkbW9D0/
 TaDQOtCK0MrIB8eyKgOvqu3HgaFZtKtgKBEWNlqWjdTvhRLipDFXEGYKdMsSI0MvfWXE
 YZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708019927; x=1708624727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dqF/h4b+bAkBGCkEQ2mmapUdtDBHzstE/FcKUqg3JE0=;
 b=oDdKJJzZzUNwxcbqxhAeFFjyf8iY6Y6/GLFq8l0DQISVkAmCMmgcQlX63Iq3kB+o4N
 fcaOeFZQQittNj1+oXGeJfNBghiFoGZSMKOYuBcAoXEburlQtTfam1k4IXNLzJOCmnKN
 zn+5A32D+lU3oJ2CtVW3IAqzqSi7uCT2SAJs195b2Hcs1XckF1F4mYiUaidaIaPWqVY+
 uzhGNoAH99tgYxqPTiINDZ6PMB0eY9h/xwToEBpf5h+ugnwqKIw3rSDssy4cMYc1wA4j
 lapryin+0MmG036DfKVbgywNtIqEff034dlX0PZdaJtB5KoAGI5/ZTOEnzOd77Ztp3f2
 2T2w==
X-Gm-Message-State: AOJu0Yzjbrl6Yo33VIDTfyk9M0xvL3s0ZlTejx/hauW+2Hwr6a7vobXl
 1vNx7DAbzYXTA3gf8t08zW88RhNellSCTdTQ2gwqs7fn2QWTFdUJw6YWIP7AIK9p8WgLD5BKN7y
 f5K0=
X-Google-Smtp-Source: AGHT+IExfnI6+rVD834cR9ju0rId2T6+/FMoTmnHKaBBt8vbdiq/feBvFxVPHujh7aLtHcD22yb6XA==
X-Received: by 2002:adf:fd4e:0:b0:33b:4838:a23 with SMTP id
 h14-20020adffd4e000000b0033b48380a23mr1761902wrs.29.1708019927683; 
 Thu, 15 Feb 2024 09:58:47 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 bh8-20020a05600005c800b0033b888a0a63sm2640261wrb.0.2024.02.15.09.58.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 09:58:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PULL 08/56] hw/misc/mips_itu: Remove MIPSITUState::cpu0 field
Date: Thu, 15 Feb 2024 18:57:02 +0100
Message-ID: <20240215175752.82828-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Since previous commit the MIPSITUState::cpu0 field is not
used anymore. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240209090513.9401-6-philmd@linaro.org>
---
 include/hw/misc/mips_itu.h | 1 -
 hw/mips/cps.c              | 2 --
 hw/misc/mips_itu.c         | 5 -----
 3 files changed, 8 deletions(-)

diff --git a/include/hw/misc/mips_itu.h b/include/hw/misc/mips_itu.h
index 3a7330ac07..de7400c1fe 100644
--- a/include/hw/misc/mips_itu.h
+++ b/include/hw/misc/mips_itu.h
@@ -73,7 +73,6 @@ struct MIPSITUState {
 
     /* SAAR */
     uint64_t *saar;
-    ArchCPU *cpu0;
 };
 
 /* Get ITC Configuration Tag memory region. */
diff --git a/hw/mips/cps.c b/hw/mips/cps.c
index 988ceaa0b9..07b73b0a1f 100644
--- a/hw/mips/cps.c
+++ b/hw/mips/cps.c
@@ -103,8 +103,6 @@ static void mips_cps_realize(DeviceState *dev, Error **errp)
     /* Inter-Thread Communication Unit */
     if (itu_present) {
         object_initialize_child(OBJECT(dev), "itu", &s->itu, TYPE_MIPS_ITU);
-        object_property_set_link(OBJECT(&s->itu), "cpu[0]",
-                                 OBJECT(first_cpu), &error_abort);
         object_property_set_uint(OBJECT(&s->itu), "num-fifo", 16,
                                 &error_abort);
         object_property_set_uint(OBJECT(&s->itu), "num-semaphores", 16,
diff --git a/hw/misc/mips_itu.c b/hw/misc/mips_itu.c
index d259a88d22..9705efeafe 100644
--- a/hw/misc/mips_itu.c
+++ b/hw/misc/mips_itu.c
@@ -527,10 +527,6 @@ static void mips_itu_realize(DeviceState *dev, Error **errp)
                    s->num_semaphores);
         return;
     }
-    if (!s->cpu0) {
-        error_setg(errp, "Missing 'cpu[0]' property");
-        return;
-    }
 
     s->cell = g_new(ITCStorageCell, get_num_cells(s));
 }
@@ -558,7 +554,6 @@ static Property mips_itu_properties[] = {
                       ITC_FIFO_NUM_MAX),
     DEFINE_PROP_UINT32("num-semaphores", MIPSITUState, num_semaphores,
                       ITC_SEMAPH_NUM_MAX),
-    DEFINE_PROP_LINK("cpu[0]", MIPSITUState, cpu0, TYPE_MIPS_CPU, ArchCPU *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.41.0


