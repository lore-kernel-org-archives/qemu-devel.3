Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAB5C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 13:01:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJXRa-0007p8-1U; Mon, 26 May 2025 09:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJXRX-0007n3-MA
 for qemu-devel@nongnu.org; Mon, 26 May 2025 09:00:39 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJXRS-0005Xf-3V
 for qemu-devel@nongnu.org; Mon, 26 May 2025 09:00:39 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cf848528aso23388355e9.2
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 06:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748264432; x=1748869232; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nx4cl2IML5QZ9Mvq/oiwPXRYTEV7oxhBzSYHaQYpoVA=;
 b=uJTiwCnNnhJHjSZoxJ9ZkYqFHGc/mSnE2qsa3yh+ePWED1ubxB05XdhnWW9NjyjVAI
 IFMEUfrlo4FGDd41BMYYWYC/ACdgif9QurDb8i6bJgYyoEruWXtO+iofc++Y5qthI/S7
 B5/fxmJ9tVpZin1u3GdigmUgJUk9e+fLCEEDzyhq/aXP7BnXeWrojmiLkyShMapppx94
 hKKjWWqLWCxay1x9G70YjpFIrWtyL0owvoGUN0OC2clCpNmpAxk7bT/0kW84tGgXThkX
 lr5f/U/TcCzqGK7GEB2HrvAnTzv16/JF+Jz55iIzxo89y0SZYti667Qo/GmmdEm/k6N5
 /szw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748264432; x=1748869232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Nx4cl2IML5QZ9Mvq/oiwPXRYTEV7oxhBzSYHaQYpoVA=;
 b=vfFchxRUlDr94TKq3Xc1r5GgyeiKcgrORm8nAyOgbeyvEcyDgtk0KwRTF+i7H5dTIA
 KJdNP739BrBHqJVzfi9qyDopdKVSK4dbx5ZRAZWqbrkWykC82fE+lZLCBJF4WtdH5CyF
 O3WQ9pW/kG7LuFVdBGFrLnLH7NVD+JPp/p2mtcIWS/YTMvAITZxLflLk1afDu3FzgbXR
 7FOVYUArRGfLdW6j4D+2TrrDurPixbVfTQa4R4d6RdsACMb1V0A8wrjBvGnHFZut3Y53
 CcB9JB4txBrdLw3NpdDi+DUO19Az/mONHc0EIJYkR7+j4Akeem5wO+iM6kLPuD0+sebc
 WRnQ==
X-Gm-Message-State: AOJu0YwEbn62pc90vjXqJjjrZLuNb+8gg0nHte1HhjJtzJPTDxoS8Kfu
 4Qmpb8QbkDP3zAUb4rgt1xifIiVJ6HL+TwgSBsJUiZKUqpIXSvcwleYcV7R23vsDw8P9qEbWipk
 7c1QNx60qJA==
X-Gm-Gg: ASbGncvpVpOMENL8qjXR7CmJh4QJ1BwT3FhBX10IZr2ZzAxYyht6z1i9i1pIbI4Vc0e
 ZZbCnl4puNGkmfTNM6WvV8MY8xCpS9aWU1TiHvD6dBsToDNGH6Qi7avvqc0XLS7n6vbEdgRW0kO
 nl8yLCAazflfsx9/BqplfQUObgR7ZgLX9njGNO2IznY4MhYcSgHtpMEdFFcGoW4LjdQZDU1BFiw
 AVi4DTnvhAAdLeO5gSaBA0mxuO6atupL0Rn9Q9Bvxyo86q4T35xWJDCBmF+wW0t0id1tUOO2WsX
 5uO7Htqf6FQ5FbdogsNVfjtGIPasvXKhYxMUGm6IfPeRyOINZs/rBpYFN+5fFwaTc3MrJbthMeb
 +uVhSoKhBcz5zgavzezf5ew==
X-Google-Smtp-Source: AGHT+IGtyEg8GONWGN9YKucbsspwtuuLeAYDkXav7bSibeU/P4yQTpUfbjC3n98C58HV/A65f35ofw==
X-Received: by 2002:a05:600c:6090:b0:43c:e305:6d50 with SMTP id
 5b1f17b1804b1-44c932f9391mr67589455e9.24.1748264431714; 
 Mon, 26 May 2025 06:00:31 -0700 (PDT)
Received: from localhost.localdomain (44.87.95.79.rev.sfr.net. [79.95.87.44])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-447f7d975f4sm234864725e9.39.2025.05.26.06.00.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 May 2025 06:00:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Nicholas Piggin <npiggin@gmail.com>, Yanan Wang <wangyanan55@huawei.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 3/3] hw/boards: Remove MachineState::usb_disabled field
Date: Mon, 26 May 2025 15:00:06 +0200
Message-ID: <20250526130006.49817-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250526130006.49817-1-philmd@linaro.org>
References: <20250526130006.49817-1-philmd@linaro.org>
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

Commit c6e765035bc ("powerpc: fix -machine usb=no for newworld
and pseries machines") added the MachineState::usb_disabled
field. It is now unused, remove it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/boards.h | 1 -
 hw/core/machine.c   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index a7b1fcffae3..7d9149242ea 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -406,7 +406,6 @@ struct MachineState {
     bool dump_guest_core;
     bool mem_merge;
     bool usb;
-    bool usb_disabled;
     char *firmware;
     bool iommu;
     bool suppress_vmdesc;
diff --git a/hw/core/machine.c b/hw/core/machine.c
index c3f3a5020d0..896b5067214 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -498,7 +498,6 @@ static void machine_set_usb(Object *obj, bool value, Error **errp)
     MachineState *ms = MACHINE(obj);
 
     ms->usb = value;
-    ms->usb_disabled = !value;
 }
 
 static bool machine_get_graphics(Object *obj, Error **errp)
-- 
2.47.1


