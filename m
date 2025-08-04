Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B52C87FCF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 21:49:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj33V-0005Di-Vw; Mon, 04 Aug 2025 17:49:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj33E-00054T-NC
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 17:49:02 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj33B-0006Xl-K7
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 17:48:59 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-76bd9d723bfso3007893b3a.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 14:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754344136; x=1754948936; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=niT1nxlQEoDOEmdshDe60Tmy2BJfmPeStyXXw9rw3fA=;
 b=Q7YHEaNpI403gPavmOL9uN0/A77he1Eke0fKsVr3JhS08WoakOPEPPwehn2/J6qbcS
 R0k6jFbvMNwTiV67r/w0XiSRN2vjefWhsmRQ/fwAagnBpj6O0Dx6BQAgXMzqap/toVjf
 rDJqlweavUy/2gp7aPGzoUlVFiFi3+7c2JrPA66YZswY7EhQQx9N+0jioT5CewEYu3Os
 78FSkSr2mFEQ7gJcUVhLsHFO7Pqyjln8wcdt7Vgm4liE0fnTu5NiuDldU7zLhtr8ljtx
 RqzlXvi1llaObI0e/Xqy7nq/S+r6xLWJAAAYe8YMTTt86dAl3gAdi974LIZ46B2IgP6F
 G2nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754344136; x=1754948936;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=niT1nxlQEoDOEmdshDe60Tmy2BJfmPeStyXXw9rw3fA=;
 b=CeSRNsMzzB7sryEwEzLPrsiqYzNhI0gv/4X+ypkJslvPtxNAUJZbJLgOGVsuTiEPDL
 J8FiyjoAP12ycpNN+r4ddznzTz3EjvxWa2aQAl141kl7qhLRRY+9SX9/C3xFlc0MACTi
 eZ4j35sQor2MHWqDODq/8CkutgJT0EpxyivCh9g7prX7FW6qfXL8IMtvWMuy5WaRtp5q
 0AgMgTaZE6wsI6AYmVgQ/0aY7l733UMwibpRYVJYdOS1Gne/sXEJLFkLcJ96ebod2OCu
 Nc/VccAcndX4BvSEkv73mIbpN8UGQD/Z9x/0Rc7doOy3/EtUc1AporTeb3f6UOWcJUqm
 A6dQ==
X-Gm-Message-State: AOJu0YxSHpMVUvIDE4hJEomMueiXQBGnWEDqH0QKijjg76eqnNzKDnNu
 dGvXNs3dQUH0kIsgpBBfSwdUiAozJt9dl8Z+JrFDLbqQpur2zUlH8OHXm+6I/2ecAEw=
X-Gm-Gg: ASbGncuWcJhwByu29Q+8lAj8nbqjEeEP9B5bPzCMES5NGJfGp0syeiUtXv13kWb+aXP
 h8bW8sLmbSK0mR3/LmKsRULIJX2KhV1SSA62tHsFtnO4yOEpta6AWYWBD42AA+wghvAJXWi5mj4
 IN7IfiiAkqRhzInAQr8ZeyPUZDtdKYvJQw4qKXySm9drAPHFQN25MlRPSCHgsYHo5BOeCb3+ELp
 rrhBcZl9fMetbg0CxaILpM1dnwMIoGQVVvb3HDS3YQj5eEWKm8oXm7x5nS11TDQMcL3eJRUpiK6
 Qp52uSLMoFCxv0VOHkviEub4mk+EM99Pv6kitXPvM4rAT6ufp+EFby/tsvfFHzf8BNivFy9evQm
 OYTq69lRe2r65TjC8x6N0yedm66I27S87nXptohwOAZua2g==
X-Google-Smtp-Source: AGHT+IHoqNlRFhC31s0DR++fw4DkIKCPlGWJe4feuwsNd+UOSvq5ULfvzMcbNfe2xgO5bjiZYPz0Uw==
X-Received: by 2002:a05:6a00:4f95:b0:74d:3a57:81bc with SMTP id
 d2e1a72fcca58-76bec2f3303mr13171639b3a.2.1754344135703; 
 Mon, 04 Aug 2025 14:48:55 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bcce93da5sm11244054b3a.50.2025.08.04.14.48.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 14:48:54 -0700 (PDT)
Message-ID: <7a8d6a2b-357f-4014-acfa-82fc6ed905d3@linaro.org>
Date: Mon, 4 Aug 2025 14:48:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/17] whpx: interrupt controller support
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, Shannon Zhao <shannon.zhaosl@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Phil Dennis-Jordan <phil@philjordan.eu>,
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
 <20250804142326.72947-9-mohamed@unpredictable.fr>
 <f8bb5277-bb6b-44be-a5ea-93e7dd55ca18@linaro.org>
 <4E0E2520-3812-451B-876F-5EA54ED23FD2@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <4E0E2520-3812-451B-876F-5EA54ED23FD2@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
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

On 8/4/25 2:47 PM, Mohamed Mediouni wrote:
> 
>> On 4. Aug 2025, at 23:39, Pierrick Bouvier 
>> <pierrick.bouvier@linaro.org> wrote:
>>
>> Probably a stupid question, but since check, get_cpu and put_cpu are 
>> empty functions, why define them and the logic associated?
> 
> They are empty today but won’t be once save/restore is implemented for 
> the GICv3 state, which is still incomplete so that I carved it out of 
> this patch series.
> 
> That’s one of the last remaining blockers before VM save/restore
>

I see thanks.
Worth adding a comment into them for that.

> -m


