Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598C6E7716A
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Dec 2024 13:34:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMSHj-0002Pn-CF; Sat, 14 Dec 2024 08:34:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMSHc-0002O6-Ul
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 08:34:13 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMSHb-0007Rk-Cl
 for qemu-devel@nongnu.org; Sat, 14 Dec 2024 08:34:12 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-43622354a3eso18256825e9.1
 for <qemu-devel@nongnu.org>; Sat, 14 Dec 2024 05:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734183249; x=1734788049; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qryLo8GnwMuL5WDUJO7z/jT/YXZUuHwdXtP0T/vvWNk=;
 b=V2mb6wNX3BoZeS9OFV7pqOc0jEcIAnRk6Vd5n45esGL3PmcMIoIbWm0l83W69ZB6kF
 xQO6Wn28UEWJsbXfwu3T2L6qE6uUWrFzyFKXTk8GID74CZaoSkNJqDTTiJtzHBYj0GKY
 z3JgoqXXaWEw7q2smy48NXT06vqhjXKxM2tY2Kds0dZPVZPC5l7/EM2h+2GVxZ3yHQn9
 BXsVRTQ4kdH4q+C2gni9N5c2Pl5tNs0W/Bk48byX9asrzZOhlA5qlBiDs7iyqYEhcabA
 cnwGfXWH2qUZKaEwkoNRsruBWcUn6dUor1Zps4UDlXeDIkbayF+fVI5AX/MrY15A8j20
 SpZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734183249; x=1734788049;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qryLo8GnwMuL5WDUJO7z/jT/YXZUuHwdXtP0T/vvWNk=;
 b=fWm6qBVUQnmKvS3QDXePjeBNhwYrl1Q5Q1cICiuVrqJtgctVsCkGD8HAL05F3DrmYm
 hj3BuhC3zTTTc0YuEkX7NP6tUnb4w0XwokcLqTF7jZ0OMuYLbopQCnwMklXo+tG3lAHb
 /407pMVPd0fz42jPjudleifML96Hmms906J3SkW8q1w381qu/O9XejwPNnPfEUuIhFDV
 8AUpZE6BwWP1+OzzsNe4BlvXGNIVjVjm0UtEXJjpM0ZKDebsVcAMDXnSXT20fNhRFqTS
 LAJWTKntj6eJgmAXnuuvuc8oo3jaRFqjwQu4aYrLUhcK+c9omSLdPMbW9fYo+nup7Na+
 AqNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2RigUC6THA2fGL8pwYV88OwmcXt8Zvh5WPyfdU7RgJQ0L05PBAMhdx1QK+Z5IpKU3dPFUOF0G6eGS@nongnu.org
X-Gm-Message-State: AOJu0YzH/zQYE5J7rcFS+GjOUunUkORbiwMrFKiw9rv8IQ8PRmPLql//
 2cfi+uqGTM300X/jt45+tTQvIUtvHm8ebV0YIF38etdpECr5/eb1NxzwLI9Dq0c=
X-Gm-Gg: ASbGnct4PkAM3VGEgUpUf5j4v6iQonhqluz/9g9/1fRTqH4aRSuJjZw1fwDRUjeo6TO
 Spo9OG7QVcM0epUqacQ16Ih68rfkaZy1y50AIYxQ4D/mFQvN/9FvbVqtVMAHmOCWfryO/iC2CAL
 +kFY8ZSBMZacrE54XBOMjuCdKqb0XuMZ0284ac+SG3fxacf+cvbbrBvqDJYAvOxpitXFhyuC0oa
 5y2mniw5D1K+fCeFqo4bAHHaVMNoe5keejNisGJpC92g0IKtw1WkE4NfbROYB/IhhkrDHmuVtJt
 v8dOXPf4LxrsMwwNPyD3712rHg==
X-Google-Smtp-Source: AGHT+IGQbQ3B/38Ys3LUTVEprVCnoLbW64Y3/N0kdsD0Cw1uoppvHTc2vs8sMyxtRuTZipZr6HRKUQ==
X-Received: by 2002:a05:600c:3496:b0:434:a07d:b709 with SMTP id
 5b1f17b1804b1-4362aab4896mr53229235e9.29.1734183249101; 
 Sat, 14 Dec 2024 05:34:09 -0800 (PST)
Received: from [192.168.224.213] (201.19.205.77.rev.sfr.net. [77.205.19.201])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436362b6981sm24581225e9.31.2024.12.14.05.34.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Dec 2024 05:34:08 -0800 (PST)
Message-ID: <d291689a-6d4a-49ed-97cd-655e96eca0f7@linaro.org>
Date: Sat, 14 Dec 2024 14:34:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/34] next-cube: rearrange NeXTState declarations to
 improve readability
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, huth@tuxfamily.org,
 qemu-devel@nongnu.org
References: <20241212114620.549285-1-mark.cave-ayland@ilande.co.uk>
 <20241212114620.549285-17-mark.cave-ayland@ilande.co.uk>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241212114620.549285-17-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 12/12/24 12:46, Mark Cave-Ayland wrote:
> Move the NeXTState, next_dma and TYPE_NEXT_MACHINE definition to the same area
> at the top of next-cube.c.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Thomas Huth <huth@tuxfamily.org>
> ---
>   hw/m68k/next-cube.c | 64 ++++++++++++++++++++++-----------------------
>   1 file changed, 32 insertions(+), 32 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


