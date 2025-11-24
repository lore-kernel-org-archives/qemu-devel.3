Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB0A9CFD313
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 12:31:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNVc5-0005FU-H7; Mon, 24 Nov 2025 07:24:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNVc0-0004wS-FW
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 07:24:09 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNVby-0005BW-RX
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 07:24:07 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so27303865e9.0
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 04:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763987045; x=1764591845; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YFUqPyXoIDtGVeuH7VqsJ7MOoz2HmKT7WqlGbCd66cE=;
 b=VCZB5+aDC/Nz8ddeT9/vzpyvc3VkftouA1A1GuvJQzH2wPVuPyA0ofcrKWJMl4Xt6r
 QMhMIiQBYapagn5Z7RO9YSbWs1IgOd1+VT38cHgR3q98Gth1DhgPKJ27rY3yiUWvtmcD
 g/dTZQgGyr23T+o8y250ypTwm3G7cJI0LNepsbp3MQrIeamPfwTUr/qWfx4d6MKyc2sG
 TUjxQYc8qZHHcMvkBR143WSZkHUS168S1h4+c4RoBOaYLR0LjM1kzmq0Kus+CwpP+yMS
 fakB1sT4fvlwdjndJ1VeAmkr09rJCU0DVAR1hl3AmciJAVIaIzv4Q2nlYcZnKpvL+gIR
 63aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763987045; x=1764591845;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YFUqPyXoIDtGVeuH7VqsJ7MOoz2HmKT7WqlGbCd66cE=;
 b=s7ESptqLiAOfHTP+A1JQqS3n2mIRzZzLcICpMAK42HsE4Be1dnotDfywkmUkhKBhkI
 /7ZvjK5EPN+wkpAMZcb3r615usUyK0ZxooTpksXry/8tZvYZCBrsyJjpNtVAdUPwiWG9
 qsdSn654lrtHee215u+jTnMaFIy9TQKQhGxQ0VL/+wM0QZ1abhH/Za3TD9Hr0GhnILRP
 BhNDGQzyxy39xinq42aKWa0qGGa2vS0VF2bru2sN5k30fPS2g9Cy2vy4UblMry9HvXnz
 VP/Xw7BZSEMWf44gtFYm8S72FaHOirUA3DNYlqj9Z5p+FVYDsD2cXVHkw2ecM2JYUeLT
 +aeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUF5P6nWR8e5F1hRYw1TY0Gh2DCsrpAa+KzujazkDhvwQjTDmcXgSQp7s5Dt2ToAf4pNxWQIDNaW0y7@nongnu.org
X-Gm-Message-State: AOJu0YybBEPYxYV0xX0wQ8XivwZWqrY0miUtOdk4zaIatLg3caMQKH5v
 VHWs1Azn0kzHEIDhAVlNnegBj2C961HPpV2RC+PWZjIVtwujeynlmsNGlSgwr4bVCpo=
X-Gm-Gg: ASbGnctXOuhYSuERkewoXuCaQp40hI878ZQrd/pXzMTb97tmwHhdEs8HkuYubBVzJeM
 CiWi1C1acqR5Si5cJzPxoxgTJhTajAYVVzC9yQtH0A5FghV1h8KOno323Vh8yyT3PKHZcxEqHSb
 oMU8dOgITJIQ09x5/XLxM0pWzVZxHOo0B1ioHL2OQskeosR0DgCJSdH9K5bDqI80HNQKGEEMs6V
 zshAfm0SZnkf/2ohqXLEM0hy0zHbnQSoA0/XxzfBVxO+zttBb3RIikLPgKT5kqxOpx4uJ0wfLR/
 MikbX1Pd12DDUTeQ0KfhFfjj1gH6Y+1gzaNaJbyzHmBB8xnxyMHCS4LLG1nmu/Z8D/DmVMUI6wE
 s84YsbqiTeGl2dHJeC+hWUCTNZ2QpLeqbeRWgHVQpoGaBpyP7ulZofAgYnisgEuMQ8YBWd9qurL
 +xPTNSA1KJqar+QZmugd1uBx1ErUBojgwwziHPohMVtBXFX2nPDC8VnA==
X-Google-Smtp-Source: AGHT+IF0xZUJpWScuToPTVMnXkp0BeFuganRQnYpKZaLr3KG2FLf02qV+StKz4/owrVpnt9lr4kMCw==
X-Received: by 2002:a05:600c:1d1b:b0:477:9671:3a42 with SMTP id
 5b1f17b1804b1-477c1133e4bmr119196285e9.35.1763987045330; 
 Mon, 24 Nov 2025 04:24:05 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb8a29sm28606915f8f.30.2025.11.24.04.24.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 04:24:04 -0800 (PST)
Message-ID: <1649f7fa-281d-4876-9172-3cccddb77b39@linaro.org>
Date: Mon, 24 Nov 2025 13:24:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] Use g_autofree in unpack_efi_zboot_image()
Content-Language: en-US
To: Daan De Meyer <daan.j.demeyer@gmail.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20251011081553.4065883-1-daan.j.demeyer@gmail.com>
 <20251011081553.4065883-3-daan.j.demeyer@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251011081553.4065883-3-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

On 11/10/25 10:15, Daan De Meyer wrote:
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> ---
>   hw/core/loader.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>


