Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A9EFC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 17:13:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCLqo-0003RE-VM; Tue, 06 May 2025 13:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCLqn-0003Qz-I3
 for qemu-devel@nongnu.org; Tue, 06 May 2025 13:13:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uCLql-0006bj-G7
 for qemu-devel@nongnu.org; Tue, 06 May 2025 13:13:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746551578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=lbSb1jVekFhLi/NBpXJ0FvYQt8Tsx1pf0qwJer4I7P8=;
 b=bkfQtM4If5IKbxsPhhC1+dFFCRud5/kyeVTKFuHYwVcQFzG2dcN4UDrXEHIf9WSgOFl8/Z
 UIIUquhZmQVp4KVHwkFusnfbak3SD0ofY3BfJXzMsPw0IVpF/51sZ+hg6YWMXpL10P7XAo
 LkAL7ynRrGgoJGP5xp+xxBIU4xXAacU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-ZGZz-xt8NdKAxFZXHUTNxw-1; Tue, 06 May 2025 13:12:56 -0400
X-MC-Unique: ZGZz-xt8NdKAxFZXHUTNxw-1
X-Mimecast-MFC-AGG-ID: ZGZz-xt8NdKAxFZXHUTNxw_1746551575
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3a0b394504cso31673f8f.1
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 10:12:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746551575; x=1747156375;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lbSb1jVekFhLi/NBpXJ0FvYQt8Tsx1pf0qwJer4I7P8=;
 b=QQ24Yg8lbf0lvTQ5twqXC0pe1JoTN6FV9SD8TFAH4ZQRpPhhr2fgNP/xBM4vBUmKfL
 skUSjjmVUgPrEcIpU0VX3p/iSFErR5vMOziZoCYnzy7xeMhhQj6L897Ty5adXeBEifoo
 yV2HtD2rdUY7F5m2pKneb6ixXfg+QPxnHFt1c49G/uERmAqGyIaeA6c7z5+UxUedwfJ3
 e+oOLT3ugpqS99E3e6ufmMGjjdLOYz0Mi3pejmxAKFSjZohUZXZ9YsGF4/VP9a3aCnjK
 70ZMFEXojuYpAQlUwz81up9g0RMPFePIBSsKRG5A6yiGmUXqnpireTu6XfEc9L3eBTBw
 svWQ==
X-Gm-Message-State: AOJu0Yx756XxJOnD+aFN2m/nD3f3v2jvZ+8wSlHL5Utlg51dCR2OTIxh
 pNDh+zAvKhMplQtArvti3vGxLUlSrRVQvh7Dk8xR0RWgKIoZKbQY8MCOlKJ2x6Qbn7Yj1H4odap
 gX2aDEmgc7SvILy67L16ed8xaGTGplikx+7L4Rc8Tx+4U/CRSd9Nm
X-Gm-Gg: ASbGncsfSL4umvmNRJjpPyeA+6/nlIUI2ksbmaBgLkSTR0KLmQixMwTFRxojghsqdMv
 d2PO6FvSt1KoNE5ZKZHRE8I9dRoYal9QsMxPQMQEngDwyC/OqeKXXUBVH+uqLvlLBnjexbNj15l
 Fg6JaGha9jXPULg2HNq0gk5CC0hCEbl/6gPmbkX0HcE2mn8TE+igzQ68n0hdrDpJ5RKezCmcPdo
 BvGHDukuNYw2BeYEuhazheM4hHyZGLvl7dEhyIJJ2DSBzoq1y/SSp1gA5YuhYRbfixqbRsSRcnl
 Flbl4xxTwpuaLLJCXSsSt7LjLnpJFE+QWoU4cuPaoZq6+3a714cl
X-Received: by 2002:a5d:5f4f:0:b0:3a0:7afd:cbfd with SMTP id
 ffacd0b85a97d-3a0b43b6901mr599488f8f.7.1746551575310; 
 Tue, 06 May 2025 10:12:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1OiRGnvZlrzxoewx4DGcoh0VU6pSlaCWNEezzT6GdUkYYvE9QvKnsOowD1InGcOmsYeFOgA==
X-Received: by 2002:a5d:5f4f:0:b0:3a0:7afd:cbfd with SMTP id
 ffacd0b85a97d-3a0b43b6901mr599463f8f.7.1746551574910; 
 Tue, 06 May 2025 10:12:54 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-173.pools.arcor-ip.net.
 [47.64.115.173]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a09a7ad055sm13875216f8f.11.2025.05.06.10.12.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 May 2025 10:12:54 -0700 (PDT)
