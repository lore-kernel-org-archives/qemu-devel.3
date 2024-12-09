Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D86FE77180
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 18:26:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKiSF-0001Nf-0C; Mon, 09 Dec 2024 13:25:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tKiSD-0001Mb-8e
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 13:25:57 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tKiSA-0006F9-Ik
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 13:25:57 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-724ffe64923so5380091b3a.2
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 10:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733768752; x=1734373552; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5sc/zlzqr4yLfdRPh4w1mTJtVEwOYGR3gVEEm/MVuu0=;
 b=kZt5wHY+aCjUdWQxvCslTPAbe03wq6p7Dj6GiEgjF/cWULIuO4L/UHBpWjqVhsGkeM
 rwYNfLIpY+AoO/3aaRJ1+DjdoDazVpJfA29bJtFSP0wMfpKAemu19KsKyEzU5mFb1RDw
 20sgbofl/DdpJzp/3x6RC5rVZu+zBM/FuTyb40cIU+A/w8R7K45vLUacDpEcpTd2kBId
 8X4aMqfX7QAOSrmQ1OoH+514l+T2REJZB25cSxtH8UJN3Lx9K2eEAOJM0WIXpJCjCM+6
 V+qBOc7W6MqyCsbPZJ950e0uceT4OOx80CmL+iv3YoiDUnSZqdGC/xRQ/BFlbNrQHEef
 E8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733768752; x=1734373552;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5sc/zlzqr4yLfdRPh4w1mTJtVEwOYGR3gVEEm/MVuu0=;
 b=wwLD/nRSDHwNcdh+F1geRdttlo5NrRO5u3Fdrs5AaqS2HSy4dkvdKF2lnB52XzCqcn
 7uF8FhLby9SAIVntbImcsV164v+s8iGqX/RJK/FNvWDlhvcA8dkuujeUtsq1LCveZSqF
 wr0utjMUyXGYiDCj6NE71e3YHKSdyEF4tGfz214DmHetXFxh6Q5yS2Z8I653XV6/O1z1
 dcfm207VNCIjBD0qQ8D2Knz67yCQO3U6DTBiE20wF8cehb0yESPYNCdo8hIo1ZfcDx0o
 w2Axmko49TvJDVELqi7iJwAXwlc00NrbacKAqR8t1Xp2iehaKqJVg3FV1LI0CCulOyUZ
 vKXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhr1CNnJrWLJHEWXQjho+Tf4pERzkA8aJWTS2CVsuN6OHK8UQrSdheuUcRMESx7G8V5ADCO/Y5gEL4@nongnu.org
X-Gm-Message-State: AOJu0YykVNaWSK83TXTcuPuMZVlXRso8YYT6WsKUKQ/JtCUtEnXF92MX
 m6l+MRhqwSDfGuyk4xlOItPyYFy8RjTsxBC4lOVdSPmtBQH6oD+DHfxiX+GSSdg=
X-Gm-Gg: ASbGncuGViDODh7aD5eRq2RZAGU1LyI/vaiSQ5YUBurgHeSm4aAC6QKl2UJ63a9YsfG
 uvdRiE/0X+2fICQiTIChasD+GBEaPUIHo7jH+Cof3SIJvRPQZv6vgme7O5sDnIP0DBMrJzWsnrt
 qSoK6ur6ja/PdVMt2GnbwPjBSJnx4RbJIHLOzmzhPGOgHPIsXS6GmPuoFovRVu0CZbyyrBGc9qk
 WqBMFmI0PoJhnq/+MMONUzQ4BVsmUh+i/C2TcdNlnO6KKkaUqyNdTTaM0KPbc8Z8sTlMdQ5AvK+
 4+9kgWzW5QjSTCudQ58zARBm7g==
X-Google-Smtp-Source: AGHT+IGtzqsCPU6jEkieD7TImWgDFXGHxos/m9EMy/BwHyTvUj+KviItTSKuNWYAQSTT/PPY59iRRQ==
X-Received: by 2002:a05:6a00:22d0:b0:727:3c37:d5fb with SMTP id
 d2e1a72fcca58-7273cb92441mr1839672b3a.16.1733768752020; 
 Mon, 09 Dec 2024 10:25:52 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7fd578b457csm742249a12.27.2024.12.09.10.25.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Dec 2024 10:25:51 -0800 (PST)
Message-ID: <ea22699b-28bb-4bb0-8d5e-a0608b6e4beb@linaro.org>
Date: Mon, 9 Dec 2024 10:25:50 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] docs/devel: add b4 for patch retrieval
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-block@nongnu.org,
 philmd@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-arm@nongnu.org,
 Michael Roth <michael.roth@amd.com>, Peter Xu <peterx@redhat.com>,
 gustavo.romero@linaro.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Eric Blake <eblake@redhat.com>, Andrew Melnychenko <andrew@daynix.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Jason Wang <jasowang@redhat.com>, manos.pitsidianakis@linaro.org
References: <20241206192900.3893118-1-pierrick.bouvier@linaro.org>
 <20241206192900.3893118-4-pierrick.bouvier@linaro.org>
 <2f99cd24-768a-4e28-b5b4-d2697ca244af@redhat.com>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <2f99cd24-768a-4e28-b5b4-d2697ca244af@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 12/8/24 22:47, Thomas Huth wrote:
> On 06/12/2024 20.28, Pierrick Bouvier wrote:
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>    docs/devel/submitting-a-patch.rst | 10 ++++++++++
>>    1 file changed, 10 insertions(+)
>>
>> diff --git a/docs/devel/submitting-a-patch.rst b/docs/devel/submitting-a-patch.rst
>> index 69df7682c5e..1ef7d137320 100644
>> --- a/docs/devel/submitting-a-patch.rst
>> +++ b/docs/devel/submitting-a-patch.rst
>> @@ -433,6 +433,16 @@ For more details on how QEMU's stable process works, refer to the
>>    
>>    .. _participating_in_code_review:
>>    
>> +Retrieve an existing series
>> +---------------------------
>> +
>> +If you want to apply an existing series on top of your tree, you can simply use
>> +`b4 <https://github.com/mricon/b4>`__.
>> +
>> +::
>> +
>> +    b4 shazam $msg-id
> 
> Should we elaborate on $msg-id here? (saying that this is about patch series
> that have been sent to the mailing list and you have the retrieve the
> "Message-Id:" header from one of the patches?)
>

Ok, doing this is next version.

> Apart from that the patch looks fine to me, thanks for tackling this!
> 
>    Thomas
> 


