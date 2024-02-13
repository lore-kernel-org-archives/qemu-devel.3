Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192ACC48BC1
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 13:07:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZsUP-0004Jg-HT; Tue, 13 Feb 2024 08:06:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZsSh-00023h-U4
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:04:39 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZsSf-00068I-P5
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 08:04:35 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-411d231ea71so752435e9.1
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 05:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707829472; x=1708434272; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XdX06BDUj7IHudTjK3BG6Cg14kAdsMYjZQRXHg7kqgI=;
 b=fZ2tdunO+hrdAHlDFES1xg7rcLOJX7jG9vCv3EDmmImiz9xK9HQ04muXiks1DD2TRB
 qlLT40mLaU6sxI740dpnWHwMowRr7EPEIowjljWj/05xQ1Vhg0C/QtuT5AxfZADi0vol
 4bI8bx1B/8xDNYklTrpLzgcEms9ViIaSxkvmchhnyBp6Y2iN0RSc385SEi+vSzePljTv
 r9vEL1NlEjA8VDOS0k/VhB8U55TgOL3wwIsxY+AqMG2mA1JUSw+v4+DHt0TTqNy9TFYg
 3yYZjIrz2+MHti1j4hz1jQTV9cZZODr8copSUzomUSdGW3pqnhHT0ogCF+16zAdJIoTZ
 HBEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707829472; x=1708434272;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XdX06BDUj7IHudTjK3BG6Cg14kAdsMYjZQRXHg7kqgI=;
 b=jDRnZuSovZCZEuNheisEykJM+Ob6h8B0RUrNs35phkKkMdt2vFe6sF/2DiYRiwO2nD
 9jNzGQGqcpyVwsB3lDcyzlEkV4SNsiz7oH9w4lwZVfdKN9ndK7eEi7DQoUWIaC/ys45q
 41/dW3V3AWShVtfaKyi+X5z7OifnlHkTO8Wu3F5yplIxpt8ptEjgJNLdkE8Mj1unYbKJ
 zHFnBGg8VbCTKMp/6zmjh3yW8xb6TmWc6SZ+Kv/MA5OeX1tTik/m/EoW5owOaXTwxtMV
 9wsgkbk3VJQOBMzkVFTxY2s50iLvcnpW5nAMUFzsLiODY2YppboNZTM8wz90CL7TEoFd
 Nbnw==
X-Gm-Message-State: AOJu0YyKuU/Ai3cai0+fDz4/yoGOtwKIuxjBPnzkNDFtVhvxqZInJK9h
 53HQZB60w7OTMqjdUxuBwebnurulvxe0NGSSxCzadxg0tzKKiVT8Nmg+iPNgyY8nXykDF/Qzojc
 +
X-Google-Smtp-Source: AGHT+IHjP1q9+u7f59gXclGWhWgy23ueyU/gGHJyVFNzGznWNhcvdhMJUEqGCXdfiMC464AuYUUo7w==
X-Received: by 2002:a05:600c:5248:b0:40e:f2d6:9dc with SMTP id
 fc8-20020a05600c524800b0040ef2d609dcmr8400422wmb.33.1707829472135; 
 Tue, 13 Feb 2024 05:04:32 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUmsggy1yIJOq36rY3HLkR7YiiALQSWYffVtLb3oeQTgBWNPByqA//REb0fwW0unXcGXBgO1gZ4uRQSpTlBmdmKwgvP7++Ba+zk2ICnbKNtFOvn/afpI5lzkL8/+Fmm/s5uadVYeujphWYJmC5gBHAfzDc/28HnVNtjz3gSk8DFp6X8U1OIH/DAaLTCYJv0imztbNK+9vO2CNW342PmVrlI0w/Pwb86ptWP6fy2s0OAnmIeKAzT6w8IxN/yyKgqhYXVVn1CEedN5thOZh7aBo2SvQtjvNIv4So2uacO5D1SkQ2rEfFBNaNHDeG0o1aQIjAilXaJrvwYeFnUdnRztwmshDZ5osB03ZgqXKpQOrFmv2ZQY6M3iRrCSLbvresstQt17desvwW/i2S+T+yibG7RJ2F5Z9Jcgs5ts1aP1LSgEAyr9Q==
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 o16-20020adfead0000000b0033b4ef142edsm9495466wrn.110.2024.02.13.05.04.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Feb 2024 05:04:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@linux.intel.com>, Bernhard Beschow <shentey@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH v4 07/12] hw/sh4/r2d: Realize IDE controller before accessing
 it
Date: Tue, 13 Feb 2024 14:03:36 +0100
Message-ID: <20240213130341.1793-8-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213130341.1793-1-philmd@linaro.org>
References: <20240213130341.1793-1-philmd@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

We should not wire IRQs on unrealized device.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Yoshinori Sato <ysato@users.sourceforge.jp>
---
 hw/sh4/r2d.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sh4/r2d.c b/hw/sh4/r2d.c
index e9f316a6ce..c73e8f49b8 100644
--- a/hw/sh4/r2d.c
+++ b/hw/sh4/r2d.c
@@ -285,9 +285,9 @@ static void r2d_init(MachineState *machine)
     dinfo = drive_get(IF_IDE, 0, 0);
     dev = qdev_new("mmio-ide");
     busdev = SYS_BUS_DEVICE(dev);
-    sysbus_connect_irq(busdev, 0, irq[CF_IDE]);
     qdev_prop_set_uint32(dev, "shift", 1);
     sysbus_realize_and_unref(busdev, &error_fatal);
+    sysbus_connect_irq(busdev, 0, irq[CF_IDE]);
     sysbus_mmio_map(busdev, 0, 0x14001000);
     sysbus_mmio_map(busdev, 1, 0x1400080c);
     mmio_ide_init_drives(dev, dinfo, NULL);
-- 
2.41.0


