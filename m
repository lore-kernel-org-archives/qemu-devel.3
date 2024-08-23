Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A36C531DC
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2024 12:55:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1shToT-0006Im-9f; Fri, 23 Aug 2024 08:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1shToP-0006Hf-OE
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 08:54:42 -0400
Received: from mail-qv1-xf2c.google.com ([2607:f8b0:4864:20::f2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1shToO-0004sJ-4k
 for qemu-devel@nongnu.org; Fri, 23 Aug 2024 08:54:41 -0400
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-6bf7658f4aaso9313996d6.0
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2024 05:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724417678; x=1725022478; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wbys7aSbUEeoFbo2CczsEvIqae23lK3FB+T/gbx3lhg=;
 b=YIa8U5Y1NC+3wkYE8rCSRGLKRImMzASu+lVNs09QWfbyhd7BR6832PFEN5efd7v7EE
 Zgqc75iFNXrFCRBnJcNh+yleBg5ltL4nRJXkI9AurA1tGiLPRdUWEg9XCCJzbqDeI2+t
 4//3qLGbPHuFyhkEOKVrBswXg3XW4im5p6OStZOAHysGRnYx8AEpbD9Q+Mx528RYG5i5
 vXNalnhw8oxDWNSLxzZ9kDPLqYZG/JsZvHNkMMr9VjnkrR5HRNqtGXHqXuuMCvieAAAG
 C1V13DKhefRrs54jIlu6vq8e8QKlOnY7vn4jR0Boy1yhI1LnYfGedPT0sLE70jJXlJ1c
 yMvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724417678; x=1725022478;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wbys7aSbUEeoFbo2CczsEvIqae23lK3FB+T/gbx3lhg=;
 b=G9NKIYEQZqOb43eyZgH6LaUjK4i6NDO2YeBrS+8WtS/0sNlcOAJDUIjTkTdJvg/vPu
 VoznmHg9J+vldyaAGQsdNeT/dJlv2XFaBVy7R4CDotsyL6g80onnVCA1ndBOtmsJof94
 v/X20HlDYpaaKCkyxiTHGw/7e0gcCyhfVHQmYvRNXCBPIRxg/bMKY0ll64lC256wTW7P
 IqGrMBNTYXNCgPiPDf8MF1SFPbVgrbKb8uOwcP/4WWy/eVvdZdS/XVGbOvwDRzTd1GPb
 8vQuS1siMrobOmRW1xuIXV/aEtXbvwwQn5RGkBpE6x8/zjWFE41jOT7udk8LOuLrcNK8
 WzZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgzFagcs/wfizC0DZK0sNKnYo6kYIdI0OvaJVHmYEoVr4HP397ciOq6ppCGwd8rMnBr0fqZrXSoLEi@nongnu.org
X-Gm-Message-State: AOJu0YwX1iH53HT4Xm982Y67G7/qxY3fCL2CgwFUGc2CYu8ROqh+XDP4
 5iGWtmBrfTpeXd8JfTKq9mO6RtdiTmctqZNIMHA0+dcVXLe328WVJ1mHKg04Giw=
X-Google-Smtp-Source: AGHT+IHF1wQgCsJOMhvB3lyaRLeHRnz7bvbKPrCmwArZGmFYl6pDL8a5xnujPMBBd61yD+7XR2b7fg==
X-Received: by 2002:a05:6214:3281:b0:6b8:1936:9061 with SMTP id
 6a1803df08f44-6c16decbf60mr23795516d6.52.1724417678328; 
 Fri, 23 Aug 2024 05:54:38 -0700 (PDT)
Received: from [192.168.69.100] (plb95-h02-176-184-14-228.dsl.sta.abo.bbox.fr.
 [176.184.14.228]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162d1d25bsm18319296d6.3.2024.08.23.05.54.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Aug 2024 05:54:37 -0700 (PDT)
Message-ID: <4b4018c6-4a2b-4250-bb53-be9cc5df7cb4@linaro.org>
Date: Fri, 23 Aug 2024 14:54:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/35] tests/functional: Prepare the meson build system
 for the functional tests
To: Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
References: <20240821082748.65853-1-thuth@redhat.com>
 <20240821082748.65853-12-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240821082748.65853-12-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2c;
 envelope-from=philmd@linaro.org; helo=mail-qv1-xf2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 21/8/24 10:27, Thomas Huth wrote:
> Provide a meson.build file for the upcoming python-based functional
> tests, and add some wrapper glue targets to the tests/Makefile.include
> file. We are going to use two "speed" modes for the functional tests:
> The "quick" tests can be run at any time (i.e. also during "make check"),
> while the "thorough" tests should only be run when running a
> "make check-functional" test run (since these tests might download
> additional assets from the internet).
> 
> The changes to the meson.build files are partly based on an earlier
> patch by Ani Sinha.
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/Makefile.include       | 11 ++++++
>   tests/functional/meson.build | 66 ++++++++++++++++++++++++++++++++++++
>   tests/meson.build            |  1 +
>   3 files changed, 78 insertions(+)
>   create mode 100644 tests/functional/meson.build


> +# Timeouts for individual tests that can be slow e.g. with debugging enabled
> +test_timeouts = {
> +}


> +    foreach test : target_tests
> +      test('func-@0@/@1@'.format(target_base, test),
> +           python,
> +           depends: [test_deps, test_emulator, emulator_modules],
> +           env: test_env,
> +           args: [meson.current_source_dir() / 'test_' + test + '.py'],
> +           protocol: 'tap',
> +           timeout: test_timeouts.get(test, 60),
> +           priority: test_timeouts.get(test, 60),

IIUC with Avocado the timeout was for each test_func in a TestClass.
Now this is only per TestClass. Hopefully I'm wrong...

> +           suite: suites)
> +    endforeach
> +  endforeach
> +endforeach
> diff --git a/tests/meson.build b/tests/meson.build
> index 80dd3029cf..907a4c1c98 100644
> --- a/tests/meson.build
> +++ b/tests/meson.build
> @@ -85,3 +85,4 @@ subdir('unit')
>   subdir('qapi-schema')
>   subdir('qtest')
>   subdir('migration')
> +subdir('functional')


