Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD9CC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 23:30:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubSMg-0004Lw-4i; Mon, 14 Jul 2025 19:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSJf-00064g-NN
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:10:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ubSJe-0006Fz-0n
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 19:10:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752534633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2+Hdc3Q1kzEjtmu1x2KZoQB+ra+Yvhw6yCMQj7TWWZk=;
 b=ZtUKS4MJB1xOXzwKYwbxU9rca/mK/Yg+UZyArr7n+ycst7liyUDKK5vq4YWYASzayVZ10Q
 juogYi4xsENPFo3/jUtMUwqWhhdiIdRa7JVzUHISPoGrMdYcDSnBeltpqs4uTOO9XKYEAy
 G78FScEzg/5H1TXU5/nsp2okW7nwfmo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-IayyownLOiOqz694ypz4QA-1; Mon, 14 Jul 2025 19:10:31 -0400
X-MC-Unique: IayyownLOiOqz694ypz4QA-1
X-Mimecast-MFC-AGG-ID: IayyownLOiOqz694ypz4QA_1752534631
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-451d30992bcso37920425e9.2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 16:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752534630; x=1753139430;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2+Hdc3Q1kzEjtmu1x2KZoQB+ra+Yvhw6yCMQj7TWWZk=;
 b=FDd1/DlXrMEZJYJAGDEv1aoGLr6CK8dJgLnec4lUsiyfSexL+Z5NILD/5Uu3hQ8F41
 sANjxHDj8xrq4021mbvBDQKXnhxBo1xcaYqb9HOqePDaAPzOEJMElCw2T5B/92Zf3IAx
 dFQDDM+8LPV4UlkjRyP+E85fzmfa3kcHYWUCApXq0Erck1jKuIxJZTTGOEMh2kvR5tmf
 lSiy978ofXvfZ6sof4gitm4bbpk/YGwD3A6dou94lDgAFNB6LJrO/do1BG/5yokxwF4K
 sdhIFxX1MRojqwXB1mwOOh25/XQrbNQoGXi0ljShRi3uQJv59DvB8hhX7zRTsXLh18HT
 OfMw==
X-Gm-Message-State: AOJu0YzfFGY+4K685ox3MnM0ZCrtcavSI33Pf8YOx9RYQAbWeve2yM1D
 bHmrYvOqb3riEjqJloAdh1ya22wbijE+D8ijwUk4YtdFz3YTwtkIBhdxhZGvRqzdL1jWu+DTLyx
 Lpi/EZVe2WopjWzX3Jl0CTL7fpIQAW2fjBVyXKMbr+K/8eJzf4DefXCJwZqgNi+YrzBAWvJjofN
 TgEyNxaVTazaRFuMlLJ/Ss0J9DF3LGZzXXcA==
X-Gm-Gg: ASbGnct+4NYzk8lfeuD0w7AjD59E8JF8gyfvxHXc022RBAIzrsqVkcBA1NFbAxsVWsy
 yCknaIy0C6rfiLIxOcqkUbh9Ikz0qIZaG1ZedFPrZWi1c6VGjCdc9Rn+h5UxsWdwvPBGfNYej7Z
 7+4B24efB9PPzmwVilVzBsbMfUTaygOjo9w0DBzIV4ywUnJUjya0gmhwmg+VaqIFM5IiwoJz9ww
 d8ioqHU6KNjjR3uLQ1tgrlQfeXFn0vxXI4sUZoWZqMsUJKVxe4rJsmvmsrRF4QdW68bp4UevKVJ
 ZOmbSypruoAwp19wi3UHGQBQZzT7sWua
X-Received: by 2002:a05:600c:468b:b0:453:1e14:6387 with SMTP id
 5b1f17b1804b1-456057c68bemr76241465e9.32.1752534630029; 
 Mon, 14 Jul 2025 16:10:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHt5bUFpQrzgBQZEdy/VP1cMAfSJs7Wr8A5rdg2Y8VRM1i1YrXXVpwn7IxVBxuA5aRF3p0Mvg==
X-Received: by 2002:a05:600c:468b:b0:453:1e14:6387 with SMTP id
 5b1f17b1804b1-456057c68bemr76241325e9.32.1752534629569; 
 Mon, 14 Jul 2025 16:10:29 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:150d:fc00:de3:4725:47c6:6809])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd17b7sm13550755f8f.11.2025.07.14.16.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 16:10:29 -0700 (PDT)
Date: Mon, 14 Jul 2025 19:10:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Anisa Su <anisa.su@samsung.com>, Fan Ni <fan.ni@samsung.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PULL 97/97] hw/cxl: mailbox-utils: 0x5605 - FMAPI Initiate DC Release
Message-ID: <77a8fbb887cb4c00be094aee839a42f72a850950.1752534227.git.mst@redhat.com>
References: <cover.1752534227.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1752534227.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

