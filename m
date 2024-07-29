Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DD4EC3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 12:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYOxr-0005S6-Lm; Mon, 29 Jul 2024 07:54:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYOxp-0005Oh-RY
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 07:54:53 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sYOxm-0002fP-N6
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 07:54:53 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-368584f9e36so1248590f8f.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 04:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722254088; x=1722858888; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+ui2GzqOyf53+BduT2bZbxvFiRlJThGLjySYkf4II08=;
 b=RaRHhQgCJ8e+4ocKRnCH69OyYBL134opeXJ8t4y9tm8CZ1SdWKFYppb4C3vmNwRDJN
 hoW1XFCJPDR50zDH1tQELnV6HtVqMFrs6nLZM536EzfBBsuvNWJhd0yKjdT06026xiJL
 w8NuKTgDXMxaNApO4gbuKJ0QdNSG7lReKb4ENxfCq30bMWI7F1QIlnsztMHXDHQM6VyB
 Eu8DHDmaswB3ij/LH4fiRldL9PNNB/s5t23c5wJJyYqIz+S1K1XPv+QwdxAcLT5ZtD3U
 wDodwoBQX55jdQCJsigeQivEzSI+wuHv19EEmyAdY3GyX4xalj2kRxntDvjGfV6ZeNfz
 0QrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722254088; x=1722858888;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+ui2GzqOyf53+BduT2bZbxvFiRlJThGLjySYkf4II08=;
 b=omzP3+TlfevWFybThkd+DXELQ880i2qczCwgSW59zo659KLHsVUbdmDYN47+MXVPmT
 +yIKRT9k3fuPrPh6W/JPxtHHWs5/Ca7mVS46KIO2zd/577/rtW9+SWLYjtItilCDFVJV
 l1yhacsH7Z9LTmPu0P8w2xUICkOz3xXIdAAIvd0GOm6gxDSohvhEaLYtG9DYDiApa81Z
 9xrQbY16Pr9CVAIFlMEAoaoVpE2Ybug3NQaNyS/FghvbjU0+HDUaj04W+Yk8h+S9qG1g
 pR6QdxFq+AlZsg9W+YH5Q+kvRcp924+eQZRhOmuy2OL1iYxNiuj8HpGVBAc0bAysGe69
 fqfQ==
X-Gm-Message-State: AOJu0YyQbePkQggIDVPAjbpVIDd00h+3OKSvP7wK2yYbzWrYzIe1xNA7
 5F0tz42+4A7nCvrRcwEHWutX9RStVagQZFhpQMqPUP3rER0Qf5GEKLpPwGRhXHI=
X-Google-Smtp-Source: AGHT+IHj863gKHFZgln/0mHvZ8mw+pDVh0OE4eOA7e5u0e+MLLV5z5cTOwDpSkbnpDIjyWAJw7qzlQ==
X-Received: by 2002:adf:ea10:0:b0:367:9c12:3e64 with SMTP id
 ffacd0b85a97d-36b5d073efemr5511758f8f.46.1722254087783; 
 Mon, 29 Jul 2024 04:54:47 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.173.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36b367d98aasm12089148f8f.30.2024.07.29.04.54.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jul 2024 04:54:46 -0700 (PDT)
Message-ID: <6dbc898d-be8a-497c-87bb-d13d956cd279@linaro.org>
Date: Mon, 29 Jul 2024 13:54:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] tests/avocado: use more distinct names for assets
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org,
 Radoslaw Biernacki <rad@semihalf.com>, Paul Durrant <paul@xen.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Akihiko Odaki <akihiko.odaki@daynix.com>
References: <20240726134438.14720-1-crosa@redhat.com>
 <20240726134438.14720-7-crosa@redhat.com> <ZqdzqnpKja7Xo-Yc@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <ZqdzqnpKja7Xo-Yc@redhat.com>
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

On 29/7/24 12:49, Daniel P. Berrangé wrote:
> On Fri, Jul 26, 2024 at 09:44:31AM -0400, Cleber Rosa wrote:
>> Avocado's asset system will deposit files in a cache organized either
>> by their original location (the URI) or by their names.  Because the
>> cache (and the "by_name" sub directory) is common across tests, it's a
>> good idea to make these names as distinct as possible.
>>
>> This avoid name clashes, which makes future Avocado runs to attempt to
>> redownload the assets with the same name, but from the different
>> locations they actually are from.  This causes cache misses, extra
>> downloads, and possibly canceled tests.
>>
>> Signed-off-by: Cleber Rosa <crosa@redhat.com>
>> ---
>>   tests/avocado/kvm_xen_guest.py  | 3 ++-
>>   tests/avocado/netdev-ethtool.py | 3 ++-
>>   2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/avocado/kvm_xen_guest.py b/tests/avocado/kvm_xen_guest.py
>> index f8cb458d5d..318fadebc3 100644
>> --- a/tests/avocado/kvm_xen_guest.py
>> +++ b/tests/avocado/kvm_xen_guest.py
>> @@ -40,7 +40,8 @@ def get_asset(self, name, sha1):
>>           url = base_url + name
>>           # use explicit name rather than failing to neatly parse the
>>           # URL into a unique one
>> -        return self.fetch_asset(name=name, locations=(url), asset_hash=sha1)
>> +        return self.fetch_asset(name=f"qemu-kvm-xen-guest-{name}",
>> +                                locations=(url), asset_hash=sha1)
> 
> Why do we need to pass a name here at all ? I see the comment here
> but it isn't very clear about what the problem is. It just feels
> wrong to be creating ourselves uniqueness naming problems, when we
> have a nicely unique URL, and that cached URL can be shared across
> tests, where as the custom names added by this patch are forcing
> no-caching of the same URL between tests.

I thought $name was purely for debugging; the file was downloaded
in a temporary location, and if the hash matched, it was renamed
in the cache as $asset_hash which is unique. This was suggested
in order to avoid dealing with URL updates for the same asset.
Isn't it the case?


