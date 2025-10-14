Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24B4BCCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 15:25:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8gtN-0005G9-H4; Tue, 14 Oct 2025 11:24:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v8gtL-0005FV-8b
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:24:47 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1v8gtI-0007I0-VO
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 11:24:46 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-789fb76b466so4988299b3a.0
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 08:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760455482; x=1761060282; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KuL9N6TS69/nmbvHCWcmwf8nUDNY2qRkN0vCSdqJqGw=;
 b=Jn1v8Zijgwn7omuASbqWSOMrtDCEgRj+segjX5mnd9nBecQOnGPplpz/X8oRPlpV8F
 qM6ly3QfC33YbQeKxyYAFzDMmV+3AANQveW7j3b9Z6SD5XM5xwJPIAud6RTKvrSXWIWS
 AR1bkAyIjZhWbJ52XUX/pxhZnrC0sLDZqiYuxnA4kLxeA1ZVqyOIIrWghReqkp75ihaa
 QPZPOBPxCD9kGkQyQ/6rCM6d5zaw1Y1WdbtvtPYnrvqdzCFqBCu7aHeHbPW920KCsO+V
 20aWBPZrWGlwnK4kX5bIiGScV/6B1TotChMohgPpbETF/sxafiiM9Uj2cby4ySUHIbKK
 j3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760455482; x=1761060282;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KuL9N6TS69/nmbvHCWcmwf8nUDNY2qRkN0vCSdqJqGw=;
 b=tRER587b/mgw40KrQipH+Ctz5cg2s4qizDo0VirPdRAdAbCky3W7zn7ciuuiacX6t8
 cu46s51BFaWt61hR7eJ3QbubJqy29HxOCroAhFk2E0KyID7U/8w6yLM+jV6doRY288QM
 PdugAhpGRJMUJwczr1yNOS12QAc3V8Yo0PcmGPzSumyGk/LyLIOpf0+cGGsGhDNq2nf/
 MTFufZSiEleKHoJ5Axou3KMygh07KdcJ7VQc0qQmO9GB2JaP/lGxCLfpRs339c61uekl
 PGFaF+oSZmw57kON+T7/Zf9bxejxk0qA+OXaYXi0DaWUMkZYBI35MP7jki/5SC+4zM6n
 hRkg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXaE+ggvUkaeK16K369gO1X82/CqAWXInn6ZfRaqGnmOMlIksoN36SaBvBC0x7HG5zUbhNxbgWqq7v8@nongnu.org
X-Gm-Message-State: AOJu0Yxj5eH54SsUhWMHC0uqpir5sFdj4L50D+qHruxQO3Q0w+4o9LOb
 hzvD0qZdNMDkBkjItPXqGUhXLBqoZpQfbxGz1z9NknaABbuMLfz9T8oFUdu8R4Po5iw=
X-Gm-Gg: ASbGnctoT0BEPe4BjRRq4n6n2o2piu3aNJ3GBidgXP96YDcA05FDzoVxq4j7gHhmrVc
 ZdgiJqCTTZTW/wQ9fvxesmy7hdyyGoMAyFJK6fMlDHaM1y5Y8B9SrJX7qpqThHSMIeSSJwkpP0p
 TRRpBP9wqaAP9nPi1T5kU34H2LoTxV4Sd3UoGxquDYAPUH9HCwMSV75zgreI/CeD3Yx40n0Z9IK
 SQNASkAbVgQ6AmkXnjLPXTe1rIuGrgd6J5s0wwSHxrJmnJo+/A/lboTw/Ekhcyqwtcl7t9+yBlo
 zNBsfyoTz+CzyVk4ZVGnf3W0Jv5E1xbvlLQ/5j1ysle8bRFLHkBYyOqBBRmLYFAHMLwHRUgxcsD
 RoMgfK0fFu0aj/1JcDm43OT7NBW4DuTOnQhirq+ykK4wH2F4y6HAAQ6aoCmcWeqv7ki1LLedHIT
 FctLOrMWf8wphtzmr/rLIwZrlp087dxunuZg==
X-Google-Smtp-Source: AGHT+IHICk8X4m/xwiEFDz6dLz4rxcijLNqO7dYzaHlBvyhP8amqAopQ/TxNGF4L3D+gULOkQTRYCw==
X-Received: by 2002:a05:6a20:72a2:b0:262:9461:2e59 with SMTP id
 adf61e73a8af0-32da83df936mr31006757637.39.1760455482325; 
 Tue, 14 Oct 2025 08:24:42 -0700 (PDT)
Received: from ?IPV6:2804:7f0:b401:1d95:80a1:93a2:fc08:86bf?
 ([2804:7f0:b401:1d95:80a1:93a2:fc08:86bf])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992b8285ddsm15485102b3a.23.2025.10.14.08.24.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 08:24:41 -0700 (PDT)
Message-ID: <ca74ac20-f510-4c78-8f3b-85a551841041@linaro.org>
Date: Tue, 14 Oct 2025 12:24:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/76] target-arm queue
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
 <35087274-df34-4528-88a2-d855768fb5af@linaro.org>
 <e3314d25-dd8a-46a9-bbfc-44fba387099a@linaro.org>
 <CAFEAcA_OLA=Ct7wFHwnfixrYofjyMDuw_5ViNb7Yxu43B12szQ@mail.gmail.com>
Content-Language: en-US
From: Gustavo Romero <gustavo.romero@linaro.org>
In-Reply-To: <CAFEAcA_OLA=Ct7wFHwnfixrYofjyMDuw_5ViNb7Yxu43B12szQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pf1-x433.google.com
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

On 10/12/25 16:58, Peter Maydell wrote:
> On Fri, 10 Oct 2025 at 20:59, Gustavo Romero <gustavo.romero@linaro.org> wrote:
>>
>> Hi,
>>
>> On 10/10/25 16:03, Richard Henderson wrote:
>>> On 10/10/25 06:04, Peter Maydell wrote:
>>>> Hi; this is another target-arm pullreq. It's a big one but it's
>>>> only two series: FEAT_MEC and FEAT_GCS.
>>>>
>>>> thanks
>>>> -- PMM
>>>>
>>>> The following changes since commit 94474a7733a57365d5a27efc28c05462e90e8944:
>>>>
>>>>     Merge tag 'pull-loongarch-20251009' ofhttps://github.com/gaosong715/qemu into staging (2025-10-09 07:59:29 -0700)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>     https://gitlab.com/pm215/qemu.git tags/pull-target-arm-20251010
>>>>
>>>> for you to fetch changes up to 00936783abf77ebb47a78312a2e6500c6a13d938:
>>>>
>>>>     target/arm: Enable FEAT_MEC in -cpu max (2025-10-10 13:22:05 +0100)
>>>>
>>>> ----------------------------------------------------------------
>>>> target-arm queue:
>>>>    * Implement FEAT_GCS
>>>>    * Implement FEAT_MEC
>>>
>>> Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.
>>
>> Could somebody give me access to https://wiki.qemu.org/ChangeLog/10.2, please?
> 
> It should be accessible to anybody with a wiki account, I think.
> 
> (I have already updated it per this pullreq's changes; let me
> know if I missed anything.)

It's missing FEAT_MEC in the list. But let me add it so I can test my access to the Wiki pages.

Currently, the wiki is returning a Bad Gateway, so I'll wait it get resolved ;)


Cheers,
Gustavo

