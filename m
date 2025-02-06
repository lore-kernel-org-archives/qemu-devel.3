Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3652AC02194
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2025 11:44:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tg0II-0003gY-12; Thu, 06 Feb 2025 06:43:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg0IG-0003fT-5Y
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:43:40 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tg0IE-0005KB-Gh
 for qemu-devel@nongnu.org; Thu, 06 Feb 2025 06:43:39 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so8793405e9.1
 for <qemu-devel@nongnu.org>; Thu, 06 Feb 2025 03:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738842216; x=1739447016; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BUm+oKv4IDns3lDH754Ob+WUqxC8MNFQ8NAJlwERYlM=;
 b=uOtJyGnuW67h2Youyes3IlkKCxKbX4RWCvEM9BW2oVP1JGcp1O5mDf31c9TiLIU3/e
 1ab9YokfntwJqzPAZ11RB7aYoDuNdq03iaVuumysKcFDQmd8f2sUVotRqnPDKkOmkBFW
 JUIX/7WEpMNko6Q3t5YVlrqWckRK4auxt+sCCmPlLupovubHyRA9feJ4HxsJ2p/t73I7
 AV6zvhU+DP/evT9LSnhdAOLUq3d+eZHBdNDKfRd6iAiaJXJFS1KcyKJ3j6idQ8QPUMUD
 ldXvV5PrwVRxts8FXUl+CrEZIWJ7dmx2j0T5t0BygZ+Qc1qHElV+mj+Y05ckqv/QPTOa
 6s5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738842216; x=1739447016;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BUm+oKv4IDns3lDH754Ob+WUqxC8MNFQ8NAJlwERYlM=;
 b=QozTe6oApNz5qMblBnXtMos6FXmwYrX69xa7Aup64EMObt1HKr0K61ICGZsovHN+0U
 ECXtvnh21ldR146sY5uq7RoRr7PHmPT+lFCzqyYr8esnokua9SfpXjd8MkM22zVfpW9q
 3TkQuZaaJM4TQ3saZTGKVau7Mqk5S6vCrd2FhRmmAmgPIKS0ATv6xNLRMhz/nhHzpF/S
 qqnPEsz/RQu05PQrpIyoooj+Gpt41wqfUK9M94vAkH0SGkC9MKj0t7d5jDZ87A8dLIrT
 N8gcBF5pmKLyKN1O8gAcs4f03dnm6bYagcZ4XonACJsa5UFIq6SLvFe/z+p+UpiCrhla
 5PuA==
X-Gm-Message-State: AOJu0Yz39JriBUHnR5LICUYIJMAErY4ZFAkS3WooZk/KbTVuoVrqkee9
 30jzXZ90pe0H+Lpt0sJtlx8ue91rjxMF7l60y1aCY+zpQ26KgOEg4eG9Z23nMS4=
X-Gm-Gg: ASbGncuyYbEWR1MYeHz/bTNzsVFQwKqhT8cTnsc7hRMBWgTNQqLy2ekqJdgyG+efL81
 Ag3CkVtNWAEBmDm5dE4ZW2UXqyBI5g2lR1Zc5rk7ASF/gjiaaWaNtHIO7P+fkCRrHORlbWqDAt4
 y6GPTpr2woH3gWE9Fz8baYBmcvBOjbFusfQf4C7jSDzu966k99m3TnRD7y6LUGmLdf6FtWZNXeB
 VBNk5HhMlm++CwEKKelvUrmaHVQ3OVp2Bns7UGWNmbjlDC6dH5kgbbfSZj3GqxKCIjQ2YsBUhcb
 NAsKplmI8bLFqb2HsJsLH2mjadZhvzL1o53ZlfXBKOqj9by8Rx5XHE2gwQg=
X-Google-Smtp-Source: AGHT+IHdu/IoQHRZg5H2NmqxcujFEafSzkB3J34j9A8YLR4PteP2a5XSvEaJJL67ohILgOZ81jV9ug==
X-Received: by 2002:a05:600c:83ca:b0:434:f218:e1a8 with SMTP id
 5b1f17b1804b1-439133fe7abmr18120085e9.19.1738842216519; 
 Thu, 06 Feb 2025 03:43:36 -0800 (PST)
Received: from [192.168.69.198] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38dc4d00645sm257805f8f.66.2025.02.06.03.43.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Feb 2025 03:43:36 -0800 (PST)
Message-ID: <f64a58c5-1080-49de-915a-56d4895d51a1@linaro.org>
Date: Thu, 6 Feb 2025 12:43:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: add --rust-target option for bindgen
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, qemu-stable@nongnu.org,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20250206111514.2134895-1-pbonzini@redhat.com>
 <298a7473-e5e5-418d-8902-2cbd30730db6@linaro.org>
 <CABgObfYzncjR=DtvE8asLfqJA89JjatMzs352F=4PbfTBrq1sw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfYzncjR=DtvE8asLfqJA89JjatMzs352F=4PbfTBrq1sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 6/2/25 12:38, Paolo Bonzini wrote:
> On Thu, Feb 6, 2025 at 12:37 PM Philippe Mathieu-Daudé
> <philmd@linaro.org> wrote:
>>>      if bindgen.version().version_compare('<0.61.0')
>>>        # default in 0.61+
>>>        bindgen_args += ['--size_t-is-usize']
>>
>> Should this be merged directly on master as build-fix?
> 
> If it's breaking CI I can send a pull request later. I wasn't sure if
> it was just my branch with other Rust changes.

No, this is now affecting the main repository, so also all forks.

