Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0310FC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 16:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAAC3-0004Lc-8k; Wed, 30 Apr 2025 12:21:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAAC1-0004LH-Ae
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:21:53 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uAABz-0006WI-1f
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 12:21:53 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-227a8cdd241so214195ad.3
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 09:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746030103; x=1746634903; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CK3R8NG0Ht6HFQtv7LqmLGfMdjeBRifCgAvnIcKboVY=;
 b=ZIxqhWJ9i9rsxTf67NWkwElFb62W+3cjRYrCoY+vpybB2N+u1FR22YriFblyYYN0gC
 wcrXBkIqc5EodcBsl8wm8VPhnnnYYhCQVaSmcvYGFnEzNW3KHe7aMlefRx5AFKMwUT5j
 tLeyBobWsH6npLiuQ+nnxUcIAG8zu5ztH85d/vxizI4mt493ipqmLbP1Kb3Q1WfZhFxC
 0lwudiRVEjL1GLXfQ3JBBQUs/Kqmi8BaSIgWFapKV/XQjoQPSOl5cLixobwWLHgEm/jG
 KbR4HQpf5scqDYIR8QE5kJxGL9JfobV2UgaTuNlA8asGQepaQ30qxfjkE6iZAI1t3jBl
 3UAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746030103; x=1746634903;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CK3R8NG0Ht6HFQtv7LqmLGfMdjeBRifCgAvnIcKboVY=;
 b=LQ9C6wo7otUtnKB3v53B5e+2aJwRyE9aVgFgqHrTVX1fBD4r3VIp9X0EJwf6tJAzmB
 HuvuZbHPEwg1lB7Ldsoauvb4vMZ6EpQjQGHKpPOvL4MXmVdkyQPVYe8vSMYOiwdy9Pu9
 fiM4qlTQnW9VOgZEDfQxX2iBR75IzIRerkCmzJRuwdV0nywJW+eE+kF/FsknA33Yx7VN
 aGMXUKFedHJFwwaadc3lXB+NECJ2LlLhmgPLJmeAIBepwg5IsBS81jDu1eQXbrg7CY5q
 ccd1FVA3ZxwiLeN1l5d75cg4zGTLQ6B1JBHX2qe+oksgwpFhNEc7UJjsMAtqECdB8ro/
 q9sQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjOZgURkd6szOLNuF5I5xz4gQ6OR1NbCVARSCTVXXNahV69txFv0wM2hvSs4Ow4XskKpI7Qj4wf8Pm@nongnu.org
X-Gm-Message-State: AOJu0YyetLXZ1fer4Cna42EyMQ1TrlkKDh+q972WjAUxJm/4wNsNCeiu
 swn71lYUaCtP7/ZZN88aTFRFoQarb2aU+4cjQNxcZZZQFL2Kynpzz2+IhEn0TaI=
X-Gm-Gg: ASbGncsGsQnmQr/IhUzpP2lOtuqhfPhfUxf/pPtMoJ1wKcvJkb+IAm8Iy12GSuIzIy/
 ZVrmR7U9YCwlxH86acKouJZ3zNCF6i6wSpM6zVAqWfFMcO+CK8QMF8BaRNKu6V3QqLzym8T1xm5
 l+mB0KJLTgJw6P0Qc4llWVlqVnpQc/k0FljPcEbq5U3hajmVKGwa364V0RnWXI1Ev5q+MphL1qt
 zhu+JVe2J+wSLpK4unLxy/GHvt681Uj/uuSncwuWitMl8K9Z0DHnSZvhXveFtjqINptksmb5vwV
 UhgcJciIGo7ELRLsX9sST40MBvAK9lmzexoX2Pef9gtJPCiqnFPOcg==
X-Google-Smtp-Source: AGHT+IHfudTt7LszFLKuM/jUzOdJOodx6TuD54vAwFnTH4Qj15t8IKdPiLxy3B68wMPki8ZKi3v98Q==
X-Received: by 2002:a17:903:1984:b0:224:ff0:4360 with SMTP id
 d9443c01a7336-22df35ffbabmr67866345ad.53.1746030102775; 
 Wed, 30 Apr 2025 09:21:42 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d898e2sm125117235ad.7.2025.04.30.09.21.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 09:21:42 -0700 (PDT)
