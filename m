Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3284CC88E50
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 09:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4x9x-0003g5-4c; Fri, 11 Sep 2026 05:03:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9W-00032O-Na
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4x9U-0008BK-W3
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 05:02:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789117352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SMrXl840QxHcg/H4ML9GgiuvmC8Z3gLSM3n2uW6G38c=;
 b=cdKpWQ4t49pVDzRKldLqlvbd2anSCn7bBBVjFogT0arrlwCB4BdQWKE8y0D8/MPhWiIYr7
 b+hCejr6HnlfCrv8CbW5XdhuNoeUUNkpFlVTzV0/3tNei3MCU45QMxxyMzFfhPw1MP77in
 PWWI/SFYjetp7IQfJDMBzWU3gC6HR9I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-I6gXuegCNemilfOyE-VivA-1; Fri, 11 Sep 2026 05:02:30 -0400
X-MC-Unique: I6gXuegCNemilfOyE-VivA-1
X-Mimecast-MFC-AGG-ID: I6gXuegCNemilfOyE-VivA_1789117350
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49cf5bd2f12so7325265e9.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2026 02:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789117349; x=1789722149; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SMrXl840QxHcg/H4ML9GgiuvmC8Z3gLSM3n2uW6G38c=;
 b=Ezrs0JxcOxUWEvyAJs8AuQcU1Gklw1O4Qn30HhITrxL9XKLkptLcAn0Q2Ikm4IrW72
 RGGpjLAkEEWs+DS9WWxRYMh2n8/hCkqXUqgx9j7UumCmDJpMxv1RV0mdyjsbmfAspEe5
 VejRplCi9vXCs2CKfbq7LrkaWywMtkdiI1M9vXYxtU4vuQbLx9oAL97XaT0dtLXPIFyl
 KLDqh3jl8seg2/rRdH/De1vvYV7xBzYOY03d+vxOm0SdviT8LqlLTZImMd7zViB9IZ2O
 kvZXh3d7FsQ++AHfXx1D4XxgfRQMOOCq/xdYP1eZjuO0IWjQJDyfqipLH6AJO5JDxAMg
 Ay3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789117349; x=1789722149;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SMrXl840QxHcg/H4ML9GgiuvmC8Z3gLSM3n2uW6G38c=;
 b=ag5hPuKKOZxU9XdBI59O2b2YgweAV0pbkuATnIUq0ZRpQhbbpEK++mLvCY9aRDBMFx
 9SwEQqVCAzKbs/hGJe3TKI2Vw9fzlwn6vB3c2dc3ZH2e8bkQ9FQ0wV38mkP+UMV2zuZI
 wspOdA9C1lbFKXz8+2VaqpTH0584FYF5CKC7zEVNHFYcENEswGMem07QeQySkRFvWFP5
 IZf4sfT3ToFuhvr08NVBkbMDQnUVwqNxTIPJlx6Q/6RqcJPA56yVAKt8jwpWvQvG4BeO
 35gD7aYhfJwcC/U7BPBut77y/biJSicnlRFM6UHSr9I+Y2BVFdCYKX836ZVPAqj7+suj
 u16w==
X-Gm-Message-State: AFuF++m0Mn0oxqaJSJW3JNSV/QpNgiY5WI6Td0Y6Ey8ZKYymVrUAWz95
 1Pg1hpdQEgWfyvT+bapL9lxc0DNc2/QjtUuIv2zvsEnbNtaUOP3HZW6KLDI1AV6p/qpUwMeFu6Y
 1zGg5WGPeGFDrjqbkYjO8nfVRVDxe0lQGTff3tgkpYl+uMENbLup7V/aOsGL8azmPuJGs6qiGDS
 ahAf3vSay5T6mmGYt0UGKr0b6zBIolVTNzqQ==
X-Gm-Gg: AYBFou3Dzxq81rFAEMdzhskRnubGaefCAEu/OpTdriunFDv3VR4S9d6fwWBicBB0d65
 U6sHw2KyjqHFLZFmJ/UDzDUoVblVeOdpTRi6oMLUzMG7b4Y0grQk0lH4A1SEf1JCpopJgwAVufu
 jH9tVdxUHCTQVCsS4OUj2eH/I1DFIBpz1QuvAPgP1vKlbrjnrlJlEancmPFd/waMIROInvwmijx
 hIqSio+P4wrbJr2k1dF2w+Z+YnKXelpJqseRg7RJO6Jw/Y8vElnto0qeq+wOOjXl/lwzdhAP1ZK
 QqfwsrhB8RAZytZ6N3fx/zc9u8TGc8EUmnpuY9YoIRk1vOvDZQjuG2i6Khl84xPZOO9llzIIDs3
 0gLDvc0Ox8lG3XMduN8bb1ZU=
X-Received: by 2002:a05:600c:3b1f:b0:49d:25b0:cc60 with SMTP id
 5b1f17b1804b1-49e619d1d24mr37106075e9.29.1789117349288; 
 Fri, 11 Sep 2026 02:02:29 -0700 (PDT)
X-Received: by 2002:a05:600c:3b1f:b0:49d:25b0:cc60 with SMTP id
 5b1f17b1804b1-49e619d1d24mr37105265e9.29.1789117348635; 
 Fri, 11 Sep 2026 02:02:28 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e60946249sm69455245e9.0.2026.09.11.02.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 02:02:28 -0700 (PDT)
Date: Fri, 11 Sep 2026 05:02:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL v2 29/75] tests/qtest/cxl: Add CXL Fixed Memory Window
 restriction flag tests
