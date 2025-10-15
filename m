Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FE1CCD18E
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 13:48:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v91qv-0007rQ-AB; Wed, 15 Oct 2025 09:47:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v91qt-0007oV-Hl
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:47:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v91qp-0007Bp-1P
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 09:47:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760536051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=mABeTWsHuaxz3zG020Ydc5GeFWueJ48Yy/FbYxVq9nE=;
 b=ZKDhXQk7o6Vqn8iAXGPnAzzG9EJidejtiP2xuXGt3Sco4jJQeqTn0zEUTyCbay30C/3asa
 BPoKCZoov9TvI7uOEIs2otJfMCVU2lTE1ffutC5l+xpgbkGw2kTjgv2N1XRYcV51Ek+lZQ
 VhYEAj4iogye6/x2t8EePgsMDe2U6QI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-_3bEdKHDM7OW5HYWxO3hKg-1; Wed, 15 Oct 2025 09:47:29 -0400
X-MC-Unique: _3bEdKHDM7OW5HYWxO3hKg-1
X-Mimecast-MFC-AGG-ID: _3bEdKHDM7OW5HYWxO3hKg_1760536049
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-46fb328a60eso21545445e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 06:47:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760536048; x=1761140848;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mABeTWsHuaxz3zG020Ydc5GeFWueJ48Yy/FbYxVq9nE=;
 b=aljBJ2K4UYzZK7JyHZ0CL6m/Hzqhxaj/TQOMZyLHleLhk2SjLvEfwauhy++6SzBYCM
 zVVJ6nezEouFjWlK3fooKx/RTpI+/kNigXndcL6g7Ll3VoNgFIozOI/uU8bZVYcFYpLQ
 lgp31QcIFW9uhQsmSMD+oT9MahtsFErsYqBncinAOq9hjCoAoiWKaPu7FFZaZtTGB+1B
 xfTiNXsLQ2Kt6yS2cCwC8ZODsi3tj0xD7Jk+nHbyEZsuSzzzLV1YWvYaNAglw+/Bq+4J
 +Pmudc9bEUqE+affGKGpOh9LXbqaBTSjhSJ+HCtKWomTuFxHHV+rkpYcwIXaf20X1z+q
 xy8Q==
X-Gm-Message-State: AOJu0YxU9gJw5V/69MbhHnc3F3I1N2kuz8LlH1DB9G6yS/osk76RAO6y
 NGxBUFBNY1Ul4wFFD7LMrvmGfJHDLv59ELKf3Io3YKC7W2Bup4UA5Sy0tEBpAWJivIk0j4NFIpN
 YQuM0UhUfPeURvMMwtKjO2ASqFgfNvw4IE1gl1mRy3IYpOaSIVYGMuXWW
X-Gm-Gg: ASbGncsFNIQJoRiKzREaUh+EJwzquvqebSLpgSt2jmxqrsxZ0zbxclJ6ucnuXBrkmle
 MLKrMck8Qy2gr8EBfY5kq6r3aaEp65beXoeIrUoe7MdBj5W95XM5R9+nO8H+yx9JCQFEz0jNtXx
 T8sqmEX1AAfG+qyvEU6uXBYtIT/OcPYZUAnWgzVd1qd4lHpscuhw1OJWyoJCiXtcv98S+scEkCy
 ay0YAdGo3sFeXueGvSRpKO99e1oLWUaUeeN2tGCUiMcDxPX8Y3W5DtVLIJ51B+m1hZolu6WOiQv
 2RGebqCjc4lYMH2rAuf/mPFbnIt9wHv5zFg9IERRihcJLKgJytRVhtbuGCi85QX+qxllVv8Jrb6
 7LxXSFQ==
X-Received: by 2002:a05:600c:34c7:b0:46f:d723:3b17 with SMTP id
 5b1f17b1804b1-470fc0465fcmr38596385e9.6.1760536048650; 
 Wed, 15 Oct 2025 06:47:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDwxNlpjjZnjXaBPX+rh3H3TyCKOxd2b+sE4sdvOpHsa8FboQcusPIB03MC39Eg1aO6xvx1g==
X-Received: by 2002:a05:600c:34c7:b0:46f:d723:3b17 with SMTP id
 5b1f17b1804b1-470fc0465fcmr38596015e9.6.1760536048169; 
 Wed, 15 Oct 2025 06:47:28 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-112-136.pools.arcor-ip.net.
 [47.64.112.136]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47101c23a52sm28001495e9.12.2025.10.15.06.47.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 06:47:27 -0700 (PDT)
