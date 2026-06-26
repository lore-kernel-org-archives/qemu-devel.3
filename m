Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9A3CDE002
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 12:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd5mt-0004XC-6N; Fri, 26 Jun 2026 08:36:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wd5mT-0004Tf-Pd
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:35:43 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wd5mR-0002vs-Gu
 for qemu-devel@nongnu.org; Fri, 26 Jun 2026 08:35:37 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-46f3ca3c598so688193f8f.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2026 05:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1782477333; x=1783082133; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MquNqe18DPhVhW+OqRiNtfS8g3epc7GXA4QXS+eLsH0=;
 b=NeOaIEwpuFovKWAsYW7DVRabbn1vR/vXJ2z3qT0DT4mRmSE/vmMJ0UHU4iMjE/HDUp
 IllYqzNY0w+2BAy4FRzg3WRRhr60Zu9d23DnevfWMrglzp5Ww2nFVG8ta5yCtm6JJYgc
 yIwn7YW6BfUh+WRUbLjFOuJCXJjH6ssxW+/0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782477333; x=1783082133;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MquNqe18DPhVhW+OqRiNtfS8g3epc7GXA4QXS+eLsH0=;
 b=mHGuG6wnuPEBgtsTfHcWuveB4PoI6ahQ6kn5RBALb8RLuGK5x3UCVHwuaCinSo2hLn
 WgJ1Zkcze24mNwbeFSEC4m03nVx+gsudlhMY/PpMnC/FPZSmJmNh0qRLcj2RCUWgdiqA
 a0P7Fv7aqCJ6APyYLvVp8m63/k68KUgxcvPlz6394vzry8x8NqGnDDd1m7AQSuKV6Nna
 25dQPy2IPO1oWO9Dp5UkaoIZYVZ6stCa3iNo5f91P6hzVexh+ARyLm7DsV72B3nOahav
 ziPBJD35G+L6FbXLU8hydoGCbhfP3mQ6PvY0cby1EQa/A2rOW2oN+l50Eo47ejicoI5N
 HEhA==
X-Gm-Message-State: AOJu0YwvFzibUkIlSkOS3lQ2kpqbU3tv81tpgpYHsSNg+jFgSrrIUYOq
 KQD23HCmIe0R2dm0eedCPKgWcVcRS31vovxhGt0GKvTQVi7Zuo3HTT0JQtIfKlpTaZGBGVSUIl3
 OlTUaxVg=
X-Gm-Gg: AfdE7cnOxQ0fFjJkfkxr/3u5+6HeeE5pgI0MFiKY4VYTL/PQstW2QSzeTR9fz89R5gq
 /X4i7JXKnltRaTOSrkSq/l8sOUFx3jV5ZJNyMqhfNUhIY1zHFy8MDh+lgjgiMeNDDR1Bjlegp0n
 gKQxu2jBjSVSJiK7DP8ybm+nUgHI7/Hr3rL9n6A+lQyCEESUqGKJa129gg5p66APZlTADfSujni
 CmGFTCqycTG/CWdIR3UZg6aABb5Jf8wrbxSQRKlhdI+UWO7YFGMyNnLTpMKClUUNmE9pUIm7CfD
 NWBbYahXnDTMuOkk5hvT9NGB3AW2IliU439S2arRwHWiZGb73QAm/vWLa1cYkUOA8H+0INV2GQF
 jg4xWJC70A5JZd33K6mu3rANpw97+DiIQs+iib/l8eXqJb/rmYhi6x4N3TTclfzrb0ccCf27gga
 hppDPaFtbtJM1msXeu1mxmaSsN2L+cO43mq2XcP/mu8iNr1vc16mG/WxWEF+5bE4e0xa0zNua9D
 FWO7OQJp9fiR72wSNI51Kc=
X-Received: by 2002:a05:6000:2207:b0:46f:960b:b711 with SMTP id
 ffacd0b85a97d-46f960bb850mr1732810f8f.45.1782477333276; 
 Fri, 26 Jun 2026 05:35:33 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a7200aa896c1ac04cb1b2.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:aa89:6c1a:c04c:b1b2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46efd7ee1c7sm7373757f8f.14.2026.06.26.05.35.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 05:35:32 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v3 0/9] hw/audio/virtio-sound: basic migration support
Date: Fri, 26 Jun 2026 14:35:22 +0200
Message-ID: <20260626123531.132078-1-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=alexander@mihalicyn.com; helo=mail-wr1-x433.google.com
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

Changelog for version 3:
- addressed review feedback from Marc-André Lureau:
	- drop VirtIOSoundPCMStream's id field (unused)
	- resurrected error_report(..) in virtio_snd_pcm_start_stop()
	- fixes in "hw/audio/virtio-sound: add stream state variable"
	  [ please, look in commit message for details ]
	- added "hw/audio/virtio-sound: remove channel positions field
	  from VirtIOSoundPCMStream"
	- fixes in "hw/audio/virtio-sound: add missing vmstate fields"
	  [ details in commit message ]

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

Alexander Mikhalitsyn (1):
  hw/audio/virtio-sound: remove channel positions field from
    VirtIOSoundPCMStream

Volker Rümelin (8):
  hw/audio/virtio-sound: remove command and stream mutexes
  hw/audio/virtio-sound: allocate an array of streams
  hw/audio/virtio-sound: free all stream buffers on reset
  hw/audio/virtio-sound: split out virtio_snd_pcm_start_stop()
  hw/audio/virtio-sound: add stream state variable
  hw/audio/virtio-sound: introduce virtio_snd_pcm_open()
  hw/audio/virtio-sound: introduce virtio_snd_set_active()
  hw/audio/virtio-sound: add missing vmstate fields

 hw/audio/trace-events         |   3 +-
 hw/audio/virtio-snd.c         | 679 ++++++++++++++++++++--------------
 include/hw/audio/virtio-snd.h |  26 +-
 3 files changed, 399 insertions(+), 309 deletions(-)

-- 
2.47.3


