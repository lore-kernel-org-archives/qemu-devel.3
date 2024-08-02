Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FE21C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 13:26:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZsHk-00056E-QE; Fri, 02 Aug 2024 09:25:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZsHj-0004zn-5Q
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:25:32 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZsHh-0007dg-Fo
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:25:30 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4280c55e488so19402955e9.0
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 06:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722605128; x=1723209928; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q3mIPqJh8BOz0AuzS7FzeKZvEUsY6afgM71FCBzle2g=;
 b=eWkAtDGwlwCqtID8soJ2TKxFc7z7wgrWExRV2s+5gRumUv7FZBQfluac/av9T+OV+J
 oWaSrn6dh5e8oQENbl2ZtnuzJNs1VYKDTr8e/AJD9NGeK4oKeNsvd7yUfM2ig1Hqx9VZ
 fhsv9lggadCj7UBOXw9AqSd1+fRR0ARNnIb1iRIFn5ZEIXA6m3Q/A+jkpdPtATp5ThFT
 R9gmHieJDcjLucNvHPY/LR0/6+QNAP4WTIAvYUkSmsVuxoCBN4eklgwle579Dig+Pn++
 8xLMmpvrd955PDBzVtbIta70KduOTRFGLCHtvxGYeSvm2/GF6WhckwKabVZQKVSlyNQY
 9uVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722605128; x=1723209928;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q3mIPqJh8BOz0AuzS7FzeKZvEUsY6afgM71FCBzle2g=;
 b=HRcMB058WbU0zMr0KKV7kf5FFBWe/hrHcWMPwmmQ+Po2qf8snOxqlJ67eHkjNmVaHt
 cyYUY+VBllzCiB6fG4ABPKUaGG9URmPJtM9HL9IHMrcmoWkHOJhLktyh9+NFE3FFgN1s
 XbTV6ckefH1oE1HXop0xuW1kAeBWJEUmPDrIy7aEyrs07Q7HydEAW1flvZTs0Dytv156
 fhHDXjd9R+mk/HEYgWGaozodO2tKX/xH34NUbDzm/l78aWTXu3PkugKV+42sAVPvmpQF
 nFMtzW5KfaXXMXSp1MeWEc+ewtYDOWhCOefnj4OgxbpH2uF8uBuGQbj3shRTQ0F1+1yb
 mXBA==
X-Gm-Message-State: AOJu0YxbPkXyYlavjkeSlnM0G5BxHzsxai+fCCA6AT/NjyBb1V57Utrl
 Qa0Oq2buzgaEXGNj07uhAN4url29QTmjZDreK9eOjkntkJUWNqwzpMApTRa4T8M=
X-Google-Smtp-Source: AGHT+IEeQE/LmQA7X/BF4qt42x67LAGYPdaHZwc4+81SWCNiSTSHiYEXmgjmUpMlojoBEKNgjHrvOQ==
X-Received: by 2002:a05:600c:4507:b0:426:5fa7:b495 with SMTP id
 5b1f17b1804b1-428e69f6162mr25481375e9.15.1722605127565; 
 Fri, 02 Aug 2024 06:25:27 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.94])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282b8ad475sm94878965e9.13.2024.08.02.06.25.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 06:25:27 -0700 (PDT)
Message-ID: <8756361d-fc46-4a04-bcba-9200d739c404@linaro.org>
Date: Fri, 2 Aug 2024 15:25:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/24] tests/functional: Convert the s390x avocado
 tests into standalone tests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x <qemu-s390x@nongnu.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-14-berrange@redhat.com>
 <0f30e83a-2048-4dcb-ba41-47920c62e1e1@linaro.org>
 <ZqvIHb15uzWZw6Qt@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZqvIHb15uzWZw6Qt@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 1/8/24 19:38, Daniel P. Berrangé wrote:
> On Thu, Aug 01, 2024 at 07:11:01PM +0200, Philippe Mathieu-Daudé wrote:
>> On 30/7/24 19:03, Daniel P. Berrangé wrote:
>>> From: Thomas Huth <thuth@redhat.com>
>>>
>>> These tests use archive.lzma_uncompress() from the Avocado utils,
>>> so provide a small helper function for this, based on the
>>> standard lzma module from Python instead.
>>>
>>> And while we're at it, replace the MD5 hashes in the topology test
>>> with proper SHA256 hashes, since MD5 should not be used anymore
>>> nowadays.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>    MAINTAINERS                                   |  4 +-
>>>    tests/functional/meson.build                  |  6 ++
>>>    tests/functional/qemu_test/utils.py           | 14 +++
>>>    .../test_s390x_ccw_virtio.py}                 | 79 ++++++++---------
>>>    .../test_s390x_topology.py}                   | 86 ++++++++-----------
>>>    5 files changed, 94 insertions(+), 95 deletions(-)
>>>    rename tests/{avocado/machine_s390_ccw_virtio.py => functional/test_s390x_ccw_virtio.py} (85%)
>>>    mode change 100644 => 100755
>>>    rename tests/{avocado/s390_topology.py => functional/test_s390x_topology.py} (88%)
>>>    mode change 100644 => 100755
>>
>> Conversion LGTM, so:
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> Now while testing I'm getting errors, but maybe pre-existing...
> 
> What host arch / OS are you running tests from ?
> 
> I got through the full set of testing on Fedora x86_64, so
> wondering if something differs.

Linux s390x but I'm not in the KVM group, I need to find
another place to run these (or ask Alex :P).