From: Anisa Su <anisa.su@samsung.com>

FM DCD Management command 0x5605 implemented per CXL r3.2 Spec Section 7.6.7.6.6

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Anisa Su <anisa.su@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Message-Id: <20250714174509.1984430-12-Jonathan.Cameron@huawei.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 88 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 5d08525529..68c7cc9891 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -124,6 +124,7 @@ enum {
         #define SET_DC_REGION_CONFIG        0x2
         #define GET_DC_REGION_EXTENT_LIST   0x3
         #define INITIATE_DC_ADD             0x4
+        #define INITIATE_DC_RELEASE         0x5
 };
 
 /* CCI Message Format CXL r3.1 Figure 7-19 */
@@ -3645,6 +3646,86 @@ static CXLRetCode cmd_fm_initiate_dc_add(const struct cxl_cmd *cmd,
     }
 }
 
+#define CXL_EXTENT_REMOVAL_POLICY_MASK 0x0F
+#define CXL_FORCED_REMOVAL_MASK (1 << 4)
+/*
+ * CXL r3.2 Section 7.6.7.6.6:
+ * Initiate Dynamic Capacity Release (Opcode 5605h)
+ */
+static CXLRetCode cmd_fm_initiate_dc_release(const struct cxl_cmd *cmd,
+                                             uint8_t *payload_in,
+                                             size_t len_in,
+                                             uint8_t *payload_out,
+                                             size_t *len_out,
+                                             CXLCCI *cci)
+{
+    struct {
+        uint16_t host_id;
+        uint8_t flags;
+        uint8_t reg_num;
+        uint64_t length;
+        uint8_t tag[0x10];
+        uint32_t ext_count;
+        CXLDCExtentRaw extents[];
+    } QEMU_PACKED *in = (void *)payload_in;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    int i, rc;
+
+    switch (in->flags & CXL_EXTENT_REMOVAL_POLICY_MASK) {
+        case CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE: {
+            CXLDCExtentList updated_list;
+            uint32_t updated_list_size;
+            g_autofree CXLUpdateDCExtentListInPl *list =
+                g_malloc0(sizeof(*list) +
+                    in->ext_count * sizeof(*list->updated_entries));
+
+            convert_raw_extents(in->extents, list, in->ext_count);
+            rc = cxl_detect_malformed_extent_list(ct3d, list);
+            if (rc) {
+                return rc;
+            }
+
+            /*
+             * Fail with Invalid PA if an extent is pending and Forced Removal
+             * flag not set.
+             */
+            if (!(in->flags & CXL_FORCED_REMOVAL_MASK)) {
+                for (i = 0; i < in->ext_count; i++) {
+                    CXLDCExtentRaw ext = in->extents[i];
+                    /*
+                     * Check requested extents don't overlap with pending
+                     * extents.
+                     */
+                    if (cxl_extent_groups_overlaps_dpa_range(
+                            &ct3d->dc.extents_pending,
+                            ext.start_dpa,
+                            ext.len)) {
+                        return CXL_MBOX_INVALID_PA;
+                    }
+                }
+            }
+
+            rc = cxl_dc_extent_release_dry_run(ct3d,
+                                               list,
+                                               &updated_list,
+                                               &updated_list_size);
+            if (rc) {
+                return rc;
+            }
+            cxl_create_dc_event_records_for_extents(ct3d,
+                                                    DC_EVENT_RELEASE_CAPACITY,
+                                                    in->extents,
+                                                    in->ext_count);
+            return CXL_MBOX_SUCCESS;
+        }
+        default: {
+            qemu_log_mask(LOG_UNIMP,
+                "CXL extent removal policy not supported.\n");
+            return CXL_MBOX_INVALID_INPUT;
+        }
+    }
+}
+
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
         cmd_infostat_bg_op_abort, 0, 0 },
@@ -3779,6 +3860,13 @@ static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
         CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
+    [FMAPI_DCD_MGMT][INITIATE_DC_RELEASE] = { "INIT_DC_RELEASE",
+        cmd_fm_initiate_dc_release, ~0,
+        (CXL_MBOX_CONFIG_CHANGE_COLD_RESET |
+         CXL_MBOX_CONFIG_CHANGE_CONV_RESET |
+         CXL_MBOX_CONFIG_CHANGE_CXL_RESET |
+         CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
+         CXL_MBOX_IMMEDIATE_DATA_CHANGE) },
 };
 
 /*
-- 
MST


