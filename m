Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05DA6C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 19:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wonS9-0003Ev-TF; Tue, 28 Jul 2026 15:27:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonS8-0003DX-DM
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:27:00 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mathieu.poirier@linaro.org>)
 id 1wonS6-0001Ul-M9
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 15:27:00 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-38deea72eebso223431a91.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 12:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785266817; x=1785871617; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y9/pLOprN9xy/YNaMUPV2tlXHH+UzLYmz6W1kUG4LRc=;
 b=f0hxXe4oRhE3GzMMohyhYEf4gUtwqIQX5xXaSy3aTuQfkKnUriwG031jk7fQ4pfVfH
 lSfWpOKpaN9RHgk/gEJaOJHfHgISu40C9AHE4SbV9cjyJA5CD5U3g5qSlCbpYIKQpt3V
 ZN6YAu6fDM4SefYjKYjAEmGAs4eT43L1qQ+vM0K8gfzhLkJlcKAZIm0HTAnwBeE/jBtd
 1/28409HnpN3EOotDZCpyQ2OsFIsBou+kltEW3vuMx9smqob6jzoXsCVWEySgI7oFFXI
 jbAiIeEcLS9gUBDxdfO4IceuEWgWaxT9lXj8cgE8gvk6JrYzAinNL/JqERPDehmbJ5za
 QVww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785266817; x=1785871617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=y9/pLOprN9xy/YNaMUPV2tlXHH+UzLYmz6W1kUG4LRc=;
 b=dyBHxrLCXAT2pHZuV4Fgwda8761meSPcV9NEUWqJEBpX8sLAZmMMTtAQtCrMgHynEy
 iyrHTuwHosvGlDc32DjlBI+r50pk+XnNwxm2VBxm9b99trOilJSY10f1dEC7M7yYP2zx
 A97CDDjYmohC/H/reE3IMXLoH+WXpEaqcCXjP/DToqUdstMncv1jgq4BsKBVm2uDXGW2
 cFpCQ5KxZgZsk2W5y1dq492y4AijB5/LtcY4dxEv960Z6gQ6oUkwWzQynoSufKGnPiHZ
 crHzzNF6WbeuPciHx46iIiQhSPyl5pAXYE3KdzSMB/21u6GgArmwfA3Cvx4JBBFGpore
 dLvQ==
X-Gm-Message-State: AOJu0YyPgiLb6ypcqCaSrM012SwtrYZSgyeoZ5EyGEl4HjFH3+O2Q/NC
 cKXrX0brSh0VU97B9tnhPIHpNBZNW+B8rEXt+ov0V3BgpV7mEsPQGjXPZ13spw5WAJo=
X-Gm-Gg: AR+sD1117CYYGPSSmQhCfgGVq6MpSG+ppKgCJ13iBKRx6JYiujq5U/8ONeYlvBWaTGE
 03XSIWs8ncHAYJWrJ4gZ+7qG3GQemC5EpXSz6m6JRA6biK8EX0BEVz/eJrtVNRQgyM/0AEGaor1
 QtfIy4KcAM00AOXzmmmBiE1p+vmmDf0IgnVA5sgjQTZXKEEaIlM+oDbmzRChThA8oLvGbpaRLvt
 OUkI7fk9ZmZCKYv5kc8q7QuZJZbLaXde2AoH7UX97SecfD5Kn3L4+z9xHMP1upRPaHyvKIpladH
 zPe7+ovW6TD9iEGg6buWIZUR8oUEx+hiFA2s9w/30KdkVEY4tVU02CJnArQkWLB+Jgml9sCHqQJ
 wyXCVtdq102eS8EhEu41cU56JHdG1FFNJsLJF4XRG0H4LLySi0WrfXRz+Bh4rSeiTvvDQWBtaZu
 mBnNE2hHABw1olzrO6q4lgRghLbZfc4PUCE43JNuuTTowhdWQIQlIxJGYVA+O0F1Q6M/v3H36rj
 SN4p54kzRuumd0=
