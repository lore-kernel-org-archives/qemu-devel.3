Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA745C88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 17:22:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6ANM-0001sN-7L; Mon, 14 Sep 2026 13:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6ANK-0001rz-Ig
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 13:21:50 -0400
Received: from mail-pj2-x11.google.com ([2607:f8b0:4864:39::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1x6ANI-0003pc-JS
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 13:21:50 -0400
Received: by mail-pj2-x11.google.com with SMTP id
 98e67ed59e1d1-39dacf053eeso1442434a91.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 10:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1789406507; x=1790011307; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Y8Dq6FsLqmNEarBazbsxpjb/jQ5OvjQmhuvdiyYrYEY=;
 b=OtPumYcgEBfu8YS1HITRAbO4RiiV6dOUdHKnbhpek+63QTEVH9FG2F0w737kDh/tPM
 xw4Xaho8gdgk7wNDgifOH+uiPz1ZcwF384Rdabl3QsZrZ8URGa0baON4bj60Tp5Y9dLt
 8dey8iI3zfHUnVBerjDmXvH1tj6f7AzQL6Ej8HgFklUqiSG54aKm/+PZZLRHclCfC8MN
 rETwzupdTJQHHgjeHd6hRPyrNPPg391pMHZ0DroIRoc1/O1pCmEMGGRubPiJrMJXvxno
 0qLOOZDKUznYa0wzf1NKb3HhzoZIZx5nIVVI0VAGnlsjF5eHmyvBGtDC9kvrBpsNsUJm
 tf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789406507; x=1790011307;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Y8Dq6FsLqmNEarBazbsxpjb/jQ5OvjQmhuvdiyYrYEY=;
 b=isrxIXrxqVGa0wmATP1KArrZoZ9mJPuz1IT4+8YIW0KO1te/g6zRul2IKVhJlYb+oW
 V+6LwpyaD5E+r7lSpbFAxfdpt5qhiGww6P8QNwzFSpSa3kDcixbYEawr9/yAP4J3mtWN
 0YdkWwo7jCIV7srZFV/bh1uxdJGVmnWOv0GP/hKDA/Gd3qTLcGEppES+D5Kx48gkWVxc
 SEPnXl1mNJ06XlUTbvvRCV0NJfCmStzF2HEJRt+trh1/bamzCfjaGzlz03U60q4Rtm90
 7yAJ/y5AMLt6UTSRvA0SOmWf1XRgLY2fr4Ak2L1BkOIGKibyBftfHPopebKPTeRNrpiG
 hE0A==
X-Gm-Message-State: AFuF++n7lsul2EyLnG048gcOkE0I8YFsLE3oPlidxeOtxyOgOOfOwV3e
 MvmZTUrHfDDVdd8DEay1UaDr6SN5xWIPOotahcC+ZMJ1ETbYjTRfKst5ujrZdZ4Neov31ooHXD/
 VKKQM
X-Gm-Gg: AYBFou2MQ8CGFu/kElkrFqtI6cEmcTmMiNJumOQi/HrCuCV1ix7JeBfInyYvirQMHEN
 xoYxsa/TeEoXmzcUgr3BUdnKHdkdmyIhOCoJX0jgd5WCwyqDSol1Mw9wVciQmiP9Ec8VLxmWVQf
 qpErt0ntFFOB7sLlrvs+f1F7D/lDMi+KbupN+UNaVDMGRxZnPB6+FYzhEGf6lMjnvreAWGIxV2c
 Uxur7B8vFlQ4iR5yTboTaS3GY14rvyMkfv6OUP3GTPh/nyMdr1wEuXeM2Fmv3Uld7dj5LRb1gGr
 Ww+G+4qCssYT6LaS9RDFC2NLp/KB1OzO0kEHN2+SxHm5KFyVL9NHOSzlIJ94Ia8YRTw/WFHp23m
 1W0lcCiF3lGn8n2oZYPhnyPVJ68YaK0nbWKJFSwF0bQkPrQRtoraupvEBzzwu5AJZQKvwqWZ22h
 pBmd8czFiCX0sbw+wmDZEdb6BEZUldL+6e8jRk0Ox34RXt3lO0xA+I510B8YIHEMNxCpn+cJm+x
 FQyaHVCtus37X/Y6iQqoFXf56wXPRmSIScgYnbA5hJ2cMl7rIJNfpt0PRFbvw==
X-Received: by 2002:a17:90b:2cc7:b0:39d:fcbe:c1ae with SMTP id
 98e67ed59e1d1-39dfcbec295mr1273164a91.23.1789406506676; 
 Mon, 14 Sep 2026 10:21:46 -0700 (PDT)
Received: from ?IPV6:2603:800c:7900:ed00:7164:7976:4c53:31bc?
 ([2603:800c:7900:ed00:7164:7976:4c53:31bc])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfdaccc0fsm459167a91.15.2026.09.14.10.21.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 10:21:46 -0700 (PDT)
Message-ID: <a930c1b6-dd93-46ad-9e61-eafda9dcaac9@linaro.org>
Date: Mon, 14 Sep 2026 07:21:43 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] target/arm: Implement HCR_EL2.TID3 trap on
 undefined TID3 registers
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20260806173123.333423-1-richard.henderson@linaro.org>
 <20260806173123.333423-4-richard.henderson@linaro.org>
 <CAFEAcA-NoW=39G_m21zQO6CzH5UU3MnsKuFNjkjX-55gzXqD2g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA-NoW=39G_m21zQO6CzH5UU3MnsKuFNjkjX-55gzXqD2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:39::11;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/13/26 23:16, Peter Maydell wrote:
> On Thu, 6 Aug 2026 at 18:32, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> It is IMPLEMENTATION DEFINED whether HCR_EL2.TID3 traps on registers
>> within the range which are not explicitly listed.  Previously we chose
>> not to honor the TID3 bit.
>>
>> However, with FEAT_IDTE3 it becomes mandatory to honor SCR_EL3.TID3
>> on these registers, so we might as well honor HCR_EL2.TID3 too.
> 
> I thought we agreed not to change the behaviour here? Is this
> just a "forgot to update commit message" thing?
Oh, yes.  Because I did update the code to test for v8 in translate.c.


r~

