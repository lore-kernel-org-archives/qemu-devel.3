Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4345C55190
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 08:13:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqnmK-0001bH-Ni; Mon, 03 Aug 2026 04:12:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wqnmH-0001aR-Vc
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 04:12:05 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wqnmG-0003ei-4V
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 04:12:05 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49545ba3d4eso7496955e9.3
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 01:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1785744722; x=1786349522; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=iKlJZzEnji/4/fsJjukXXFncXRqve6Su1uk5mBpn1O0=;
 b=jYKCuMoS04I+bdUKwNAoTxajnnHANJDywG1rUYzQq/SzbQPo0zC15CzRLyf0sw3uuk
 CwR4poSMFW4IpAMA6QcNOOKwz+g0zHuGSnx0rdVjm8Sh7Cp5S4qghScGsuHiX70r4k/F
 SHhvKvWHKNea+lYoWHzKQdysLL2+ZokkTVya4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785744722; x=1786349522;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=iKlJZzEnji/4/fsJjukXXFncXRqve6Su1uk5mBpn1O0=;
 b=BFyW8J9yxtppu8CNzAjBjKLx5isGNMgvU+65FzPFKo9UwyqCGPed7+ANyh0xMSeJre
 yBj/qSPgm0P6Mtwwiwvp/bR/F/xQik8wSISOr3ll+VlP5WFCAwpkoAscj611vLe50E0B
 qhbK+bu8xwkooftit14nyOLPLiV5/a3YZb7F6FR/f2Xwb/pQEQ2HTtR3Wd+SEhPXyZqr
 A2bc6WvZCyCROqCGhLm2b3BPDEKr378DHCwK0ap+m+m6yvyvh7oNi6S+j9cGTxnIlQwH
 NscKlBRgfv7j25D5JED9nAHsYH+HBJg3g7o06HZMSBQFAsWr20xGhyQUi+aICbP7zBoI
 NC9Q==
X-Gm-Message-State: AOJu0YwsFsuECpTchIij0OoGpmUTHZrJVKxNv3vBBdQpVSKDrSj8Jyww
 p2ynBZJTpvq4Ojn98NRtlM8DA45C5R1sFqUk5kXrkRMdklAqu0wtSYLJvxc3/RRrlHli5oAqXiE
 ozZg3
X-Gm-Gg: AR+sD10wOx8awnAt2CDDPjf1gCgEPlBsInXOFlgN4N/5FXBFWQDKoETkd1lYmT2e1do
 R+csGynT//U6kqbmwQmgULZVctEtuHJxZkajviooGQzQNMKs6r5VHAHIqZGfH1oaxe0ehXfjEl2
 wUY1Hz8gsZpf8+LGzY0H5Y27yzDJvswUOBXQH6NQik4JMz4CZ7Mcy5fLiL23P+wMH18QZ6+5JRR
 FXRSUwkZxF1X/n1S9f935gYhZIN1hIORVd087A/Y4i8JQbNBuN9kYoDWzcirlCxsDSSeSSvIBTR
 GYBrvWdpi/3Yb0ZA3HSxQ4kFIL/5i7ewyMD/aXYU5sKfjj4P/Y59UPIwHfXGJLZsHShBDrN/L2C
 kyjS412TXY8n9oMHqo3/9hLvRgK97q4lOgr+GdtqDY+u0wpJFLv6EhY2SC/4j5/iY6xvm3/63fI
 M96JqexFBB0jzFU2V5wwGso2WQZCnZANqmmAifh1rVC6YNAB93AjvGTmD/9Q/chRbUnB8HLbmax
 Zox2/9Cuy8ChgsH6cGIagVTjAMQTPdg1IyjXT0tQjPIOv3Xp157yvMlhcC9
X-Received: by 2002:a05:600c:a45:b0:492:45a0:dcef with SMTP id
 5b1f17b1804b1-4980c66d8a5mr165756605e9.5.1785744721552; 
 Mon, 03 Aug 2026 01:12:01 -0700 (PDT)
Received: from alex-laptop.lan
 (p200300cf574a7200803110ea947f174a.dip0.t-ipconnect.de.
 [2003:cf:574a:7200:8031:10ea:947f:174a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b98284sm209358435e9.12.2026.08.03.01.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 01:12:00 -0700 (PDT)
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@stgraber.org>,
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Subject: [PATCH v5 00/10] hw/audio/virtio-sound: basic migration support
Date: Mon,  3 Aug 2026 10:11:49 +0200
Message-ID: <20260803081159.91981-1-alexander@mihalicyn.com>
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

Changelog for version 5:
- rebased
- added RWB tags

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
 2 files changed, 414 insertions(+), 308 deletions(-)

-- 
2.47.3


