Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33F07CDB466
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 09:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcglY-0005lN-8T; Thu, 25 Jun 2026 05:53:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcglU-0005l1-Fn
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 05:52:57 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wcglS-0003jU-7c
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 05:52:55 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-490c0c92cffso14343885e9.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 02:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1782381172; x=1782985972; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YLFPplBpJbQNoJ2TFh04ZV1b6QOT8aj6bxnWSJ6Uveo=;
 b=f7wV4Kh3T4DTxuL/dYVbAnVnYba9F4F7LpoI+q2/aDN5VfB5YXd4rAgM4RU9sEzkM0
 /FEFdCdWmf/p6VFbRBf9MG/eXMDC2+3c9qyo2mgXkGOFrEdmUAzwoSCR34FChgXN0tHT
 54hzr3QldkbKuBVPDjXwPVHt15KG5jU30suyg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782381172; x=1782985972;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YLFPplBpJbQNoJ2TFh04ZV1b6QOT8aj6bxnWSJ6Uveo=;
 b=Sd94u3hcP3S/6waKmSUZ33+wkAHSj2TCHDasfjSxkOn65oEwGesIxigGrCvIIS5qUN
 W83oGrY5UJVkwexiYqnCfuQ6qnqp4BK+D/9tVpvx6gL6JXp2pALDGF7bWt/XifQ+vfD0
 Uwhn12BnP4ak2seHY1o+bMM4m2PeR4pH1N6VF6crepfylZ1r/RrVmmZtusqxwk4SmyV2
 Vl5DIxBj4K3e9FMafz3gnkSnzVNZX+E+DIlQcIJuFOgifU2BH/pIohg1e0wrvYaoOJlt
 06z07Vzx9j4Cr6Ei3erZAhRNaEsJFJtbEeJ+Ka+PtLui71eP186k7/XiDS1NyAkXKR9m
 v9ug==
X-Gm-Message-State: AOJu0YwoDwGRlrnIyRo5f93nMYC1cYnu1UtFy3rMMwblm+T1hUJaHRf8
 4vyyiBiPksOXu4rg2Mnun9Fu3jWJ1K6Ey5UBKdrxI0UyEkA+mSki/nk5YfOJ3NEi+djBhpKRSAC
 +PoyLVRq4OA==
X-Gm-Gg: AfdE7cm+d1ajJEfuBFNKI/aXElNJtwxfPSAyrEDDtGTzWOulKqjasrmzrtJUUVuE/rE
 gRMdpyVW97ZhEq5m/tnG9z1sUs+gMAqTK9uRwr5oKLyu6J4HoubPcYjEbU3FIPiD1B+uQAHPxTZ
 /UtFAoAvrK+JGbpkPoo8CqFcFeRBxqKFpxS0OYiFZydobjq/iIXu3Y1Qc67S0uk7liEnaxODbY0
 4yc7NHCGLJt94eDU5NkZw8dc5hmQMRALcYD4myQgIEQ2KzFkpB5G8dE1sx6fxVp97mJ+JeHbDgz
 LaWiD+sEvVeQ+HabVDiAUGem8pYmquCxzU2woSVsbOQclfkcExOyStknZz63dM0ZI9qjoKdp7dd
 wSvc+Lm5B4/PiS1iggm5QBd1U+2g8JgTiHD9S7ZkObRoj/vdNsZPXh64y1/zgDfs7HBk+EMALDg
 uXW4xigL2C0v5UnPIq+yLwl1ezDIapflJeqtnFIfvPIJnFIT16P9RRFJpEqHW3KaFg+2iIsR1Qv
 RGcnLPTpuu0
X-Received: by 2002:a05:600c:8b0d:b0:490:bf1a:ed04 with SMTP id
 5b1f17b1804b1-49266838794mr23239065e9.1.1782381172190; 
 Thu, 25 Jun 2026 02:52:52 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a720090e98b0d86cf6583.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:90e9:8b0d:86cf:6583])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49266102bcfsm53562105e9.15.2026.06.25.02.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 02:52:51 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v2 0/9] hw/audio/virtio-sound: basic migration support
Date: Thu, 25 Jun 2026 11:52:40 +0200
Message-ID: <20260625095250.65073-1-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x32c.google.com
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

From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>

Dear friends,

This patchset is aimed to support virtio-sound live migration and based on
pre-existing Volker Rümelin's patches from qemu-devel lists [1]. I tried
to ask (https://lore.kernel.org/qemu-devel/9d7ea128c711c201688a4716f53b8a335fc53569.camel@mihalicyn.com/)
if Volker is going to continue his work on this, but received no reply so I
just decided to go forward: take his patches, rebase and resend. Of course,
I kept all authorship/tags so I hope that it is fine.

Testing.

I manually validated this with Ubuntu 24.04 Desktop VM and found no issues.
Also, it was validated with CI (https://gitlab.com/mihalicyn/qemu/-/pipelines/2626702088).

Original patchset:
https://lore.kernel.org/qemu-devel/a289a081-9a61-4bcb-b693-bf6cd7768c0e@t-online.de [1]

Git tree:
https://gitlab.com/mihalicyn/qemu/-/commits/virtio-sound-migration

Changelog for version 2:
- no code changes (only commit messages)
  followed suggestions from Daniel P. Berrangé (thanks, Daniel!)
  https://lore.kernel.org/qemu-devel/ajzoxZr4g0Xsr_4p@redhat.com/
  and added some extra details about what I did with the original
  patches during rebase (for some of them it was simpler and less error
  prone to just drop changes and reimplement them by following the idea
  of the patch, cause base code has changed significantly).

Changelog relative to the original Volker Rümelin's submission:
- rebased:
	- "hw/audio/virtio-sound: return correct command response size"
		was dropped as it was already merged
	- "hw/audio/virtio-sound: fix segmentation fault in tx/rx xfer handler"
		was dropped as it seems to be replaced with another fix
		https://github.com/qemu/qemu/commit/731655f87f319fd06f27282c6cafbc2467ac8045
	- I had to drop all pre-existing Reviewed-by tags cause it was 2 years since
	  this patchset was sent and reviewed and I did a quite significant code changes
	  during rebase

Kind regards,
Alex

Volker Rümelin (9):
  hw/audio/virtio-sound: remove command and stream mutexes
  hw/audio/virtio-sound: allocate an array of streams
  hw/audio/virtio-sound: free all stream buffers on reset
  hw/audio/virtio-sound: split out virtio_snd_pcm_start_stop()
  hw/audio/virtio-sound: add stream state variable
  hw/audio/virtio-sound: introduce virtio_snd_pcm_open()
  hw/audio/virtio-sound: introduce virtio_snd_set_active()
  hw/audio/virtio-sound: add missing vmstate fields
  hw/audio/virtio-sound: add placeholder for buffer write position

 hw/audio/trace-events         |   3 +-
 hw/audio/virtio-snd.c         | 685 ++++++++++++++++++++--------------
 include/hw/audio/virtio-snd.h |  25 +-
 3 files changed, 407 insertions(+), 306 deletions(-)

-- 
2.47.3


