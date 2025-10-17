Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 360BECCD199
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 13:32:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9kY3-000096-Ql; Fri, 17 Oct 2025 09:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kY1-00008i-IE
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:31:09 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9kXs-00080O-FF
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 09:31:09 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4711825a02bso7910715e9.2
 for <qemu-devel@nongnu.org>; Fri, 17 Oct 2025 06:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760707851; x=1761312651; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t7TOtOenWslncjhlwC5SIPbJSYnSgL1bmnbXeJ9sRy8=;
 b=iUzvfA8UeHysrt3xEQi78F2S9Rt66zUAtHdMkMMrY0kvW3sSbMmPwCWsnA57tPGAcW
 dn2TPU38cNLtf60O01I0i9UyA84aAnyDUEC8vBZXRTSeVE3HutcUgGmu3GD2xZRwtkU8
 apJkY22jHM5Ctm86gWKxzTvbLZZ/MatzAQFQ2Mhq8ENwI5b05XOvyk4zo+ajuVkMiGwQ
 m1hHIdhMHCnTwk2NlRP5t2z2KYql+gMIYBx7+Y6QASUtVsuj50Ogm9yVGgEzAF4fW0IQ
 5cygqJKfMvm1cODtftgHC1/45ddpJw7RGZAy83JUH/WkOR+s+/p7+fSFMnYxt8408Il+
 xQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760707851; x=1761312651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t7TOtOenWslncjhlwC5SIPbJSYnSgL1bmnbXeJ9sRy8=;
 b=e1CO9V2yHXnpYjdDdE6qdVWfguZ0HmcmwKjaa9Ser5LJXKdTDC13PN731ZAXnTUiNQ
 HTUVjorgeUOGePFIKU9rXbwcwV3ggE4wLnq/zGXMWtl9/fSRyOTnhNyBzp40JVI6ZgSH
 MU88OIWPx13R6d8GA0Po47f0pnbmxkn8xWg3cW24hkZUNxxXQ9TIfKIH4NPdRLLS5gob
 cCQ2B34Anes3s+h0je+puIIdKca916wiHM0W0znAq13vHbWttBna4wjaC1ts7KEE/Xp8
 xXHLBzMBA2PUGftTavhUNpBtsdH78mIolIrI95d2NxIY4Ef6H/7f+A+81Kl0m59ZsZsZ
 Ztwg==
X-Gm-Message-State: AOJu0Yy974vBido66BjGwaRXtuxd98ht798JHiootmswd1ONnsgsVsFf
 AiQeSUrUrAiKLCXpg5yk3hfwj0NxdNyshzK2ZCpzYzGxDgnleqlAuKJrZtvYtPviflnE+aQEnGw
 a4HqloK0=
X-Gm-Gg: ASbGnctimCl5ebYBjqEeCTgACJRVvng6eULBgos/o60i1M09whFhoMIhKZ3zoYrD7ZD
 JpKjmKI4dfP8C3PHoby/50Q37QD1HysVUgCrHhlZIq+C5bjPPllAfoKIArVPibft7FSRYt2unjM
 ZN8MN8ec0wz4lQp49TwzLS/Ch0w7msRBXN9IOl2q8hgoy6T+YuqJzyMgd6W/Ag6YUBZd51GfLIr
 bbp8Aa5d5oOoHRzTgh3+e/oWbrt/ARYsdP8o1I3o6RNYmnoQQLZFWKbZpDWgfJBoUsI5omzHrEr
 A9qxX+1/lFOS/jdwHAiy4Ec4Za9XdUBHv3pf9mK1SH+W/xx6BZVpbi3C43eSgTw+W3nIsSZCY5I
 cqgl67r6D9mHkGEW+uAcn6fctUXnzxRkmFigNyclDpvmoVzxQWrErOOK2GMZVU/icWABqLcQXAd
 RkturbAbNvdvJRgN7UQ4lsNbUJqWgtEAGGVRzgdgtB+k3XzvJZ4SHkLsWHR4G/C8uXxzOSDKY=
X-Google-Smtp-Source: AGHT+IH2vIW7p3d5yHPBsbCzVJ3XlhtQm5ASTK/XXkyCxV7jIq9HeB24hCFecZ6Rz1Q70lHJlTMZEQ==
X-Received: by 2002:a05:600c:450c:b0:46e:38cc:d3e2 with SMTP id
 5b1f17b1804b1-47117906a23mr28302735e9.22.1760707851593; 
 Fri, 17 Oct 2025 06:30:51 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144b5c91sm81198735e9.11.2025.10.17.06.30.50
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 17 Oct 2025 06:30:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 09/12] hw/s390x/ccw: Remove deprecated s390-ccw-virtio-7.0
 machine
Date: Fri, 17 Oct 2025 15:29:58 +0200
Message-ID: <20251017133002.61410-10-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017133002.61410-1-philmd@linaro.org>
References: <20251017133002.61410-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

This machine has been supported for a period of more than 6 years.
According to our versioned machine support policy (see commit
ce80c4fa6ff "docs: document special exception for machine type
deprecation & removal") it can now be removed.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/s390x/s390-virtio-ccw.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 319b597d12b..942b1e5a932 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -1046,21 +1046,6 @@ static void ccw_machine_7_1_class_options(MachineClass *mc)
 }
 DEFINE_CCW_MACHINE(7, 1);
 
-static void ccw_machine_7_0_instance_options(MachineState *machine)
-{
-    static const S390FeatInit qemu_cpu_feat = { S390_FEAT_LIST_QEMU_V7_0 };
-
-    ccw_machine_7_1_instance_options(machine);
-    s390_set_qemu_cpu_model(0x8561, 15, 1, qemu_cpu_feat);
-}
-
-static void ccw_machine_7_0_class_options(MachineClass *mc)
-{
-    ccw_machine_7_1_class_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_7_0, hw_compat_7_0_len);
-}
-DEFINE_CCW_MACHINE(7, 0);
-
 static void ccw_machine_register_types(void)
 {
     type_register_static(&ccw_machine_info);
-- 
2.51.0


