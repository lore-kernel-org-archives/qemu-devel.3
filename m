Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79744D0E6D8
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 10:05:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2pHf-0003Zg-CD; Mon, 21 Oct 2024 06:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t2pHZ-0003VU-47
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 06:05:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t2pHT-0006Qy-88
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 06:04:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729505093;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lCQ7QD74XHEnVsryUCvmKvPJna4l4bQ79tfM/O8aW+4=;
 b=Qx3HFe78BFxJHfoXInuwBUjIkJ9YMvYmpD+Aj4DoKBp75rspEMPoRXFTnRvmmVbVTsuqfJ
 HA9IwP+ZIcTOHSzZsXq+qQAVEKQxOxS1teQqIMWy4jyB0vp9truqpwzBe8v/09KsPIIpY7
 lnZDoZ0pXyMX6okjjN5C4fJXxb+hG68=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-647--rkok8FuOFeiE7JtTjw-1w-1; Mon, 21 Oct 2024 06:04:52 -0400
X-MC-Unique: -rkok8FuOFeiE7JtTjw-1w-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4316138aff6so24807905e9.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 03:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729505091; x=1730109891;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lCQ7QD74XHEnVsryUCvmKvPJna4l4bQ79tfM/O8aW+4=;
 b=cfmlUsvDGAxo4EJ5egO77nmPlA8U8yW4m2HBWmZCgStrjUEIixp5dMGNeOK4G0mbRe
 6LdRGaWp+NMA5nCxJdsuyaKRBvGwvDSQOAaxb3YSsAj+aWWluaGTgBZDUPMfJ/mDfJRy
 1HB8WM2wKM6RclsdF8VINOocEa+Yd+2wZZ2X09vSASrB1zFkhs1SBPQpmg3eN+fSbnod
 iOvQjKVdeFVpjzlXyK1yIYpn4D/Ps/9Av+c7IWi7PkqFEJ6DzhL3C+9mFwrm67E1ogD3
 x0DgdAnBDDjVUqrpKk7wrThddl53QcSTVIIsKiUtWJ/1DU7lp+/7pc/tnZZotedWo8if
 C6Cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0SA8RJX9jzE9auNrjpDP+uLXk6s/E7WkEIXXVheopLKUKJcB6DSjlmvQHsHJyUj+plODoXYni9fD6@nongnu.org
X-Gm-Message-State: AOJu0YzX2Ym1bbw8hsgtuy8z20grTEpkzv1M3ECIdxhHVvyXPRR8y8qV
 6obfbE6IsL+P+oDBtkXB6BNfDp6flAyj9t0FNYRFUfrTv6ijC5l2JsB4G0ZAsV03mNDAH3CW012
 YpDZsDBkCiRuur2UXwC245lyxnrde6tj/IQsdVXRpO31d2obMKoRz
X-Received: by 2002:a05:600c:4f09:b0:42c:c28c:e477 with SMTP id
 5b1f17b1804b1-43161697686mr85623165e9.23.1729505090798; 
 Mon, 21 Oct 2024 03:04:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSBGZf3yHNXYae7IfFnIfldxz3+vNaR0ylNCRyXhCEZ6cGu/TuiadIGS72TLbePybqDtU4XA==
X-Received: by 2002:a05:600c:4f09:b0:42c:c28c:e477 with SMTP id
 5b1f17b1804b1-43161697686mr85622905e9.23.1729505090395; 
 Mon, 21 Oct 2024 03:04:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72?
 ([2a01:e0a:165:d60:bbdd:3c5e:7d8b:3f72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4316f5c2b46sm51918515e9.36.2024.10.21.03.04.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 03:04:49 -0700 (PDT)
Message-ID: <bd2275c0-fb89-4898-9fe1-ada795e79ef3@redhat.com>
Date: Mon, 21 Oct 2024 12:04:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tests/functional: Convert most Aspeed machine tests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241018071726.2723934-1-clg@redhat.com>
 <f1249e0b-290e-4416-a776-3f5d6ada1ece@redhat.com>
 <341dff70-d0bc-432b-8764-8cb9b1aba1eb@redhat.com>
 <ZxYjN6T2T9Dqnpz8@redhat.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <ZxYjN6T2T9Dqnpz8@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.527,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.699,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/21/24 11:47, Daniel P. Berrangé wrote:
> On Mon, Oct 21, 2024 at 11:31:03AM +0200, Cédric Le Goater wrote:
>> Hello Thomas,
>>
>>
>> On 10/21/24 10:53, Thomas Huth wrote:
>>> On 18/10/2024 09.17, Cédric Le Goater wrote:
>>>> This is a simple conversion of the tests with some cleanups and
>>>> adjustments to match the new test framework. Replace the zephyr image
>>>> MD5 hashes with SHA256 hashes while at it.
>>>>
>>>> The SDK tests depend on a ssh class from avocado.utils which is
>>>> difficult to replace. To be addressed separately.
>>>>
>>>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>>>> ---
>>>
>>>    Hi Cédric,
>>>
>>> I'm seeing errors when I try to run "make check-functional" with this patch multiple times, e.g.:
>>>
>>>     File "/home/thuth/devel/qemu/tests/functional/test_arm_aspeed.py", line 111, in test_arm_ast2400_palmetto_openbmc_v2_9_0
>>>       image_path = self.ASSET_PALMETTO_FLASH.fetch()
>>>                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>     File "/home/thuth/devel/qemu/tests/functional/qemu_test/asset.py", line 104, in fetch
>>>       raise Exception("Asset cache is invalid and downloads disabled")
>>> Exception: Asset cache is invalid and downloads disabled
>>>
>>> Could it be that the tests alter the file in the download cache?
>>
>> yes. the flash image is updated by Linux. I don't reproduce the issue
>> on my build though. Are you using special options ?
> 
> NB, this would only happen if invoked via 'make check-functional' as
> that has the logic to run asset downloads seprately from the tests.
> If you were just directly invoking the test program you wouldn't see
> this error message, as it'll just re-download.
> 
> You would have to run the test twice too I guess, first time downloads
> and modifies the image, second time sees the modified image and
> complains.

.cache/qemu/download/3e13bbbc28e424865dc42f35ad672b10f2e82cdb11846bb28fa625b48beafd0d

is indeed updated. check-functional-arm doesn't complain (which I was using),
check-functional does complain.
  
I will add '-snapshot' to the machine options.

Thanks,

C.



