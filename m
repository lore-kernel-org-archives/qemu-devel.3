Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EA2BC5DF87
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2026 11:02:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wxN0i-0007PO-GP; Fri, 21 Aug 2026 07:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN0f-000790-Es
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:05 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wxN0d-0007Kb-9W
 for qemu-devel@nongnu.org; Fri, 21 Aug 2026 07:02:05 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-496bb7cdf51so8315165e9.2
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2026 04:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787310122; x=1787914922; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=vnXUIz3SC8Ou6fd68xxg7mOuPxzgFf1mC6qX64/vths=;
 b=KGzBEBgNPcZHWv6eRr2PQLkqakAinwpP5f8MGhOaQd5YIh5LmM/vSI1e408IxA+Ofz
 AX3sMEfCQYeZdk/CfiItKF7cwOgy0Y84C/kfyGgdMYrTnyY8NnX+BL8VKIshVSEt8VIe
 XgH0ESsUWUDO0uX5CYYotYhpu2tliQmBOivNVBKdE/PVR1xEmZJ2OnX6c9Zj6oX3vXT6
 AcPEIkM9krH+68wnp964ef6wJoU1zTGJ/PyKgupj3CgowtAcxmLBjBNLB3YrMWMHBN7Y
 PiivkKeDdQNm0sLr0dso1UYEYuHcbB4vpEF5Ml+67+bzm5wKrb/gh9lKbp6ckyZI4aYf
 c34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787310122; x=1787914922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=vnXUIz3SC8Ou6fd68xxg7mOuPxzgFf1mC6qX64/vths=;
 b=UsgEfh9lnTxV/v7UxLRk+SkVh4uEsUPKZ0wlmid7xibdBETN2OylvL6px6XSOO4lph
 yKUNbcHPKVmdjegD/TXRZJWfFLKeDWYv5phqudz8vLkrIeMt/miDjtqquhiZgbbn2iut
 lJhpRfYBFOlOKuqpSnYdbotK/79uI68u35gs0SwWVs4kDBRwwtSh+/oP3ouPxWBxs8ZK
 H8AtmWQQ7rJ57GuPyKwp9IM9yrrnPr1DLxM/2/R3CAlAjXoI54LUQQS1dLS4URnTxl7m
 lNC6oebDrhlPCLj7uu50xCzz1TeBlp6rjykT4Urb/IY2De1Dp7k2T/3pmospEZRxdzCR
 wk9Q==
X-Gm-Message-State: AOJu0YySm6SHVZ8bHagdK0zx5SV9DElkX3jTqn0OfFOB0X5elKXdZbRJ
 +G9wxU1ZT29tix34Mr8Qc4o+soUc+qtHzMkWSa8+oSJa9QiaQYNFgq0wuAdTJ9CKg4j3XneeA/0
 VS0FW
X-Gm-Gg: AR+sD11Q4UtRCfgwH573Kyh8akq8fvDW9nqqjydo1P1f04J34y7D8Z3Ht2uz+75N0o+
 wVc2/Qjcf1M+4k2BQidIEIOIUZf4915VSIUuyT4rp2YdcA+awbilgWgzulQftX8TDQUZivOfgit
 cMTt/vGVRmZsBylKMQzzh0WH4lisHgxSqlXmq8GNmNp7KmZlSQcdv09Ekn9yWTS3gKU1wnv8/34
 6kNAA283uV0zRVhzrZLaxGWOH/E9ovclAmg+NKZlS6yprErc690xQzVDD7TQ3ytUh1fL9cZeoKO
 ezlO4mCW+IL/twZRS0VxgLliQDexcwcr+qmEWyZb01BqcbZ61/n7AWuMP0mEyFs0HYSQEIURCdb
 gzGhVaOSBnArZY5QWKMdko4qOu32qPywyl1B/Fz3In4uPe+bOxB95mKoHXXcBCYmsUMfmcJHoKy
 /lmw6As0nMFWdIEk+4o01ZhZuOVPANbdkHg2GUk+GsY2nRBhcA9es506NuNZyWnmfglUEodXire
 b1EUQbzkKz8amRLTGc1u57G98d1tQUq3lddB0YbeoT47RzTGCBykQuBPpk+K7DC3G3nUw==
X-Received: by 2002:a05:600c:3e1b:b0:499:a685:c10 with SMTP id
 5b1f17b1804b1-499b82e5427mr86715255e9.4.1787310121633; 
 Fri, 21 Aug 2026 04:02:01 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b90e7e20sm22875985e9.5.2026.08.21.04.01.59
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 04:01:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/43] hw/arm/ax3000-soc: fix heap overflow from missing
 class_size
Date: Fri, 21 Aug 2026 12:00:33 +0100
Message-ID: <20260821110101.3971391-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821110101.3971391-1-peter.maydell@linaro.org>
References: <20260821110101.3971391-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Doug Cook <dcook@microsoft.com>

TYPE_AX3000_SOC declares an Ax3000SoCClass via OBJECT_DECLARE_TYPE() and
ax3000_class_init() writes to it:

    Ax3000SoCClass *sc = AX3000_SOC_CLASS(oc);
    sc->num_cpus = AX3000_NUM_CPUS;

but its TypeInfo omits .class_size, so type_initialize() only allocates
class_size inherited from the parent, i.e. sizeof(SysBusDeviceClass).
The store to sc->num_cpus therefore writes 4 bytes of the value 4 just
past the end of the class allocation, corrupting whatever heap block
follows it.

Fix by setting class_size.

Fixes: 33a71a68c6e1 ("hw/arm: Add Axiado SoC AX3000")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4197
Signed-off-by: Doug Cook <dcook@microsoft.com>
Message-id: LVXPR21MB70090B04FF7397B0F2A201C8ADA72@LVXPR21MB7009.namprd21.prod.outlook.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/ax3000-soc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/arm/ax3000-soc.c b/hw/arm/ax3000-soc.c
index 71e31c6fb46..ebe174fb978 100644
--- a/hw/arm/ax3000-soc.c
+++ b/hw/arm/ax3000-soc.c
@@ -236,6 +236,7 @@ static const TypeInfo axiado_soc_types[] = {
         .instance_size  = sizeof(Ax3000SoCState),
         .instance_init  = ax3000_init,
         .class_init     = ax3000_class_init,
+        .class_size     = sizeof(Ax3000SoCClass),
     }
 };
 
-- 
2.43.0


