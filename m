Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AADE7719F
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jan 2025 22:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tX5ze-0005Xy-EO; Sun, 12 Jan 2025 16:59:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX5zb-0005X5-Q2
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:59:36 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tX5za-0003oj-Bg
 for qemu-devel@nongnu.org; Sun, 12 Jan 2025 16:59:35 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-385df53e559so2965737f8f.3
 for <qemu-devel@nongnu.org>; Sun, 12 Jan 2025 13:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736719172; x=1737323972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kAUArdqNQE+zvrxsV1qj+qeaVTE4xMA3YRlZsT7RA+o=;
 b=OwE2RQXLkuhsE2mX+qGPyv+S3icsmgIkRJuS+9ZKJ0eFNxwS4t5t1gO7H1c3Z74TYK
 Mj0cWam0HHU0fsRWp/iYfx+Y2xhO1nwIbjjflFSKpDxbgE5LXi8Q9IHD4e5S0EbQggkr
 lJkT9QpXO7myMY3X9a6LfNWIQVnCgFzjLIw2Sr34NLQjVHbtAy1Ll/96BlJcl4UZwprH
 fRm6MGhlWg9Qt4JJGPSQpe1fAZAerWB/lpQiTdhJthp94zEhFJt94I+1omg6yMr2jMOz
 HafVya1tpkt99c+PROnU64/WSXnlWBUn0LnaxXBTL8DEgff8tt6+OT5uwaV08Vt7R5jZ
 taDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736719172; x=1737323972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kAUArdqNQE+zvrxsV1qj+qeaVTE4xMA3YRlZsT7RA+o=;
 b=WSRPRRVaNli002sl8He3XAFGj6r7YQbKSX3jaDCjPtDrH4P1OJRDqmLudaVFKpTCBr
 eNV/oU4YPPkjnneJO0OUf1u6rdasCW4KzX3O71puMTQgbS8a4oGxG2o561SSsM7jqdNl
 9Rlubyyk/CU9Q9CP2geJ5KqmSEF3hu2IW5hjjHoCU2i+rV+yF0zn4CxFRaWLFMsLar2V
 gZ9D0tjiD2drTSkZ8UkQ2syn4s8LFdN3fX1kGVjd3uOWnypIoEA4nGVyprDBoHFcD4X1
 Ipv2mRvN8WiZoh//kxzIy8Lrz1tNeSpyBIkpz31XvnD+O1kwnrFERXpCoMh4na93agPH
 ii4A==
X-Gm-Message-State: AOJu0YzZw9TAwSniu4zbkZehKT7kcaMgCTY2QNTsetKbPzSotsvjLn7y
 ropmCDsU3ao82U/m4FfZpKpNMPU07a4Z4OGvFdRSoqz4lUxmW0tMReS3fJeYC8qHMtnBcQzkFyV
 /PKo=
X-Gm-Gg: ASbGncsUIOK9ropn6wx2angdt5nrxu95gYZ5mDx1uPajaioTauqKKTNzv/nDZNX5RKQ
 HqypF1/5zMiXAxRfskpLJdlAvIiNlo+Oi/4Wipc5IidGvaSBUSsbc9DYJe2JEjnc4Az0PgXO+2C
 /c7BceLV5sPmREccChRrTpa/PArUNDdf4+S/LmX8xREWTjA4wtfc3h4cEPY9IlkC8+evVcIO5ic
 FJpgCB+t9B5Qs1CaOZSb5yP8j/eXGWGF+1gxkjl0tdRt4EKJfce2TJjUEhdStNLyhoMa9HQvASw
 av4eo0khCWZ8OoDQoIRHP5ER0sTDETs=
X-Google-Smtp-Source: AGHT+IFY/3+eBZWJ7EHzpdwrif197WPGzagtfAl/SSV/+Dwl/w0NzZLfumF7wZgZM5vwfs/uUg+ZAw==
X-Received: by 2002:a05:6000:1acb:b0:385:edd1:2249 with SMTP id
 ffacd0b85a97d-38a87316a81mr15405201f8f.50.1736719172019; 
 Sun, 12 Jan 2025 13:59:32 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e4b7f86sm10575765f8f.67.2025.01.12.13.59.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 12 Jan 2025 13:59:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 11/11] hw/mips/loongson3_bootp: Move to common_ss[]
Date: Sun, 12 Jan 2025 22:58:35 +0100
Message-ID: <20250112215835.29320-12-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250112215835.29320-1-philmd@linaro.org>
References: <20250112215835.29320-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

loongson3_bootp.c doesn't contain any target-specific code
and can be build generically, move it to common_ss[].

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/mips/meson.build | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/mips/meson.build b/hw/mips/meson.build
index fcbee53bb32..31dbd2bf4d9 100644
--- a/hw/mips/meson.build
+++ b/hw/mips/meson.build
@@ -1,7 +1,8 @@
 mips_ss = ss.source_set()
 mips_ss.add(files('bootloader.c', 'mips_int.c'))
 common_ss.add(when: 'CONFIG_FW_CFG_MIPS', if_true: files('fw_cfg.c'))
-mips_ss.add(when: 'CONFIG_LOONGSON3V', if_true: files('loongson3_bootp.c', 'loongson3_virt.c'))
+common_ss.add(when: 'CONFIG_LOONGSON3V', if_true: files('loongson3_bootp.c'))
+mips_ss.add(when: 'CONFIG_LOONGSON3V', if_true: files('loongson3_virt.c'))
 mips_ss.add(when: 'CONFIG_MALTA', if_true: files('malta.c'))
 mips_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('cps.c'))
 
-- 
2.47.1


