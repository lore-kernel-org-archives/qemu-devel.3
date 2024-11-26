Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C88D65538
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2024 17:53:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFzkZ-0004Xr-J5; Tue, 26 Nov 2024 12:53:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tFzkP-0004XG-86
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:53:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tFzkI-0003fU-Gx
 for qemu-devel@nongnu.org; Tue, 26 Nov 2024 12:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732643583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7jgxlVheYSQwo2aCD18s8SzMh3LYfDJ0Kj4wbmLLr7Q=;
 b=MNnTx8ulovvUdIIHBPl9po1l5jGniLST9rKgDQBXF5HaySQOjbfvM4m2qnuKfbfD3niXZq
 E3Q3zeiAObcPKTjsln9EaRlhXM2p/G+Kr5Qbkri0R5nGs6fX7MADT5AIDO3nshVIBcyy+W
 RkdLsz68u+MngQeIIMZRVn7JZL3JTr4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-E5qSu68uMLSRY2MXdMBXvg-1; Tue, 26 Nov 2024 12:53:02 -0500
X-MC-Unique: E5qSu68uMLSRY2MXdMBXvg-1
X-Mimecast-MFC-AGG-ID: E5qSu68uMLSRY2MXdMBXvg
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-aa53116660fso269166566b.1
 for <qemu-devel@nongnu.org>; Tue, 26 Nov 2024 09:53:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732643581; x=1733248381;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7jgxlVheYSQwo2aCD18s8SzMh3LYfDJ0Kj4wbmLLr7Q=;
 b=rGSn4gWu6fBc2P92PyNMYyc0i1WjdMsTIErduYMaDI2pNXHNeVvcxKNALFVaJH+fCN
 9p4QxRzhnHAqfp13bRCpuqQCROMDIGh/tKhaMfTK0DXofeLMHdwlvwp1UazFxRXzGOqr
 98jHTArspx2cRyVMVyPbbJDMOc3v/MctOI7GtjRZ2vF2jENztWuxvHTsJY50RoQYvQ+Q
 A+zTywlmfqnZ9c0l1BYxn3pHaC4MuKYJ05U0BZ0cAvjk1AJ0TDEkQkAr+ri+bOzpnycl
 2/GYhE6As6RijowHuSQRJiy4ftyx6CxJmv+i68ZZQfgMyQDfBLJDAMZVhTs3ssV0WicV
 R5Ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2xkVth1DFHlJXWAiAK4hr+jz+MgIQKqcW1n0dG0MkcMxLFx+SiJExu0SWDMdwganTDE6FHlGBJuEp@nongnu.org
X-Gm-Message-State: AOJu0YycXlf1d5/dqOZ72VNE0MnE9EX1ftWgGtcx2+arMNYF5pZw/XIl
 2hYg3RGG0UlSNp9IUiqg3g+jRrxuRggdTximds2ZJItl0Y/SuSD7Jg+yfQ5Et0BQmQ+fs+G6jJ7
 cJD+69Bd3VhlK5OaIuu79bj/UglceUK3Yeczhm74MgJXZFvnpv3QW
X-Gm-Gg: ASbGnctUBy3YGes3rLSo9xkYvyL9ekxnRMaQS0CyAy3v7irKd0ijReJf3TLqncAZMHT
 MdX8D+7xOe3MwBRhtZ4R1w8G615u+UK8H8oxN1gsmoADWyW38Ybcf5TGBcfFMdsm3pTwZW2pJKj
 7NMFIASi6OUtTylsJtLxPttSkGWpyzi5XoHuWuqKIpCK7prlMgju9nT23A93SvRLdu44W6D0pDX
 Z/d2mYmXSJrghkZBrm+qszdluUTFhV5yzkm/ba00MD0YIG4nJ0Jo6/lIzJIHZ/Vd2VR0UVBntu0
 sOKgFA==
X-Received: by 2002:a17:906:2182:b0:aa5:3853:5536 with SMTP id
 a640c23a62f3a-aa5385357camr997215066b.46.1732643579600; 
 Tue, 26 Nov 2024 09:52:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+E99r3NtWtv/eHq0/GvYQG8Qz26+x8ChVa8cZmbIJSCgoHtldaH60Wyo/27xJGYSooqs/qg==
