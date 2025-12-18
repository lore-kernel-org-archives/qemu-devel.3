Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F114D68BED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Dec 2025 08:03:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vW8yv-0002Du-Kn; Thu, 18 Dec 2025 03:03:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vW8yo-0002DM-Fl
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 03:03:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vW8ym-0000Ei-Mp
 for qemu-devel@nongnu.org; Thu, 18 Dec 2025 03:03:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766044996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kwjjNxyg7PPyxDSY3txRUbxWrhbT7w6Nahp5wpTyZ3s=;
 b=RWuowsoTCOKkQz6+adn1dIzVAIHerpUGqlPseG3yRKOAV29Wp9TYwwLIQhTOlGgzCoJ5SQ
 +2NA6fcET04JtdqwYIufUU35qe8BCVESKlVTYTvonZXnfkgTMbl0lo04ChhIt4fxkTg3eq
 EzXz+F+Fs2lH7EPsnZU7H0UknfbGxL0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-526-lBjbOcTbOXyWzB0GuNgVgQ-1; Thu, 18 Dec 2025 03:03:14 -0500
X-MC-Unique: lBjbOcTbOXyWzB0GuNgVgQ-1
X-Mimecast-MFC-AGG-ID: lBjbOcTbOXyWzB0GuNgVgQ_1766044994
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-477a11d9e67so1586625e9.2
 for <qemu-devel@nongnu.org>; Thu, 18 Dec 2025 00:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766044994; x=1766649794; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kwjjNxyg7PPyxDSY3txRUbxWrhbT7w6Nahp5wpTyZ3s=;
 b=ZpXrlmvV0JHpNGBVNVWUefBeFxHd9/VRpq1KJGN/A6NnD4Ws/8Zw5Q5P6HtB+hCsC7
 188GLcjdKSxIyjua5i8LHaUsCG00aQFg9OMaY753rAUngCcGRNhCdZS+wogPf9kCW/Xi
 p330F3lauC/Pz2f2Mgs7mI+rLqVhD9YmLqtvOFjXnfRLvrNyi6T7PYsEXM1kjWPwIAqa
 vQdW7suJMwpVXuy5kjhTyTCwsYGIHAgvkO/4HePc0o6Nhvv8rS/MzkE7zpZbXTkah8m5
 gpEYXQQSbc6edRhsEzkehjFyAmC7X+Wc0Eutlmz2oWoXda50p8S7uH1cM8vu0fXwgHXS
 48SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766044994; x=1766649794;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kwjjNxyg7PPyxDSY3txRUbxWrhbT7w6Nahp5wpTyZ3s=;
 b=nPva8Aj4iHlGK6b9apW0w0C9Cwf7X9zYfBqzxIADeRqPg2eqgPH1MDMPFoMlTQKdPj
 gfujmryySaTFCbAkCYqrhnU8uLoWt57xfi6AeelXr/e5PHN2s+2tQeP6t65GmZA/wxe8
 26SnzOVRATQGPPwvEM16p0D5hQXwlOUWtHXPBQCvcBLMsWBMBT79GVYix9QQBBQ3ilXG
 q0x0PkGwJOoiMl/+efWRaaI7lk0IeYQKX/qtGR0GC9mCbVGUp0PCM02LLul/p5g5PBxj
 EEsFzRtwc84prxHngjk/1Fq+i4tGup73j9/ZvJBjM85MaiH+tp7QSgwim5vi4oq/skSn
 rITg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX17DkpQAS5C4ux+/m1C8wGbZvXMd/SBB+nCM/+VaTETCfqX8qIb3VK/u5kpyx4DWcr0cqsRGGqKhMo@nongnu.org
