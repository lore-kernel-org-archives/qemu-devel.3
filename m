Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA96C25B4F
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 21:59:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4pJC-00016N-VC; Wed, 08 May 2024 17:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4pJB-000165-7v
 for qemu-devel@nongnu.org; Wed, 08 May 2024 17:58:41 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4pIx-000704-HF
 for qemu-devel@nongnu.org; Wed, 08 May 2024 17:58:40 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-51fb14816f6so249078e87.0
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 14:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715205502; x=1715810302; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iPoLc1i8CoxysbXgzY1g8MHKCY6OFR0k+fHD2JgyK+Q=;
 b=kPpPZW676E61Fr3N0nrs2TfdLcdtU655Xclnxx74J3gJQ7yWCxN/KCcss/1SMulJsy
 iritVRjnCDdvN8vlb1iZlFIRBvIZFYK6CJ16EVqCIRNZMf7TMHutX+XvJQKVNVwIc8L4
 GJb6NB2sa0aammjxDPeO4LEzL7DBSQ8BPXS1VVdv/qLAHCuG1SjA/JuSekdikFAHEO2p
 quId/trFeRmTjvvFyZ6WPSC1hV2MvpEQR91waK4OaCD40/J+Fakxo7FqSNOtM8i3Jq2g
 hudavrwdi0EXt+yay6edAeRrND4hnjdctU76IguoPd7JeZq2PcSBMJkDTIJKY6Uz2iTc
 NBvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715205502; x=1715810302;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iPoLc1i8CoxysbXgzY1g8MHKCY6OFR0k+fHD2JgyK+Q=;
 b=UNx2vMaPwDA03BUUkdcp5oTFnhwnVsoF2zqZaTS8h7eC7u6+fPDoUBRGWBaMMG6KSC
 0EdGqE3ZOReTZPT8KL1LaB6gKCq20oc0jRshsh8m3u1wUe8sDu9YvGgrzUryYaqb7t7C
 wQsG14pTdnQ1z5erlT7684VeRbQAShW0S33BnpFFkD2oYzQKNB7IXGc6Js9wiE75jxb6
 PvPFCyX0A6NZRL0Ho1ju2mt4QBqtPOsScPYThKXhyhCyX0gcg0wAHbHUaF1rOidzp+5E
 aychaMjEwkHEHN2OWTes02oBvhOZvZCuXmts5KCkBhwf107yoVKQmt69j8duvKYgkpZN
 ZlQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUasbWXrU6sqiAFSeccJYoGXuAh6wuGM6f3Rut6Y/8/aEy1ODEvr5c2sWDTSKLUd8vuM1HVTXUdn8nN1xVHLQq5c4hmLXA=
X-Gm-Message-State: AOJu0Yy5qtIYeSK4pmdkPaqowCy0HbmsEll2viQ/GhnQ93G2wXBa7M3d
 LGMVLEKzOtgkfXcdPEVCwWkrajGLOc1ge3a0ESk0hf7VeZGdyf6Qqnr/0xvY43s=
X-Google-Smtp-Source: AGHT+IHkiFe+e6XtEJi+N2gN6Dhbx1/gHzO25xekrx0C1FX4PVkePyog/z6Q/qRnXzX5DOFUtSR2Kg==
X-Received: by 2002:ac2:4565:0:b0:51d:416e:8434 with SMTP id
 2adb3069b0e04-5217c278bc1mr2356869e87.2.1715205502057; 
 Wed, 08 May 2024 14:58:22 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a179220efsm5648866b.94.2024.05.08.14.58.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 14:58:21 -0700 (PDT)
Message-ID: <99ce62dd-ea8e-4eee-88f3-b349a8b00f3b@linaro.org>
Date: Wed, 8 May 2024 23:58:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] Add migration test for loongarch64
To: Bibo Mao <maobibo@loongson.cn>, Song Gao <gaosong@loongson.cn>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240508031110.2507477-1-maobibo@loongson.cn>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240508031110.2507477-1-maobibo@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 8/5/24 05:11, Bibo Mao wrote:

> Bibo Mao (5):
>    hw/loongarch: Rename LOONGARCH_MACHINE with LOONGARCH_VIRT_MACHINE
>    hw/loongarch: Rename LoongArchMachineState with
>      LoongArchVirtMachineState

Patches 1 & 2 queued to hw-misc so far, thanks.

