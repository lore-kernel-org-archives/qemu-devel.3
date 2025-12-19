Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E21E66891
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Dec 2025 22:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vWiuH-0001cB-AA; Fri, 19 Dec 2025 17:25:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vWiuG-0001Z4-AR
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 17:25:04 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vWiuE-0004ku-R5
 for qemu-devel@nongnu.org; Fri, 19 Dec 2025 17:25:04 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-64b7b737eddso2320854a12.1
 for <qemu-devel@nongnu.org>; Fri, 19 Dec 2025 14:25:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766183100; x=1766787900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+nO01E4MIADXT/2dtH7ndROwg87mD1wMVfQOgnul++k=;
 b=io+dfbhOL7RtC5CnCm94Du5OM4Wh1gZRy32EVV3VOm/fTNnbj0aoFpfPRc6NdNAi1m
 c7zgTbkAytloVq3uAB5JzOTnrNKlLJ7nePZpQFhfMOi141MEl0mDTtPv15VHLh6RhYXW
 bNUmHm6YctTWUw/VQre6YIsYhpjn2Y3PKMJq3+A9kFKRC/xa/VuV3NSwU1uCUv7nkvBS
 /lMehgaLGo3re4aeatWnnGhjuu2ojf7fs85xNTnKNbKUQwLZ2oCrbbyPL55YYJd4taOb
 PpJe+ZuUS14q8dvJPAcywYb+12IG9riDqQNrSI3pvyAXG7buRb8DGAflPxWTe7h1lMCM
 +oTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766183100; x=1766787900;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+nO01E4MIADXT/2dtH7ndROwg87mD1wMVfQOgnul++k=;
 b=sFApylCUOX2SkVr0TPzajIR6KdZZX3PbGsvCtVOsBZR3RjFqWoHp0gTfDXTRucrLWb
 V3X9k5GJbBlERztJI0jqu3GGidDhUW61fl5hFQEVjMeuR14qdOMd3DpFrroVIiqV4rLq
 Fon+71J40rhelXioIi+fTIMFif7+/as/MEBfUE+J2IZc0wxvZmOS5gCTKKnN0+h3nJYf
 eaUFh5zSNOgLOFHX+1n/5pG/JzPAJdysl2fYwnxl79i2fPtN4+G629PSt78g7pamMujC
 2W/Zb9jjtEcFbO1GweaYZ5Xodj5zciz2zuvfjmjOkgnwqV/I6npb4o8/x//AK+HXc0b1
 ygYQ==
X-Gm-Message-State: AOJu0Yyvq+1kY1gVINdY+60uLhT8vScsfG6raTNitdTkMvgfUbP73mtf
 aL5xPMQPrxhN77MdcajIGFXd7CEQ7mJlliSvMmiWkHYE2w5Rzl6FW91Rei3+uoMk
X-Gm-Gg: AY/fxX4baslKwUlvkYQ37VZAa+h7ckj4eC0/dGpmglbffNuHN7zZi5AFS0NQiUe41Sk
 Bk0vG2KAuWbn+LQupmrb2kS7Rq7uxYUEKS9/wuJgY5Zl0sEOXVF+MxOceoiQMvk5UJv/HeVZgyj
 diJ0jcAra6fDc353UFYy4YecXxqn4Sr03TXiRa8Gk02zJoE/tCkJnZHbpGlMXIuoRdOeUlx1PsR
 ThFLaQORItL0eg9ApFSRA6vmMSrr8BGT7ipPPXI8R62SYag95Ti0R9HYKgktBUSSA8FR+Nx5/13
 I4zxC8Orct8ywVUdhsy5R9aaUZBB79dcb442+XHzAPcQynfpAJGRDsRGOabV6E50bQmrlvscASu
 kmUNDM4wQOhHrtphj+5ryFOhzZXCC2t85yocVh8ADW+YcXFAY7ilQU6TpQ7Jia8MQdl9cUDV+xD
 1Aym748bO61mW3eQwsyUCilotng9+6SQYxH0ASEj2zLlMzkpBkkTayM3C9CddIOw==
X-Google-Smtp-Source: AGHT+IE7wnvl5gi101Uak0L2Lm65OyLDDOCkirf7zKkarEIygrpJ3MVQq14yHDAsi08vGIs4oxbjuQ==
X-Received: by 2002:a05:6402:27c8:b0:64d:1a1:9dee with SMTP id
 4fb4d7f45d1cf-64d01a1a07cmr974935a12.16.1766183099501; 
 Fri, 19 Dec 2025 14:24:59 -0800 (PST)
Received: from thinkpad-t470s.. (93-138-210-222.adsl.net.t-com.hr.
 [93.138.210.222]) by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-64b91599605sm3237440a12.23.2025.12.19.14.24.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Dec 2025 14:24:58 -0800 (PST)
From: ruslichenko.r@gmail.com
X-Google-Original-From: ruslan_ruslichenko@epam.com
To: qemu-devel@nongnu.org
Cc: ruslan_ruslichenko@epam.com, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com
Subject: [RFC PATCH 0/6] hw/arm/smmuv3: Add SMMUv3 sysbus support
Date: Fri, 19 Dec 2025 23:24:33 +0100
Message-ID: <20251219222439.2497195-1-ruslan_ruslichenko@epam.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

By SMMUv3 specification it can be attached either to PCIe Root
Complex or regular IO bus devices. However, current
implementation only allow to associate with PCI bus.

This patch series add support to use SMMU for sysbus devices.

One usage example implemented for virtio-mmio, which allow
devices to perform DMA operations SMMUv3 with address translation
and isolation.

The patchset has a basic support to create multiple SMMU's on sysbus.
The next step would probably to add qemu-option to create
arm-smmuv3 devices similarly to PCIe logic, e.g.:
	'-device arm-smmuv3,generic-bus=id'.
This is not implemented yet.

