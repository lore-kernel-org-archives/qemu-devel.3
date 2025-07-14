Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3388CC83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:30:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSMj-0004NS-RR; Mon, 14 Jul 2025 19:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSJB-00059n-0z
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:10:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSJ9-0005zG-3V
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534602;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NpoaHNSgFo/RDoo9oflmiOTFn5UaMvPYbywQP0NYLfY=;
 b=fJTVUSVvdPBAAMfbE8JIH1TdMNsLo8wjinHuDb6xjVMttgUBjxynfeyb5lPIEaYWOpJLD5
 y1/F9OKs3obeTGom943NzRgzR4c5skrlLtRA7AlNOAEQm6+piay1DWSiKrOdAD5QKE1NcZ
 lMjvUON9vTxfDDtP/tkAt2BrGRk5X28=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-668-SXnuwyGxP8KkwAfp2BBo8A-1; Mon, 14 Jul 2025 19:10:01 -0400
X-MC-Unique: SXnuwyGxP8KkwAfp2BBo8A-1
X-Mimecast-MFC-AGG-ID: SXnuwyGxP8KkwAfp2BBo8A_1752534600
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a50816cc58so1639376f8f.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:10:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534599; x=1753139399;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NpoaHNSgFo/RDoo9oflmiOTFn5UaMvPYbywQP0NYLfY=;
 b=LqcvvbeUpWPcziX2XAmr9oxMQLEYe/KhuSyT1bdZjiMnY5nJj4BeUOSXe6hORqr2PD
 ORTjvsBMgU5n4WibBxdO7snBJD3rDTelPjgLw7IVJGSASPYguIbz2Cj9iHQsmLMCqheY
 r4RQtqevq7SBjfKV+utQNpQ7Y0uDL0Xqd7v3YFYqTM8OZu0JAJ6E5mM4FUDMWb2TPPaH
 humjHrZZ+/dOVb7u2XnLzR+vXAoYPiURuu2jzLCixhntj16T9XDBtuU4FOhDdaiKlep7
 VjfWOIOX1p/j0Am+7zQCAMKDs3ZLKAmveg0iL14fNW7NSbiQNGg6DIE/Vh4yt6YEcuNc
 KMAQ==
X-Gm-Message-State: AOJu0YxnBRD+HKQB19I5y+YHa7uyD6P1O11GW+1aJzH8v/fKIfYPhQKY
 d7gSTBpS73dUH1TBNcfQR1gl+ipqtucVzZ+4Z+L32dPwvRcWIq6w8OBWzYom5MfXH0byvXqUf7i
 T1GHZRnUGOmeWhEv8U+37GHbn97cRVXfBLnx3wMRiBZrrBRT0sxKB3Kpj6ErRYfVaIaluc5oHfy
 dmr/7piQH/4Ic6ZMHk3V9PHMph91FlB0B8tA==
X-Gm-Gg: ASbGncuHaNq15HftNWgaFVAJXu48v2k7SmczirR0mw/H0ewnuuqaSeewqRyVYg12nPo
 0XP3Z4iOlRmn6+g3lbE8GE95eqXpradkqqZiVs6UOPCq8dd+jt74JtXH+mEpGUdNFe5bflF2EOt
 PMd0f/+r1ujsTYAT0oIN7/KKlcdEQXCzBgmc2W8WvtAI+ADkpN6PQbCayiaSPNPDclFoC4D1lWV
 uq2wkZG3kRWMlAoWpWPBBqppHAfVdouaT6KLAVBmGEaIH/W62IwS5m2Hb61s1auRXuSEC+z5X26
 Cfr95tmdwLskgoWEDy67qfC0ZhC2usH5
X-Received: by 2002:a05:6000:18a5:b0:3b6:936:92fa with SMTP id
 ffacd0b85a97d-3b6093692fcmr1427777f8f.52.1752534599557; 
 Mon, 14 Jul 2025 16:09:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa/zKJlHlDjvyC04ek9MWlqg66e75MVMANvHHuFYHEV11RWQeuftJ7uNiUHqvUfvAeR8YXow==
X-Received: by 2002:a05:6000:18a5:b0:3b6:936:92fa with SMTP id
 ffacd0b85a97d-3b6093692fcmr1427753f8f.52.1752534599117; 
 Mon, 14 Jul 2025 16:09:59 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e1e8b1sm13431957f8f.82.2025.07.14.16.09.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:09:58 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:09:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Yicong Yang <yangyicong@hisilicon.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PULL 85/97] hw/acpi/aml-build: Build a root node in the PPTT table
Message-ID: <a8a0315535d93aa9eb343550f2bf434198e5fa8b.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Yicong Yang <yangyicong@hisilicon.com>

Currently we build the PPTT starting from the socket node and each
socket will be a separate tree. For a multi-socket system it'll
be hard for the OS to know the whole system is homogeneous or not
(actually we're in the current implementation) since no parent node
to telling the identical implementation informentation. Add a
root node for indicating this.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
Message-Id: <20250714173146.511-4-alireza.sanaee@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/acpi/aml-build.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 9b9be4ea0f..1e685f982f 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -2152,12 +2152,25 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
     int64_t socket_id = -1, cluster_id = -1, core_id = -1;
     uint32_t socket_offset = 0, cluster_offset = 0, core_offset = 0;
     uint32_t pptt_start = table_data->len;
+    uint32_t root_offset;
     int n;
     AcpiTable table = { .sig = "PPTT", .rev = 2,
                         .oem_id = oem_id, .oem_table_id = oem_table_id };
 
     acpi_table_begin(&table, table_data);
 
+    /*
+     * Build a root node for all the processor nodes. Otherwise when
+     * building a multi-socket system each socket tree is separated
+     * and will be hard for the OS like Linux to know whether the
+     * system is homogeneous.
+     */
+    root_offset = table_data->len - pptt_start;
+    build_processor_hierarchy_node(table_data,
+        (1 << 0) | /* Physical package */
+        (1 << 4), /* Identical Implementation */
+        0, 0, NULL, 0);
+
     /*
      * This works with the assumption that cpus[n].props.*_id has been
      * sorted from top to down levels in mc->possible_cpu_arch_ids().
@@ -2174,7 +2187,7 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
             build_processor_hierarchy_node(table_data,
                 (1 << 0) | /* Physical package */
                 (1 << 4), /* Identical Implementation */
-                0, socket_id, NULL, 0);
+                root_offset, socket_id, NULL, 0);
         }
 
         if (mc->smp_props.clusters_supported && mc->smp_props.has_clusters) {
-- 
MST


