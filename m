Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A4DEE499F
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 12:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soMKF-0005E5-6E; Wed, 11 Sep 2024 08:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMKD-00056z-Ed
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:19:57 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1soMKB-0007jf-Kg
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 08:19:57 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-42cafda818aso41872965e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 05:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726057193; x=1726661993; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oF+VgAK/60bbN2i1wEB0HZzkwqaqE8g4quwMk7fBc9o=;
 b=C4/+x3FrcVgNBUuaLkowAgtrHb3T2FRkYvYRqIZxqy7CHvngPIZGOUYHPWL1WtNPGt
 h7DELA4xoQoI5f+ixL0XEVUFIk4mZ4OiWZBsJPNVi76vNkRJhpIvlbFSaLCNa+2DYc5P
 jUISrg7zda95QiQKrRFIRuhnp47aXLa/Wzu0r4zVbdcgoIn8EhRBfEIsC7y/7N2+rJ4t
 PnzeK6R6mKcpBS1Ntb2Aru9VQfWrNFHgQj7gsHoAOu7ZSxrnIU9I4X8xwNqfDD8KIDFO
 Q+N0tFU5nJ0O5GfbYyAonB8Y0FbsWb9il+A3xX8mbVOwSEmHQOUCpS1UskjOXOABIYjs
 6yHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726057193; x=1726661993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oF+VgAK/60bbN2i1wEB0HZzkwqaqE8g4quwMk7fBc9o=;
 b=akHO9RYLrjkzEl0F4f4ZXZ8eg55WiWwH2MDtpsoCm8T+gz8gXotvYny9p00k9wLF5q
 ui8e5eVPGnhUO3s33l4ExF/vS9DbYyIOrT24BsSvRhoDS331UoG0tOD0yeitwN6qX6Ea
 DcCc2tBvjyfc/aQbR9U5PKIZIQZTNzWc6PgXeTrFbhv/65NGaGTGJcDqDP7vkMiToOcN
 xxUyLzMPWQd0spKOmFWtlUZLlqK+bBjjaRwhNyiQNTZWndBqyTjpvqIzaKtrRXVG9A0t
 YudqtK47/rzuzYDKUIBBIID2hzLIBpSZB7YDZAOmytNcBhRuz6NAfJh4oTK1xpVXR8y5
 iqTg==
X-Gm-Message-State: AOJu0YwjxdlMPxqXeWqRUOLpPCn6Jc+wFdIP+Ae9w5irvLO+BhwybcUT
 DhrO5OLSh5jVZLUjbrhsYitmX3Ss02SOqZmIdIMP/9h459mxqT/6nSxd8EBN0KdhSQmRXy6FuEo
 H
X-Google-Smtp-Source: AGHT+IHdedMUSVuFbOI9UGYuhVmQTqBCuoFanOxAYA2rpllXIO+U5JeluA9oCMNKXlxcsFgiQ2Algg==
X-Received: by 2002:a05:600c:54e7:b0:42c:acb0:ddb6 with SMTP id
 5b1f17b1804b1-42cacb0e00bmr116603175e9.9.1726057193251; 
 Wed, 11 Sep 2024 05:19:53 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.196.107])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42ca743bc15sm161665535e9.46.2024.09.11.05.19.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 11 Sep 2024 05:19:52 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Richard W . M . Jones" <rjones@redhat.com>
Subject: [PULL 48/56] hw/watchdog: replace assert(0) with
 g_assert_not_reached()
Date: Wed, 11 Sep 2024 14:14:13 +0200
Message-ID: <20240911121422.52585-49-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240911121422.52585-1-philmd@linaro.org>
References: <20240911121422.52585-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
Message-ID: <20240910221606.1817478-8-pierrick.bouvier@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/watchdog/watchdog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
index 955046161b..d0ce3c4ac5 100644
--- a/hw/watchdog/watchdog.c
+++ b/hw/watchdog/watchdog.c
@@ -85,7 +85,7 @@ void watchdog_perform_action(void)
         break;
 
     default:
-        assert(0);
+        g_assert_not_reached();
     }
 }
 
-- 
2.45.2


