Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC36D11194
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 00:24:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7kps-00009i-Jj; Sun, 03 Nov 2024 19:20:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kpg-0007zs-Le; Sun, 03 Nov 2024 19:20:38 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1t7kpf-0002cJ-3V; Sun, 03 Nov 2024 19:20:36 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-71e49ad46b1so3058862b3a.1; 
 Sun, 03 Nov 2024 16:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730679631; x=1731284431; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j+nbBw6IEzhuLF9byaPUKaUWorh3MYy1TUvwqOA4xVw=;
 b=mWmVoARdy4Bd+nC491ymaRJfPZ8u5chMFO3x8F4QdaQkkvnL+/uGSsopKyOMxKVT6v
 hn9OL1LTCphNOHlygocfhNI3gAzjfE8cWSkUcdWHZOmAkkviAc7dLwAinkM8GM6eArt6
 U5AATe7xlWQstLjvDFnQHpcN/CkvBFYlb0Dyoi74SYEQoPBsBq0E7UypwWBmTiQdgRGd
 Ox6GjxKHbvZjFqog/H84EOxfgd7W/PayCPrt4tVTIfmDm+kes2cF1qfbUlq/JlltEk2o
 deVAyoG8tHUf9XtxZxD3rVSPO6Cl1eGaq2/Y7Pn7lUGsSa6aZAFzV/f80NSVlGDvctPH
 nJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730679631; x=1731284431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j+nbBw6IEzhuLF9byaPUKaUWorh3MYy1TUvwqOA4xVw=;
 b=UgrxyVUauFeivyJU1aCn6CuTkMOqFxLLMWghdWpZ0lvDMAXc5YjQnm2Q/jWpjC1QOu
 tzuFgdleE8oOPN/c7A+MVbfpmnryO2ZoZJHXvdu6T7GFC6vLpGGKwF10XPZx/T9GUAlO
 uhYOxiv8DJtrZs18H85o1/KMgi4QsIpA/D8eHtWEK2UmbObE0Qb4U6Ofz+XWQLNhWrWJ
 wFQhzxfuO1LjD0uc0GLODaRqo3wZquUZkfX09TTnENNwyTfz7BJo5eHcU53ETGPD88wO
 6sA+TqK6L0PKdNc7BuxEbMhA+222u95fA35vVQ2K6WFeqOfw9js1fCVP5YXvTbIBSU+k
 j7pg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVd25/oO66QQuFWGB2HR3/rNO1hcGAtALelnhOwVLU47Zbnc8/BIoA+7uxwAVYJKgqCnueysDorNw==@nongnu.org
X-Gm-Message-State: AOJu0YzX3nTvIY0+sceXFR4VRsbKFUgULVG3gVgtILXELPz4sm+WDq3p
 4FeaHxTsPtR3CI8F5zv+OiUrDn/5aWCnU46/3vF6KidRPCBHrwjpz+Z1kg==
X-Google-Smtp-Source: AGHT+IF0IrfYEcc7C9u1QyVrx5rZaetztgbR9RuhEa/FNrBK2JiMEuehaZlu2xK8t9xuzfrOLG67MA==
X-Received: by 2002:a05:6a20:d98:b0:1cf:44bb:1cc4 with SMTP id
 adf61e73a8af0-1d9a851d257mr43219843637.40.1730679631496; 
 Sun, 03 Nov 2024 16:20:31 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ee45a0081esm5900648a12.59.2024.11.03.16.20.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 16:20:31 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 22/67] ppc/spapr: remove deprecated machine pseries-2.6
Date: Mon,  4 Nov 2024 10:18:11 +1000
Message-ID: <20241104001900.682660-23-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241104001900.682660-1-npiggin@gmail.com>
References: <20241104001900.682660-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

From: Harsh Prateek Bora <harshpb@linux.ibm.com>

Commit 1392617d3576 intended to tag pseries-2.1 - 2.11 machines as
deprecated with reasons mentioned in its commit log.
Removing pseries-2.6 specific code with this patch for now.

Suggested-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f63843d107..a9c988b8f6 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -5278,24 +5278,6 @@ static void spapr_machine_2_7_class_options(MachineClass *mc)
 
 DEFINE_SPAPR_MACHINE(2, 7);
 
-/*
- * pseries-2.6
- */
-
-static void spapr_machine_2_6_class_options(MachineClass *mc)
-{
-    static GlobalProperty compat[] = {
-        { TYPE_SPAPR_PCI_HOST_BRIDGE, "ddw", "off" },
-    };
-
-    spapr_machine_2_7_class_options(mc);
-    mc->has_hotpluggable_cpus = false;
-    compat_props_add(mc->compat_props, hw_compat_2_6, hw_compat_2_6_len);
-    compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
-}
-
-DEFINE_SPAPR_MACHINE(2, 6);
-
 static void spapr_machine_register_types(void)
 {
     type_register_static(&spapr_machine_info);
-- 
2.45.2


