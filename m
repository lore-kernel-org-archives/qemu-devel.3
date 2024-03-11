Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E00EC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 12:35:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjery-0000rN-2o; Mon, 11 Mar 2024 08:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rjerw-0000qt-Fb
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 08:35:04 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rjert-0002uu-TX
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 08:35:04 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4132a436086so5034865e9.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 05:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.com; s=google; t=1710160499; x=1710765299; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=rlPMa/qxborM8s490ri7DT2VZROhH4ERuCvOsPfS7eM=;
 b=nebDNmtvU+MUtZa0vwbQWpiRKlEScf6PZDcA9E7h/VqFsHROdTOxhtYXeccjkobvGl
 iHy6c3UQ0aryo3MYSiprVqW2KtD0lN/AerOXNe3foVZtDVjcbvlKLvyaYUAvg1CCBoaz
 Kt347vb0ucoyRoMwvPkUndKLIsIzKxz/On8rY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710160499; x=1710765299;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rlPMa/qxborM8s490ri7DT2VZROhH4ERuCvOsPfS7eM=;
 b=lXT3zmI7aU7kr4V+Elp2C5WOLZq/BlzH7sPZyPEKd9EGpMBPjGu7CSClRaLNJwh6Q1
 iRnvsu+umFosI5YmVJdXu1LEpX9JtOVOdd7r0n5pFdhi23bg/LrT91h8SPBZyTXK3g8L
 6FTJANeu4g7dTzBtEPjc69/1mxlfqASaaQVuM0/aArx0bzWHS0NA1OQJi0g+BeI8hqUR
 iVRQWn14dptpfxABL51FvQTc0vvJsX8WvbFfUR91bRuSPfb5MeyHrFcFx3yqFdx4QKc4
 KdbSM8dtjfh7ZKqtV1yNjj+V3CyE86BnZZl1yspGdDfV9ZF5rlaA2WDZ2nCJJhkOGrNK
 N80A==
X-Gm-Message-State: AOJu0Yx//8vGhp/q9uM/RvEyHAUjmC0E9Xdn+cwBMks3QeXN2U/SYK3k
 eg5LIGtOFll3OgLU+/h94gWkM9KX/NCGJPRwoqRgFcCCNoBdY37Mfl8lpj5IbKaTYtl7TLa0USk
 k
X-Google-Smtp-Source: AGHT+IGNVDb7sZG1ocbqJS/Hcf9B2VYTyLUFbrcHqEdOixXYj4DfOL6lzVnqAqkk11Sq1GbhwaJIAw==
X-Received: by 2002:a05:600c:3f90:b0:413:28ee:22e5 with SMTP id
 fs16-20020a05600c3f9000b0041328ee22e5mr2266589wmb.23.1710160499262; 
 Mon, 11 Mar 2024 05:34:59 -0700 (PDT)
Received: from localhost.localdomain
 (cpc92320-cmbg19-2-0-cust35.5-4.cable.virginm.net. [82.13.64.36])
 by smtp.gmail.com with ESMTPSA id
 c6-20020a05600c0a4600b00412f2136793sm15792639wmq.44.2024.03.11.05.34.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Mar 2024 05:34:58 -0700 (PDT)
From: Anthony PERARD <anthony.perard@citrix.com>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH] migration: Fix format in error message
Date: Mon, 11 Mar 2024 12:34:39 +0000
Message-Id: <20240311123439.16844-1-anthony.perard@citrix.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=anthony.perard@cloud.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.029,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

From: Anthony PERARD <anthony.perard@citrix.com>

In file_write_ramblock_iov(), "offset" is "uintptr_t" and not
"ram_addr_t". While usually they are both equivalent, this is not the
case with CONFIG_XEN_BACKEND.

Use the right format. This will fix build on 32-bit.

Fixes: f427d90b9898 ("migration/multifd: Support outgoing mapped-ram stream format")
Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
---
 migration/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/migration/file.c b/migration/file.c
index 164b079966..5054a60851 100644
--- a/migration/file.c
+++ b/migration/file.c
@@ -191,7 +191,7 @@ int file_write_ramblock_iov(QIOChannel *ioc, const struct iovec *iov,
          */
         offset = (uintptr_t) iov[slice_idx].iov_base - (uintptr_t) block->host;
         if (offset >= block->used_length) {
-            error_setg(errp, "offset " RAM_ADDR_FMT
+            error_setg(errp, "offset %" PRIxPTR
                        "outside of ramblock %s range", offset, block->idstr);
             ret = -1;
             break;
-- 
Anthony PERARD


