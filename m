Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 063BAE77199
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 07:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTyxo-00012g-1U; Sat, 04 Jan 2025 02:52:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyxm-000124-Dr
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:52:50 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTyxk-00032i-T3
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 02:52:50 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2efded08c79so14381279a91.0
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 23:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735977167; x=1736581967;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=2gQd0Jy4rc+uI1Ti92SqV/hr0DQj0ZpBWM4CmdOjypM=;
 b=o0rJdYsSbPwYhtv2MquspX/H/rBnPpe30/D2CD1CaYUQcAIwsbXW63S0r/W26XlTu1
 cBzQRW4b7CPIkUgdzprJjBR3KZvEUnQEgHp2WofBqS46GF71rKDxvXNzq0EmxgnjKcZn
 HBnaUVcINLqFwaOBa9wi8I/IwB64Iz/OnKV4U6n4pZBS7HAHo/vACuebyIF1N5KsfuhW
 kOS6VPZ+dr2PqawKPhhgTnkMILG3EIGR+e7c5Qnb9YQiE2hlW2B3QIcqB3nC40Y14SLp
 0T3w+cM5j/UtM9BGex7vrx1n1LmU3xHtTeglztlYbHzqMI7u4lLa5weZi+0+RZLCyRRl
 /4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735977167; x=1736581967;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2gQd0Jy4rc+uI1Ti92SqV/hr0DQj0ZpBWM4CmdOjypM=;
 b=eQm0yBftDIgfmzVsaI+4PSFnW9/yokeKy0TKYT1VI4FMA08IZsK3o/ecIcNHRSItun
 hBPxgvet3zVuYOvUsTqeaggM6X/JkdL/0OhjuMn2vyvCrH5M173bXkWqYlWWXYGasa5p
 uNMUPTibLPVzWLJDlyTchPfj9ng3wBprRTMalpD0mdsbIRMrE6nMdIU/HRu4LD9h9hc0
 H9+/n46+eRH3/W5TFsWbn4zH5VAPc17n0GH6c1OLiQSxkvCEP8zuHOPn7EGYdEqghUfP
 iymga4woQzEePP5xsU46TPJus4SotjzIAwdpmDEWyId7/+a/I5mCuv+JghWqmp3cYid7
 q0zQ==
X-Gm-Message-State: AOJu0YzzL52Fy8SFYl9VOQ/KzHbWAj9sQpHYHjY0hm2i56VvkJQno4PB
 gdieKDURwiLjyl2Gx4x8GmXpUTi37PJ0FO+ivn74xzV9cko/wYTkZY4XOn8Z9/4=
X-Gm-Gg: ASbGncvVXVjBx9dfr9qpTiPccnl31csmSumyyTWN21lPGJp0+GF+FUIHuDnxdKl/jru
 YpEgzWInqJ/CQUbNNK8ykY61ALZ3dM4tyAuvzhzgj55K3YTIY6mBu0ZKQou/eG8qOE4vMVznSpD
 A9Xf69N8coFtnapYtLLit2xajpC4A+HQ5vJFBT9K/l4L/EXWVzslRrgeI8qkfEQO4FjzQrTi+BJ
 rjzXFClPpz0YtpzvoEDbiZ3RvK+cNRAtaAUMSMfKOHNj8sGi1WB1PXrTm8J
X-Google-Smtp-Source: AGHT+IFszFiSUUSkWviDla+3kYRFvPVamY97X5FOxeosF+OfIr4yG+lAecORSUiDPL07P0SRSx6iEg==
X-Received: by 2002:a05:6a00:39a6:b0:729:1b8f:9645 with SMTP id
 d2e1a72fcca58-72abdebf1a1mr78424223b3a.24.1735977167621; 
 Fri, 03 Jan 2025 23:52:47 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-72af8dcff60sm18590051b3a.152.2025.01.03.23.52.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 23:52:47 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 16:52:22 +0900
Subject: [PATCH v18 02/14] hw/ppc/spapr_pci: Do not create DT for disabled
 PCI device
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-reuse-v18-2-c349eafd8673@daynix.com>
References: <20250104-reuse-v18-0-c349eafd8673@daynix.com>
In-Reply-To: <20250104-reuse-v18-0-c349eafd8673@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Disabled means it is a disabled SR-IOV VF and hidden from the guest.
Do not create DT when starting the system and also keep the disabled PCI
device not linked to DRC, which generates DT in case of hotplug.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Shivaprasad G Bhat<sbhat@linux.ibm.com>
Tested-by: Shivaprasad G Bhat<sbhat@linux.ibm.com>
---
 hw/ppc/spapr_pci.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 904227d9aa1f..b94e4ba1314f 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1283,8 +1283,7 @@ static void spapr_dt_pci_device_cb(PCIBus *bus, PCIDevice *pdev,
     PciWalkFdt *p = opaque;
     int err;
 
-    if (p->err) {
-        /* Something's already broken, don't keep going */
+    if (p->err || !pdev->enabled) {
         return;
     }
 
@@ -1572,6 +1571,14 @@ static void spapr_pci_plug(HotplugHandler *plug_handler,
     SpaprDrc *drc = drc_from_dev(phb, pdev);
     uint32_t slotnr = PCI_SLOT(pdev->devfn);
 
+    /*
+     * If DR or the PCI device is disabled we don't need to do anything
+     * in the case of hotplug or coldplug callbacks.
+     */
+    if (!pdev->enabled) {
+        return;
+    }
+
     g_assert(drc);
 
     if (IS_PCI_BRIDGE(plugged_dev)) {
@@ -1647,6 +1654,11 @@ static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
     SpaprDrc *drc = drc_from_dev(phb, pdev);
 
     g_assert(drc);
+
+    if (!drc->dev) {
+        return;
+    }
+
     g_assert(drc->dev == plugged_dev);
 
     if (!spapr_drc_unplug_requested(drc)) {

-- 
2.47.1


