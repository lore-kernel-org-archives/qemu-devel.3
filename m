Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C4EC3ABCC
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 20:10:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEZTY-0002Gt-Ks; Mon, 12 May 2025 16:10:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEZTO-00027w-5e
 for qemu-devel@nongnu.org; Mon, 12 May 2025 16:10:06 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uEZTK-0006zz-LS
 for qemu-devel@nongnu.org; Mon, 12 May 2025 16:10:01 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7425bd5a83aso1650027b3a.0
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 13:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747080596; x=1747685396; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fKupLSMdvHNinncztrPfg97RfswSna+7nchTWtqXlm4=;
 b=asFxLz92lZrbz0f33RbH6woR0RfVlNK1w1xtHGNGFCj4g92W2UzC/nQDyf4W11Fr8d
 dgRaJanpFhd57A0N/S3YL80lY/4sUtdPdclcmMg+07xCvOUo0u/ordwWZZ2tAKUDvUnQ
 7+72dQa953PHepmRQEZg4mfGcpu2r7rsi/PE8N9birrNIuVkpzrPNzrgmOxMcGsZ9McU
 ymPL51J2r1bpWlAiLBL+nbJM2RgS0BeEWwRV2R+nAA/aaTMMOMUt8xPUXiFncvc2Azd2
 9coJH3vqWObKnrAFA2NLsFIGURqWmUGXnLtd+bRtoEcguWdxwUWyk2j1WKUbdgUJ2pm3
 8csw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747080596; x=1747685396;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fKupLSMdvHNinncztrPfg97RfswSna+7nchTWtqXlm4=;
 b=JbsewTutdpc0ldEPjzxdjo1DJzG+H4wNmyxShr1UHn84PX9sBkQtU35MmqHHM3SxqF
 PJ4PRGWTlFJW4UgRC6yo15eTotn+b93CnBsg4wO/YoKA50q8+0LF8h7I1WBIMDSh/Nqy
 DKjfMOoXwF75KbGHrDxhnGnSJw0JzYnThvSOOfrB5LeoZoPnHsU3aeqiUAvx6J8v2OVo
 FnLVvrSJhYLKoNr7hG+HizVTsnbXcXwo9pj5roXHe76joYDwMaZ4CYGWACqkojcf0txG
 yUxTonUd0KMrQo+/+6AVyHHw0lIEPjPxisDbnn4MuoIkOps/V7iuPog8FC6VIbJFfi3m
 eD1A==
X-Gm-Message-State: AOJu0YxSBapEgxj2njS8iA3WXvKipFZ6R2KlPfiJSH/0hmLGusfVU3hd
 m+EaGpCu6bDxmDVRfu+fZxsG5TPCf6pPC6bqDkrzn0tGoykaD1Pdm/QTSY5jCU8=
X-Gm-Gg: ASbGnctXFJHpbi+ofLUOKjp/tgWqWMCE2Hq8mViO6d6/H/JAiOCSvCkqvK9OI/TKSh6
 BiibxcutKi67OjO2g5/Cw4VbVTy0rx80QPAJk/kzrK+x6mHaLef+pYUoNPKCCRUHwudB2zjDWxz
 3pA8d4nohkeKi3Ohp7ku0XfoNoA2OQ06wxtEJmKD7NwdlMstDe2j1dBUs8sl7j1P/U3Bjt2L3E8
 YKrERbiXHUgTaQndgx5+2v/jDY1X8UG1Uh1U0X7BH6LzPkQ2GHj7D1QgmPsEFplV5IGTurWb3Zq
 tJEm5X9NiZTEjojLZPoUaw3HQjllAd64SGfmLfoN85InR4cCvUA3b+ufTArayMcVI53B2mhKDLQ
 =
X-Google-Smtp-Source: AGHT+IFkzZUpuRX3GIjNg36dvclmF+vfV+z7V6caN8e+VQy9zXKLwugCdI/0fVmAzk4tW8c89KKi3g==
X-Received: by 2002:a05:6a00:893:b0:736:b9f5:47c6 with SMTP id
 d2e1a72fcca58-7423c01deb4mr17634285b3a.16.1747080596542; 
 Mon, 12 May 2025 13:09:56 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74237704ff3sm6422458b3a.1.2025.05.12.13.09.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 13:09:56 -0700 (PDT)
Message-ID: <26fb50ca-36fd-4aca-908c-272c5a109bac@linaro.org>
Date: Mon, 12 May 2025 13:09:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 00/10] qapi: remove all TARGET_* conditionals from the
 schema
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250508135816.673087-1-berrange@redhat.com>
 <87y0v4zuec.fsf@pond.sub.org> <aCJAaawKsNFAtSmy@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <aCJAaawKsNFAtSmy@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42f.google.com
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

On 5/12/25 11:39 AM, Daniel P. Berrangé wrote:
> On Sat, May 10, 2025 at 11:28:59AM +0200, Markus Armbruster wrote:
>> PATCH 10 empties out and deletes qapi/machine-target.json.  PATCH 04
>> empties out qapi/misc-target.json without deleting it.  Missing:
>>
>> * Delete qapi/misc-target.json
>>
>> * Delete entry F: qapi/machine-target.json in MAINTAINERS
>>
>> * Delete dead logic around qapi_specific_outputs in qapi/meson.build
>>
>> The latter deserves its own PATCH 11.  Whether to delete the
>> qapi/*-target.json in the patch that empties the file or in PATCH 11 is
>> a matter of taste.
> 
> FYI, after discussing with Pierrick, I'm going to let him take over
> work on this patch series to drive it forward to something viable
> to submit as a non-RFC.
>

Thanks for your work Daniel, I'll continue the effort based on your 
approach.

Just for information, I'll apply a Signed-off-by with my name to all 
patches posted (including the ones I won't touch) simply because I use
git rebase --signoff by default, and don't want to have to do this 
manually and selectively, as I work with a single master, with stacked 
branches and update-refs.

Regards,
Pierrick

> With regards,
> Daniel


