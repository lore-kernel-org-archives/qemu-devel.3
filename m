Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517E9C28B28
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 00:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trQnQ-0005Mt-Ah; Sun, 09 Mar 2025 20:15:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trQnN-0005M9-NS
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 20:15:02 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trQnM-0000U1-3K
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 20:15:01 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-39140bd6317so674903f8f.1
 for <qemu-devel@nongnu.org>; Sun, 09 Mar 2025 17:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741565698; x=1742170498; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3XDnzfquwfvMltHwbNocic4mvgShzRB7PHB47fqbJOQ=;
 b=gouFQmgcE0i9LpJZiZ4uiBen6byWJnXmFMq16IANTPYg7VvQufHbLhLqlFKAJ3wLA8
 dH0Q7mAO0Xudt1yUGsztGKVVl3URAK2/hl8aNvmQ6zrgoFkpMdE6bILQu9dnRTTPsuDd
 2YUoKyRxXDv2+ChkBGB6mFHfA5xXueEEjQeIsAAD5vkt0BiV9PNVBgHGCsoJZLXjoSRs
 4JH0rfvZOuARovOny/gDACHCmOkRN+I38+aI9kfuUd7oSnHZCHny/HfG7XrQH2f2WcFG
 DmIXjB1uxbs0fxxQcrkSWQptxwcr21gm1jiBSEujwXUgbRxU8G9YVS6Rz5ReWmcBhRyg
 vKlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741565698; x=1742170498;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3XDnzfquwfvMltHwbNocic4mvgShzRB7PHB47fqbJOQ=;
 b=NrWLQ69WiVZRngD8AAOSG2yeQbfrfba9jvNWt8mXLgy18OIVssZSE42so8NBkh4xBW
 7KLLLpcmwfafsQ7Q8b8BMmBkMS15EQQSBl+/aflD2+foeTaGlufqI3Fc1FpiMEEyDHCp
 pOQSK42A5wC6Ozr1W+X8q3gAgF5/5kxSrFAPaV2LsalQemUDGz66s4Xx8eKyntngePdn
 8VeYlmfE+ubZMmX7Pef4FaOlju5G8tW9g9vUuEtNkPA8bN3xgkmp6tVKc2dL5vqUXZW2
 Ir+H59HT/XsuciL6+X795H+CfzNRNSxh0h2w2DlltGRrIEyRv291HG44t33aQJIFCmpD
 eWpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDd2TYAaF6vdxH+47HNskv+5DMWuAFotOMOoD4zgcvDpMBI5mdjzGuFdImg2QrLzLHNsF3PiDWrGt2@nongnu.org
X-Gm-Message-State: AOJu0YxlMy9VUbcuen4PyrS8QT4JjBNDcQGyCJt2POh7NQvQ9EDZqvXD
 CwPSlP/aB+kCaTZAd9/4yBcYJO5d4px+b4hSIrlTDf/WfuOQGf9F3VNBrbfvPnQ=
X-Gm-Gg: ASbGncsyMKHAjaqU2h1cJ0GBJpwAWCHKy6wnM+U0sHiWfUVfdXPzc9RO08+nyKuFmbz
 Y6uO2E59FJGbP61qV1e3qDEiRaq9NnVL2WZ8mDaTZQlsOXIx8GrXBB85jZi0gGhprmdmIvMuxlC
 BfSaK3ylOug6wgn0KK/nQvTX+3SyOSE0EYg16R8KCUCJCgzcIY1NnJIYL80tp8lBmTIY7jyzLB0
 wy5s8f/G3tSwRCYpTKX0sZLxeS7bLY6PKEFvj5LOPHH4gitEeLyrDbKfgpmIXkbE7S1pl2VvvbK
 YWRxYrLHFzKDWcUWYR4AWDNABNTMk2ZpCY06n85dlhGbh35eKtAO3TRuEddTab1ORIxK7upGIEn
 GTr9NdLfJhkjL
X-Google-Smtp-Source: AGHT+IHqoB80XkpSQPer1Ybe2qKMEe9hTqpnQTlMttk3wKgoqoID3B7xzsZrRedXZs1Je32TrSlzmA==
X-Received: by 2002:a5d:588f:0:b0:391:1806:e23d with SMTP id
 ffacd0b85a97d-39132d7a3b6mr5996316f8f.6.1741565698246; 
 Sun, 09 Mar 2025 17:14:58 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c102b62sm12960568f8f.84.2025.03.09.17.14.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 17:14:56 -0700 (PDT)
Message-ID: <440fe370-a0d3-4a32-97e2-e5f219f79933@linaro.org>
Date: Mon, 10 Mar 2025 01:14:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/7] hw/hyperv: remove duplication compilation units
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 alex.bennee@linaro.org, qemu-devel@nongnu.org,
 Marcelo Tosatti <mtosatti@redhat.com>, richard.henderson@linaro.org,
 manos.pitsidianakis@linaro.org
References: <20250307215623.524987-1-pierrick.bouvier@linaro.org>
 <8c511d16-05d6-4852-86fc-a3be993557c7@linaro.org>
 <8d2a19a8-e0a4-4050-8ba5-9baa9b47782f@maciej.szmigiero.name>
 <91ddf98c-3a5d-404b-9e80-ed4580c1c373@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <91ddf98c-3a5d-404b-9e80-ed4580c1c373@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 10/3/25 00:33, Pierrick Bouvier wrote:
> Hi Maciej,
> 
> On 3/7/25 14:31, Maciej S. Szmigiero wrote:
>> Hi Philippe,
>>
>> On 7.03.2025 23:25, Philippe Mathieu-Daudé wrote:
>>> Hi Maciej,
>>>
>>> On 7/3/25 22:56, Pierrick Bouvier wrote:
>>>> Work towards having a single binary, by removing duplicated object 
>>>> files.
>>>
>>>> Pierrick Bouvier (7):
>>>>     hw/hyperv/hv-balloon-stub: common compilation unit
>>>>     hw/hyperv/hyperv.h: header cleanup
>>>>     hw/hyperv/vmbus: common compilation unit
>>>>     hw/hyperv/hyperv-proto: move SYNDBG definition from target/i386
>>>>     hw/hyperv/syndbg: common compilation unit
>>>>     hw/hyperv/balloon: common balloon compilation units
>>>>     hw/hyperv/hyperv_testdev: common compilation unit
>>>
>>> If you are happy with this series and provide your Ack-by tag,
>>> I can take it in my next hw-misc pull request if that helps.
>>
>> There's nothing obviously wrong in the patch set,
>> but if we can defer this to Monday then I could do
>> a runtime check with a Windows VM too.
>>
> 
> this series needs some fixup after the merge of 58d0053: include/exec: 
> Move TARGET_PAGE_{SIZE,MASK,BITS} to target_page.h.
> 
> I'll re-spin it later, so don't waste your time trying it.

1, 2 & 4 are not affected. Until someone object, I plan to include them
in my next hw-misc pull request on Tuesday.