Message-ID: <e36633e2-e0de-422a-8ad3-1562e97926c6@redhat.com>
Date: Tue, 6 May 2025 19:12:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] meson: use thorough test setup as default
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20250503201806.3045723-1-pierrick.bouvier@linaro.org>
 <f7da46dd-0e8f-42d8-b555-300c088f605e@redhat.com>
 <91cc4370-163e-4bdd-ac1c-b0d6ea3c06cb@linaro.org>
 <aBnXXC3ldqErl8ub@redhat.com>
 <6a8d7703-e275-4566-bc38-b627cc597e9a@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <6a8d7703-e275-4566-bc38-b627cc597e9a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.414,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 06/05/2025 17.31, Pierrick Bouvier wrote:
> On 5/6/25 2:33 AM, Daniel P. Berrangé wrote:
>> On Mon, May 05, 2025 at 10:46:52AM -0700, Pierrick Bouvier wrote:
>>> On 5/5/25 3:32 AM, Thomas Huth wrote:
>>>> On 03/05/2025 22.18, Pierrick Bouvier wrote:
>>>>> Allows all tests to be visible by default when using meson test
>>>>> directly.
>>>>>
>>>>> This has no impact on make check-* commands, which use SPEED=quick by
>>>>> default (see scripts/mtest2make.py).
>>>>>
>>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>>>>> ---
>>>>>     meson.build | 5 +++--
>>>>>     1 file changed, 3 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/meson.build b/meson.build
>>>>> index f8bf6e7bb66..57ff3f722d8 100644
>>>>> --- a/meson.build
>>>>> +++ b/meson.build
>>>>> @@ -5,12 +5,13 @@ project('qemu', ['c'], meson_version: '>=1.5.0',
>>>>>     meson.add_devenv({ 'MESON_BUILD_ROOT' : meson.project_build_root() })
>>>>> -add_test_setup('quick', exclude_suites: ['slow', 'thorough'], 
>>>>> is_default: true,
>>>>> +add_test_setup('quick', exclude_suites: ['slow', 'thorough'],
>>>>>                    env: ['RUST_BACKTRACE=1'])
>>>>>     add_test_setup('slow', exclude_suites: ['thorough'],
>>>>>                    env: ['G_TEST_SLOW=1', 'SPEED=slow', 
>>>>> 'RUST_BACKTRACE=1'])
>>>>>     add_test_setup('thorough',
>>>>> -               env: ['G_TEST_SLOW=1', 'SPEED=thorough', 
>>>>> 'RUST_BACKTRACE=1'])
>>>>> +               env: ['G_TEST_SLOW=1', 'SPEED=thorough', 
>>>>> 'RUST_BACKTRACE=1'],
>>>>> +               is_default: true)
>>>>
>>>> I'd rather not make it the default: The thorough functional tests 
>>>> download a
>>>> lot of assets from the internet, so if someone just runs "meson test"
>>>> without further parameters, I think we should not trigger these 
>>>> downloads in
>>>> that case.
>>>>
>>>
>>> $ cat tests/Makefile.include
>>> ...
>>> check-functional:
>>>     @$(NINJA) precache-functional
>>>     @QEMU_TEST_NO_DOWNLOAD=1 $(MAKE) SPEED=thorough check-func
>>> ...
>>>
>>> What's the rationale to run check-func with SPEED=thorough and
>>> QEMU_TEST_NO_DOWNLOAD=1 with precache-functional having cached only quick
>>> tests by default?
>>
>> Are you sure about that ? The precache logic uses custom_target() in
>> meson and so does not filters on "suites" used to define quick vs
>> thorough tests.
>>
> 
> My bad, I missed the "foreach speed : ['quick', 'thorough']" wrapping all 
> this in tests/functional/meson.build.
> 
>> IOW, precache should always be downloading all assets.
>>
> 
> Then I don't understand the previous argument from Thomas to not make 
> thorough the default: "The thorough functional tests download a
> lot of assets from the internet, so if someone just runs "meson test"
> without further parameters, I think we should not trigger these downloads in 
> that case". It's what precache-functional is doing.

precache-functional is *only* called when you run "make check-functional", 
i.e. when you know that you want to run the functional tests that might 
download assets from the internet. It's not called when you run the normal 
"make check". I think "meson test" should by default also not download any 
assets from the internet (e.g. in case someone is still on a metered 
internet connection or tries to do air-gapped builds) - we should only 
download if people really really want to run the functional tests consciously.

  Thomas


