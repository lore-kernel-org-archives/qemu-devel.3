Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A80CCD183
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 21:17:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9VLd-00060R-Kt; Thu, 16 Oct 2025 17:17:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9VLa-00060F-V8
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 17:17:19 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9VLY-0000EF-33
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 17:17:18 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7811fa91774so1171637b3a.0
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 14:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760649434; x=1761254234; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=vYQc+OQd1WLprH4Xk54+pFw3a1MLnzBbVtUHUmSexRc=;
 b=EMDXZ4zoPMjwaR+7mzxmOfwod7kN9NAFott6FrscLQKRS6GrVA+aUgEcoNxMbUyKUJ
 PhqH21mMMpG/efbMIyAIGxLnNSmNrAc5Hkf7i4YkWMRiM8+szc9MNprK675Ja8KivWMv
 LIa1CVpG2ge+4Cwx93t0CaNp+2mPPwr/DOhZIx9eXN6mAmaVzz4zbGVUfTxhvtYKV6c6
 z1tfo7jbjDKbWUZAcOvSiekjUBD0LL4Zk5Rr27lrE8JVyxZjbxLWJ0yQtxZjOS8n/hFa
 fhuz13jdQo4MRtIvF1uWOyzqgfbPqNVy5Et5c9dXhSM+vOneCi7dpe4xvdCD6vmzuarw
 XkXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760649434; x=1761254234;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vYQc+OQd1WLprH4Xk54+pFw3a1MLnzBbVtUHUmSexRc=;
 b=fdyhwfXxec2ulQrHGi6D/bv1YXJfUHL+umfwC06fEeaFoHFT9z8wlnLY1bMFyLyBS+
 Dp3wRloRRstVD8lG3ihJuRNL7tY+Sea/gC9WEdOH4EKAZcqehuQlhobO96grIhvIaImI
 IxwZiUszWVTc0GlEXVughxL+gbTw5r0CMjYf1lEsioZ5zuTX/M264eh9Mu8MIBKjISPG
 VpwqXOiexQGpmTb1CZY7yBxJ/YqmhVg2/ogM94x4e6E6B+HfTB5eK+mue1HHl6mtBBMr
 eyejj8DVkdNZM3sL8vzY1AOjB8YlnqGPUmrmrguFVfzkoN4HCu21TtS+8CTrOWJ+bHFM
 6qXw==
X-Gm-Message-State: AOJu0Yzk6AtRzSHLt3nQSqjCAEzfbcXAYtKpckDBRk7/VrSW5eAziYEP
 +KI8FD553Bodo9sujs5h5B2C7h9EOGUEBPbCEC+dceQ4Cr+rvYuGYEei50pEgXAHtprRhlkXG6P
 gDNMw3vg=
X-Gm-Gg: ASbGncv59YT7+BMbUPqYiAmw/enrPx4wVUOigfWDBSN+H4i17VqFulnMfnTxhabyKwL
 kHzbvnb++7bjB0ur9gJuLW5HAnFZe2mXAdjU9PmcVUHkkFwtNTLdT85TzRwjsF+7vrW0HzouJTd
 /YXzTAk8D+G2ohUS/oH4P+I/RxwK0yRcmLZP2rHbvCxwmPlkFw3yYbwTisiwNmUD6oV9tlZabh3
 iuCSd/Yy8qCR1U8ws+lbpUcyqcJw4rAX0IAmVOzkQskwx/aDEXfc9p6Vvvu29nCmAa69h+nMf99
 x8Ff2U3ZtptUSnssymYFbJm83ox9rS5uuEUY2lMHAJkX3kucnN2GI3PBLJqE+5dKYkFOoVqdJnS
 1aykih4WPmMKJa+zbrRuVEbNF5eL7mtSPEBIrE/htW77TnjEih6/9CUpMTL5QQcfwJ7GROUWi1v
 7Dn4GzBK1IkBRH1FnPeqK+29Ib
X-Google-Smtp-Source: AGHT+IHz0hI5UQC5p4MVMNnlSGA+SQdpdA202dUBXJyrzY77a+vwDI5gfeTyARV3YMfVu0zZQRPp8A==
X-Received: by 2002:a05:6a00:94ce:b0:771:fa65:ae6e with SMTP id
 d2e1a72fcca58-7a220a99177mr1876120b3a.17.1760649433985; 
 Thu, 16 Oct 2025 14:17:13 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992b065c40sm23350583b3a.10.2025.10.16.14.17.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 14:17:13 -0700 (PDT)
Message-ID: <c6bea598-23d8-4f38-b488-ae017df8a8f4@linaro.org>
Date: Thu, 16 Oct 2025 14:17:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/arm: Implement SME2 support in gdbstub
To: qemu-devel@nongnu.org
References: <20251016122132.737016-1-peter.maydell@linaro.org>
 <20251016122132.737016-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251016122132.737016-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 10/16/25 05:21, Peter Maydell wrote:
> For SME2, we need to expose the new ZT0 register in the gdbstub XML.
> gdb documents that the requirements are:
> 
>> The ‘org.gnu.gdb.aarch64.sme2’ feature is optional.  If present,
>> then the ‘org.gnu.gdb.aarch64.sme’ feature must also be present.
>> The ‘org.gnu.gdb.aarch64.sme2’ feature should contain the
>> following:
>>
>>     - ZT0 is a register of 512 bits (64 bytes).  It is defined as a
>>       vector of bytes.
> 
> Implement this.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

The size of ZT0 is fixed at 512 bits.
There's no need for the xml to be dynamically generated.


r~

