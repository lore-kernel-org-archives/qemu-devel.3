Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DBF4F8E4AB
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 06:35:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDcnV-0007FN-Sh; Fri, 17 Apr 2026 02:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDcnU-0007F7-5A
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 02:35:24 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wDcnS-0000B8-Ka
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 02:35:23 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488ba6366a7so3728505e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 23:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776407721; x=1777012521; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5NS/1OcJQ2z5TmJfxbTyVH2TsYHDh05FLHASEzsGv1E=;
 b=aJmHN/qM41r28GT7Fml+l67Xff8vLHIjf8t7uNHKPb34KwlU+pFM5yjhXr3pNmp9A8
 GdAjYRhyvDGzsj8EEOufJjcl5yBIP8CAgAK3wc9O7Zucr0FSX2aGG5/8tEsqogtXSDlZ
 27aCoXCzbELeeY117JPVqWEdgmp2Rr31xnKyxdXOi/eIyEJFuaAqJcn8iPMM698QQixG
 LcF1CvZbxU0orF3LSaID9iUcCh4UPqanukUzQalEFs7w7+8ftPMwDdc+8mn8ZNssiqRD
 BGAZxY6cD4DoPpoDfc/xEIG42FCfPn9BCUELMVgOF56c7/8aGIAVZvBS95oqdCisLNMU
 aRww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776407721; x=1777012521;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5NS/1OcJQ2z5TmJfxbTyVH2TsYHDh05FLHASEzsGv1E=;
 b=c7ecp4piwJsP51OGhA+qEEOKG9osVt5jHT6FMYlPprV5TD/aCYK+eXH9h9d3bsca07
 1Ijl0yaQ3PAzupHwUtjTAZannlbIBmMah1/cKg+LXFKvswlQAbAsh6zXsT7sqlLoAw/u
 ByzHBz4MiovSFPlpYs2RJ/F7UATHbHC3+ZVPrVi3t4OKLxHIKlujtItkRUF7VLtBfXCR
 m7Yt1U95gTSDmJ/gDeX6WRSLLLA+BIN6y+cdG4vhH69ozz7FjDDiv08cqtCvUCfljrQK
 4qHddMf6k3gWxdlILRY8SrCMz81euSK14uVXhg/MGQSxdwdzxToB16N9SLjvOeEnuMBq
 1QRA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8wxVgNBx8E5GMn2KpJmX0wx85x49GgoI2JiNSMW3uxk0n6MlxEZoH9XlKA8IFHpWnT/K4ia2FxFDzx@nongnu.org
X-Gm-Message-State: AOJu0YyJTcQ7HF3x58BDORrvy8LMBzOS5k7psBEUYJLkF2oqMZNBboGr
 ofd8vL6+1G0ZfgR+eAasVyNgdmTFt6YREVnMc/CINDpxftGuY/UeLMKHnZNoD9Raugc=
X-Gm-Gg: AeBDiet8FSwBFQCOJb2i7Sat52zKAtkvhayXWx/gO4OTWKEgNvFrlP6b9T2SmY5rrNs
 LvIp2ME8rVD0HJW+r0rPDrRhqBAKqRayk2bJT7E7SGRwOkARlxEQSuew2W4hI/57qVHEFNRIypF
 X+krjccmr8BL3iVTMsDuE+/pNZm84+oYChXt+T4fMWIvYNnWr+RevGFyVroRLMivG2ZobbWaSUh
 2nYyIhO5Fvmya1H57ybZnjCiee5W3b9lULXvtMHOz/piFhX0+5YXLNFt6iWakOyOU4VyV2KZHwR
 woPeRmuLPZAyC+exDKCV7BDQg8Xe1B4uS/dMTwxPPj43/POXIw/NjIjImdZoEgybypiTJR11aww
 LBRt+8RRskYC9hQsPBEwnIlokAbGFVtmZ4Ee9bE+3fgtHcDJjKwqxrXxccXSeE4l11En71Mks1z
 8HES8YKED7QezygMdNltjkDclHLGYJHSQFLF3z6V9oUtwJsAM1i8GWJPAmW3jxIvM3G7XH2GAet
 1D3
X-Received: by 2002:a05:600c:4746:b0:488:9439:881a with SMTP id
 5b1f17b1804b1-488fb738412mr17494195e9.2.1776407720962; 
 Thu, 16 Apr 2026 23:35:20 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1c773fsm17234155e9.12.2026.04.16.23.35.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 23:35:19 -0700 (PDT)
Message-ID: <ba039ab9-e5d3-4363-9159-cc72670756b6@linaro.org>
Date: Fri, 17 Apr 2026 08:35:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/17] hw/usb/ehci: Add 64-bit descriptor addressing
 support
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Cc: Troy Lee <troy_lee@aspeedtech.com>, "flwu@google.com" <flwu@google.com>,
 "nabihestefan@google.com" <nabihestefan@google.com>
References: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260416014928.1279360-1-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Jamin,

On 16/4/26 03:49, Jamin Lin wrote:

> v1
>   1. Fix checkpatch coding style issues
>   2. Implement 64-bit addressing for QH/qTD/iTD/siTD descriptors
>   3. Add descriptor address offset property
>   4. Enable 64-bit EHCI DMA addressing on AST2700
>   5. Configure descriptor address offset for AST2700
> 
> v2
>   1. Remove unused EHCIfstn structure and dead code
>   2. Replace fprintf(stderr, ...) with qemu_log_mask(LOG_GUEST_ERROR)
>   3. Replace DPRINTF debug logs with trace events
>   4. Add functional tests for USB EHCI on AST2600 and AST2700 A1/A2
>   5. Fix review issue
> 
> v3:
>   1. Add Migration version test function
>   2. Add EHCI 64-bit buffer pointer fields description in commit log

I left trivial comments on v3 and expect v4 to be the last one :)

Regards,

Phil.