X-Gm-Message-State: AOJu0YyQ7V8xwrYAEqxqq9+Ro+9YiAxiuxHfV4afm5b1wRkD/KKqP0wO
 83CvdPIbVLFj5hHrZp/5fLTSkmXVwkfhAXthzwP0RkNAE/dJt0W2NSl0359qn7DO1F36bdL4fRM
 I3oAG28VIDHOkVb2S3zpJL3P0BdkeersTePdlMvj3RYsUclPtMjv37FsH
X-Gm-Gg: AY/fxX7weaYRNXP7Xz63tC10Kp32USVTILZfKuanAZ2o/z1hglsHwGhA20zbJhSeZDK
 L9xw6oLVsKnGVu5c+wrn1r/HNxbFX7vlw6OTD1q5edHjzytgUg9ErYSBjlPG2U5pXG81w+ehf5s
 hzHCRoo3Q2vbLW8ciboVYRT6ttTsA4FT789OoyoqkgY/XSO/vb8TYSa49P/dIFsAgVKpjFFgAfY
 dn90SlT3GZBx8jZ3dXblIgCZQaZLbtD3C5+Y3O0AHogj0Osf90FyYsDCLriJerN985zQ41d0cMW
 gH2/6+cM6rBIfBb4XCzGUTElkpc1/kzLOtWrdFJqhTsVlwsLR7CUyIGjDP2KIb8SvNVB3el0j8Z
 0F+dQnhw=
X-Received: by 2002:a05:600c:3b9f:b0:47a:7aa0:175a with SMTP id
 5b1f17b1804b1-47a8f90da0fmr235719425e9.26.1766044993613; 
 Thu, 18 Dec 2025 00:03:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFN2BZe/zN0tPgyngRBO/qqGkMu9ZNtV8CCwG5DVKx17LVvA3UV9/L9HHG4/4+xT3prpT9xUA==
X-Received: by 2002:a05:600c:3b9f:b0:47a:7aa0:175a with SMTP id
 5b1f17b1804b1-47a8f90da0fmr235719065e9.26.1766044993220; 
 Thu, 18 Dec 2025 00:03:13 -0800 (PST)
Received: from [192.168.0.5] ([47.64.112.241])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324493fe32sm3572517f8f.14.2025.12.18.00.03.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 00:03:12 -0800 (PST)
Message-ID: <dbfcbfff-b2fd-4c23-82da-ad9eed22a812@redhat.com>
Date: Thu, 18 Dec 2025 09:03:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Allow tests to be run individually
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20251216200555.4374-1-farosas@suse.de>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20251216200555.4374-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 16/12/2025 21.05, Fabiano Rosas wrote:
> The functional tests currently don't allow a single test to be
> selected for execution by dotted name, e.g:
> 
> ../tests/functional/ppc64/test_pseries.py PseriesMachine.test_ppc64_linux_boot
>                                            ^
> The issue is that the testcase.py main function passes the test
> module's name as the second argument to unittest.main(), which makes
> it ignore all other positional arguments (presumably because the
> module is already the superset of all tests).
> 
> After commit cac08383f0 ("tests/functional: expose sys.argv to
> unittest.main"), the situation improves by passing the rest of the
> argv from the command line invocation into unittest.main(), but it
> still doesn't fix the issue. The short form options are now accepted,
> so the -k option could be used to filter for a pattern, which is
> useful, but not the same as listing the test names.
> 
> Fix this by passing the test module name via the "module" argument to
> unittest.main() and stop touching argv. The ways of invoking tests are
> now as per unittests documentation (-k still works):
> 
>    Examples:
>      test_pseries.py                           - run default set of tests
>      test_pseries.py MyTestSuite               - run suite 'MyTestSuite'
>      test_pseries.py MyTestCase.testSomething  - run MyTestCase.testSomething
>      test_pseries.py MyTestCase                - run all 'test*' test methods in MyTestCase
Tested-by: Thomas Huth <thuth@redhat.com>

If you've got some spare time, maybe you could also add some words about 
running individual sub-tests to docs/devel/testing/functional.rst ?

  Thomas


