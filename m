Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07B46C3DA4A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2024 14:32:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgPsb-0002Dx-Py; Tue, 20 Aug 2024 10:30:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sgPs2-0001tn-Se
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:30:04 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sgPry-0001WT-U2
 for qemu-devel@nongnu.org; Tue, 20 Aug 2024 10:30:00 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52f042c15e3so5074684e87.0
 for <qemu-devel@nongnu.org>; Tue, 20 Aug 2024 07:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724164195; x=1724768995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0FTAVDz3Cw1uxIbhjmeqEYJqdjw34VbylOmDWLTwvx4=;
 b=ly7XO/c6HEIngNjvBaNFLeM1xyixORSPa9ejCW0LZD8dDSe+6Retn6BmGJFz3uvqb/
 JfxoriLu3hNjI+lnA+Wyxe4rtrvWOU4AFccWLAo3gIkfmYBrp40PZ/fICF+ba7tBjquH
 VRmVSHevY7c3XGm8y8pH2hM33brr+R6829Kmu5bw+r51xJnkcg/jF40ZP+X1Xm//oBW2
 toU9cFZajoDUtUWnmtT3oqLlfcPmxebokVzzsy9jJRypNgzExJxmpBO8rY04y1ynvftJ
 GCv0MMsOXhhveJgDgO+ADcyb9dFPIc6xDFxG04O+VGiXHk8lHZt5Zl3nMG0tgKNh6eL8
 FzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724164195; x=1724768995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0FTAVDz3Cw1uxIbhjmeqEYJqdjw34VbylOmDWLTwvx4=;
 b=pJzR7Xq/B6riRfV/YyOY8Fkhr0oP11I2afeMSoqfvyMZEHyf0Lq7p+hreXgtF/n6IE
 U4/WTRU4W5wNK1yMjHYYUjzNuKNUvhQ6LAWVfGejw4DUoX84qodc02+KhxSKts9TWUK1
 qjkYJCZ+TKswahbf5MeuTigHpI2dG0hvAOFNu1Ak+Cy/+NN+18MRRYqBefhfOJPO/TJY
 zEgAsB4pItolCIrOi4kWIhDi/UgwXBl++B8e72ksYOhSOpQbgxj+fkTlTDVFfAygt+RV
 2HgTd8a6WD+bmPNkzzfFKbPnnV3Q0G6eCu32AtRqNF5uuAV1nO2rtSg5duBaXdmsDZRY
 jWzg==
X-Gm-Message-State: AOJu0Yw5yV7hz9cvYWkNI5a/xSzUfcAbkT2wLIOLQlLQAtwipF9ANofW
 FLn5blOjeFotYVioiqA8MbJvFrW7++IWDy1lHC1Vv9ZJxKS0ukmXZ1+Vd46W
X-Google-Smtp-Source: AGHT+IFrPcDRBYvfqjcvKbmWjLtw+0FlYqh8Z0iVHC/dcsRC/BqjVUCiAdvRhyukGAYN9Iw59X5/Ew==
X-Received: by 2002:a05:6512:2824:b0:533:415e:cd9a with SMTP id
 2adb3069b0e04-533415ee2demr694896e87.23.1724164194086; 
 Tue, 20 Aug 2024 07:29:54 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5330d3afa66sm1772714e87.7.2024.08.20.07.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Aug 2024 07:29:53 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, xenia.ragiadakou@amd.com,
 jason.andryuk@amd.com, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org
Subject: [PATCH v2 01/12] MAINTAINERS: Add docs/system/arm/xenpvh.rst
Date: Tue, 20 Aug 2024 16:29:38 +0200
Message-ID: <20240820142949.533381-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240820142949.533381-1-edgar.iglesias@gmail.com>
References: <20240820142949.533381-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Acked-by: Stefano Stabellini <sstabellini@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3584d6a6c6..c2fb0c2f42 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -559,6 +559,7 @@ F: include/hw/xen/
 F: include/sysemu/xen.h
 F: include/sysemu/xen-mapcache.h
 F: stubs/xen-hw-stub.c
+F: docs/system/arm/xenpvh.rst
 
 Guest CPU Cores (NVMM)
 ----------------------
-- 
2.43.0


