Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451A0CD5BC5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 13:03:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smC79-0001oG-Gv; Thu, 05 Sep 2024 09:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC71-0001Im-CN
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:23 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1smC6x-0001n7-NB
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 09:01:23 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-42bfb50e4e6so5751935e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 06:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725541278; x=1726146078; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VA29/g4wKHT5gPl+VZPcS59cjqvbl7e/0STDa0JUTUw=;
 b=WW7pFIxCfPNt7FzKL64to3Suj5JKXhNDEoFvjZgOTuVkXjyPCmEuSPLLVzc8sPJLhI
 MDKZ3kpnzwlFhKD8npzVcSLWUgDdKiXP7yV1w22VWftJHNqF1UWxFv4hwgJee86BEJdJ
 HSY/lcPZinY5vAdoV8ifh24gzDDo/KOfCz2RPphc5aXFiQB3PvJrAqTLUea+oJnnGyUx
 pwMiviSROArI5sa0W4lD1jqX7XyA0V1WUWd5s0bJ9mRcnQWKx3hZaWwfz+6TOfQ9vQ5e
 0Z7vNNXEM2oyQv9ZtaOt0BjamnBkXkAGMQFAJyp9xKm5zuYsOmsDfI3cYKyvDhePFdvL
 rwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725541278; x=1726146078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VA29/g4wKHT5gPl+VZPcS59cjqvbl7e/0STDa0JUTUw=;
 b=FYVrCxa00D5K6ineo8TXqOis40Whz7ilNdDGQuR/d8qIQXAIsa9V/GTLZaeB9p+syd
 uxIUdkritJtNE9RMiis9W7Ffo41g+H9trLD+UagA9ypyH0TTV6hsIXhAYc8gHrdArNlM
 KSkGT6IDRJ9t+WG0x+5MFVAiI7fkS3bhXPEkLHOA/GaLAcxUMQCUu7uuwBjb7xTopH+F
 sguN1dC1We47QCykaz7cOEKhF8PRIYIAo0gFUhFIdkdd9FH/XoJqBUOUvvx5qMbtiryW
 DEZKXjDd4mbHOnCGUuW5YYirc41lLOTFiYGA5jnrrW/lQwtLyu3TXHxPv/A7cku8GDT/
 Ybgg==
X-Gm-Message-State: AOJu0YxPbDIT5TtZCo4Zo9XEfDXMqm2oYSLm9wqzbtw2wz3Oxk+XPXL5
 8KbQNiEp5ULLDvECPP0QyX1/pKwDPingT6YUG4X/d19IHpYbJVn6xpVP1bBI/IqRtjHSkWQPwsQ
 d
X-Google-Smtp-Source: AGHT+IEPLerX9lXw70s6a7Blkxo6Nk+aIZ3kl8Tp9wojozHnB81sHh84zksuEjRXPEot0YXFN6Jbcg==
X-Received: by 2002:a05:600c:1ca8:b0:426:6f17:531 with SMTP id
 5b1f17b1804b1-42bb02edaf6mr187964425e9.13.1725541277878; 
 Thu, 05 Sep 2024 06:01:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42bb6e355dfsm232251365e9.46.2024.09.05.06.01.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 06:01:17 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/25] hw/arm/boot: Report error msg if loading elf/dtb failed
Date: Thu,  5 Sep 2024 14:00:58 +0100
Message-Id: <20240905130100.298768-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905130100.298768-1-peter.maydell@linaro.org>
References: <20240905130100.298768-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

From: Changbin Du <changbin.du@huawei.com>

Print errors before exit. Do not exit silently.

Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Changbin Du <changbin.du@huawei.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20240903133940.3447430-1-changbin.du@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index d480a7da02c..6c895e05cbc 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -839,6 +839,8 @@ static ssize_t arm_load_elf(struct arm_boot_info *info, uint64_t *pentry,
                       1, data_swab, as);
     if (ret <= 0) {
         /* The header loaded but the image didn't */
+        error_report("Couldn't load elf '%s': %s",
+                     info->kernel_filename, load_elf_strerror(ret));
         exit(1);
     }
 
-- 
2.34.1


