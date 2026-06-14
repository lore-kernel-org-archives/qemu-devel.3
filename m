Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE53ACD98C5
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 19:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYqDm-0001wJ-36; Sun, 14 Jun 2026 15:10:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqDi-0001em-R3
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:10:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYqDh-0002yf-3D
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 15:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781464208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OVFR5ZMMA9tW5EcU89K6NhXfWseK/D10CzlcrHs1uUE=;
 b=XF3cMjwvY92h3hg85p4Rzl1lkMCcg0GgM3F5kOotbUv1MwVi0VZqRPgZgdYAt4G+gqCC05
 9yXcyFdul2OixmStS2fBWZnhCgpdnT3j1MOQ9otX99kQ48vTm2PriAeAOHVtCfE4j9jcGC
 eTNzeqCoNIcEogNUWf7JbSJKNsgiN30=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-UpyOhAsUNISVl0V8LN_wSQ-1; Sun, 14 Jun 2026 15:10:07 -0400
X-MC-Unique: UpyOhAsUNISVl0V8LN_wSQ-1
X-Mimecast-MFC-AGG-ID: UpyOhAsUNISVl0V8LN_wSQ_1781464206
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490b7959b9fso25363255e9.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 12:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781464206; x=1782069006; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OVFR5ZMMA9tW5EcU89K6NhXfWseK/D10CzlcrHs1uUE=;
 b=R26UMC29TN/RNoaGxRcDQmmF6QHsGH8wrWbrn8BKZ9p3P/pIiq+bSpsc8vA5AnKGq9
 LayDQCpF5NQIe7TIjI5vAwn/Sb0bR0cVqS8v6TJIEiD1l325lnSEu23G4DpSGh+u+y5q
 E0OkPHp+5gvSi32TPa9rW8p+7HhOBa6utscA8293ubO+Onerja3KX5na7TRA6Yy6qPbZ
 gOWrUyVJqqSv7XA8qSZVOz9xj2ZUgPNkfI7iPT5N89B78LGEo8Gj6EwIA7//m5pjOoMa
 wGQZOeuo6mzFpuydg9y2pMs5sc10uaQ8seQhyEPM2HfX+MF+WT27HclqX8+k+4Pzl1jS
 TwyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781464206; x=1782069006;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OVFR5ZMMA9tW5EcU89K6NhXfWseK/D10CzlcrHs1uUE=;
 b=kJvzpvdvSvX2/7+gzA0yMZFF8rMOj1PWYWg8FxEnDHlyAvXRAeZGl2ZMMZfa1B3QVG
 KTFPI1SeSG7SbIc1VIauMseHqxv0VOSFEAvpZ8dri9ylMZ+UsXr+yFA9qHyMmV0Mn26E
 S4MheYIqvO1VJ+91vhzaULW9Av2YHWuQ1CgueFgjs/HyaSsCEUWjZvk/yYT1LMtlAlmR
 Fm+mFnhuU5j6rf98u1BM1PZqWFPGxMsBTOsfso7G6e6ctsYUh7NpXh3NmaItBMVOnoMF
 UbgpUF/CriOEzyaTPBkJixnIpNA1hP+xwNbLMS0g+L4ou9F/YE3IKY2BJHOgt4HspYJp
 g+9Q==
X-Gm-Message-State: AOJu0YxgPwSQASN5EnUdJsaHFsq6VJ3CIsejo+8Lv8fHWmvrTAVhq4/V
 GDouh8KflVbPfv4N2gOFR5pjHNR1K+HcrxbvBmxP8gRLViW1fHchw5lpvPrGoVLDzEbVBhioWdG
 g8vQ1bi/KmQXwgHlUFEGnXVgcV6Xl4q9Gp8VEBHYIz4U5Vi0L4Zwj/oEYLo9rjkC4LxRKxQSpbF
 IFIE++STnR7fpsNcFylBz6amROdmEH2hy/oA==
