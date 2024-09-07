Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A87F7CD4846
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Sep 2024 05:43:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smoDn-0001ho-6B; Sat, 07 Sep 2024 01:42:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smoDd-0001gD-Eg
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 01:42:46 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smoDb-0002AP-Fn
 for qemu-devel@nongnu.org; Sat, 07 Sep 2024 01:42:44 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-53653682246so3125389e87.1
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 22:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725687761; x=1726292561; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KFjm31zxVUtyMnrBstriW1QpXq5N5Ttm/vOf+zHfiyI=;
 b=HNjCu0eqllZ2viRDcKoDwbX8zutjEPJgOG7uKrJHJq1sVYnQCXpI82Tc/ZgiUSW2PX
 SjpMEtHETNmuUBxsVz/3piy+Ox9a7m8A+I2KNs7MP3J6U2Es0XAj9Xy5YuV8IAiX0mIQ
 EaBbAyUm9Rulltfbq9rL8NCzjw1zvXTVySVjXgLnAklm9M3R7buSjeQq21DDFq2CUsJZ
 UxF/cXwWPWl38kY4VFfgu3VUETnIBNjKY3GLZX3TiNgoKwMTPoYJokIsZ7U/yfu16C8b
 w+iAuqT72ebQ0R/i+cBD1151Oyf0Y6Q+Ae8/93hS1lhcao3JDI7Jb+7O1ggbJcslF+lx
 gQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725687761; x=1726292561;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KFjm31zxVUtyMnrBstriW1QpXq5N5Ttm/vOf+zHfiyI=;
 b=D2Uw0l++4wxKDftTm5WbHF1WXgWgKF5p6QVQe4oKbL8VC3K8JE2OKyDp5z6EWEL78O
 nxj93k9QmLKzjIrTlWi6i847z1r4mjXFW2CHWDqyvCiglmi+qgdE1JnTvwV8zXjRCjkb
 OJTc80aeacUSFf85ObdeLxhXzIkUJF1A8tfZyCkE2E+8tQHhSw+XEUdBZgEIosgxP75X
 oplEa4oHuJ3eDstKOmIB6dPN6wc3evgWf0DkhTXUQWMW6IfBn+5xlRmry4ESQtHgTLR4
 Y/BsvreWSk+V0WHKVHwsQwYbJtDFzT1PWT2fyULF0IbgMNI7GXMXHLSSy1WkPpseFfty
 R84g==
X-Gm-Message-State: AOJu0Yx2yHZi/40KAL2qtNxFhIs7335rw+Dam1XANBCSQQWFKr7FFUTc
 Yqv5XIDYYxeBqdDbv98rUKxXWkMztoqU1xqf98R4al1bAJ5JLIjq2h7hMTGQYHxfHhNYU1iKuWY
 t23k=
X-Google-Smtp-Source: AGHT+IG4szxEuFEnj1JbmFqSaixYx8jYJ6hjM2N7d7136XMPwQj+BkVf1PCau+asWQDA+KIkKixyJQ==
X-Received: by 2002:a05:6512:1092:b0:535:6992:f2cb with SMTP id
 2adb3069b0e04-536587ef18amr2653625e87.42.1725687760640; 
 Fri, 06 Sep 2024 22:42:40 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.197.174])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8d25979fa3sm30595166b.71.2024.09.06.22.42.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 22:42:40 -0700 (PDT)
Message-ID: <4bc83012-3b9c-4b99-8b6b-65f041652540@linaro.org>
Date: Sat, 7 Sep 2024 07:42:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/16] hw/char/pl011: Implement TX (async) FIFO to
 avoid blocking the main loop
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Tong Ho <tong.ho@amd.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240719181041.49545-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240719181041.49545-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Peter,

On 19/7/24 20:10, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (16):

>    hw/char/pl011: Remove unused 'readbuff' field
>    hw/char/pl011: Move pl011_put_fifo() earlier
>    hw/char/pl011: Move pl011_loopback_enabled|tx() around
>    hw/char/pl011: Split RX/TX path of pl011_reset_fifo()
>    hw/char/pl011: Extract pl011_write_txdata() from pl011_write()
>    hw/char/pl011: Extract pl011_read_rxdata() from pl011_read()
>    hw/char/pl011: Warn when using disabled transmitter

>    hw/char/pl011: Rename RX FIFO methods


If you don't mind I'll queue the reviewed 2-8 & 11 to ease my workflow,
before respining the next version.

Thanks,

Phil.

