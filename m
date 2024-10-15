Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C25D1F9C2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2024 19:03:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t0mox-0001Wg-73; Tue, 15 Oct 2024 15:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1t0mov-0001WV-1o
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 15:03:01 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1t0moq-00089r-Ik
 for qemu-devel@nongnu.org; Tue, 15 Oct 2024 15:03:00 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-71e52582cf8so2219118b3a.2
 for <qemu-devel@nongnu.org>; Tue, 15 Oct 2024 12:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729018974; x=1729623774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tRhqJ20pk83iDSj5hmw7CzhffO/7S9pA+eX7u2uLFo4=;
 b=BKwbZJv3syeMcKPOZGetukVYChWU/wB/W2thdBWTVVcafyGftJSbRMxZTPe1YzRLzS
 vmimw4oWVDngBxosV/Qa2hB0SRVW5FGFvlBb+OSdKXw8oHmIAmcyClAkf9MYFq2wWaMv
 TIVY1b5i3OORosCaGMs+7U1WCOUUEXwh5k60vNCsrGblMcZSe/qEVWg9yq+BkSOBLHCB
 ODFYHlXBal/iGH21aI7+iv4J2kBt+Cel5P+SCbz5qsp/YQQqAWyZ5F0LEDtK/9J3DR4l
 wCi45TJZihZ7iOh1KirkZc/9ibeEBDYQe5dWC7FTRt+K1M1c7q79mapuDyqz27M+DBHp
 MXkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729018974; x=1729623774;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tRhqJ20pk83iDSj5hmw7CzhffO/7S9pA+eX7u2uLFo4=;
 b=r2rQYImfWup6Evhrs2YlcKH5I4Ccir5TZoMy16gZ0gjzMEgektZ3hrIO0mm0W+DuBZ
 CWNLBM3LtnbGT7aycDW23RxnpdjkT04OcWzQqQwe/JmmnFtDbbWIxZfu/lvZuUM1nLTy
 ewTFXbgZEhSq+3pgudskbDNzwr2QpFTaJ0ElY9EvD1APTJ+j+zGKb/PsifO+Hs5l+hk2
 Zx0lnRGC6FsGyeIMsUUtYNgp8uG5BBShjhHPP/bqvfKMj58I8YiydJUw3frKKsQkxzR2
 APl/bYcb48dvpGRCZVMgLlMzbVPUw0pi3YMcI2xlj5hp6AvLtb5xNewbabwEC+KsFDTv
 2g5Q==
X-Gm-Message-State: AOJu0Yzjkuo0SGJmNCcgVS4ymfHQ3DsBm7fBDwz7kDgi4W4O0TDlJqF4
 liA+/k/9JM8tfnZ1QTtORRM1teWJqf+z86rM+H214FaMTY6K8jYVZCCxKg==
X-Google-Smtp-Source: AGHT+IGc5YPaHVYzT8+gN6wEAfeb43XjrNCWb44uNxhvH+Z50BWjZbe0gjt5jCjBlP8uQMLOcGpfLw==
X-Received: by 2002:a05:6a00:2e97:b0:71e:cc7:c507 with SMTP id
 d2e1a72fcca58-71e4c1cf183mr22748548b3a.23.1729018974328; 
 Tue, 15 Oct 2024 12:02:54 -0700 (PDT)
Received: from fan.. ([2601:646:8f03:9fee:b98e:93ee:91b1:1c18])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7ea9c6d3fe9sm1707165a12.51.2024.10.15.12.02.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Oct 2024 12:02:54 -0700 (PDT)
From: nifan.cxl@gmail.com
To: qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 ira.weiny@intel.com, dan.j.williams@intel.com, a.manzanares@samsung.com,
 dave@stgolabs.net, nmtadam.samsung@gmail.com, nifan.cxl@gmail.com,
 Fan Ni <fan.ni@samsung.com>
Subject: [QEMU PATCH] hw/cxl/cxl-mailbox-util: Fix output buffer index update
 when retrieving DC extents
Date: Tue, 15 Oct 2024 11:51:26 -0700
Message-ID: <20241015190224.251293-1-nifan.cxl@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

In the function of retrieving DC extents (cmd_dcd_get_dyn_cap_ext_list),
the output buffer index was not correctly updated while iterating the
extent list on the device, leaving the extents returned incorrect except for
the first one.

Fixes: 1c9221f19e ("hw/mem/cxl_type3: Add DC extent list representative ...")
Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index c82ad50ac8..58f8930272 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -2233,6 +2233,7 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
             stw_le_p(&out_rec->shared_seq, ent->shared_seq);
 
             record_done++;
+            out_rec++;
             if (record_done == record_count) {
                 break;
             }
-- 
2.43.0


