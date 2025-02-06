Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C52C02198
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 15:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg3YG-0000Wn-Id; Thu, 06 Feb 2025 10:12:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg3YE-0000Vk-64
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:12:23 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tg3YB-00013e-KL
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 10:12:21 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-436a03197b2so7093045e9.2
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 07:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738854738; x=1739459538; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OBNYNjCfYi4QoRh0F+kJieima3x5PkzU8IjA7dU/mlo=;
 b=GytINZ5AHEP0t42WDUKymQ538wjb8A3XJZ2YYKgwXJ+ne5Mf9/QGr5zS/Gj5o4ORTm
 dRDeyGxlOIy72q7hKg+Jj83+pvrIO+oKocx6qlVjoxu7YViu27KQQJcfDi+bM6Zh4YR+
 vsLrWb1SoiEsSTyKJ9yvFP4YJEZhvPGVDu1RDO0niNQe74w6TRulWYY1rWgqO5PlNDVK
 mbQg3yMq2YiBAWr6bT5F3waykfW4bbxmZCG6tIglJG8q1zozjCgigD7iq7xf3X0F2zWR
 lGzi+Dm6RNiGjFYhYqFNxiIn1WMBY9/4LMWUZsxS4t5LOKDr6bJApLSqRdnrobw88zd2
 W3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738854738; x=1739459538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OBNYNjCfYi4QoRh0F+kJieima3x5PkzU8IjA7dU/mlo=;
 b=DKqLso4gi3JfGehQChp+E2B7Yn1Ag7vW5VvNeu1Xckl64kJ8kJFDwcokIJu2LJ59ep
 xevUY+C8+Orvl9OOfd5Yzml/JX8OYH+QFtlNkhO4U01fStv8VncHyq1HZDMqCZR4rYWS
 LA1DL8eYTovN4ebfKvlfS/vIz70rLDhj7xe9+fmeOGF83t5lCfiK1rqq47gtITmlqehz
 mXAhSeIpeHxgNb3rdh8oFtptTjySkwGFh8WIQVSLKTmBfTuHjt0ULH93j2/hmwZVQGpO
 WMCh56E1GvoIM0RtDMTRahumZ9gdTvb92wzKCbvBfu8H4wfeXzV/UIm9sVkp1SAJ3YPe
 lHrA==
X-Gm-Message-State: AOJu0YzgN+JKIlfixu/TzOBt/hWzWRTGAOynVbVCG7ypDJv5T33Cki+b
 OxA99sKEwVqyu0IM3Z2GN6E+U8HuK5bsX/41xQ2aHtqX+ceLIcnQtxg2teY8ppN6BswBHmCXkGN
 D
X-Gm-Gg: ASbGncvW3nS3ItIM3TMPYX0qQimR7VYwd2lNpJDg4WVHLV315wXm9Br4ZCMkwFZ+Wb8
 G8dD/DVgPzBI/ntjRVbVVR5TGVJNikaZE4QKiiClIBb8f5KDJegplm3GIzULOfDyM3a8ZqpYVvW
 03Od2vWlq9gEzWwdbJcOFCo62PZOIEcpzYgqqHfjhcm0qVzuuACiU3Ty5lxBzoMct7Kf6b7EldZ
 iEmcm4BAV8sKXjGDLVtvo45AwJs4EKmLKwnTVAWG8hSyJ7iEvhloX95ninOFX0cLaH7ylIpszNl
 z/41Xy73I+d9S+I8O21mLQ==
X-Google-Smtp-Source: AGHT+IHMltcPEBSo8w545oIWF6WyrP9Sdw05FDStv1AXJB4R7C7ouNNrds8H9xIC6Num/QHIUcnfTg==
X-Received: by 2002:a05:600c:1d1e:b0:436:faeb:2a1b with SMTP id
 5b1f17b1804b1-4390d43e579mr58801755e9.13.1738854737474; 
 Thu, 06 Feb 2025 07:12:17 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4391d5283b2sm23591535e9.0.2025.02.06.07.12.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2025 07:12:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paul Burton <paulburton@kernel.org>, Aleksandar Rikalo <arikalo@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Jia Liu <proljc@gmail.com>
Subject: [PATCH 1/6] monitor/hmp-cmds.c: Clean up hmp_dumpdtb printf
Date: Thu,  6 Feb 2025 15:12:09 +0000
Message-Id: <20250206151214.2947842-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250206151214.2947842-1-peter.maydell@linaro.org>
References: <20250206151214.2947842-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In hmp_dumpdtb(), we print a message when the command succeeds.  This
message is missing the trailing \n, so the HMP command prompt is
printed immediately after it.  We also weren't capitalizing 'DTB', or
quoting the filename in the message.  Fix these nits.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 monitor/hmp-cmds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 0aa22e1ae27..ff87fd89e4d 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -431,6 +431,6 @@ void hmp_dumpdtb(Monitor *mon, const QDict *qdict)
         return;
     }
 
-    monitor_printf(mon, "dtb dumped to %s", filename);
+    monitor_printf(mon, "DTB dumped to '%s'\n", filename);
 }
 #endif
-- 
2.34.1


