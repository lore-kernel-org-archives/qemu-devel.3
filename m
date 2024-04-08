Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99E3ACD1292
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 22:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtx7F-0004pY-Gf; Mon, 08 Apr 2024 18:05:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtx7E-0004oi-07
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 18:05:24 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rtx7B-0003Z3-8V
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 18:05:23 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4165caf9b2dso17038745e9.1
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 15:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712613919; x=1713218719; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hgklZCSMJzVwztwZf9i4cyoWfITG4nxFgImb0mPq6lo=;
 b=VDBsffeUA1jtPy+VqNDjdzuhOEtd0A+817NQaUR9Uf2GKoOAYYfFiQ1nREFCRrVd06
 l8nMoJ6k0E850xoWH5r6wa+Y9ED3wfmsHWH7Vpyfoqb4oVW5aFcPHdV3udaoLx0n+Ogt
 +xkHU52/rdY0ryl0Fp49M6iCVdH9wHB0gGcdZDAgBp852Muwgya4rDUqRAiHL7GbxamX
 4/3vQ8PFsAc0lneID22N6RCNuEu2/5dsgdcmdRU3z1lct9lE6eR0no2NvhCgGQh21wai
 +bzHu+oLwtSUMm9Gc3gVI+hum1g8NmkhAgjr+MAY2frZ1/SAVza4u2UFcBuKVhRumMmK
 wzDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712613919; x=1713218719;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hgklZCSMJzVwztwZf9i4cyoWfITG4nxFgImb0mPq6lo=;
 b=kWMcuCu7hzwXHtJNVXs8EN0CijdTzPpVxdcIql4eYF5+VmZpyiXJrFNzGhKSUaz6Yu
 BJoEm/kZdT/dXXdXUMC0/bsPPq9j6yWqsd0X1k205KAmZ/Mr6IyKJrAUTtcuesPlSfsr
 /KTp5Iytzo8zsaVbsXX/srdHofKdgK3qRkcTwL/zA07EZxpb3IFkuzp4FkudhNahswup
 4dit+ToLZzkJCIbMTkBanynWph5Ea/5Uxn7zWXKM/SNG4NKM/RLdbakqINHWrvN9x+kb
 wg14T+UQqy3PYjL88cicrnDvygFn7It/0KS/ueOQR2icx9EWPOL+QbjUORk1xvYw7F2y
 Chdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvaPWpXVzowiItcwhkg9r/RFnG2Vpk1h5n2HfaR/mAfgSNNeCSTR0lP/LbCXHUeDXzKpxGTqAapqCSVI1quCZFeLJbdx4=
X-Gm-Message-State: AOJu0YyX3fd5/A8hsDV+2oB682LCTFocX3stzKFYd4aNm5uEi1gheaZB
 r2WTlpGvYNR3ajd3mUd8W8hn1nwm1bNbPRObwPWwcML2JnlcSfCP1LR7t/z2Yyk=
X-Google-Smtp-Source: AGHT+IFNkt6M0VOtxXhbyp4ZVyQ5YhCzVh2FkKcvStVrpb4+ZrHTHsSt3gVgUhHJwtdK6mE0/PmxXw==
X-Received: by 2002:a5d:6105:0:b0:33d:73de:cd95 with SMTP id
 v5-20020a5d6105000000b0033d73decd95mr9096553wrt.17.1712613919463; 
 Mon, 08 Apr 2024 15:05:19 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.144.67])
 by smtp.gmail.com with ESMTPSA id
 n6-20020a5d6606000000b0033e745b8bcfsm9894161wru.88.2024.04.08.15.05.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Apr 2024 15:05:18 -0700 (PDT)
Message-ID: <ee492ca9-4d79-4de1-98da-8df9230ca5af@linaro.org>
Date: Tue, 9 Apr 2024 00:05:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0? 3/3] hw/block/nand: Fix out-of-bound access in
 NAND block buffer
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Qiang Liu <cyruscyliu@gmail.com>,
 Mauro Matteo Cascella <mcascell@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
References: <20240408083605.55238-1-philmd@linaro.org>
 <20240408083605.55238-4-philmd@linaro.org>
 <d610c2d2-3576-4ca2-a2b9-4f9a5390e3d3@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <d610c2d2-3576-4ca2-a2b9-4f9a5390e3d3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 8/4/24 18:39, Richard Henderson wrote:
> On 4/7/24 22:36, Philippe Mathieu-Daudé wrote:
>> nand_command() and nand_getio() don't check @offset points
>> into the block, nor the available data length (s->iolen) is
>> not negative.
>>
>> In order to fix:
>>
>> - check the offset is in range in nand_blk_load_NAND_PAGE_SIZE(),
>> - do not set @iolen if blk_load() failed.
> 
> Do not set, or do not set to non-zero?  I had been wondering if the 

Oh, "do not set to non-zero", thanks :)

> final assignment to s->iolen should go into nand_load_block as well...

For the next tag I rather keep it this way which seems more
explicit to me.

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks!


