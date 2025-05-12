Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BC2C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 16:54:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEWPu-00013b-1x; Mon, 12 May 2025 12:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEWPi-000136-27
 for qemu-devel@nongnu.org; Mon, 12 May 2025 12:54:05 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEWPf-0000JC-Ei
 for qemu-devel@nongnu.org; Mon, 12 May 2025 12:54:01 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-22fb33898bbso57299235ad.3
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 09:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747068836; x=1747673636; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5qv97JEWqOyn2RBAQVy3o+mtOcNrHF+oRB2lO8yK+3g=;
 b=dothGlp1WOVnhUwPC18zs56v/f2ep9VXbOWq85uol0Qaxh9S4V7xyH04XpkxHNA5kO
 rF8iiq4v1mNTCeKMGpHxpHvdWrPiodg+8But+9eBykhlzZuaTbBUY7SaCg9zLvV2M8Ic
 R/MpimYvTD7f5MLW+ZQ/uTLcSfB0IpPOjXkUx4a2rE/kOcHDarSsrXjKv6ilfK9ZLxJD
 EUihRbPRjjI8AFWViSwTg/PQs9hBKTwelQ0mUEo3aDkaz+5xFmGYjtoo3LXEOMH8Z4vu
 m10aLCSQRr5I7+q7XUtZjIVb5NwSqFpmhC8hyd2e8cBbwRfMTRmUcFCkyv1MdvQRP0vB
 YggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747068836; x=1747673636;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5qv97JEWqOyn2RBAQVy3o+mtOcNrHF+oRB2lO8yK+3g=;
 b=pUFCFmeWzKTRC48p++5EghpDLLemPlJS7Z/CvXxJiY721v+jnTBuJL6TpLvn+YWxBb
 Z99aV8JEUmgUQI+gn7k8T/vrePGNi+Jf8nqy1ZWzcBaMHKJWDfnO2a5X3d8K9RSm7pGv
 LwQdJDCPaOGNw1I2VEIWKNeYCzjyarb0xQ4Uza8D+RYljjaODivZVxqtc09gR7CxUgQV
 Uk+s5qdKynX5baYVNsyY7uerpWKkXNfOY/zfILRiE16NARQ1efNKgC8gufbNWqMQDE7z
 PblDgY1Kr4NjGc1LjktFeF2fmt5T6/hDKIkg6ZoyJ0QXsrTvcPQcy99G6BsRQ5Vn7Mia
 F8LA==
X-Gm-Message-State: AOJu0YzxxqTpvv+8BRGzsYJlnkUU5OWRJvsw+3RNnSgl7WXe3bT8s7oj
 fJqtoEeP3Biqm/cqICvx/xCBkdCDuXEGMjbF1MSd8CGUSb/u5HQe+WQ9Mo0gL1s=
X-Gm-Gg: ASbGnctWC4+tW4z/35zfM+AOffXgc5+jd6HDzzaQdnel2eYboRcU7pu7ljA1qqkOU10
 iYD+2GKFGYRBQgPrdRbd9m5p+TdpTAPZhBGg0rBkhaTMNRL76AskOrpgiue7l5vV5Ah3MqbzcQN
 rvomL+xwYG7MZBDCEKKHKVercbd9fzPbzFtexjOd6kwo+2tYcXtVjbkqiy1yMjeRU8MjXdhUm7m
 8wFdoEjgw4UXLKWqJIvB8PvA/PvREByUIMthIoNR8Q8/+70uOeYtXwn4CIcrEXovfrt59BUhw1X
 J+D4c36JB/gUl4paqLIlbITzM82SF0tR4QK0lrrbaVvjsQUtpt1wVq/egEFV4M45YG/4JmUMyjg
 =
X-Google-Smtp-Source: AGHT+IEOn8CN414mVktJ1vMBGRSWrkkrE+hsDBQ68HIHv+XPldWZKBuYvuSfuI1+1GV0jBqItHroGg==
X-Received: by 2002:a17:902:d581:b0:224:5a8:ba29 with SMTP id
 d9443c01a7336-22fc91a7375mr222155015ad.43.1747068836640; 
 Mon, 12 May 2025 09:53:56 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc764a536sm65723905ad.66.2025.05.12.09.53.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 09:53:56 -0700 (PDT)
Message-ID: <726ecb14-fa2e-4692-93a2-5e6cc277c0c2@linaro.org>
Date: Mon, 12 May 2025 09:53:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/49] single-binary: compile target/arm twice
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, anjo@rev.ng,
 Richard Henderson <richard.henderson@linaro.org>, alex.bennee@linaro.org,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250507234241.957746-1-pierrick.bouvier@linaro.org>
 <CAFEAcA_NgJw=eu+M5WJty0gsq240b8gK3-ZcJ1znwYZz5WC=wA@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA_NgJw=eu+M5WJty0gsq240b8gK3-ZcJ1znwYZz5WC=wA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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

Hi Peter,

On 5/11/25 6:40 AM, Peter Maydell wrote:
> On Thu, 8 May 2025 at 00:42, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>>
>> More work toward single-binary.
>>
>> Some files have external dependencies for the single-binary:
>> - target/arm/gdbstub.c: gdbhelpers
>> - target/arm/arm-qmp-cmds.c: qapi
>> - target/arm/tcg/translate*: need deep cleanup in include/tcg
>> - target/arm/tcg/cpu*: need TargetInfo implemented for arm/aarch64
>> - target/arm/tcg/*-helper*: need deeper split between aarch64 and arm code
>> They will not be ported in this series.
>>
>> Built on {linux, windows, macos} x {x86_64, aarch64}
>> Fully tested on linux x {x86_64, aarch64}
>>
>> Series is now tested and fully reviewed. Thanks for pulling it.
> 
> Do you/Philippe have a plan for how you want this to go into
> the tree? I know Philippe has been taking a lot of the
> single-binary related patches. Let me know if you want me
> to pick it up via target-arm.
>

During the release code freeze, we mostly used tcg-next.
However, now everything is back to normal, we simply work upstream, with 
a simple "first pulled, first in" strategy, fixing the occasional 
conflicts on our respective sides.

So if you could pull this, that would be appreciated.
Thanks!

Pierrick

> -- PMM


