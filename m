Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BFD2C4829E
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 08:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbcZw-0000rj-AA; Sun, 18 Feb 2024 03:31:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1rbcZp-0000pm-6B; Sun, 18 Feb 2024 03:31:12 -0500
Received: from mailout05.t-online.de ([194.25.134.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1rbcZn-0005lT-Iu; Sun, 18 Feb 2024 03:31:08 -0500
Received: from fwd78.aul.t-online.de (fwd78.aul.t-online.de [10.223.144.104])
 by mailout05.t-online.de (Postfix) with SMTP id 0000719BDA;
 Sun, 18 Feb 2024 09:31:04 +0100 (CET)
Received: from [192.168.211.200] ([79.208.24.6]) by fwd78.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1rbcZj-0qy76H0; Sun, 18 Feb 2024 09:31:03 +0100
Message-ID: <a289a081-9a61-4bcb-b693-bf6cd7768c0e@t-online.de>
Date: Sun, 18 Feb 2024 09:31:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Subject: [PATCH v2 00/11] virtio-sound migration part 1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1708245063-5CF5D979-46E4D3FD/0/0 CLEAN NORMAL
X-TOI-MSGID: db17e7fa-3fe6-41f8-9683-66a1a9414bd3
Received-SPF: pass client-ip=194.25.134.82; envelope-from=vr_qemu@t-online.de;
 helo=mailout05.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Here is the first part of my virtio-sound patches. Most of them are a
preparation to make migration work. Patch 10/11 enables migration.

The second part isn't finished yet and will have to do with virtio-sound
jack and channel maps configuration and migration.

Patch 01/11 "hw/audio/virtio-sound: return correct command response
size", patch 02/11 "hw/audio/virtio-sound: fix segmentation fault in
tx/rx xfer handler" and patch 05/11 "hw/audio/virtio-sound: free all
stream buffers on reset" are candidates for stable-8.2. Patch 05/11
either needs patches 03/11 and 04/11 or has to be rewritten for stable-8.2.

v2:
The patches were reordered to facilitate the backport of 3 patches to
QEMU stable-8.2.

Patch 02/11 "fix segmentation fault in tx/rx xfer handler" has been
completely rewritten.

Patch 04/11 "hw/audio/virtio-sound: allocate an array of streams" has
been renamed. The subject and the commit message describe the patch better.

Patch 05/11 "hw/audio/virtio-sound: free all stream buffers on reset" is
an additional patch.

Patch 07/11 "hw/audio/virtio-sound: add stream state variable" resets
the state variable on reset. Once a stream has been opened, it will only
be closed after a reset or when QEMU shuts down.

Patch 10/11 "add missing vmstate fields" resets the inuse variables on
reset.

Volker Rümelin (11):
  hw/audio/virtio-sound: return correct command response size
  hw/audio/virtio-sound: fix segmentation fault in tx/rx xfer handler
  hw/audio/virtio-sound: remove command and stream mutexes
  hw/audio/virtio-sound: allocate an array of streams
  hw/audio/virtio-sound: free all stream buffers on reset
  hw/audio/virtio-sound: split out virtio_snd_pcm_start_stop()
  hw/audio/virtio-sound: add stream state variable
  hw/audio/virtio-sound: introduce virtio_snd_pcm_open()
  hw/audio/virtio-sound: introduce virtio_snd_set_active()
  hw/audio/virtio-sound: add missing vmstate fields
  hw/audio/virtio-sound: add placeholder for buffer write position

 hw/audio/trace-events         |   3 +-
 hw/audio/virtio-snd.c         | 776 ++++++++++++++++++----------------
 include/hw/audio/virtio-snd.h |  29 +-
 3 files changed, 427 insertions(+), 381 deletions(-)

-- 
2.35.3

