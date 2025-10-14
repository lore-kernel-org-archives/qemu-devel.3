Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66168CCD190
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 19:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8kYs-0005wV-KI; Tue, 14 Oct 2025 15:19:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8kYp-0005vc-5R
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:19:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v8kYl-0007XW-Pa
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 15:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760469583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nxxHIyWXSbtCv/rAIR+l2M0E7ZD4lmObdEUsl/l6F/Q=;
 b=XCrTJBleAho9Opi6B7cSCwlAWxXPAhCcxI1E7BviMRZ7lqemr35IhLcWxzagTw7sv+a7Qq
 GMLbTfLA1nDK/0VvP6uvUAft5TNPptx6eCFJrDATrU+H/mFXpjgXEUusxHIrkdcVpmjtgB
 5rYqRFcU2wPue4eSmeGYQIOqSU22OxA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-362-g0eLZCAeMiyGvUcYZBkowQ-1; Tue, 14 Oct 2025 15:19:41 -0400
X-MC-Unique: g0eLZCAeMiyGvUcYZBkowQ-1
X-Mimecast-MFC-AGG-ID: g0eLZCAeMiyGvUcYZBkowQ_1760469580
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-426d314d0deso2526917f8f.1
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 12:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760469579; x=1761074379;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nxxHIyWXSbtCv/rAIR+l2M0E7ZD4lmObdEUsl/l6F/Q=;
 b=rLJ7dS95qJLihEv5t5SD1+F6z2+Di7j0MK0C8egwKeAhlAzm/Ig1T5USQgOTxLFJjd
 u5ze8Zkn4Gir0vHF5dhfW2nOtBXRunfGEs1TPjbwxi4ly5Pw3IS6xATQPAe1BULfi/Gd
 uUNGFNYoyMH9ZnT0aS6VEIBAQuY3IDCN91nZRi+2JOR7297I5EzkQRiODxwW95VPfLZ6
 4UCStymadkkEEjTDIXkIhWywUYtuHdOGg+66bokZI14yjH+wYqwdCXc4l3GSBfJphk5g
 P8NLRGyTEp5GIxfOvDTTSvj95NJz3rDXMAyOtoCniM4YO8Tzgv7l7VGykwrsie1a9USK
 2eAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsAVr6qVthbDkSACf6VTcKnnGvr30+rYOmLz9+2L54FTj15ZJ2VOIAOqXcbadbXIJX/J+QUlkT9tIH@nongnu.org
X-Gm-Message-State: AOJu0YwlA0d/p0KNZJg4N4VMxcf2eKFeUEO9aZ+0f51f/cLIR4cn6Wbs
 KUEhE0lWXhm0JozJrtfxf3tZ/3FfS4Xkueh8kqJIyQOJnaECHk6k7o0SBr+DPizO361XFLiR+0z
 0JXQDhzubclxhig7aCOLRLtlfQ6/lkXapP/S+SLZzJEj7sd5FezyVVAMM
X-Gm-Gg: ASbGncuDQi+R5+pJTYO7+YPNF9eh8rBOs4napgOS7c9ggLp7S2tn4RwFf9LjfrhTBO3
 NCFdMewM9bCyFBcYeBnRZHFVXDnKvAS5+J0C2aD2EUre+BSnPL0OdsdhcfWaSIz0stLQNAKVZ/L
 oGBe5howXBCuurCIu04bXFNbfs7PkFdk2PJM5b/PgdPlbcxWVfIfji4Td1mgklmSSamZIR9u0Sc
 YjicFmIxVvyh92DKvIR8Igfwaw03l3HNbBoSnMnxz5YHkytVOE24j6MpMYdJU8Pp1LAa9z7yLuO
 oiFf45bS/kqdOC7lgxYmbYfg7c6Mae0auIGTYu/0KK33tT3du8ThujQ4y+c9MvCXx9dYBXAiEzo
 MjEwo9A==
X-Received: by 2002:a05:6000:4b16:b0:426:d54d:224d with SMTP id
 ffacd0b85a97d-426d54d22bemr10056337f8f.27.1760469579466; 
 Tue, 14 Oct 2025 12:19:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBFHAWA63ZBRbemBt5/mSxRdybStwhSb7Vup/WaMzJ5QPM+Cuk2SJkPT6rahMRl85zFa+Bow==
X-Received: by 2002:a05:6000:4b16:b0:426:d54d:224d with SMTP id
 ffacd0b85a97d-426d54d22bemr10056318f8f.27.1760469579071; 
 Tue, 14 Oct 2025 12:19:39 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-136.pools.arcor-ip.net.
 [47.64.112.136]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583664sm25165819f8f.22.2025.10.14.12.19.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Oct 2025 12:19:38 -0700 (PDT)
