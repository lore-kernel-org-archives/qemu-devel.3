Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4451C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 22:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x991b-0004OT-DP; Tue, 22 Sep 2026 18:31:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1x991I-0004Lq-JT
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 18:31:24 -0400
Received: from mail-ed2-x10.google.com ([2a00:1450:4864:33::10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <weqaar.janjua@packetfive.com>)
 id 1x991G-0004MV-LO
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 18:31:24 -0400
Received: by mail-ed2-x10.google.com with SMTP id
 4fb4d7f45d1cf-6a99c5de614so451338a12.2
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2026 15:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=packetfive-com.20251104.gappssmtp.com; s=20251104; t=1790116281; x=1790721081;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jPa+3krWwAcEd/vM14z9bDk3/+TaDzZgd+Vvv77ZvNc=;
 b=fVpOsgoLMJhAbKbf6qGvXmiHcT2Df3XRO1mtrENVaxzk9GtuPow8wBESdGAIy+yAuK
 eaMzONeHib7wsSgFB2equVhsvXzQuxOEuXHsaxbQqqh/4lWLOEY3LKWkrx02P5VIZaXt
 vxfHxyjEH8iQf4CAnEmRnTOkn3mVHYokd5EbZOb7ULLP/KAt/eHUOV581Xf4EuQvxbHV
 TYoqzvkqHZBbuBavsBQnqnDuGEw5GkTzyqMNK6UwtmWk/00UvacvL0cG9UnerpKbJN5U
 TfazVg+AHhD93uhYGtNnbUIcV2UlRBBL7dPFZzwIvoCuMMxKZcN+OdmRSJWcHXc9h38w
 bUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790116281; x=1790721081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jPa+3krWwAcEd/vM14z9bDk3/+TaDzZgd+Vvv77ZvNc=;
 b=cjW5edg5gVLVP2G93EdVHV4FYaKFlORpeAKhvmWSJtpFnJqTVsPn7qoqQbqYAz+HqJ
 ZRHoi4go8H8n6/S8FWyeOh3BoYc6sMY53BJV0R4YYab1UdBXQmiASN9OhnzXjhYHbGdC
 HaTUsYIH59KMmIAI0RDzlj1Ai3ymety4RdCkjOttfZeUzBsZwf0yo/y58LknDiJ+t2/V
 UDLZ75JYePWZrAwZ9dgz4gEekov84r8uXtsvU5Vx2hYwAmGH99lgj+zvaPhlzFPoKjNr
 Gj9QNTBz7VPabsctVZV1LemC8iLlRL0wYGBwzP0Ey2yzQ6M3GOerO7CVpvXGXVn2K9tt
 V+7Q==
X-Gm-Message-State: AFuF++leAW4SPN5QQSIf48uQpfnos/HsZPIS0/McC3Xx9ww/UcwNNkLG
 0WJInHLTq0PCAGtPtWYYUUXc8y2pOFq/fcrkqgHeQYBIYsPtiRIsH2+simeO3HDk03R1rRanZoa
 H4v4YeK0=
X-Gm-Gg: AYBFou0+1SkR92ylD6I3Kmcxij8KnnzG8Btak5ksqW6S4Qx454qd2oiuD6nh6DeQ2d+
 cH0QTOhk4o+b06SPDf0vO46lfJix35ybw0zseghXjS1qN/yPsdCT6se3iJ6t5Cj6m/OZ1dROQW0
 v1xKPAY3A0eTCfiwzXcen8aVofwVyZwiTY3w5NM9eikgbbBYehb0qT9SSiZGr17iCWJF9s8BIO/
 lEM3sMi9Jz/dTGV/Tz3GPPMqnIUsaA/Qiqb/9r5dctafcmx1CQMNqsSK3lIUJxcf9G0E0fNEig4
 Qw1tXTEc1hV9dA26yAa9RkVEvXUx1JhXLYyjyCEJnTjcrNdTL67pXDsb+QWOUg9cFLa0MBHVx3d
 r1bk6UMwlszsow/ZsN5ik/14Epi3aU+sB3JJ84WeqTTnBdGkCn6gWhK+Jua/PNJG2HovBN17XFp
 NySeIBfW5hRhyluIQicvdzwUG5DfQKiKBjalukm9kF6R5c8djhb6cSRzTecX3BJ/M8ju5ZA1JlK
 x+o9ZzPP8QJFekwTkUgzuMQXyDLYPokTkY0SlTnPkb2OAacZWml8Dn7Lf2yA1ZymhILKguCubT8
X-Received: by 2002:a05:6402:52c5:b0:6a9:d0f0:69a0 with SMTP id
 4fb4d7f45d1cf-6aab3b0a3e2mr560926a12.11.1790116281332; 
 Tue, 22 Sep 2026 15:31:21 -0700 (PDT)
Received: from node-dev.home
 (86-45-19-184-dynamic.agg1.roc.bbh-prp.eircom.net. [86.45.19.184])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aab3883151sm411663a12.14.2026.09.22.15.31.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 15:31:20 -0700 (PDT)
From: Weqaar Janjua <weqaar.janjua@packetfive.com>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, mst@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 jasowangio@gmail.com, pbonzini@redhat.com, farosas@suse.de,
 lvivier@redhat.com
Subject: [PATCH v2 4/6] pci: Add device ID for CnuasGPU
Date: Tue, 22 Sep 2026 22:30:43 +0000
Message-ID: <20260922223045.190062-5-weqaar.janjua@packetfive.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922223045.190062-1-weqaar.janjua@packetfive.com>
References: <20260922223045.190062-1-weqaar.janjua@packetfive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:33::10;
 envelope-from=weqaar.janjua@packetfive.com; helo=mail-ed2-x10.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Reserve device ID 0016 for the CnuasGPU virtual accelerator.

Signed-off-by: Weqaar Janjua <weqaar.janjua@packetfive.com>
---
 docs/specs/pci-ids.rst | 2 ++
 include/hw/pci/pci.h   | 1 +
 2 files changed, 3 insertions(+)

diff --git a/docs/specs/pci-ids.rst b/docs/specs/pci-ids.rst
index 3f3825bfe5..bda59c20cb 100644
--- a/docs/specs/pci-ids.rst
+++ b/docs/specs/pci-ids.rst
@@ -102,6 +102,8 @@ PCI devices (other than virtio):
   PCI RISC-V IOMMU device
 1b36:0015
   Cnuas virtual RDMA network adapter (:doc:`cnuas-vnic`)
+1b36:0016
+  CnuasGPU virtual accelerator (:doc:`cnuasgpu`)
 
 All these devices are documented in :doc:`index`.
 
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 51b3f83514..ad74f5456e 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -122,6 +122,7 @@ extern bool pci_available;
 #define PCI_DEVICE_ID_REDHAT_UFS         0x0013
 #define PCI_DEVICE_ID_REDHAT_RISCV_IOMMU 0x0014
 #define PCI_DEVICE_ID_REDHAT_CNUASNIC    0x0015
+#define PCI_DEVICE_ID_REDHAT_CNUASGPU    0x0016
 #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
 
 #define FMT_PCIBUS                      PRIx64
-- 
2.43.0


