Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C72CA1005
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 12:54:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut42L-0002WR-Jr; Mon, 01 Sep 2025 08:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ut42B-0002Ud-H0
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:53:19 -0400
Received: from mail-ej1-x635.google.com ([2a00:1450:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1ut422-0004JE-Au
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 08:53:19 -0400
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-b042eb09948so142114766b.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 05:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756731188; x=1757335988; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3i2Eag+k7j9y13dUOQK5hZi+NdV8CGfRchfnzsO2Kps=;
 b=Lb/Ukn2fWDTRdiHjxnglpcCuSX3RLALdZ0fNBUAfCf2q40xaWQ6DtPPRyK+zrkegdt
 PEvgnFPpt7gL1a3H59TkGSQDYs+7jmtxfateHR6moPD0nOr4R9zu1GEK22GpEStHaV4x
 i5zx3Q/oknH1CkE5kkxqPoozKAHxAMRCltzYYF3eW4M/V/2MdTqVGwc0pnz1zR9FoImF
 kwTobB2FwfN//5uwIiCryE+xULcVvmscXrTjmswHfGwFuiIU0qX9Dmvjwo3DM1VrWdKp
 /LFciXwT27U1FOg/yA3KrhjplRUh6/ait1OjPdrbju3fTrFd705sPmEIIEf5ngbRIbPh
 O8uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756731188; x=1757335988;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3i2Eag+k7j9y13dUOQK5hZi+NdV8CGfRchfnzsO2Kps=;
 b=AVf1gRsqAAzyuoUCc2Fxd+Gmapq9vit6mhibiVCeTfjCuO6kcq+LX0hMXVnkQnMA3v
 sTP2t39URBlSNkCfN4s+5mZIemGNhWK/V3fID1p+pUaMJXYi90a2MWf/i5j8dFvrKgoE
 Kw4bQ9hopPEe95e4T0aey59soQFoJUo2IF6LnBL8EELDJy7j3D1XqCHcfe48tnNis7u7
 qB5iGZEytnvKt9uWzqrIp0mrVo3shTjApLj+6ABDzlYhXBKPLyrK15h9d64kK6g01/rC
 iUSzBnaR64KtMnGol+hy/9N8N/h84cDZDu6uHUFKvEuWw37crUVnopC22n8mxEYO5Sjn
 Zw0w==
X-Gm-Message-State: AOJu0Yy/IRcLzzPCg9jGVOfNSqEU/CaPiG9hbu7FJrfWXAiboi4MosBI
 1s8yb4J50HEz7P2yZ2Suh8Zd6C4eVwADO3EnaYDYsc4/bJbMNgKGZmsKrrMoD0G5784=
X-Gm-Gg: ASbGncsnIdDymlcR7CNJV7UkpTEoXijIKuKxYFj6xbL3z07Ofb2Uf9DepV9/5u+/fvO
 gWZX3mKd+hEv/7IXNfMsb1QqIQ0S/fOKVilyG6XAZQvcCfOK3PVVkIbBstsPWnsExds3QpDA1GM
 8DNKYjYog+ZwJ54dY3zcLYFxyElR5QUvnIOCbsT94rhRuLZNpMSEXee+UMNlNJIQwqjwf2rG1fh
 l2iVzPDc/kIZ4/2G+nhnbZj1xR6m5SdcnGQB4uO5o/gqK/OvPI/FL0wLoH83VnnBRD9viDd4WyM
 ymSDWFOmIwzxbuKL/iFoQsw8LpYQbnSqLacsVpr1C3e83FVl+wYmCQfAc2ZEeIxacabwImyC3gP
 gTydjz1ZgrP2n0ro+WMy78oI=
X-Google-Smtp-Source: AGHT+IGqt0ogGqxj+izrq1zJvuiUR1IrPzKUuoY3YElHWhJFmIL22cW4DdFz8ymREILKQFynnZ+VKw==
X-Received: by 2002:a17:907:1ca0:b0:b04:286a:2fb8 with SMTP id
 a640c23a62f3a-b04286a4b87mr417188866b.56.1756731188009; 
 Mon, 01 Sep 2025 05:53:08 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b00bab3ef2esm609931666b.11.2025.09.01.05.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 05:53:05 -0700 (PDT)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4484B5F8D8;
 Mon, 01 Sep 2025 13:53:05 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 3/4] hw/arm: use g_auto(GStrv) for node_path in arm_load_dtb
Date: Mon,  1 Sep 2025 13:53:03 +0100
Message-ID: <20250901125304.1047624-4-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250901125304.1047624-1-alex.bennee@linaro.org>
References: <20250901125304.1047624-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::635;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x635.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This is potentially more of a bike-shed case as node_path will persist
until the end of the function.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/arm/boot.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 749f2d08341..f9d0bc7011e 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -520,11 +520,11 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
                  ARMCPU *cpu)
 {
     g_autofree void *fdt = NULL;
+    g_auto(GStrv) node_path = NULL;
     int size, rc, n = 0;
     uint32_t acells, scells;
     unsigned int i;
     hwaddr mem_base, mem_len;
-    char **node_path;
     Error *err = NULL;
 
     if (binfo->dtb_filename) {
@@ -586,7 +586,6 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_info *binfo,
         }
         n++;
     }
-    g_strfreev(node_path);
 
     /*
      * We drop all the memory nodes which correspond to empty NUMA nodes
-- 
2.47.2


