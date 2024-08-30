Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DB0CA0EE0
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Aug 2024 05:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjtwQ-0004Bk-DB; Fri, 30 Aug 2024 01:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1sjtwM-0004AA-7V; Fri, 30 Aug 2024 01:12:55 -0400
Received: from mailout04.t-online.de ([194.25.134.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1sjtwK-0001Et-9F; Fri, 30 Aug 2024 01:12:53 -0400
Received: from fwd85.aul.t-online.de (fwd85.aul.t-online.de [10.223.144.111])
 by mailout04.t-online.de (Postfix) with SMTP id 24C7217CF1;
 Fri, 30 Aug 2024 07:12:48 +0200 (CEST)
Received: from [192.168.211.200] ([93.236.150.177]) by fwd85.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1sjtwF-0MmJBh0; Fri, 30 Aug 2024 07:12:47 +0200
Message-ID: <122bf0db-8763-432b-979c-f0c91c7710b9@t-online.de>
Date: Fri, 30 Aug 2024 07:12:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 2/3] hw/audio/virtio-snd: fix invalid param check
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
References: <cover.1724151593.git.mst@redhat.com>
 <7d14471a121878602cb4e748c4707f9ab9a9e3e2.1724151593.git.mst@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
In-Reply-To: <7d14471a121878602cb4e748c4707f9ab9a9e3e2.1724151593.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1724994767-F37FD872-039FF045/0/0 CLEAN NORMAL
X-TOI-MSGID: 02d816ef-2acd-4990-b971-7fad3887e43b
Received-SPF: pass client-ip=194.25.134.18; envelope-from=vr_qemu@t-online.de;
 helo=mailout04.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Cc: qemu-stable@nongnu.org

Without this patch, the virtio-sound device will not work in the next
QEMU stable-8.2 and stable-9.0 versions.

With best regards,
Volker

> From: Volker Rümelin <vr_qemu@t-online.de>
>
> Commit 9b6083465f ("virtio-snd: check for invalid param shift
> operands") tries to prevent invalid parameters specified by the
> guest. However, the code is not correct.
>
> Change the code so that the parameters format and rate, which are
> a bit numbers, are compared with the bit size of the data type.
>
> Fixes: 9b6083465f ("virtio-snd: check for invalid param shift operands")
> Signed-off-by: Volker Rümelin <vr_qemu@t-online.de>
> Message-Id: <20240802071805.7123-1-vr_qemu@t-online.de>
> Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  hw/audio/virtio-snd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/hw/audio/virtio-snd.c b/hw/audio/virtio-snd.c
> index e5196aa4bb..d1cf5eb445 100644
> --- a/hw/audio/virtio-snd.c
> +++ b/hw/audio/virtio-snd.c
> @@ -282,12 +282,12 @@ uint32_t virtio_snd_set_pcm_params(VirtIOSound *s,
>          error_report("Number of channels is not supported.");
>          return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
>      }
> -    if (BIT(params->format) > sizeof(supported_formats) ||
> +    if (params->format >= sizeof(supported_formats) * BITS_PER_BYTE ||
>          !(supported_formats & BIT(params->format))) {
>          error_report("Stream format is not supported.");
>          return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
>      }
> -    if (BIT(params->rate) > sizeof(supported_rates) ||
> +    if (params->rate >= sizeof(supported_rates) * BITS_PER_BYTE ||
>          !(supported_rates & BIT(params->rate))) {
>          error_report("Stream rate is not supported.");
>          return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);


