Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FA6C3ABBC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 08:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEOlr-0004mz-UD; Mon, 12 May 2025 04:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOjg-0000qi-UX
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:42:12 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uEOje-0001pn-SC
 for qemu-devel@nongnu.org; Mon, 12 May 2025 04:42:08 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a0be321968so2394931f8f.2
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 01:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747039325; x=1747644125; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GVwv0FdE9kunPs7GKD3AsVw5npncB8R9kvNzX+qR/aM=;
 b=MbEnxwhvCsttajgXEfyktdHZCHFXqcDkgujXobK4+0aSkDiEfjirxibShpkX+Yc554
 a3FlDE5HAF2kVpEv6VOBhODfe7aYctdVbqUTCA2QU8UuNHO0uJk0FOpAC0Za15/c/S/s
 +F2jMUAGHGv+YCPlIwwOVatIuIHiIUqcivSxFFAE8f52cY/S/GWXs60TKGpMkuNoEETJ
 PlMYUwjvlQwlLuSTPeKpf60Rmrer5sluVil/bh6HNYwslGlE3Y2fb8oKhKr11bnpk11G
 dWq/M45etSe2qky6Un+Xnhbs2T9e5exesXhGn0y1tO/DTi8lJEdhZb6AU+3L7N9r1ckC
 0XRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747039325; x=1747644125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GVwv0FdE9kunPs7GKD3AsVw5npncB8R9kvNzX+qR/aM=;
 b=H8yXVdFZgEXG+vTDWGxO5nkSplODFVS2IwS4QjxTgOsUpVupXM93cPWGX4o5JUvysy
 gMYHrILQwvyB1pZ8K2nk+5fQpNXl/wW/1x0LIPDkPBLctxlETooIP98lzhCQo0Epeqtr
 1zx6LwBQJPTDvrg/sUDOElLMK2sArTks1igJZl6T5fxCF0hIx6f1sJTLv4Iaelbg9DaQ
 GvNKArCV+TDGNra5W29sOVTuK2Sk/2+qk12mBevcMmNNkxerZX71jHBn+fCpbjuT6dx8
 GLH+psRuFdINrRWbGArSv18OEfccT9TZQoTEizfk2XiY0s+3bKmT0x9QRQMGIwHtylAR
 FtyQ==
X-Gm-Message-State: AOJu0Yx8Fm3fqlxGB2mkAlolNN9ss0Xo2EWLU+P/eh6v0SpH2WpBDCJ3
 /W6oClVGHxKjEFVDOyXPYWTrXJstY1gXmdnEPeZfN8kpqL1JJVpFQGud+LnMFP0wRTSpJDsqs75
 wobQEsA==
X-Gm-Gg: ASbGncvF1ZOORD/am9HgO11Pb7f9vEo4j3qYgYCAzXx+kBDCSaYLmu4cM4Vk6D1z4ip
 phcKBvVB8ptSSIuM0gN2lce7HJAwigpruyxliHAnexvQ9cWcTZt8y3jdYdYmunGikiAC5qP3xee
 oPvEN9KFdx4wyrVhwHYgjNrj8RlIFL1szxvvxp1b2fhpYi6qs/sXFLE+C430KRcsDM6H1zW4SzW
 0Q4BM1TnKZSlXlQAHYASMLjwVfmhA9GCDLgH/Hfa8OlZGVtKvO+y+cMeL3jXU9ZBnhrkm/ZeRid
 sf2qt3+3mO8XGO8qZ8XO7WC+rgMGpS8yXMowpqaPoqHqZI7oH1JQ8dIl26M6zlvt80G6OJEHs9M
 HVH4nCqSZntms28YBKln45q6fBxf+4FnGOg==
X-Google-Smtp-Source: AGHT+IGp5IYNZatxsWr9L+R7yNcuhYeAZBBhj3aCQH372yS25eaN+VlagILiFOOh7+nscqSGMsHtJQ==
X-Received: by 2002:a05:6000:40cc:b0:3a2:6b2:e552 with SMTP id
 ffacd0b85a97d-3a206b2e856mr2850082f8f.29.1747039324545; 
 Mon, 12 May 2025 01:42:04 -0700 (PDT)
