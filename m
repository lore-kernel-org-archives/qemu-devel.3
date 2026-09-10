Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB22C79FBB
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:37:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4nNr-0008QZ-Nx; Thu, 10 Sep 2026 18:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lJo-0002Nb-TD
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:24:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1x4lJa-00087c-Gb
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 16:24:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789071616;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Moug1WmXO2CB2DYm8PmKZYdWRJM7GGO9/h6JXojQGEQ=;
 b=ZYSXDyVCa4ip1RhR1FmirIF/UOYcuLJ5/ohOMkSMzZJYbZcbAdWF/b+R48cmiE/qKxJ/0r
 +PdTFUinALnox8pl3kv0SRCdf1U2lEpzP9Jtq5MIyIdDoi1bVWHVnzaJQ+nIs/1n8RzkzI
 1nbM+M0YWuKf//KX512kc3OX9vMIcMc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-EXgOxq0SOdGzzlIPZ7NwKQ-1; Thu, 10 Sep 2026 16:14:07 -0400
X-MC-Unique: EXgOxq0SOdGzzlIPZ7NwKQ-1
X-Mimecast-MFC-AGG-ID: EXgOxq0SOdGzzlIPZ7NwKQ_1789071246
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-486e8fb7d75so36218f8f.0
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 13:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789071246; x=1789676046; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Moug1WmXO2CB2DYm8PmKZYdWRJM7GGO9/h6JXojQGEQ=;
 b=gPftJCD9b6DnwxsL+uYFAzAf7U0Da2amVolXKIoI/Fyu/2AKbmRFueIpoRi+NaZvIW
 +D2/qc6TojSgLePMxrf43g+aESJGiBWDhvPYoOl7ljPyPM3aabIedYDk/FS7O8MvhI5S
 ch9/Em5pyYeq/kWm6q1sjC4Pv/tqF85tq2wk6E/vM11vFHm9edrWPy8yiYbIzUndcy0s
 NCzg5OP44zYfHK/qBNSCwtFekxjRuacPosT09Z3o+Lqmc4i/8EzWB2p2EYPDuBzAZP9g
 aPDaasQi/wWIeRaBhmv09IwV3FaH1NGbSgAbAkVwUKValtMTkkV/FotWWTEtYS0K/ab6
 q77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789071246; x=1789676046;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Moug1WmXO2CB2DYm8PmKZYdWRJM7GGO9/h6JXojQGEQ=;
 b=gmbzsj0AQkR1x066vcBFPseIyytEvDqlUhL25poeY7aZlxvgdyb/iZjuJNRzQuxouD
 NGg1Ph53QBznKgpIlVfHQgi0HN6bxABVcNcXwrA7UTbuCCwa0LeOa9+j4x8w6RELVkyd
 5mt71IPP1wnsiDUCHeIdN4C0mT7HeV+drdLBa8tb8+5LVJQfG43IToopBIaDgshJ2ER9
 HYGa7xguiPjdvmB2bUeMq/6zDZTXrLcuvm4/5pVMp++v4A3xYwOJQ6tiQWvnWBFS9WTx
 rl23v1QIR49GZ+MAqZzzo8MfkGaphlvWhnToy6kEQmbafA8UAJ+Iy7TIste4YWhoDBl3
 AFPg==
X-Gm-Message-State: AFuF++nPz0ouQNvKw5HfvZuiKdkt5rgB0didKRibLWRO8QMlaMNFFgS+
 KmlHwx6IwQfpfII0Hh6mBM8X5bg466cFWexkiugTYAzxJcn662sy8PLQP8IUTEIOBjtVUjOQ8Av
 aPbauqadUNO3L+LEBbPWtwtsljatez0pB0I9ma2slMTDn9flrsC78LHVLpwk95tZhY6VsNpCdtw
 xWCmYX1hqXACcYm7ono/0l46+FARbYsyVXOg==
