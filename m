Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 386F0C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 19:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg87A-0007vz-53; Fri, 01 Mar 2024 14:00:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rg877-0007vQ-KR
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 14:00:09 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rg876-0004Z6-41
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 14:00:09 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-412cb23625fso4369645e9.1
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 11:00:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709319605; x=1709924405; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LnLg0GlDlx8BY5bqC0PJRd1qke0B9SIhpAt2ftapvRU=;
 b=MvAF5qYAfpApw60SfBfomJe+4cnnEgJx3jWq1fkrqupNN5ePuWaw7n2ZhVNlvAmatM
 d3fAZkyN+WQfhxC3KHJL1IA05LWwVEzz18DRJSb7THcUZZ4HQ/YeyHoykma7zIQc+Yy2
 bneI6tC452hqvnqrDo2PIPUhyKgEw4M+b3LHDb3mn5liCQeNgGKr9tXD6mQ1a/4sopc9
 rZ1/gKw0JVRCEHo5++pdRoTdEZhYWNmEKnUjxQtkqY+922ds2mhr8SbFuPqbc64KqHur
 ZxOhHweNp0ImeHyU2dyEF2ghj24/swzTQVf+McY3l19xrB+9PiAJFbsF7HaKjup1HoqY
 I8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709319605; x=1709924405;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LnLg0GlDlx8BY5bqC0PJRd1qke0B9SIhpAt2ftapvRU=;
 b=a24OMi4DXT3fCHWRsfjNhHP18u1Lih8DPAYA4LYz3jrx6new0dhxouUTz0wCyJQBrZ
 nzqRWimNg0kAt7V130EQYL+cEzV5n6FTvIpAD8r60LubYp1Lk332EYN8Fl3vkLAqQBjM
 sFLe5m6tisxnQwgP1zr+/ssDJnAGHn8Qk/sdU5qcmMDrgG1nCpZ2gUovad6VwoRUXfHQ
 QSrY+mTyt9sXqcyZjBAqRUCuro4/z1wIWckWGxSQbE+1qMap/51dhX7RwlApfqeg/cHL
 HOC0bXyjmsle5XgfwXiBJoQjd+C3zTJ34Db7/EXtvBJKyAJgqseKeduWwE0EQSX4kvVJ
 LzbQ==
X-Gm-Message-State: AOJu0YzrOUN1vwDVPrpSmXWzaJ1/MQO+/9ZkH9I8PrnjZSYauxXxCqGN
 QDROUND0MPWQ6QmmG3sqIvS+0cuQQVl4QmcxvvtPqSDkeHVPBPF/WjuuLB2flZ3ObOeCG5prqGv
 UPWZ1+g==
X-Google-Smtp-Source: AGHT+IH33H41lDOfST544btGajVoGmRRg7xrrsYQtc557NsKy2IH4+1lf6fVvZumzZ6qZ6kiRovElg==
X-Received: by 2002:a05:600c:3645:b0:412:b30b:e47b with SMTP id
 y5-20020a05600c364500b00412b30be47bmr1754728wmq.27.1709319605315; 
 Fri, 01 Mar 2024 11:00:05 -0800 (PST)
Received: from m1x-phil.lan ([176.187.210.84])
 by smtp.gmail.com with ESMTPSA id
 dx14-20020a05600c63ce00b004129f28e2cdsm9186404wmb.3.2024.03.01.11.00.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 01 Mar 2024 11:00:04 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 4/4] hw/i386/pc: Have pc_init_isa() pass a NULL pci_type
 argument
Date: Fri,  1 Mar 2024 19:59:36 +0100
Message-ID: <20240301185936.95175-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240301185936.95175-1-philmd@linaro.org>
References: <20240301185936.95175-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

The "isapc" machine only provides an ISA bus, not a PCI one,
and doesn't instanciate any i440FX south bridge.
Its machine class defines PCMachineClass::pci_enabled = false,
and pc_init1() only uses the pci_type argument when pci_enabled
is true. Since for this machine the argument is not used,
passing NULL makes more sense.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i386/pc_piix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 400b1c1e15..fa5f93f99f 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -449,7 +449,7 @@ static void pc_compat_2_0_fn(MachineState *machine)
 #ifdef CONFIG_ISAPC
 static void pc_init_isa(MachineState *machine)
 {
-    pc_init1(machine, TYPE_I440FX_PCI_DEVICE);
+    pc_init1(machine, NULL);
 }
 #endif
 
-- 
2.41.0


