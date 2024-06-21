Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7D7C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 06:27:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKXjM-0004O9-5v; Fri, 21 Jun 2024 02:26:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKXjJ-0004Ny-T1
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 02:26:37 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sKXjI-0006L0-Er
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 02:26:37 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3650f2e540dso1041611f8f.0
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 23:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718951194; x=1719555994; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qlGAlkZfTk61bVYQBn45idrU7hvl/Gbhx/41mWlESZU=;
 b=LukHJk3EHfesID5Hompj930c99siEW7MhrNp3PwrtVMee0RWfxYJKypSYWH00sYdrx
 czbuYkYLvRfj4soY6DthlzI3bw6eIp1yUd07jUD+V0IJ8bZ3qmbGr/7cB67BVMfwWPPP
 oZ7DClQQvSF8UaPBdWj4J3NFyR8N7cCz206KZnTGTEaVnv0QaYpoNFdo1AQ/WH07LtRc
 tdfZwpQfIpYE1U5AuYYl6/7HB+FJowkJFKTFGMOyLpr4veFxA1hKvcaxOcUWrSsdibPR
 3gh6T6vOK22ai2x3Arll6Nv8YfKV8ugtFa1R1WWq2Gv/oxMqYTwEko/ChLblOnVvjM/z
 TjqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718951194; x=1719555994;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qlGAlkZfTk61bVYQBn45idrU7hvl/Gbhx/41mWlESZU=;
 b=RGfFbphlxjhPUEurWggPTzYtX7Ez8J1htQDJBs9FNINSF1Z0+jrk1BdiCrVUYqNy12
 QzyIOivGeq4xDoLV1CJq8wp11SlSxQVjCVDiJrHdmc19EHd5FSDHYRaRUuE40FAG+yux
 GA5SKIv/49xsvulGeQ2Adz3yVBprjSRPS3pbzeWKOGM5HOGLs2R084zF7cZCPWVOVEMD
 rny6YyVnhvqbggcMR6KoB43Q3uPxUznrl15K4rCtpMWPK1aFLAzZJ5CSc21wasiD9kpj
 CrcDh6LgjBn9hnD0FVaCNRszefSrGY1ckB2ClgB7ee17xFjlueKy5BCHtbTvpbP6i/Tb
 bNrw==
X-Gm-Message-State: AOJu0YzL//ze4tDZDC/hGk4KFXTeoZ3jmOeDl29O5KXac31LorZWXzrY
 SQP/t7YXghc/7E0qb6yRQxr5llk/Bj0ujZsnmL8RpiSCTav9S0UIck0xfGGaywc=
X-Google-Smtp-Source: AGHT+IG9lW0xlnyDu/4lYZiVKCYxpbClvGg98Qd2lAoCukPQ7tZ/xgw4Lc4BNzv7SvR1t8PwwoWnPA==
X-Received: by 2002:a05:6000:108:b0:360:9641:573a with SMTP id
 ffacd0b85a97d-363193c62dfmr5509260f8f.43.1718951194029; 
 Thu, 20 Jun 2024 23:26:34 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.151.40])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36638d9bfe4sm802936f8f.53.2024.06.20.23.26.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 23:26:33 -0700 (PDT)
Message-ID: <6297a086-7e59-4299-aabd-68cf14fc42bd@linaro.org>
Date: Fri, 21 Jun 2024 08:26:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: standardizing i2c device ids
To: Patrick Leis <venture@google.com>, Markus Armbruster <armbru@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Corey Minyard <cminyard@mvista.com>, Titus Rwantare <titusr@google.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <CAO=notyY_Jc2_Xq0NeK-0zUORy1n-6yuP5M_WXWEQnaqTmVXkw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAO=notyY_Jc2_Xq0NeK-0zUORy1n-6yuP5M_WXWEQnaqTmVXkw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Patrick,

On 21/6/24 00:03, Patrick Leis wrote:
> Corey and Peter,
> 
> My team builds lots of configurations for Qemu boards, and one pain 
> point has been that the qom path for a device depends on the device 
> insertion order, child[0], child[1] and the like.  I noticed that the 
> qdev paths for devices also exist by their device id property.  By 
> default, this ends up being the device type name.  I was wondering if it 
> made sense to override this with the device type plus the smbus 
> address?  I did something similar with the i2c mux device, to resolve 
> part of this issue.

Including Markus since we discussed this with him last year, but
I don't remember correctly what was agreed / decided :S

Regards,

Phil.

