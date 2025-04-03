Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D837C3601E
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Apr 2025 13:38:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0KkS-0001ab-GE; Thu, 03 Apr 2025 09:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1u0JVQ-0000Ky-Ik
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 08:17:12 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1u0JVO-0002vN-Ln
 for qemu-devel@nongnu.org; Thu, 03 Apr 2025 08:17:12 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-abbd96bef64so137886266b.3
 for <qemu-devel@nongnu.org>; Thu, 03 Apr 2025 05:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743682627; x=1744287427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ylVDvabhlUsgaY1uD9b3R6RDStdz7jSkppf/KZ1Z9Gk=;
 b=BNCud4G+6p2WywLd+lBDEyZlmTga1dvZQ8FstMP8aaSBT29uHh4duvbSDpiLJXTYE8
 ED9KxXdFT8JqCiwTx2+cGSR0Nq/R/HVhY1ymIWzeBo5EMd7fVTIUCzLcxBbBtnmWVDO6
 6HH4jgI68blRz3PopfHckYcbBI0bnHazLmcRGkSzdfTDko136yaPyJyYCAZOtglo8dD4
 SQi70HWg9YuddjHG1e9MBMagRmlvteIHuLtcyonN+ontFR/w6y/B7E4cy7cB2JWYRcaV
 nskmPrSkqZvXTBlELLcJkYQ9jYVyInC15a5x1WbvYGb1b1yVZQIdu0xSZEQUKZk8EPPa
 hZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743682627; x=1744287427;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ylVDvabhlUsgaY1uD9b3R6RDStdz7jSkppf/KZ1Z9Gk=;
 b=X98JwaHsnSM2ibYf/nGGJyYh46mCp5NE1gq+uBj3pCeJTE6/pmKYqhEmWuMRfdrehp
 RkLGhTtIjXQ/5JsKjI5h1YIjV/JwM24YU9C7BghgR+g5+f87cClWS1WxYk5fRz1Sw2HS
 PjopJiqhTZSNSD33qp0xr8lYmUB7O/LaqhL77BQ7sRHQafIlgHNv5evBfYKY/JzFjaFV
 GUv27gd28TXELitjipan1E76Zq8Q0wQzn80O8QKgKOgxbGZYlACe6+WQgXDUlqiM5paO
 Wnrvz9Hny8Hbv81IdqTig1V0zcJdYj93mYyVIz+KJcxiey9MmoEefespBRVNVZwoSqaw
 dfPA==
X-Gm-Message-State: AOJu0YxFt+v6yqKvEvE+Roi/8WGT+zteztczOQeedXfCRtND0sZTLhQm
 kaYvDXxeP8qChIebP9p0RIVTw5KGEAM8KkZL9GNSR5UhQERkZofFLdD58ya7qPMkGNOxFK4lJQ9
 kdFw=
X-Gm-Gg: ASbGncuUyNyv72t9u+PU4yjgG/yjIxl94zA2CIa6SiDtUo2K3ayxSPJivqdCMCaUj+w
 MKThwyzcFYNTyrdxj2xl6uNj1Wm8yeEW6rsbO8UBlK6IWNkmSCspVbBE3MVZL0Au9NEDCluQFiQ
 tcrjdL3lqqEIyrDtoIU0xzTrama+aXRDPEEprLADLzb1g814CO0LQIdvEOV7WGngM8uLQ+AkLxq
 3qAGUFpV4ij+51064cGCEfDx8GnvUtltF1CsQrEx/nc5iLHdgtScJbTiel8sKwlp//IO6z4Wl8f
 PesJ+Yq7pLOXhx8waF+CXU7736598zTqk9jymAU+SON2HyV2EJk0OL/07EyzsIPm2/fneZ3WI/n
 24iadHbQN8jK6vHR55cYFfmLu9kVxlg==
X-Google-Smtp-Source: AGHT+IHpTB2VQrKgwCIqzIhadiyKCioxX1Mrpb0TnYJ7ZcnJjdccB/uvwIEQ52gubrBkoxuOD6vvlQ==
X-Received: by 2002:a17:907:1c08:b0:ac4:3d0:8bc6 with SMTP id
 a640c23a62f3a-ac7bc0d2cb3mr208228066b.13.1743682626620; 
 Thu, 03 Apr 2025 05:17:06 -0700 (PDT)
Received: from localhost.localdomain (adsl-37.37.6.161.tellas.gr.
 [37.6.161.37]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac7bfe61c15sm85641666b.12.2025.04.03.05.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Apr 2025 05:17:06 -0700 (PDT)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v1 0/2] virtio-gpu: fix blob unmapping sequence
Date: Thu,  3 Apr 2025 15:17:00 +0300
Message-ID: <20250403121704.2754589-1-manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 03 Apr 2025 09:36:46 -0400
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

A hang was observed when running a small kernel that exercised VIRTIO 
GPU under TCG. This is an edge-case and won't happen under typical 
conditions.

When unmapping a blob object, its MemoryRegion's freeing is deferred to 
the RCU thread. The hang's cause was determined to be a busy main loop 
not allowing for the RCU thread to run because the kernel did not setup 
any timers or had any interrupts on the way. While fixing the RCU thread 
to run even if the guest CPU spins is a solution, it's easier to fix the 
reason why the MemoryRegion isn't freed from the main loop instead.

While at it, also restructure the 3 stage cleanup to immediately respond 
to the guest if the MR happened to have had no other reference.

PS: The hang can be reproduced by running this unikernel with TCG 

https://git.codelinaro.org/manos.pitsidianakis/virtio-tests/-/tree/8c0ebe9395827e24aa5711186d499bf5de87cf63/virtio-test-suite

Manos Pitsidianakis (2):
  virtio-gpu: fix hang under TCG when unmapping blob
  virtio-gpu: refactor async blob unmapping

 hw/display/virtio-gpu-virgl.c | 37 ++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)


base-commit: 0adf626718bc0ca9c46550249a76047f8e45da15
-- 
γαῖα πυρί μιχθήτω


