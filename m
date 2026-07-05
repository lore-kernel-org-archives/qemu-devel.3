Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FD5AC43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 14:38:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgNvw-0005C4-2i; Sun, 05 Jul 2026 10:35:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNvu-0005Bt-Cf
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:34:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wgNvs-00017Y-LG
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 10:34:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783262096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NTRUDBx0gpZabdbM32vez4CHeJyZ2PohKLpfkYO6ixU=;
 b=dH0du0wI4Ny+IewM3XEpDMfx0BJRuSj+Ng8dFX8RiHyL2GLKpDFCrfixJ1Q7dn1nCvfXlf
 eMQnYLjMN3tc1CkV2WwjiWqiQkb1tguCa+3Wc326HIcprDiE1DMgUel/w22ZxZZS7t0wWF
 kHdSrOgXR0x2kuKrPzTlLc7RJtpFnWs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-TLB17nmYMyaxoHx6NrlFhw-1; Sun, 05 Jul 2026 10:34:54 -0400
X-MC-Unique: TLB17nmYMyaxoHx6NrlFhw-1
X-Mimecast-MFC-AGG-ID: TLB17nmYMyaxoHx6NrlFhw_1783262093
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47127ee7e07so1397340f8f.2
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 07:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783262093; x=1783866893; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NTRUDBx0gpZabdbM32vez4CHeJyZ2PohKLpfkYO6ixU=;
 b=l/bVARWjehPnBkvhVB58281+H6q6/OiUfQzhkOkaTdOljXdvJohv8mrjlHjLO18zAO
 kOrRNPL/ziwCk2LDBPdMqNQhhZQKWCAzu9uEuCqoayebNIDnmGy+kCAgegwIC68X/ldA
 zMB/+0OqlVRtE2vB9CPk2lQ7QbwsmG5rW8wE/vvXcugBYqEiiW4CLdwk95GwXM4mTjJl
 UFRlz972SSpskKV8JP8s7/QHOiE/7Tk9bEWTe3Vyu/zdBQcgyRdi4kwuWh2yQ986RORS
 ngIvuS6YFWHMRrlgMTWQZEUwwPxpOib/ELNqEd5qdtmXY6ifeNFrfFyoBUhDYkTwJFb2
 7AZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783262093; x=1783866893;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=NTRUDBx0gpZabdbM32vez4CHeJyZ2PohKLpfkYO6ixU=;
 b=fxpCPqk7F5oPiXXm/nUa72pzNTMHuuZBj3CMvzRI4ZdeV9PheujDSkge4KHKQSJkWf
 0g2X4x5jHLq9ftDGLm1J6lI3lyFDGjwu9QTk/Mso/Y3rov0HkhNwbF5bk5025YTwXjOl
 O80TKmK31HdTa5HW4nGnmGPaZmL71mo2EIQ0mG0sOxen4UGNmY5UPZ3DVq05Nh09tCRl
 fSCihQF2PsAsPJhHB1eAR7vncOoP7/3NEF1C793VWF/giSjadoCopo9iTqspIN7BOk0h
 l6lj1caRwRnA5W2NmUz3py6OwlyYW5RXUBQsWmTvd01oXM/j40jVbIWC1xci79wvko8j
 CPIw==
X-Gm-Message-State: AOJu0YyNifcSca3g6yTdLenGXs5zU1Hw8G8Em/lSk7jR5krZPtxgM/cj
 FYDKhofzzdyfWuBHTSx0WTl1Tpa00WwKciKWo9n5mQsGiasPNVQAYyBaJJ+ZxpiGv6WhDqpvIBH
 1PjEQgaC4+IWxFN72B198q6WObvseTp5c9dNbr0/Shqb/S4UHLkvycrPaUCjUbOXvhicA9oqSfa
 u+PaTCjWOeGNiXFHDuFT3Vcr/Ufart0viCEg==
