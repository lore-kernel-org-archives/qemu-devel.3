Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD6A6CCD193
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 09:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAmNw-0002hS-Pa; Mon, 20 Oct 2025 05:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAmNf-0002eY-UG
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 05:40:45 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vAmNd-0000QH-Kb
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 05:40:43 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-42421b1514fso2573697f8f.2
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 02:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760953239; x=1761558039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HhXctmaGs+38JQZVNJ1bF9+hCN6zeVUF0eyaD2DT6Kg=;
 b=Xqk6z/kas9vKKHsaU8Dun8vkspyt3RtNtDrK9za5p6yVF4oc84Su8lGIZfrSwArW0M
 hpCquuygBqPP59rDizaLo3Lv/Zrq6j9PjNebsUOPborAfb+9rm6zmrxpzEPOmB6dLJRV
 VKnoke/MzpdLtTHCXEGlcZB8alxUvg7tVa6ol6vVJwB40FqYxseW2aE4KSRhpTN8L+wQ
 SYA8jHmsRXadFtfgEVs0oRSOzshMtzb05w1L4c1oaQPwH07lmuz53mBvD1Ua6wnKpfce
 f9+PX52roQJ0Y1Ktslre1SKifD1xRYbKr5d3iyMcXo45d4qnbxHE8PpJDOQI2dWnFsqK
 eTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760953239; x=1761558039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HhXctmaGs+38JQZVNJ1bF9+hCN6zeVUF0eyaD2DT6Kg=;
 b=aI9StkDFmTKJTH/6AIQwVTnqffV0tHHmvmsBcFJ0n5eYIED3DC8IUHZw5KxTzTFHeJ
 GzdLi5opVr0XsSA5KVKmfzEX8LWvfJ1hMwCpW2cdTtLBXPMAyieXS9tDTijbSpEVH+yQ
 ZfX9x3xn1edwnzJvu6khx+J6jRNta+fgz6TbefNrExJ1AqKmiwjmLYIqHsrToXA2olrc
 1Y6gSuDLccMOR24ShAUaroIZOkRhIhEh1Gf1Y1oyGA+hE3FTGZU6ra/wQ6H1o9ZyOj/e
 sMu6DJ5CQNWR7TMjYJN8N+x72aJDaW1EKWatVN68yAvlfe4TWPZuK37MzAsirkEpK268
 63Og==
X-Gm-Message-State: AOJu0Yz+LKoXHW0a0HiN+V+hy2uIHpEhNeb2zHIYyZonthYUxKzuxT/v
 reinxSR9zxYlpJKm3dqf+J/ttWHXi+Jz3gbGDU8jo+lWF3+w0SSxqw5j7OKeJHofVXgxYeMOd5j
 ZA2+NzlQ=
X-Gm-Gg: ASbGncsftNg4swlfv7ACchmWQDmGgQpGtck9PvWEOe4baHGxen0wJepD1NwIx/kBahr
 ELmxRdMq4tM9z964J0KreYUEsg+EO/FbXxC2Qr0vDPpBV8Y/zU1N7g5bLjwpCe+DCdZ1X+96tKY
 QybVFDUP264nC+++FNXmzHbde6lJZOXNouUHE5L2eUQXXtebiuwgKnsjeECuRrUWmy296wpEyVe
 coluju1RX86ZWO+VztYdK/N9A979HD+N7MsULEB16h2BgIV6lv4WSPaisV9wq7YBEeyDMqqcKMV
 L/yVvlBvvvGVXP9auIpW0LU8fIPWib8QOql5/b5dsUkbly7i2kW+JPDfP1Z6qJzYqMZ+ZmPuNo0
 +XtZe9nKDIh5XqbgUgFzOG5QPJUve+nXvcjGhprxE98yFiwEetqOfAOuWNgHYUs8aAnf/XNHnNx
 BKi2PiU9+Qti2+A0FcUPWlTZoajtzdy/MHAvoZQ13qfx1d5VA78yHie+7oTjlR
X-Google-Smtp-Source: AGHT+IE4NSMVLmGu4k7pVvWuQNyk4Nxhg18lTq9s4W8+u5RtD14bIYkuJnnUJYOrWhnEmWRcBFfROg==
X-Received: by 2002:a05:6000:2884:b0:428:3f70:4b2 with SMTP id
 ffacd0b85a97d-4283f70078cmr4394571f8f.63.1760953238673; 
 Mon, 20 Oct 2025 02:40:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00b9f71sm14388375f8f.37.2025.10.20.02.40.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 20 Oct 2025 02:40:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Andrew Jones <ajones@ventanamicro.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 qemu-arm@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/4] hw/arm/virt: Remove deprecated virt-4.2 machine
Date: Mon, 20 Oct 2025 11:40:20 +0200
Message-ID: <20251020094022.68768-4-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251020094022.68768-1-philmd@linaro.org>
References: <20251020094022.68768-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 hw/arm/virt.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 2eda2d43974..b781a218019 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3690,13 +3690,3 @@ static void virt_machine_5_0_options(MachineClass *mc)
     mc->auto_enable_numa_with_memdev = false;
 }
 DEFINE_VIRT_MACHINE(5, 0)
-
-static void virt_machine_4_2_options(MachineClass *mc)
-{
-    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
-
-    virt_machine_5_0_options(mc);
-    compat_props_add(mc->compat_props, hw_compat_4_2, hw_compat_4_2_len);
-    vmc->kvm_no_adjvtime = true;
-}
-DEFINE_VIRT_MACHINE(4, 2)
-- 
2.51.0


