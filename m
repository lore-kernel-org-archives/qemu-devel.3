Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F92CA101E
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Sep 2024 13:26:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skkaX-00081J-BY; Sun, 01 Sep 2024 09:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1skkaV-0007z3-L6; Sun, 01 Sep 2024 09:25:51 -0400
Received: from mailout01.t-online.de ([194.25.134.80])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1skkaT-0003SI-J3; Sun, 01 Sep 2024 09:25:51 -0400
Received: from fwd76.aul.t-online.de (fwd76.aul.t-online.de [10.223.144.102])
 by mailout01.t-online.de (Postfix) with SMTP id 0C11326E20;
 Sun,  1 Sep 2024 15:25:45 +0200 (CEST)
Received: from [192.168.211.200] ([93.236.144.183]) by fwd76.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1skkaN-4IHwOn0; Sun, 1 Sep 2024 15:25:43 +0200
Message-ID: <d006d238-52b3-4b73-8046-f22d2a9b9ae3@t-online.de>
Date: Sun, 1 Sep 2024 15:25:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] virtio_snd_set_config: Fix #2296
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
 Zheyu Ma <zheyuma97@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <cover.1713789200.git.manos.pitsidianakis@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
In-Reply-To: <cover.1713789200.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1725197143-BE7FB9C6-5B9E3B55/0/0 CLEAN NORMAL
X-TOI-MSGID: d1e4bb29-1593-4699-9b33-94e642209147
Received-SPF: pass client-ip=194.25.134.80; envelope-from=vr_qemu@t-online.de;
 helo=mailout01.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Am 22.04.24 um 14:52 schrieb Manos Pitsidianakis:
> Changing the number of streams via virtio_snd_set_config() did not
> re-configure the audio card, leaving it in an invalid state.
>
> Reported in https://gitlab.com/qemu-project/qemu/-/issues/2296
>
> Manos Pitsidianakis (4):
>   virtio-snd: add virtio_snd_is_config_valid()
>   virtio-snd: factor card setup out of realize func
>   virtio-snd: factor card removal out of unrealize()
>   virtio_snd_set_config: validate and re-setup card
>
>  hw/audio/virtio-snd.c | 174 +++++++++++++++++++++++++-----------------
>  1 file changed, 105 insertions(+), 69 deletions(-)
>
>
> base-commit: 62dbe54c24dbf77051bafe1039c31ddc8f37602d

Hi Manos,

I don't think the virtio_snd_set_config function is necessary. The
virtio sound device specification in chapter 5.14.4 states that all
fields in the configuration space are driver-read-only. I wrote a patch
to remove the virtio_snd_set_config function. The patch can be found at
https://lists.nongnu.org/archive/html/qemu-devel/2024-09/msg00003.html.

With best regards,
Volker

