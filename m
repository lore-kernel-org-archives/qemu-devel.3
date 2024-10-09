Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D62CCED614
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 07:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syQfr-0005Nh-Nt; Wed, 09 Oct 2024 02:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1syQfp-0005Mt-O8
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 02:59:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1syQfn-0005Pa-Tq
 for qemu-devel@nongnu.org; Wed, 09 Oct 2024 02:59:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728457190;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2bjpps8q8wyN4AxZ6gK8xYk17I3xUWKFTmCf2QHC7hE=;
 b=cH1h4eTl9MRclVWs6s/x60pKvrXy0iNvOdf8bxB/fCghRnLixS5+pQzL7i77Nc6XLgun8b
 o8CD0a0LQ4mNiI5EdkoohfwC+L1r5dQXVW2w53eDz3tUrnJhhNyF8cBbU3vmgyg4K9BeOc
 wbXFTF0Vh6MkOuqkvne+NW6dZ8btu38=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-IJgX82oKMlWVbLoeAGH1ZA-1; Wed, 09 Oct 2024 02:58:50 -0400
X-MC-Unique: IJgX82oKMlWVbLoeAGH1ZA-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-204e310e050so79612045ad.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 23:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728457119; x=1729061919;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2bjpps8q8wyN4AxZ6gK8xYk17I3xUWKFTmCf2QHC7hE=;
 b=N123RKNj4tXHXEqczpJkd7tpESTBWrwV4ln8FaLR/EO7XmkK20268WHBwbidLoLZZV
 b+KAaQfDEVb/9xi15eVXkWfsfOqKKIuDvgK2CfTxih7EEcR6W15rMTLz5zI1aMnOZ97J
 WZwL4jQAarzBpvJOIk+6IVWwXO1lRjcN0x/VLIVKGfl3uNR65Viwwjy0UcUDlTLD0NcT
 73bTrd0IdA32F0CFZhrqiOBCWSZSWRISOCCfPee5jDs6U/TvdPyxa8OuwOgU2UFpSaVe
 XcEZTeMrlK02kCub4fbH+Ixi/Z14NjYjwJvW0nMD6doLLx+sc+ADLgc8M7MABSsb5Eff
 Cllg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWbR4YZEKaDeczzsT1SNstSjFTs2ar2jWj97whjcYL6N2td3e13awdCMs+nLEDRV9nAmsuT1WfEk3wN@nongnu.org
X-Gm-Message-State: AOJu0Yyx1Wpv2OeIzZ1MBarmF8gtJ9dccVyIOs07NZ7GWQbU9aNOGy5D
 UlfdZX27SWtT7Qlsc5IJc6zHaaeMsWcx2C66tb7QI6UNl5yU3oJNvqkFESsL1D3KBUxE7MliTM8
 QSbb5ry/nXMya+cBkdwuHID5/6s8Y09JFFDfUWYbJvUPug7cqRlOi
X-Received: by 2002:a17:902:d4d0:b0:20b:5351:f6ab with SMTP id
 d9443c01a7336-20c6378eb2dmr21798865ad.53.1728457119666; 
 Tue, 08 Oct 2024 23:58:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7ytO8Drp1G72OBaNXAa75zR+2moOmxxZT4hZgeifdd/ZcdzKmWQePG73a17RbEyEwRjgKzQ==
X-Received: by 2002:a17:902:d4d0:b0:20b:5351:f6ab with SMTP id
 d9443c01a7336-20c6378eb2dmr21798665ad.53.1728457119368; 
 Tue, 08 Oct 2024 23:58:39 -0700 (PDT)
Received: from [192.168.68.54] ([43.252.112.159])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c13930b92sm64518385ad.128.2024.10.08.23.58.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Oct 2024 23:58:38 -0700 (PDT)
Message-ID: <ca04ffc9-df13-423d-b864-71e0395ce509@redhat.com>
Date: Wed, 9 Oct 2024 16:58:34 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/char/pl011: Use correct masks for IBRD and FBRD
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Zheyu Ma <zheyuma97@gmail.com>, qemu-stable@nongnu.org
References: <20241007144732.2491331-1-peter.maydell@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20241007144732.2491331-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.151,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/8/24 12:47 AM, Peter Maydell wrote:
> In commit b88cfee90268cad we defined masks for the IBRD and FBRD
> integer and fractional baud rate divider registers, to prevent the
> guest from writing invalid values which could cause division-by-zero.
> Unfortunately we got the mask values the wrong way around: the FBRD
> register is six bits and the IBRD register is 16 bits, not
> vice-versa.
> 
> You would only run into this bug if you programmed the UART to a baud
> rate of less than 9600, because for 9600 baud and above the IBRD
> value will fit into 6 bits, as per the table in
>   https://developer.arm.com/documentation/ddi0183/g/programmers-model/register-descriptions/fractional-baud-rate-register--uartfbrd
> 
> The only visible effects would be that the value read back from
> the register by the guest would be truncated, and we would
> print an incorrect baud rate in the debug logs.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: b88cfee90268 ("hw/char/pl011: Avoid division-by-zero in pl011_get_baudrate()")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2610
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/char/pl011.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


