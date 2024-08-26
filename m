Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34D82C5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 08:19:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siUwG-0000HF-3e; Mon, 26 Aug 2024 04:19:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1siUwC-0000FK-SQ
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 04:18:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1siUwA-0003pp-7X
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 04:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724660331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VL9iwBunfbUdjp7rBq57qadG7ag2mHVt2wNeas22a/4=;
 b=NSlTIKGkbfcaIqkcqnNnyx7RD5mZxqWyrpj75BJxvuheuWPeGYjW1byRsxU9AuGFAzF6N2
 GHxYUynCy4POficdYRpkYUfU2VC431B7T19wNUU8tk+PUqEAHBCkc92uQOPLdq9DVr0Yzj
 5+GWgInQyPI/X2Ui/NI7Lk0r0YgFTPg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-NDXnROhPPKutkAem5_R9jw-1; Mon, 26 Aug 2024 04:18:49 -0400
X-MC-Unique: NDXnROhPPKutkAem5_R9jw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6bf7cd59d92so51037086d6.0
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 01:18:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724660329; x=1725265129;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VL9iwBunfbUdjp7rBq57qadG7ag2mHVt2wNeas22a/4=;
 b=wG63ep5vWBEdsD/5dN0IbREwhsLN1Vj8pDiFbM9ysGW3rl/+sFxbmpl1KehMCZ+WHY
 2yEHv1sn3zO/9+YMNSIKJnve1LuwnMdwNBZw+ie+rH04Y8PJqnsTwhpR+YiOpGmxif7k
 oNCmC3Q8WYrmXdW6nSDN8g+GEkQVg6d7AQxTIQ6epAUcLbQZZAc2u3XEjvUReZ2QlKUJ
 g7AH3gme+nbqFu30DKAbIFLoXo6QBe3NJEnT9y0CKkz+5tFJgHHDKJO1KsLoa3mn/IBu
 yHifEUGdKRVGqyi6RJlMI8innJlKr3ZBFrQ1M1/g70pmX9hGFMpSEVICqPtmXlEcBPrT
 OBmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHswH2FueOLmMhP4C1rS/8WEJGkx97YEufFhKAKoIT3TvpjwhbcHwvpg6Xekz4+cjuGy5/ex//yNxg@nongnu.org
X-Gm-Message-State: AOJu0Yx/OoQIHymbCeuOuxKbf/XogixNZvJqqpTd0lqC+M1g47ETMAPg
 4eEdIwONswvSo0DDWmBp60W6ON06HkhszZGVxnkj19GZb7brAI9MDpiIRtCgGAZjI700oLheS6v
 PIgpejwVpfAXVlXbQMIMuQtDefa9M7oAmV1GcDkdtqLmdlOfjpjD9
X-Received: by 2002:a05:6214:5d0a:b0:6b7:a4dc:e24a with SMTP id
 6a1803df08f44-6c16deef452mr93854496d6.54.1724660329108; 
 Mon, 26 Aug 2024 01:18:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHa1aGJ29CE8huitJieUB1nsHEnjMXllwi02RxOFTAewMeo599JC/Vo44RD0zJROUz8DMr+kw==
X-Received: by 2002:a05:6214:5d0a:b0:6b7:a4dc:e24a with SMTP id
 6a1803df08f44-6c16deef452mr93854246d6.54.1724660328637; 
 Mon, 26 Aug 2024 01:18:48 -0700 (PDT)
Received: from [192.168.0.6] (ip-109-43-177-41.web.vodafone.de.
 [109.43.177.41]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162d4960bsm44440946d6.30.2024.08.26.01.18.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 01:18:48 -0700 (PDT)
Message-ID: <b60d967a-6d87-4dfa-9ed5-da547be453a4@redhat.com>
Date: Mon, 26 Aug 2024 10:18:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/35] tests/functional: Prepare the meson build system
 for the functional tests
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
References: <20240821082748.65853-1-thuth@redhat.com>
 <20240821082748.65853-12-thuth@redhat.com>
 <4b4018c6-4a2b-4250-bb53-be9cc5df7cb4@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <4b4018c6-4a2b-4250-bb53-be9cc5df7cb4@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 23/08/2024 14.54, Philippe Mathieu-Daudé wrote:
> On 21/8/24 10:27, Thomas Huth wrote:
>> Provide a meson.build file for the upcoming python-based functional
>> tests, and add some wrapper glue targets to the tests/Makefile.include
>> file. We are going to use two "speed" modes for the functional tests:
>> The "quick" tests can be run at any time (i.e. also during "make check"),
>> while the "thorough" tests should only be run when running a
>> "make check-functional" test run (since these tests might download
>> additional assets from the internet).
>>
>> The changes to the meson.build files are partly based on an earlier
>> patch by Ani Sinha.
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tests/Makefile.include       | 11 ++++++
>>   tests/functional/meson.build | 66 ++++++++++++++++++++++++++++++++++++
>>   tests/meson.build            |  1 +
>>   3 files changed, 78 insertions(+)
>>   create mode 100644 tests/functional/meson.build
> 
> 
>> +# Timeouts for individual tests that can be slow e.g. with debugging enabled
>> +test_timeouts = {
>> +}
> 
> 
>> +    foreach test : target_tests
>> +      test('func-@0@/@1@'.format(target_base, test),
>> +           python,
>> +           depends: [test_deps, test_emulator, emulator_modules],
>> +           env: test_env,
>> +           args: [meson.current_source_dir() / 'test_' + test + '.py'],
>> +           protocol: 'tap',
>> +           timeout: test_timeouts.get(test, 60),
>> +           priority: test_timeouts.get(test, 60),
> 
> IIUC with Avocado the timeout was for each test_func in a TestClass.
> Now this is only per TestClass. Hopefully I'm wrong...

I think you're right ... we might need to adjust the meson timeouts here and 
there in case they are causing problems, but that's just business as usual 
(we had to do the same when enabling the meson timeouts for the qtests for 
example).

  Thomas


