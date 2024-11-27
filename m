Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99BF5D6ACD2
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 13:59:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGIYQ-0003jT-Nk; Wed, 27 Nov 2024 08:58:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tGIYQ-0003jK-0G
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:58:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1tGIYO-0007l2-Al
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:58:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732715883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PVkuzJ3PZWHU81/L5qS9M1rthMb+FEyxqRXv2Sgjhfs=;
 b=Urax264/p8e6G9YaXB82si6eLaJMoKQTEK9gCP7foJR770mNk6oLIil6K9w2/WA/kJfy1z
 SPltw8pdojtpnPp3jBpDLbaH0mjM3XqcFd+JeB8cdSeb2pVK32zqULRD2ecsWGTxuW/kZY
 SkzYT2+invNqkmOzXgFHXTQE9VvS2Bg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-7BZsZw3zP4izATAdwo09Vg-1; Wed, 27 Nov 2024 08:58:01 -0500
X-MC-Unique: 7BZsZw3zP4izATAdwo09Vg-1
X-Mimecast-MFC-AGG-ID: 7BZsZw3zP4izATAdwo09Vg
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-434a90febb8so7993075e9.1
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 05:58:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732715880; x=1733320680;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PVkuzJ3PZWHU81/L5qS9M1rthMb+FEyxqRXv2Sgjhfs=;
 b=VbzUBGeR67SX1hhYoIKP7unls3+SA08Xinsw+QqEJg0YOsnpT1zsqWSEvRoBxlNaDv
 /I8juKlN8uvOKwhvZyIICHWvSg51UWSBgWPyqJuw5cG+2DjHKiD2/bmN1FHQRCb4yZyH
 +b9B7Zz6l9ALMGra7En6gFF8GAz8/eCk9NFKGgO1N1Or7lFvdl635UOQpoablsLTcAhV
 ad54Jz5njE0xPS5MAPYlbTFdYZMYBFs/L+9qd86PpuRqZMK2lXmjawxbPsrJ9iNAV2mE
 numoF3OkedLrH9sLFiohd3qwmMIJZBAz8vH6P0SXngRSJbw8EwlvF2d6GOCy07DsxOv1
 7PdA==
X-Gm-Message-State: AOJu0Yx+t2lRPU9CQwB7z7w0j10Tgy4N4U3Ghq7S6bpaWnz4oVvG0RSw
 FtY3Pia9xWj3+Vlzk6/szNfo6WpaNnrCDrNmojXEJLSroO+OVdm8dZJunB1QQREcMoky/VjrgST
 K7+lGqJAbK932LTFwb3NBEWSJ+0wsiuK77+V5+RwlEkdz6e1zjrphyWaTyLvrn6ACAV3GB8tAue
 qHUs/uE/btzYptsFazO8RcxNi+i4Iy/Mk0
X-Gm-Gg: ASbGnctidP5d7Ofr6YfZR1lZIh+sVGxsLHHOiZQ5vlVwsko+gk5EtgQRTFXJhGlyJ00
 YBu837yX5oWemq2BGdJ8oq4Iv1ZOqMSn26ypOoEN8oIqe53jqKjxu+BkOY+mAIgm/rGUMCy0tdW
 qN/Cg92iUg56ABM1fQfimY77elJMKEaVKDvKomAUr551Y5dGvMcIrXTdvobxUUvGke4WdTca/9R
 cy3f+rIJHqOch1YDdwh2VrcrGLv+EDnzJUwXrvdl6X5
X-Received: by 2002:a05:6000:2cc:b0:382:498a:9cf5 with SMTP id
 ffacd0b85a97d-385c6ebb6d9mr2753746f8f.14.1732715879917; 
 Wed, 27 Nov 2024 05:57:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYo73Vhc5gZnsNQ89iDBTlPAYABUSyYi/dd+/lr+ioOv/d3JeBQh530VXrw8FJEgu2iKzXyw==
X-Received: by 2002:a05:6000:2cc:b0:382:498a:9cf5 with SMTP id
 ffacd0b85a97d-385c6ebb6d9mr2753717f8f.14.1732715879435; 
 Wed, 27 Nov 2024 05:57:59 -0800 (PST)
Received: from redhat.com ([2a02:14f:1ec:7d4b:8b11:bed7:9e00:8df7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa74f18bsm22809315e9.4.2024.11.27.05.57.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 05:57:58 -0800 (PST)
Date: Wed, 27 Nov 2024 08:57:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 11/13] bios-tables-test: Add complex SRAT / HMAT test for GI GP
Message-ID: <18afed7402038b772dc9e9250181bcaddda864ab.1732715823.git.mst@redhat.com>
References: <cover.1732715823.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1732715823.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Add a test with 6 nodes to exercise most interesting corner cases of SRAT
and HMAT generation including the new Generic Initiator and Generic Port
Affinity structures.  More details of the set up in the following patch
adding the table data.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20241107123446.902801-5-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 tests/qtest/bios-tables-test.c | 97 ++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index e79f3a03df..16d0ffbdf6 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1936,6 +1936,101 @@ static void test_acpi_q35_tcg_acpi_hmat_noinitiator(void)
     free_test_data(&data);
 }
 
