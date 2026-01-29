Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C081D6B084
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUab-0000AG-Lk; Thu, 29 Jan 2026 11:09:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaM-0008VX-8Q
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:34 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUaK-0006Zn-K1
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:09:34 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-432d256c2e6so1100886f8f.3
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702971; x=1770307771; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z13uXKrf8/Vg9Np7XNzNgTT9vT/RUmS7H/xdYMAPddE=;
 b=PWl2V6KYHUPKM74wuIOKAD6p53VuZ725qRifmGOICHAV/krcL1ruW+FLUmfDRU6BND
 /qGNRKfD4/7vsrEIcS5g+u7+C2S5yavCujHUvS1v/KWC2GvfLgxMQtxxyvVbb66xDen1
 CjB2FhRuo1hZKlEPisDdGxqJnoQVfFofXjk5+MLlsejhxwHuiPCgvhe7STNiukRuj21Y
 C7yVl8wzD7h2pVkalFWvqZc8BfT1kphUrTMQWgAkpxvsCGjU1QGI9khxVlgjBN52Lxlt
 Q8iNFX53YS/0+OTNfl1Nw94v+/IFv9b+OXuTGFiB3Ux4Ylj5FX4KosSua7Ezob+aIhcF
 t0WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702971; x=1770307771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Z13uXKrf8/Vg9Np7XNzNgTT9vT/RUmS7H/xdYMAPddE=;
 b=fzD8lGF1zqlU6bIx/kdOeQZwHk+tgAYrb/DvtE39kAcmAukXao/0W8c/rd6F/KOUKQ
 PMLWrhMev5PMESRryh33AwwvW+7eMM1ZRODH4WV7gjoW2R31dFZXKdHGyE8PfPXXzc5a
 eE9EJJ9+rmXS+4v/GVew02MdYjUPs5mN6j7TidbfSVt6Ws31e2chfialHAFtU/3x9Ub5
 jXMkFea50CgW7TPVk/5zbL8M9RxLe8wJn2DlA7VASYiQ4VF7cg5P4tYRR0jajo13jq7J
 oitzjQJT2MKo1gvCRSidA2Asiuia6GaD1Y4VlaOdZpQPMFb3Z4Uu8HhKSAgfURnSj8Ip
 wc+Q==
X-Gm-Message-State: AOJu0YzfU5IXHAwx3bADtRhsXIeFY+pnMtVU65Tv/UkeT9TbYkzJPmJ3
 dmFbQjw2eClXtl1DfaAuTOajL56pfOc8FKpFwsAI/kE7PdCKr28p/YGpRPCP2/Y207dsKX5RK63
 TSscDUag=
X-Gm-Gg: AZuq6aLIHjkMPZO6IhVcayd/b/tSlDZd2DOPO+5e+JdmrgzyX4TEvC2frddMi3ShKg8
 BtugszDhY0yUw7bKaM6aQJj9LNfoLW9cVAxunh2Gcpr7nUlhRbMiWKvUrflK2DgZ/5U/RsV+6hT
 6VEgvwMnjj+5kch/5aOHL/Uq5CiQU40Zlnj8DkL6IE0Pz4v5We708gNZckpO4+3cnxcKp9EqPD8
 AbCvLgsA+7tJP6Fg2EphbQwXxHFVspQGjcPmF5PaKR1tAEFM++Zgr8anFaL6k7PKGL4RIMWCzHT
 yUtKXj8+Sz9vwSmJ0aXr0QteYDJfA1sqJMaqopep8sjKsoiJWSAjGkUBuAhNYEwfG7y+BBC2RqJ
 3evwXzfGvoBGAVPivXYBuzMYZtoqMw6LYdh8daRN9aVPRM673F+BHID0w/P1zYvuTJ5rWy0tzfM
 YlpKv8OCTfeGv5pX2TcMedYQ5ethhvXw==
X-Received: by 2002:a5d:5f84:0:b0:434:24fe:b25f with SMTP id
 ffacd0b85a97d-435f3ab212bmr142176f8f.37.1769702970622; 
 Thu, 29 Jan 2026 08:09:30 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.29
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 09/43] hw/pci-bridge/pci_expander_bridge: Move
 TYPE_PXB_PCIE_DEV to header
Date: Thu, 29 Jan 2026 16:08:43 +0000
Message-ID: <20260129160917.1415092-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

Move the TYPE_PXB_PCIE_DEV definition to header so that it can be
referenced by other code in subsequent patch.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Message-id: 20260126104342.253965-10-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/pci-bridge/pci_expander_bridge.c | 1 -
 include/hw/pci/pci_bridge.h         | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 08d40aa2ea..b6e2eb7969 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -48,7 +48,6 @@ struct PXBBus {
     char bus_path[8];
 };
 
-#define TYPE_PXB_PCIE_DEV "pxb-pcie"
 OBJECT_DECLARE_SIMPLE_TYPE(PXBPCIEDev, PXB_PCIE_DEV)
 
 static GList *pxb_dev_list;
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index a055fd8d32..b61360b900 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -106,6 +106,7 @@ typedef struct PXBPCIEDev {
 
 #define TYPE_PXB_PCIE_BUS "pxb-pcie-bus"
 #define TYPE_PXB_CXL_BUS "pxb-cxl-bus"
+#define TYPE_PXB_PCIE_DEV "pxb-pcie"
 #define TYPE_PXB_DEV "pxb"
 OBJECT_DECLARE_SIMPLE_TYPE(PXBDev, PXB_DEV)
 
-- 
2.43.0


