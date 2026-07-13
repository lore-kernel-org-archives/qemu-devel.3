Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B40EFC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 08:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjCFv-0004PN-Tq; Mon, 13 Jul 2026 04:43:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wjCFt-0004Ok-Pc
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:43:13 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wjCFr-0003B5-PS
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 04:43:13 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-493b1710405so14387675e9.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 01:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1783932190; x=1784536990; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=fn+HRTMRfGBK9U2/G6IxGyKxGXQNDbYmTnzDpaEa8WQ=;
 b=RP5bAi4bFy7zngf/Bw809vIyU+IbWhK2Ihz+ux1aqGAMHUjiZR0lyGP97OlW0UwDM0
 AqUDly3GJhcQLt93KufEXGviC12ZQcaIFklQvggP30gTnQ8sntFno1iVK2+cD9lL/+4H
 5V9/CTkgMSZnQebxr2/ekKOh6qigfSI0Oj9ZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783932190; x=1784536990;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fn+HRTMRfGBK9U2/G6IxGyKxGXQNDbYmTnzDpaEa8WQ=;
 b=n9cUe3tO9EQZd4qtp13GWaAWzbTBpjhfqPKmV5eHzDhMU0OD/YEewpxJtAouKdKMyC
 Piuv2vagnpNXCICh4RrajQ5UjpkLxz5oGe+4Z+sw++9S/J5LL8Oh3A8oiw9K+JRal9CY
 i8blsTisNBij6zPAx8s6yeNcuT3C++PLtY5hfyLuS2tbaANFzYMFHvsfVbS1lHNSmdPK
 l13ky8fIB+Sm3Q2oDfRpvYZMRWpTtpL81MRcPp3wkQ1vlcmmixH4WqFfZyYQXPioBoHn
 xUYms/u6UB8To0vnYQVv/WR25FhlwmPNM9kHWyAcmIpNM0CQL9QK9GsnRQEMGzaDWVPQ
 /48g==
X-Gm-Message-State: AOJu0YxXFk/hPEWRo5hopEwXDbowNAhfYFAXNyCwluCHc1DiTxR18Gcm
 zNYvafd8yZ7yAKvDedunBMoftTu3HhiG3eR/YGs72ZndlppvVv9PTPzwo2iMcmRU99juu+FoBXQ
 1ykoRXgelsA==
X-Gm-Gg: AfdE7clKybmJBvCnellN01gInaEuYC14EFYjqf74dh4YWdoCzvqU8VQeQRbilYsWwOd
 wxT2Lxgong/8WMClDw8a3knkEr0c4+FyuKfPu85XrHT5HxBQ2Z5jQfr7d9ut6cEgnSREEow54s+
 2hd6rAyJJVexW0rjgQJzX5sF3iDJWxzq1dQNUoyWiVmaYS2695qHbTdgA3c8Z73JtkOLSb1Km2t
 5t5ZLCS99fwnQ5QStdjLqZ3fbb2W8zkD3C6fE5LW8q6PcIXZHGnZ7f6sWA+cgULWW2LxahC9XG0
 UJcIhBvDR7lq7DdymHdumyoj0vWTRiYCIZOf0RouipD9Roamvbs6xUK8ZGCNWQkS8uTc2CsqoZf
 /Z27kHoPpEw5RZ21JCFwMVy1mmENGSDgTOHD1+1DzxHemPJDJbDWddquh1RGCxr4cfa1+8gJsxl
 yhNYMChUnZ5P8s54tV+RHs7FHH5VqmrpfMxdGg7VCdPuNBz2x/Hr7P8Hj5oZEBE8yo3YIRldD2t
 vTePcgnMO3uTbGgyUkFe2c=
X-Received: by 2002:a05:600c:a010:b0:493:c389:d43c with SMTP id
 5b1f17b1804b1-493f8837655mr79067565e9.34.1783932189330; 
 Mon, 13 Jul 2026 01:43:09 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a7200912ca59176a42017.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:912c:a591:76a4:2017])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2d97527sm287254815e9.2.2026.07.13.01.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 01:43:08 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v4 00/10] hw/audio/virtio-sound: basic migration support
Date: Mon, 13 Jul 2026 10:42:57 +0200
Message-ID: <20260713084307.79593-1-alexander@mihalicyn.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alexander@mihalicyn.com; helo=mail-wm1-x333.google.com
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

Changelog for version 4:
- addressed review feedback from Marc-André Lureau
- and from Manos Pitsidianakis
*there is a detailed changelog under each commit message*

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

Alexander Mikhalitsyn (2):
  hw/audio/virtio-sound: remove channel positions field from
    VirtIOSoundPCMStream
  hw/audio/virtio-sound: drop unused struct
    VirtIOSoundPCMStream.flushing field

Volker Rümelin (8):
  hw/audio/virtio-sound: remove command and stream mutexes
  hw/audio/virtio-sound: allocate an array of streams
  hw/audio/virtio-sound: free all stream buffers on reset
  hw/audio/virtio-sound: split out virtio_snd_pcm_start_stop()
  hw/audio/virtio-sound: add stream state variable
  hw/audio/virtio-sound: introduce virtio_snd_pcm_open()
  hw/audio/virtio-sound: introduce virtio_snd_set_active()
  hw/audio/virtio-sound: add missing vmstate fields

 hw/audio/virtio-snd.c         | 696 ++++++++++++++++++++--------------
 include/hw/audio/virtio-snd.h |  26 +-
 2 files changed, 413 insertions(+), 309 deletions(-)

-- 
2.47.3


