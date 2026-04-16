Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C556F8E489
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 22:38:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDVLa-0007nc-W5; Thu, 16 Apr 2026 18:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aaron1esau@gmail.com>)
 id 1wDSzq-00022x-6T
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 16:07:30 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aaron1esau@gmail.com>)
 id 1wDSzo-0000IL-7Q
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 16:07:29 -0400
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7dbcb45153cso1095689a34.3
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 13:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776370047; x=1776974847; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p1WMxWJyeutL6cak8qb7wJqgMiroiOZ8xYTt72hdlKY=;
 b=oDpgxx9xZtVGiuxketHDxRymZbivvO37kZ+V08ms2IIhigr8FBTjLEw0B2nIBrb1Tc
 W9rz67KQ20E0f55Of6eCvkJC9FAn2yUaTtm51FBCJeJaP96ZnNoBvhyX9nqQRx75ptsK
 0Q1PbUubHjbCtXBNRyB8lGtvKIuFILlIF0xsGGk2R+CY317Q79IKHPApNwFpujXzxV21
 DsH+WR1tzRydQfLnyH+XQhyy/p4Z7vmMsXaWq5MGxwGY4fLTqiAjXsQFZsMuvCxozvvI
 4bzlt+of+eqDdPQ7rcRED3fTApVn2tK5+acatY8kSh55B7RP7mhdtUh5Ejn8q49Si9nP
 8pDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776370047; x=1776974847;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p1WMxWJyeutL6cak8qb7wJqgMiroiOZ8xYTt72hdlKY=;
 b=cBcH2S/YKDEWgtWplVgYKN9ZfKlLcAJEV+Q3dQr3/Fs/1MrORdQZ17ObSVwEG6RCcB
 46zpEu5Wg1TYlFtB4M7UZQZJJfKx97go3Rf74zeZfeykXP7omgyhJ2PDKY+7HbaBgrmt
 nQKXGp1nD7mZrmbb41cAuE6x+Lqho2DENgn0M54xFvOWWZthH2csBco9qZwgjxvzWwZg
 ESxnWW52pLGlcE0zou7Bh+jc6uCsLqE4Y1LLMnEcZwVVbuVTIMVNqt2w2pJ6rjc1w3YK
 j89oTCZhBCBkO7NoGE7uSyHJy4zBn+dzc+UAVuj9/GHBH8eHe3cNkqs52aEh9ffDcqck
 wM4w==
X-Gm-Message-State: AOJu0YxudmCcReIm9TuLk98tOvWXTWlNesbxm7UXnGCfRFWpe88Qat2E
 ktOArds9MlXh3C/LslI1tb9fjmK6yh+Z8NULGotNPnwhr5u9OHFYu15Z+rABOaog
X-Gm-Gg: AeBDievAnOWwE4JFR1mVQZ5ctpZIwilSS9kq8cPWHAf92jCnYzrSxsd6inGRZOmY0cj
 fQgrDYq38OHVV9iaWMLf/1HRkbOlNgoFnQYHdh3nM65Rm/h7j7v91qV2JsaIFj8KrKlJVGRfe5k
 WUy7chtyobKgBcsTpSIluNCr0TlQ5bpObhNyeEiY742MsfHA1xj5AGrmxhrX+iJ1i+AZD82nWc4
 Vsw3NrZ+Zo2ajHwA4n3+fRciwShIuQXzJ53yxAbvoN31RXvoL3d2FnNdoSyIFszIYkBX906boV9
 lyIkf+FnUuNaCQlcrawnNm7BR7Q17AcWaIQCjmymEx08iWUxQvB5G03/njpTbTN3jNgeucqAcam
 4T9VNAH+l68lOpdrDBeMGCsZGuttbg6SaAtqw/Z5pi/DqXvqqHFirGdo7YXZg3j3QEEzzjJvvb1
 WmO7GSZBwt1bJxcQhJuEEyWqSh+DSqv5JdcH1aGW6eFhbvx3KGH+/m7yziDw4UZxEoQo3lk0H7s
 V6812JpXcmlJRc/w7FUgrZWECqaXNCbfpo=
X-Received: by 2002:a05:6830:411d:b0:7d7:e695:93b8 with SMTP id
 46e09a7af769-7dc926d2605mr324081a34.5.1776370046849; 
 Thu, 16 Apr 2026 13:07:26 -0700 (PDT)
