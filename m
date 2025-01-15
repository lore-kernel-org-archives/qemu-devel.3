Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A120C02183
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 23:23:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYCjW-0000rn-VO; Wed, 15 Jan 2025 18:23:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCjU-0000jW-85
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:23:32 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tYCjS-0003rB-Il
 for qemu-devel@nongnu.org; Wed, 15 Jan 2025 18:23:31 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4368a293339so2427745e9.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2025 15:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736983408; x=1737588208; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=snfcvZGJRSdw9CpfmPwjHfIiEi+hhZ6w0WHUO6QzqM8=;
 b=NaqZ5ZGJCn793ePZZGpzE1xVhksco6P6HZ7jhYbamNGX0q+qxdcxuREehfZhvmgwl9
 bR/yw0jBCHYK76GYuHViAJIpcmjCQpXJuhjOyT4zfTN7C1aqRIuT389noBOO3wkuda3q
 UtPCp9HSykTgULtRGbDw8KO9sAY7TJZT9YdtTM/sHiVewLolnRXds3QPeAaSRtXaf+hM
 9VRN+Rd9cyhI2KgFLTXabVmRxOpF9//vrw6Mi2oHBDSmwj5zj/4fv900E7sib2vIaEE7
 jW1oI915LxGuZ7qWF2quNLYnsVpvCYBDTGE9HeABMz3iv77qOWUmwhvcqsorKKx4kP8a
 yIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983408; x=1737588208;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=snfcvZGJRSdw9CpfmPwjHfIiEi+hhZ6w0WHUO6QzqM8=;
 b=sMWYNIyiRz7xANoixsTruvl5PvkXTlOIMMpqaNwTc5xmPLOOWrg49MKGTdv824bGZt
 QkKHnXK9Y3rmZzdD5295MUdZY3bGST0K92FGX9PKw1m4tK2UgqbZmcP/XYS9YdyLCivt
 fXmMgIzeDInP1s1mJdnbOMfOeDmEuoFJTSDk98TY3C5Sf773W38nFgLvSCPDoItq+kZg
 93IoTZkA+CP1ofYkarlOk8iqh+cYrJixGSwTImvrbo7qO/xbtX5RrnP1vYdgxbDe4A19
 SlpQR90bT56x5/XVK9EFZIxsqR3KyMrsDGxVNszHqBcR9enn8KbxI6Cs4B7yFo0wWLja
 1qFA==
X-Gm-Message-State: AOJu0Ywuj6UdHsO04+xYcG7B459nHSXTjbLlWQyW2iU1h6OzoAvnMt3E
 bTWp7gcEaI0GDVFF8JNLo8Mq1H9haK51e8Pifwf+7AVng5tMgslI1FI7A3XQ4bZdgKhozpgOMtg
 Nnu0=
X-Gm-Gg: ASbGncsU86OVFwIibOmAyROJl6HZ0twzVeiQNIEFDSyI4BSDKTaHojOC9VHWjqAPXfi
 vh+vetDCvVI62C3gN4PD0ZVxEag7lS//Yh+06jkX52JR9xjY0XTdsA4s2uQaIovivVaqQaygamw
 2njikNK/rkHcCAxi2U4s5PYx8rtvsg8xud1MjfJRtmaNMlba0y5XiL9S6+2OA0yqBhFD7j8xPsp
 zi0J/czV1iDEOFInIk2XdG70I+ZIy94QzpdhvTbDKdnQ14Q3s0HsM/Vqe/HVJ4x9sCPC1WkiV6H
 +9FOkJS4SxKCH8obbQH4iEFcfk5OJTU=
X-Google-Smtp-Source: AGHT+IHQc5Ghd4EK8DHjkTYR4yEJtRhumv72h7MlL7Hk9xcjNkchGaVDw8e2DaUQPfYGOptzP+syFQ==
X-Received: by 2002:a05:600c:5491:b0:434:fddf:5bfa with SMTP id
 5b1f17b1804b1-436e268626emr270176085e9.2.1736983408392; 
 Wed, 15 Jan 2025 15:23:28 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-437c7499878sm39944135e9.6.2025.01.15.15.23.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 15 Jan 2025 15:23:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 07/21] hw/core/machine: Remove hw_compat_2_4[] array
Date: Thu, 16 Jan 2025 00:22:33 +0100
Message-ID: <20250115232247.30364-8-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115232247.30364-1-philmd@linaro.org>
References: <20250115232247.30364-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The hw_compat_2_4[] array was only used by the pc-q35-2.4 and
pc-i440fx-2.4 machines, which got removed. Remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/boards.h | 3 ---
 hw/core/machine.c   | 9 ---------
 2 files changed, 12 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 2ad711e56db..e9e33c57f27 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -841,7 +841,4 @@ extern const size_t hw_compat_2_6_len;
 extern GlobalProperty hw_compat_2_5[];
 extern const size_t hw_compat_2_5_len;
 
-extern GlobalProperty hw_compat_2_4[];
-extern const size_t hw_compat_2_4_len;
-
 #endif
diff --git a/hw/core/machine.c b/hw/core/machine.c
index c23b3994964..bdd4dee3d67 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -281,15 +281,6 @@ GlobalProperty hw_compat_2_5[] = {
 };
 const size_t hw_compat_2_5_len = G_N_ELEMENTS(hw_compat_2_5);
 
-GlobalProperty hw_compat_2_4[] = {
-    { "e1000", "extra_mac_registers", "off" },
-    { "virtio-pci", "x-disable-pcie", "on" },
-    { "virtio-pci", "migrate-extra", "off" },
-    { "fw_cfg_mem", "dma_enabled", "off" },
-    { "fw_cfg_io", "dma_enabled", "off" }
-};
-const size_t hw_compat_2_4_len = G_N_ELEMENTS(hw_compat_2_4);
-
 MachineState *current_machine;
 
 static char *machine_get_kernel(Object *obj, Error **errp)
-- 
2.47.1