X-Gm-Gg: Acq92OG6+I5tPV3pO4taA2YUslgwEKgMfVydCIeW1YIRJJeVm9eGZ51xjcjgHDqWEJF
 n0vFq5uAg6ys7i3w34jeHwntVE+h+mgfC6gdTjYs2s/+75p6lnTQyzWmwwA7AVAnsKqSFW8Xjg0
 lgJm+QoSCQYTCKYXS8FrsAq2VJPVS1OeXJpGPaDQ0AD2G+YOoUwatwvarjscM78tuFb2PGPCMFO
 2ujupDOt/ehmCd5minpNrZ0VUkuGTIM0DQY+GxjhoF5H6Y6tEhJ0cwuCKEUbmzSlt7XaXEpGY9X
 zczwpAvpXu6cE+yWxT5R8vx1cX8qqO/2GEif+Dr49QAlzJ3IixLXL9FVlzJwTLIQUFOjk6GJP+R
 yH9xxfN+m5Wu76/J5I0Eg1cprMDGHPELLm/4dGnBGj5w=
X-Received: by 2002:a05:600c:a310:b0:490:e19b:bd99 with SMTP id
 5b1f17b1804b1-490ec5021c2mr143426275e9.30.1781464205633; 
 Sun, 14 Jun 2026 12:10:05 -0700 (PDT)
X-Received: by 2002:a05:600c:a310:b0:490:e19b:bd99 with SMTP id
 5b1f17b1804b1-490ec5021c2mr143425735e9.30.1781464205042; 
 Sun, 14 Jun 2026 12:10:05 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492203d08bcsm184331835e9.13.2026.06.14.12.10.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 12:10:04 -0700 (PDT)
Date: Sun, 14 Jun 2026 15:10:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Junjie Cao <junjie.cao@intel.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yi Liu <yi.l.liu@intel.com>, Zhenzhong Duan <zhenzhong.duan@intel.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?Q?Cl=C3=A9ment?= Mathieu--Drif <clement.mathieu--drif@bull.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 105/106] tests/qtest: add 8-byte MMIO access sweep for
 intel-iommu
Message-ID: <ddc0a856d2955677bfda5358ce216ea34e115495.1781463125.git.mst@redhat.com>
References: <cover.1781463125.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1781463125.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Junjie Cao <junjie.cao@intel.com>

Sweep every 4-byte-aligned offset in the VT-d MMIO register space
with 8-byte reads and writes to verify that no register handler
aborts on an oversized access.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Reviewed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260514180703.85686-3-junjie.cao@intel.com>
---
 tests/qtest/intel-iommu-test.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/tests/qtest/intel-iommu-test.c b/tests/qtest/intel-iommu-test.c
index 30ee6524df..ef6e6eb8b6 100644
--- a/tests/qtest/intel-iommu-test.c
+++ b/tests/qtest/intel-iommu-test.c
@@ -17,11 +17,39 @@
 #define ECAP_STAGE_1_FIXED1   (VTD_ECAP_QI |  VTD_ECAP_IR | VTD_ECAP_IRO | \
                               VTD_ECAP_MHMV | VTD_ECAP_SMTS | VTD_ECAP_FSTS)
 
+static inline uint32_t vtd_reg_readl(QTestState *s, uint64_t offset)
+{
+    return qtest_readl(s, Q35_HOST_BRIDGE_IOMMU_ADDR + offset);
+}
+
 static inline uint64_t vtd_reg_readq(QTestState *s, uint64_t offset)
 {
     return qtest_readq(s, Q35_HOST_BRIDGE_IOMMU_ADDR + offset);
 }
 
+static inline void vtd_reg_writeq(QTestState *s, uint64_t offset,
+                                  uint64_t value)
+{
+    qtest_writeq(s, Q35_HOST_BRIDGE_IOMMU_ADDR + offset, value);
+}
+
+static void test_intel_iommu_8byte_access(void)
+{
+    QTestState *s;
+    uint64_t off;
+
+    s = qtest_init("-M q35 -device intel-iommu");
+
+    for (off = 0; off < DMAR_REG_SIZE; off += 4) {
+        vtd_reg_readq(s, off);
+        vtd_reg_writeq(s, off, 0);
+    }
+
+    g_assert_cmpuint(vtd_reg_readl(s, DMAR_VER_REG), !=, 0);
+
+    qtest_quit(s);
+}
+
 static void test_intel_iommu_stage_1(void)
 {
     uint8_t init_csr[DMAR_REG_SIZE];     /* register values */
@@ -58,6 +86,8 @@ static void test_intel_iommu_stage_1(void)
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
+    qtest_add_func("/q35/intel-iommu/8byte-access",
+                   test_intel_iommu_8byte_access);
     qtest_add_func("/q35/intel-iommu/stage-1", test_intel_iommu_stage_1);
 
     return g_test_run();
-- 
MST


