Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B264C87FCB
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Aug 2025 21:23:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uj2dz-0000D8-KH; Mon, 04 Aug 2025 17:22:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj2dt-0008Vz-TJ
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 17:22:50 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uj2ds-00085H-58
 for qemu-devel@nongnu.org; Mon, 04 Aug 2025 17:22:49 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-31f28d0495fso5218054a91.1
 for <qemu-devel@nongnu.org>; Mon, 04 Aug 2025 14:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754342566; x=1754947366; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8SRHEIcqfurbwfU0xYLmg2MGMq+fWhVhfZ23PthYEz8=;
 b=wl7d4KI4P+n4MEHQ1oUwtQtRT9EGQJ/ZwCrBnRXKdWUVw56+r0J+qPkJ+9W/jNPiY2
 WetHrL3wleVDB1ueL1DLQmNRWe16QDtJn3WizRflvDfB90odnTJqCjbgJqTTaHgDFtvr
 PXCsTc7tD0vksSGVq0r9c8j3KAAglI/Rhr9ts87cgzn761dFKKKsQk0Zegb9uVIeLmGc
 pybd+mD6pu1erG7nryeoTokZO8B8WivdBh6V0Yv5h3M1HYHfof3GmHIcl7DxkZBzvmEw
 5gHBZUH6cqrCFuirxO7B4yoGM95d3sLZYoFTamqnWUfT00mpan7u4vLwzmbf1M+n6Pyi
 k0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754342566; x=1754947366;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:subject:from:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8SRHEIcqfurbwfU0xYLmg2MGMq+fWhVhfZ23PthYEz8=;
 b=iXkDbShwxqYVWGden/aiNgDUk4hXSfwPquoqQtiIcUeWhFkUvGkVzGP6r6RL4/HJIk
 ZFZcaFiTBgoc0AhnzbZT5LF6W2I5F3ksvPpbTZwacvMJnQc/bKAiO6FV1VktVdccB56/
 9fDVzoUivnN44UqOXUAoerZPGO8EGu3gmpYFaavOTfur29oK6yfM3ygFNooDPGJxCV3z
 B9YfwPSClbkZiDOp19Wf/vsjgfDycKld87KIsuDoy2a2pmBrxtLgvkae4dAaVbQ+vWOs
 fCG1FIWgVQdH6M6dgr3Wsx2xBduvelL76d+/XVawFLBs60/6iUn/EpHrF24Kmtn0MUyf
 4JXQ==
X-Gm-Message-State: AOJu0YzG60f2k8gpjiEsXrhSNbzrUHapFgySQcAtCuMGzlkDgnyQ702V
 V0Ck4hThZzEW8HHDIR+yeMx6dKTm96Qzi3TObxaX1ABDrRsvjmo8yEuVUHab3KxuCBE=
X-Gm-Gg: ASbGncuELAPyWGaKnryqxDx0Yx6+unDdJ9S8sKpKoz6ay8XxbiOvRQb0Qu+XVZAO1bu
 QLIZMN5vevw9JPy7tdBXloKMG0ueGvobBHN1bbPSUjcNofLGIq+YhzqPvBVUI5/Rt52zXNviwen
 VB42m0fTf7V5rIbLYKGYQ4dK0jM14Rw5PpV3Bgo83RCfKCFNzBno42oWwEMOclzPZQWeo1SEpHz
 q/ZN72H3mSt4ZrHUIP75DRWuxPrYwDvqCPZTPX9QC9O1nWlMrx2FzgXhJi9xxIC4nd302XxCSJL
 QqQ8UhDxmeRXMITY6VPCSMtyRo2H0Rj61KpsrzNLOOQhL/S+jyTWw7Fo0CCXbNPOI78Wi2N53Lv
 XkuYne2SNvR1MBZkoHor4f3BPOz8uHlPjsVyPAjRTc+2+3w==
X-Google-Smtp-Source: AGHT+IF+E2k3dBAkj0K19KJ1oDET/fvDmyauBJReUhlRW5ogOfDfQMErUmgmlRyJDtz8+SM8rCK7lQ==
X-Received: by 2002:a17:90b:3b42:b0:321:38e0:d58e with SMTP id
 98e67ed59e1d1-32138e0da42mr6148100a91.3.1754342566600; 
 Mon, 04 Aug 2025 14:22:46 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b422bb19069sm9380714a12.65.2025.08.04.14.22.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Aug 2025 14:22:45 -0700 (PDT)
Message-ID: <fe5b0075-e242-432c-b093-adffe2e15792@linaro.org>
Date: Mon, 4 Aug 2025 14:22:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH v4 12/17] hw/arm: virt: cleanly fail on attempt to use the
 platform vGIC together with ITS
To: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>
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
 <20250804142326.72947-13-mohamed@unpredictable.fr>
 <a8239e8e-37ad-415c-b13a-4b4ce8fa2a36@linaro.org>
 <2BF73501-00C6-4194-B75C-CD50A8807314@unpredictable.fr>
 <2bb26ff6-8ee5-4255-b8df-27aec29b56a9@linaro.org>
 <9A4DE34A-784C-4501-B8AD-A93CBFB795B1@unpredictable.fr>
Content-Language: en-US
In-Reply-To: <9A4DE34A-784C-4501-B8AD-A93CBFB795B1@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1031.google.com
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

On 8/4/25 1:59 PM, Mohamed Mediouni wrote:
> 
> 
>> On 4. Aug 2025, at 22:40, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>>
>> On 8/4/25 12:56 PM, Mohamed Mediouni wrote:
>>>> On 4. Aug 2025, at 21:50, Pierrick Bouvier <pierrick.bouvier@linaro.org> wrote:
>>>>
>>>> Is it equivalent to simply using its=off, or is there a difference?
>>>> The info_report seems to imply it's not the same.
>>> Not equivalent.
>>> Regular system: GICv3 + ITS
>>> This configuration (for the newest machine version): GICv3 with no MSIs
>>> And its=off explicitly: GICv3 + GICv2m
>>> It became not equivalent since the intro of GICv3 + GICv2m in patch 2 of this series.
>>>
>>> Thank you,
>>
>> I see. It could be worth adding this information to commit message.
>> With that,
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>
>> Slightly off topic for this commit, is there any downside to always have GICv3 + GICv2m setup enabled? Do some systems don't support GICv2m?
>>
> GICv2m is modelled as a device external from the GIC, and so it can be emulated everywhere.
> 
> It can be done but then it supposes that the same Qemu command line will expose a different device model (instead of just MSI support missing) when ran on a different system. Not sure that’s the right thing to do…
> 

Indeed, it might be surprising, but on the other side, we already do 
something specific to whpx, so it might be better to choose the default 
offering the maximum support.

 From user point of view, the question is how hard it would be for them 
to guess what is missing in case they need MSI support, and didn't see 
the warning message about using its=off in this case.

Peter, any opinion on this?