X-Gm-Gg: AYBFou10t00wOMTUOiukIgQV1Myex4iNy1HISdrGyULWXOid3uOll92J07aJ7SdthRT
 oaHz8qqHbprcr06NlVpj2V6hn2m17biPYdoMwLDxubd/cnfx1f4PzPIXOHeptPfqveHPaAKMZSA
 dVQ7FhxHNN+aB2IxRu9pXNWoeqT49nr4QsP0W/3imEt80meZ9L3XpEB8BbPQm1sOkMTENM4H7bl
 uP+7DNwh2pEHo68u2vBZEltS+GOpufe4tyBG7+klqu2F84O2EREjoM3yQAUIS+uaOy5hy8SjXWn
 5VkxN+EFrhUWElFVHV8iREAEx5vL8TaE4hfmuHhRHzGwSzo9VIor78eZHPo4yB83t4PilA++Rj5
 CNUOHcihGSAfDVRp4Egzrdmg=
X-Received: by 2002:a05:6000:2006:b0:485:847f:fd89 with SMTP id
 ffacd0b85a97d-486eb2e2588mr668046f8f.9.1789071246350; 
 Thu, 10 Sep 2026 13:14:06 -0700 (PDT)
X-Received: by 2002:a05:6000:2006:b0:485:847f:fd89 with SMTP id
 ffacd0b85a97d-486eb2e2588mr667996f8f.9.1789071245753; 
 Thu, 10 Sep 2026 13:14:05 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486eb33ee5csm810113f8f.20.2026.09.10.13.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 13:14:05 -0700 (PDT)
Date: Thu, 10 Sep 2026 16:14:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sairaj Kodilkar <sarunkod@amd.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 62/90] acpi_build: Use IOMMU pci device to build IOMMU DeviceID
Message-ID: <30b49a4782d7bff2abfbf9982a30255aa40c3376.1789071043.git.mst@redhat.com>
References: <cover.1789071042.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1789071042.git.mst@redhat.com>
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

From: Sairaj Kodilkar <sarunkod@amd.com>

Currently, build_amd_iommu() uses "addr" property to build the DeviceID for
IOMMU device and advertise it through IVRS. But this property does not encode
IOMMU bus number, only the device and function number. This creates an
incorrect DeviceID when the IOMMU is attached to a bus other than the
default one with bus number 0.

Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260807061250.27739-5-sarunkod@amd.com>
---
 hw/i386/acpi-build.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 05b68d05a8..a28bb2ec63 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1851,6 +1851,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
     AcpiTable table = { .sig = "IVRS", .rev = 1, .oem_id = oem_id,
                         .oem_table_id = oem_table_id };
     uint64_t feature_report;
+    uint16_t iommu_devid = pci_get_bdf(&s->pci->dev);
 
     acpi_table_begin(&table, table_data);
     /* IVinfo - IO virtualization information common to all
@@ -1913,9 +1914,7 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
     /* IVHD length */
     build_append_int_noprefix(table_data, ivhd_blob->len + 24, 2);
     /* DeviceID */
-    build_append_int_noprefix(table_data,
-                              object_property_get_int(OBJECT(s->pci), "addr",
-                                                      &error_abort), 2);
+    build_append_int_noprefix(table_data, iommu_devid, 2);
     /* Capability offset */
     build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
     /* IOMMU base address */
@@ -1947,10 +1946,9 @@ build_amd_iommu(GArray *table_data, BIOSLinker *linker, const char *oem_id,
 
     /* IVHD length */
     build_append_int_noprefix(table_data, ivhd_blob->len + 40, 2);
+
     /* DeviceID */
-    build_append_int_noprefix(table_data,
-                              object_property_get_int(OBJECT(s->pci), "addr",
-                                                      &error_abort), 2);
+    build_append_int_noprefix(table_data, iommu_devid, 2);
     /* Capability offset */
     build_append_int_noprefix(table_data, s->pci->capab_offset, 2);
     /* IOMMU base address */
-- 
MST


