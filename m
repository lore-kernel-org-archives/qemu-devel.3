Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C25C3271E
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2024 22:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPr16-0000mn-KH; Fri, 05 Jul 2024 18:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr15-0000mM-4F
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:02:55 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sPr13-00070y-BB
 for qemu-devel@nongnu.org; Fri, 05 Jul 2024 18:02:54 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2ee920b0781so16516931fa.1
 for <qemu-devel@nongnu.org>; Fri, 05 Jul 2024 15:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720216971; x=1720821771; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u+ZL80qL+hS3Vf/bqmuOEDduXSfk5Xbv8TcgxPxGk9g=;
 b=oJtazlWeTCKmQfvA2G/EahwG4PGRb4wK83yKJfdUwL0ge3tgln3/DAiRQsmJOFz0T9
 O38puCZHjc2eKVQRxto4dv9eh+d8AvM5q/UhhftvBAmkQz7S7WwIVD97P5SxluuRzq1M
 iBjfcDOmT19ZOP9yA04/rb42bpFDLlG+A23v7RefNc7MvMGjzh0cOXNS4hCkRanlFCJj
 1gUNFKmnc19zEZlZDrsnuUCmxr6AnZIKZHPCbkJsfQlj7Djnc9EDNX+UJTDrV0IIYxp9
 8IZwIEJOcR2duY0TziIs5HrIYMQ1qOYIr7AMk21T00YfXtMNscFQqBCeIrwSl6pz8RRj
 mxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720216971; x=1720821771;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u+ZL80qL+hS3Vf/bqmuOEDduXSfk5Xbv8TcgxPxGk9g=;
 b=VUeMmpYSaT3XXDF7b2SArslR+8FbpBon7+eEzXDcTxb2Z64bWmaVwW4fCo1jS45Saq
 ufUHkYGofLpzSRmV/jfXlF9qhz/xF0uMWsBKWq//z5hoD3XolW6MMCsqNj7/EnoOe+sZ
 OCBxhpZt5KU7QlDfJMWxS3BG9QjePRH/FCbGWPTkuO2tEqBj9CQWs5ERy1scCYigG6J7
 o3YsC3HtUapyhyO2ZhzBVarVfeANTUP8tih1EaWGFq3GuNDdXX/eIz+azE90Ms5j0k4g
 TzcqHTX06Yons2vWn5pzOYIx96+gsWU5XGNnGqGNEyF8UyK8TZto4qWIyOzb9vAfgftX
 ejQg==
X-Gm-Message-State: AOJu0YwLygU8L+SuNN8szJ7LPNcAbhOHSERVTZQ3f75J4MVufYfVUoM4
 flvs/gjJcdty/XkGH+lQAGJQpdyhl953KIC9ZdohTv/1okrM086bILycRcoiNLppXKO3+U7b6jo
 f
X-Google-Smtp-Source: AGHT+IGidCsuP7YWA/z3tOnZPSk9NBfgp+G4SMkUv/kT6vHEH8Xj8ABWmEQy7/Oh1W5GnfAQclhL4Q==
X-Received: by 2002:a2e:9d12:0:b0:2ec:541b:4b4e with SMTP id
 38308e7fff4ca-2ee8ee01a9cmr33251621fa.32.1720216970712; 
 Fri, 05 Jul 2024 15:02:50 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.163.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a21cb57sm74041435e9.21.2024.07.05.15.02.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jul 2024 15:02:50 -0700 (PDT)
Message-ID: <a0036c08-a7ec-4b52-8c4c-649e958b8b0b@linaro.org>
Date: Sat, 6 Jul 2024 00:02:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v46 0/5] hw/sd/sdcard: Cleanups before adding eMMC support
To: qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Luc Michel <luc.michel@amd.com>,
 Bin Meng <bmeng.cn@gmail.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, qemu-block@nongnu.org, Eduardo Habkost <eduardo@habkost.net>
References: <20240703134356.85972-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240703134356.85972-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/7/24 15:43, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (5):
>    hw/sd/sdcard: Use spec v3.01 by default
>    hw/sd/sdcard: Add sd_cmd_GEN_CMD handler (CMD56)
>    hw/sd/sdcard: Rename sd_cmd_SEND_OP_COND handler
>    hw/sd/sdcard: Introduce set_csd/set_cid handlers
>    hw/sd/sdcard: Extract TYPE_SDMMC_COMMON from TYPE_SD_CARD

Series queued, thanks.


