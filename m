Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8997CCCD182
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Oct 2025 19:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5UFv-0004pp-VR; Sun, 05 Oct 2025 15:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFO-0002Pt-NH
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v5UFG-0006ao-1W
 for qemu-devel@nongnu.org; Sun, 05 Oct 2025 15:18:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759691887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xISYYcoFQClxd+HhqK447x/hInZXjtzJhdgWUsDmah0=;
 b=dfE/Ej2WVPPZTKJFiFN6OXH2tiKJyhjvpE0+MSxriLKuWvjsW2FJlT84E9YnxYPgEkXvy/
 hmgLuwXTbZIvGZCYwRTImncqrAgEaqdToUac9A8U/QxSxiwTu/kHHX/3lbrgSJOFaZ9K/f
 J3kRkAe+Ohg6AxtI4fHISVh3kcfZdvY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-s5lP3ZJtM2OrP1MpSwT0Cw-1; Sun, 05 Oct 2025 15:18:05 -0400
X-MC-Unique: s5lP3ZJtM2OrP1MpSwT0Cw-1
X-Mimecast-MFC-AGG-ID: s5lP3ZJtM2OrP1MpSwT0Cw_1759691884
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3f6b44ab789so2162726f8f.3
 for <qemu-devel@nongnu.org>; Sun, 05 Oct 2025 12:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759691882; x=1760296682;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xISYYcoFQClxd+HhqK447x/hInZXjtzJhdgWUsDmah0=;
 b=UdKTZXr2QK7Xai2IL9hw6OzYQ2j0zs83LEJ70p8lHci7jihIosVAvEV4gcezI4HjRG
 c504+BZ0mHzUvcybf3SHBL2lg/uIANwdI0FXFZtgd22tJr8TevuNpwPbLwttlHMpdYsn
 PCIw8mHDLAz6VNWtntu+K2mi2v6AwKRbHmr1qz/ZB7VtN1tphBUWVKh0C+CWjkadHtm6
 94DNv06gVTS8MVPpouFFSJbAUtOJ0EgFlULS9cmWz/82rqt1CEwVuEUHhhFWwp7q8LMW
 LCcxEZYAeIUNc05xCZfSf7lw1124tWojXUZjZbA5/2e7tEC1aJ3hFLFyo9B1OJ+r1wMZ
 W2CA==
X-Gm-Message-State: AOJu0YwwJHNpYc/qFYeCI8mnCuM/Mjvdgh675nP/uOUkcwxKMwgsuMUy
 /PDFfLsK/1/c7WZBP0k/0PoD1atQwzfePUYz02Vi+jvJhdbSv2A3rRGTEQElhq976rHyPxcaQJc
 flk5oJ2gqb4gXw0FAdiELF0kEXCV7r+3UUxO0I98k7zleBhQJNtjH8blTky1AriSxY1KINfCRm/
 82ujeq/06jaZz5CcIE1GhZVLPko0hhDG0vGA==
X-Gm-Gg: ASbGncu64Uw4hpQsA8r8XeoX9mybrZedi7YPUUYIXlMzPKO79uGAJDZVXzhGbJEQhve
 KKTf48+k9/tbL884Z+Vd2K+frmijAcxOVzAhtjQDNrTPkGXOxS6gyAN0Zw+fhEthATENSt5Ag0s
 Gnv4LbhpTQhNby077zankuhwxKd9lECt9h4n8EpT3tr6lp0hIia5CGG1dH8s/2dbbFdkAZG8r76
 uJq0WRPoBogan8+qIH7ObFOymHmKNAbDu8aQymk0CsUUfCc5w4r/IlEgP+jNb5uQ8YROzhpmxsv
 afrllE94BR+CNE1OcDC9wLeAMtSu5oAmEhKNtlE=
X-Received: by 2002:a05:6000:4305:b0:3eb:f3de:1a87 with SMTP id
 ffacd0b85a97d-425671c2042mr7574172f8f.56.1759691882374; 
 Sun, 05 Oct 2025 12:18:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwEnfi+OQJQCIiHpszPDOslfe2htzVCaY0Egr9eRwQ71+9kPsCgvdvUgIWNXlilAnlb9xoVw==
X-Received: by 2002:a05:6000:4305:b0:3eb:f3de:1a87 with SMTP id
 ffacd0b85a97d-425671c2042mr7574149f8f.56.1759691881727; 
 Sun, 05 Oct 2025 12:18:01 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1518:6900:b69a:73e1:9698:9cd3])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8a6c3esm17619080f8f.1.2025.10.05.12.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Oct 2025 12:18:01 -0700 (PDT)
Date: Sun, 5 Oct 2025 15:17:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PULL 53/75] amd_iommu: Helper to decode size of page invalidation
 command
Message-ID: <717d2f8805558ec39604c201bcbe3b36be2904db.1759691708.git.mst@redhat.com>
References: <cover.1759691708.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1759691708.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.43,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>

The size of the region to invalidate depends on the S bit and address
encoded in the command. Add a helper to extract this information, which
will be used to sync shadow page tables in upcoming changes.

Signed-off-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20250919213515.917111-5-alejandro.j.jimenez@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/i386/amd_iommu.h |  4 ++++
 hw/i386/amd_iommu.c | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 2476296c49..c1170a8202 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -126,6 +126,10 @@
 #define AMDVI_CMD_COMPLETE_PPR_REQUEST    0x07
 #define AMDVI_CMD_INVAL_AMDVI_ALL         0x08
 
+
+#define AMDVI_CMD_INVAL_IOMMU_PAGES_S   (1ULL << 0)
+#define AMDVI_INV_ALL_PAGES             (1ULL << 52)
+
 #define AMDVI_DEVTAB_ENTRY_SIZE           32
 
 /* Device table entry bits 0:63 */
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 3cbc9499db..202f0f8c6e 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -577,6 +577,40 @@ static gboolean amdvi_iotlb_remove_by_domid(gpointer key, gpointer value,
     return entry->domid == domid;
 }
 
+/*
+ * Helper to decode the size of the range to invalidate encoded in the
+ * INVALIDATE_IOMMU_PAGES Command format.
+ * The size of the region to invalidate depends on the S bit and address.
+ * S bit value:
+ * 0 :  Invalidation size is 4 Kbytes.
+ * 1 :  Invalidation size is determined by first zero bit in the address
+ *      starting from Address[12].
+ *
+ * In the AMD IOMMU Linux driver, an invalidation command with address
+ * ((1 << 63) - 1) is sent when intending to clear the entire cache.
+ * However, Table 14: Example Page Size Encodings shows that an address of
+ * ((1ULL << 51) - 1) encodes the entire cache, so effectively any address with
+ * first zero at bit 51 or larger is a request to invalidate the entire address
+ * space.
+ */
+static uint64_t __attribute__((unused))
+amdvi_decode_invalidation_size(hwaddr addr, uint16_t flags)
+{
+    uint64_t size = AMDVI_PAGE_SIZE;
+    uint8_t fzbit = 0;
+
+    if (flags & AMDVI_CMD_INVAL_IOMMU_PAGES_S) {
+        fzbit = cto64(addr | 0xFFF);
+
+        if (fzbit >= 51) {
+            size = AMDVI_INV_ALL_PAGES;
+        } else {
+            size = 1ULL << (fzbit + 1);
+        }
+    }
+    return size;
+}
+
 /* we don't have devid - we can't remove pages by address */
 static void amdvi_inval_pages(AMDVIState *s, uint64_t *cmd)
 {
-- 
MST


