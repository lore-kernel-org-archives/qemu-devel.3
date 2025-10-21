Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B0C1CCD1A7
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 17:46:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBGQT-00059S-LE; Tue, 21 Oct 2025 13:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBGQR-00055V-Rb
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 13:45:35 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBGQP-0005md-M1
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 13:45:35 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-46e6ba26c50so38424035e9.2
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 10:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761068730; x=1761673530; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XHBuhRPRLbOSNiZ0G0iBGYbxL5H81DmDmTj6zZRytoY=;
 b=Pgmr1mKDdvXJcEbOYR4DZfBrV3F4VxTjLLbBRQbCfNBOLsxP61Y19BskqpS9DVrMJF
 rXFW3qEBqik2OB+/2rPeivE2KzrKvdMOo0kCsrcONrFzw3/IRCPXWZvfyIlYv2TK3M2a
 zjwQ9WqIjAkt2CcU/Uusqaumkmlz6tf8tfpe/vd5DyCaId3yd6UZ9lLBLVZsFLd7GTvQ
 D3MpetZfts+rLdCcOqLli/B3Dw9NP72F8qWQtsfULCuknFnVL68DzdVHiE4o3F0iJ5ZC
 qTJhn18nwDgJy1NLeD1niwOFRFAIrKlmzb5zYXT4yuKEVD8ucctBByFNyLxNjU90XjTw
 IPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761068730; x=1761673530;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XHBuhRPRLbOSNiZ0G0iBGYbxL5H81DmDmTj6zZRytoY=;
 b=sDUOtqeZf1+QgP5JOeu1go6CC/xGSYrKV9lf7oQlAY3YHA+VMd0NniF/kqx8JbjEYg
 J5+ooaT6RkR31I75cjxpQ/kvXCdBE8qLZP7lx9l2R4oopzt4d4L9/z6qC7v45TwtoiSx
 zR29tvNGhfPOm8IIp1vo1K4TAG7//q9Fk2EW+0+LapiDF/ENDxgyfRN3Wl9iAnwGAP4m
 QCQ11a22mOUsK2M9yEbs2EWFBc+mV3z1DdfkFLeSA+M8AZ+otnNikpkUdUZ+fHVxtYrQ
 hUqWjn+EK6Xpn/rKNZ2XZKgWjPObjRIBZmik+Ya0gfrJFSj09ZjCdRcvJwKQ6+wP2AfB
 KQ+A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwNTmym/zn3zuG9FRZJEjicO9RWym8Sy5Ib+HOqboa+qbH+yQfkHegSFz+SsW0a2Y3H5IdiaOadLwi@nongnu.org
X-Gm-Message-State: AOJu0YxlHiMedas8El0VbBig789aj36lSgv7BQzDPo63gX9i3lko8gJj
 vWO2QlxIvane4mIqm83UkUHlqnEXzZvVZHIRBmrdJfMEc97vnBih/dvT/aII/sIvtBzAnyhFNUZ
 RCFyF24s=
X-Gm-Gg: ASbGncvIXGDb4aufnpQOXK0lxH/DZA90DwpZoO9DKBVchm/uV4m+9mvuuJrQvsf4JJf
 H+b8HLtJbyoDFcMHEnH0IfYKfI4YvQbAmnsdi2Eo5z0u+nO+cYmwznlFWlcGq4rqZo0s2+UTuMt
 bMvOhyqHGFYPS1xtsRkkIe9ZiOwejrzJVKfhUz4fKgycwSsHAm3SnwuwlgTg6HLu1wakqmw7Os7
 BLtcJ+L2/iTIZLJHQ/AA0bYwDfoyy97IbgSPM/T4uY9PTKtfCEn+0xxsf6eySmC8cpOgxSxSaki
 lVBwGtVOxRQ7P5977fP7So7Uw1R9+lSXiHsiph8C9E4wE+hkXrJ4PDCizbJbEXkSs9+IrEVhgby
 yssKkyMuaN/XdmODmrifB8mvS5xj6LpGUET4qDk5xn+oIZrD9G4x9YdlGr6ST4TzwUbd6+tzOA4
 1gDbG0i/jmqrZiApy32YGcqHYYh3KOjM+L8KwWk6mpOkabeSAsCgYs0g==
X-Google-Smtp-Source: AGHT+IFTl2+tr/zqnBX/4QDIsgAkWw+1z/sD+VgHs9CkiI0r/d1gJKTwHfRkUcqihFLY4S8731ZPvA==
X-Received: by 2002:a05:600c:1d9b:b0:471:a3b:56d with SMTP id
 5b1f17b1804b1-4711792006bmr150621985e9.34.1761068730252; 
 Tue, 21 Oct 2025 10:45:30 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c427f685sm3648875e9.2.2025.10.21.10.45.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 10:45:29 -0700 (PDT)
Message-ID: <ef0a247e-9337-4919-8e16-5e25ad35154e@linaro.org>
Date: Tue, 21 Oct 2025 19:45:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/43] hw/pcspk: make 'pit' a class property
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
 <20251021090317.425409-6-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251021090317.425409-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 21/10/25 11:02, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> This should be functionally equivalent. (for some reason, the device
> property was convert to an object instance property in commit 873b4d3f0571)

This commit is from 2016; DEFINE_PROP_LINK() was added in 2017,
in commit 5b4ff3c6613.

> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/audio/pcspk.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


