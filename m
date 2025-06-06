Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DECDC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 09:30:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNTOc-0006qq-ID; Fri, 06 Jun 2025 05:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uNTOP-0006cX-MX
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:29:42 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uNTOM-0001J9-W0
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 05:29:41 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-22e16234307so17331955ad.0
 for <qemu-devel@nongnu.org>; Fri, 06 Jun 2025 02:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1749202175; x=1749806975;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0cucf0fNbzoI6TltF2lzxdvXS014QSFuz2amwIFlu84=;
 b=IIwLV74keHKTOwi+KvcxXBke84fCTj6MlfXimFmLXpM81Rpzl9p6BVjH9SX3BQ9Fjx
 2kJrRT/KMVqheIWzWq+wTVvcPPH0GjpLY387wJu/5GIhLc/3NtCejDPWhj3qX52y81rr
 uxbjWoTTVaC6plooVu1uTM+xlRm8doF7VDt5Oech55EsLNV4LhbNNBPcuBBxUFg8BBuR
 S/4pOOTuLj5mt3YxAJkCzo7zwyVVjE6gUkNfuPyYfQsf/KhApzhtGDh2kmk2wnhZTrPx
 UXk9FDBRxOhvfJW+0hmPOxd6u5LEJlp4C/YOC1pTk8aF1Yozy7GYHL8kRfoEnzOuMuKd
 OPxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749202175; x=1749806975;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0cucf0fNbzoI6TltF2lzxdvXS014QSFuz2amwIFlu84=;
 b=tLxUwATd+voNB1mwKyuQYQnH4WlvaNtA6pO7DWIi4JxUSm87TJSrciNG0Y/MhHOIIz
 cedmQbZQF0Bw+fvPsubuszg4/CkePpXa61lZkLC8m3/XKJtA00gEGCbBCkzXF2nUhgqN
 nVOHl6LvoAofYG22a5RdcWiDTMF1ST+h3gersMOzQFrsXfu2tJDsMQo/S2Z42iyCbUse
 r9gUlfgai8DPQDJ0ZmAOdg9KE3fcJs0agJUaRjIrv5ukCSifGY6h9a8RxVTbC9oKSaKk
 Wl0QWG5fG7SdYWs/q7bWdjcuBs7JT6K7BKarK9DCIqdjVLvNBUTumgXk94GHQ4ZvttVD
 VNrQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHO4XIeup2I2VbEFCASA+uiX0VwW4UU3OzpDzDE8f12cn+FJyWYpnqD6EFseH9G4olWPbqTSBwpMGg@nongnu.org
X-Gm-Message-State: AOJu0YxFHmnkcMcInaE9uq9Q5lepSN52Yye2K4WOgCMrZZgGE4MUzeol
 mLiJWKB6BGIBJBFn+hHeq5nfZt30P0xS1uYyZosT2CGwy5U6AZBkidhGGbaRfgKzlhQ=
X-Gm-Gg: ASbGncuQdfey/ZToqVs+s64FxYBkHBr8fTWkNrU59M05WSq4ZhCsoAW83qAwRXzPmwS
 WNM/xLzTPZ6wOMumQoDYmDqWkbgRdYtKPp4Klp9vkYY1XgJq0M+dlr+2gRWFJ/4/8JBE0vB2ngi
 ZclcfJEIIudwNEgdmG+JL5TNVutN7W905fuZIESI2uXPYU1S3xwQnocnoQZDbHWdC6yRaIVCqZE
 b0IXRB7Fw9LO3RmkA1V4xjRNVZAtWPSHOkT5ar+ak3/lURpuzVjp7y8GUcM7MpXIX63DqzNNTmF
 kaDTN6TPyuv84wVFyaf1d8ej+two9xWOXGzy9OS4QhF7XwAcj/Zy4c/Pv6Yj2EoBXncgH50LLdw
 jDeSgC+q4iQ==
X-Google-Smtp-Source: AGHT+IEb31FsiuO7N7xz4NRwfrFoBKqivOo8yyuIse6DDbr5uxd1Ug07QksBGru4QlpRee9yXSOS+Q==
X-Received: by 2002:a17:902:ce88:b0:234:1e11:95a3 with SMTP id
 d9443c01a7336-23603a2ba52mr29473425ad.13.1749202175650; 
 Fri, 06 Jun 2025 02:29:35 -0700 (PDT)
Received: from [157.82.203.223] ([157.82.203.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23603077fabsm8664365ad.28.2025.06.06.02.29.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Jun 2025 02:29:35 -0700 (PDT)
Message-ID: <ec09774b-5498-4c66-9d44-5b73104f9e5a@daynix.com>
Date: Fri, 6 Jun 2025 18:29:32 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 04/17] tests/qtest: Avoid unaligned access in IGB test
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Nabih Estefan <nabihestefan@google.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>
References: <20250605162651.2614401-1-alex.bennee@linaro.org>
 <20250605162651.2614401-5-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250605162651.2614401-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/06/06 1:26, Alex Bennée wrote:
> From: Nabih Estefan <nabihestefan@google.com>
> 
>    ../tests/qtest/libqos/igb.c:106:5: runtime error: load of misaligned address 0x562040be8e33 for type 'uint32_t', which requires 4 byte alignment
> 
> Instead of straight casting the uint8_t array, we can use ldl_le_p and
> lduw_l_p to assure the unaligned access works properly against
> uint32_t and uint16_t.
> 
> Signed-off-by: Nabih Estefan <nabihestefan@google.com>
> Reviewed-by: Laurent Vivier <lvivier@redhat.com>
> Tested-by: Laurent Vivier <lvivier@redhat.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20250429155621.2028198-1-nabihestefan@google.com>
> [AJB: fix commit message, remove unneeded casts]
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-ID: <20250603110204.838117-5-alex.bennee@linaro.org>

Somehow this patch was sent to my old email address though other patches 
were correctly sent to my new email address.

The patch itself looks good to me, so:
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

Regards,
Akihiko Odaki

> 
> diff --git a/tests/qtest/libqos/igb.c b/tests/qtest/libqos/igb.c
> index f40c4ec4cd..ab3ef6f0c3 100644
> --- a/tests/qtest/libqos/igb.c
> +++ b/tests/qtest/libqos/igb.c
> @@ -104,10 +104,10 @@ static void igb_pci_start_hw(QOSGraphObject *obj)
>       e1000e_macreg_write(&d->e1000e, E1000_RDT(0), 0);
>       e1000e_macreg_write(&d->e1000e, E1000_RDH(0), 0);
>       e1000e_macreg_write(&d->e1000e, E1000_RA,
> -                        le32_to_cpu(*(uint32_t *)address));
> +                        ldl_le_p(address));
>       e1000e_macreg_write(&d->e1000e, E1000_RA + 4,
>                           E1000_RAH_AV | E1000_RAH_POOL_1 |
> -                        le16_to_cpu(*(uint16_t *)(address + 4)));
> +                        lduw_le_p(address + 4));
>   
>       /* Set supported receive descriptor mode */
>       e1000e_macreg_write(&d->e1000e,


