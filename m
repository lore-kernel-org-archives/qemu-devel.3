Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF66CCDE000
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 10:31:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcKrH-000777-IH; Wed, 24 Jun 2026 06:29:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wcKrF-000762-5A
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:29:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1wcKrD-0007HU-Nq
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 06:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782296963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TSn0YlKNIrGhiGyyc7mHGoMTOpJjhPKEHsQv9XyR10o=;
 b=DF2juVTjFJyxg56utJbwehng5a87s1/ThKHA3E5K4c56vx9d/M910flAJ6zgFheoUH0NuY
 IDlhxbXL2chB8VllYlR8hdbQuqm/sw0+yE9a6AplBN8kiSBXhtUCjiC1MAyfXsi0ITJmi8
 NH6LdWOZ2TkRt7qZ4/GKgXJ2sDURQ6Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-695-YkLKGIjEPMej8ETdxIYnPQ-1; Wed,
 24 Jun 2026 06:29:19 -0400
X-MC-Unique: YkLKGIjEPMej8ETdxIYnPQ-1
X-Mimecast-MFC-AGG-ID: YkLKGIjEPMej8ETdxIYnPQ_1782296958
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 732491954B35; Wed, 24 Jun 2026 10:29:18 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 72F0030001A7; Wed, 24 Jun 2026 10:29:16 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, eauger@redhat.com, peter.maydell@linaro.org,
 shannon.zhaosl@gmail.com, rad@semihalf.com, leif.lindholm@oss.qualcomm.com,
 qemu-arm@nongnu.org
Subject: [PATCH v3 17/17] sbsa-gwdt: limit compare_value to INT64_MAX
Date: Wed, 24 Jun 2026 12:28:30 +0200
Message-ID: <20260624102830.1355552-18-imammedo@redhat.com>
In-Reply-To: <20260624102830.1355552-1-imammedo@redhat.com>
References: <20260624102830.1355552-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

QEMU timer subsystem uses int64_t, so WCV values with bit 63 set
overflow and cause the timer to fire immediately. The SBSA spec
defines WCV as an unsigned 64-bit compare value, so such values
are valid per spec and represent far-future deadlines (however
unpractical).

Windows in GTDT mode writes WCV in two 32-bit halves while the
watchdog is running:

 sbsa-gwdt_control_write [0x8]  <- 0xffffffff    # WOR (~4 sec)
 sbsa-gwdt_control_write [0x0]  <- 0x1           # WCS enable
 sbsa-gwdt_control_write [0x14] <- 0xffffffff    # WCVU (intermediate)
 sbsa-gwdt_control_write [0x10] <- 0xa906ca28    # WCVL
 sbsa-gwdt_control_write [0x14] <- 0xecb1        # WCVU (final)

The intermediate WCVU write (0xffffffff) creates a WCV above
INT64_MAX, which overflows QEMU's signed timer and fires
immediately — triggering WS0 => WS1 => reboot before the final
WCVU write lands.

Clamp WCV to INT64_MAX to avoid timer API overflow.

Note: Windows' GTDT watchdog usage is also fragile under
virtualization. It programs a short WOR (~4 sec), enables WCS,
and relies on a subsequent WCV write to push the deadline far
into the future — never using WRR for explicit refresh. On bare
metal the WCS=>WCV gap is negligible, but in a VM the vCPU can
be preempted between MMIO accesses while the clock keeps
ticking, potentially expiring the short WOR timeout before the
WCV override lands.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 hw/watchdog/sbsa_gwdt.c        | 2 ++
 tests/qtest/bios-tables-test.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index fb67db9672..ff7adbcb0f 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -122,6 +122,8 @@ static void sbsa_gwdt_update_timer(SBSA_GWDTState *s, WdtRefreshType rtype)
     }
 
     timeout = (uint64_t)s->wcvu << 32 | s->wcvl;
+    /* clamp timeout to INT64_MAX to avoid timer overflow */
+    timeout &= INT64_MAX;
     timer_mod(s->timer, timeout);
 }
 
diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 94fc95c8e1..370b0fd2e6 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2308,7 +2308,7 @@ static void test_acpi_aarch64_virt_tcg_gtdt_wd(void)
         .scan_len = 128ULL * MiB,
     };
 
-    test_acpi_one("-cpu cortex-a57 " "-device sbsa-gwdt", &data);
+    test_acpi_one("-cpu cortex-a57 -device sbsa-gwdt", &data);
     free_test_data(&data);
 }
 
-- 
2.47.3