Received: from localhost.localdomain (129.163.185.81.rev.sfr.net.
 [81.185.163.129]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f5a2cf43sm11704423f8f.70.2025.05.12.01.42.01
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 12 May 2025 01:42:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Kevin Wolf <kwolf@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Hanna Reitz <hreitz@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, John Snow <jsnow@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH v4 15/19] hw/scsi/vmw_pvscsi: Remove
 PVSCSI_COMPAT_DISABLE_PCIE_BIT definition
Date: Mon, 12 May 2025 10:39:44 +0200
Message-ID: <20250512083948.39294-16-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250512083948.39294-1-philmd@linaro.org>
References: <20250512083948.39294-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

PVSCSI_COMPAT_DISABLE_PCIE_BIT was only used by the
hw_compat_2_5[] array, via the 'x-disable-pcie=on' property.
We removed all machines using that array, lets remove all the
code around PVSCSI_COMPAT_DISABLE_PCIE_BIT, including the now
unused PVSCSIState::compat_flags field.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 hw/scsi/vmw_pvscsi.c | 30 +-----------------------------
 1 file changed, 1 insertion(+), 29 deletions(-)

diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 34de59a7cf6..e163023d14c 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -68,11 +68,6 @@ struct PVSCSIClass {
 OBJECT_DECLARE_TYPE(PVSCSIState, PVSCSIClass, PVSCSI)
 
 
-/* Compatibility flags for migration */
-#define PVSCSI_COMPAT_DISABLE_PCIE_BIT 1
-#define PVSCSI_COMPAT_DISABLE_PCIE \
-    (1 << PVSCSI_COMPAT_DISABLE_PCIE_BIT)
-
 #define PVSCSI_MSI_OFFSET    (0x7c)
 #define PVSCSI_EXP_EP_OFFSET (0x40)
 
@@ -123,8 +118,6 @@ struct PVSCSIState {
     uint8_t msi_used;                    /* For migration compatibility      */
     PVSCSIRingInfo rings;                /* Data transfer rings manager      */
     uint32_t resetting;                  /* Reset in progress                */
-
-    uint32_t compat_flags;
 };
 
 typedef struct PVSCSIRequest {
@@ -1224,21 +1217,8 @@ pvscsi_post_load(void *opaque, int version_id)
     return 0;
 }
 
-static bool pvscsi_vmstate_need_pcie_device(void *opaque)
-{
-    PVSCSIState *s = PVSCSI(opaque);
-
-    return !(s->compat_flags & PVSCSI_COMPAT_DISABLE_PCIE);
-}
-
-static bool pvscsi_vmstate_test_pci_device(void *opaque, int version_id)
-{
-    return !pvscsi_vmstate_need_pcie_device(opaque);
-}
-
 static const VMStateDescription vmstate_pvscsi_pcie_device = {
     .name = "pvscsi/pcie",
-    .needed = pvscsi_vmstate_need_pcie_device,
     .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(parent_obj, PVSCSIState),
         VMSTATE_END_OF_LIST()
@@ -1252,9 +1232,6 @@ static const VMStateDescription vmstate_pvscsi = {
     .pre_save = pvscsi_pre_save,
     .post_load = pvscsi_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_STRUCT_TEST(parent_obj, PVSCSIState,
-                            pvscsi_vmstate_test_pci_device, 0,
-                            vmstate_pci_device, PCIDevice),
         VMSTATE_UINT8(msi_used, PVSCSIState),
         VMSTATE_UINT32(resetting, PVSCSIState),
         VMSTATE_UINT64(reg_interrupt_status, PVSCSIState),
@@ -1288,19 +1265,14 @@ static const VMStateDescription vmstate_pvscsi = {
 
 static const Property pvscsi_properties[] = {
     DEFINE_PROP_UINT8("use_msg", PVSCSIState, use_msg, 1),
-    DEFINE_PROP_BIT("x-disable-pcie", PVSCSIState, compat_flags,
-                    PVSCSI_COMPAT_DISABLE_PCIE_BIT, false),
 };
 
 static void pvscsi_realize(DeviceState *qdev, Error **errp)
 {
     PVSCSIClass *pvs_c = PVSCSI_GET_CLASS(qdev);
     PCIDevice *pci_dev = PCI_DEVICE(qdev);
-    PVSCSIState *s = PVSCSI(qdev);
 
-    if (!(s->compat_flags & PVSCSI_COMPAT_DISABLE_PCIE)) {
-        pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
-    }
+    pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
 
     pvs_c->parent_dc_realize(qdev, errp);
 }
-- 
2.47.1