X-Received: by 2002:a17:90b:4b50:b0:38e:659b:f366 with SMTP id
 98e67ed59e1d1-38f6a27d798mr3746529a91.0.1785266817324; 
 Tue, 28 Jul 2026 12:26:57 -0700 (PDT)
Received: from p14s.cg.shawcable.net
 ([2604:3d09:148c:c800:b9d1:87c9:a085:86c9])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f7f1353fdsm372650a91.8.2026.07.28.12.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 12:26:56 -0700 (PDT)
From: Mathieu Poirier <mathieu.poirier@linaro.org>
To: berrange@redhat.com, kchamart@redhat.com,
 pierrick.bouvier@oss.qualcomm.com, peter.maydell@linaro.org,
 mst@redhat.com, cohuck@redhat.com, pbonzini@redhat.com, eblake@redhat.com,
 armbru@redhat.com, lorenzo.pieralisi@linaro.org, gshan@redhat.com
Cc: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	kvm@vger.kernel.org
Subject: [RFC v2 11/24] target/arm/kvm-rme: Populate Realm with runtime images
Date: Tue, 28 Jul 2026 13:26:17 -0600
Message-ID: <20260728192630.240375-12-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728192630.240375-1-mathieu.poirier@linaro.org>
References: <20260728192630.240375-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=mathieu.poirier@linaro.org; helo=mail-pj1-x1034.google.com
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

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Once the Realm descriptor has been created, tell KVM to transfer runtime
images (kernel, DT, and rootfs) from guest memory to Realm memory.

Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 target/arm/kvm-rme.c | 56 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
index 10bca9a944ba..335ad60d0f3b 100644
--- a/target/arm/kvm-rme.c
+++ b/target/arm/kvm-rme.c
@@ -43,12 +43,68 @@ OBJECT_DEFINE_SIMPLE_TYPE_WITH_INTERFACES(RmeGuest, rme_guest, RME_GUEST,
 
 static RmeGuest *rme_guest;
 
+static int rme_populate_range(const RmeRamRegion *region, bool measure,
+                              Error **errp)
+{
+    int ret;
+    void *host_ua;
+    hwaddr size = region->size;
+    hwaddr base = region->base;
+    hwaddr start = QEMU_ALIGN_DOWN(base, RME_PAGE_SIZE);
+    hwaddr end = QEMU_ALIGN_UP(base + size, RME_PAGE_SIZE);
+    struct kvm_arm_rmi_populate populate_args;
+
+    host_ua = address_space_map(region->as, base, &size, false,
+                                MEMTXATTRS_UNSPECIFIED);
+
+    populate_args = (struct kvm_arm_rmi_populate) {
+        .base = start,
+        .size = end - start,
+        .source_uaddr = (uintptr_t)host_ua,
+        .flags = measure ? KVM_ARM_RMI_POPULATE_FLAGS_MEASURE : 0,
+    };
+
+    while (populate_args.size > 0) {
+        ret = kvm_vm_ioctl(kvm_state, KVM_ARM_RMI_POPULATE, &populate_args, 0);
+        if (ret) {
+            error_setg_errno(errp, -ret,
+                "failed to populate realm [0x%"HWADDR_PRIx", 0x%"HWADDR_PRIx")",
+                start, end);
+            break;
+        }
+    }
+
+    address_space_unmap(region->as, host_ua, size, false, 0);
+
+    return ret;
+}
+
+static void rme_populate_ram_region(gpointer data, gpointer err)
+{
+    Error **errp = err;
+    const RmeRamRegion *region = data;
+
+    if (*errp) {
+        return;
+    }
+
+    rme_populate_range(region, /* measure */ true, errp);
+}
+
 static void rme_vm_state_change(void *opaque, bool running, RunState state)
 {
+    Error *errp = NULL;
+
     if (!running) {
         return;
     }
 
+    g_slist_foreach(rme_guest->ram_regions, rme_populate_ram_region, &errp);
+    g_slist_free_full(g_steal_pointer(&rme_guest->ram_regions), g_free);
+    if (errp) {
+        return;
+    }
+
     kvm_mark_guest_state_protected();
 }
 
-- 
2.43.0