Message-ID: <507917da-519f-431d-ab30-3b24b7173471@redhat.com>
Date: Wed, 15 Oct 2025 15:47:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] tests: rearrange suites for I/O tests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
References: <20251008113552.747002-1-berrange@redhat.com>
 <20251008113552.747002-3-berrange@redhat.com> <aO4JSRfDAn6Jq7Hn@redhat.com>
 <aO-lVDVKWEVMeasR@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <aO-lVDVKWEVMeasR@redhat.com>
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

On 15/10/2025 15.44, Daniel P. Berrangé wrote:
> On Tue, Oct 14, 2025 at 10:26:49AM +0200, Kevin Wolf wrote:
>> Am 08.10.2025 um 13:35 hat Daniel P. Berrangé geschrieben:
>>> Currently there are 5 block formats, each classified as either quick,
>>> slow or thorough. This classification then determines what tests we
>>> add to meson suites. The suites are as follows
>>>
>>>    * block
>>>
>>>      => tests listed by 'check -g auto -n' for 'quick' formats
>>>
>>>    * slow, block-slow
>>>
>>>      => tests listed by 'check -n' for 'slow' formats or 'check -g auto -n'
>>>         for 'quick' formats
>>>
>>>    * thorough, block-thorough
>>>
>>>      => tests listed by 'check -n' for 'thorough' formats
>>>
>>> The pairs of suites 'slow' / 'block-slow' and 'thorough' / 'block-thorough'
>>> match in terms of what tests are enabled. The only difference is whether
>>> non-block related tests are also in the suite.
>>>
>>> There are two problems with this
>>>
>>>   * If a format is classified as 'quick', we don't expose any
>>>     meson suite for running *all* tests, only the 'auto' tests.
>>>
>>>     eg there is no suite to run all qcow2 tests, only 'quick'
>>>     tests can be run via meson, even if using 'SPEED=slow' we
>>>     still filter to only 'auto' tests.
>>>
>>>   * There is no suite that allows running all tests for a given
>>>     format.
>>>
>>>     eg there is no suite to run only 'raw' tests - you can only
>>>     use 'block-slow' which runs both raw and "auto" qcow2 tests.
>>>
>>>     eg there is no suite to run only 'vpc' tests - you can only
>>>     use 'block-thorough' which runs qed, vmdk & vpc tests.
>>>
>>> This patch suggests that 'block-slow' and 'block-thorough' are
>>> not actually compelling use cases, and should be dropped. ie it
>>> is not expected that people need to run all VPC, VMDK and QED
>>> tests at the same time. Instead a more useful feature is the
>>> ability to run all tests for a given format. Further the 'auto'
>>> filtering should only apply in the default 'block' target/suite.
>>>
>>> IOW, with this patch we get the follows meson suites:
>>>
>>>   * 'block' - 'auto' tests for any format listed as 'quick'
>>>               Currently just qcow2 'auto' tests
>>>   * 'block-$FORMAT' - ALL tests for the given $FORMAT, for each
>>>                       of qcow2, raw, qed, vmdk & vpc
>>>   * 'slow' - ALL tests for formats tagged with 'quick' or 'slow'
>>>   * 'thorough' - ALL tests formats tagged with 'thorough'
>>>
>>> This corresponds to the following make targets.
>>>
>>>   * 'make check-block'
>>>
>>>      => runs only 'auto' qcow2 tests  (unchanged)
>>>
>>>   * 'make check-block SPEED=thorough'
>>>
>>>      => runs all 'qed', 'vmdk', 'vpc' tests (unchanged)
>>
>> Also all qcow2 and raw tests, right?
> 
> Sigh, I made a mistake here, this should read:
>   
>    * 'make check' / 'make check-block'
>   
>       => runs only 'auto' qcow2 tests  (unchanged)
> 
> The 'make check-block SPEED=thorough/slow' feature was removed
> on the basis that running all targets at once is not that
> useful, instead the 'check-block-$FORMAT' targets are
> replacing it. IOW the meson 'block-slow' and 'block-through'
> suites are gone.

Can we still run all tests (i.e. iotests, qtests, unit tests and functional 
tests in parallel) at once with a simple "make check SPEED=thorough" ? If 
not, that would be a regression for me.

  Thomas


