Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F405C9830E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 20:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xAC63-0001ix-66; Fri, 25 Sep 2026 16:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <logic@deltaq.org>) id 1xAC5j-0001i6-8H
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 16:00:20 -0400
Received: from mail-ed2-x0f.google.com ([2a00:1450:4864:33::f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <logic@deltaq.org>) id 1xAC5h-0003lt-3O
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 16:00:18 -0400
Received: by mail-ed2-x0f.google.com with SMTP id
 4fb4d7f45d1cf-6a9a2b95b72so2249462a12.2
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 13:00:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790366414; cv=none;
 d=google.com; s=arc-20260327;
 b=P4GnwxxYWEZ6R+0eQrKMb6Zsi7FNg5rDebq7/41SDPE9thQ9e58Prd42Jtos+/OvSr
 XSLQjSsagJ03CtoVbA2ofYwXKhqNCVzGCl9HgtcnyMDGbXjBmQJl1TIEUepHZytUWd3f
 2Cl3+oQvD1hBrseV2bERiKl3bid711ZzKL+qiOzSHlEOG6qCxKtqEMjzZddCs57Wo5gV
 KGIhA6ekTS0OThu8Gkswgf1DHqYJBRgHwJwDhqYk88DpPieNj00CK2fy1IjdGvpOi+54
 kP5epOMx2YDNLblM/pcmTau4mjXZkTyD/Qv8sWW0OSw7YVxVZ1MsdjNRG+8IfyIHrRq+
 Rjdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=TgANr+mvCFPgwg6E5Z0epu6bljS00P5fwdzhlNbrquE=;
 fh=PnYt+qEB9tAfMKoqBm2xjKOFpYyFFGPudh5cVIoieJM=;
 b=gmHADXr6sI3MWxX7kdtr/sBvqbpB6ecVLUbW3QOe/OyiTfWcpVQUS8dyKm3RlYk2qv
 h5mcnnIPA+a2HBIPYHnIgRDB6tluzAVMfutkefnVb6XVbohjOIvVJT6RP/hAOGmYabD3
 9aOC91pFtWwWwE0zaAN4sRk1Q8wp0D2YkxDmcFttMQO5P2Ak1qBBb6Oo8odJohAlHwIk
 V6yuCooxa3a0Qwz9DRsk+3xH+3oJodcmH9ZR367+7uN898gOOtfGF4+psonJtY5R68Cn
 5G0RF3HDlNK3fGT80bWViJSBT4kMGrTpuMzyrLYp+whEbLalNs/RvritSynXsV46nlYq
 6+Hw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=deltaq.org; s=deltaq; t=1790366414; x=1790971214; darn=nongnu.org;
 h=content-type:to:subject:message-id:date:from:mime-version:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=TgANr+mvCFPgwg6E5Z0epu6bljS00P5fwdzhlNbrquE=;
 b=Nipve6pQWLUmdjTUcFvayWfqy9XQkOwhNMUF7LLQ1fQVquvAKQRtk/m4KGLE+cBvKg
 nNa3bXATPVFtcmze8rldh3oKkh/YpiqFAB6jjffVk7meqTHOQhcKW8Y3ojFE0QymyCYB
 /O0W2Omq+7cPusHeMxOcG2OClfKTpfX2SYToY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790366414; x=1790971214;
 h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TgANr+mvCFPgwg6E5Z0epu6bljS00P5fwdzhlNbrquE=;
 b=Nmd3SWFMOBybHmZ1dFXD6o4Lj+VrEkdjRmHrviFYl1uHylFMHaLf/9NIY9MY+xynPI
 RImO4yKyn1ZyZ5GIPunOkJKAT+ljNeOh6eaet+JDcUzNgn+8qNFAsNiloo08muorvgb4
 52Hkg+BTm8FFjQAgK6GiFQWqZrBmFT5r41Y9SApUJ6WE+ho7/JJXnZfFTMjTup0lvz8n
 tvkcWN02EpX6dVKI18hjB9Ql3r/0CpPgkoeYxSi2R2DlK87b3wT2+2nqtlElsIP1tK1P
 qcGqVfCNa8xXgfeKw+ikhlwii8kQm0m0Lpp8lVGveIjQiISLGvFj+N8pFpvakLoV+LgQ
 h3Zg==
X-Gm-Message-State: AFuF++l09F66a3oKMQTXaVHOJX9MZMsYzGz6ZmqgG+kYZmXQvbqdPki0
 cZnEYDS35qLg0icUz0o++G1GCIGSq71pP8k/cH23tpEAb95JlVAM6fHxyiB/gnUfGbHTCPrfMCh
 IqyTv9h66NFoWqZBHmlAr+O8QCD5KWagaVhnfPBJH8+sPuJzzDSumnAKVbbxc
X-Gm-Gg: AYBFou1058aTcS/Dv8/o3BSMY7oW/UDxh/IwK9vyxJ35zluvMLdMydi2Fnrn/74c36k
 MKz3GVuy1mj8jrnqkAVIfOB900vo8cl5VoqHfNuBqNHehGLzfKflNk15WP83AkvrTlbTkmUP/x4
 RzKcfjfKV2Xb942/bXte44CxLNuSB8h1N/2mpY1uc9vANcnsk5pikG6NVi91MvCya+7SZXe03AT
 kx9HEkIrxX0cN2uE7aNxDr1HN8dgTHsd0bXwXtmi0sg8MWN31Z1Y1Dpe/MCnvVFM3LAAtyEu3Qn
 mOBGB8GjLXIOBVjqR/AlI+lq6T2XoxtigTe3vbE9xuAjNEX0HcZXa46nuIUMc04VLyduGf1iw0K
 /7i5BDGpCqwABRcCYgVg4aM1+
X-Received: by 2002:a17:907:7288:b0:c26:19de:912d with SMTP id
 a640c23a62f3a-c2ac256dca9mr617401066b.32.1790366413905; Fri, 25 Sep 2026
 13:00:13 -0700 (PDT)
MIME-Version: 1.0
From: Jonathan Gilbert <logic@deltaq.org>
Date: Fri, 25 Sep 2026 14:59:56 -0500
X-Gm-Features: AclHuK9xUNSSe3TR_6IWBet3QczY_dZDH4x1kLKnaPfjMgymtgyRbQ0B5r599AI
Message-ID: <CAPSOpYuC7iuMJV=PQPm+KGSvDZUg3WoP90+FkFcpH2hgRz-H-Q@mail.gmail.com>
Subject: RFC: hw/arm/raspi: initial BCM2835 PWM emulation
To: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:33::f;
 envelope-from=logic@deltaq.org; helo=mail-ed2-x0f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hello :-)

I have been working with a bare-metal project that runs directly on Pi
4 hardware. It emits sound as simple tones by using the BCM2835 PWM
peripheral on the BCM2711 in autonomous mark-space mode.

I wanted to be able to hear the tones under QEMU, so I have cobbled
together a QEMU device that handles this specific use case. It
implements the CTL/RNG/DAT register behaviour needed for mark/space
operation and renders the resulting waveform through QEMU's audio
back-end. FIFO/DMA operation is not implemented. In its current form,
it does not support streamed PCM output through rapid modulation of
the PWM data value.

I note that QEMU currently lists Raspberry Pi PWM as unimplemented.
This could provide a useful base for fuller PWM emulation later.

Is this level of partial emulation useful enough to be interesting as
a proposal?

Thanks,

Jonathan Gilbert

