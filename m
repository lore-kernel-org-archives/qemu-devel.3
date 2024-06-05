Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FA7C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 21:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sExz2-0000fs-KK; Wed, 05 Jun 2024 17:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExyu-0000cw-S5
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:41 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sExyj-0003Q1-Ge
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 17:15:39 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-7023b6d810bso199745b3a.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 14:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717622128; x=1718226928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TgL42mC7jE0u3HD5Jwp7lhtcm3jXE8Mj7V3RtjF1NUM=;
 b=eOJ7K1dYloajCjYjB4VRf+l9+CMpLo05pKi92Ggd/ivvGS9HO9XsmsN99tcXGJk7+x
 LcMiskv2owZM29Go2f6nGb3WoqekUY0Kb5uEq6NFXDx8aQUlDbJhZx4m9So3p3/rgQB5
 gDcwduJTygYIILh4D8gwhgD+O/76GVqbqj3H/2DxjMOKEUkDssyyTEiDtvSaSJk82EpZ
 w2ikQmrkomOzgL1Byoe1LWyn4u9qznvUZQVmejGuErIDi1XXU68pWE+xWXWWamlQ0PCS
 qgqfF4YTkNheslx5fFdDx5n7RMKbh0R6EonB2xthAzsv9F8LTxooLNVcbirCvIakm613
 aH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717622128; x=1718226928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TgL42mC7jE0u3HD5Jwp7lhtcm3jXE8Mj7V3RtjF1NUM=;
 b=V5jr8ZpHJkRFDEN7B8yJa74zHVSzUdbKIpgZJ/5yE3cgifkSRa1Ociz6WkWUG5rr80
 RSgu80f17bKvxp+6Ci4WrYpJvqToDoSiwQWPj9ABa8rAlJ9f8sdVFBG02WxJSvuNpLaj
 GkekUOdRid4e3xlQ2FqUmcNDt8qIPRR0TCKIypZnt58HulC6dz4nPqJHK1q28mLCEmxa
 v2UK7zog8PVnXVfZ0wN7+OAVSqoZpUE4e9LiAsAwafxg/3Th9Y1eIqZSW8P3uC018ZM9
 CEWRCBHP0dD9E5NYDg+FZw6Qy7e4sBa9CQnfevVxnxrz7UAb0DbqlBp1HTBYHDnrbBGB
 vDjg==
X-Gm-Message-State: AOJu0YzAnkOWNAtTwIE4P+ypKlqbzys3xEG7zmUTmIwkbsW/4UTcqYqb
 WqvbRrsg9TqhGoEm46J186GNd3gXsGoda0BxaikryR/G8PIpGgXv4xavO6R1MEn30IeC+vdNJPr
 D
X-Google-Smtp-Source: AGHT+IEsLGOF+U0pd+gqZKbLNLd/RPk1vdCd4AdoGbJ6lp8b0r2cN4b9hM0uek+nuFSU4BPbGYDCwg==
X-Received: by 2002:a05:6a00:1d0c:b0:703:efa7:e594 with SMTP id
 d2e1a72fcca58-703efa7e8dfmr2127404b3a.33.1717622128148; 
 Wed, 05 Jun 2024 14:15:28 -0700 (PDT)
Received: from stoup.. ([71.212.132.216]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70242aec7d0sm9347538b3a.99.2024.06.05.14.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 14:15:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 06/16] hw/scsi/scsi-disk: Use qemu_hexdump_line to avoid sprintf
Date: Wed,  5 Jun 2024 14:15:11 -0700
Message-Id: <20240605211521.577094-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605211521.577094-1-richard.henderson@linaro.org>
References: <20240605211521.577094-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1.
Using qemu_hexdump_line both fixes the deprecation warning and
simplifies the code base.

Note that this drops the "0x" prefix to every byte, which should
be of no consequence to tracing.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240412073346.458116-9-richard.henderson@linaro.org>
---
 hw/scsi/scsi-disk.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index 4bd7af9d0c..f386a2f01c 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -2648,19 +2648,12 @@ static const SCSIReqOps *const scsi_disk_reqops_dispatch[256] = {
 
 static void scsi_disk_new_request_dump(uint32_t lun, uint32_t tag, uint8_t *buf)
 {
-    int i;
     int len = scsi_cdb_length(buf);
-    char *line_buffer, *p;
+    g_autoptr(GString) str = NULL;
 
     assert(len > 0 && len <= 16);
-    line_buffer = g_malloc(len * 5 + 1);
-
-    for (i = 0, p = line_buffer; i < len; i++) {
-        p += sprintf(p, " 0x%02x", buf[i]);
-    }
-    trace_scsi_disk_new_request(lun, tag, line_buffer);
-
-    g_free(line_buffer);
+    str = qemu_hexdump_line(NULL, buf, len, 1, 0);
+    trace_scsi_disk_new_request(lun, tag, str->str);
 }
 
 static SCSIRequest *scsi_new_request(SCSIDevice *d, uint32_t tag, uint32_t lun,
-- 
2.34.1


