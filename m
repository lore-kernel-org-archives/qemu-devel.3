Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9292BCD4F59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2024 07:48:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sm7E2-0005s6-EQ; Thu, 05 Sep 2024 03:48:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sm7E1-0005rO-9q
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 03:48:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sm7Dz-0003Ub-LR
 for qemu-devel@nongnu.org; Thu, 05 Sep 2024 03:48:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725522493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LS8YJ3z8wLAxqqHPxvQZK7mIO5wh0Imz+22gFgU4FeQ=;
 b=hY/rZxDRF2Iqvbt1/xU5IwhtehVl9KJQk4nCnZYN74Mz8nKGk89KZEJsMsrLnbD4uK308S
 OLDr5ZlywnUGVbOmxrPXb+BLo0JOIaHBTy1fhEqZiOa3PooBrc/LSjW8Y0/VBgw55gVTjW
 78P6pNV7sGWZFVz80D07SKKszZXOTlE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-6-rYzbwJNdubzT1ynzQfcQ-1; Thu, 05 Sep 2024 03:48:12 -0400
X-MC-Unique: 6-rYzbwJNdubzT1ynzQfcQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-42c80412dc1so3811195e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2024 00:48:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725522491; x=1726127291;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LS8YJ3z8wLAxqqHPxvQZK7mIO5wh0Imz+22gFgU4FeQ=;
 b=tUldH19L2mNTDPPgYDSzLwybuPlIcvLQ9PlSc0Zt/DJXnn/q6LbSsaHN8Vht6tjJTo
 xbL1XQ4M5Xjx3anpNgcfrvc/gBXFxP2h/ps+7LxOfeCRJ28SQby7iq4Owm3+moTvGWEt
 n4r/HySWZ8KlqqKVbXIxxH/EQyCfo8zxplTCo72ab/hymKzebVNjjtKppchhkhqi2kq0
 BjPZXpenqzosehhCSEjX+5R1gHrZwpNLGva3vjbmdSJY0w1t62drmDYg79iWy53FsWe5
 V6qMwFABPLQQSD4TRUk9vjBqresIobFDcfWDPxac0CRprCYr8a3UmvTTadLWavjhE1xp
 zoLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvoUbJrIUKDehgnS7stJV9UzJ9GViF2ndJ4iBxny9S6yFE/bUiimf9gaPaWM73hjC56T6kX2nFkPxa@nongnu.org
X-Gm-Message-State: AOJu0YzsNvhnGe7AQPs4LezdVC3Fb3ahW2lrudDxxk+Km4+DRT+xmRKH
 WILTov1FpWFZVUwMZQa9P0VoHP10v/hN0U3CbQJ/xCSoXHfIZuaPN3CVxjTBYvgZEJY2DDGiwCw
 ODsdzN5txOxsVROOL8+B4kA/4YyAONb0k69ehBQUO9XpoXjMQUqvT
X-Received: by 2002:a05:600c:1e05:b0:426:5416:67e0 with SMTP id
 5b1f17b1804b1-42be48faa14mr116677435e9.31.1725522491437; 
 Thu, 05 Sep 2024 00:48:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE5Yh5CMTNpY/fCH3Lrg9QUqqjEYjsx/8SXenSCRVUTtWi2vtsxxw8T8mjfxRZtbSglddfsIQ==
X-Received: by 2002:a05:600c:1e05:b0:426:5416:67e0 with SMTP id
 5b1f17b1804b1-42be48faa14mr116677155e9.31.1725522490947; 
 Thu, 05 Sep 2024 00:48:10 -0700 (PDT)
Received: from [192.168.10.28] ([151.95.101.29])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-374ca0cef22sm10412161f8f.106.2024.09.05.00.48.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Sep 2024 00:48:09 -0700 (PDT)
Message-ID: <c254b667-2a47-4e6d-9a3e-79318ffa6792@redhat.com>
Date: Thu, 5 Sep 2024 09:48:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 15/15] seccomp: Remove check for CRIS host
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 devel@lists.libvirt.org
References: <20240904143603.52934-1-philmd@linaro.org>
 <20240904143603.52934-16-philmd@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20240904143603.52934-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/4/24 16:36, Philippe Mathieu-Daudé wrote:
> As per the deprecation notice in commit c7bbef4023:
> 
>    The CRIS architecture was pulled from Linux in 4.17 and
>    the compiler is no longer packaged in any distro [...].
> 
> It is now unlikely QEMU is build on CRIS host.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   system/qemu-seccomp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/system/qemu-seccomp.c b/system/qemu-seccomp.c
> index 98ffce075c..a14a0c0635 100644
> --- a/system/qemu-seccomp.c
> +++ b/system/qemu-seccomp.c
> @@ -50,7 +50,7 @@ const struct scmp_arg_cmp sched_setscheduler_arg[] = {
>    * See 'NOTES' in 'man 2 clone' - s390 & cross have 'flags' in
>    *  different position to other architectures

Small nit, "cross" is a misspelling of "cris" so

s/& cross //

No need to repost, of course.

Paolo

>    */
> -#if defined(HOST_S390X) || defined(HOST_S390) || defined(HOST_CRIS)
> +#if defined(HOST_S390X) || defined(HOST_S390)
>   #define CLONE_FLAGS_ARG 1
>   #else
>   #define CLONE_FLAGS_ARG 0


