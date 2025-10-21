Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33C2CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 13:00:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBBxZ-0006dS-OB; Tue, 21 Oct 2025 08:59:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBBxM-0006aP-5M
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 08:59:19 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBBxJ-0000If-Qr
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 08:59:15 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-47118259fd8so34133745e9.3
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 05:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761051551; x=1761656351; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RKb1C0Z+V+5BKrIvq+PMCgWnQegFZR5Tk+7yDTWXqyI=;
 b=mmQ7k3hDLQvprlXJcAY0dUw6b2GWBIq/p1OhBGkkbOpkLup29yjYnRVVCnyaJcrdjE
 pyezZF2w+hF/quu/8SwU22oy0a3I3fgNIzPpM01X3W7GkquCCZo73z/0uj57X2LEA6+S
 V4sBYKuzSzzviyxAebw1wK6KBGywiLtuuI7hfTx87mCC/ahvMlrM6vwebg/r97Aat4Tx
 9TZH4oniGsEOKOZDa1Vyl29FfSUcYhnCfviRD4e/6zRNHA+DXZ8i+du0+5dd0riYnrM7
 29EmN/n4Wd/O3toREMRkdhoRMWOTAWuaHs4Fm1iv91OYHcbc3/WB9XhhTCBwBqnncRhV
 T5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761051551; x=1761656351;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RKb1C0Z+V+5BKrIvq+PMCgWnQegFZR5Tk+7yDTWXqyI=;
 b=boiXDLDuolF0VuFBqprwpHR/CbrXbYQsMB8MEDz9KKvFCJ03zQCDgtbqK8p/ED3jwA
 oRNRYVlriHTy1SA6GK3Yg2486qGU1c3QtGEz9AHnLDp2nGH7CSAXm10ZjK/tWC2pYLj6
 yL8ncQntHoJ/0GIvD59OQHduRtALzUY8Exg0tSA28vEOYOzlCpeeD5DZM1rLUYDINOes
 +hPbgDolKZBGQ7KbDLvWIja6Vf90TXLoZeatY2vU6cJtIOkGHlxyyn71GUseZfElPG4S
 jLei3dfeNT9A2DGBB22jZ+EvDSVz31ZVnhyW5/PdkIXhA7UNESMxj3J+SnIS3tbE8a8R
 0a+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCViHY0AXXZtn1xrkQBXAD1Nl8HfTzCKfFKjzSKk9rme+IWv9DwPLuwtCCDVyNKM8R2Capu6K5HvpmDP@nongnu.org
X-Gm-Message-State: AOJu0YxjS793ThykXHL8pnfY6EveokeIhJ6xbCfo3aBeai3N9CGk3PDL
 ztZ5RzFYTR/zcqYehNSEBJAF+d8Z73QwEBUYbLdkAu0ihZscmCBLnG2iO6vqcZt3OfM=
X-Gm-Gg: ASbGncuI2/CTAT8r5prUE7wOfHpS9D8xRJu344UF4PBV9Q+4Qw756UEY+RXNcFG302u
 wYxKdUOjS9Q6L505w58xrVcE9fiTlf1eWKRB/+wJlR5ppzhdTlaxr7yiK98A1KN+F+QKbtUfdib
 lQkbNalaJJp0R/I1BaaOdQoy8/2uaK1kBdNjoTbwBe/ZlmuOthv3YghOIvzplQ7UtwkQWNz7zAx
 SgMDUl25IV3VbcdBy0Hsc9xTH7OhbIHmrpvSpv2tiPkJWUrSC4A6X7JYuwPASPOn8Xjj0U1bc1h
 PCpqBrX+N4mUIe1KqDxC4flT3rKF9MYwfuk0BlHioeCFeqtVosxkKSJmOiqljYjZQdqqm/C7qy1
 pPAZeKmcp+Hcfwc/xH5DxjIfpoxtbayU4UXuz+ABvsWDnw5aLHSiHSs4PEgFRkHb9JKWAQiGWGT
 YA2PyfqlPEKmhflZng2ApfHz3BDkJ06ek2+1wp0Jq4pw8VQJ88zqmUvg==
X-Google-Smtp-Source: AGHT+IEqSeSnKgX3CY/v/1OzV8CgzUMQS6J9/2JtGG6PbdCEEfzt9fy0Fag4AMdJQxcpRhymGrY6ng==
X-Received: by 2002:a05:600c:800f:b0:471:700:f281 with SMTP id
 5b1f17b1804b1-471179041b6mr126108355e9.25.1761051551113; 
 Tue, 21 Oct 2025 05:59:11 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471553f8a3asm227592395e9.16.2025.10.21.05.59.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Oct 2025 05:59:10 -0700 (PDT)
Message-ID: <f38dc977-e6bf-40ea-b439-b0e5a49df81a@linaro.org>
Date: Tue, 21 Oct 2025 14:59:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v5 5/6] hw/ppc/spapr: Rename resize_hpt_err to errp
Content-Language: en-US
To: Vishal Chourasia <vishalc@linux.ibm.com>, adityag@linux.ibm.com,
 harshpb@linux.ibm.com, milesg@linux.ibm.com, npiggin@gmail.com,
 peter.maydell@linaro.org, alistair23@gmail.com, balaton@eik.bme.hu,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, berrange@redhat.com
References: <20251021105442.1474602-2-vishalc@linux.ibm.com>
 <20251021105442.1474602-9-vishalc@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251021105442.1474602-9-vishalc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 21/10/25 12:54, Vishal Chourasia wrote:
> Rename resize_hpt_err to standard errp naming convention.
> 
> Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> ---
>   hw/ppc/spapr.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


