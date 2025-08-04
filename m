Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9102BC87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 19:41:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj13V-0005dV-LF; Mon, 04 Aug 2025 15:41:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uj0Nz-0008LF-4I
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 14:58:15 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uj0Nx-0004Fo-6e
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 14:58:14 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-458aee6e86aso21488505e9.3
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 11:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754333890; x=1754938690; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aINB0QOVgM33xiDkDtdEK7Zj4ssFbn5yVZBBPivr7uQ=;
 b=fiOAB+d9Dwys+FDe3v+4uE+kjgMDV6uVIWBtmlkJZCocL7rTs6f8NT4ksBuvBXO5oI
 ZrupmlsvdM8sJzq99JIXpVuIGs8aphLgP4CcgzK/Wh1b4fOD0UNoawW2CkcPINCcZ9vU
 WisAKM7KMZCtRteqcV+kJlI64VDUHVcz/whuxE84GxQrHVdDO6onSgDNcoJ3ilXwbvCR
 TveysHERoaeLjuLlKNH3gp0P+3eWGR8cOiumFpebNvZGfqRb9SnGBES0gMQRQatcfTxf
 qNJVaYqIrsUaReWOOqrnrgxoEY470ggnx+7UTRDfCE7fJfaC2AhDQ+7UanKin8bJDRT2
 Y5FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754333890; x=1754938690;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aINB0QOVgM33xiDkDtdEK7Zj4ssFbn5yVZBBPivr7uQ=;
 b=UdXbnuNlD3KEipp3IPCqaTD0EIpt5hYJxDzSzEshDENbLKvciWqzKjme8za8qx9phN
 OG5bt1q6UhTR3d7/OesZ/suFT4LRwE2oH50FrwMFZIOCjAoig3653QOL25WvzAZ3vfYH
 kCzBlTsEfjXOQdPxg/g4fMMOWyaA0mPd1vmBJq1XuVw4P6SGLpmb4ZrMnjD12krAIh5e
 GlrUjNprYtUtF0T/18qYr1ZUmsJAGktRclCvurqBV3CEg35i5uLbW7brzH9E/ZnlPlvi
 C4jCcoY+0gVAQizsfLE/KU2cja1tDHg0WwVSNjFeZqJ9dKDyIcvjRSuLkdLxJ+Zdq01p
 Usiw==
X-Gm-Message-State: AOJu0YyoDAedyognh4QUzdITXuOiiAmdq2HO3lZz5LoO9fxGOAwSMPKa
 3H1PwfAIPkXmDHblgAdu/PIyaVi1+5c2bWoGOilMD5gntgCXYBT9qFijKZKcyitY6VQ=
X-Gm-Gg: ASbGncs648OAgce5bMdllNXwtGZAfkl5EqAJwMVKtYcIkDEGGOAqq86vhKbbq+Crvrv
 yyFIJoM5VryHomoBrkg6uNDXpULhvagJ4B9QO/I4+2tvcXXRxrHcxLmi5aaJYcv10EUaDOwppxh
 s3rb3+3gCoqriEE3wuUx+geSpsa2AKLKx+JvQzIy4IxPA7OxikXlDXUHkv0JsKGSnBrCqcc9vk3
 eS93NQd2JhcCl9xcGRf3bf28pLiGrL1m6sC9/Uo0xJFk9k6D8PbujtczFA+P03wOJ4xST7zmd3B
 kBGWtqfIdWW6lDml7SQmgxjcwYDFVj/geYAYm6AbWi1pvz99UuPFGIIpW67c5lMjaDwLA2+ZdS5
 quDdGukabRdU6mt/143qVURSndnNONs7aKnvL7NSorybiWYoZq99pKVavu3RqErbNMA==
X-Google-Smtp-Source: AGHT+IFE9L8xp684iBaG0lgYWTBK2Pkue3NA3EWZX+vLXyy39soDe6/jHeaWoiSPwZ9ZS8YqBL/EOg==
X-Received: by 2002:adf:a30e:0:b0:3b8:dabe:bd78 with SMTP id
 ffacd0b85a97d-3b8dabebeb6mr4694686f8f.54.1754333890092; 
 Mon, 04 Aug 2025 11:58:10 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-458953eaeeesm233071245e9.25.2025.08.04.11.58.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 11:58:09 -0700 (PDT)
Message-ID: <18978892-cff3-48ab-9322-0227c8719517@linaro.org>
Date: Mon, 4 Aug 2025 20:58:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/17] accel/system: Introduce hwaccel_enabled() helper
To: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Claudio Fontana <cfontana@suse.de>
Cc: qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Igor Mammedov <imammedo@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Mads Ynddal <mads@ynddal.dk>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>, Zhao Liu <zhao1.liu@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20250804142326.72947-1-mohamed@unpredictable.fr>
 <20250804142326.72947-2-mohamed@unpredictable.fr>
 <d18fc5c3-b68a-4afe-86b7-e1687780b67c@suse.de>
 <59A4FF62-384F-4D43-BD56-60AA93733580@unpredictable.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <59A4FF62-384F-4D43-BD56-60AA93733580@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 4/8/25 18:12, Mohamed Mediouni wrote:
> 
>> On 4. Aug 2025, at 18:00, Claudio Fontana <cfontana@suse.de> wrote:
>>
>> On 8/4/25 16:23, Mohamed Mediouni wrote:
>>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>>>
>>> hwaccel_enabled() return whether any hardware accelerator
>>> is available.
>>
>> Available or enabled?
> enabled

Oops indeed.

Orthogonal, but still not trivial to follow available (built in?) /
loaded (as module) / enabled (selected?) / usable (permissions OK)
logic (there is also another state, but I don't remember right now).

> 
> Took the patch from https://lore.kernel.org/qemu- 
> devel/20250703105540.67664-47-philmd@linaro.org/ <https:// 
> lore.kernel.org/qemu-devel/20250703105540.67664-47-philmd@linaro.org/>
> 
> Should I edit the commit message locally or will be taken care of when 
> it gets merged on that series?

I'll do it.

Thanks!

