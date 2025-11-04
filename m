Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E703CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 15:08:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGIdc-0002Vi-RQ; Tue, 04 Nov 2025 10:08:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGIdR-0002VI-Ei
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 10:07:50 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vGIdM-0004fF-QC
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 10:07:47 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-6406f3dcc66so9715165a12.3
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 07:07:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1762268863; x=1762873663; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3gkApcen/u7PZg/AmNna6Nx5Sh0pjv/0bpJjfcjE7Z8=;
 b=s2r8noeMphij+YeFBApSzB5DMlvBkbbSIDJCnneu/CgkFW9qmREssvOgeyyfWZVUix
 H4M5HZWxH5MhJPnAVuLWXeD+MjbrQzMOSjQTxlj1+kzQ9QhKmiwU9+0MDFcwXALxlU8F
 I7YurCkGeMWbmVaqDMm9mu5J3LTWJuDQr/1P+SgMZgez1/Pwri6gib1F/D2cf3uoliHF
 bNWHHF5k17dzd/KbOx70mI4D3Oudt+iwk4ykKzlBhpJ0vFONw73LnRNI8rsONlSSfB6K
 mrBfgrWEyd3rBZqNO0+Hk6Aop0fQQ+Cpbo+xDhLtAb7ScNfWIzw7bamNUotQoEZbqNgp
 rtlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762268863; x=1762873663;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3gkApcen/u7PZg/AmNna6Nx5Sh0pjv/0bpJjfcjE7Z8=;
 b=Ew0rGBgXmfCBtrhSBHOM2QyROVdGkgwNmTRJHiR03FcbOzWZvGN61F5v9NA0HcfSkh
 8Qa7l7AA6DppWcmi0HdrPJKQBXAw0220iJ/63nOF/Ot6AzXyxIpnWWUXGyoZgMC5jYOU
 uie6uyFhz7LpZ7phhLV3Ghb9CKFplrnarC0E2sAwgQa5x4vIZWsHjO4AG9qXPg7UPTVj
 CVMvZPUSSE2cQDWoN89MBEqlmF3UjZmfmerxNm69LUUmsEZDyFhowgP+6D3xGZYCLDoC
 iF7jV+8U68VQKb3y4PNt0NjqiyxDBl7NojliO+1WWirxswOdjGk0YFrsgHtnzvfyhTEe
 /ZkA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVV0H4NV+kRqLwvuBHxkrVBzGW0ZViefMt05sdsFxCnWHf7v2KO0Hi+9YygWHVv0CFD4wVwuvXAYruo@nongnu.org
X-Gm-Message-State: AOJu0Yz07HQ170aQOu+D1i+eRzXG7q4dJmYD0DhR6hXqExA+zFO9MSL8
 cGRnAwwu4oF9bE5LczpgJk0uJropRuG3GmYZXfYkIVWtJXkLzE9t+gZmqeadmmbAtVU=
X-Gm-Gg: ASbGncu40bbqfy2ZeQ7CIJLPn3K3k4UDT9booWFyQFj0TsB9E2tuJyIVGmuU7DU1A8B
 3THeouNbpyJ9PCgsPLpYdD7YdwrX3nkAht+h9mBxi+Uf0TETAloBazarT4oO5tTIY6bAmOf5kjs
 tpwv9S5Gf3p3fn1tARINOaNywiewnUHUQg7tX86EK1F9WBCMdc7Vm89pir9fxBq1p522EklyDnw
 zqi8+1KuhD2Notj7bH8NcQLmgqOze6yXZEZVlFrTsq3UN9aj/ciKqUSseYs4+5pXh94/U6Mkkme
 EQxHeoiZg6Fxb4o3C0YvwxjyEC2wLocGV3VdizsUrQRuFqD871nbRWptshC+CdTY4MZgDcy3e3a
 LlrWtyzmeZWXyYhyuX8ttIBUft9yMYLNVGGBCIKYhj9hDSbqBmd3W5ebc/SGHJ7s4HVkoNd6d8s
 QdrY3EKlIUmHvW7KlMa/s=
X-Google-Smtp-Source: AGHT+IF7jaAfKfeePIja1K1/XReBS97lQlhZDT257gHOiypg1d/53s84pgXUyxYW+QIzg2cYoxGRvA==
X-Received: by 2002:a05:6402:518c:b0:640:ba44:c731 with SMTP id
 4fb4d7f45d1cf-640ba44ca96mr6880024a12.21.1762268863182; 
 Tue, 04 Nov 2025 07:07:43 -0800 (PST)
Received: from [172.20.148.75] ([87.213.113.147])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e67eb671sm2284178a12.2.2025.11.04.07.07.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Nov 2025 07:07:42 -0800 (PST)
Message-ID: <bd382183-0cb0-40be-9ee9-18e637837d97@linaro.org>
Date: Tue, 4 Nov 2025 16:07:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/6] hw/sd/sdcard: Add basic support for RPMB partition
Content-Language: en-US
To: Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel <qemu-devel@nongnu.org>
Cc: Bin Meng <bmeng.cn@gmail.com>, qemu-block@nongnu.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>
References: <cover.1762261430.git.jan.kiszka@siemens.com>
 <d57388b599e47f5c95f30be7571b77f9016289eb.1762261430.git.jan.kiszka@siemens.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d57388b599e47f5c95f30be7571b77f9016289eb.1762261430.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
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

On 4/11/25 14:03, Jan Kiszka wrote:
> From: Jan Kiszka <jan.kiszka@siemens.com>
> 
> The Replay Protected Memory Block (RPMB) is available since eMMC 4.4
> which has been obsoleted by 4.41. Therefore lift the provided
> EXT_CSD_REV to 5 (4.41) and provide the basic logic to implement basic
> support for it. This allows to set the authentication key, read the
> write counter and authenticated perform data read and write requests.
> Those aren't actually authenticated yet, support for that will be added
> later.
> 
> The RPMB image needs to be added to backing block images after potential
> boot partitions and before the user data. It's size is controlled by
> the rpmb-partition-size property.
> 
> Also missing in this version (and actually not only for RPMB bits) is
> persistence of registers that are supposed to survive power cycles. Most
> prominent are the write counters or the authentication key. This feature
> can be added later, e.g. by append a state structure to the backing
> block image.
> 
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   hw/sd/sd.c             | 217 +++++++++++++++++++++++++++++++++++++++--
>   hw/sd/sdmmc-internal.h |  22 +++++
>   hw/sd/trace-events     |   2 +
>   3 files changed, 233 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thanks a lot for the ld/st API changes, very much appreciated :)

