Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4612ED68B07
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 13:08:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBZZC-0003Uw-Q9; Thu, 14 Nov 2024 08:07:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBZZA-0003UX-Sj
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 08:07:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tBZZ9-00043Z-BN
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 08:07:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731589637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=cogg4RETQKLp/tA1DHhWDLFGfEICNWMYhlF8tQ0LsZ8=;
 b=fH045nNcZOrx1GvHlyi8HXQd96OuCy5jW2HCUz8wZ2xOfcjlx3SgybubY1RX5p5L0zm0mU
 /tGkRSTuJ5/f7MBGYdK+dDDnfWWCphYknv7vOCpyc+y0ooORuPEBmfFx9hfAPWfzh/9yE9
 +ywqndc6KWJgJ5lnXJaFB1gALWkYHb4=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-gRlPNyAoPXyZVm3pKy4mKQ-1; Thu, 14 Nov 2024 08:07:16 -0500
X-MC-Unique: gRlPNyAoPXyZVm3pKy4mKQ-1
X-Mimecast-MFC-AGG-ID: gRlPNyAoPXyZVm3pKy4mKQ
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-53da87f2786so343180e87.3
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 05:07:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731589634; x=1732194434;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cogg4RETQKLp/tA1DHhWDLFGfEICNWMYhlF8tQ0LsZ8=;
 b=DSXR5K8+n/OgBkngYJ92aQjpn3GDyOvAXGA8aA4fD4Gs6lh6SnzYjlV6KnggZQCoGE
 JtLRlwsEqYb9HJLZ2aHARjjoJkExwIgGXw+KZ7bxOl4mkbqrK6vomxR5LKhe+Tu6i/Dp
 ukcGhiYZQNyIErs2vID/H4Xvc74gEISAEG+bdhhgVp6RlOE/FwlOie+dpCvvmWVNKfax
 O0FXfMC6vB+Vr0nWFhuoWk7OXhZ0EjPnlDvPjmwNccMFEvIlYmPrrdziEPAbjS9LYT34
 37VvDItSpgkLbT0V2wtiV06kTp7hwBpYMwmEcFaK2dhSx3M8TSgJwbw4qt6vUDwuKvTN
 RHVw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpStXG/uSJLklcjTC3LOHSiL1Ns7RNr/IwtBe8eBBo4tD1lXE0ZTurGAtHhz0nLIEk+YnnToaKu1Ue@nongnu.org
X-Gm-Message-State: AOJu0YzqB+jbw5jUAWR89KzhRodQFt6jZKD9KIzsTREIP5tT5xG7yT4J
 qOvUXJAiIjzrJVIB62y6XJ8SriZVPsGOW+ruL56JUMD4p/qSygQvrfvjeSBO4aYtd9Ss0x3R5Ww
 Pw8hnlnW39WctUMTUmCtTIe7EySd4z4YfwQ5N0+U57Cy7wNH5iApJ
X-Received: by 2002:a05:6512:b0b:b0:53d:a283:f290 with SMTP id
 2adb3069b0e04-53da5c4dfbcmr1360634e87.31.1731589634601; 
 Thu, 14 Nov 2024 05:07:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOfrXNOpFDa+2+BdFGjZ9vCnJsYo+iDjx+84I+SFJVL2999ZdobJWKAWEUnnzBm+8cUh8/nQ==
X-Received: by 2002:a05:6512:b0b:b0:53d:a283:f290 with SMTP id
 2adb3069b0e04-53da5c4dfbcmr1360612e87.31.1731589634173; 
 Thu, 14 Nov 2024 05:07:14 -0800 (PST)
Received: from [192.168.10.3] ([151.49.84.243])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3821ae161a5sm1462703f8f.80.2024.11.14.05.07.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 05:07:13 -0800 (PST)
Message-ID: <3dd4edcd-830f-42da-8f73-968c9b47c6b7@redhat.com>
Date: Thu, 14 Nov 2024 14:07:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/audio/hda: avoid unnecessary re-open stream on
 reconfiguration
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: mjt@tls.msk.ru, Gerd Hoffmann <kraxel@redhat.com>
References: <20241105083203.2230983-1-marcandre.lureau@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241105083203.2230983-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.122,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.69,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 11/5/24 09:32, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Closing and opening a stream too quickly during reconfiguration create
> issues with Spice.
> 
> Note: the issue with Spice has been there before and still is. When the
> audio stream is recreated, for example when using
> `out.mixing-engine=false`.
> 
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2639
> Fixes: 6d6e23361f ("hw/audio/hda: fix memory leak on audio setup")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/audio/hda-codec.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/audio/hda-codec.c b/hw/audio/hda-codec.c
> index bc661504cf..b734a5c718 100644
> --- a/hw/audio/hda-codec.c
> +++ b/hw/audio/hda-codec.c
> @@ -502,7 +502,15 @@ static void hda_audio_setup(HDAAudioStream *st)
>       trace_hda_audio_format(st->node->name, st->as.nchannels,
>                              fmt2name[st->as.fmt], st->as.freq);
>   
> -    hda_close_stream(st->state, st);
> +    /*
> +     * Do not hda_close_stream(st->state, st), AUD_open_() handles the logic for
> +     * fixed_settings, and same format. This helps prevent race issues in Spice
> +     * server & client code too. (see #2639)
> +     */
> +    if (use_timer) {
> +        timer_free(st->buft);
> +        st->buft = NULL;
> +    }

Looks like we raced on sending a fix.  I don't like freeing and 
recreating the timer...  all you need is timer_del(), the callback 
cannot change and the timer can be created close to where st->output is set.

Paolo


