Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B36C2C3601A
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 00:04:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0UWJ-00040Z-GG; Thu, 03 Apr 2025 20:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UW8-0003nw-Fy
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:02:41 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0UW6-0003Lx-Rq
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 20:02:40 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-43d2d952eb1so9937345e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 17:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743724957; x=1744329757; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y8pJw8cPhR9UAP5Jbu+JLKafXySYzE5GFtajnVdfvaQ=;
 b=zpxdSvDNBekrRJO9Ej4v8f5yHBvVcp7wpc2Kpb2W159ybQzczFFr+fk5PQPmtOrQlq
 0+//9Hny2oho0XLx4qa99p6WazOXzR9fl7PJeX3pijzVUNb6FQ4rkJSShtSWm/Ai2YMJ
 VahMWA4u27gQGzns/UTJnPWURQySCsaSlEsGzgQFPXVjoT6BlnxhMWNevnQmY1tp0xrB
 etsv/3DvdmL92eJMmPaBFlvffTfAWxWZI+csSr0QNY++y+DKQL/s4zzz/0RqPyc0g/P6
 V0fmsRGUdzmMWOsoygo28UY9Br4UGuEmX/2vdDn19Ci3t/eK6kCVdKyhryuM9UNfGrtE
 ZZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743724957; x=1744329757;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y8pJw8cPhR9UAP5Jbu+JLKafXySYzE5GFtajnVdfvaQ=;
 b=KUKa1apMQd6xlizy3gkBD3r64IiTqSKGp7J4MJljSHeY+m71jfzXFY7t8UqpgPto4r
 Pj/b1KYuxPrHYf6ttIvOTstex0xiwF6Qqr5oWf9kT+phMkCzVszapVcP3Pw5Gc+q8MBS
 lbiUzeEboHffOviyIgbQn6PmjcbumCdMKuD95Adojk/acFY+sjhyq32BvWjkDheI1+7V
 ZyzTF9rM21gCh2ilRoJD9+cwwE0WV6lx4L2uIh8hfaPioBa72ki+ibfwPVRv7AaLQmjA
 dh6czF6K4L1jRsJ9Zjc2BytWf6DW4qT7ViX7QFLaGBbfDflWrLS2vMwaQKDdXcjnvG/w
 /ygQ==
X-Gm-Message-State: AOJu0YwF2xGa1UWWNe/My3OUTPdyrjwHLssOnwgS6Y9uX26MZuJo+Y/a
 IbUBqGolhgItukKpo9ULHffLaty9STh4tY+RdD+Jut122Mn84TAYgDeAgYuHeJjMz3l0YB2nP0Z
 L
X-Gm-Gg: ASbGnctxzMwgU3ysn5Unv2jqW7E8RB7ssUlQvNNh3Pp6wpbh67mtlmPOdWFqbqoBnkE
 gV6o9BtbFKMucjcfFAKyYqcTbIJDsnczBFtKY1gufWpWGr1T7yJiAOeqUMb4jo8N650MRHWQFrD
 hmRzmktMyh2/BC7hSD6yPRezdjiCC5qIzsvP04xQ1qU0rAeQpFb7KnL5TQPnGVwQKpioF4FpMa8
 hQbRTcs8bOOn5zvrmmaCqTHkm1tOn4QrZEGykKI6dho0lmWJON53v9qQKTjxd2egnUc6VNtlcJ+
 J21fbI2tH103rGPRvlNfC3PAMnxa3dq8/rQhfsEdq9opfPBAaWsxJEXkfpLtBRUtyjRjop2nOHW
 nv2Hy6Pc8IDYsTb7uiX4=
X-Google-Smtp-Source: AGHT+IEXRB0buW1jHdZlNo4d9QPmrsrP+OeA4fHABFrsnJoXuoyE9uM4gOwe0B8wk7zfuuGihsoMKg==
X-Received: by 2002:a5d:64cd:0:b0:39c:1f10:ba54 with SMTP id
 ffacd0b85a97d-39cba93bc91mr891063f8f.35.1743724956987; 
 Thu, 03 Apr 2025 17:02:36 -0700 (PDT)
Received: from localhost.localdomain (184.170.88.92.rev.sfr.net.
 [92.88.170.184]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c30226b23sm2926410f8f.86.2025.04.03.17.02.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 03 Apr 2025 17:02:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [RFC PATCH-for-10.1 39/39] hw/arm/meson: Remove arm_ss[] source set
Date: Fri,  4 Apr 2025 01:58:21 +0200
Message-ID: <20250403235821.9909-40-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250403235821.9909-1-philmd@linaro.org>
References: <20250403235821.9909-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

All units are now built as common objects.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
Yay!
---
 hw/arm/meson.build | 2 --
 1 file changed, 2 deletions(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 61f145f901f..476e6048939 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -1,4 +1,3 @@
-arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_common_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
 arm_common_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
@@ -81,5 +80,4 @@ arm_common_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
 
 arm_common_ss.add(fdt, files('boot.c'))
 
-hw_arch += {'arm': arm_ss}
 hw_common_arch += {'arm': arm_common_ss}
-- 
2.47.1