+/* Test intended to hit corner cases of SRAT and HMAT */
+static void test_acpi_q35_tcg_acpi_hmat_generic_x(void)
+{
+    test_data data = {};
+
+    data.machine = MACHINE_Q35;
+    data.arch    = "x86";
+    data.variant = ".acpihmat-generic-x";
+    test_acpi_one(" -machine hmat=on,cxl=on"
+                  " -smp 3,sockets=3"
+                  " -m 128M,maxmem=384M,slots=2"
+                  " -device pcie-root-port,chassis=1,id=pci.1"
+                  " -device pci-testdev,bus=pci.1,"
+                  "multifunction=on,addr=00.0"
+                  " -device pci-testdev,bus=pci.1,addr=00.1"
+                  " -device pci-testdev,bus=pci.1,id=gidev,addr=00.2"
+                  " -device pxb-cxl,bus_nr=64,bus=pcie.0,id=cxl.1"
+                  " -object memory-backend-ram,size=64M,id=ram0"
+                  " -object memory-backend-ram,size=64M,id=ram1"
+                  " -numa node,nodeid=0,cpus=0,memdev=ram0"
+                  " -numa node,nodeid=1"
+                  " -object acpi-generic-initiator,id=gi0,pci-dev=gidev,node=1"
+                  " -numa node,nodeid=2"
+                  " -object acpi-generic-port,id=gp0,pci-bus=cxl.1,node=2"
+                  " -numa node,nodeid=3,cpus=1"
+                  " -numa node,nodeid=4,memdev=ram1"
+                  " -numa node,nodeid=5,cpus=2"
+                  " -numa hmat-lb,initiator=0,target=0,hierarchy=memory,"
+                  "data-type=access-latency,latency=10"
+                  " -numa hmat-lb,initiator=0,target=0,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=800M"
+                  " -numa hmat-lb,initiator=0,target=2,hierarchy=memory,"
+                  "data-type=access-latency,latency=100"
+                  " -numa hmat-lb,initiator=0,target=2,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=200M"
+                  " -numa hmat-lb,initiator=0,target=4,hierarchy=memory,"
+                  "data-type=access-latency,latency=100"
+                  " -numa hmat-lb,initiator=0,target=4,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=200M"
+                  " -numa hmat-lb,initiator=0,target=5,hierarchy=memory,"
+                  "data-type=access-latency,latency=200"
+                  " -numa hmat-lb,initiator=0,target=5,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=400M"
+                  " -numa hmat-lb,initiator=1,target=0,hierarchy=memory,"
+                  "data-type=access-latency,latency=500"
+                  " -numa hmat-lb,initiator=1,target=0,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=100M"
+                  " -numa hmat-lb,initiator=1,target=2,hierarchy=memory,"
+                  "data-type=access-latency,latency=50"
+                  " -numa hmat-lb,initiator=1,target=2,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=400M"
+                  " -numa hmat-lb,initiator=1,target=4,hierarchy=memory,"
+                  "data-type=access-latency,latency=50"
+                  " -numa hmat-lb,initiator=1,target=4,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=800M"
+                  " -numa hmat-lb,initiator=1,target=5,hierarchy=memory,"
+                  "data-type=access-latency,latency=500"
+                  " -numa hmat-lb,initiator=1,target=5,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=100M"
+                  " -numa hmat-lb,initiator=3,target=0,hierarchy=memory,"
+                  "data-type=access-latency,latency=20"
+                  " -numa hmat-lb,initiator=3,target=0,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=400M"
+                  " -numa hmat-lb,initiator=3,target=2,hierarchy=memory,"
+                  "data-type=access-latency,latency=80"
+                  " -numa hmat-lb,initiator=3,target=2,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=200M"
+                  " -numa hmat-lb,initiator=3,target=4,hierarchy=memory,"
+                  "data-type=access-latency,latency=80"
+                  " -numa hmat-lb,initiator=3,target=4,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=200M"
+                  " -numa hmat-lb,initiator=3,target=5,hierarchy=memory,"
+                  "data-type=access-latency,latency=20"
+                  " -numa hmat-lb,initiator=3,target=5,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=400M"
+                  " -numa hmat-lb,initiator=5,target=0,hierarchy=memory,"
+                  "data-type=access-latency,latency=20"
+                  " -numa hmat-lb,initiator=5,target=0,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=400M"
+                  " -numa hmat-lb,initiator=5,target=2,hierarchy=memory,"
+                  "data-type=access-latency,latency=80"
+                  " -numa hmat-lb,initiator=5,target=4,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=200M"
+                  " -numa hmat-lb,initiator=5,target=4,hierarchy=memory,"
+                  "data-type=access-latency,latency=80"
+                  " -numa hmat-lb,initiator=5,target=2,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=200M"
+                  " -numa hmat-lb,initiator=5,target=5,hierarchy=memory,"
+                  "data-type=access-latency,latency=10"
+                  " -numa hmat-lb,initiator=5,target=5,hierarchy=memory,"
+                  "data-type=access-bandwidth,bandwidth=800M",
+                  &data);
+    free_test_data(&data);
+}
+
 #ifdef CONFIG_POSIX
 static void test_acpi_erst(const char *machine, const char *arch)
 {
@@ -2414,6 +2509,8 @@ int main(int argc, char *argv[])
             qtest_add_func("acpi/q35/nohpet", test_acpi_q35_tcg_nohpet);
             qtest_add_func("acpi/q35/acpihmat-noinitiator",
                            test_acpi_q35_tcg_acpi_hmat_noinitiator);
+            qtest_add_func("acpi/q35/acpihmat-genericx",
+                           test_acpi_q35_tcg_acpi_hmat_generic_x);
 
             /* i386 does not support memory hotplug */
             if (strcmp(arch, "i386")) {
-- 
MST