X-Gm-Gg: AfdE7clXGR2t+QoneBOHdH7zmOW+/fJYE7EUNEFdCccxwvftJj5DUKT8ztypFi8nMYt
 +XoMxOu1BInWkzt4l7OrMWUaxp3UbrpFLPqyf6yIUoq/AQOzp8qXfnOYUtwx6fOhDKvW/1sgetE
 am7OPrV/uBBBs7ZzlcwIRUFo6bM5KOv0lKJtTX9LhvDQKW2F43aUN5RW8mPVn+k8jV6aq6Wy7SS
 BJPF9s+K+miDpoIiqOJ3xoeC2LSXv5b3GePLlyY3WMjkUWj3GuE6bPy99GCeZ65OZVQWfsOlFIP
 sHiqJQ/Ly6Kz26rM9aJlB66ioGIsw8jkKyzoCn+7jjPMOEZmQM+g9+Zl1tHyXDE3f9XjVNkQ281
 6pjq40GhNQ7LaaD90Dxi59Fhk+AwBsPBy
X-Received: by 2002:a05:6000:4203:b0:464:8d68:618a with SMTP id
 ffacd0b85a97d-47aaaec0251mr7606680f8f.32.1783262093320; 
 Sun, 05 Jul 2026 07:34:53 -0700 (PDT)
X-Received: by 2002:a05:6000:4203:b0:464:8d68:618a with SMTP id
 ffacd0b85a97d-47aaaec0251mr7606641f8f.32.1783262092719; 
 Sun, 05 Jul 2026 07:34:52 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039ae4fsm17086316f8f.18.2026.07.05.07.34.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 07:34:52 -0700 (PDT)
Date: Sun, 5 Jul 2026 10:34:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Sairaj Kodilkar <sarunkod@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 05/44] amd_iommu: Fix endianness handling for command buffer
 entries
Message-ID: <fdb2f65c513257c783aca6e031350e6d29f1e186.1783261895.git.mst@redhat.com>
References: <cover.1783261895.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1783261895.git.mst@redhat.com>
X-Mailer: git-send-email 2.51.2.2891.g4157995a80.dirty
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

AMD IOMMU command buffer entries are stored in guest memory in little-endian
format. Convert command buffer with le64_to_cpu() after dma_memory_read(),
so that command handlers can all operate using host native endianness.

Remove the cpu_to_le*() conversions from command handlers, since the values
are used internally by device emulation and do not need translation.
Conversion is only necessary when reading or writing to guest memory e.g.
writing completion-wait data and event log entries.

The flow for command buffer handling is:

- Retrieve command buffer (cmd[]) from guest memory (via dma_memory_read())
- Convert command buffer to host endianness (via le64_to_cpu())
- All handlers decode fields from cmd[] in host-endian format
- All emulation code uses decoded values in host-endian format
- Use cpu_to_le*() when writing back data to guest memory

Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260630220806.1758748-6-alejandro.j.jimenez@oracle.com>
---
 hw/i386/amd_iommu.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index c7bf21b762..90252c52af 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -278,6 +278,7 @@ static uint32_t get_next_eventlog_entry(AMDVIState *s)
 
 static void amdvi_log_event(AMDVIState *s, uint64_t *evt)
 {
+    uint64_t le_evt[2];
     uint32_t evtlog_tail_next;
 
     /* event logging not enabled */
@@ -298,8 +299,14 @@ static void amdvi_log_event(AMDVIState *s, uint64_t *evt)
         return;
     }
 
+    /*
+     * Convert event buffer to little-endian before writing it to guest memory.
+     */
+    le_evt[0] = cpu_to_le64(evt[0]);
+    le_evt[1] = cpu_to_le64(evt[1]);
+
     if (dma_memory_write(&address_space_memory, s->evtlog + s->evtlog_tail,
-                         evt, AMDVI_EVENT_LEN, MEMTXATTRS_UNSPECIFIED)) {
+                         le_evt, AMDVI_EVENT_LEN, MEMTXATTRS_UNSPECIFIED)) {
         trace_amdvi_evntlog_fail(s->evtlog, s->evtlog_tail);
     }
 
