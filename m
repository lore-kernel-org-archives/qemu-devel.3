Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0091EC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 14:17:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wevkE-0005kf-3H; Wed, 01 Jul 2026 10:16:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wevjr-0005Wo-Nf
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 10:16:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wevjo-0000GX-GW
 for qemu-devel@nongnu.org; Wed, 01 Jul 2026 10:16:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782915387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UqBgkjj4+5qCZafjC2NJKdGLFc9kuK531RBFru072RQ=;
 b=PSVrZCtzb1Dktf87H83k6Yt5elPcfYNCSkJAWm2Dw4WOu3vhBMWj+/Pj/ow5riDaKIdmTs
 BjKuIalR4XiBjsol2OKuRwhcakDgeXAs8zyRq6c/c6QvxCrfPVsOjSj86Rux0JoZeQSakv
 olDSCFEdKriI2AouO7DXNBZFk/CcHjY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-206-a_hFSWPIPkCAI5L5K0jyCA-1; Wed, 01 Jul 2026 10:16:26 -0400
X-MC-Unique: a_hFSWPIPkCAI5L5K0jyCA-1
X-Mimecast-MFC-AGG-ID: a_hFSWPIPkCAI5L5K0jyCA_1782915385
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493c36b290cso2570015e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Jul 2026 07:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782915385; x=1783520185; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UqBgkjj4+5qCZafjC2NJKdGLFc9kuK531RBFru072RQ=;
 b=RlmifWen4HQ+geolFaWHakl12BpGLy36SIRBRy/DEa+gsPJdOdNwFG7LkAv56y3QGo
 +P/uMZ05bT0hb8pPeS0huCBu/NdHq8KW/gdumeO2qyNNbpHR3/3gfYwbfI8wYhi7v5A8
 v7qBkc/TeIRECK3zofMmgoAZUK8pUzqsF2Xi3YXuDQkCm0RMcjJQ3nJjVylvrOaD53Zr
 1M97hao2U/2m6efGctGF3OC8LDLWt1wwo/H7lU2/nJEtK2A/UQ7qDa4fF+hX/Sqs5jCJ
 7I5cl6L5g99cMRAf99PTsShPTxv4XNgKpU1oCwBw8Gt+O0E5yk/U7Dk3lOTp0BmvZU05
 /rvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782915385; x=1783520185;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UqBgkjj4+5qCZafjC2NJKdGLFc9kuK531RBFru072RQ=;
 b=OXXzk19na76MbvuQVZ2E36wVcJp8LJXWr7HJT9+oRdYOv3Fp0HQ+NNt24vzqf74gSh
 spbl1L6zYpibvzdgDLugVL8h3crHS+oG+v8gKxjz2S0KA0syJjyOFEpm9+vBo7Tl1C7V
 VBIfRbDugCuMBQrAMMQBSMLfygRExBRpGgzzXHhMfo9QHhNgivud5bSZWzqAQuvSY/WJ
 DwuTozx6FwZYMBGtIvMhvVtJ0i48/IOCU3VxC9YYqTNaI/+siiYDK/aSoBq4ZpgTqo++
 JgQqT786xrAfUYlq7Nsx7ZKfz03R36cp8J2OvG0HWp/iEREEWplfwqB9XZvbxYZQVjcW
 kAcA==
X-Gm-Message-State: AOJu0YzBLmSmIeWpe47lUK5WLaFOMNWRFsVXRANn6HbnD0e5Vb7KpbzN
 1ROEuA5mk8u44mI4fHsrDwwMAqxrCQ0JU780oKi13FSxYKpWHk6zNMk15dxn36TL8TM9nJvj2vQ
 MzFJYb0c3TVoRwsNKoy6HRIJInuFjY032yOJQBekEdXPbVJaOU7yH8xCx
X-Gm-Gg: AfdE7ck2OR016AWEs1h5dx4pf5uLivHbv0KJGikxZqpSAsRivlQPpPOcqknrZLBE5lf
 oiNs92oEpAmSD8sSilVN4CjhZfH+BG8MvNnUhY7A+Cta2wzhBkyoB/nqjIzjHorLKS42j/8LH3I
 DvwAS+haacDYHZ7A9zSdVXvE5WotS4k3ROyO8qJGZgRSyoiscDudO/wRVmOvuL7Xtjr9XMhk+VF
 efFomgpgLrgUcKmvBAFgPbNqpY8OoxMmZeDe1plJKX1smAPzYmmEJ/kd9YDUaotUzYNlUk8bwHX
 w5LXVEFFmenNNhMtVc04SyBS+UrkI4rSz3xHwwaYoooQkSyNxwT624xlXhTfzzjGkKa/bkBITAj
 aBVcpTzazRy/YvS36Zh5m1CXJ0AynwrNKLh2I2J3p05dekfnJzeBRqn2wvp/iZA80Cv+c0Jl2IP
 SYP4xP
X-Received: by 2002:a05:600c:8217:b0:492:5e71:f6ab with SMTP id
 5b1f17b1804b1-493c2b84c14mr29476245e9.20.1782915384517; 
 Wed, 01 Jul 2026 07:16:24 -0700 (PDT)
X-Received: by 2002:a05:600c:8217:b0:492:5e71:f6ab with SMTP id
 5b1f17b1804b1-493c2b84c14mr29475875e9.20.1782915384073; 
 Wed, 01 Jul 2026 07:16:24 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be493c24sm53283795e9.0.2026.07.01.07.16.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 07:16:22 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Wed, 01 Jul 2026 16:16:17 +0200
Subject: [PATCH 1/3] hw/core/platform-bus: fix crash when num_irqs is zero
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-microvm_uefi_var-v1-1-0652cae6a152@redhat.com>
References: <20260701-microvm_uefi_var-v1-0-0652cae6a152@redhat.com>
In-Reply-To: <20260701-microvm_uefi_var-v1-0-0652cae6a152@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

bitmap_new(0) returns a zero-size allocation, and the subsequent
bitmap_zero() dereferences it because small_nbits(0) is true.
Skip IRQ initialization entirely when num_irqs is zero, which is
valid for platform buses that only provide MMIO mapping.

This will be the case for the microvm platform bus which initially
has no IRQ lines.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 hw/core/platform-bus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/core/platform-bus.c b/hw/core/platform-bus.c
index a2217a2dee..4f765582e7 100644
--- a/hw/core/platform-bus.c
+++ b/hw/core/platform-bus.c
@@ -194,6 +194,10 @@ static void platform_bus_realize(DeviceState *dev, Error **errp)
                        pbus->mmio_size);
     sysbus_init_mmio(d, &pbus->mmio);
 
+    if (pbus->num_irqs == 0) {
+        return;
+    }
+
     pbus->used_irqs = bitmap_new(pbus->num_irqs);
     pbus->irqs = g_new0(qemu_irq, pbus->num_irqs);
     for (i = 0; i < pbus->num_irqs; i++) {

-- 
2.54.0