Message-ID: <efbaccd1-9ef2-4aed-88ed-d6a2bcb7902b@linaro.org>
Date: Wed, 30 Apr 2025 09:21:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Functional tests precache behaviour
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
References: <c83e0d26-4d1b-4a12-957d-c7b7ff4ba1b3@linaro.org>
 <7f0c4586-8a97-4e64-8abb-58a74b86afaa@redhat.com>
 <6e9a3cb3-e238-48a7-a67c-c95b36a517bc@linaro.org>
 <aBJJqtzQaTH_xcKK@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <aBJJqtzQaTH_xcKK@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 4/30/25 9:02 AM, Daniel P. Berrangé wrote:
> On Wed, Apr 30, 2025 at 08:48:59AM -0700, Pierrick Bouvier wrote:
>> On 4/30/25 8:00 AM, Thomas Huth wrote:
>>> On 30/04/2025 16.34, Pierrick Bouvier wrote:
>>>> Hi folks,
>>>>
>>>> $ ninja -C build precache-functional
>>>> 2025-04-30 07:23:20,382 - qemu-test - ERROR - Unable to download https://
>>>> archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/
>>>> gzimg/armv7.img.gz: HTTP error 503
>>>> 2025-04-30 07:23:23,131 - qemu-test - ERROR - Unable to download https://
>>>> archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/
>>>> gzimg/armv7.img.gz: HTTP error 503
>>>> 2025-04-30 07:23:25,870 - qemu-test - ERROR - Unable to download https://
>>>> archive.netbsd.org/pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/
>>>> gzimg/armv7.img.gz: HTTP error 503
>>>> 2025-04-30 07:23:25,871 - qemu-test - ERROR - https://archive.netbsd.org/
>>>> pub/NetBSD-archive/NetBSD-9.0/evbarm-earmv7hf/binary/gzimg/armv7.img.gz:
>>>> Download retries exceeded: skipping asset precache
>>>> $ echo $?
>>>> 0
>>>>
>>>> Since we silently skip the asset precaching, how can we identify that an
>>>> asset is not available anymore (temporarily or not)?
>>>> Should we rely on test itself failing when trying to download again this asset?
>>>
>>> The current logic fails hard for 404 errors, so if the asset is completely
>>> gone, we should notice it. For other error codes, we assume that it is only
>>> a temporary server problem that will hopefully be fixed on the server side
>>> sooner or later.
>>>
>>
>> Sounds good.
>> Should we replicate this semantic when running the test itself?
>> It would be more useful to skip it because an asset is missing instead of
>> reporting an error, except if it's a 404 error.
> 
> The tests already gracefully skip if one or more required assets
> are not available. See the 'setUp' method of QemuBaseTest
> 
>          if not self.assets_available():
>              self.skipTest('One or more assets is not available')
> 
> 
> In the 404 case, the pre-cache step should fail and thus we shouldn't
> even get to running the test.
> 

This is not the behaviour I observe (error, with server returning 503) 
[1], thus my original email.

Maybe something is missing in the associated test, or in our test 
infrastructure?

Nothing funky in the command line used, you can reproduce it with:
$ rm -rf ~/.cache/qemu build/
$ ./configure
$ ./build/pyvenv/bin/meson test -C build --setup thorough --suite 
func-quick --suite func-thorough -t 5 --print-errorlogs func-ppc-ppc_40p

[1] 
https://github.com/pbo-linaro/qemu-ci/actions/runs/14747788692/job/41398348905

Traceback (most recent call last):
   File 
"/home/runner/work/qemu-ci/qemu-ci/tests/functional/test_ppc_40p.py", 
line 68, in test_openbios_and_netbsd
     drive_path = self.ASSET_NETBSD71.fetch()
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^
   File 
"/home/runner/work/qemu-ci/qemu-ci/tests/functional/qemu_test/asset.py", 
line 175, in fetch
     raise AssetError(self, "Download retries exceeded", transient=True)
qemu_test.asset.AssetError: 
https://archive.netbsd.org/pub/NetBSD-archive/NetBSD-7.1.2/iso/NetBSD-7.1.2-prep.iso: 
Download retries exceeded

> 
> With regards,
> Daniel


