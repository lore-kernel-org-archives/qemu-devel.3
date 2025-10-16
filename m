Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25710CCD199
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 20:50:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9Uuk-0001VA-0C; Thu, 16 Oct 2025 16:49:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9Uuf-0001Ub-Pt
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 16:49:30 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v9Uud-00050U-Tm
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 16:49:29 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-79ef9d1805fso1185207b3a.1
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 13:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760647765; x=1761252565; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=maGa1ryzoa7fEHm5TYkqPQn2fmFfdgCSmJAGtCD2lQA=;
 b=Zc5IqJpVwfImwHgqKvnxCF7+T8OIdm0ozD2AurzZpdThgOGLnAhQvWd4Mi2VT1WcSX
 /iNxe9L8LEi5UXxO8lxzF2LVFbGP5U+F0+DglFDMNMWBc66lst4rMUnSJhZforPVDMxh
 oEaZfgPF9LGG+ygpopUAHTZOgdqvdiqJN67aZcqDAH0Wi//UNbbGAQ5LGJ304SIgS/RD
 3NwwdYKGe3NDJoBS7XsDZlt1Dmap4VTlNECGYBPrnWIgs0wUKbIva/8owSBNK3j+GMce
 KM7zvvzFVhEV9Acn+kpeNJj7pFV/h6ILQK1nhZzlTGbV9MExUnCNYfh5CI8XmyGce8L/
 w5sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760647765; x=1761252565;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=maGa1ryzoa7fEHm5TYkqPQn2fmFfdgCSmJAGtCD2lQA=;
 b=soypf89b1qX+KHtUuiZNO1qgIRS6w1oVlDPGZ6lMpiDbz2xgj+NgN+1R1FcOAZL9ni
 eg4LNXVADjxvPJqghiDUW97B2U6cEM3wcyLHfwWztSP5vUk95LzI1wASyCmA7PJBQO+3
 Wi8F3RYiVRC7wSYMudYLNFNbVuXoYCueKxOam802i9Reo/8cLnFHcxkIletb10N+gCmp
 Dg5IgdvK+AbIB8g4ptv0EDJo+ML8FaDuT57EdXGEeVZQAwhljIXiTFQtU8mMAw6R+FgM
 6XUD2CP0A4F47a146St38/hAbb1R1Ah/Y9EDDXx5L+zuLMIC17flt9J5XmKBTRYXpgEz
 n4jQ==
X-Gm-Message-State: AOJu0YzdY2HRdo9Ix55gSuEhm6NvneuYm/eDVdBCG/eixGl6ps6vVQPS
 dTsElcmYi8x7KBna7T5tM76RBXExNKVAaN8xpUS07hvXU1EHb9np2Ubi73rlyxWF8pA=
X-Gm-Gg: ASbGncuLpNbScFkvTaKC0qwHGBd5cSq81jMYvSOz/aPhPJuVFuSqbxYLadVf4BVODcL
 dd6Gw4rAR9fym1aneGnihoqfRb8bcC8UOSK8cvJjm+gp+UawXEExDqGYt79kvNV3HRSU4Lu0f1w
 RqzPsSyPTgi3aeHX+JvZ6WbfwT/6lNgp5Do7a9Bg9OjEiTHtjkf3nTtzjh+aixUVXqPoMEb5jdK
 OMmqOaSJO/lDpNDH56xqo1BYR7vmo0dnhQc66+E5m34SLedce0JgE/1tv6xW7+WJ0wX9KOud22h
 +3pejHoDu6IEqY/QtllXtfGQR7htSXiI3C7XchUGIe62Fr4f7L6PufmG0yCLYVWr34KjjNa5a5z
 OghHKdwyhVw54yReqFou7UkdD2xpMq2eUuSDs/0QqoFwYkWY6vpSLU46XWL6GMudG4EJOllpXEd
 nmYAJEko5WN20RtQ==
X-Google-Smtp-Source: AGHT+IFdO108mVSMWD4sNXmQCfGPt89+Nx5jv8A6nG61ndRp1ZA4XX0TsrF2F5Oa/e+QqhJDBpeT9w==
X-Received: by 2002:a05:6a00:3d06:b0:77d:6a00:1cd1 with SMTP id
 d2e1a72fcca58-7a220a814a5mr1664705b3a.12.1760647765583; 
 Thu, 16 Oct 2025 13:49:25 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.157.132])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7992d096740sm23414698b3a.38.2025.10.16.13.49.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 13:49:25 -0700 (PDT)
Message-ID: <5a25d13e-7b99-49c4-ace1-8d190aa2e0d4@linaro.org>
Date: Thu, 16 Oct 2025 13:49:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] gitlab: Stop cross-testing for 32-bit MIPS hosts
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, alex.bennee@linaro.org,
 Thomas Huth <thuth@redhat.com>
References: <20251015213843.14277-1-richard.henderson@linaro.org>
 <20251015213843.14277-2-richard.henderson@linaro.org>
 <aPCl9VPKPLSDmjiG@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <aPCl9VPKPLSDmjiG@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 10/16/25 00:59, Daniel P. Berrangé wrote:
> On Wed, Oct 15, 2025 at 02:38:35PM -0700, Richard Henderson wrote:
>> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>>
>> 32-bit host support is deprecated since commit 6d701c9bac1
>> ("meson: Deprecate 32-bit host support"). Next commits will
>> remove support for 32-bit MIPS hosts. Stop cross-building
>> QEMU on our CI.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> Message-ID: <20251009195210.33161-3-philmd@linaro.org>
>> ---
>>   .gitlab-ci.d/container-cross.yml |  6 ------
>>   .gitlab-ci.d/crossbuilds.yml     | 14 --------------
>>   2 files changed, 20 deletions(-)
>>
>> diff --git a/.gitlab-ci.d/container-cross.yml b/.gitlab-ci.d/container-cross.yml
>> index 8d3be53b75..0fd7341afa 100644
>> --- a/.gitlab-ci.d/container-cross.yml
>> +++ b/.gitlab-ci.d/container-cross.yml
>> @@ -52,12 +52,6 @@ mips64el-debian-cross-container:
>>     variables:
>>       NAME: debian-mips64el-cross
>>   
>> -mipsel-debian-cross-container:
>> -  extends: .container_job_template
>> -  stage: containers
>> -  variables:
>> -    NAME: debian-mipsel-cross
> 
> The input to this job is
> 
>    tests/docker/dockerfiles/debian-mipsel-cross.docker
> 
> which should thus also be deleted, along with removal
> of the line from tests/lcitool/refresh that generates
> it.

Yes.  As I mentioned in the cover, I'm leaving the docker updates from Phil's patch set to 
Alex.


r~

