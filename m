Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 342E2C3DA45
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2024 06:58:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTFeg-0001DF-PY; Mon, 15 Jul 2024 02:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTFef-0001Cd-Mo
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 02:57:49 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTFee-0005Lk-0q
 for qemu-devel@nongnu.org; Mon, 15 Jul 2024 02:57:49 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2ec61eeed8eso51593561fa.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jul 2024 23:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721026666; x=1721631466; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RehVoEof3WEmy2fUV8+DnuJXHxPuM7X5e+4aZgIbCY8=;
 b=pUJEi2Rq/nWCxpw6ykylFsBvf6sLGJ0pI+OMLbd3NmY0BGMHUMwo3oo4BDzT1Hwg+k
 02vNgXyj8c3+pOo6uEs221w50XB9VpaqeDv1NKfebCgEXaL6h9OnuZkEQq3h7dc2r4p4
 CKB5Okb1SXBvw/fxbvgAvXSgojv+JiZs3OlB8PvQitsBhK3fRfIFlkMbI1gSiG5djUtt
 eTJjLsOODNfabEOFkR1XNn7OFIMbVZpgQIr6a1brfxP14rHYOzgjyVXTebs+Z153bMPm
 R3Ant5882mjPaBGj9r17drKZC9GGp0pK8TTGKtg3De4AfkbbvON19VlMhDXneBbtaE2f
 k1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721026666; x=1721631466;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RehVoEof3WEmy2fUV8+DnuJXHxPuM7X5e+4aZgIbCY8=;
 b=CVvh2HeRMqFypwq3RB+X24Vg289LsWePLUjgBRfuKZ0+22T/cRfA1gNJhUAxZvuc0P
 YMgbECyKk6itna3vAzS3ABJP3lm2pMhHIG6rg3TAhj3lkhLiKXRhNwXjtEKnQ+l0fSPV
 Ny7fN3b9WBMLOc20I2ymDHm8luG9kz4byUa8Du+XNvFs8uEJuzc5ySEhXmn50vKOud7o
 MKZUKG8sosENbiwEIESegmNtK7L7flEGcccSFngL//CrnDMXliTUNj2A8vvaH7oWsytG
 D62/Al/UxYEhUFP526ybJIwXsev+E/rSOTanwyByMQG+uA0ryxtii8Z3vp483v+yI5M8
 x1ug==
X-Gm-Message-State: AOJu0YzGcjbSC2m7lhKDE8qZUKn9igvibKy0XgqA/pm5/d2CFX23JHcN
 UZljOt84soiDvW5FtO+N7/tOd+QZ0cPi4DqmccWMA7G/RemVlk8xYWFLIIZKEOs=
X-Google-Smtp-Source: AGHT+IFS5uFMc0BR6oJfjmifTl7P11gSVVkH+TKOuwvClp4l8X1YtiXuCt+5WuhAmNfQu/VZozwT4g==
X-Received: by 2002:a2e:87c5:0:b0:2ee:699b:466 with SMTP id
 38308e7fff4ca-2eeb3189e1dmr117875861fa.36.1721026666222; 
 Sun, 14 Jul 2024 23:57:46 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.134.54])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2397f7sm108703285e9.9.2024.07.14.23.57.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Jul 2024 23:57:45 -0700 (PDT)
Message-ID: <8e36641b-ea92-467e-95c3-babffbaeb44b@linaro.org>
Date: Mon, 15 Jul 2024 08:57:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] ui/cocoa: Release CGColorSpace
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>
Cc: qemu-devel@nongnu.org
References: <20240715-cursor-v3-0-afa5b9492dbf@daynix.com>
 <20240715-cursor-v3-1-afa5b9492dbf@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240715-cursor-v3-1-afa5b9492dbf@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22b;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22b.google.com
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

On 15/7/24 07:25, Akihiko Odaki wrote:
> CGImageCreate | Apple Developer Documentation
> https://developer.apple.com/documentation/coregraphics/1455149-cgimagecreate
>> The color space is retained; on return, you may safely release it.
> 
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> Tested-by: Phil Dennis-Jordan <phil@philjordan.eu>
> ---
>   ui/cocoa.m | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


