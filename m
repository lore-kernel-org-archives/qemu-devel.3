Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99B1BC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 14:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts0mv-0005R7-Gn; Tue, 11 Mar 2025 10:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts0mt-0005Nn-Nj
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 10:40:55 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ts0mq-00048G-T8
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 10:40:54 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-2241053582dso11156755ad.1
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 07:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741704051; x=1742308851; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yY+Sy2R58LoXui0yaW8CsowsbAUNMOdibTb29N2io2I=;
 b=k61a75jXFj4/TtV6lo5THUVpmmeKAVJCkuEULA01bUoejuSHJBQ/flQi23rLryMsmI
 jx+6irps6Ibhp6PVhF76pEIEAcYzIOGbAZMT8SYWWvMnXZlc0BUMTXc52V75Sz501U4p
 t8qv4YwTj5JqkSTTGSGgaq/CTuEbfIajEb4T322IpcOKlU5G5HhfTWZ4hxm8PwS3tMC3
 JNz1GfdqmQALaC65e0eviQ+eLFQWSwGu5z7IC3cLyaBgUC+9Q/cAoejBMyy6lLPdcCBU
 NmZDxGYZomcLQLz3VCMwtFTQ/2SP5xo9fKfWkQ89yl9ok1w6eX4EGTIKI9sVZOw03zU8
 b2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741704051; x=1742308851;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yY+Sy2R58LoXui0yaW8CsowsbAUNMOdibTb29N2io2I=;
 b=KmPeChylUjY+2/uF6UpmyXM+IMvYsZEfZIfEExen9YMfOU364ecIaTeQZm9DzPEwYD
 G+hXIrXmSK2dL+VivgGhUri9Ydt1pP6TPI5xzL3uJb6WwTjbkuowERfDTVrkAcQUAVDY
 LbyLeKqIu3kyUMyi3dknKp/tlM0B745lzODxWflw5MHh85YHvVmrOJGhgI8NYgRHJi1N
 G5HzH3fy2B7gN14jOu79J6cr+EnBYiSzI91TP4gUXy7nvCSb6pbyUjWFoZQPDlbbWapE
 Ja+//1QC6m7/O8q1TVFUL+SOXiDhq4H2rH+irHK7T4TGisjm81DsmLb3//Syk844JHJu
 yZug==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfKLRUokuUGdrXA/BGwVdI7AxIImBrlbEWiZ1pFqBxkx0oR/8p/Xpelth+PRd56y9sHnDgbJFWUu2y@nongnu.org
X-Gm-Message-State: AOJu0Yw8toOY9LLHvJ7rR2pr45DBGugeUsdcFa0JTcnQS1oOJ4tkNdp0
 gBBem/0PU3HXkoVaC2Sdh0mWz+MpH9HvwmTrTz92Y+rTH5oioqcVNgzwqDPr0NwoENrZpXSlDMb
 H
X-Gm-Gg: ASbGnctCfJQYGxZBhqYAOCPh5S0o3HDDMzcztk7hBALcQ4AMwe+jP0YVKyFI9uQuiuO
 hF56x5uY6ATZeBbhUh1Ik6y2nX5mAaEc8yvdWUwt+ryPM3rJ3TSEqVji8RhQFhYo9tjmawG2qP0
 9tXS3xKOsy4+RcAOH7d/pYiuBdCkRZ9KxYlVjyGacJRRMW0p92fwFJ3Ytq+pTIER9/YdLRWMvgD
 yaGYExd2KLS6CAzvNcU5KF8ZdALgQg+igm+rnArqrF/fJ8MuZj5942Mrd/csdMsrD/nbPSkpGvn
 ZeRVRtiZCOIPtmLNCvkdiN+WNXJSRRKJxCAqpaFzXTXCpUXDP1iFqZBEY2S3zD/vhgetDWCTCoX
 UwKDEhZ4P
X-Google-Smtp-Source: AGHT+IEVRZPIxj7wvYl7OWWa8Kfhv9HpJtYFHInwJiFoFVZP7vwk+YW0JRqOXNuTWMXRaQtPs+C2cw==
X-Received: by 2002:a05:6a00:3c87:b0:736:2a73:6756 with SMTP id
 d2e1a72fcca58-736aaad21dfmr26139427b3a.21.1741704050783; 
 Tue, 11 Mar 2025 07:40:50 -0700 (PDT)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-736c7ac6e11sm6011708b3a.148.2025.03.11.07.40.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 07:40:50 -0700 (PDT)
Message-ID: <f5dd133e-aaae-4e54-9476-53a1275e395c@linaro.org>
Date: Tue, 11 Mar 2025 07:40:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] exec/memory_ldst: extract memory_ldst declarations
 from cpu-all.h
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20250310045842.2650784-1-pierrick.bouvier@linaro.org>
 <20250310045842.2650784-2-pierrick.bouvier@linaro.org>
 <57612d65-aec0-4785-86c3-0c8d647af38a@linaro.org>
 <efde9b68-fd8c-4e06-ab5e-6b1d4cf75332@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <efde9b68-fd8c-4e06-ab5e-6b1d4cf75332@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 3/10/25 17:04, Pierrick Bouvier wrote:
>  From what I understand, non endian versions are simply passing DEVICE_NATIVE_ENDIAN as a 
> parameter for address_space_ldl_internal, which will thus match the target endianness.
> 
> So what is the risk for common code to call this?

You're right.  I failed to look at the current implementation
to see that it would already work.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