Message-ID: <c8d19a018b5abcb436ba7f8f9993981b8f288290.1789117222.git.mst@redhat.com>
References: <cover.1789117222.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789117222.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: Davidlohr Bueso <dave@stgolabs.net>

Add a /pci/cxl/cfmw group exercising the configurable CFMWS Window
Restrictions.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260720233242.901544-6-dave@stgolabs.net>
---
 tests/qtest/cxl-test.c | 95 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
index 8fb7e58d4f..49d820cde1 100644
--- a/tests/qtest/cxl-test.c
+++ b/tests/qtest/cxl-test.c
@@ -81,6 +81,13 @@
     "-object memory-backend-file,id=lsa3,mem-path=%s,size=256M " \
     "-device cxl-type3,bus=rp3,persistent-memdev=cxl-mem3,lsa=lsa3,id=pmem3 "
 
+/* Single pxb + volatile type3 + one window; base for the CFMW tests. */
+#define QEMU_CFMW \
+    "-machine q35,cxl=on " \
+    "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 " \
+    QEMU_RP QEMU_T3D_VMEM \
+    "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G"
+
 static void cxl_basic_hb(void)
 {
     qtest_start("-machine q35,cxl=on");
@@ -117,6 +124,81 @@ static void cxl_2root_port(void)
     qtest_end();
 }
 
+/*
+ * CFMWS "Window Restrictions" (CXL r4.0 9.18.1.3) are configurable per
+ * window; check that valid restriction sets are accepted.
+ */
+static void cxl_cfmw_default(void)
+{
+    /* No coherency flag advertises both HDM-D and HDM-H. */
+    qtest_start(QEMU_CFMW);
+    qtest_end();
+}
+
+static void cxl_cfmw_host_only_off(void)
+{
+    /* Disabling host-only leaves device-coherent (HDM-D). */
+    qtest_start(QEMU_CFMW ",cxl-fmw.0.host-only=off");
+    qtest_end();
+}
+
+static void cxl_cfmw_device_coherent_off(void)
+{
+    /* Disabling device-coherent leaves host-only (HDM-H). */
+    qtest_start(QEMU_CFMW ",cxl-fmw.0.device-coherent=off");
+    qtest_end();
+}
+
+static void cxl_cfmw_back_invalidate(void)
+{
+    /* Back-Invalidate implies device-coherent (HDM-DB). */
+    qtest_start(QEMU_CFMW ",cxl-fmw.0.back-invalidate=on");
+    qtest_end();
+}
+
+static void cxl_cfmw_fixed_config(void)
+{
+    qtest_start(QEMU_CFMW ",cxl-fmw.0.fixed-config=on");
+    qtest_end();
+}
+
+static void cxl_cfmw_device_and_host(void)
+{
+    /*
+     * device-coherent and host-only may both be advertised (the spec
+     * permits multiple bits set); this must be accepted -- a regression
+     * guard against reinstating a device/host-only mutual exclusion.
+     */
+    qtest_start(QEMU_CFMW
+                ",cxl-fmw.0.device-coherent=on,cxl-fmw.0.host-only=on");
+    qtest_end();
+}
+
+static void cxl_cfmw_volatile_only(void)
+{
+    qtest_start(QEMU_CFMW ",cxl-fmw.0.persistent=off");
+    qtest_end();
+}
+
+static void cxl_cfmw_persistent_only(void)
+{
+    qtest_start(QEMU_CFMW ",cxl-fmw.0.volatile=off");
+    qtest_end();
+}
+
+/* Two windows in one VM: a Back-Invalidate window and a host-only window. */
+static void cxl_cfmw_two_windows(void)
+{
+    qtest_start("-machine q35,cxl=on "
+                "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 "
+                "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 "
+                QEMU_RP QEMU_T3D_VMEM
+                "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G,"
+                "cxl-fmw.0.back-invalidate=on,"
+                "cxl-fmw.1.targets.0=cxl.1,cxl-fmw.1.size=4G");
+    qtest_end();
+}
+
 #ifdef CONFIG_POSIX
 static void cxl_t3d_deprecated(void)
 {
@@ -233,6 +315,19 @@ int main(int argc, char **argv)
         qtest_add_func("/pci/cxl/pxb_x2_with_window", cxl_2pxb_with_window);
         qtest_add_func("/pci/cxl/rp", cxl_root_port);
         qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
+        qtest_add_func("/pci/cxl/cfmw/default", cxl_cfmw_default);
+        qtest_add_func("/pci/cxl/cfmw/host_only_off", cxl_cfmw_host_only_off);
+        qtest_add_func("/pci/cxl/cfmw/device_coherent_off",
+                       cxl_cfmw_device_coherent_off);
+        qtest_add_func("/pci/cxl/cfmw/back_invalidate",
+                       cxl_cfmw_back_invalidate);
+        qtest_add_func("/pci/cxl/cfmw/fixed_config", cxl_cfmw_fixed_config);
+        qtest_add_func("/pci/cxl/cfmw/device_and_host",
+                       cxl_cfmw_device_and_host);
+        qtest_add_func("/pci/cxl/cfmw/volatile_only", cxl_cfmw_volatile_only);
+        qtest_add_func("/pci/cxl/cfmw/persistent_only",
+                       cxl_cfmw_persistent_only);
+        qtest_add_func("/pci/cxl/cfmw/two_windows", cxl_cfmw_two_windows);
 #ifdef CONFIG_POSIX
         qtest_add_func("/pci/cxl/type3_device", cxl_t3d_deprecated);
         qtest_add_func("/pci/cxl/type3_device_pmem", cxl_t3d_persistent);
-- 
MST