X-Received: by 2002:a17:906:2182:b0:aa5:3853:5536 with SMTP id
 a640c23a62f3a-aa5385357camr997214266b.46.1732643579219; 
 Tue, 26 Nov 2024 09:52:59 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-48-143.web.vodafone.de.
 [109.42.48.143]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa54afde284sm330219966b.17.2024.11.26.09.52.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Nov 2024 09:52:58 -0800 (PST)
Message-ID: <8ff5ef91-1a4b-498e-a948-37444d699f94@redhat.com>
Date: Tue, 26 Nov 2024 18:52:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 15/42] tests/functional: enable pre-emptive caching of
 assets
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Camilla Conte <cconte@redhat.com>
References: <20240904103923.451847-1-thuth@redhat.com>
 <20240904103923.451847-16-thuth@redhat.com>
 <66bf4784-f1e4-479f-83db-2d4f91c10e48@linaro.org>
 <Z0YF9i2pwBkznkCD@redhat.com>
 <CAFEAcA-ematCTyj0SN2=e3mGHvp0VWjN1GV-Tu5Rkf-V721L1w@mail.gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA-ematCTyj0SN2=e3mGHvp0VWjN1GV-Tu5Rkf-V721L1w@mail.gmail.com>
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

On 26/11/2024 18.46, Peter Maydell wrote:
> On Tue, 26 Nov 2024 at 17:31, Daniel P. Berrangé <berrange@redhat.com> wrote:
>>
>> On Tue, Nov 26, 2024 at 05:44:29PM +0100, Philippe Mathieu-Daudé wrote:
>>> Hi,
>>>
>>> On 4/9/24 12:38, Thomas Huth wrote:
>>> fetch() can fail [*] (see previous patch, various Exceptions returned).
>>>
>>> What should we do in this case? If we ignore a missing artifact,
>>> the tests will eventually fail. Better bail out early and save
>>> credit minutes?
>>
>> We already do what you describe - 'fetch' will raise an exception
>> which causes the precache task to fail, and the CI job gets marked
>> as failed. We don't attempt to run tests if assets are missing.
>>
>>
>>>> @@ -58,6 +59,12 @@ def tearDown(self):
>>>>        def main():
>>>>            path = os.path.basename(sys.argv[0])[:-3]
>>>> +
>>>> +        cache = os.environ.get("QEMU_TEST_PRECACHE", None)
>>>> +        if cache is not None:
>>>> +            Asset.precache_suites(path, cache)
>>>> +            return
>>>> +
>>>>            tr = pycotap.TAPTestRunner(message_log = pycotap.LogMode.LogToError,
>>>>                                       test_output_log = pycotap.LogMode.LogToError)
>>>>            unittest.main(module = None, testRunner = tr, argv=["__dummy__", path])
>>>
>>> [*] Peter reported the following CI failure:
>>>
>>>    https://gitlab.com/qemu-project/qemu/-/jobs/8474928266
>>>
>>> 2024-11-26 14:58:53,170 - qemu-test - ERROR - Unable to download https://apt.armbian.com/pool/main/l/linux-6.6.16/linux-image-current-sunxi_24.2.1_armhf__6.6.16-Seb3e-D6b4a-P2359-Ce96bHfe66-HK01ba-V014b-B067e-R448a.deb:
>>
>> This looks to be working as intended. We failed to cache
>> the asset, and so we stopped the job, without trying to
>> run the tests.
> 
> The job ended up in state "failed", with a red X mark in
> the gitlab UI. If we intend that not being able to fetch
> the assets doesn't count as a test failure, that didn't
> work here. If we do intend that fetch failures should be
> CI failures, we need to make our process of fetching and
> caching the images more robust, because otherwise the result
> is flaky CI jobs.

I think we want to continue to maek failing downloads as test failures, 
otherwise we'll never notice when an asset is not available from the 
internet anymore (since SKIPs just get ignored).

What we really need is a working cache for the private CI runners to ease 
the pain when the host just has a networking hiccup.

  Thomas


