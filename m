Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80D3CA0FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 11:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut2x2-0004oq-Sw; Mon, 01 Sep 2025 07:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut2x0-0004oB-2O
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:43:55 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ut2wm-0000uO-Qr
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 07:43:52 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3cbb0df3981so2070168f8f.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 04:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756727017; x=1757331817; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5vPB+uCTKThjbxVRwS6EBkKN4EVWXWVAmW/EtGN84nA=;
 b=b34E414x6K35s60RLm68oppDfMmx0MWa8lFb3DKryP2lRAN8QatRLz3Yb4G1fHqnte
 0yJB4njtB6hwtaxgfllT44ierrDjE7CEMTnI22FFTnlhAtUsRoDZSvjPVuWnB619QDIP
 8oy3cufhNI9nD/mQzy6z4tSzcUdC02Ex62bHfhbOuv1qzYpGadeToCcnnuC8WzK7osaw
 L6lWmSBdzJMDIiCcBj01a5h5Lzpw6t70wsjVtycRz6JU8vnk1HRzFdjiZy1OuJ92V5QE
 qNPKu1rpmU1jvfkT+RJ9Xn8pOmoyGzszUCgbJbcJGC5eDvzUiXG4ZSeU9sIkhOQSTsIG
 wT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756727017; x=1757331817;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5vPB+uCTKThjbxVRwS6EBkKN4EVWXWVAmW/EtGN84nA=;
 b=v96q0rh4G7nOALQiFghwl8W5qn8dzSObvt2J1X1guVaVNVA/5SiQg4SJWEKa7K7UVS
 GOHqdVkvIKkMuq2FPZorsy/EyHH6Pz6yAUW/2VHKEgYV3SPT2PpZEJQJM6mUhLNQQZ1L
 EqvNIlUsx8CG4DkV1TD64BeYSSMokLtROG1t9/mgdNP9iYegvnpGRTQhE12hU2qN7s9D
 FbjYOy7aKLfrub4DapFbqC0cJkWIjDVOuUWakJf7g5NvshNrfDjSdmv57LjDTMT3uwne
 pAPmoVVSiOZCom4OTcXVCiw9JtjT2+UQxiFsQCLz/uJXd23aAHu74+rgK/UMHygFEI9R
 thqw==
X-Gm-Message-State: AOJu0YzlXWF6r3Ki6oHRRUtvXI1Sv2TEll3YLLvMHEh3CSyiuivlhR4m
 PZDGdBHLOZ0mN2s6Yg+Ae1wZKXRZNnbPpLoSkCqBboAVA9VcDFHszqxxetTIpIau77bWOh5h3Fx
 cCJWT
X-Gm-Gg: ASbGnctpTkKCKjcgxx6sAeR6QSMBdZkP6E1/CshsvWLmnaSixPfc4uZY7r8YaT5Mcwy
 4RxqYIr5B1VO16I1qXzAfI5YtT+zKu1qCKS2jLCRTUx5Eb0HmZ1VqKLqolHLmQDijZlJHTwYUk6
 kTAedZNlLuiPINMWRYlnGnp5Z+sTr6EfhsXCdyGn205o8nZQNB2C+kJIDmEL08hSKrqaN7gb++K
 +3zcURdc2CEu2y6jBWwoSTR2/xjO/QEU3gGADdRgswIaM6yFInnqlhd1ntyLs+ecCfxGa7q/Nl0
 QobNimd+KnA7aau/vP11/BdWu0xGn0SDE0Sd/hLdEYAK5PElBC2i3l+/VXXbNQlSMOpejzWaz/j
 3Pi/nydOmzwyGrm8vu5AegY7ZjIFfj6MI7cx/lYCxsgAZJfEMu4/mOipKxURlZwmHmxDaWQBzuq
 2J7jVojA==
X-Google-Smtp-Source: AGHT+IHlM/Gsho8UTdqV3Lsm22622Je7DAcSmwzcsS1qdNLadVIEWRZscv5hwTKaTqphfdpxgLjCsg==
X-Received: by 2002:a05:6000:2410:b0:3d8:e1de:7e4f with SMTP id
 ffacd0b85a97d-3d8e1edc849mr392142f8f.21.1756727017281; 
 Mon, 01 Sep 2025 04:43:37 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b85090262sm104205435e9.17.2025.09.01.04.43.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Sep 2025 04:43:36 -0700 (PDT)
Message-ID: <fbba47d4-09af-4719-9cf0-c660c129739f@linaro.org>
Date: Mon, 1 Sep 2025 13:43:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/scsi/mptsas: Avoid silent integer truncation in
 MPI_FUNC_IOC_INIT
To: qemu-devel@nongnu.org
Cc: Don Slutz <don.slutz@gmail.com>, Fam Zheng <fam@euphon.net>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
References: <20250811095550.93655-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250811095550.93655-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

ping?

On 11/8/25 11:55, Philippe Mathieu-Daudé wrote:
> For the MaxDevices 8-bit field of the request / response structures
> of the MPI_FUNCTION_IOC_INIT command, the 0x00 value means "max 256
> devices". This is not a problem because when max_devices=256, its
> value (0x100), being casted to a uint8_t, is truncated to 0x00.
> However Coverity complains for an "Overflowed constant". Fix by
> re-using the request fields in the response, since they are not
> modified and use the same types.
> 
> Fix: Coverity 1547736 (Overflowed constant)
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/scsi/mptsas.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
> index 1ebe0b82a79..4ada35b7ec8 100644
> --- a/hw/scsi/mptsas.c
> +++ b/hw/scsi/mptsas.c
> @@ -579,11 +579,11 @@ static void mptsas_process_ioc_init(MPTSASState *s, MPIMsgIOCInit *req)
>       }
>   
>       memset(&reply, 0, sizeof(reply));
> -    reply.WhoInit    = s->who_init;
> +    reply.WhoInit    = req->WhoInit;
>       reply.MsgLength  = sizeof(reply) / 4;
>       reply.Function   = req->Function;
> -    reply.MaxDevices = s->max_devices;
> -    reply.MaxBuses   = s->max_buses;
> +    reply.MaxDevices = req->MaxDevices;
> +    reply.MaxBuses   = req->MaxBuses;
>       reply.MsgContext = req->MsgContext;
>   
>       mptsas_fix_ioc_init_reply_endianness(&reply);


