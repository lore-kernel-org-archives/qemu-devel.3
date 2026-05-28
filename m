Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1049FCD6E44
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2026 13:59:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSbG2-00043u-63; Thu, 28 May 2026 09:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSbG0-00043b-JY
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:58:44 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wSbFz-0006kp-0T
 for qemu-devel@nongnu.org; Thu, 28 May 2026 09:58:44 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-45e7c636e74so6839634f8f.0
 for <qemu-devel@nongnu.org>; Thu, 28 May 2026 06:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779976721; x=1780581521; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mZ4ofqV8ZgTvRegZrDEGGZ0MxiTuCRPcSGnZ/wlYX2g=;
 b=GiJLnzRm22MqH67QCy9+prg9A7AEV3ONJz8or7KzX25EveWR+i4tQ0OCd5MByre+OY
 NPf+HJ8vJCOG4BkU03non/U3TkZa3LU8/HaFIF2K01RTeMwH7mgCyhqvnttM7K2x1UG4
 AjVB3M2MCBS6anAUv1NBI6RBfIwjN+0x5rp0cL/HgNDCcYh5dxuNLR9TxLTJk3/sZXWs
 avylWkOxpJEa3IaZ7S65MMsS/cP3cy638dTX4XNb+4kANW2NVQ3kYiqxk5D2uBHIAuLg
 jXgmlliMICQM0fFE/7XiHElOOVVM0Se+ag4am3gH793FG1wjtYQxbvI5FMnpRZcuacHR
 7mvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779976721; x=1780581521;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mZ4ofqV8ZgTvRegZrDEGGZ0MxiTuCRPcSGnZ/wlYX2g=;
 b=ZNjgRnktzrS3ceiHoYZLwPCBPQcRTKlPN5Omwri5qv+XeWS/hS24sWzsJJOzyEZEiV
 fn5h0NpQg2bfvwWnT+dDJj9X/GgARO4CUK6R7XVK9IjSB9JAb9tgg+WugW6Q7bfwkkO7
 cqPe4p4FNE6Ru4lN9/i25oNgElYisikybNXs6CpSZjr+hsf4W/iPlXriY6ZoCR3A26AI
 qNJ802QOzLdVeic/jKc82z/l/Wi1ljGizSrMaKps4VzPERL+LRMg4rRM+VurIbNqbIkW
 CIOAq3OivIRrKFNLMrjxapbojYsEvNBU88VdCjniGAt2UxuB02YFaFzR4xxo86njOc7Q
 ZnbA==
X-Gm-Message-State: AOJu0YxsUwdQAlhuuqQBIzkPoE950oHo8FbTeWD/jtfKo8clP3ao6itq
 Avfuj4OqMJEJDt+SIyHpXf+Nx5FaaWEW0nkX8/nJqKI+UAFzfjY5TCAuV2uWaQhX8xsJQHu7lHY
 BwyvHucjuZA==
X-Gm-Gg: Acq92OFFvCsJLVSX31dYBLiEChOqESn3sVdfYg8wD7bJ7apC1Zq5QFfejhYVkJneSPo
 wyyg0L432EWd328LD1Qrx1rU+O1HvXpXUupn8+IRNdDQGGeytzWF58uSNsWqUl1ZwhLbCzA36G6
 XK4nLrNMrIDqdaZkilY23wnV85vTd0S0q4bOZERtPmbaR4UA/KezH1XTTBtvX8AgXVACww7fp1M
 OeizLDbkzxZo8Ao1kzIEenggIOTj+6ouJOn+AVh9TfWwvDebhcW1E5rzmwBZHqy/+rhCypUcfKN
 k8O3M5q1ZVa3LiymFmxhaADLYvruk71XXGjNpWJhKxbYVjxAKjdigrkaTGetDWCbJu9TeejLcS7
 3vM8E1Wg2JvC2pRSk+4NL0ZGl2reLJLjicV306EB7NNxDBwgZbnVEp3G//zXne6xlDsXKt8Fz31
 u38Gn+FwS3r54133pBbny5xpg3ZA/n7X5kuB4t6KBVtsj/GeH3V/A5DdBZK+x1AYWz+iC8fhwK+
 D58
X-Received: by 2002:a05:6000:1acb:b0:45e:a225:6dfe with SMTP id
 ffacd0b85a97d-45eb38a64e2mr52116402f8f.25.1779976721080; 
 Thu, 28 May 2026 06:58:41 -0700 (PDT)
Received: from [192.168.69.207] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45edb5b19aasm14945574f8f.25.2026.05.28.06.58.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 May 2026 06:58:40 -0700 (PDT)
Message-ID: <5f1fe018-e3e2-4295-8b0d-1246b580d020@linaro.org>
Date: Thu, 28 May 2026 15:58:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mailmap: Update email addresses for Andrew Jones
Content-Language: en-US
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org
References: <20260528083920.33105-1-philmd@linaro.org>
 <mojx2suobu4ebtmvof4qzjidemjwa6i6imvu33dqfhcpqj2jhr@md4jdj7fqzl5>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <mojx2suobu4ebtmvof4qzjidemjwa6i6imvu33dqfhcpqj2jhr@md4jdj7fqzl5>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
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

On 28/5/26 15:47, Andrew Jones wrote:
> On Thu, May 28, 2026 at 10:39:20AM +0200, Philippe Mathieu-Daudé wrote:
>> Cc: Andrew Jones <andrew.jones@oss.qualcomm.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   .mailmap | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/.mailmap b/.mailmap
>> index 6335fbd6c84..1ce5e6c5a14 100644
>> --- a/.mailmap
>> +++ b/.mailmap
>> @@ -76,6 +76,8 @@ Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> <arikalo@wavecomp.com>
>>   Aleksandar Rikalo <aleksandar.rikalo@syrmia.com> <aleksandar.rikalo@rt-rk.com>
>>   Alex Williamson <alex@shazbot.org> <alex.williamson@redhat.com>
>>   Alexander Graf <agraf@csgraf.de> <agraf@suse.de>
>> +Andrew Jones <andrew.jones@oss.qualcomm.com> <ajones@ventanamicro.com>
>> +Andrew Jones <andrew.jones@oss.qualcomm.com> Andrew Jones <drjones@redhat.com>
>                                                  ^^ is this a name field?
> 
> I see the same format below for Anthony, but it appears the format is
> usually just <name> <email1> <email2>

Oops, copy/paste mistake :|

Fixed and queued, thanks!

>>   Ani Sinha <anisinha@redhat.com> <ani@anisinha.ca>
>>   Anthony Liguori <anthony@codemonkey.ws> Anthony Liguori <aliguori@us.ibm.com>
>>   Brian Cain <brian.cain@oss.qualcomm.com> <bcain@quicinc.com>
>> -- 
>> 2.53.0
>>
> 
> Anyway,
> 
> Acked-by: Andrew Jones <andrew.jones@oss.qualcomm.com>


