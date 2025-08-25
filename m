Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42D88CA0FE1
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Aug 2025 11:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uqVGE-0006fp-OQ; Mon, 25 Aug 2025 07:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqVGB-0006e1-OV
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 07:21:12 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1uqVG7-0004XQ-A8
 for qemu-devel@nongnu.org; Mon, 25 Aug 2025 07:21:11 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-55f48d62057so452406e87.1
 for <qemu-devel@nongnu.org>; Mon, 25 Aug 2025 04:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756120861; x=1756725661; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IMI6xQ1cHbmfMoFiMMverDrG0su+7XxOrvMMPNwbWlg=;
 b=RVUyFeD9zwkzLstyhup6E3xZny3aOsh3p3GAVtHEUQkX7LGY1VK3aZ+y+OyhbMNv1F
 Xtwbn9B3cRZtbinierFQCwIshmit06rWFDibg2aPwItqIJ9Cjz/mDleU5AFKrbZreCRu
 t/sEGMSirdPzw3dm5McO6q6OstTYP+UIeZHN0Gt/MQFJ5eInbUfrFqx2aIh0xWuaXrnv
 W9WvRwda0yXYPf6uZtVU2pkWO5pSbg+29n87wyqz0JEELAf3zQxuGPRCkaEU+2ad7FZe
 f+3u3+ZoTBAzGrIDEndB39Lam2kFgv3Q+Y/gJhOmPXqn8/xK2UEwQY282ZYkiTAfzwcv
 S72g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756120861; x=1756725661;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IMI6xQ1cHbmfMoFiMMverDrG0su+7XxOrvMMPNwbWlg=;
 b=EQ2te3nZttdVWLvgOoEH9iPOPNvFbkH/DArUQ0ETHalYpeDZeKcL+AyvjKbBJedSCC
 SuXyZ/GmgErWHdyGlyg4+8eo5IZlvmwBwvqS5aaJzsxx8Mq2Gy7WXV5X2s7j+MlV+6uy
 UkLtU8AneAtDrsGG90O56VH7XA1MsIg02+FBhuxVEFhd2dOs1MrJBJrQDgyihObGu0w5
 8QtQ3SY/5j1IceAQCJQmFp7cR1G7WUJPuxdTd3p/z4xNdeAc9MloL8qxydq1IoUdX/a1
 yse0FsMCDTdp44JCaYlyoRbycwfeUcKpI8yP2JqdKtQKing6L2svTfd+j0zy10lmR2of
 ZhvQ==
X-Gm-Message-State: AOJu0Yw06wMsvqW35mE/y9gtbPq0Po/L0t8A8kYat6gfyA29eodUd2xj
 qkwm3eUssi0TEZvdrOCqqCXE0JeCKMLLLqCMvFfqgVDZZSiRCAbD2pLeqxgPeWAC
X-Gm-Gg: ASbGnctpaPu3FLTXAY78YSlZH3u5lJCdbHLKHWhpMcpA85liqToxul7ckbgPaq3Ll1W
 OzXskrhlLevNRCw/2enS7WU9PeagLNHhLjrja8ifV00cUqLyyZH/4do8z0CERKlZX881kcw86iU
 +Px4A4WbMbmz13c9Qiwh3esbfyA/3YD/umW49JC7ZluVQWSRLppk1rQrmu1YDiTToWMN5MJtWz6
 y7OJxbmzA+5TtFP2Oc2TsrJP5gTkPXIFwD6n596RLFb8OwRtbpIxB5wwFdnqF5LpV6/t2q/EimA
 +C5i1pCJs+gCKOO6e5HWmFzNkR7f9JVfoPUWuVKrTBx2R9txZytlAeXttj7NrrB8394oahB+k5Z
 POLljG5q0yPEJWM0zpj4KLf0L4ohQBv/piScXfz5s+ri4laEaVIABt0qvdTVz1wY83GUcbA==
X-Google-Smtp-Source: AGHT+IFwCUI4U57+KwbQFfsbyIPs71HaK3XxUSnQYWeALdcnGKUVjlnpRFEh3aCOBL0dsdJjB2mT8w==
X-Received: by 2002:a05:6512:630d:b0:55f:4b3c:57d with SMTP id
 2adb3069b0e04-55f4b3c0661mr22050e87.28.1756120861219; 
 Mon, 25 Aug 2025 04:21:01 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-55f35bffafcsm1597016e87.17.2025.08.25.04.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 04:21:00 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	philmd@linaro.org,
	edgar.iglesias@amd.com
Subject: [PATCH v2 0/3] targets/microblaze: Handle signed division overflows
Date: Mon, 25 Aug 2025 13:20:48 +0200
Message-ID: <20250825112051.4155931-1-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12d.google.com
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

First a few preparatory clean-ups followed by the detection and
contional exception of signed division overflow.

Spec:
https://docs.amd.com/r/en-US/ug984-vivado-microblaze-ref/idiv

Cheers,
Edgar

ChangeLog:

v1 -> v2:
* Fix ESR_ESS_DEC_OF from bit 20 (big-bit-endian) to 11 (little-bit-endian).
* Rename pc -> unwind_pc.
* Squash patches 2 and 3.

Edgar E. Iglesias (3):
  target/microblaze: Remove unused arg from check_divz()
  target/microblaze: div: Break out raise_divzero()
  target/microblaze: Handle signed division overflows

 target/microblaze/cpu.h       |  1 +
 target/microblaze/op_helper.c | 53 ++++++++++++++++++++++-------------
 target/microblaze/translate.c | 12 ++------
 3 files changed, 36 insertions(+), 30 deletions(-)

-- 
2.43.0


