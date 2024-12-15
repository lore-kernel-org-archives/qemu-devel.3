Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E3EBE7717F
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:18:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtx6-00028t-9G; Sun, 15 Dec 2024 14:06:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwi-0001Vd-0H
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:28 -0500
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwg-0001FN-Ay
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:27 -0500
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5f3397bef34so345029eaf.0
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289584; x=1734894384; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UfqIQEtvyEll+bEq9eNWxSmYq+UyXT05rhZW4u9iFUI=;
 b=hhtNcTFFMDiyqcvtq1CJ95UFBT0DmH659PqCwYj63d/pSog5dQQr/cfwPbDJEMf2OX
 68FgWnYCunmldw/T0ow28qHsToAGRPoUam7UfTN+nFSk56IrQBMH2IwPBiFperwd87yx
 KA6DatWDPKqSsY2OOR0wcXf8JVwA0hCNm9hdvH23ObEgkt5JWJjG68/smaMgLOjMDjGv
 9pBPupwWtUJ6dXCnCobBi0PphJitV81HQ579bmV8lCYrD+k4GA1Gyzx6/dW5Fg9KkwxB
 UazUiX2d04BNv3hxmGpaq2T4Z0NrAajEp7IpAGHm21aV+w7Y1GMOogYwlOtmUZY0I6rV
 xnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289584; x=1734894384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UfqIQEtvyEll+bEq9eNWxSmYq+UyXT05rhZW4u9iFUI=;
 b=t7IAPoefuxRPw7Ziv8oYs8UfEyoYibPusUTNvUf6ZzHzuqRmm6B09WV4KoNrDAfwfK
 nXR83AVDRZFmXxIYCDya9YtQ4cNIW6R6sLegooVnL+9d4ibBe/J9KnoZFCYjbg8lmoex
 SvhZL72cGH4tk0KrPbDxUyKj10y6R4Bxv4ZaM6LJEsznKt7FNgOwBKmrE2ThK+2yC3M6
 7NTHEuA+xIhOOa/GXV7dbYt5tDha2RoY82ftaFzZXLkl/zd4GTlhVLlWxT+AzQuyNhmp
 r32pCQYW50HCA9y30CqKGGGsSBWjoa8T0AG/gxOZ9hmw7zGX4pLIryOrizOmJ6geb87G
 5H/g==
X-Gm-Message-State: AOJu0Yx5IOwe2DzZ1CRr20qH2om4Xcg79SD9/7X4aXIH8a3GBrfcR7fj
 YTdAHdPnUZ7gDtu/5A9Y7VDRyfUXmDWttpQEIAAeMKBe8kmhYlRMWF+jXVkwZDxve5s6H9wxC9s
 hUQUVM8F6
X-Gm-Gg: ASbGnct38Ns+1YrjlCDxdt23gklZcc3p0ZxnEVTAlRxEvWKXbkGWZp2JIQrLM8ItJmt
 cxgV8v0t4VAM1yomQvDpnWU/CN87cr6n/CebpodWfXL/hvhA81VeXdvRfs3T1UBFnETmIz4jwkp
 jttUEnOBZ/dmNs+KeoZyDBXkNEz6XpfxcCOJMToQgPQO/Wtf0rN1ctBrlejlgQxdgJPijE//Qt8
 Owf472fXHrb5lAJuE6wY0xuY5xxZF+oRmfw4tSouyjCeG9I5Nionlvjb0KeIU7/ile+xGCCDUKx
 DD1LakjZJ5MY53FFsOaoGOf5BEACPzOk8/sMzDKIk5E=
X-Google-Smtp-Source: AGHT+IFhHpMpm+ocQm/ytiv5cQcRe13Ant3odRXWN3IJGVLz70KhLBOZjhwUtWqfYOTsJwHg2ASntQ==
X-Received: by 2002:a05:6870:15ca:b0:29e:43ce:a172 with SMTP id
 586e51a60fabf-2a3ac867f5amr4767151fac.28.1734289584169; 
 Sun, 15 Dec 2024 11:06:24 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.06.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:06:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 33/67] hw/ipmi: Constify all Property
Date: Sun, 15 Dec 2024 13:04:59 -0600
Message-ID: <20241215190533.3222854-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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

Acked-by: Corey Minyard <cminyard@mvista.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/ipmi/ipmi.c            | 2 +-
 hw/ipmi/ipmi_bmc_extern.c | 2 +-
 hw/ipmi/ipmi_bmc_sim.c    | 2 +-
 hw/ipmi/isa_ipmi_bt.c     | 2 +-
 hw/ipmi/isa_ipmi_kcs.c    | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/ipmi/ipmi.c b/hw/ipmi/ipmi.c
index bbb07b151e..850b3bc463 100644
--- a/hw/ipmi/ipmi.c
+++ b/hw/ipmi/ipmi.c
@@ -108,7 +108,7 @@ void ipmi_bmc_find_and_link(Object *obj, Object **bmc)
                              OBJ_PROP_LINK_STRONG);
 }
 
-static Property ipmi_bmc_properties[] = {
+static const Property ipmi_bmc_properties[] = {
     DEFINE_PROP_UINT8("slave_addr",  IPMIBmc, slave_addr, 0x20),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index 29c5af3cc3..cfec1da87c 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -515,7 +515,7 @@ static void ipmi_bmc_extern_finalize(Object *obj)
     timer_free(ibe->extern_timer);
 }
 
-static Property ipmi_bmc_extern_properties[] = {
+static const Property ipmi_bmc_extern_properties[] = {
     DEFINE_PROP_CHR("chardev", IPMIBmcExtern, chr),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 33c839c65a..8a55893e89 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -2191,7 +2191,7 @@ static void ipmi_sim_realize(DeviceState *dev, Error **errp)
     vmstate_register(NULL, 0, &vmstate_ipmi_sim, ibs);
 }
 
-static Property ipmi_sim_properties[] = {
+static const Property ipmi_sim_properties[] = {
     DEFINE_PROP_UINT16("fruareasize", IPMIBmcSim, fru.areasize, 1024),
     DEFINE_PROP_STRING("frudatafile", IPMIBmcSim, fru.filename),
     DEFINE_PROP_STRING("sdrfile", IPMIBmcSim, sdr_filename),
diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
index 7b36d51494..16062abb31 100644
--- a/hw/ipmi/isa_ipmi_bt.c
+++ b/hw/ipmi/isa_ipmi_bt.c
@@ -135,7 +135,7 @@ static void *isa_ipmi_bt_get_backend_data(IPMIInterface *ii)
     return &iib->bt;
 }
 
-static Property ipmi_isa_properties[] = {
+static const Property ipmi_isa_properties[] = {
     DEFINE_PROP_UINT32("ioport", ISAIPMIBTDevice, bt.io_base,  0xe4),
     DEFINE_PROP_INT32("irq",   ISAIPMIBTDevice, isairq,  5),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
index f52b32e590..7e7a37659e 100644
--- a/hw/ipmi/isa_ipmi_kcs.c
+++ b/hw/ipmi/isa_ipmi_kcs.c
@@ -142,7 +142,7 @@ static void *isa_ipmi_kcs_get_backend_data(IPMIInterface *ii)
     return &iik->kcs;
 }
 
-static Property ipmi_isa_properties[] = {
+static const Property ipmi_isa_properties[] = {
     DEFINE_PROP_UINT32("ioport", ISAIPMIKCSDevice, kcs.io_base,  0xca2),
     DEFINE_PROP_INT32("irq",   ISAIPMIKCSDevice, isairq,  5),
     DEFINE_PROP_END_OF_LIST(),
-- 
2.43.0


