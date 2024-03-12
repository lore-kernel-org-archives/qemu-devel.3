Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C788AC54E66
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 09:10:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjy9Z-0005uJ-1O; Tue, 12 Mar 2024 05:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rjy97-0005ky-EL
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 05:10:09 -0400
Received: from mail.ispras.ru ([83.149.199.84])
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1rjy95-0000OR-N0
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 05:10:05 -0400
Received: from [10.12.10.172] (unknown [78.37.10.254])
 by mail.ispras.ru (Postfix) with ESMTPSA id AC4CC40B2789;
 Tue, 12 Mar 2024 09:09:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru AC4CC40B2789
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
 s=default; t=1710234598;
 bh=PQiqmAXtGClHEXlU2ATMIHhvkjNq95U4Hf86knsideE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZvLfTOKh3AyY29MrdKsPjxLcITOQ1Oy4bv7+/uL+0oFQMcqy9uJMV2afUm5A2tuGI
 YxufRbzQ6f7f+MREcSGGvdPiVnk635fBTf7Z17vkutNT3NJtJQ4iZWCMEQ7O/t/J0E
 bcNcuog/qG00NCZSaD3Djw4TwQA5Bwsg0Ttae+uE=
Message-ID: <6e9b8e49-f00f-46fc-bbf8-4af27e0c3906@ispras.ru>
Date: Tue, 12 Mar 2024 12:09:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/24] net: Use virtual time for net announce
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
References: <20240311174026.2177152-1-npiggin@gmail.com>
 <20240311174026.2177152-12-npiggin@gmail.com>
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
In-Reply-To: <20240311174026.2177152-12-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

This won't work, as needed. Announce timer can't be enabled, because
it is set in post_load function. Therefore announce callbacks break
the replay, when virtio-net is used with snapshots.

On 11.03.2024 20:40, Nicholas Piggin wrote:
> Using virtual time for announce ensures that guest visible effects
> are deterministic and don't break replay.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   net/announce.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/announce.c b/net/announce.c
> index 9e99044422..70b5d5e822 100644
> --- a/net/announce.c
> +++ b/net/announce.c
> @@ -187,7 +187,7 @@ static void qemu_announce_self_once(void *opaque)
>   
>   void qemu_announce_self(AnnounceTimer *timer, AnnounceParameters *params)
>   {
> -    qemu_announce_timer_reset(timer, params, QEMU_CLOCK_REALTIME,
> +    qemu_announce_timer_reset(timer, params, QEMU_CLOCK_VIRTUAL,
>                                 qemu_announce_self_once, timer);
>       if (params->rounds) {
>           qemu_announce_self_once(timer);