Received: from localhost ([136.49.184.116]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7dc90a5ef51sm633330a34.9.2026.04.16.13.07.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 13:07:26 -0700 (PDT)
From: Aaron Esau <aaron1esau@gmail.com>
X-Google-Original-From: Aaron Esau <git@aaronesau.com>
To: qemu-devel@nongnu.org
Cc: Jonathan.Cameron@huawei.com, jic23@kernel.org, berrange@redhat.com,
 Aaron Esau <aaron1esau@gmail.com>, qemu-stable@nongnu.org
Subject: [PATCH 2/2] hw/cxl: add missing bounds checks in Set Feature for PPR
 and sparing
Date: Thu, 16 Apr 2026 15:07:02 -0500
Message-ID: <20260416200702.2374709-3-git@aaronesau.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416200702.2374709-1-git@aaronesau.com>
References: <20260416200702.2374709-1-git@aaronesau.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::329;
 envelope-from=aaron1esau@gmail.com; helo=mail-ot1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 16 Apr 2026 18:38:06 -0400
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

From: Aaron Esau <aaron1esau@gmail.com>

cmd_features_set_feature() is missing bounds validation on the offset and
data length for several feature UUIDs before their memcpy calls. The
patrol_scrub and ecs cases correctly check:

    if ((uint32_t)hdr->offset + bytes_to_copy >
        sizeof(ct3d->..._wr_attrs))
        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;

But the soft_ppr, hard_ppr, cacheline_sparing, row_sparing,
bank_sparing, and rank_sparing cases are missing this check. Since
bytes_to_copy is derived from the full mailbox payload length (up to
2048 bytes) and the write-attribute structs are only a few bytes each,
a guest can overflow into adjacent CXLType3Dev fields.

Add the same bounds check pattern to all six affected feature handlers.

Cc: qemu-stable@nongnu.org
Fixes: 5e5a86bab8 ("hw/cxl: Add support for Maintenance command and Post Package Repair (PPR)")
Fixes: da5cafdc4d ("hw/cxl: Add emulation for memory sparing control feature")
Reported-by: Aaron Esau <aaron1esau@gmail.com>
Signed-off-by: Aaron Esau <aaron1esau@gmail.com>
---
 hw/cxl/cxl-mailbox-utils.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 0adf1e72c8..5fabfcbbab 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1814,6 +1814,11 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
+        if ((uint32_t)hdr->offset + bytes_to_copy >
+            sizeof(ct3d->soft_ppr_wr_attrs)) {
+            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+        }
+
         memcpy((uint8_t *)&ct3d->soft_ppr_wr_attrs + hdr->offset,
                sppr_write_attrs, bytes_to_copy);
         set_feat_info->data_size += bytes_to_copy;
@@ -1833,6 +1838,11 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
+        if ((uint32_t)hdr->offset + bytes_to_copy >
+            sizeof(ct3d->hard_ppr_wr_attrs)) {
+            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+        }
+
         memcpy((uint8_t *)&ct3d->hard_ppr_wr_attrs + hdr->offset,
                hppr_write_attrs, bytes_to_copy);
         set_feat_info->data_size += bytes_to_copy;
@@ -1852,6 +1862,11 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
+        if ((uint32_t)hdr->offset + bytes_to_copy >
+            sizeof(ct3d->cacheline_sparing_wr_attrs)) {
+            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+        }
+
         memcpy((uint8_t *)&ct3d->cacheline_sparing_wr_attrs + hdr->offset,
                mem_sparing_write_attrs, bytes_to_copy);
         set_feat_info->data_size += bytes_to_copy;
@@ -1870,6 +1885,11 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
+        if ((uint32_t)hdr->offset + bytes_to_copy >
+            sizeof(ct3d->row_sparing_wr_attrs)) {
+            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+        }
+
         memcpy((uint8_t *)&ct3d->row_sparing_wr_attrs + hdr->offset,
                mem_sparing_write_attrs, bytes_to_copy);
         set_feat_info->data_size += bytes_to_copy;
@@ -1888,6 +1908,11 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
+        if ((uint32_t)hdr->offset + bytes_to_copy >
+            sizeof(ct3d->bank_sparing_wr_attrs)) {
+            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+        }
+
         memcpy((uint8_t *)&ct3d->bank_sparing_wr_attrs + hdr->offset,
                mem_sparing_write_attrs, bytes_to_copy);
         set_feat_info->data_size += bytes_to_copy;
@@ -1906,6 +1931,11 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             return CXL_MBOX_UNSUPPORTED;
         }
 
+        if ((uint32_t)hdr->offset + bytes_to_copy >
+            sizeof(ct3d->rank_sparing_wr_attrs)) {
+            return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+        }
+
         memcpy((uint8_t *)&ct3d->rank_sparing_wr_attrs + hdr->offset,
                mem_sparing_write_attrs, bytes_to_copy);
         set_feat_info->data_size += bytes_to_copy;
-- 
2.53.0


