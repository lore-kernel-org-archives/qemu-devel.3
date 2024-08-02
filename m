Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5CCC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 11:16:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZqGF-0002Pf-Ph; Fri, 02 Aug 2024 07:15:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sZqGD-0002OQ-Eu
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 07:15:49 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sZqGB-0005Wv-TT
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 07:15:49 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-a7a9185e1c0so806236166b.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 04:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722597346; x=1723202146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=e+44dpgRtXaXlvWeGa06WK3Rxt1+rkpwzOuWKFzcYNI=;
 b=wZxIpn0sIu+2VJX+eR8lDPR3F4q8KqjBpyoA8OZ0PkHYMrL7KQXl7TC3M6NrKMcN88
 9FNOPP23eeq7KQ11yEABBUtJe/ksYFFG5YlBgtM6qYSSw1lClI/xBKpAcvOK7J/BnIhR
 XV/dN7KsYD++2KALZiNW50c+qBkpzqHRUJM6k1V6Wh75ZvvtJhINmGSLtYU1w7/MK9P6
 uZIL8vh8ALEjvxiUgEkHWT6J5EfWsyqQkeuXGkh64H9srS7hZdFjSjfHxisHBCBwTQCG
 TA27SZTlzqfZ6R0/X2ZNA4AwNTaVAl9C8O7Z1GQCbvM1Tf0R2bWKH9pDGaiR6L1+ZIHp
 m6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722597346; x=1723202146;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e+44dpgRtXaXlvWeGa06WK3Rxt1+rkpwzOuWKFzcYNI=;
 b=d+ptzv8w68fM8Z66Ae5eYAyK6CAwvBvo1EDY4Qpr/pB461zBQ/cNHn4Oabb0MufNr2
 OWTy5Uj+B+Yl2h/XdL9a2cud7dl+/Gy9xW6x3f2XQGDRx+NDU3FdOKdnHrd37pUNLUai
 ZRDgC5zZmBFw7wHEPMe4ccK6tAf9aimqhJqPl0V+Bikfkl4fktedv4ZrLKgtIr2+ExQ7
 25SAwAaOxfWOIypXMhhsp2xLAhqzxleYEH+Ab0JRLSI9DSvbLG18yWjOJCd/GzpwjGTB
 hccWtljI4jFXm6Ra36qKMxuJ59SR3YvzAhN1Dnd05HIwy4EUDePMCWdgPR4r0ipUB1nW
 blJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWA8rntnZEP96dwA+kvFFgbcp2W1TINj2FIg2yKRAa9TPOZ34pamxck/kCKmSdAshdhoGs55ETNDAT5@nongnu.org
X-Gm-Message-State: AOJu0YxzpPc1lWYfEcjIaViHFcgkfTQwzLybDmtRY7AREJz1LUSwPI6T
 WabHzD2DAr/43lobK7RRYz7vcUdYifztQVNqKllyMpNR+j13uqQMyCcqcRdIeHc=
X-Google-Smtp-Source: AGHT+IEdB4mjo49H+VzMG/oS0nHnJ2QXsUl8bm+l09Zgo4p90LxAUjzvNVTwN0jl9UTagLjeQUMk9w==
X-Received: by 2002:a17:906:6a09:b0:a7a:bae8:f2a1 with SMTP id
 a640c23a62f3a-a7dc50a2f0fmr225858866b.42.1722597345836; 
 Fri, 02 Aug 2024 04:15:45 -0700 (PDT)
Received: from meli-email.org (adsl-146.37.6.160.tellas.gr. [37.6.160.146])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9c0cdddsm87069566b.81.2024.08.02.04.15.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 04:15:45 -0700 (PDT)
Date: Fri, 02 Aug 2024 14:13:14 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Volker R=?UTF-8?B?w7w=?= melin <vr_qemu@t-online.de>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Zheyu Ma <zheyuma97@gmail.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PULL v2 17/61] virtio-snd: check for invalid param shift operands
User-Agent: meli 0.8.7
References: <cover.1721731723.git.mst@redhat.com>
 <9b6083465fb8311f2410615f8303a41f580a2a20.1721731723.git.mst@redhat.com>
 <21a0899b-cff5-49da-bda5-f53e12cca234@t-online.de>
 <20240801042204-mutt-send-email-mst@kernel.org>
 <79f6f143-0dda-4630-89ea-8d3a8ca4dba3@t-online.de>
In-Reply-To: <79f6f143-0dda-4630-89ea-8d3a8ca4dba3@t-online.de>
Message-ID: <hl8m7.3vs5o9nscf7x@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62b.google.com
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

On Fri, 02 Aug 2024 08:03, Volker Rümelin <vr_qemu@t-online.de> wrote:
>Am 01.08.24 um 10:22 schrieb Michael S. Tsirkin:
>> On Sat, Jul 27, 2024 at 08:55:10AM +0200, Volker Rümelin wrote: >>>> 
>>> Hi Manos,
>>>
>>> this patch doesn't work as intended. I guess you wanted to write
>>>
>>>     if (params->format >= sizeof(supported_formats) * BITS_PER_BYTE ||
>>>         !(supported_formats & BIT(params->format))) {
>>>
>>>> +    if (BIT(params->format) > sizeof(supported_formats) ||
>>>> +        !(supported_formats & BIT(params->format))) {
>>>>          error_report("Stream format is not supported.");
>>>>          return cpu_to_le32(VIRTIO_SND_S_NOT_SUPP);
>>>>      }
>>>> -    if (!(supported_rates & BIT(params->rate))) {
>>>     if (params->rate >= sizeof(supported_rates) * BITS_PER_BYTE ||
>>>         !(supported_rates & BIT(params->rate))) {
>>>
>>> With best regards,
>>> Volker
>>
>> Any response here? Should I revert?
>
>No response so far. It's not necessary to revert. I'll send a patch.
>
>With best regards,
>Volker

Hello, I am on PTO. I reviewed Volker's patch, and it LGTM.

Thank you both,
Manos

