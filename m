Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82370FC6172
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 18:49:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spBLH-0005Aq-9w; Fri, 13 Sep 2024 14:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1spBLD-00058p-0Q; Fri, 13 Sep 2024 14:48:23 -0400
Received: from mailout10.t-online.de ([194.25.134.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1spBL9-0006H6-2s; Fri, 13 Sep 2024 14:48:21 -0400
Received: from fwd85.aul.t-online.de (fwd85.aul.t-online.de [10.223.144.111])
 by mailout10.t-online.de (Postfix) with SMTP id 7949345F8;
 Fri, 13 Sep 2024 20:48:00 +0200 (CEST)
Received: from [192.168.211.200] ([93.236.144.183]) by fwd85.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1spBKo-1D6pFJ0; Fri, 13 Sep 2024 20:47:58 +0200
Message-ID: <730a179c-99dc-4996-8e71-8d01fe42f6d1@t-online.de>
Date: Fri, 13 Sep 2024 20:47:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 16/18] hw/audio/virtio-sound: fix heap buffer overflow
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
References: <cover.1726062663.git.mst@redhat.com>
 <7fc6611cad3e9627b23ce83e550b668abba6c886.1726062663.git.mst@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
In-Reply-To: <7fc6611cad3e9627b23ce83e550b668abba6c886.1726062663.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1726253278-B77FD83E-4FAD900C/0/0 CLEAN NORMAL
X-TOI-MSGID: e4a178f7-7eee-4dce-ab5d-9825781f6b49
Received-SPF: pass client-ip=194.25.134.21; envelope-from=vr_qemu@t-online.de;
 helo=mailout10.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Cc: qemu-stable@nongnu.org

stable-8.2, stable-9.0 and stable-9.1

> From: Volker Rümelin <vr_qemu@t-online.de>
>
> Currently, the guest may write to the device configuration space,
> whereas the virtio sound device specification in chapter 5.14.4
> clearly states that the fields in the device configuration space
> are driver-read-only.
>
> Remove the set_config function from the virtio_snd class.
>
> This also prevents a heap buffer overflow. See QEMU issue #2296.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2296
> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
> Message-Id: <20240901130112.8242-1-vr_qemu@t-online.de>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/audio/virtio-snd.c | 24 ------------------------
>  hw/audio/trace-events |  1 -
>  2 files changed, 25 deletions(-)
>
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index d1cf5eb445..69838181dd 100644
> --- a/hw/audio/virtio-snd.c
> +++ b/hw/audio/virtio-snd.c
> @@ -107,29 +107,6 @@ virtio_snd_get_config(VirtIODevice *vdev, uint8_t *config)
>  
>  }
>  
> -static void
> -virtio_snd_set_config(VirtIODevice *vdev, const uint8_t *config)
> -{
> -    VirtIOSound *s = VIRTIO_SND(vdev);
> -    const virtio_snd_config *sndconfig =
> -        (const virtio_snd_config *)config;
> -
> -
> -   trace_virtio_snd_set_config(vdev,
> -                               s->snd_conf.jacks,
> -                               sndconfig->jacks,
> -                               s->snd_conf.streams,
> -                               sndconfig->streams,
> -                               s->snd_conf.chmaps,
> -                               sndconfig->chmaps);
> -
> -    memcpy(&s->snd_conf, sndconfig, sizeof(virtio_snd_config));
> -    le32_to_cpus(&s->snd_conf.jacks);
> -    le32_to_cpus(&s->snd_conf.streams);
> -    le32_to_cpus(&s->snd_conf.chmaps);
> -
> -}
> -
>  static void
>  virtio_snd_pcm_buffer_free(VirtIOSoundPCMBuffer *buffer)
>  {
> @@ -1400,7 +1377,6 @@ static void virtio_snd_class_init(ObjectClass *klass, void *data)
>      vdc->realize = virtio_snd_realize;
>      vdc->unrealize = virtio_snd_unrealize;
>      vdc->get_config = virtio_snd_get_config;
> -    vdc->set_config = virtio_snd_set_config;
>      vdc->get_features = get_features;
>      vdc->reset = virtio_snd_reset;
>      vdc->legacy_features = 0;
> diff --git a/hw/audio/trace-events b/hw/audio/trace-events
> index b1870ff224..b8ef572767 100644
> --- a/hw/audio/trace-events
> +++ b/hw/audio/trace-events
> @@ -41,7 +41,6 @@ asc_update_irq(int irq, int a, int b) "set IRQ to %d (A: 0x%x B: 0x%x)"
>  
>  #virtio-snd.c
>  virtio_snd_get_config(void *vdev, uint32_t jacks, uint32_t streams, uint32_t chmaps) "snd %p: get_config jacks=%"PRIu32" streams=%"PRIu32" chmaps=%"PRIu32""
> -virtio_snd_set_config(void *vdev, uint32_t jacks, uint32_t new_jacks, uint32_t streams, uint32_t new_streams, uint32_t chmaps, uint32_t new_chmaps) "snd %p: set_config jacks from %"PRIu32"->%"PRIu32", streams from %"PRIu32"->%"PRIu32", chmaps from %"PRIu32"->%"PRIu32
>  virtio_snd_get_features(void *vdev, uint64_t features) "snd %p: get_features 0x%"PRIx64
>  virtio_snd_vm_state_running(void) "vm state running"
>  virtio_snd_vm_state_stopped(void) "vm state stopped"