Message-ID: <e6bf49c3-b115-4359-a27c-8ff574aed005@redhat.com>
Date: Tue, 14 Oct 2025 21:19:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/9] python: Install pygdbmi in meson's venv
To: John Snow <jsnow@redhat.com>
Cc: Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, berrange@redhat.com, qemu-arm@nongnu.org
References: <20251002020432.54443-1-gustavo.romero@linaro.org>
 <20251002020432.54443-3-gustavo.romero@linaro.org>
 <CAFn=p-bscu00jtyfm+SmeYqB7gt6eA+F8uuYb8ng6rTe_a=HTA@mail.gmail.com>
 <a0d4ba3d-f799-4ec3-8d3b-efdc33527242@redhat.com>
 <CAFn=p-awbF01tQr9xnRX8EqPBNoafGP+N2W-hoMwc68cmwQzLA@mail.gmail.com>
 <701600e9-651c-405a-b076-57883878bdef@redhat.com>
 <CAFn=p-aYSo15pW+wBKsAOFdf9PyniZf4R2TcvMNJaRPULxVL9w@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFn=p-aYSo15pW+wBKsAOFdf9PyniZf4R2TcvMNJaRPULxVL9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 14/10/2025 21.05, John Snow wrote:
> On Tue, Oct 14, 2025 at 2:59 PM Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 14/10/2025 20.55, John Snow wrote:
>>> On Tue, Oct 14, 2025 at 2:21 PM Thomas Huth <thuth@redhat.com> wrote:
>>>>
>>>> On 14/10/2025 19.39, John Snow wrote:
>>>>> On Wed, Oct 1, 2025 at 10:09 PM Gustavo Romero
>>>>> <gustavo.romero@linaro.org> wrote:
>>>>>>
>>>>>> The upcoming changes in the reverse_debugging functional test to remove
>>>>>> Avocado as a dependency will require pygdbmi for interacting with GDB,
>>>>>> so install it in meson's venv (located in the build dir's pyvenv/).
>>>>>>
>>>>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>>>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>>>>> ---
>>>>>>     pythondeps.toml | 1 +
>>>>>>     1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/pythondeps.toml b/pythondeps.toml
>>>>>> index 16fb2a989c..98e99e7900 100644
>>>>>> --- a/pythondeps.toml
>>>>>> +++ b/pythondeps.toml
>>>>>> @@ -33,3 +33,4 @@ sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.2.2" }
>>>>>>
>>>>>>     [testdeps]
>>>>>>     qemu.qmp = { accepted = ">=0.0.3", installed = "0.0.3" }
>>>>>> +pygdbmi = { accepted = ">=0.11.0.0", installed = "0.11.0.0" }
>>>>>> --
>>>>>> 2.34.1
>>>>>>
>>>>>
>>>>> Do we need to vendor pygdbmi? Currently, mkvenv does not consult
>>>>> online sources and so if this package is missing, pulling in testdeps
>>>>> will fail.
>>>>
>>>> This is handled by the "check-venv" target which is called now when you do a
>>>> "make check-functional". See:
>>>>
>>>>     https://gitlab.com/qemu-project/qemu/-/commit/75b1786996c422878d09bd12f166004a7d32e459
>>>>
>>>> Works fine for me, did you hit any issues here?
>>>>
>>>>     Thomas
>>>
>>> Ah-ha. I am working on dropping qemu.qmp from the tree and had moved
>>> this machinery into mkvenv.py - I didn't realize that the Makefile
>>> invocation here passes `--online`. The core groups for mkvenv still
>>> operate offline only, I didn't realize we let it go online for tests.
>>>
>>> Before these dependencies get more numerous: do we accept that "make
>>> check" might only work if you are online, or do we want to enforce the
>>> idea that "make check" should always work offline only?
>>>
>>> (like "make check" works offline and "make check-extras" may require
>>> internet for deps?)
>>
>> "make check" works offline (it does not include "check-functional"). It's
>> only "make check-functional" that requires an internet connection. It
>> required this for downloading the assets for the functional tests already,
>> so adding "check-venv" here did not hurt.
>>
>>    Thomas
> 
> OK, got it. For *my* purposes (and this has nothing to do with this
> patch anymore, I see that it's fine as-is) I need to pull qemu.qmp
> into the testing venv /offline/ for the default "make check"
> invocation and I intended to vendor qemu.qmp to accomplish that.

Makes sense. I did the same for pycotap a year ago.

> With this dep here, installing "testdeps" offline now fails, so either:
> 
> (1) I vendor pygdbmi so it can be installed offline, or
> (2) I split the test deps into two groups; offline and online.

Please go with option (2). We likely should add more deps for the functional 
tests one day (e.g. a bunch of tests are using "numpy" and "cv2" - and 
currently these need to be installed in the host env manually), so adding 
all these via option (1) won't scale in the long run.

  Thomas


