Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B0DCAC5B5
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 06:27:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v37Ld-00079E-60; Mon, 29 Sep 2025 02:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v37La-00078j-4D
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 02:26:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v37LS-00041t-6p
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 02:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759127197;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=X3tX04K/XYn/NkJKn6o6GO1ekrmrzLcVfothhwv5THQ=;
 b=bh///3VQTFCfpiF+BlH5+uMsxdLT2d3mcx7E6sNz22Skvi0ZavLCeEN0JfPEWKVjCDC0VK
 CiecN/jcs11u8JuBly34KCYScH6cLAqRFF9uxheXJnY9h9xKAvVK6TfbdEMl3FCy6OasT3
 YTg3oDYc20L2l2FWq8+3abu5tonKM6I=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-8mXAwPZyOteKWiyC3DHqoQ-1; Mon, 29 Sep 2025 02:26:35 -0400
X-MC-Unique: 8mXAwPZyOteKWiyC3DHqoQ-1
X-Mimecast-MFC-AGG-ID: 8mXAwPZyOteKWiyC3DHqoQ_1759127194
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-afcb72a8816so434527166b.0
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 23:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759127194; x=1759731994;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=X3tX04K/XYn/NkJKn6o6GO1ekrmrzLcVfothhwv5THQ=;
 b=XtHXnWI6VKDdKAuDv+zEUxuyDfnosIzti5r8lm50v+wcDWeJFHEofSvvIKuQvhLXnQ
 u6lzGMT+WsjSvw+ECC3OfgoTCqVuWT7Ku67Bb8v4MA2cnQoYrL0/WWmMjjuV87WxYY9j
 TUSA8T7JQW3XQGdC224KQifK4UINossuBS3d+n6bW/OgafcSMqHOCsioJfaJOoRZP9jX
 4utVizH6mkSm1q0algH2gerC2K/ypyygfDscznZArn5z0GTAQjKuZYo5d9yIfAGxQCMg
 nynl+37ecqI38LOyKmhBIUPwOVY32kfpicLCc+ilcB4fmwtoLubdchvV/ljbefk4XGrX
 1GYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9IVZ8Ig+W7c8Gsz7dGYnu3q1gmar+WjK78UcIK1seuB5/JHBQGqyRgvvpFsvJ60cRFrNKrmau+wNC@nongnu.org
X-Gm-Message-State: AOJu0YyPSCdBFw/df+TLG7JPhKObE1y2nH0gqiqUdeE3HaHi2Tx7Ev2/
 ky7FLsmhUEIWwVhMXqIvZdUR2Xo+G5vWhSK0EKCtCAmkHbgqkk9pWslY3z0aR4hUOQLTIPk3Mwh
 aFahz73iIWpG/FmuykBKC1/cy6IGoLhIx0YHYRAvm0+AsQqbCxXDDp6G6
X-Gm-Gg: ASbGncvjoi0RVwDJTHaaiUlnCGdRZnqufZlTTSjuzn7X6rcmvYZHJ/zbLdyxzoR4XEN
 fguP3fUIhwlcel1wr7PBvIKpA16nMCnKucyg2nMlr2YuPZ6IPWkufQqxkxgh66n76LvDb70ikOB
 8SIY1eXL+rokJx0Pqux4RBxOe6d0hxv+LmWQbRDJRe2HTQxYJKY/hBMegC7x+3MTpgrpBaayPHY
 HnsTGmGy3kz0t68PxIDMsEWttZVLjQ4uHch0MdgZ02xBeBhqWYeSv+hOAa5upNM3rHLtKXYRWBj
 WwabwMviovkXyenzySRUbNkvxwj1wvXsv9XE70vcLWmb+6pxILf7SrRr74Op/bc/RMjXaUIj1fK
 HJDcojw==
X-Received: by 2002:a17:907:da1:b0:b3e:dbbc:4e16 with SMTP id
 a640c23a62f3a-b3edbbc4f90mr267345066b.41.1759127193872; 
 Sun, 28 Sep 2025 23:26:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQ4bbGpJWr4gkXXT7QeLix5IvUjdxOCMNCnG7tOpTQ7vx4i69JHlxiIXUSsio+tucRD2ZurA==
X-Received: by 2002:a17:907:da1:b0:b3e:dbbc:4e16 with SMTP id
 a640c23a62f3a-b3edbbc4f90mr267341966b.41.1759127193477; 
 Sun, 28 Sep 2025 23:26:33 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-212.pools.arcor-ip.net.
 [47.64.114.212]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b3a835ca898sm430195766b.60.2025.09.28.23.26.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Sep 2025 23:26:33 -0700 (PDT)
Message-ID: <66ea9c0e-14c6-465d-b473-2d750effff4c@redhat.com>
Date: Mon, 29 Sep 2025 08:26:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] tests/functional: Re-activate the check-venv target
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, berrange@redhat.com
Cc: qemu-arm@nongnu.org, manos.pitsidianakis@linaro.org,
 peter.maydell@linaro.org
References: <20250926051542.104432-1-gustavo.romero@linaro.org>
 <20250926051542.104432-2-gustavo.romero@linaro.org>
 <5aefdfa3-4b8b-4512-a6a4-1a1684352d0f@redhat.com>
 <34599995-fe56-436d-82c2-3837037a58a8@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <34599995-fe56-436d-82c2-3837037a58a8@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.539,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

On 26/09/2025 17.43, Gustavo Romero wrote:
> Hi Thomas!
> 
> On 9/26/25 05:34, Thomas Huth wrote:
>> On 26/09/2025 07.15, Gustavo Romero wrote:
>>> Add check-venv target as a dependency for the functional tests. This
>>> causes Python modules listed in pythondeps.toml, under the testdeps
>>> group, to be installed when 'make check-functional' is executed to
>>> prepare and run the functional tests.
>>>
>>> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
>>> Suggested-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   tests/Makefile.include | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>>> index 3538c0c740..d012a9b25d 100644
>>> --- a/tests/Makefile.include
>>> +++ b/tests/Makefile.include
>>> @@ -109,7 +109,7 @@ $(FUNCTIONAL_TARGETS):
>>>       @$(MAKE) SPEED=thorough $(subst -functional,-func,$@)
>>>   .PHONY: check-functional
>>> -check-functional:
>>> +check-functional: check-venv
>>
>> I just noticed that there's still a problem: If you run "make check- 
>> functional-aarch64" immediately after configuring + compiling QEMU in a 
>> fresh folder for the first time, the functional tests fail with:
>>
>> ModuleNotFoundError: No module named 'pygdbmi'
>>
>> We either need to add dependencies to the check-functional-<arch> targets, 
>> too, or we have to make sure that tests still get properly skipped in the 
>> case that pygdbmi has not been installed into the venv yet.
> 
> Isn't it inconsistent that check-functional runs the test and
> check-functional-<arch> doesn't? I think it's a good idea to
> skip if the module is not available, yeah, I'll add it in v6,
> but would it be ok to add check-venv to the check-functional-<arch>
> targets too?

I think so... so please try to change this patch to add the "check-venv" 
dependency to the "$(FUNCTIONAL_TARGETS):" line instead.

  Thomas


