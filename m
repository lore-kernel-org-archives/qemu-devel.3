Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A91C3ABAC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 14:52:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCJWu-0000Of-PT; Tue, 06 May 2025 10:44:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJVD-0001dO-Bf
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:36 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uCJV9-00027D-Od
 for qemu-devel@nongnu.org; Tue, 06 May 2025 10:42:34 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso47136135e9.2
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 07:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746542549; x=1747147349; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Xs/iC588/V7o70GcvxZgF68fgUadmPr7lsPrdvAHcow=;
 b=OHuE5VMv70IG5URuUsgETrstKAEJ9V0CyYVqCj3xOHqlNhdcs4M8W4QeCoUlYmSFEI
 hSeDWeYvIO7yaZBnV76xsauFs/bgZFf/DagibgbIStU61A8jQTLcyzQT+9GfxvXK8KAt
 tNp7z3qyum64yfdm2bzzszr6bPjDj4NexhtDDmLCvn4f2ZKQ9QvZdoOK9iluyZ9HOBXL
 UW6/AdHFotupWXmjpcDaqQAo7lE/Xi/5XdEIltn/uYXEorBLtaaY52Wb12wLM0N8Ropk
 6wXmuIEm4lTX0N4k5uSWkrZJrQEUcXoTbPXgBJ9YcqjrMmCvZBnpPPmzz5N7fmOqLbOa
 PRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746542549; x=1747147349;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Xs/iC588/V7o70GcvxZgF68fgUadmPr7lsPrdvAHcow=;
 b=aiz73NgJP5I3L7f2NKKtngxcY+CkrCSYGzlSic6YI54Vd3msJ/8RDIy/f/WFi3wXSQ
 8TRma+l95s3iZBltbw9/hfLt8epfr/TQEjrosNyCYdtuZv8FjCJl3Al8rQGID55Tc93P
 bOlkJgBFdCF5p/PEIAjlewzSxsWS24UDVcTLez22Fk+P7qw2pSV73z/3R+Z1kwxsS1d9
 ODpIxAQfuZBpwvBYUCgezZ4TOQvNx1vw8TYzT0r+8or7D57vk/1HjrVjzsTL79GzJ4Yc
 9Oc81UVIb8zrnUSIhuDXwfeop5kqmdEKD9SddRGS8VbqFw8gmdArdXvTu5PqmHbtyKfI
 xFyg==
X-Gm-Message-State: AOJu0Yyxg1vdThlUUXtDp3jr8ftymUvLspC1g2OSrdq67C1wavQaHQHM
 kj1UCj8sAHmJEaJ7G5RLs5dp2pmMy3/V9wapCVGld/n9dQIllCNyPXUbnrNK6Ax6Ycsz/j5sCMX
 j
X-Gm-Gg: ASbGnctMLJE/p9JWNGg9VMoY81dqhsiKiBlhD47pXFaBXcfovSlQ58p6gJalgDN56Qm
 zLtJ7ZcjZMHDJz8VwG+rRzKxLlf4y/SynrDm/DI8amW28aLe/761Po1kPV3OABtF5Biw/beemF4
 oEgZAsTQojMmLLhOieRzOnIe0JmQm5dnp05G9qPG085esK+JnxnVJkWTKRbdg66yffEvZqHEAmX
 hvmdKHkV0psD54VcTln0Ll9ykcaIHoSDA1A1Qi8oireE/a9Ke+YPK1++zb5DXwRL2sJhZUA6lvJ
 sEP7VidsLcTM/kHqx4K61G/wqu15NwMMqmSYPi91njgxJk0=
X-Google-Smtp-Source: AGHT+IErvtVb6S4g8ZHw2e/OqBpH9K41zdQ/0hjKBehSrYXwXqVukUQsban9MJS33efZQKRU/0cVZg==
X-Received: by 2002:a05:600c:4ecf:b0:440:6a5f:c308 with SMTP id
 5b1f17b1804b1-441d051b271mr36448445e9.13.1746542549107; 
 Tue, 06 May 2025 07:42:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441b89edfc2sm169603435e9.20.2025.05.06.07.42.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 07:42:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/32] hw/arm/virt: Remove
 VirtMachineClass::disallow_affinity_adjustment
Date: Tue,  6 May 2025 15:41:52 +0100
Message-ID: <20250506144214.1221450-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506144214.1221450-1-peter.maydell@linaro.org>
References: <20250506144214.1221450-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

The VirtMachineClass::disallow_affinity_adjustment
field was only used by virt-2.6 machine, which got
removed. Remove it and simplify virt_cpu_mp_affinity().

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
[PMM: Remove now-unused variable]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/virt.h |  1 -
 hw/arm/virt.c         | 31 +++++++++++++++----------------
 2 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 27c5bb585cb..5d3b25509ff 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -117,7 +117,6 @@ typedef enum VirtGICType {
 
 struct VirtMachineClass {
     MachineClass parent;
-    bool disallow_affinity_adjustment;
     bool no_its;
     bool no_tcg_its;
     bool claim_edge_triggered_timers;
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index e82b8a45664..9d82cf78b0e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -1770,24 +1770,23 @@ void virt_machine_done(Notifier *notifier, void *data)
 
 static uint64_t virt_cpu_mp_affinity(VirtMachineState *vms, int idx)
 {
-    uint8_t clustersz = ARM_DEFAULT_CPUS_PER_CLUSTER;
-    VirtMachineClass *vmc = VIRT_MACHINE_GET_CLASS(vms);
+    uint8_t clustersz;
 
-    if (!vmc->disallow_affinity_adjustment) {
-        /* Adjust MPIDR like 64-bit KVM hosts, which incorporate the
-         * GIC's target-list limitations. 32-bit KVM hosts currently
-         * always create clusters of 4 CPUs, but that is expected to
-         * change when they gain support for gicv3. When KVM is enabled
-         * it will override the changes we make here, therefore our
-         * purposes are to make TCG consistent (with 64-bit KVM hosts)
-         * and to improve SGI efficiency.
-         */
-        if (vms->gic_version == VIRT_GIC_VERSION_2) {
-            clustersz = GIC_TARGETLIST_BITS;
-        } else {
-            clustersz = GICV3_TARGETLIST_BITS;
-        }
+    /*
+     * Adjust MPIDR like 64-bit KVM hosts, which incorporate the
+     * GIC's target-list limitations. 32-bit KVM hosts currently
+     * always create clusters of 4 CPUs, but that is expected to
+     * change when they gain support for gicv3. When KVM is enabled
+     * it will override the changes we make here, therefore our
+     * purposes are to make TCG consistent (with 64-bit KVM hosts)
+     * and to improve SGI efficiency.
+     */
+    if (vms->gic_version == VIRT_GIC_VERSION_2) {
+        clustersz = GIC_TARGETLIST_BITS;
+    } else {
+        clustersz = GICV3_TARGETLIST_BITS;
     }
+
     return arm_build_mp_affinity(idx, clustersz);
 }
 
-- 
2.43.0


