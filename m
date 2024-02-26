Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E71C54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 13:14:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reanb-0005hT-Q6; Mon, 26 Feb 2024 08:13:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reanX-0005gN-Pf
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 08:13:37 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reanV-0007pg-MK
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 08:13:35 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-412a588c8b4so5001735e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 05:13:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708953211; x=1709558011; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=flV6l2nnWjgUUCSbchL6kRD2mWs8B/wfdp6O+7bOlXk=;
 b=Stfmdje1dD7Nq6lGnxuOkvfNL0RPaaMZHdLC0LKyn9fjqwzKQCabRVg1yAm8ohPq/Y
 SgeAJDAt2NnXxC1uJIssjE3SXmgZHrYAXk94dtqjfsZ6Ku7HEyx+QHJO+se+Y5jKNXgt
 j09lgoiP/euJfnh2wpH6UGT+Uiw0233uIw2QwPj8XCNWVeNJenuXC2aBB+bZCpjgd1f0
 U0TwGJ5INHtRreOwVhRLe+C7r+kFJ/JABcKccUkLMtvds8hgz5pNoBo+CxBpa5A57PfX
 oVhiC6hfRwxVSH4PZLDuHQsngTYuntPg0ePtjYCEnLReGW5vxQQfPjfo7wbWSpP0BW2p
 27MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708953211; x=1709558011;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=flV6l2nnWjgUUCSbchL6kRD2mWs8B/wfdp6O+7bOlXk=;
 b=SHRTlFS7q7qJ9gflWPLB6Id2a/K47CC7RMIZfB5wTWWPRVCR2FeAnH9xXjPAeKQsdk
 1pDcnYPjYRrLwPn8jYCr/KyTtb+Ohzy2eB7bKFIko8aCDB3HEE61ed7/Bonr5Gx4eSaJ
 HkpJ3lxmvtby8pp2As71/RPmhrsyehAx/69s8FXDI2menuZV3MyAQnIn9aviEV4Ts97w
 bzDLecGkf23Uag4sjZMM0KQ0BGvQQ1PE/MXzolpDegPEssQsTrMmTBQmwqw3JLzrB1pF
 58lNn2mIvCKSheMo8pVR7QByhiMV+tiBEKrhYch9L8ZivJTv97DkfMDhu36QWfxTGhNE
 VgCA==
X-Gm-Message-State: AOJu0YwGm0kb/ILW3WrOM8LOM+rxjlQz/bZRB12t5xOI+9OELMQUm7w9
 BiHixbW8InlMUiIK199NLie0V3jPKzROtsLuCKFRWe3QlDJFCwFAYQuPteoG5e0=
X-Google-Smtp-Source: AGHT+IFANlaPBOt9AH0FNgM/6nfcHXs31Z6py+o5MOgviWLC5IuWnCgQ9ZrqTQkB+omhVX45kjGePg==
X-Received: by 2002:a05:600c:5117:b0:412:625b:963f with SMTP id
 o23-20020a05600c511700b00412625b963fmr4710832wms.40.1708953211278; 
 Mon, 26 Feb 2024 05:13:31 -0800 (PST)
Received: from [192.168.69.100] ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 v6-20020a05600c470600b00412a2919d98sm5038893wmo.10.2024.02.26.05.13.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 05:13:30 -0800 (PST)
Message-ID: <143195db-5c46-4435-8396-bb1927544957@linaro.org>
Date: Mon, 26 Feb 2024 14:13:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/15] hw/ide: Rename ich.c -> ich9_ahci.c
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Bernhard Beschow <shentey@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, qemu-block@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
References: <20240226111416.39217-1-philmd@linaro.org>
 <20240226111416.39217-7-philmd@linaro.org>
 <54e1f04b-bef5-7587-f6d3-a87e9e036740@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <54e1f04b-bef5-7587-f6d3-a87e9e036740@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 26/2/24 13:52, BALATON Zoltan wrote:
> On Mon, 26 Feb 2024, Philippe Mathieu-Daudé wrote:
>> Most ICH9-related files use the 'ich9_' prefix.
>> Mention 'AHCI' in the file name.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>> hw/ide/{ich.c => ich9_ahci.c} | 0
> 
> That would rather be ahci-ich9.h then analogous to ahci-allwinnet.c maybe?

We can have all ICH9 functions named ich9_foo.c, or all AHCI
implementations named bar_ahci.c. But currently there is no
particular style enforced and we have a mix. I don't mind much.

> Regsards,
> BALATON Zoltan
> 
>> hw/ide/meson.build            | 2 +-
>> 2 files changed, 1 insertion(+), 1 deletion(-)
>> rename hw/ide/{ich.c => ich9_ahci.c} (100%)