@@ -545,15 +552,18 @@ static void amdvi_update_iotlb(AMDVIState *s, uint16_t devid,
 static void amdvi_completion_wait(AMDVIState *s, uint64_t *cmd)
 {
     /* pad the last 3 bits */
-    hwaddr addr = cpu_to_le64(extract64(cmd[0], 3, 49)) << 3;
-    uint64_t data = cpu_to_le64(cmd[1]);
+    hwaddr addr = extract64(cmd[0], 3, 49) << 3;
+    uint64_t data = cmd[1];
+
+    /* Format the data to be written to guest memory as little-endian */
+    uint64_t le_data = cpu_to_le64(data);
 
     if (extract64(cmd[0], 52, 8)) {
         amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
                                    s->cmdbuf + s->cmdbuf_head);
     }
     if (extract64(cmd[0], 0, 1)) {
-        if (dma_memory_write(&address_space_memory, addr, &data,
+        if (dma_memory_write(&address_space_memory, addr, &le_data,
                              AMDVI_COMPLETION_DATA_SIZE,
                              MEMTXATTRS_UNSPECIFIED)) {
             trace_amdvi_completion_wait_fail(addr);
@@ -1281,7 +1291,7 @@ static void amdvi_update_addr_translation_mode(AMDVIState *s, uint16_t devid)
 /* log error without aborting since linux seems to be using reserved bits */
 static void amdvi_inval_devtab_entry(AMDVIState *s, uint64_t *cmd)
 {
-    uint16_t devid = cpu_to_le16((uint16_t)extract64(cmd[0], 0, 16));
+    uint16_t devid = extract64(cmd[0], 0, 16);
 
     trace_amdvi_devtab_inval(PCI_BUS_NUM(devid), PCI_SLOT(devid),
                              PCI_FUNC(devid));
@@ -1448,9 +1458,9 @@ static void amdvi_sync_domain(AMDVIState *s, uint16_t domid, uint64_t addr,
 /* we don't have devid - we can't remove pages by address */
 static void amdvi_inval_pages(AMDVIState *s, uint64_t *cmd)
 {
-    uint16_t domid = cpu_to_le16((uint16_t)extract64(cmd[0], 32, 16));
-    uint64_t addr = cpu_to_le64(extract64(cmd[1], 12, 52)) << 12;
-    uint16_t flags = cpu_to_le16((uint16_t)extract64(cmd[1], 0, 3));
+    uint16_t domid = extract64(cmd[0], 32, 16);
+    uint64_t addr = extract64(cmd[1], 12, 52) << 12;
+    uint16_t flags = extract64(cmd[1], 0, 3);
 
     if (extract64(cmd[0], 20, 12) || extract64(cmd[0], 48, 12) ||
         extract64(cmd[1], 3, 9)) {
@@ -1497,7 +1507,7 @@ static void amdvi_inval_inttable(AMDVIState *s, uint64_t *cmd)
 static void iommu_inval_iotlb(AMDVIState *s, uint64_t *cmd)
 {
 
-    uint16_t devid = cpu_to_le16(extract64(cmd[0], 0, 16));
+    uint16_t devid = extract64(cmd[0], 0, 16);
     if (extract64(cmd[1], 1, 1) || extract64(cmd[1], 3, 1) ||
         extract64(cmd[1], 6, 6)) {
         amdvi_log_illegalcom_error(s, extract64(cmd[0], 60, 4),
@@ -1509,7 +1519,7 @@ static void iommu_inval_iotlb(AMDVIState *s, uint64_t *cmd)
         g_hash_table_foreach_remove(s->iotlb, amdvi_iotlb_remove_by_devid,
                                     &devid);
     } else {
-        amdvi_iotlb_remove_page(s, cpu_to_le64(extract64(cmd[1], 12, 52)) << 12,
+        amdvi_iotlb_remove_page(s, extract64(cmd[1], 12, 52) << 12,
                                 devid);
     }
     trace_amdvi_iotlb_inval();
@@ -1527,6 +1537,15 @@ static void amdvi_cmdbuf_exec(AMDVIState *s)
         return;
     }
 
+    /*
+     * Commands in guest memory are little-endian. Convert once after reading
+     * so that command handlers can decode values in host native endianness.
+     * Convert back to little-endian only when writing data to guest memory via
+     * dma_memory_write().
+     */
+    cmd[0] = le64_to_cpu(cmd[0]);
+    cmd[1] = le64_to_cpu(cmd[1]);
+
     switch (extract64(cmd[0], 60, 4)) {
     case AMDVI_CMD_COMPLETION_WAIT:
         amdvi_completion_wait(s, cmd);
-- 
MST


