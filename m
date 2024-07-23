Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7616C3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:06:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDEd-0006C4-Lf; Tue, 23 Jul 2024 06:59:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDEb-0005hs-Ki
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:59:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sWDEZ-0002K0-Tr
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 06:59:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721732347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=glIE7906tG8xbsdQlnyVht0Qfp0CHdCdyn4JQdsY2qk=;
 b=MrCI/F/ucFYcd7SEi1v3X6KJITdejSwgDsKKSO61C5AilyWL5SMGWL1ss3xAF/Px0Y1TTJ
 a8lfLDE+dANNdniAGRv+OnDeE0UoASixFysI+TMSjtx8motOif82ePE8lAR7Mz1J0KSq1r
 gJEviis+mcCBllLxDCUu16RS3JWNbAA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-BMycfZljPgOHIGIHDLjp6g-1; Tue, 23 Jul 2024 06:59:06 -0400
X-MC-Unique: BMycfZljPgOHIGIHDLjp6g-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-5a2d4fb1e73so4085013a12.2
 for <qemu-devel@nongnu.org>; Tue, 23 Jul 2024 03:59:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721732344; x=1722337144;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=glIE7906tG8xbsdQlnyVht0Qfp0CHdCdyn4JQdsY2qk=;
 b=jnannnBtmkaq6Wr5UnUHxdeogVvVjj1XBcQov3ZIDHXMFaq+kURTHHEKIoisk0mHdJ
 mCOy84E6L2tHtWaHBP4uII1gsn3hvvMa7HwjeOkcSXA4urJ9btmAVT+O7I/kAPvaHZqn
 tFhdO4IcT5xU5DcUn8usiwvOVUe/MK+5ghTW7cf/V8MPK+n7jHfNR+3KcqK0R9VYrE26
 G21oIabkvAIFwB5dRjV329O60PmVe/u2mBYTzgfoKGbQXLtgaupszr1qM9KAewdpCROA
 AlSvS97gdBW7o9L6XkdfzX6NEYjeWeHhdA3UlAHAyfeP9ooV7hZTDsjdt/7UsC4jc7/4
 PpFA==
X-Gm-Message-State: AOJu0Yy2IPmiXzgoSV16cExakaKt4dNziRx4RNmbIXRR4ogM/LHsV18u
 WFrMeAo7t+xR1IRShV8h/Qa5OD7k4uf11QGmmu76V64MHTgSzGzdzwHhf/SiT89+XEfyrFXgicx
 JfI8HN65fHmQVEYf5E+alDPGtzPaq4QPH/TxTmdlS/iKXSpnzfwuIV9lRSqkPMh+eCphPy9NviI
 DghYPaHyadMRTSQNYCKpJnTkPusy0thQ==
X-Received: by 2002:a50:ccc2:0:b0:5a2:1f7b:dfff with SMTP id
 4fb4d7f45d1cf-5a478b79a8fmr5602345a12.6.1721732344495; 
 Tue, 23 Jul 2024 03:59:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkY1B+SxNO1bP+niY0kZAQGjsvQnd71EA4XVumgGGeth4M7eQkjnVAjspzmDUcI7AeGLwo/g==
X-Received: by 2002:a50:ccc2:0:b0:5a2:1f7b:dfff with SMTP id
 4fb4d7f45d1cf-5a478b79a8fmr5602315a12.6.1721732343914; 
 Tue, 23 Jul 2024 03:59:03 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:9c9a:ffee:509d:1766:aa7f])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5a30c2f8808sm7305396a12.78.2024.07.23.03.58.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jul 2024 03:59:03 -0700 (PDT)
Date: Tue, 23 Jul 2024 06:58:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Salil Mehta <salil.mehta@huawei.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Gavin Shan <gshan@redhat.com>, David Hildenbrand <david@redhat.com>,
 Shaoqin Huang <shahuang@redhat.com>,
 Vishnu Pajjuri <vishnu@os.amperecomputing.com>,
 Xianglai Li <lixianglai@loongson.cn>, Miguel Luis <miguel.luis@oracle.com>,
 Zhao Liu <zhao1.liu@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PULL v2 38/61] hw/acpi: Move CPU ctrl-dev MMIO region len macro to
 common header file
Message-ID: <2f1a85daf3d8d06e4b204c29c1d47c76a2bc81e6.1721731723.git.mst@redhat.com>
References: <cover.1721731723.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1721731723.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Salil Mehta <salil.mehta@huawei.com>

CPU ctrl-dev MMIO region length could be used in ACPI GED and various other
architecture specific places. Move ACPI_CPU_HOTPLUG_REG_LEN macro to more
appropriate common header file.

Signed-off-by: Salil Mehta <salil.mehta@huawei.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Shaoqin Huang <shahuang@redhat.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Xianglai Li <lixianglai@loongson.cn>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Tested-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20240716111502.202344-3-salil.mehta@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/cpu.h | 2 ++
 hw/acpi/cpu.c         | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index e6e1a9ef59..df87b15997 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -19,6 +19,8 @@
 #include "hw/boards.h"
 #include "hw/hotplug.h"
 
+#define ACPI_CPU_HOTPLUG_REG_LEN 12
+
 typedef struct AcpiCpuStatus {
     CPUState *cpu;
     uint64_t arch_id;
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 2d81c1e790..cf5e9183e4 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -7,7 +7,6 @@
 #include "trace.h"
 #include "sysemu/numa.h"
 
-#define ACPI_CPU_HOTPLUG_REG_LEN 12
 #define ACPI_CPU_SELECTOR_OFFSET_WR 0
 #define ACPI_CPU_FLAGS_OFFSET_RW 4
 #define ACPI_CPU_CMD_OFFSET_WR 5
-- 
MST


