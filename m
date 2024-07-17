Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F113FC3DA4B
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 10:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU1Zi-0001n3-MC; Wed, 17 Jul 2024 06:07:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU1Zh-0001gz-4E
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:07:53 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sU1Zf-0001TX-IF
 for qemu-devel@nongnu.org; Wed, 17 Jul 2024 06:07:52 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-368313809a4so241994f8f.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2024 03:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721210870; x=1721815670; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QEXmQJgpZNe0qzeHejZ78j2XMC1F/Zpcp8sm1S9LZNQ=;
 b=MYVm6pOwdgS8XTq29fulEFX94MBI4yruAPoNcrlxUPWYcMyfCrGa7dtGcBRYlwQ7aP
 Fmasq+ZUC4VAU5QSFb4eFbIQ2JHG60MTC2ZNmFDmeo1mww0bVYNjgpJspPlj93wQ6FFu
 q9WtAC69EH1gYugqMEZ5hRT2me/H7/vNh0B90xsSTn6W4p3me5V7TI33B0fVOlAI3bkw
 W6Z4dN0tV5QSxNwarDVHmTRJTYmDlXec5bSBdSHmgUf/562tBobsd3NnWgRBxTTDWj2W
 GkuJJM+CvjH9l5HTTVe3a6AofIRdGRDsokfcietBAOudS/6Wz2Ys/LUUDFyxsivQ3Mbq
 7NPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721210870; x=1721815670;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QEXmQJgpZNe0qzeHejZ78j2XMC1F/Zpcp8sm1S9LZNQ=;
 b=ktuhnBVighRTXgHZSOFductklqKFYsTrRGm2hX796XMTIEko7LHIv3aKnE9ejg4chY
 iismUymS8Ihi7l9YpM4MXD2GooTENFUw4xbnpYJJQcPtwVHJc4veNbJqFXSyKkKg4n6h
 WBer1wXaKKt0Q/wZyYoYkeqxKdjOc9kY5S2CtDFWI608b++GlklDihhBAP/Jx3hBj5OA
 qZUc7wwFlPACcx2ZXatojDnsMd/ix3/ng0dapNvKuKXGBXBLEcrW0Yt2ed9ZGEUr7qum
 yRwEPS29t/qBHXpAdmAVgwhDxta9Zuxd/uMjNSoW774PfdiBtp5f2d63La89VO+tnztw
 1dAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWEhQd6kz323CWdQ+/xWF7C0vIdXIN891Of97cHm/4mp0Enndh4RpF8ecETlifTbxPt5BQhDavkGCl659wUsx3oDq4HWQ=
X-Gm-Message-State: AOJu0Yzn6oS1orF0vmGa4Jog1EF5UwgPvFFIOECAFBImCuPPYDkuiKMk
 nA3sIx2wXr31RYYpAc7E+ZoLVDRjTRwntVloClQ1GizRrVIAKR5XTDVtSB7GvO8=
X-Google-Smtp-Source: AGHT+IGVwwJSvenSEJaMP75V4ZM8iTU6+Ig+478HUZoJzjmJlApixWYBlVdSNvhT+mG6an1FqQkmgA==
X-Received: by 2002:adf:ef08:0:b0:367:89ae:c204 with SMTP id
 ffacd0b85a97d-368273d6961mr2992482f8f.12.1721210869780; 
 Wed, 17 Jul 2024 03:07:49 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.208.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4279f2cc42esm200985315e9.32.2024.07.17.03.07.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 03:07:49 -0700 (PDT)
Message-ID: <1228cc4e-f8ba-4b1f-92ba-0b35c0aff9b0@linaro.org>
Date: Wed, 17 Jul 2024 12:07:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/8] aspeed: Tune eMMC device properties to reflect HW
 strapping
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>
References: <20240717063022.549849-1-clg@redhat.com>
 <20240717063022.549849-6-clg@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240717063022.549849-6-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 17/7/24 08:30, Cédric Le Goater wrote:
> From: Cédric Le Goater <clg@kaod.org>
> 
> When the boot-from-eMMC HW strapping bit is set, use the 'boot-config'
> property to set the boot config register to boot from the first boot
> area partition of the eMMC device. Also set the boot partition size
> of the device.
> 
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> Tested-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
>   hw/arm/aspeed.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


