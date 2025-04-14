Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07E7C369A2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 15:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4Lgz-0006MX-Vh; Mon, 14 Apr 2025 11:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4Lgs-0006MG-4u
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 11:25:42 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u4Lgq-0003gm-CA
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 11:25:41 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2279915e06eso47231465ad.1
 for <qemu-devel@nongnu.org>; Mon, 14 Apr 2025 08:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744644338; x=1745249138; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tCwH6ejLLmxo920ylREybpUVK1EaglyTjM7rhkehS34=;
 b=T9t8axxYhHVxq/TqGr7bzaeYAureyMtAdCPR/3h+ztUd+l9ZhFGDnJCpOx7eGleL2n
 yrMtsG5wwNxhhFCzdrpZOzj/Dw9Rrz+8tEYWFyf+LErEeIYwLxsingwRi6GJq5ASRgKY
 PXf//+m5jb7u5CSDavXhWE0REGtOb+oGXzfystiDZMgyzVzTiNYi0RSd2GPGo62DUZfX
 rmbkTDjW9OSCHimW6cgm20OooBN327J1aokw1epQB9kt7cQmeJy2Vd9JL01dT0LdTtmE
 PmjcMf7vHfU5pdKXKbh+Ir9U9+1BIuT1cEGXwt4aqbCanh/e4CRg0AxTd6F7ORzvT5PP
 I1Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744644338; x=1745249138;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tCwH6ejLLmxo920ylREybpUVK1EaglyTjM7rhkehS34=;
 b=iZg/pwXnb1m6fPcbWBGc5MQTb+JCJXQgs2eZ9wIcN1ybDmUmvh71eoyLmUVy8ljnrg
 LvdBr2JGhT+dmS+5vLGs2kudGDriWr2DZhWbNk9VMwREYmO3+AdlYl6mS2jZgvt8bw5l
 kvHohfsbzhTt7Bi7qum9wMO5NDkSvTL7ZtOPr4RmloaBefRELJdJ10u5RKhALLoIYaVE
 pkJ0NyPBp6UYR5Vb5/g/SKnc/vCDScYjl/jf3VJ6MoLt3/tz453SshfMMRVqfzhLBfyn
 DF5oJIcJYZk5QTs24bpsM/LXE1TLqARbCgiYRN1G/V3lhnkBSCh7BtcbYliCEclhomVS
 28ZQ==
X-Gm-Message-State: AOJu0YzIW/LcuojnarZBNqvD0YurJ9z9zatXeVOtEDD/LPE7+RC8E71y
 OhhXxWNla70bp04+D3z20vggbCdFxiq/J1qCR89qlR6HcXUfknBbMtKKp9MeLw0=
X-Gm-Gg: ASbGncu6CF3BHZj4+ZzRn1muYIr5rJcS34PeneATHUJPeGZco1PQpBJBene09gwR1mc
 J4Cgsz9IlhwP11InXjJxjbJl6yePgpXtFWNbKvX4gT4q6/66F1ZslR51YVgp/I6Ow9EQbSnNIzL
 MCu4L/3hCpDlzLrOnjHmHh5Pj87VDvgBF99JKaQhQ5iwbWSalklcziRlt8eUbM7fRkh1KkDGVz1
 js0Zj1bciW3WRVXGKDwKxJayMBwQ/p7SudVvyxPR2VyYrIphnVgyjmcwptthtQX+EO87z8LQ+ou
 dXgHMgVXN7TBm2nlYUlTEsebbYlY6xTm82JN+RlbCiLbmlEO4Enrk3GPyrBXo4I1
X-Google-Smtp-Source: AGHT+IHgUn+4P3OLo9Nge9ONVbX9kzoYhowOfENByZ6/PGKTFj+uKNEaPu7UcEGel37eEuX69vLtUQ==
X-Received: by 2002:a17:903:230b:b0:220:e1e6:4457 with SMTP id
 d9443c01a7336-22bea4bd84dmr174016705ad.26.1744644338215; 
 Mon, 14 Apr 2025 08:25:38 -0700 (PDT)
Received: from [192.168.1.87] ([38.39.164.180])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7ccb596sm99427715ad.220.2025.04.14.08.25.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Apr 2025 08:25:37 -0700 (PDT)
Message-ID: <5b54911e-6b23-4038-b124-dc9bcdaba4d1@linaro.org>
Date: Mon, 14 Apr 2025 08:25:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fix record/replay on MacOS
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Phil Dennis-Jordan <phil@philjordan.eu>
References: <20250410225550.46807-1-pierrick.bouvier@linaro.org>
 <20250414151422.GB117758@fedora>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250414151422.GB117758@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62c.google.com
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

On 4/14/25 08:14, Stefan Hajnoczi wrote:
> On Thu, Apr 10, 2025 at 03:55:48PM -0700, Pierrick Bouvier wrote:
>> Recently, it was found that rr tests fail on MacOS, with a replay_mutex_unlock()
>> assertion. This is a recent regression, related to running qemu main event loop
>> in a separate thread, like first commit explain.
>>
>> We first fix the regression, by handling the qemu replay mutex in the same way
>> we deal with BQL.
>> Then, we reenable the disabled test.
>>
>> Pierrick Bouvier (2):
>>    system/main: transfer replay mutex ownership from main thread to main
>>      loop thread
>>    tests/functional/test_aarch64_replay: reenable on macos
>>
>>   system/main.c                           | 4 ++++
>>   tests/functional/test_aarch64_replay.py | 2 --
>>   2 files changed, 4 insertions(+), 2 deletions(-)
>>
>> -- 
>> 2.39.5
>>
> 
> Thanks, applied to my staging tree:
> https://gitlab.com/stefanha/qemu/commits/staging
>

Thank you Stefan.

> Stefan


