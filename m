Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC17ECEBF93
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 07:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLFzu-0007VF-V8; Tue, 18 Nov 2025 02:19:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLFzr-0007U0-UR
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 02:19:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vLFzq-0005W9-1X
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 02:19:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763450364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VmJdiDmFPOlENInmh2WpPOtarGUE9pSC4w6eVPjoNRQ=;
 b=gW4VCU8osyKBKg1d9lg7U3RJ97GBy9OUpIWilYXzj8zSjBqDPwMRPzFWIpJKXiu5uC8cVT
 URaiDdpQV2DDtII7TAEy66ph8pHbDt24HhQEMEcJ+X1szc5sfuTYGh+KobSnw3uKthXp9m
 p5eShJ526qhcrKWPgQDbM3FgwQwPlH4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-bFN_erB9PFutbI4QjZS6QQ-1; Tue, 18 Nov 2025 02:19:22 -0500
X-MC-Unique: bFN_erB9PFutbI4QjZS6QQ-1
X-Mimecast-MFC-AGG-ID: bFN_erB9PFutbI4QjZS6QQ_1763450361
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b736eca894fso353704466b.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 23:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763450361; x=1764055161; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=VmJdiDmFPOlENInmh2WpPOtarGUE9pSC4w6eVPjoNRQ=;
 b=NyT164TDK1zN41g1BWXi2J2sg4fr8wjnUo8dXbTlX45cROSzGwWjd/N7xHwoUk5rSG
 PdoktxQggwSoJGqw+eTjK++OCXykgEelCEaQmkIWus9jr3M4mzk8r/CzOVUQaMZdAzrG
 WVRAC20SXUGTzS7vMWfSgbHPHvM5H9v+NHLmORVgMYVhEg9k1UC80MstJDJl/wF+mr81
 9n0nXXpqLa5cFa7kxOEUEwTf8pf9zonIQS/CjmQ7Hl1fLWd16JplCCtEr6HGKSnI2Ayv
 1O4Kxet99Ls5HVRpetc5npYrC4pEOef+VB8MCE7WMnkEOL8ZapFmfMfTdRxXcNhetNNl
 eHqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763450361; x=1764055161;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VmJdiDmFPOlENInmh2WpPOtarGUE9pSC4w6eVPjoNRQ=;
 b=QnLEnm8BRm37dUGDYL1ckjK6srijCd92Cg2GjDYAqdxggzi32r32DXgPBqs+MnLBaG
 JCxfZI5tdRa12jWWX8HM7Etaz0zjpimszJeutk0v2Q++oXhdMiWkpICV+A+WTppbi8v/
 Nz5BaricgAQ7TSiQo7/vWSwszR4oy/UOGBA0jJQRkllFLIy010dRliT2uuyYvcOyLGBq
 3Lm9nAI0ykqdHGE48yeBTUK5Vx3YQQmpPYz2fojWHWI2hpgOXIhWL8+hu3g4yQs2LIzZ
 74Ia76QQQ1vvBAhW6IlV7Vq9cBGV3VhGxfzyLHM8nWPqIPSSvAi3gpgbVZh1td9lXLcP
 cLVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfgJB6gPl4mNISNMn5b1MDRK9uzeTcHCXudl4/kGW8czKSgCZpfUzZ+yUhDsgeiY4izg9FFuMwhM1G@nongnu.org
X-Gm-Message-State: AOJu0YxWav6XsLDQa4TOKEJsb+/8A+RZzLG7O1nCpnunp8qCVHXbouqN
 Qd7W9Ebag9mOifp6Tl98VY97zPeHK0y2Ql6kBA8Vk8az0zRuwhAkmJ39NQkWpAZo3y+0mhOg91V
 a/u8iuWS7UoeJTdn8tJmHVzzoY225Zpn/3oS0Ex0HocKRnEX/w1l8Q9N9
X-Gm-Gg: ASbGncvNyDv9IzA7BsZASM5F5HpLsISUH5bGpQvUadmOusxJ1xeNf13kMurLVRfU8cw
 htC3Vj1rwMg8VdnQrx/r8LMdJ9TvI2/OtFXnswU1nyc2Yq4fzw/NanWpGz2Csw1kR1bj3iK5hrj
 IkpVBn3gZS9OfIN2odq7ifRt/itfMXjtrWdLjvqIBkjLG4pYm4YWYy/0DmrK1zAPK1hdip7yTpW
 4EZ9vWZ3/KMLmBnAL1+fU9hWA1xOgmuTE8qfDgVeCfJFxz5fLYFR53dWOUgzw67pH87SbPTThwi
 ss6ncIRxdLn+T80AZLlcE1pPRoE4NpnWIhCeC3qhqYil6aPVb9EUFe0nSkJBOIATl96ySO+ropS
 XW234YS4=
X-Received: by 2002:a17:906:99c4:b0:b72:e158:8234 with SMTP id
 a640c23a62f3a-b73677edb41mr1701641766b.3.1763450360778; 
 Mon, 17 Nov 2025 23:19:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjcUM66lVLajpcsD+J5t/2c6Kqr1UR/H/duLU2HRmYRKqLoT2teKaft5Lh0DxTSUBLCuILPA==
X-Received: by 2002:a17:906:99c4:b0:b72:e158:8234 with SMTP id
 a640c23a62f3a-b73677edb41mr1701639466b.3.1763450360361; 
 Mon, 17 Nov 2025 23:19:20 -0800 (PST)
Received: from [192.168.0.7] ([47.64.114.102])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b73a5d77a03sm378549666b.63.2025.11.17.23.19.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Nov 2025 23:19:19 -0800 (PST)
Message-ID: <f1f5e3a2-2528-4c15-8729-63a01acdd8a5@redhat.com>
Date: Tue, 18 Nov 2025 08:19:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/22] python/mkvenv: ensure HAVE_LIB variables are
 actually constants
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Hanna Reitz <hreitz@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20251117185131.953681-1-jsnow@redhat.com>
 <20251117185131.953681-2-jsnow@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251117185131.953681-2-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 17/11/2025 19.51, John Snow wrote:
> Pylint 4.x has refined checking for variable names that behave as
> constants vs ones that do not; unfortunately our tricky import machinery
> is perceived as these variables being re-assigned.
> 
> Add a temporary variable with an underscore and assign to the global
> constants precisely once to alleviate this new nag message. Add an
> ignore for this name for older versions of pylint that developers may
> have installed locally.
> 
> (In other words: there is no solution that will cater to both pre- and
> post- 4.x versions, so we target 4.x here and silence older versions.)
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   python/scripts/mkvenv.py | 24 ++++++++++++++++--------
>   python/setup.cfg         |  1 +
>   2 files changed, 17 insertions(+), 8 deletions(-)
Reviewed-by: Thomas Huth <thuth@redhat.com>


