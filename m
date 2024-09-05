Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFE36CD5BC5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 13:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smC6y-00015h-7i; Thu, 05 Sep 2024 09:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6u-0000yO-AV
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:17 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6s-0001kG-6P
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:15 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-42bfb50e4e6so5750995e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 06:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725541271; x=1726146071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nOfGgKkVr27UMgs8upuHdRZMRcRcWoHqPVmmA3MjBFY=;
 b=sEh+tkn73fMHovuQCep3341CFzCCs0l/sNNZQx+0qFVPg+HYXhh6/Iyz6c8JXSGyuR
 oP7xY65TMsy/VGob3naAVE4Lr02eiAQvsrEGDjQB1dy8uBHdF1OoBfXHwv37p9X9KJLc
 SNPI9w3xBOAH12x58MUcKfefmFJDC7W/wr6Wjfder30r/51vi6q3yigBeI7/cs9OsIOf
 WM9J9ILWBw2VRW9WJqBzjXbbzfQMPTd7/D2OXgXTZLSvSQ3m+AlSbUk+Jjs939/uAJ8i
 6Br6H+xQ3G5z5/EPsw+ulMMmDd8zCi6h9jcE7o5jvH9JJg/n6ez3nwsQI+A/ADIVMcfw
 K72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725541271; x=1726146071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nOfGgKkVr27UMgs8upuHdRZMRcRcWoHqPVmmA3MjBFY=;
 b=XBxEnLrBsd4ulI/f1hLviXLjNBGDAphlFDdW87vlw6SG9zuxnl86Vrry2QJFUWwTnx
 AMjwLL2VGmYpts6Cad7PrzFm3BvIyQ0CKNbH31qip1rtqs0Ysz7p07oQFyLlbfgfDG7B
 /9k9QFPsLP2qBoea77H+mDN417hglDaMoHgc8+B/9Na0OQTo+6zVzM6ZkMXFsdW1IVLr
 daiBTBd3Uh8zfRf0nUPfCo/O4dHoP0h68eSZ52xaSuj/Vz7TstmT6iLhvnwpmuL00SxK
 S7CYQr8v4qM6B+djAeqJFF1pkTcxLE4Yw0nteH1ZWQOpWp3ckun1rWxt1HtCHU3YrCXX
 i3Sg==
X-Gm-Message-State: AOJu0YxiMAcWANh6a/h9Ivwrfd99IhGYoyTqw/HApmnnT1LJMRPCo/ww
 T9pMA9+H5/GOYFFm3T63taK7LL5E9na+/qg5GhZjVNzrBTXWvWXCEx9wnAm4MlpY5SM42quEyMe
 p
X-Google-Smtp-Source: AGHT+IFs6mU2o7kkJLK/eCmjPnXsomqyDPzv0Xbu6+Wj48RXAIs7eMNrKyt53iKNuA9UQT5sqnyigg==
X-Received: by 2002:a05:600c:474c:b0:42b:ac80:52ea with SMTP id
 5b1f17b1804b1-42bb02c1098mr181247685e9.6.1725541271427; 
 Thu, 05 Sep 2024 06:01:11 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e355dfsm232251365e9.46.2024.09.05.06.01.10
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 06:01:11 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/25] hw/arm/virt: Default to two-stage SMMU from virt-9.2
Date: Thu,  5 Sep 2024 14:00:47 +0100
Message-Id: <20240905130100.298768-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905130100.298768-1-peter.maydell@linaro.org>
References: <20240905130100.298768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Now that our SMMU model supports enabling both stages of translation
at once, we can enable this in the virt board.  This is no change in
behaviour for guests, because if they simply ignore stage 2 and never
configure it then it has no effect.  For the usual backwards
compatibility reasons we enable this only for machine types starting
with 9.2.

(Note that the SMMU is disabled by default on the virt board and is
only created if the user passes the 'iommu=smmuv3' machine option.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-id: 20240816161350.3706332-4-peter.maydell@linaro.org
---
 include/hw/arm/virt.h | 1 +
 hw/arm/virt.c         | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index a4d937ed45a..aca4f8061b1 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -134,6 +134,7 @@ struct VirtMachineClass {
     bool no_cpu_topology;
     bool no_tcg_lpa2;
     bool no_ns_el2_virt_timer_irq;
+    bool no_nested_smmu;
 };
 
 struct VirtMachineState {
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index a5d3ad9bf9e..7934b236516 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1408,6 +1408,7 @@ static void create_pcie_irq_map(const MachineState *ms,
 static void create_smmu(const VirtMachineState *vms,
                         PCIBus *bus)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
     char *node;
     const char compat[] = "arm,smmu-v3";
     int irq =  vms->irqmap[VIRT_SMMU];
@@ -1424,6 +1425,9 @@ static void create_smmu(const VirtMachineState *vms,
 
     dev = qdev_new(TYPE_ARM_SMMUV3);
 
+    if (!vmc->no_nested_smmu) {
+        object_property_set_str(OBJECT(dev), "stage", "nested", &error_fatal);
+    }
     object_property_set_link(OBJECT(dev), "primary-bus", OBJECT(bus),
                              &error_abort);
     sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
@@ -3308,8 +3312,12 @@ DEFINE_VIRT_MACHINE_AS_LATEST(9, 2)
 
 static void virt_machine_9_1_options(MachineClass *mc)
 {
+    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
+
     virt_machine_9_2_options(mc);
     compat_props_add(mc->compat_props, hw_compat_9_1, hw_compat_9_1_len);
+    /* 9.1 and earlier have only a stage-1 SMMU, not a nested s1+2 one */
+    vmc->no_nested_smmu = true;
 }
 DEFINE_VIRT_MACHINE(9, 1)
 
-- 
2.34.1


