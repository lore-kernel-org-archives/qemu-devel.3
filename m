Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C582C30658
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 12:47:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPiJx-0001li-BQ; Fri, 05 Jul 2024 08:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPiJu-0001l3-CR
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 08:45:47 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPiJs-0006NK-3X
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 08:45:46 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2ee7885aa5fso17303951fa.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 05:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720183542; x=1720788342; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WNDLgSKuj/JEGkQnNe9YyIJCv5XnbjbM9mOjkA4c2oA=;
 b=Jarcn7KVIVZaBO4y1EkyQwCoxcFlGzXckGWDtN+bkcLWVT/HRF0YZgUrSv3iaGvu2n
 5mm7EPXOU9DMEVXDWsZxaibOxOfTkpI0uUIia/jKCuEetsw2EcFlBZXTsxdh7rfZD2iT
 Z0O/vGldCWbkCfqrXyGdyac510MuR4x3E9TIVHNeNng2IBbL4K+F/fMxwirIal9rGyQK
 JpH6WH12qygivKJNun7CkFuFb1sgRpKzwNxLxcRGghN8iJJYifb8an1r5ERL22m1nF5S
 LbRN+ewZZiWryXAoI0yNE+kvK23H2AJ2WFzxPBQld21AIiEm8qemPGQaYWZaCAYcshPR
 0y3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720183542; x=1720788342;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WNDLgSKuj/JEGkQnNe9YyIJCv5XnbjbM9mOjkA4c2oA=;
 b=T2VUTIsiAJThk76IOOF0skrfJZgVR7bBs1Qh/840JIyHdSJ2JDJz7yjkGKIlqRDymm
 uxYoOcraI72vb0ivcgDMzgk5ovtYA14Xa1FgewrMsBtnAQnV0X+C8cDn3SBgIb9+Nflf
 qwUWp3uqe5n6FXv9/CU5gzcJ2EtqriTxAL+ORwP9f+1Y5s+1DIJ29r0gI+dzUaT3HvZb
 C1oHB4ghxT+NOl5zlu+MqPfh2dolKzySjkQdORexV/rLxPwYCT9BgLEgIgvbg8hfP/je
 UDeSYUINx08ZqprbsUP4dXd3klaWyxDWpIIItzUzJsPUqmQUOC3nXS+4fACcq9MTDTcg
 S5iw==
X-Gm-Message-State: AOJu0Yyt59/juJUmcJJvpdtGa9NOMpykS2DDdBDU49y+QL1/J16/zxQF
 7SihmbnU2K0aQHJZyPSDu6dMD8TYS2v3sWs1bJK0ERxFY76zrBTlIGzPuHqgFpaX1NhctL8OY2G
 u
X-Google-Smtp-Source: AGHT+IFdOo0yRtFdNljjvpFDm4jujC03JxI7Ags1YqRVSRTQ/OGJcFgTZzfsdKvJyrT4Rjsrb+haqQ==
X-Received: by 2002:a2e:b173:0:b0:2ec:550e:24f3 with SMTP id
 38308e7fff4ca-2ee8ed5f62cmr29408011fa.10.1720183541741; 
 Fri, 05 Jul 2024 05:45:41 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.163.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a283551sm61209735e9.42.2024.07.05.05.45.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 05 Jul 2024 05:45:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/2] system: Enable the device aliases for or1k, too
Date: Fri,  5 Jul 2024 14:45:28 +0200
Message-ID: <20240705124528.97471-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240705124528.97471-1-philmd@linaro.org>
References: <20240705124528.97471-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22c.google.com
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

From: Thomas Huth <thuth@redhat.com>

Now that we've got a "virt" machine for or1k that supports PCI
too (commit 40fef82c4e "hw/openrisc: Add PCI bus support to virt")
we can also enable the virtio device aliases like we do on other
similar platforms. This will e.g. help to run the iotests with
qemu-system-or1k later.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240705090808.1305765-1-thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 system/qdev-monitor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index acdc8b73a3..44994ea0e1 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -61,6 +61,7 @@ typedef struct QDevAlias
                               QEMU_ARCH_I386 | \
                               QEMU_ARCH_LOONGARCH | \
                               QEMU_ARCH_MIPS | \
+                              QEMU_ARCH_OPENRISC | \
                               QEMU_ARCH_PPC | \
                               QEMU_ARCH_RISCV | \
                               QEMU_ARCH_SH4 | \
-- 
2.41.0


