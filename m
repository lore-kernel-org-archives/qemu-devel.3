Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77F18EA7941
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 18:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnhix-0008Th-WD; Wed, 04 Feb 2026 13:35:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnhiu-0008Sk-Hw
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 13:35:34 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnhir-0003rz-1P
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 13:35:31 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4801d7c72a5so1125225e9.0
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 10:35:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770230125; x=1770834925; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8tctsqqueOweB61bv51fAI5Am248JpGWEFHuwnfzxYI=;
 b=sF23Lm6CpI7GMtA84TQTfFRaGSHIEiGyjLNwElRI3kmwWdSxGnxjNFxAnwk69Jmbb0
 vkiIbdkrdT+EDP3raX5aweYKZacLIdCEXlOJQtHNgH/eDsRxm9qhe5hkXz+x2poJbAlV
 Y6OTvx2UxUAnGVhoYQh70m53/Em/EKoSh+x3Wg4WgH3kQQmJQLR8gBKvCMbeF9oL7WZq
 qSR7cep9VfSMcSMntadeITDNZ+qKhPAqPDxJV33tub+PHpIEMrVJofI0pllf/hqyK3UT
 7s5HEej3XAuSiRHeyXgUedh9DHCHxq9F4CQKRoalxs7vFCEAviyY1x4M+cE+Zk3TnaDz
 0E5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770230125; x=1770834925;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8tctsqqueOweB61bv51fAI5Am248JpGWEFHuwnfzxYI=;
 b=bZCz3tq8qFQRUL0vdl67P9XdXfMF3R+Tewz7pCW7rZCY4hTD2+UAZih/fRcE2Tnc3r
 /WffiXYIVGKbPfSBsWPgk3220qfcH4UcTwtxStXPleGXSIag7lOyKot7wN8N7zGnwAdq
 1rz/dkExfR/zG12wBuISYLC1yCTdIOYMwLPbIYY0i48qRSrndPVQcXwvjTunBkd2DTYM
 L4j2/W9Tx3ZpVnRXiqErA4I67BqYsnaR0joZX6V4/QjIVaUa7nU9XhIlmmebd4W2mqIE
 Qs0H/76qoXOZtgEkFbr2Mwpn612TxUkZkin4hOZbU6Azje/HlkEmE/T8BzDanzckmn3e
 SReA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWf+nxqCmQGxU301FWCLG10cxCcB07BrUXSbKjhinDWv2dqYSlThsjjf6HCCise0bsG4/GBqFZ+PQ4h@nongnu.org
X-Gm-Message-State: AOJu0YzzAsyCy33uX/vZfKOtpjAc0lVDuQPQcCI3RfRB8lh3HTxEBABD
 nrui7zn7J83bR7WPGAm73Pv6Q5Lge0QAV8CN+yrAwbXEOU4lBHarXg46zP7gEEtlAvg=
X-Gm-Gg: AZuq6aI9WU+VToG2R1FyCzAboUY+mEw/1CG0SGZYldi10Gf7KUZzBQYj2qrGrNHJ353
 ZKYgKcgI7nnW096ZtmVsCx5OUBmCr+dLv0mg5laPMgEXaE1CYsq/Wx91mf5h6h81q/ayQf5Vwnz
 9NZf+sQ1sSwDfz8fDJ61OioHxyXhfpbbE5gjAa2pDZCRVBbw0B4EiRrpNGVZkZNVRHta8xLjJpS
 LzFfkIayg0mcjrXe0zsY+aRMbu7lxsh9wj5e9ZYTjasgFSXqv/24VPHoKxAdeeZdcP5SDhHkMb1
 8gw+29+sjx7RcaoBEi41VH3pl0dYuaxaPdeSM0LGvv9mpdCgBcWZI3h2WQ3KFTcPqs6WRoYNUVd
 m74CDKp+vmTFJJGK6ba9IDmiZgDKvp36/t2UFxTIjG8o6cMamZNVZ+p7D09TbmsNHi4Qety63Nn
 CP94aZs9FITIA/78dPcMOxwfzpYtalJFuOuj1HFiYJ1N5dFK9RhWpX1w==
X-Received: by 2002:a05:600c:8712:b0:476:d494:41d2 with SMTP id
 5b1f17b1804b1-4830e980229mr57018955e9.29.1770230125366; 
 Wed, 04 Feb 2026 10:35:25 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4361805813asm7797575f8f.27.2026.02.04.10.35.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Feb 2026 10:35:24 -0800 (PST)
Message-ID: <db38246e-091b-4bb8-84a0-fc50b02e21d3@linaro.org>
Date: Wed, 4 Feb 2026 19:35:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v4 1/5] qemu/int128: Add int128_signextend()
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20260203230054.23667-1-philmd@linaro.org>
 <20260203230054.23667-2-philmd@linaro.org>
 <45d7fb96-f2de-4d67-8069-b545e210947b@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <45d7fb96-f2de-4d67-8069-b545e210947b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 4/2/26 02:47, Richard Henderson wrote:
> On 2/4/26 09:00, Philippe Mathieu-Daudé wrote:
>> Add a method to sign-extend a Int128, along with unit tests.
> 
> What in the world does this mean?
> 
> I can't imagine a real use for this:
> 
>> +static inline Int128 int128_signextend(Int128 a)
>> +{
>> +    return a.hi ? a : int128_exts64(a.lo);
>> +}

Should we ignore MO_SIGN in do_ld16_mmu() in the
next patch then?

