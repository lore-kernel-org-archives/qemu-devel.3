Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C25BC36013
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 19:54:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzL8t-0002uq-6f; Mon, 31 Mar 2025 15:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL8V-0002QO-M9
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:49:40 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL8P-0003Pv-TX
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:49:30 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-43d04dc73b7so54303715e9.3
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 12:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743450564; x=1744055364; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vmsVNeCK9XAwasYEG5loG6D8JvxrnUff8X/1oJ1HOX8=;
 b=z2n4VUvkc0vvhzkky/OJBs7Ed/wyeriqvCHKQhF7XkHGeeBaVcRAu5leKFe8PmoLa2
 v92mqpCfDgCybaSv/2Bf9uGFsyS+yhljRbSGYH+YFnBYjaUQs3dh2cEip8OeBsz+uq9L
 Ve0QaTVxqBW3rHBpn8/ORgNvVyyg+zlebBE3jErJNF1JiaCt1LmxlAowJ/PKw0P4HtEU
 OZ1Vj1rx2zDOMTrALN7NsUFs3NGoRxJGJ8Bm1hAWP2VCyfwVnbv8bee1CasrNfdV2IOt
 jBS6ZweycO22eBGb5NZ2O2wGYDfBqLYMSmZkfTeW7tDterzT7DBZibE/1wQNkJwtsoB8
 Aebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743450564; x=1744055364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vmsVNeCK9XAwasYEG5loG6D8JvxrnUff8X/1oJ1HOX8=;
 b=uEi8fsXVrJcz0AuKXv9RgBupWIdAz0own9NmryKCLLsfCBRAH3iFgMci6iJd8jWFhP
 716qBY7eBoii8FUG0K3houITtGBGV8u4xhOZDVyAVkoniC4ysZEPhs/vdf8BNMAm4QQ3
 IBgo3R0aaav3iGpkn4yVxYrJ68a/W3mat9LF6RqVXBVhdQd4F6NkhSIEU7sCEuP6EeNA
 w21kpsngeNpuqhdBiga/Y6aCLZyQ4afsRoUgQvRlC4V5Y5ahtvm9k+7wRyJ/qbyf0ILJ
 z42xrFfPAWod75IU5Ca4Hyjb9Iel9NAl2Cj7nAOTInTnyAKME57Vk/nfZ8sBGms0Jn5x
 aCFw==
X-Gm-Message-State: AOJu0YxDVIyw9ifE7S8ZrMWDmHjPniGb4qR01r31TgZbPXXEBNtA+FGH
 2v26fhnA1LacfNCayaUZIS5qBb9r7wy2c3UY+dBmF4IGmLDKuRvcVtyKXU+gGQzuJ6Wn3GOYTy3
 N
X-Gm-Gg: ASbGncszE1IXQ9PmKTJl7PKt5ES9j0woetCQ0qCegjKlHlzqA3JESOKo2IervSgv4MH
 VpvQuUhm9x47VSbeNDBnGY2pLOOR+RUYiHFA8ocSYiYoSm9wT3JZYGv+pUjxxekzq0aVXikZa+L
 +Rl6CkMohT3/AEOlB+/TntA20b+LsWaWI/qY5Q81OAr1ExbtE8VkDfegpzXaF1j+4M0nkF/TxjP
 2aPYjzzLXqT8HAcBwvQN3QsVfGdXEAQuSCe6lV/WPk9HDFSxzvAJj+hiLoB2Bw9847/DC4ipbIl
 tEt7s5ruDva6D0F0fZ+QsHB64umSYpdx5zKoc5Puu5mXPIHGFO2bjgTEGGQsZ2lhr9OPFaYLz6r
 FcUjUuRpUHvaoz0AyH5U=
X-Google-Smtp-Source: AGHT+IEfgxt36ulSKtuyj6A2nMLc7IVi8RSrnshZAnV1G5LB6549fKVwCMqFSJLjms1H4UC6Z7T6AA==
X-Received: by 2002:a05:600c:46d1:b0:43d:160:cd9e with SMTP id
 5b1f17b1804b1-43db6249d14mr90561565e9.17.1743450564127; 
 Mon, 31 Mar 2025 12:49:24 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d8fba4c29sm136189505e9.5.2025.03.31.12.49.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 12:49:22 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 12/23] hw/nvram/xlnx-efuse: Do not expose as user-creatable
Date: Mon, 31 Mar 2025 21:48:10 +0200
Message-ID: <20250331194822.77309-13-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331194822.77309-1-philmd@linaro.org>
References: <20250331194822.77309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

This device is part of SoC components thus can not
be created manually.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20250325224310.8785-10-philmd@linaro.org>
---
 hw/nvram/xlnx-efuse.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/nvram/xlnx-efuse.c b/hw/nvram/xlnx-efuse.c
index 29e7dd539ec..176e88fcd17 100644
--- a/hw/nvram/xlnx-efuse.c
+++ b/hw/nvram/xlnx-efuse.c
@@ -280,6 +280,8 @@ static void efuse_class_init(ObjectClass *klass, void *data)
 
     dc->realize = efuse_realize;
     device_class_set_props(dc, efuse_properties);
+    /* Reason: Part of Xilinx SoC */
+    dc->user_creatable = false;
 }
 
 static const TypeInfo efuse_info = {
-- 
2.47.1


