Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FCBE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 13:43:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNuKv-0001m5-Ro; Wed, 18 Dec 2024 08:43:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKb-0001LA-Oq
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:25 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tNuKZ-0005gi-GU
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 08:43:17 -0500
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3eb9bbcc936so3355979b6e.0
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 05:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734529394; x=1735134194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6kwxpp6H6DpWLzGbf6AeTqxyXU7uHDghdBpIzRPpVmo=;
 b=wW6Yk4LE849tUNbYZrxX+rX6UrQRTTqaOnwt02amcZzzS4i4Y2YrWA3NmM5mr8nKER
 r1gNBQV7fjICJi7kyKVqnDHjCFv0EtKEIEUEnv+m5hOdemJS5becyU/KNnbhKYFIbMyj
 XUtHZN05GAzFGKOrvC6x0IhvOzQGYtKLZ5uaEbCPE5OdWysLk3MMl5mf0/fRDGJGMTJl
 YtEkkQMMmK8hqdRhhAah7Be8Dk02xTxN02xbwzgku2tbgvAeShmVL8QFeRL80xECKXBh
 EMEQn/U57guRXYT8HrIpOCZYVOn3j6zwC0FebrHaxz4aIjvMbw65ZSjrGJNffZafLhjL
 YAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734529394; x=1735134194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6kwxpp6H6DpWLzGbf6AeTqxyXU7uHDghdBpIzRPpVmo=;
 b=pNtrUhKgOliwQ/SvqwL6lLFYWPgAun59jJ1Gv+raAq0wRrU7Yc8V5m6Vwl0/jtQsKd
 LEKbr97xgp8JyuWHkBU86PUHNEclauBOzVXnCDUH3YATd4JgvFkN7/IAoB4NdfMxCESQ
 jvsIzueLUvGTmALT4tp/jrDs1yXWDIJGCzTYXoJww5neD+X8hWtHU9cjs0ab+hwHprME
 OroCBapnt8p3WLLP9IvE31NajnKLrQa91oILWMH0oSWF61Q+KuTfPgOcgl3DVeF5kPaz
 cPdqr34xAtfiYHga4BtZDeXM8lnsztpFXpJGSSmKRnlwGovxhC3tfYNqYICHmGszAYcv
 IgNA==
X-Gm-Message-State: AOJu0YwKp5jNOc+dWLxRx7AbdNrIyrPve1CjkQP+tvKkGoscwSlfVXRV
 ED0TQB170ZwsHS2QIHyiV7JbtxWzwoNSVBpKsdwDcFLy3Wk5OuB483Vt2qdfeQvr09SliKdqNpm
 xiIV69voz
X-Gm-Gg: ASbGnctMcWFEYpTRcza5rONz1UqAiyuInLRkePT8PDzY29AdOTPgzbtlQV6dvoE1DT7
 b2AMnztsat/GIdfrfU4l1pmkOJHHIdA7nFw86HivIOPYPhSJSZ+MgGiPxgMVK7eMaQUotR0V1et
 NtnDgqp5WCRSiRxj21e3Wz+Cgf8AnuG89oZqOM/iFDdS7/0AR9S6gqMyzk40z0ai9BJwYeqH0Xo
 HijyXvAWOPUJWPZbHFHkt/koH1wo1Q30Vl/RefP+BrwD9el1YHxbnDPYub6AzHv
X-Google-Smtp-Source: AGHT+IGBC7fvnvpT1nBqXVON9CN3dwosBLUXeZBvHJhauu4GdAgVRuv5GO3t9KXROQQzyqeAH5z7pQ==
X-Received: by 2002:a05:6808:3093:b0:3e7:60bd:8b06 with SMTP id
 5614622812f47-3eccbf59704mr1454764b6e.16.1734529394456; 
 Wed, 18 Dec 2024 05:43:14 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ebb478a502sm2870951b6e.9.2024.12.18.05.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Dec 2024 05:43:13 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Subject: [PATCH v2 15/24] hw/scsi/megasas: Use device_class_set_props_n
Date: Wed, 18 Dec 2024 07:42:42 -0600
Message-ID: <20241218134251.4724-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241218134251.4724-1-richard.henderson@linaro.org>
References: <20241218134251.4724-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22a.google.com
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

We must remove DEFINE_PROP_END_OF_LIST so the count is correct.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/scsi/megasas.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 8323cd18e3..7f012c218b 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2459,7 +2459,6 @@ static const Property megasas_properties_gen1[] = {
     DEFINE_PROP_ON_OFF_AUTO("msix", MegasasState, msix, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BIT("use_jbod", MegasasState, flags,
                     MEGASAS_FLAG_USE_JBOD, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 static const Property megasas_properties_gen2[] = {
@@ -2473,7 +2472,6 @@ static const Property megasas_properties_gen2[] = {
     DEFINE_PROP_ON_OFF_AUTO("msix", MegasasState, msix, ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BIT("use_jbod", MegasasState, flags,
                     MEGASAS_FLAG_USE_JBOD, false),
-    DEFINE_PROP_END_OF_LIST(),
 };
 
 typedef struct MegasasInfo {
@@ -2488,6 +2486,7 @@ typedef struct MegasasInfo {
     int osts;
     const VMStateDescription *vmsd;
     const Property *props;
+    size_t props_count;
     InterfaceInfo *interfaces;
 } MegasasInfo;
 
@@ -2504,6 +2503,7 @@ static struct MegasasInfo megasas_devices[] = {
         .osts = MFI_1078_RM | 1,
         .vmsd = &vmstate_megasas_gen1,
         .props = megasas_properties_gen1,
+        .props_count = ARRAY_SIZE(megasas_properties_gen1),
         .interfaces = (InterfaceInfo[]) {
             { INTERFACE_CONVENTIONAL_PCI_DEVICE },
             { },
@@ -2520,6 +2520,7 @@ static struct MegasasInfo megasas_devices[] = {
         .osts = MFI_GEN2_RM,
         .vmsd = &vmstate_megasas_gen2,
         .props = megasas_properties_gen2,
+        .props_count = ARRAY_SIZE(megasas_properties_gen2),
         .interfaces = (InterfaceInfo[]) {
             { INTERFACE_PCIE_DEVICE },
             { }
@@ -2546,7 +2547,7 @@ static void megasas_class_init(ObjectClass *oc, void *data)
     e->osts = info->osts;
     e->product_name = info->product_name;
     e->product_version = info->product_version;
-    device_class_set_props(dc, info->props);
+    device_class_set_props_n(dc, info->props, info->props_count);
     device_class_set_legacy_reset(dc, megasas_scsi_reset);
     dc->vmsd = info->vmsd;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
-- 
2.43.0


