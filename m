Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF0FC44515
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 20:12:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wluL9-00065X-UU; Mon, 20 Jul 2026 16:11:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wluL7-00063c-Dn
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 16:11:49 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1wluL5-00065l-VI
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 16:11:49 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-493f75f7172so82875935e9.1
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 13:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784578306; x=1785183106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U/09Eb0HUBr/JHocdx6RIzxAMDkihyLBxhmQ0AfJ/9A=;
 b=mblU+kogo00SPTfPJovoCn0wuFi6uzxh432w8uRnoZFuWjAZqYwzdE2CTG3FIylzbH
 QDiLDYgsd0nfBaCuAqE9EFllXMrlV6Z/XYDuKWrc3tQPz2KLwxUFb5UelPg62GEwsglV
 ZnZyIPuS+4frMeaFqaTdCZ0oya5SZs8+U39hFNte66eLr0uGyiGSRPNTC9k2ePwKER+h
 HYzEvk1Nv8XbA/EZt8uEOGtbIbj3j97mQhqha2bS9IS8k2gtdP8AFwJpHUL4EEaTZIOO
 I2NoBtvqi7HxMKM6i147oyXsxqzmUrK0M1DwqR5N4/d5WXtIGvRXKXVELIG499ksSSrv
 ki6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784578306; x=1785183106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=U/09Eb0HUBr/JHocdx6RIzxAMDkihyLBxhmQ0AfJ/9A=;
 b=RgZ9ltbFj/W4MP+92I2W5RmsWUZpxdlochNlQRBceTYOH/7Hj0K1VcaKrHGfJBiFYr
 7c8x3mepTM6PMtcU+eeZrKvr9sZJhLjstoLJAxxQaPV+MfY9qA6UDfqKZWB+zAHx4zMa
 0B4jBLzYinTnMHimnTNgpDHRtX/POKdgWXvMkpVWLYmmo5kz7dkpBA0c3nDn41anhv3k
 6L4aJD0sgakBy43sd/rmQduNO9HlJ2XJ4hLJUrHoz0GAHrRqE7lSP4Q2OyZPvVmrfLB8
 4QCxhLQRCCohH9xC6BJLWKSxRGFW5/rmAywgIq6QpQcHeume62yuju9qJv6U6tttYbhH
 2pnQ==
X-Gm-Message-State: AOJu0Yyb5Be0HaO/yqMi6m+ieo+XInwApfTcOSQFRpNmJCxqVwaLp3sF
 vSJNa6szxf2vEJQtxw5pvtha3xbY/uanfmUkPsin/PadOWQFluvAwvETMILWWA==
X-Gm-Gg: AfdE7cn95duHdsqJzo79WA/uat7m88HyNgEyzu28GtOhi28KgcG0vyIxOxBM3TpG8Wg
 OONTmUiVYS3LSza05hUyodVB789lufiUX8CnAvKH/KJqt9MXhBqPhxOJIz6+j/GVWuQAxRelzEh
 KNXuN6au2IrFJhR3WkG+FN/G68pyq7jSTvhj63OyLhDR+ayI2XKT7TwE/3m/vMzkJU+L4doQH4/
 pjVM+75UrI0deKmhFVuvOAwuh4pNu0/Ct5lSDqrHoyO7IC639neerOaumgJkVj6A00Dsep1SFTF
 x1+FaaqLs2eoMyWJQTRePYlhR2eaf98owRX+aOWRGhY+cqCRnJ57rtRbRsYcqm0qnwRg8XX50Lm
 DKnvFsakSpltq6/KqwD3J+15dufY/lIMv8VpryQtucfSVfQuuGjui//qYjltN5yyDMgB/BsErTX
 Vd00w/JFtvKTCaE2fKM9AZWezJsN+bVsPsOcJcnbDdtfQakfh8Z6ois3ytpHAZMQTXiEilPjpGU
 3YXcoQ+W+nzqfAdb7k5dCfpkw==
X-Received: by 2002:a05:600c:4593:b0:495:3a52:cd7e with SMTP id
 5b1f17b1804b1-4954a40e2f3mr182158835e9.25.1784578306152; 
 Mon, 20 Jul 2026 13:11:46 -0700 (PDT)
Received: from Provence.localdomain
 (dynamic-2a02-3100-225b-5200-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:225b:5200:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653bfabesm15934935e9.10.2026.07.20.13.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 13:11:45 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Bin Meng <bmeng.cn@gmail.com>, Bernhard Beschow <shentey@gmail.com>,
 Bin Meng <bin.meng@processmission.com>, Christian Speich <c.speich@avm.de>
Subject: [PATCH v2 1/2] hw/sd/sd: Fix error case for CMD18
Date: Mon, 20 Jul 2026 22:11:32 +0200
Message-ID: <20260720201133.24796-2-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260720201133.24796-1-shentey@gmail.com>
References: <20260720201133.24796-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

In commit 468fa450a7e0 ("hw/sd: Switch read/write primitive to
buf+len"), `sd_read_byte()` changed its contract to return the read size
rather than the read value (and was renamed to `sd_read_data()`
accordingly). In an error case, however, `sd_read_data()` returns 0 by
means of `dummy_byte` which is the code for the old contract. Moreover,
`sdbus_read_data()` asserts the virtual method `read_data()` (and thus
`sd_read_data()`) to return a non-zero size, i.e. to make progress and
not loop forever. Fix the code to behave like the "DAT read illegal for
command" case.

Fixes: 468fa450a7e0 ("hw/sd: Switch read/write primitive to buf+len")
Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
cc: Christian Speich <c.speich@avm.de>
---
 hw/sd/sd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/sd/sd.c b/hw/sd/sd.c
index 3360757004..a30c541df0 100644
--- a/hw/sd/sd.c
+++ b/hw/sd/sd.c
@@ -2860,7 +2860,8 @@ static size_t sd_read_data(SDState *sd, void *buf, size_t length)
         if (sd->data_offset == 0) {
             if (!address_in_range(sd, "READ_MULTIPLE_BLOCK",
                                   sd->data_start, io_len)) {
-                return dummy_byte;
+                *value = dummy_byte;
+                return length;
             }
             partition_access = sd->ext_csd[EXT_CSD_PART_CONFIG]
                     & EXT_CSD_PART_CONFIG_ACC_MASK;
-- 
2.55.0


