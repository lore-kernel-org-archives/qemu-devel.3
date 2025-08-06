Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6D3C87FCB
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Aug 2025 07:34:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujYej-0001SS-Ho; Wed, 06 Aug 2025 03:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujYeg-0001QU-Hx
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 03:33:46 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ujYee-0005ax-BT
 for qemu-devel@nongnu.org; Wed, 06 Aug 2025 03:33:46 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-459ddf8acf1so19041075e9.0
 for <qemu-devel@nongnu.org>; Wed, 06 Aug 2025 00:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754465622; x=1755070422; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MDXt8hiJNiCikqs/DNNUeXOi9aIDDwzfHoOQe8f5FCc=;
 b=U8BkXDApK/vxbk2xkXxifbEOrMYHJDjx5+JOu53xs5ezchyfax2P2wci84sKO0GaDe
 RkbaDyG3uKzjuPexCZPCJ57HTE1suuK2LBmVcJQ4jM45FqtU0fXSXhcQ9JsHZrnMCj72
 Y/PoSu7nWM+dExHL10g4Hfwz7EryEkWLRc2spFDr2PeNZbNZJJJBj+Vfo42aeaTnTL9m
 sNXkWPElt7aoOVyqDFOzDhhkc3mLqti6b4m/sPI4YP4j19Xyx0q1hwcghWH+onKLzdF+
 70yAZzbWctWInPY+eIVyPBRwqbTkXgO2xgYlqRr8tbps8wBJSMKhCBySd/y77WmEEMmo
 lVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754465622; x=1755070422;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MDXt8hiJNiCikqs/DNNUeXOi9aIDDwzfHoOQe8f5FCc=;
 b=WZBEHO9SMqpZ+pxvdl2CI3UqS16oW5uQDsbTkT4gqPseMmhp7jW766tQF5TNDnX0N4
 xFeZvNEdaJVWP4din0fpy/MVPs/KO+44SLveP9HuexEd4CpZDukki+4BJ6BRhyTdBIvY
 dX6mPFmPVzoLF2DgbHBYTaup0FvXDCbhinqrkqtIOkyxHoGpkBN9m6iW/KCpX4MF9z+Q
 pCizWMctgbhvdwR3LutjSOuqiS7j2CJJYXybOMSUOTIwWEnrFIza4TJp0c0B87C8d0tc
 kstLg495ZjOB6MwyaZ9KELLN3+/wewKxOyT9fuVozu6WiUpVn+1686MtR11lIdPZg5AV
 irZg==
X-Gm-Message-State: AOJu0YysBziMolCv0aOaHT9Fpsk168MVZNmd3Clq7NmZK8VuCT9YB4KZ
 uWcaOoreGSMSK+lw4Y/OE3DZCg6MjOujB/gW/NiC2MHzYY68hOjUBngStqOLtXb0+98=
X-Gm-Gg: ASbGncvYeNNvGd53WQ5roCQiChis//EdGOo+nGQz05BLhz3HNUUwJ7MMVPd5kwetrf1
 kfSq/+td+7YdbCSeZ5+HCDp6d9rnc2oxxUXojR+SkbQTW3myKiPz6mtdUKIpKKY86NISFzGBORA
 ABZ30yC2WZOWP1coCgZVnowSH+lYVf5VWYNL1J2DtO+e8p/8yWLxgCMTAmDfZC9DIYgJ8fKn9c5
 dDTEQ3X/RxN+gflFarT8hD4u3Zl8jSSnXmQxC4ip0S8tfndc6joPFOo8Ju+/m0Am3w6kdKrStCo
 YAKNBtIaRiuvL4V5X+UFtzox48BZx9rGuihuCCIWreD/1NX4xeBbFp28yLcZmIMMt4mY9ko1cQe
 XCyFohCL0SOFsJE70nKMDetzB0/qjJeNLziTa9dS6juwhZ6pp/sAyJiSJ0+wRazMGGA==
X-Google-Smtp-Source: AGHT+IEyQEogh0sVItHVkhtL29dgka4/FvE41aPZg0+flWwbg8up5Jy10zvM8bA9EvSmR23QXUxJaQ==
X-Received: by 2002:a05:600c:5494:b0:456:27a4:50ac with SMTP id
 5b1f17b1804b1-459e70e6952mr11674695e9.23.1754465622233; 
 Wed, 06 Aug 2025 00:33:42 -0700 (PDT)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-459dcb86d6asm94696645e9.5.2025.08.06.00.33.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Aug 2025 00:33:41 -0700 (PDT)
Message-ID: <0270c97f-2c26-477d-bb22-9f67059ad72a@linaro.org>
Date: Wed, 6 Aug 2025 09:33:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1] tests/qemu-iotests/tests/mirror-sparse: skip if
 O_DIRECT is not supported
To: Kevin Wolf <kwolf@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Eric Blake <eblake@redhat.com>, qemu-trivial@nongnu.org
References: <20250801122850.27632-1-mjt@tls.msk.ru>
 <7893945e-6287-4f32-9e93-f28c39c7bdc8@linaro.org>
 <4f0a804d-d448-4dc0-97e1-20b3f669c8a2@tls.msk.ru>
 <aJMEeVr1BU-abnNb@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <aJMEeVr1BU-abnNb@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 6/8/25 09:30, Kevin Wolf wrote:
> Am 05.08.2025 um 19:56 hat Michael Tokarev geschrieben:
>> On 05.08.2025 20:23, Philippe Mathieu-Daudé wrote:
>>
>>>> diff --git a/tests/qemu-iotests/tests/mirror-sparse b/tests/qemu-
>>>> iotests/tests/mirror-sparse
>>>> index cfcaa600ab..19843a622c 100755
>>>> --- a/tests/qemu-iotests/tests/mirror-sparse
>>>> +++ b/tests/qemu-iotests/tests/mirror-sparse
>>>> @@ -41,6 +41,7 @@ _supported_fmt qcow2 raw  # Format of the source.
>>>> dst is always raw file
>>>>    _supported_proto file
>>>>    _supported_os Linux
>>>>    _require_disk_usage
>>>> +_require_o_direct
>>>
>>> Could the correct use be:
>>>
>>>     _supported_cache_modes none directsync
>>
>> Yes that works too.  I've no idea which is "better" - we've
>> a bit too many options here, I think.  I'll change it to your
>> suggestion.
> 
> No, _require_o_direct is better because it directly checks if files in
> the scratch directory support O_DIRECT, which is what we need here
> because the test unconditionally opens the file this way:
> 
>      -blockdev '{"driver":"file", "cache":{"direct":true, "no-flush":false},
>                  "filename":"'"$TEST_IMG.base"'", "node-name":"src-file"}' \
> 
> _supported_cache_modes is about the cache mode requested on the command
> line when running qemu-iotests, which is not what we're interested in.
> The relevant call doesn't even consider the command line option. It
> still "fixes" the failure because requesting "none" or "directsync"
> makes it do the O_DIRECT check, too.
> 
> But the effect is different: With "_supported_cache_modes none
> directsync", the test will always be skipped if on the command line
> "writeback" was requested (it's the default, so we'll skip the test by
> default - that's a bad idea). With _require_o_direct it will only be
> skipped if the filesystem really doesn't support O_DIRECT.

Oops, sorry for the bad suggestion :/


