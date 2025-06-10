Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBCAC678DA
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 12:57:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOyXY-0006np-0g; Tue, 10 Jun 2025 08:57:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyXX-0006nY-6R
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:57:19 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uOyXU-0002cM-Rr
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 08:57:18 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a375e72473so2757534f8f.0
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 05:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749560231; x=1750165031; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pACGd9aRRNLDY6rAI3jpVfxGD06wCRoRsQs9qD7T4XI=;
 b=B3FCq3OVioCshWL3BsMS3hEzeaEC3pMYbjFhMJKxLUIJS+MmIVxWN2oTyJFCVC06jA
 6m7S5szdwVxK+XvUQPtcQ04c5OfAXelRoaRcfOgH/tm5bUjV4jgVB1aJE6bH1d8d90BH
 mfLdWvUDy5TGHaBop5hPTPg5zLoyjy3C/bgIU3uvLwCF4wAZXIL7uv5PvsyxhlP0+8cn
 SvTOt9mu3kxSHLm6t8WypoeB4uzCPsGteZ1yFnQ+eZoEtU6FdtHRK0Y2ISM1t7Ff4k+8
 ZAViZjysk8r8GTEycALU2X5X75b3563nv7vSbnKHliqhlX6WNpC6sLr+dgGMqPNMYG+f
 oruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749560231; x=1750165031;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pACGd9aRRNLDY6rAI3jpVfxGD06wCRoRsQs9qD7T4XI=;
 b=VGeE1//f/HG6z1dVBXkHZDKNfj7dFhW/oZ7b7FhagFaFQ3/S8jol4fXvvWf1DjKZ+2
 3kw1Rid3S0WJ47dGTaQ4/4hl9kRqk2bTJ0ouRQh+dJtz3P2V5QgwXgdm+m6ACwxkosmb
 3hli01N1mHFIwtibJNfAnZzVSO0987vyCT4ZC3MH7bVKY0Vjfb5nZEAQYCwE+6/4JZHn
 2yI1E4q0wXaLWoWvoeqraerRzBnNXa4kaYhuEwieXXboOV/+YbTTZUwemGoJO1tr+bg0
 9eWovdWuTeiF01qcRcJ3Die9Nzdw1EmdITRoFNHVuxgwUqh+fPErp6pPbZB6xW2RxXW3
 Xo7A==
X-Gm-Message-State: AOJu0YyngUQvPVzEZr2eGMFZ0GIbHc0gmWiW53isNrWhVTeDpXlCdgVk
 ubK+7e78wvNpqVid1klBa/X/tBXXfziIUxnarLyogW6OPY+VHbswHL4pPRy6erv5VuOvTVW8IiF
 /ITuCDWg=
X-Gm-Gg: ASbGncvlj1z48YhsT7KzYMyShWdRzF1yW342q9jd2VUIoYRix7J7ioVf+1CNbSEn8PR
 mRkMNyI6LQ/2gHbVziuQwCIbA2Q+iELfCML4eV2rcs6PBTzlY2hIRSVW1DKBNTD5ECsQ22QMTiF
 q+XlcGXnLwGGeMdUGkDBWqBh/xd03l9SIYQ9w1+XLVMWdrSAutTqE+y4Z+CyS3R43T2+DUS4qn1
 0PiYKEeOd5FWSPCgOJU+ZBVKH+086ye5t2iz3zPAfZ79sS08FdKzm0AhTJ984v+BkQPsrzhH3eW
 wUbYuuFRJofpB9vAsgf/q9cf+74uJTFTugQzHtSvouke3tvdAJuHpIfEaC9BljsjX0KO5CSGNOm
 MPlcWL/Zgp8YgTTzo/vsxh+wlm9mj1j2PRMtHe+TbsA==
X-Google-Smtp-Source: AGHT+IG8N8MmoWXo7meZRdTzxnuNX0XgZdFlC+CiHi5F/ZvEr48gEOhaetKBNyb1O2o7zl5EOGB03A==
X-Received: by 2002:a05:6000:290c:b0:3a4:d8b6:ca3f with SMTP id
 ffacd0b85a97d-3a5318a7c04mr11661952f8f.30.1749560231443; 
 Tue, 10 Jun 2025 05:57:11 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a5323bee86sm11989585f8f.43.2025.06.10.05.57.10
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 10 Jun 2025 05:57:11 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 08/24] hw/net/fsl_etsec: Set default MAC address
Date: Tue, 10 Jun 2025 14:56:17 +0200
Message-ID: <20250610125633.24411-9-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610125633.24411-1-philmd@linaro.org>
References: <20250610125633.24411-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

From: BALATON Zoltan <balaton@eik.bme.hu>

Use default MAC address if none is specified by property as done by
most other network interface models.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Acked-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <8bd7ca691bd502b5fd761615d9af805e783fba36.1748012109.git.balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/net/fsl_etsec/etsec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index d14cb2a1015..846f6cbc5d9 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -389,6 +389,7 @@ static void etsec_realize(DeviceState *dev, Error **errp)
 {
     eTSEC        *etsec = ETSEC_COMMON(dev);
 
+    qemu_macaddr_default_if_unset(&etsec->conf.macaddr);
     etsec->nic = qemu_new_nic(&net_etsec_info, &etsec->conf,
                               object_get_typename(OBJECT(dev)), dev->id,
                               &dev->mem_reentrancy_guard, etsec);
-- 
2.49.0


