Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 028C9C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 17:01:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOKOL-0007Mo-04; Mon, 01 Jul 2024 13:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOKOF-0007M3-8e
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 13:00:31 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOKOD-0005Lr-HE
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 13:00:31 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-52ce6c8db7bso4859985e87.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 10:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719853226; x=1720458026; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mEsogqTUaDgWi+GkfAb+mJ2jGR4tDWYaiJVWVpgtbWQ=;
 b=McybVgVfGuSww4cU6RTKMcVUmOxhA+uJeGV8YTQYKa8rmNu6wk8pSzURcgu9WQi1BP
 Ptzt7FYF3Q96ijMFJgpGoZTHi3uGMEFCfC//gNxEDRrjUNmWefC6C9cEusRazh2XBmQH
 Boxqk3tIVazWJ8zpREMFhsl9bPyytUX0QXMT/8zn7lJikLJTDedPyjR7GSlOy/KKi+9Y
 qhexn7Kim10mRlk03O80GJZRzQ7shwWY0hA1CSSp9J/QRkustNfbxaG4gyoeXMPD1Hf1
 eKmG5wqomzXTXPuFQEu9Rf1/oeKsspmnmtwjvANp0c30XGF5QtgR1x13iXUHUYwypV5b
 S/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719853226; x=1720458026;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mEsogqTUaDgWi+GkfAb+mJ2jGR4tDWYaiJVWVpgtbWQ=;
 b=RnX1FKDLSMlF3puiui8mHdOPrG62SVopKl1tYI7kKTCqoqcAyBnJPOw8NPsHZiUPF5
 ifE+iscoZN9HSRNw4/rb3ZIU4a2gvcBMjJbGlPguFPwh77FvU3OkrCGE908VaZWFBAnx
 QZANuE3vHXLo4f85MKujPkA0KL9H/5TGkZLlXysBuY3Ymt2sI8UwN+Ac4WKlmZvOjUXN
 qpJ6XIlLq13cj+rHS3BFiRBbNgkm68i4xBuVDzGsrcILnsxmAw50QPicNxV5AVSQhoaM
 nmwrLwA2hT0ZHjR2JgiLhlFcu8dHQZY2py86PzXB3k9ne0Ug70Wpl3kbq3lDGgkb0NZg
 AScg==
X-Gm-Message-State: AOJu0Yzz6pWlJaoZg9JpnTrgk7C9h5Fols2lyLoODz5uylx+EeqrlwGx
 T3iTqg5gFQdVzkOaRo/lrrVjEEGKgj16nfVx+h4lH+KjHSiwuX5Xe9D7sSXXqoU=
X-Google-Smtp-Source: AGHT+IETO8wRu+14boqTAItTwjN4+2kVBDQnUuDV1NJVNIZkcBycw4bw0+R5vUWsmWVH7wb4fiXtHg==
X-Received: by 2002:a05:6512:1151:b0:52c:df4d:bb9e with SMTP id
 2adb3069b0e04-52e826932fbmr4733608e87.41.1719853220764; 
 Mon, 01 Jul 2024 10:00:20 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.159])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256b09a32asm163254745e9.31.2024.07.01.10.00.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 10:00:20 -0700 (PDT)
Message-ID: <07ad2b0a-8d4f-4104-8343-3b28c181d705@linaro.org>
Date: Mon, 1 Jul 2024 19:00:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] tests/avocado: sbsa-ref: add FreeBSD tests
To: Peter Maydell <peter.maydell@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20240624-b4-move-to-freebsd-v3-0-71496bf119d4@linaro.org>
 <20240624-b4-move-to-freebsd-v3-1-71496bf119d4@linaro.org>
 <CAFEAcA-suKn9LAB8qrNaRu9NeG8DyT_ae0va7uSHuiL3VSk+BQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-suKn9LAB8qrNaRu9NeG8DyT_ae0va7uSHuiL3VSk+BQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x12b.google.com
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

On 1/7/24 15:37, Peter Maydell wrote:
> On Mon, 24 Jun 2024 at 17:20, Marcin Juszkiewicz
> <marcin.juszkiewicz@linaro.org> wrote:
>>
>> FreeBSD has longer support cycle for stable release (14.x EoL in 2028)
>> than OpenBSD (7.3 we used is already EoL). Also bugfixes are backported
>> so we can stay on 14.x for longer. Tests done on OpenBSD will now be
>> done using FreeBSD.
>>
>> OpenBSD 7.3 stays with Cortex-A57 test for local runs only.
>>
>> Moved from Neoverse-N1 to Neoverse-N2 as sbsa-ref defaults were changed.
>>
>> Timeout messages expanded to mention being affected by PAuth emulation.
>>
>> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>> ---
>>   tests/avocado/machine_aarch64_sbsaref.py | 75 ++++++++++++++++++++++++--------
>>   1 file changed, 56 insertions(+), 19 deletions(-)
>>
>> diff --git a/tests/avocado/machine_aarch64_sbsaref.py b/tests/avocado/machine_aarch64_sbsaref.py
>> index 6bb82f2a03..bb2c098aac 100644
>> --- a/tests/avocado/machine_aarch64_sbsaref.py
>> +++ b/tests/avocado/machine_aarch64_sbsaref.py
>> @@ -1,4 +1,4 @@
>> -# Functional test that boots a Linux kernel and checks the console
>> +# Functional test that boots a kernel and checks the console
>>   #
>>   # SPDX-FileCopyrightText: 2023-2024 Linaro Ltd.
>>   # SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
>> @@ -8,7 +8,7 @@
>>
>>   import os
>>
>> -from avocado import skipUnless
>> +from avocado import skipIf, skipUnless
>>   from avocado.utils import archive
>>
>>   from avocado_qemu import QemuSystemTest
>> @@ -165,7 +165,8 @@ def test_sbsaref_alpine_linux_max_pauth_impdef(self):
>>           """
>>           self.boot_alpine_linux("max,pauth-impdef=on")
>>
>> -    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'), 'Test might timeout')
>> +    @skipUnless(os.getenv('AVOCADO_TIMEOUT_EXPECTED'),
>> +                'Test might timeout due to PAuth emulation')
>>       def test_sbsaref_alpine_linux_max(self):
>>           """
>>           :avocado: tags=cpu:max
>> @@ -173,7 +174,6 @@ def test_sbsaref_alpine_linux_max(self):
>>           """
>>           self.boot_alpine_linux("max")
>>
>> -
>>       # This tests the whole boot chain from EFI to Userspace
>>       # We only boot a whole OS for the current top level CPU and GIC
>>       # Other test profiles should use more minimal boots
>> @@ -200,6 +200,9 @@ def boot_openbsd73(self, cpu):
>>                                    "Welcome to the OpenBSD/arm64"
>>                                    " 7.3 installation program.")
>>
>> +
>> +    # we keep OpenBSD 7.3 on Cortex-A57 by request
>> +    @skipIf(os.getenv('GITLAB_CI'), 'Running on GitLab')
> 
> Don't skip stuff if GITLAB_CI, please. If we don't want to
> run it on the CI then we shouldn't be running it by default
> when a local user runs check-avocado either.

I did request that.

> Any skip should have a clear description of the reason why
> we're skipping it.

Right. Maybe replace by:

   @skipUnless(os.getenv('AVOCADO_TEST_LEGACY_OS'), 'OpenBSD 7.3 is EoL')

Or AVOCADO_TEST_LEGACY_OPENBSD... Naming is hard.

Regards,

Phil.

