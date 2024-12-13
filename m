Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F74E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:26:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB3r-0006IG-EZ; Fri, 13 Dec 2024 14:10:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB3k-0005z1-2S
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:10:44 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB3f-000753-2h
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:10:43 -0500
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-71e3cbd0583so199472a34.1
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117037; x=1734721837; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eBPUqFgXPqVkLv31et38XzRlVXlzY7DGcAmres7QK70=;
 b=ZcZ7zT4tdhk11j3515x4EThsO3rDbeU0jMFeUU2bb+/imCFBVZM4d9cjArcmWCQNLb
 AcdHv3KYq6L/i/+J5pw/oZdyGxN87Xrt11ojlFWjEOP6e1l9LZgzO1hUGuDVo/KIqnqO
 IxTGtFMzUfFmk6kuUHs3fDKZhllED7x9MiqRV4sWos5UPEyDVjce/PRzUu8L5agzvL/z
 nsQJp96X7tbZuc9ILIXaJe4HsfELkzkLVNvmyU9cFjKobUUrAT3ddgmHwWAWGw+mzcac
 LYaHoNmVXlXgaMT9N61SjZaQ1frNAQ89K6TcvKOC19vR+9bTnowsRftkfkMiIMD7JggR
 H0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117037; x=1734721837;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eBPUqFgXPqVkLv31et38XzRlVXlzY7DGcAmres7QK70=;
 b=k9sxvulS6DpQ0RLrX9T7DlJKL8NilwzXsQnfnhx6LwZ7/pudhzu0/c3P/Vazt17gdy
 uIO7S2X0jqma/PLu7s2SHN4kIQzGH0c2llGzhpi+rWvWIChCRr+dc8eMt2Pt3pmNFCMr
 aG7c0KdRTUCG35LbaHdaQSCU0KQsZbQP6B/81Ki5cSJ+UKpt7LDl9zlnXpjFGGHavlVJ
 CRqDl86/v4pxBR5NCnYJcxCKQu0OSErWJUuijB/GqQL2/sPSH6rS+4ZIRK3OSSpjh6GU
 Pocmt28rv32rMOzkxV4sAQ9xECUy9M9U0/5ncZctnC/42/2ByXVlIXcO96bf8XUNW0et
 rWww==
X-Gm-Message-State: AOJu0Yz9ECZy6Y9pZs/Mbiq5pqAxjo4l2HsRQiHZBwb5W+NOAs7NujlU
 Inn/fi0ZYLim1UXldtRWIKotzDCFZLuQuXY00g4rPdaopL18dv6hHB6hiQTcsWhwZCxNmd5irrd
 sCPL3OJzM
X-Gm-Gg: ASbGnctqtpslTiqjxEiXign1OjN2xY8SlTHhBzLCkuBvQ0pFyQjfUqyh7fBnCqrjLeA
 5lAXrdDWmZ6FEMTNqjWBDC3S2teRu5IgJighgtF+YbGfvLsxhwCayzbwi+p35F9MdNET0cXKyu8
 Y9LXk/6a8jQp5If0G2CnwGbyAZBP47EMBQ8juUwFOufjK0OW6yyYP15LgfTQYr96XD47CWQjm53
 yUxFaMlscEHFrSV/w1qif96jjJIzFcXlOR8+UrjktN+MDregCXc00+hLVg15/k5
X-Google-Smtp-Source: AGHT+IEQuKandpwHrwyubsQmwuH6hcgtmzp9kRDrIiuQDt4IVIV+JRd0UNYCqK2aEAMwjJYMdRBr1A==
X-Received: by 2002:a05:6830:f95:b0:71e:1c5:4f77 with SMTP id
 46e09a7af769-71e3ba2b104mr2132805a34.20.1734117036827; 
 Fri, 13 Dec 2024 11:10:36 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.10.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:10:36 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Corey Minyard <minyard@acm.org>
Subject: [PATCH 34/71] hw/ipmi: Constify all Property
Date: Fri, 13 Dec 2024 13:07:08 -0600
Message-ID: <20241213190750.2513964-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32b.google.com
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


