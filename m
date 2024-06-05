Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FFAC25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 23:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF0BF-0006yI-F7; Wed, 05 Jun 2024 19:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0BE-0006sE-9y
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:36:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sF0BC-0005sH-M1
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 19:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717630590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QuE+o0AC9wdLKXlzVTnODsdNe5/ti8zXK/7OKFfOYUM=;
 b=fZzzDE7ayuDzpcUHa7CTM4N3nhfjtg8hZoph8url2s5tl75o/8Z7NlUQU/VcfdDlR5RgV+
 VK069ly/d3/AOisNXHzFykRit0WXvv3UiNayFTqDkNevFcExVUiGxIgSR/X8kLwIrcUYIP
 ngsh2Oti0batk2sOWuDtFz6TwYP9x8E=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-lZ7d28d5MfSUjS6Crv3nUQ-1; Wed, 05 Jun 2024 19:36:28 -0400
X-MC-Unique: lZ7d28d5MfSUjS6Crv3nUQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-57a941a787dso375941a12.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 16:36:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717630587; x=1718235387;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QuE+o0AC9wdLKXlzVTnODsdNe5/ti8zXK/7OKFfOYUM=;
 b=FlmtjvdzEL4FCZSPe81Kkt225nw5HShfbtYWvmke7JoRt/7gd+wVmp/lgNxVvuK2GH
 buFBM9QQTSa84LNK8kkjkb2tMM7yso1NTnTZqQsplcjUg3FYgNW6vKZAgPTlETMIBp6s
 +DELTVRXxdLz5rYk3pk5IFptcCmKzAbgy4UlaqZSaApO6DeXgBDWYpwkABCCE5Lna+Bt
 9A6qWIUOtinJWn2L+xgPpxXiYd5ay4hU+CF8XjNMmyVhDZEW3ljn/1MC1sUkND4IS9iT
 4U0Aqrhw/GqK+nmrDGBJHC5oRv09a/naV9cKOa9XISIhWGaIpdE13atgRgJpGSu9yvHG
 709Q==
X-Gm-Message-State: AOJu0YzLKj/RryuusXtJ8u9Gr1K0nV+F1Kt4H2JyJ0BapklnpoWLGnPO
 qFVZLO/W3rUQzx5l9WHlJjG4Ow7D0fwpkIKQpq0tC8/zLP9KNbGCK0ByilOu/BfEXtz7RCvEYV/
 0oiXhNYKhg4wvlPDHCcyYzaivAByvbrbSi89TKQO+hyGjo6PTHH0tvf4dB4XMKEpCHP6QrmF2Ou
 g5/MSFiA2vTaHEJRK3305iohkzq5Kmog==
X-Received: by 2002:a50:bb03:0:b0:57a:1c44:581c with SMTP id
 4fb4d7f45d1cf-57a8bc91223mr3180058a12.32.1717630587196; 
 Wed, 05 Jun 2024 16:36:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUGQTqUQCcPO2wRAfy0GXBR/uwMiRv5mZR6w2lI9QLLukUeSoiVCPlO/QrFqi1VcYrG4916g==
X-Received: by 2002:a50:bb03:0:b0:57a:1c44:581c with SMTP id
 4fb4d7f45d1cf-57a8bc91223mr3180040a12.32.1717630586655; 
 Wed, 05 Jun 2024 16:36:26 -0700 (PDT)
Received: from redhat.com ([2.55.56.67]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57aae23a0d7sm91917a12.95.2024.06.05.16.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 16:36:26 -0700 (PDT)
Date: Wed, 5 Jun 2024 19:36:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>,
 Svetly Todorov <svetly.todorov@memverge.com>,
 Gregory Price <gregory.price@memverge.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: [PULL v3 28/41] hw/cxl/cxl-mailbox-utils: Add superset extent
 release mailbox support
Message-ID: <b841f6e53e910d412a8b8c96489841490e5b67d9.1717630437.git.mst@redhat.com>
References: <cover.1717630437.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1717630437.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Fan Ni <fan.ni@samsung.com>

With the change, we extend the extent release mailbox command processing
to allow more flexible release. As long as the DPA range of the extent to
release is covered by accepted extent(s) in the device, the release can be
performed.

Tested-by: Svetly Todorov <svetly.todorov@memverge.com>
Reviewed-by: Gregory Price <gregory.price@memverge.com>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
Message-Id: <20240523174651.1089554-14-nifan.cxl@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/cxl/cxl-mailbox-utils.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index c4852112fe..74eeb6fde7 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1704,6 +1704,13 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
         dpa = in->updated_entries[i].start_dpa;
         len = in->updated_entries[i].len;
 
+        /* Check if the DPA range is not fully backed with valid extents */
+        if (!ct3_test_region_block_backed(ct3d, dpa, len)) {
+            ret = CXL_MBOX_INVALID_PA;
+            goto free_and_exit;
+        }
+
+        /* After this point, extent overflow is the only error can happen */
         while (len > 0) {
             QTAILQ_FOREACH(ent, updated_list, node) {
                 range_init_nofail(&range, ent->start_dpa, ent->len);
@@ -1718,14 +1725,7 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
                     if (range_contains(&range, dpa + len - 1)) {
                         len2 = ent_start_dpa + ent_len - dpa - len;
                     } else {
-                        /*
-                         * TODO: we reject the attempt to remove an extent
-                         * that overlaps with multiple extents in the device
-                         * for now. We will allow it once superset release
-                         * support is added.
-                         */
-                        ret = CXL_MBOX_INVALID_PA;
-                        goto free_and_exit;
+                        dpa = ent_start_dpa + ent_len;
                     }
                     len_done = ent_len - len1 - len2;
 
@@ -1752,14 +1752,9 @@ static CXLRetCode cxl_dc_extent_release_dry_run(CXLType3Dev *ct3d,
                     }
 
                     len -= len_done;
-                    /* len == 0 here until superset release is added */
                     break;
                 }
             }
-            if (len) {
-                ret = CXL_MBOX_INVALID_PA;
-                goto free_and_exit;
-            }
         }
     }
 free_and_exit:
-- 
MST


