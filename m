Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C46CD1292
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Apr 2024 19:14:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsSX6-00061C-3S; Thu, 04 Apr 2024 15:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsSX2-00060w-E6
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 15:13:52 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsSWv-0005Uh-4h
 for qemu-devel@nongnu.org; Thu, 04 Apr 2024 15:13:51 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-565c6cf4819so4417040a12.1
 for <qemu-devel@nongnu.org>; Thu, 04 Apr 2024 12:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712258022; x=1712862822; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8WchDuPu1BDvGE3LRF7qlJXcb6p6bszd96Mxn2SBD+U=;
 b=YmdncP4tiGr7nd6EZ/xksBZ2+Cy7vMexpNnH+CQuDkT9s/mQKlaaisgI1xhYBUT3tH
 rQpoY3m5OUB9evom0U8vcjHJLVRK7Gz8iz2T5upQxboO5OttYRB6OW97NYqnSA5KB2KM
 lYDKjhdEHnTK/nydq6optPk3PaXjOEPyzSqRrSP8Hno573A0nEoYjQEbOXJbCX/Qzzl7
 eolmCFe21f9ZbSa6t/A8XDe9Q4br8e9au6Xem4j+MzyLf2dJVhhSSeLe9Tu2nxCAaHHD
 8SvcJp+3dhy4lfVOw/+34a39a+nQjSKxrKGJfeuW5sxVguhs4Qezg9EPraJ8LokFb6jo
 W85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712258022; x=1712862822;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8WchDuPu1BDvGE3LRF7qlJXcb6p6bszd96Mxn2SBD+U=;
 b=tVQNToj35srGbtbZRvcfaV48jHUcCFmkP9T7FJW5s1w58iyQe5k8+beVb/Z3dELPci
 CvU2JRLuO4Jjhc2XGowu6FjtkjdXcTy/AjLijMgotW8/9YP6UH/xS5wKiDS0iBvR0L1B
 W17x5qfv0FnK5uWRuh/4JL6HnJ4ABYeqIzPzF3gabCy+IEq8EizYhBLkQaH/ng9+tB3X
 +qZaAuQ95HNyh+/kus9KCw5paF/g6SAE0dU84xQ6hFWuuBs4TjYOI9LuX/gAtU1VUHZm
 4oPMHcWnC4O4VRWahQQ3BdZGrPVw4T47EaECaWJF4/kRfJc7uXnCCVuC4NP5pmAxUn6k
 5cxQ==
X-Gm-Message-State: AOJu0YwLvsa2LXi5wYvMszuWIfsMUKAZQrJ7GVS9tBZlj5urWAM15Ard
 tdUsoRN2U4hi6/dK8xCP8FeVVaV42qrJv4AuYBPW9Tzzm3chxlJ+0KauiAq1tCHY+H+gHc0Qq+d
 g
X-Google-Smtp-Source: AGHT+IFJBMSRNHzMkIyuivVnlKIBQPulV92yzQnl0XnYzTZCGppzgIy4FZfhTr0JXq1tdZQQLdKmig==
X-Received: by 2002:a17:906:fccc:b0:a4d:f8d7:8546 with SMTP id
 qx12-20020a170906fccc00b00a4df8d78546mr317940ejb.7.1712258022459; 
 Thu, 04 Apr 2024 12:13:42 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.216.111])
 by smtp.gmail.com with ESMTPSA id
 x11-20020a170906710b00b00a51973509afsm463533ejj.91.2024.04.04.12.13.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 04 Apr 2024 12:13:41 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Amit Shah <amit@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-9.0 0/4] hw/virtio: Protect from more DMA re-entrancy bugs
Date: Thu,  4 Apr 2024 21:13:35 +0200
Message-ID: <20240404191339.5688-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Gerd suggested to use the transport guard to protect the
device from DMA re-entrancy abuses.

Philippe Mathieu-Daudé (4):
  hw/virtio: Introduce virtio_bh_new_guarded() helper
  hw/display/virtio-gpu: Protect from DMA re-entrancy bugs
  hw/char/virtio-serial-bus: Protect from DMA re-entrancy bugs
  hw/virtio/virtio-crypto: Protect from DMA re-entrancy bugs

 include/hw/virtio/virtio.h  |  7 +++++++
 hw/char/virtio-serial-bus.c |  3 +--
 hw/display/virtio-gpu.c     |  6 ++----
 hw/virtio/virtio-crypto.c   |  4 ++--
 hw/virtio/virtio.c          | 10 ++++++++++
 5 files changed, 22 insertions(+), 8 deletions(-)

-- 
2.41.0


