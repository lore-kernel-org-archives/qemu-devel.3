Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10C0DC79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:43:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4nSG-00019I-GO; Thu, 10 Sep 2026 18:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lJw-0002Pn-EL
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:24:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lJp-0000Hv-4m
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:24:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789071721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SMrXl840QxHcg/H4ML9GgiuvmC8Z3gLSM3n2uW6G38c=;
 b=MfMPp1sNwv/GJHV0YyeWinoxDUEwlSyQR72je086FcxvkpqXSt+fU7Z4PTjV6lLAZKt8XV
 GQ7oOiDCUIYDoS2AmX/XcvmxLSyDaAEzDG6QBKVPGJziCcugV/Fe+v1TC6tCzaJ3Hrz8FW
 QPk3GSbqw29xG1LS7Wfm6dd23q7DP9g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-394-AWIQKZL3OG-X4-lmGDCpBQ-1; Thu, 10 Sep 2026 16:13:17 -0400
X-MC-Unique: AWIQKZL3OG-X4-lmGDCpBQ-1
X-Mimecast-MFC-AGG-ID: AWIQKZL3OG-X4-lmGDCpBQ_1789071196
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4994aebe932so2226675e9.3
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071196; x=1789675996; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SMrXl840QxHcg/H4ML9GgiuvmC8Z3gLSM3n2uW6G38c=;
 b=flO3U+IgURz9QcC8ZYyiGrH2sPyVhDJjfX9sUAJ7WPjlS1+stBBq69yW4QGzr3/5SK
 WJ6Y6LPH6ZQSZRyRcewWePDp5tlALFrKTfLAqCJbWvP0i3YgW2fakv9A13o351WsfiO0
 nhU+JM+r2XMTR6NHd2m4hjKlAm1VTAS2ZBpDd0fmGmLLjCZPmKZ7XRb5vr3wv9xYKSqv
 CK+gflR0Fs9W75ixEX/iMy8BdlnpA644pA9UBOX6MHu/A+hqeMpkPkjBHq3gg855Jhy0
 HZU0GEfWxuNdOAHGSv0JxzHsq+5wE2Hf88hY4E9Tg4aqdvdg2Xuc7w8Bc7CM8KQjlISR
 V7/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071196; x=1789675996;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SMrXl840QxHcg/H4ML9GgiuvmC8Z3gLSM3n2uW6G38c=;
 b=CGFIeOfn6n8VIcMryRwTwDmnl2pPsJL/FGYikp7BkNhhXJMYbfDU+vANCwmPVjTxfY
 2m/dEHnULG7LeZ2d1PfhxxDi1Wl857mqTuqA4Hhg7v520rxYivQ9T4n9uE0p1xaHX+OP
 4d06gC6GoS6F+5ZJwZNag7268q3RNsQFJZSoS4XybPJoEGxxgDWPjpdCzC3DPYoRknVf
 xg8fn3SOEGJ06zVygvGSf3XhYD4GSrH2fYaEtx5U+XhONJSn8iq2JlJpS+LaML6qSZMg
 hHz02mOevFWzRngkbu6gN3Y9WiQG7dDHU2DlkjtUp4Grh7py8LCsl6jGc0+fPFOK4BqT
 5A2w==
X-Gm-Message-State: AFuF++mEiCoNiJ0lYikGtR4BUnYXDOh5wABXc3R0xf1ehhezZr2NURXC
 9Lq2k2/MdRK9XGQffxwNhdyXn3Htd387KAY+jcpUnKSt4zTZza78i2AYvSwkOJcLiiu2S484ZOV
 3tF3C4EPJwFpHRFmNcribB2bVJOgXUsEFa097ouHB8WXIFNDUU0l1i9+nuEmMiyVA7ki0KL7B3T
 MssEQU8V1cr0cJCkqKdC6ed1gpUrwfJStXEQ==
X-Gm-Gg: AYBFou1A89QZn4n0aAQ6uEUafBJV64Jy6yVBIDxZDxV7Maw3c4CQ12pXWFG3jLsZ6Z7
 O6phfGSvcdu9CRLVYxvDYYJ/SS4qAN9B4jMMNoBKHzwmW+DFqYq3cE5DswnAYAF15MAUz2F00Hr
 /vCTWVJxfgXJ/xzJ1yFra6OXLvImQmsLi02BUi5JSuJY9CIRH3AV9P51RHsnuAg8igyNtIHEDeH
 M+wm3PAFeN+oIf1zShh7OU5b7XrUQVY0f/RgrLMs7Thvxv6cE1FZGDMUEBKtyhUImGBnVUzAUgk
 5Jp8Xj5sANGhK5t7/WTT0hzUEHTxOj6FZ3tiMYy+AfKYfX0epRKEtWI1cxYY6QQO48QhIpESj6p
 BY09lKr2KcWLCIHK9VkmWHbc=
X-Received: by 2002:a05:600c:b99:b0:499:a277:e8b5 with SMTP id
 5b1f17b1804b1-49e619a1c6amr16232825e9.3.1789071196324; 
 Thu, 10 Sep 2026 13:13:16 -0700 (PDT)
X-Received: by 2002:a05:600c:b99:b0:499:a277:e8b5 with SMTP id
 5b1f17b1804b1-49e619a1c6amr16232135e9.3.1789071195767; 
 Thu, 10 Sep 2026 13:13:15 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c1bfc1sm116298845e9.4.2026.09.10.13.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:13:15 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:13:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 43/90] tests/qtest/cxl: Add CXL Fixed Memory Window
 restriction flag tests
Message-ID: <8bcc440ac210269c7439b97604efe38dad9f94a8.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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


