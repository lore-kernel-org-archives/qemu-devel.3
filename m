Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C76CE7717D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 11:22:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM3jx-0002XN-QQ; Fri, 13 Dec 2024 06:21:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM3jq-0002X8-LV
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 06:21:43 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM3jj-00085c-Dc
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 06:21:42 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3862d6d5765so1074521f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 03:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734088888; x=1734693688; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V4UtAzmD2ehs7mM1BlK16bTNLqMuaINGq0hiaFOH+1Q=;
 b=dBdfhj5giWxrTepLL1LKEjofX1PN23eqkWi+FKDGIHyOSGCUKboYBxs7Dr1eimOthc
 VU79aVn0f3wKdj4+kFKJSAdqZxSIiRc5g8u0Mp9w/u5hQTLvGso8umbmG1QJfiUJndzC
 J4yurdTgu73auK4DHyykl2vXAStc9R470TvhLDaaayxOn0L/HSDU6d3g/QUyknZ3CqX+
 mcJiht2y7/miruz42aDMHn4W44+MC+ht+HNFXCL9KGoJfvI0RrOQMhKRast4hpPnjjP5
 k6GPhJgXZFTzEzFZErk+gSBmNZCaMZF1+++0wW/W/dKS2JvbbMnQyt67SLmIZOHdiWy2
 d2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734088888; x=1734693688;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V4UtAzmD2ehs7mM1BlK16bTNLqMuaINGq0hiaFOH+1Q=;
 b=O5EGr3nfe3M+kjO7lFXKFOKfjdX27KpIRjr4QI9vIZTeYNvLQfVFNFdajrI9o00Ith
 OiuOn2HDvUq1j4YGYFRopbH5p7LPc9quoZ5beOkKR2AVBz5QGAKjGbQIf8RmDzQbedDT
 gLcSr4SlQgTREoJtax0VB/7iPdL93YISoQJhWoZljm9YhnCqlJWzwuGnIH97p3unjAqS
 qCAfvNPdirgm6eDF8x+kY5MbMGpsurSnmA/+lbEJqB3GFOVmGSEVm8dflbHxrJ9yIQTC
 WMahgEOXXHtwqQaOQJw4InbIriC02d35TjTfffH5TcVMNFbUtAku6C7+jVo3IEGgDu7q
 MCMA==
X-Gm-Message-State: AOJu0YzAJq9/iNMeXR30buIKf4fedmbePNT2VOW+JXuJdivvIMmTrrua
 pnAmPbCAAulQTTH+I+XRFH3jUB+rHHywd9cRoBIk5rf+lMoWWFgDgD2PA3C4UcZfGqbtqHP8K4V
 k
X-Gm-Gg: ASbGnctxkZAj51xavLsRPoEflDrr8UCb9v6806hrlaMcInrnpzlpMebSMe7tTjhINC+
 TryqvzN9nBf+cjeCDVe1OtfubKmOYIPdKkKpppIsZ0xLdS/XH4SVfCO8dXUBGqi8XwaCZ4a+3U3
 tC4BD4V+aIKrzrUoYCXuxJ12N3O+5lrpAF9bDPZJvWioDt58lVTrLUg39ATMRzi44wK03gGGMH6
 c2fb6Gx88ifncKChazZLshBcA0bKdDfA8b6in7gZDiX0dZUFke00XB44aa66sjF0d+qXrjXuGcR
 e3Y9xXJgyp5DsAWhf2OqIQZg
X-Google-Smtp-Source: AGHT+IHMlGfKL+H5uvTB9oFrY3cLzZ+negEiuB0HywA+gWF1rQ+77kizS72quU+tzMFQahpzN1wXVw==
X-Received: by 2002:a05:6000:4619:b0:385:e0ea:d4ef with SMTP id
 ffacd0b85a97d-3888e0c0661mr1285358f8f.58.1734088888082; 
 Fri, 13 Dec 2024 03:21:28 -0800 (PST)
Received: from [192.168.69.223] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3878248f5a0sm6705187f8f.13.2024.12.13.03.21.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Dec 2024 03:21:27 -0800 (PST)
Message-ID: <c6280dec-0d47-466e-b361-ff452eedb6c9@linaro.org>
Date: Fri, 13 Dec 2024 12:21:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] hw/timer/hpet: Make fw_cfg state private to HPET class
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Zhao Liu
 <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20241206191124.9195-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241206191124.9195-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 6/12/24 20:11, Philippe Mathieu-Daudé wrote:
> No need to have an external hpet_cfg[] array accessed
> outside of hpet.c. Move it in the class state.
> 
> Philippe Mathieu-Daudé (4):
>    hw/timer/hpet: Introduce hpet_add_fw_cfg_bytes()
>    hw/timer/hpet: Reduce hpet_cfg[] scope
>    hw/timer/hpet: Have hpet_find() return an Object
>    hw/timer/hpet: Hold fw_cfg state within HPET class

ping

