Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 744C2C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 10:44:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8GXA-0006va-4z; Fri, 25 Apr 2025 06:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8GX5-0006sU-KS
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 06:43:47 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8GX3-0000ZO-V2
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 06:43:47 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-39ee57c0b8cso2248060f8f.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 03:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745577824; x=1746182624; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WugQtgk7w1t2M+e+7VoFI3NjDM5w73zsh32ygbXL7ck=;
 b=BEMwmg2n/k1oQKOPL6ezn8+hzpNbZBaGnv7hrmmwyd+0ShX+t95nUhRW6LECP0Mton
 PxCJm6lxfXr55HCJpvPQaXK3wrjSsLOn/zpbshUrPmXvtRPwSTAF8/gNuTwT5kqEY6Ne
 yulcn4LmzV4fb6vQjbE+6sXG9Of5TMb1N+oSG28FgBEEx0mV6mYJCU+3x7wjJPVtfsOZ
 rwaMq3EyAyq5v96WDlqMhabum9vgi+PNZ8Ixiqtdckk9zbYZOJVTVLbOBPgjuk6Rn0nQ
 35lSCKZ/zQAuvKgrlan8c7TnAyGxod3RirjKenLpqmZJuNUlbWCC9kTxl7nL2LhaKbs3
 2kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745577824; x=1746182624;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WugQtgk7w1t2M+e+7VoFI3NjDM5w73zsh32ygbXL7ck=;
 b=CVCKHcvns3NoNvOYwk1WiSchmE1S5vjiTP7P7stLStzKQYXfNSM7pUZsEpKRkqkg5o
 9qXmeCYDnLtRCehzYgCys8/N9WZE6qC3tjmDr44lTaALCcvIL2GjAdvWMEABfrczUsCG
 bDMnZqNOe7wh8vhNZMyOQXzcU4he/BAz3EYvv2/qqZIiiqby8TndRfdKIa5pK3DIluFp
 a/xCuQhGH0XwI7blFnlYtNVfuXZ34R2WpCPEhVMdR81CdDDO4rgnAMqmHHkzIVwhheJJ
 1QS8a/U9mFxZzO594Mntdns1Y4Ug7qKGq4Ba+C5I44O1DdTCLw7OHdKfJkDBLwlK9i6i
 FkVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkmZBda8SEh7RUx6EAMxLuZn7X12xEvti0FSvWsD3UK3LpBAi1/y3GpW/WVpw5srU4j30d9JTO2hzb@nongnu.org
X-Gm-Message-State: AOJu0Yz5mZiaD1RoSHfnkQMHHsp2Y65c2ai0xwgiY9NGgW9KsLeSB9Ic
 BwdhYOFshyg5eha8eVCDqkUMRq74aVi8gUn8SuIKZRBfSPu17WgaflDA0isdbK4=
X-Gm-Gg: ASbGncuJerjPHDey0yGuS9/iQD6Vmt/gBy8P8yj7nTBBJyIG6SeK6/iE+Rgk73tiFkr
 NUFUs4xCCi+gYL3Zoqds4PYJXZaHSZmglEA3IKaAe7IMkpJZV2o1Lf/sUjzhph9R0Ki9EU0utdI
 QoXmCiNAy9qJPvnQG4XCMNF0haaIXLFeGGpCL93JuF8n7dIgbL011jwZ66h/+HwOFR+UtBkk+aI
 EfZlcapqG6YWG6fsX30Ow79NRbocp8AefUYhGfbZJ6vk+/Fgt1+ehe2fn1CP0sUL5HGcYNQQ/Yz
 s8o3joEtqL4zKGz5im7XPAbc0/W3E3jlWQufSsxFaVl0F6CI92YAiQeEw0ZJqNHIpBpAQ2LCtGN
 L6nvFQUg4r7VXfl6fl8s=
X-Google-Smtp-Source: AGHT+IFWmSuCSOE873r2/Of3l012EPjlJstviHX8EPtX14hQ/8yYIIimv20cdzqb13OgY8jNYNMJDA==
X-Received: by 2002:a5d:5f4f:0:b0:391:4bcb:828f with SMTP id
 ffacd0b85a97d-3a074e2ee09mr1440211f8f.14.1745577824375; 
 Fri, 25 Apr 2025 03:43:44 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-440a53870f9sm20192775e9.33.2025.04.25.03.43.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 03:43:43 -0700 (PDT)
Message-ID: <5dc7b171-d316-431a-b90f-b3bfb63f5710@linaro.org>
Date: Fri, 25 Apr 2025 12:43:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/hcd-xhci: Unmap canceled packet
To: Akihiko Odaki <akihiko.odaki@daynix.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, devel@daynix.com
References: <20250418-xhc-v1-1-bb32dab6a67e@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250418-xhc-v1-1-bb32dab6a67e@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 18/4/25 07:51, Akihiko Odaki wrote:
> When the Stop Endpoint Command is received, packets running
> asynchronously are canceled and then all packets are cleaned up. Packets
> running asynchronously hold the DMA mapping so cleaning the packets leak
> the mapping. Remove the mapping after canceling packets to fix the leak.
> 
> Fixes: 62c6ae04cf43 ("xhci: Initial xHCI implementation")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   hw/usb/hcd-xhci.c | 13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)

Patch queued, thanks.

